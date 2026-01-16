#!/bin/bash

# ================= FUNÇÕES =================

active_audio() {
    echo "Ativar amplificação nativa de áudio (GNOME)"
    if command -v gsettings &>/dev/null; then
        gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
    else
        echo "gsettings não encontrado. Essa opção funciona apenas no GNOME."
    fi
}

install_audio() {
    echo "Instalar plugins, codecs, firmwares e VLC"
    sudo pacman -S --needed \
        ffmpeg \
        gstreamer \
        gst-plugins-base \
        gst-plugins-good \
        gst-plugins-bad \
        gst-plugins-ugly \
        gst-libav \
        vlc
}

install_aur_flatpak() {
    echo "Instalar AUR (yay) e Flatpak"
    sudo pacman -S --needed base-devel git flatpak

    if [ ! -d "yay" ]; then
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si
        cd ..
    else
        echo "yay já existe, pulando clone."
    fi
}

install_fonts() {
    echo "Instalar fontes essenciais"
    sudo pacman -S --needed \
        noto-fonts \
        noto-fonts-cjk \
        noto-fonts-emoji \
        ttf-jetbrains-mono-nerd
}

install_battery() {
    echo "Instalar e configurar TLP (bateria)"
    sudo pacman -S --needed tlp
    sudo systemctl enable tlp.service
    sudo systemctl start tlp.service
    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
}

install_firmware() {
    echo "Instalar e atualizar firmware"
    sudo pacman -S --needed fwupd
    sudo fwupdmgr refresh
    sudo fwupdmgr get-updates
}

install_fish() {
    echo "Instalar Fish shell"
    sudo pacman -S --needed fish
}

set_fish_default() {
    echo "Definir Fish como shell padrão"
    if ! grep -q "$(command -v fish)" /etc/shells; then
        command -v fish | sudo tee -a /etc/shells
    fi
    chsh -s "$(command -v fish)"
    echo "Fish será o shell padrão após logout/login."
}

update_system() {
    echo "Atualizando sistema"
    sudo pacman -Syu
}

# ================= MENU =================

echo "===================================================="
echo " Script de pós-instalação do Arch Linux (2026)"
echo "===================================================="
echo ""
echo "1. Atualizar sistema"
echo "2. Ativar amplificação nativa de áudio (GNOME)"
echo "3. Instalar plugins, codecs e VLC"
echo "4. Instalar AUR (yay) e Flatpak"
echo "5. Instalar fontes essenciais"
echo "6. Otimizar bateria (TLP)"
echo "7. Atualizar firmware"
echo "8. Instalar Fish shell"
echo "9. Definir Fish como shell padrão"
echo "10. Sair"
echo ""

read -p "Digite o número da opção desejada: " option

case $option in
    1) update_system ;;
    2) active_audio ;;
    3) install_audio ;;
    4) install_aur_flatpak ;;
    5) install_fonts ;;
    6) install_battery ;;
    7) install_firmware ;;
    8) install_fish ;;
    9) set_fish_default ;;
    10) exit 0 ;;
    *) echo "Opção inválida" ;;
esac
