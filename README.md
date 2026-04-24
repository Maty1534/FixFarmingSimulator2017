# FS17 WiFi Fix — OpenSSL

## Uso
1. Doble clic en **FS17_OpenSSLFix.bat**
2. Aceptar permisos de Administrador
3. Reiniciar Windows cuando lo pida
4. Listo — FS2017 funciona con WiFi permanentemente

## ¿Qué modifica?
Crea una variable de sistema en:
`HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`

| Variable | Valor |
|---|---|
| OPENSSL_ia32cap | ~0x20000000 |

## ¿Por qué funciona?
FS2017 usa OpenSSL para encriptar las conexiones del multijugador.
Al iniciar, OpenSSL detecta las capacidades del CPU e intenta usar
la instrucción RDRAND (generador de números aleatorios por hardware).
Algo en esta interacción con el driver WiFi causa un crash antes de
que el logger del juego se inicialice.

El valor `~0x20000000` desactiva el bit RDRAND en la detección de
OpenSSL, evitando completamente esa ruta de código problemática.

## Desinstalar
Doble clic en **FS17_OpenSSLFix_Remover.bat** y reiniciar Windows.
