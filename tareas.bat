@echo off
setlocal enabledelayedexpansion
:: Set encoding to ensure characters display correctly
chcp 1252 >nul
title PENCIL CLI

:: File Configuration
set "archivo=%USERPROFILE%\Documents\tasks.txt"
if not exist "%archivo%" type nul > "%archivo%"

:: Get Date
for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set "dt=%%a"
set "fecha_actual=%dt:~6,2%-%dt:~4,2%-%dt:~0,4%"

:main
cls
echo.
echo                ============================================                      
echo                                  PENCIL CLI
echo                ============================================
echo.
echo                --------------------------------------------
echo                         TASK MANAGEMENT - %fecha_actual%
echo                --------------------------------------------
echo.
echo                         1. View    Check tasks
echo                         2. Add     New task
echo                         3. Delete  Remove task
echo                         4. Exit    Close Pencil cli
echo.
echo                --------------------------------------------
echo.
set "c=0"
for /f "usebackq tokens=1,* delims=|" %%a in ("%archivo%") do (
    if "%%a"=="%fecha_actual%" (
        set /a c+=1
        echo                !c!. %%b
    )
)
if %c%==0 echo                No tasks for today.
echo.

set /p "opc=.              Choose an option (1-4): "

if "%opc%"=="1" goto ver
if "%opc%"=="2" goto agregar
if "%opc%"=="3" goto eliminar
if "%opc%"=="4" exit
goto main

:ver
cls
echo.
echo                ============================================
echo                                VIEW TASKS
echo                ============================================
echo.
set /p "fecha_tarea=                Date (DD-MM-YYYY): "
echo %fecha_tarea%| findstr /R "^[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]$" >nul
if errorlevel 1 (echo. & echo                [ERROR] Invalid format. & pause & goto main)

cls
echo.
echo                Tasks for: %fecha_tarea%
echo                --------------------------------------------
set "c=0"
for /f "usebackq tokens=1,* delims=|" %%a in ("%archivo%") do (
    if "%%a"=="%fecha_tarea%" (
        set /a c+=1
        echo                !c!. %%b
    )
)
if %c%==0 echo                No tasks found for this date.
echo.
echo                --------------------------------------------
pause
goto main

:agregar
cls
echo.
echo                ============================================
echo                                 ADD TASK
echo                ============================================
echo.
set /p "desc=                Description: "
if "%desc%"=="" goto main
echo %fecha_actual%^|%desc%>>"%archivo%"
echo.
echo                [OK] Task saved for today.
pause
goto main

:eliminar
cls
echo.
echo                ============================================
echo                                DELETE TASK
echo                ============================================
set /p "f_b=                Date (DD-MM-YYYY): "
set "c=0"
for /f "usebackq tokens=1,* delims=|" %%a in ("%archivo%") do (
    if "%%a"=="%f_b%" (
        set /a c+=1
        echo                !c!. %%b
    )
)
if %c%==0 (echo                Empty. & pause & goto main)
echo.
set /p "del_num=                Number to delete: "
set "temp_file=%temp%\t_temp.txt"
set "actual=0"
(for /f "usebackq tokens=1,* delims=|" %%a in ("%archivo%") do (
    if "%%a"=="%f_b%" (
        set /a actual+=1
        if !actual! neq %del_num% echo %%a^|%%b
    ) else ( echo %%a^|%%b )
)) > "%temp_file%"
move /y "%temp_file%" "%archivo%" >nul
echo.
echo                [OK] Task removed.
pause
goto main