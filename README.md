# 🚜 FixFarmingSimulator2017 — WiFi Startup Crash Fix (OpenSSL)

**Fix for the startup crash that occurs when only a WiFi connection is available.**  
**Solución al crash de inicio que ocurre cuando solo se dispone de conexión WiFi.**

---

## 📋 Description / Descripción

**[EN]**  
This repository provides a fix for **Farming Simulator 2017** that resolves a crash at startup when the system only has a WiFi connection available (no Ethernet/LAN). The root cause is related to how OpenSSL interacts with the CPU's RDRAND instruction in the presence of a WiFi driver. Two `.bat` scripts are included: one to apply the fix and one to completely revert all changes.

**[ES]**  
Este repositorio ofrece una solución para **Farming Simulator 2017** que resuelve un crash al iniciar el juego cuando el sistema solo dispone de conexión WiFi (sin Ethernet/LAN). La causa raíz está relacionada con cómo OpenSSL interactúa con la instrucción RDRAND del CPU en presencia de un driver WiFi. Se incluyen dos scripts `.bat`: uno para aplicar el fix y otro para revertir por completo todos los cambios.

---

## ⚙️ Uso / How to use

**[ES]**
1. Doble clic en **`FS17_OpenSSLFix.bat`**
2. Aceptar permisos de Administrador
3. Reiniciar Windows cuando lo pida
4. Listo — FS2017 funciona con WiFi permanentemente

**[EN]**
1. Double-click **`FS17_OpenSSLFix.bat`**
2. Accept the Administrator permission prompt
3. Restart Windows when asked
4. Done — FS2017 will work on WiFi permanently

---

## 🔧 ¿Qué modifica? / What does it modify?

**[ES]**  
Crea una variable de entorno de sistema en:  
**[EN]**  
Creates a system environment variable at:

`HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`

| Variable | Value / Valor |
|---|---|
| `OPENSSL_ia32cap` | `~0x20000000` |

---

## 🧠 ¿Por qué funciona? / Why does it work?

**[ES]**  
FS2017 usa OpenSSL para encriptar las conexiones del multijugador. Al iniciar, OpenSSL detecta las capacidades del CPU e intenta usar la instrucción **RDRAND** (generador de números aleatorios por hardware). Algo en esta interacción con el driver WiFi causa un crash antes de que el logger del juego se inicialice.

El valor `~0x20000000` desactiva el bit RDRAND en la detección de OpenSSL, evitando completamente esa ruta de código problemática.

**[EN]**  
FS2017 uses OpenSSL to encrypt multiplayer connections. On startup, OpenSSL detects the CPU capabilities and attempts to use the **RDRAND** instruction (hardware random number generator). Something in this interaction with the WiFi driver causes a crash before the game's logger even initializes.

The value `~0x20000000` disables the RDRAND bit in OpenSSL's CPU detection, completely bypassing that problematic code path.

---

## 📁 Files / Archivos

| File | Description / Descripción |
|------|---------------------------|
| `FS17_OpenSSLFix.bat` | Applies the fix / Aplica el fix |
| `FS17_OpenSSLFix_Remover.bat` | Reverts all changes / Revierte todos los cambios |

---

## ✅ Requirements / Requisitos

- Windows 7 / 8 / 10 / 11
- Farming Simulator 2017 (any version / cualquier versión)
- Administrator privileges / Privilegios de administrador

---

## 🗑️ Desinstalar / Uninstall

**[ES]** Doble clic en **`FS17_OpenSSLFix_Remover.bat`** y reiniciar Windows.  
**[EN]** Double-click **`FS17_OpenSSLFix_Remover.bat`** and restart Windows.

---

## ⚠️ Disclaimer / Aviso

**[EN]**  
This fix only adds a system environment variable. All changes can be fully reverted using `FS17_OpenSSLFix_Remover.bat`. Use at your own risk.

**[ES]**  
Este fix solo agrega una variable de entorno del sistema. Todos los cambios pueden revertirse por completo usando `FS17_OpenSSLFix_Remover.bat`. Usalo bajo tu propia responsabilidad.

---

## 📄 License / Licencia

This project is licensed under the [MIT License](LICENSE).  
Este proyecto está bajo la [Licencia MIT](LICENSE).
