#!/bin/bash

LightColor='\033[1;32m'
NC='\033[0m'

show_message() {
    clear
    printf "${LightColor}$1${NC}\n\n"
}

# Get current regular user (not sudo user)
RUID=$(who | awk 'FNR == 1 {print $1}')
RUSER_UID=$(id -u ${RUID})

# Update + Upgrade
show_message "Atualizando repositórios"
apt update

show_message "Atualizando pacotes"
apt upgrade -y

# 32bits packages
show_message "Habilitando pacotes de 32 bits"
dpkg --add-architecture i386

# Install apt packages
show_message "Instalando pacotes"
apt install -y build-essential zsh tmux git curl wget gpg apt-transport-https preload blender vim gedit gimp flameshot fonts-firacode blender cheese sublime-text screenfetch python2 python3 python3-gpg python3-pip inkscape virtualbox virtualbox-qt virtualbox-guest-x11 vlc filezilla steam gparted pinta nmap traceroute vlc ttf-mscorefonts-installer p7zip-full okular unrar rar bleachbit ubuntu-restricted-extras libdvd-pkg tlp tp-smapi-dkms acpi-call-dkms gimp-help-pt fonts-powerline calibre gnome-boxes audacity kazam htop neofetch openshot-qt python3-setuptools scrcpy whois gnupg2 software-properties-common libncurses5-dev libgmp-dev libmysqlclient-dev remmina tree obs-studio pavucontrol gir1.2-gmenu-3.0 jstest-gtk speedtest-cli pv neovim wireshark clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev xclip

# Reconfigure libdvd-pkg
show_message "Reconfigurando libdvd-pkg"
dpkg-reconfigure libdvd-pkg

# Install pylint
show_message "Instalando pylint"
pip3 install pylint

# Install flatpak packages
show_message "Instalando pacotes flatpak"
flatpak install -y --noninteractive flathub com.github.calo001.fondo
flatpak install -y --noninteractive com.github.donadigo.appeditor

# Install Chrome
show_message "Instalando Google Chrome"
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O google-chrome.deb
dpkg -i google-chrome.deb
apt install -fy

# Install - Adapta Nokto Fonts
show_message "Instalando fontes Roboto e Noto Sans"
wget "https://fonts.google.com/download?family=Roboto" -O roboto.zip
wget "https://fonts.google.com/download?family=Noto Sans" -O noto_sans.zip
unzip roboto.zip -d Roboto
unzip noto_sans.zip -d Noto_Sans
mv Roboto Noto_Sans /usr/share/fonts/

# Install - Adapta Nokto theme
show_message "Instalando tema Adapta Nokto"
wget "https://launchpadlibrarian.net/391325176/adapta-gtk-theme_3.95.0.11-0ubuntu1~bionic1_all.deb" -O adapta-nokto-gtk-theme.deb
dpkg -i adapta-nokto-gtk-theme.deb
apt install -fy

show_message "Copiando arquivo de tema para o painel"
mv -f cinnamon.css /usr/share/themes/Adapta-Nokto/cinnamon/cinnamon.css # Set Adapta Nokto panel color to black

# Set virtualbox to use dark theme
show_message "Copiando arquivo de tema para o Virtualbox"
mv -f virtualbox.desktop /usr/share/applications/virtualbox.desktop

# Install Sweet Theme
show_message "Instalando Sweet Theme"
tar -xf Sweet-mars-v40.tar.xz
mv Sweet-mars-v40 /usr/share/themes/

# La Capitaine icons
show_message "Instalando ícones La-Capitaine"
git clone https://github.com/keeferrourke/la-capitaine-icon-theme /usr/share/icons/la-capitaine

# Oh-my-zsh
show_message "Instalando oh-my-zsh"
sudo -u ${RUID} /bin/bash -c 'curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh'

# oh-my-posh
show_message "Instalando oh-my-posh"
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
sudo -u ${RUID} /bin/bash -c 'wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip'
sudo -u ${RUID} /bin/bash -c 'unzip ~/.poshthemes/themes.zip -d ~/.poshthemes'
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

# Disable; Recent 
show_message "Desabilitando arquivos recentes (recent files)"
rm ~/.local/share/recently-used.xbel
touch ~/.local/share/recently-used.xbel
chattr +i ~/.local/share/recently-used.xbel

