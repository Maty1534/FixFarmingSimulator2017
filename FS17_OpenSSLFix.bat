@echo off
:: ============================================================
::  FS17_OpenSSLFix.bat
::  Farming Simulator 2017 - Fix definitivo de crash con WiFi
::
::  QUÉ HACE:
::    Crea la variable de sistema OPENSSL_ia32cap con el valor
::    ~0x20000000, que le indica a OpenSSL que no use la
::    instrucción RDRAND del CPU. Esto evita el crash que ocurre
::    cuando el juego inicializa la red con WiFi activo.
::
::    Es una modificación permanente y segura. Solo necesitás
::    ejecutar este archivo UNA SOLA VEZ y reiniciar Windows.
:: ============================================================
title FS17 - Fix de WiFi (OpenSSL)

:: ── Verificar permisos de Administrador ──────────────────────
:: Las variables de sistema (no de usuario) requieren admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo  Este archivo necesita permisos de Administrador.
    echo  Se va a reiniciar automaticamente con permisos elevados...
    echo.
    pause
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ── Mostrar información al usuario ───────────────────────────
cls
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║     Farming Simulator 2017 - WiFi Fix (OpenSSL)     ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Este fix va a crear la siguiente variable de sistema:
echo.
echo    Nombre : OPENSSL_ia32cap
echo    Valor  : ~0x20000000
echo.
echo  Esto le indica a OpenSSL que no use la instruccion RDRAND
echo  del CPU, evitando el crash al iniciar con WiFi activo.
echo.
echo  Es permanente: solo necesitas ejecutarlo UNA vez.
echo  Para desinstalarlo, ejecuta FS17_OpenSSLFix_Remover.bat
echo.
echo ──────────────────────────────────────────────────────────
echo.

:: ── Verificar si la variable ya existe ───────────────────────
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v OPENSSL_ia32cap >nul 2>&1
if %errorLevel% == 0 (
    echo  [!] La variable OPENSSL_ia32cap ya existe en tu sistema.
    echo.
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v OPENSSL_ia32cap
    echo.
    echo  ^¿Querés sobreescribirla con el valor correcto?
    echo.
    choice /C SN /M "  S = Si, sobreescribir    N = No, cancelar"
    if errorlevel 2 goto :cancelado
    echo.
)

:: ── Aplicar la variable de sistema ───────────────────────────
echo  Aplicando fix...
echo.

:: Escribimos en HKLM (variables de sistema, para todos los usuarios)
:: REG_SZ = tipo String, que es lo que OpenSSL espera leer
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" ^
    /v OPENSSL_ia32cap ^
    /t REG_SZ ^
    /d "~0x20000000" ^
    /f >nul 2>&1

if %errorLevel% == 0 (
    echo  [OK] Variable creada correctamente.
    echo.
    echo  ╔══════════════════════════════════════════════════════╗
    echo  ║                   FIX APLICADO                      ║
    echo  ║                                                      ║
    echo  ║  Necesitas REINICIAR Windows para que tenga efecto.  ║
    echo  ║  Despues del reinicio, FS2017 funcionara con WiFi.   ║
    echo  ╚══════════════════════════════════════════════════════╝
    echo.

    :: Ofrecer reinicio inmediato
    choice /C SN /M "  ^¿Querés reiniciar Windows ahora?"
    if errorlevel 2 goto :sin_reinicio
    
    echo.
    echo  Reiniciando en 5 segundos...
    shutdown /r /t 5 /c "Aplicando FS17 WiFi Fix - Reinicio necesario"
    goto :fin

    :sin_reinicio
    echo.
    echo  Acordate de reiniciar Windows antes de abrir el juego.
) else (
    echo  [ERROR] No se pudo crear la variable.
    echo.
    echo  Intentalo manualmente:
    echo    1. Win+R → SystemPropertiesAdvanced → Enter
    echo    2. Click en "Variables de entorno"
    echo    3. En "Variables del sistema" → Nueva
    echo    4. Nombre: OPENSSL_ia32cap
    echo    5. Valor:  ~0x20000000
    echo    6. Aceptar y reiniciar
)
goto :fin

:cancelado
echo.
echo  Operacion cancelada. No se modifico ningun archivo.

:fin
echo.
pause
