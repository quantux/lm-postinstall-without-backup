#!/bin/bash

# LightColor='\033[1;32m'
# printf "I oaksofaoskfoasf${LightColor}love${NC} Stack Overflow\n"

# Get current regular user (not sudo user)
RUID=$(who | awk 'FNR == 1 {print $1}')
RUSER_UID=$(id -u ${RUID})

# Update + Upgrade
# apt update && apt upgrade -y

# # 32bits packages
# dpkg --add-architecture i386

# # Install apt packages
# apt install -y build-essential zsh tmux git curl wget gpg apt-transport-https preload blender vim gedit gimp flameshot fonts-firacode blender cheese sublime-text screenfetch python2 python3 python3-gpg python3-pip inkscape virtualbox virtualbox-qt virtualbox-guest-x11 vlc filezilla steam gparted pinta nmap traceroute vlc ttf-mscorefonts-installer p7zip-full okular unrar rar bleachbit ubuntu-restricted-extras libdvd-pkg tlp tp-smapi-dkms acpi-call-dkms gimp-help-pt fonts-powerline calibre gnome-boxes audacity kazam htop neofetch openshot-qt python3-setuptools scrcpy whois gnupg2 software-properties-common libncurses5-dev libgmp-dev libmysqlclient-dev remmina tree obs-studio pavucontrol gir1.2-gmenu-3.0 jstest-gtk speedtest-cli pv neovim wireshark clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev xclip

# # Reconfigure libdvd-pkg
# dpkg-reconfigure libdvd-pkg

# # Install pylint
# pip3 install pylint

# # Install flatpak packages
# flatpak install -y --noninteractive flathub com.github.calo001.fondo
# flatpak install -y --noninteractive com.github.donadigo.appeditor

# # Install Chrome
# wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O google-chrome.deb
# dpkg -i google-chrome.deb
# apt install -fy

# # Install - Adapta Nokto Fonts
# wget "https://fonts.google.com/download?family=Roboto" -O roboto.zip
# wget "https://fonts.google.com/download?family=Noto Sans" -O noto_sans.zip
# unzip roboto.zip -d Roboto
# unzip noto_sans.zip -d Noto_Sans
# mv Roboto Noto_Sans /usr/share/fonts/

# # Install - Adapta Nokto theme
# wget "https://launchpadlibrarian.net/391325176/adapta-gtk-theme_3.95.0.11-0ubuntu1~bionic1_all.deb" -O adapta-nokto-gtk-theme.deb
# dpkg -i adapta-nokto-gtk-theme.deb
# apt install -fy
# mv -f cinnamon.css /usr/share/themes/Adapta-Nokto/cinnamon/cinnamon.css # Set Adapta Nokto panel color to black

# # Set virtualbox to use dark theme
# mv -f virtualbox.desktop /usr/share/applications/virtualbox.desktop

# # Install Sweet Theme
# tar -xf Sweet-mars-v40.tar.xz
# mv Sweet-mars-v40 /usr/share/themes/

# # La Capitaine icons
# git clone https://github.com/keeferrourke/la-capitaine-icon-theme /usr/share/icons/la-capitaine

# # ZSH and Oh-my-zsh
# sudo -u ${RUID} /bin/bash -c 'curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh'

# # Oh-my-posh and oh-my-posh themes
# wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
# chmod +x /usr/local/bin/oh-my-posh
# mkdir ~/.poshthemes
# sudo -u ${RUID} /bin/bash -c 'wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip'
# sudo -u ${RUID} /bin/bash -c 'unzip ~/.poshthemes/themes.zip -d ~/.poshthemes'
# chmod u+rw ~/.poshthemes/*.omp.*
# rm ~/.poshthemes/themes.zip

# # Disable; Recent 
# rm ~/.local/share/recently-used.xbel
# touch ~/.local/share/recently-used.xbel
# chattr +i ~/.local/share/recently-used.xbel

# # WPS Office Fonts
# git clone https://github.com/udoyen/wps-fonts.git /tmp/wps-fonts
# mv /tmp/wps-fonts/wps /usr/share/fonts/

# # Install ASDF
# sudo -u ${RUID} /bin/bash -c 'git clone https://github.com/asdf-vm/asdf.git ~/.asdf'

# # Install Teamviewer
# wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" -O teamviewer.deb
# dpkg -i teamviewer.deb
# apt install -fy

# # Install Dropbox
# wget "https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb" -O dropbox.deb
# dpkg -i dropbox.deb
# apt install -fy

# # Install VSCode
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# apt update
# rm -f packages.microsoft.gpg
# apt install code -y

# Install VSCode extensions
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

# Copy VSCode settings (theme, font)
mkdir -p /home/${RUID}/.config/Code/User/
mv -f vscode-settings.json /home/${RUID}/.config/Code/User/settings.json 

# Set themes and wallpaper
sudo -u ${RUID} /bin/bash -c 'DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.cinnamon.desktop.background picture-uri "file:///$PWD/wallpaper.jpg"'

# Home folder - config files
git clone https://github.com/quantux/home /tmp/home
rsync -av /tmp/home/ /home/${RUID}/

# Install vim-plug
sudo -u ${RUID} /bin/bash -c 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo -u ${RUID} /bin/bash -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo -u ${RUID} /bin/bash -c 'vim -c :PlugInstall -c :q -c :q'

# Load dconf file
sudo -u ${RUID} /bin/bash -c 'dconf load / < dconf_cinnamon_settings'

# Cinnamon menu
mv cinnamon-menu.json /home/${RUID}/.cinnamon/configs/menu@cinnamon.org/0.json

# Cinnamon panel launcher
mv panel-launcher-cinnamon.json /home/${RUID}/.cinnamon/configs/panel-launchers@cinnamon.org/15.json