# WPS Office Fonts
show_message "Instalando fontes para o WPS Office"
git clone https://github.com/udoyen/wps-fonts.git /tmp/wps-fonts
mv /tmp/wps-fonts/wps /usr/share/fonts/

# Install Teamviewer
show_message "Instalando TeamViewer"
wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" -O teamviewer.deb
dpkg -i teamviewer.deb
apt install -fy

# Install Dropbox
show_message "Instalando Dropbox"
wget "https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb" -O dropbox.deb
dpkg -i dropbox.deb
apt install -fy

# Install VSCode
show_message "Instalando VSCode"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
rm -f packages.microsoft.gpg
apt install code -y

# Install VSCode extensions
show_message "Instalando extensões do VSCode"
sudo -u ${RUID} /bin/bash -c code --install-extension bceskavich.theme-dracula-at-night
sudo -u ${RUID} /bin/bash -c code --install-extension dbaeumer.vscode-eslint
sudo -u ${RUID} /bin/bash -c code --install-extension dracula-theme.theme-dracula
sudo -u ${RUID} /bin/bash -c code --install-extension ecmel.vscode-html-css
sudo -u ${RUID} /bin/bash -c code --install-extension emmanuelbeziat.vscode-great-icons
sudo -u ${RUID} /bin/bash -c code --install-extension esbenp.prettier-vscode
sudo -u ${RUID} /bin/bash -c code --install-extension formulahendry.code-runner
sudo -u ${RUID} /bin/bash -c code --install-extension MS-CEINTL.vscode-language-pack-pt-BR
sudo -u ${RUID} /bin/bash -c code --install-extension ms-dotnettools.csharp
sudo -u ${RUID} /bin/bash -c code --install-extension ms-python.isort
sudo -u ${RUID} /bin/bash -c code --install-extension ms-python.python
sudo -u ${RUID} /bin/bash -c code --install-extension ms-python.vscode-pylance
sudo -u ${RUID} /bin/bash -c code --install-extension ms-toolsai.jupyter
sudo -u ${RUID} /bin/bash -c code --install-extension ms-toolsai.jupyter-keymap
sudo -u ${RUID} /bin/bash -c code --install-extension ms-toolsai.jupyter-renderers
sudo -u ${RUID} /bin/bash -c code --install-extension ms-toolsai.vscode-jupyter-cell-tags
sudo -u ${RUID} /bin/bash -c code --install-extension ms-toolsai.vscode-jupyter-slideshow
sudo -u ${RUID} /bin/bash -c code --install-extension PROxZIMA.sweetdracula
sudo -u ${RUID} /bin/bash -c code --install-extension softwaredotcom.swdc-vscode
sudo -u ${RUID} /bin/bash -c code --install-extension xabikos.JavaScriptSnippets

# Install ASDF
show_message "Instalando ASDF"
sudo -u ${RUID} /bin/bash -c 'git clone https://github.com/asdf-vm/asdf.git ~/.asdf'

# Copy VSCode settings (theme, font)
show_message "Copiando configurações do VSCode"
mkdir -p /home/${RUID}/.config/Code/User/
mv -f vscode-settings.json /home/${RUID}/.config/Code/User/settings.json 

# Set themes and wallpaper
show_message "Aplicando Wallpaper"
sudo -u ${RUID} /bin/bash -c 'DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.cinnamon.desktop.background picture-uri "file:///$PWD/wallpaper.jpg"'

# Home folder - config files
show_message "Copiando arquivos de configuração para a pasta home"
git clone https://github.com/quantux/home /tmp/home
mv -f /tmp/home/.* /home/${RUID}/

# Install vim-plug
show_message "Instalando Vim-Plug"
sudo -u ${RUID} /bin/bash -c 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo -u ${RUID} /bin/bash -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo -u ${RUID} /bin/bash -c 'vim -c :PlugInstall -c :q -c :q'

# Cinnamon menu
show_message "Copiando arquivos tema do cinnamon-menu"
mv cinnamon-menu.json /home/${RUID}/.cinnamon/configs/menu@cinnamon.org/0.json

# Cinnamon panel launcher
show_message "Copiando arquivos tema do panel-launcher-cinnamon"
mv panel-launcher-cinnamon.json /home/${RUID}/.cinnamon/configs/panel-launchers@cinnamon.org/15.json

# Load dconf file
show_message "Carregando configurações do dconf"
sudo -u ${RUID} /bin/bash -c 'dconf load / < dconf_cinnamon_settings'