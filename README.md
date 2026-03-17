# Gestor de Tareas Diarias

Script batch para Windows que muestra tus tareas diarias al iniciar el sistema.

## Instalacion

1. Copia el archivo `tareas.bat` a la carpeta de inicio de Windows:
   ```
   %appdata%\Microsoft\Windows\Start Menu\Programs\Startup\
   ```

   O alternatively, press `Win + R`, type `shell:startup`, and press Enter.

2. Listo! El script se ejecutara automaticamente cada vez que inicies Windows.

## Uso

Al abrirse el programa veras un menu con estas opciones:

- **1. Ver tareas del dia** - Muestra las tareas de la fecha seleccionada
- **2. Agregar tarea** - Añade una nueva tarea (pide fecha y descripcion)
- **3. Eliminar tarea** - Elimina una tarea por su numero
- **4. Salir** - Cierra el programa

## Archivo de datos

Las tareas se guardan automaticamente en:
```
%userprofile%\Documents\tareas.txt
```

Formato: `DD-MM-AAAA|Descripcion de la tarea`

## Requisitos

- Windows 7/8/10/11
- No requiere permisos de administrador
