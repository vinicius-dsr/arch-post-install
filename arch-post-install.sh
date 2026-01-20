#!/bin/bash

# ================= FUNÇÕES =================

edit_pacman(){
    echo "Editar arquivo de configuração pacman"
    sudo mv /etc/pacman.conf /etc/pacman.conf.bak
    sudo cp pacman.conf /etc/
}

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
        vlc \
        vlc-plugins-all
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

install_intel() {
    echo "Instalar drivers Intel"
    sudo pacman -S --needed vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader mesa
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

install_ohmyposh(){
    echo "Instalar oh-my-posh"
    yay -S oh-my-posh
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
echo "1. Editar arquivo de configuração pacman"
echo "2. Atualizar sistema"
echo "3. Ativar amplificação nativa de áudio (GNOME)"
echo "4. Instalar plugins, codecs e VLC"
echo "5. Instalar drivers Intel"
echo "6. Instalar AUR (yay) e Flatpak"
echo "7. Instalar fontes essenciais"
echo "8. Otimizar bateria (TLP)"
echo "9. Atualizar firmware"
echo "10. Instalar Fish shell"
echo "11. Definir Fish como shell padrão"
echo "12. Instalar oh-my-posh"
echo "13. Sair"
echo ""

read -p "Digite o número da opção desejada: " option

case $option in
    1) edit_pacman ;;
    2) update_system ;;
    3) active_audio ;;
    4) install_audio ;;
    5) install_intel ;;
    6) install_aur_flatpak ;;
    7) install_fonts ;;
    8) install_battery ;;
    9) install_firmware ;;
    10) install_fish ;;
    11) set_fish_default ;;
    12) install_ohmyposh ;;
    13) exit 0 ;;
    *) echo "Opção inválida" ;;
esac
