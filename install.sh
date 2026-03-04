#!/bin/bash

echo "[*] Iniciando la instalación de tu entorno Red Team..."

# 1. Menú interactivo para elegir la distribución
echo "[*] ¿En qué familia de Linux estás instalando el entorno?"
echo "  1) Arch Linux / Manjaro (pacman)"
echo "  2) Debian / Ubuntu / Kali Linux (apt)"
echo "  3) Fedora (dnf)"
echo ""
read -p "[?] Ingresa el número de tu opción (1, 2 o 3): " distro

case $distro in
    1)
        echo "[+] Arch Linux seleccionado. Descargando paquetes..."
        sudo pacman -Syu --needed bspwm sxhkd polybar rofi kitty picom zsh zsh-theme-powerlevel10k obsidian ttf-hack-nerd feh
        ;;
    2)
        echo "[+] Debian/Ubuntu/Kali seleccionado. Descargando paquetes..."
        sudo apt update
        # Agregamos wget, unzip y feh directamente aquí
        sudo apt install -y bspwm sxhkd polybar rofi kitty picom zsh fonts-hack-ttf feh wget unzip
        
        echo "[*] Descargando Hack Nerd Font para los íconos..."
        mkdir -p ~/.local/share/fonts
        # Usamos --show-progress para que el alumno vea cuánto falta
        wget --show-progress -q -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
        echo "[*] Descomprimiendo e instalando fuentes..."
        unzip -q -o /tmp/Hack.zip -d ~/.local/share/fonts/
        rm /tmp/Hack.zip
        fc-cache -fv
        ;;
    3)
        echo "[+] Fedora seleccionado. Descargando paquetes..."
        # Agregamos wget, unzip y feh directamente aquí
        sudo dnf install -y bspwm sxhkd polybar rofi kitty picom zsh feh wget unzip
        
        echo "[*] Descargando Hack Nerd Font para los íconos..."
        mkdir -p ~/.local/share/fonts
        wget --show-progress -q -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
        echo "[*] Descomprimiendo e instalando fuentes..."
        unzip -q -o /tmp/Hack.zip -d ~/.local/share/fonts/
        rm /tmp/Hack.zip
        fc-cache -fv
        ;;
    *)
        echo "[!] Opción no válida. Por favor, ejecuta el script de nuevo e ingresa 1, 2 o 3."
        exit 1
        ;;
esac

# 2. Crear el directorio principal de configuraciones si no existe
echo "[*] Preparando directorios..."
mkdir -p ~/.config
mkdir -p ~/Pictures/Fonds

# 3. Copiar todas las configuraciones al sistema
echo "[*] Copiando tus dotfiles..."
# Copia todo lo que está dentro de tu carpeta config/ hacia ~/.config/
cp -r config/* ~/.config/

# Copia los archivos ocultos de tu terminal a la raíz de tu usuario
cp .zshrc ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh
cp wallpaper/night.png ~/Pictures/Fonds/

# 4. Asignar permisos de ejecución a los scripts
echo "[*] Dando permisos de ejecución a los scripts clave..."
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/*.sh

echo "[*] ¡Entorno instalado con éxito!"
echo "[*] IMPORTANTE: Escribe 'zsh' en tu terminal para aplicar el nuevo shell."
echo "[*] Presiona Super + Alt + R para recargar bspwm."
