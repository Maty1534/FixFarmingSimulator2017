@echo off
:: ============================================================
::  FS17_OpenSSLFix_Remover.bat
::  Elimina la variable OPENSSL_ia32cap del sistema
::  Usalo si ya no necesitas el fix o querés revertir los cambios
:: ============================================================
title FS17 - Remover Fix de WiFi

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls
echo.
echo  ╔══════════════════════════════════════════════════════╗
echo  ║          FS17 WiFi Fix - DESINSTALADOR              ║
echo  ╚══════════════════════════════════════════════════════╝
echo.
echo  Esto va a eliminar la variable de sistema OPENSSL_ia32cap.
echo.

:: Verificar si existe
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v OPENSSL_ia32cap >nul 2>&1
if %errorLevel% neq 0 (
    echo  [!] La variable OPENSSL_ia32cap no existe en este sistema.
    echo      No hay nada que desinstalar.
    echo.
    pause
    exit /b
)

choice /C SN /M "  ^¿Confirmas que querés eliminar la variable?"
if errorlevel 2 (
    echo  Cancelado.
    pause
    exit /b
)

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v OPENSSL_ia32cap /f >nul 2>&1

if %errorLevel% == 0 (
    echo.
    echo  [OK] Variable eliminada. Reinicia Windows para completar.
) else (
    echo.
    echo  [ERROR] No se pudo eliminar la variable.
)

echo.
pause
