@echo off
setlocal enabledelayedexpansion

 

:: Lista de usuarios cuyas claves del Registro se eliminarán
set "usuarios=P9AC00037 accedo a sccedotechnologuies Accedo Accedotech Accedotechnologuies Accedotechnologies Accedo TYechnologies AccedoTechnology accedotechnologuies Accedotechnology lenovo_tmp_htnqUCIS aaa Accedo Technologies"

 

:: Ruta del Registro de perfiles
set "perfilRegKey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

 

:: Iterar a través de la lista de usuarios
for %%u in (%usuarios%) do (
    set "usuario=%%u"
    set "claveRegistro="

 

    :: Buscar la clave del Registro que contiene el valor ProfileImagePath
    for /f "tokens=*" %%a in ('reg query "%perfilRegKey%" /f "%%u" /s 2^>nul') do (
        set "claveRegistro=%%a"
        :: Verificar si la clave del Registro contiene el valor ProfileImagePath
        for /f "tokens=2,*" %%i in ('reg query "!claveRegistro!" /v "ProfileImagePath" 2^>nul ^| find /i "ProfileImagePath"') do (
            set "userPath=%%j"
            if "!userPath!"=="C:\Users\%%~u" (
                echo Eliminando clave del Registro para !usuario!
                reg delete "!claveRegistro!" /f >nul 2>&1
            )
        )
    )

 

    :: Verificar si se encontró la clave del Registro
    if not defined claveRegistro (
        echo Clave del Registro no encontrada para !usuario!
    )
)

 

endlocal
pause