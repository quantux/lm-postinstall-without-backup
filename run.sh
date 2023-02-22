#!/bin/bash

# Checks for root privileges
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

# Terminal colors
LightColor='\033[1;32m'
NC='\033[0m'

# Get current regular user (not sudo user)
RUID=$(who | awk 'FNR == 1 {print $1}')
RUSER_UID=$(id -u ${RUID})

# Distro codenames
LINUXMINT_CODENAME=$(lsb_release -cs)
UBUNTU_CODENAME=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_CODENAME= | cut -f2 -d "=")

show_message() {
    clear
    printf "${LightColor}$1${NC}\n\n"
}

user_do() {
    sudo -u ${RUID} /bin/bash -c "$1"
}

user_zsh_do() {
    sudo -u ${RUID} /bin/zsh -c "source ~/.zshrc; $1"
}

# Fix clock time for windows dualboot
timedatectl set-local-rtc 1

# Set mirrors
show_message "Atualizando mirrors"
rm /etc/apt/sources.list.d/official-package-repositories.list
mirrors="deb https://mint.itsbrasil.net/packages $LINUXMINT_CODENAME main upstream import backport \n\n\
deb http://ubuntu-archive.locaweb.com.br/ubuntu $UBUNTU_CODENAME main restricted universe multiverse\n\
deb http://ubuntu-archive.locaweb.com.br/ubuntu $UBUNTU_CODENAME-updates main restricted universe multiverse\n\
deb http://ubuntu-archive.locaweb.com.br/ubuntu $UBUNTU_CODENAME-backports main restricted universe multiverse\n\n\
deb http://security.ubuntu.com/ubuntu/ $UBUNTU_CODENAME-security main restricted universe multiverse"
echo -e $mirrors > /etc/apt/sources.list.d/official-package-repositories.list

# Update
show_message "Atualizando repositórios"
apt update

# Update tldr
user_do "tldr --update"

# Instalando libdvd-pkg (único que pede confirmação)
show_message "Instalando libdvd-pkg"
apt -y install libdvd-pkg
dpkg-reconfigure libdvd-pkg

# Install ttf-mscorefonts-installer
show_message "Instalando ttf-mscorefonts-installer"
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula	boolean	true" | debconf-set-selections
echo "ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note" | debconf-set-selections
apt install -y ttf-mscorefonts-installer

# Upgrade
show_message "Atualizando pacotes"
apt upgrade -y

# 32bits packages
show_message "Habilitando pacotes de 32 bits"
dpkg --add-architecture i386

# Install apt packages
show_message "Instalando pacotes"
apt install -y build-essential zsh tmux git curl wget gpg ca-certificates gnupg lsb-release debconf-utils apt-transport-https preload blender firefox-locale-pt thunderbird-locale-pt vim gedit gimp flameshot fonts-firacode blender cheese sublime-text screenfetch python2 python3 python3-gpg python3-pip python-setuptools inkscape virtualbox virtualbox-qt vlc filezilla steam gparted pinta nmap traceroute vlc p7zip-full okular unrar rar bleachbit ubuntu-restricted-extras tlp tp-smapi-dkms acpi-call-dkms gimp-help-pt fonts-powerline calibre gnome-boxes audacity kazam htop neofetch openshot-qt python3-setuptools scrcpy whois gnupg2 software-properties-common libncurses5-dev libgmp-dev libmysqlclient-dev remmina tree obs-studio pavucontrol gir1.2-gmenu-3.0 jstest-gtk speedtest-cli pv neovim dropbox clang cmake ninja-build pkg-config libyaml-dev libgtk-3-dev liblzma-dev ffmpeg xclip tldr plymouth wine

# Instalando virtualbox-guest-x11
show_message "Instalando virtualbox-guest-x11"
yes Y | apt install -y virtualbox-guest-x11

# Instalando wireshark
show_message "Instalando wireshark"
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt install -y wireshark

# Install pylint
show_message "Instalando pylint"
pip3 install pylint

# Install flatpak packages
show_message "Instalando pacotes flatpak"
flatpak install -y --noninteractive flathub com.github.calo001.fondo
flatpak install -y --noninteractive flathub com.github.tchx84.Flatseal

# Update flatpak
show_message "Atualizando pacotes flatpak"
flatpak update -y

# Install Chrome
show_message "Instalando Google Chrome"
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O /tmp/google-chrome.deb
dpkg -i /tmp/google-chrome.deb
apt install -fy

# Install Microsoft Edge
show_message "Instalando Microsoft Edge"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
apt update
apt install -y microsoft-edge-stable

# Remove dev apt list
rm /etc/apt/sources.list.d/microsoft-edge-dev.list

# Install - Adapta Nokto Fonts
show_message "Instalando fontes Roboto e Noto Sans"
wget "https://fonts.google.com/download?family=Roboto" -O /tmp/roboto.zip
wget "https://fonts.google.com/download?family=Noto Sans" -O /tmp/noto_sans.zip
unzip /tmp/roboto.zip -d /usr/share/fonts/
unzip /tmp/noto_sans.zip -d /usr/share/fonts/

# Install - Adapta Nokto theme
show_message "Instalando tema Adapta Nokto"
dpkg -i ./assets/themes/adapta-nokto-gtk-theme.deb
apt install -fy

show_message "Copiando arquivo de tema para o painel"
cp ./assets/themes/adapta-nokto-black-panel.css /usr/share/themes/Adapta-Nokto/cinnamon/cinnamon.css # Set Adapta Nokto panel color to black

# Set virtualbox to use dark theme
show_message "Copiando arquivo de tema para o Virtualbox"
cp ./assets/programs-settings/virtualbox.desktop /usr/share/applications/virtualbox.desktop

# Install Sweet Theme
show_message "Instalando Sweet Theme"
tar -xf ./assets/themes/Sweet-mars-v40.tar.xz -C /usr/share/themes

# Install Sweet Theme
show_message "Instalando Flat Remix theme"
tar -xf ./assets/themes/Flat-Remix-GTK-Blue-Darkest-Solid-NoBorder.tar.xz -C /usr/share/themes

# La-Capitaine Icons
show_message "Instalando ícones La-Capitaine"
tar -zxvf ./assets/icons/la-capitaine.tar.gz -C /usr/share/icons/

# WPS Office Fonts
show_message "Instalando fontes para o WPS Office"
git clone https://github.com/udoyen/wps-fonts.git /tmp/wps-fonts
mv /tmp/wps-fonts/wps /usr/share/fonts/

# Install Teamviewer
show_message "Instalando TeamViewer"
wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" -O /tmp/teamviewer.deb
dpkg -i /tmp/teamviewer.deb
apt install -fy

# Install VSCode
show_message "Instalando VSCode"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install code -y

# Disable; Recent 
show_message "Desabilitando arquivos recentes (recent files)"
user_do "rm ~/.local/share/recently-used.xbel"
user_do "touch ~/.local/share/recently-used.xbel"
chattr +i /home/$RUID/.local/share/recently-used.xbel

# Install oh-my-zsh
show_message "Instalando oh-my-zsh"
user_do "sh ./assets/oh-my-zsh/oh-my-zsh-install.sh --unattended"
chsh -s $(which zsh) $(whoami)

# Install oh-my-posh
show_message "Instalando oh-my-posh"
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
chmod +x /usr/local/bin/oh-my-posh
user_do "mkdir ~/.poshthemes"
user_do "wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip"
user_do "unzip ~/.poshthemes/themes.zip -d ~/.poshthemes"
user_do "chmod u+rw ~/.poshthemes/*.omp.*"
user_do "rm ~/.poshthemes/themes.zip"

# Set themes and wallpaper
show_message "Aplicando Wallpaper"
user_do "DBUS_SESSION_BUS_ADDRESS='unix:path=/run/user/${RUSER_UID}/bus' gsettings set org.cinnamon.desktop.background picture-uri 'file:///$PWD/assets/wallpapers/default-wallpaper.jpg'"

# Home folder - config files
show_message "Copiando arquivos de configuração para a pasta home"
git clone https://github.com/quantux/home /tmp/home
shopt -s dotglob
mv /tmp/home/* /home/$RUID/
chown -R $RUID:$RUID /home/$RUID/.git

# Install vim-plug
show_message "Instalando Vim-Plug"
user_do "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
user_do "curl -fLo ${XDG_DATA_HOME:-~/.local/share}/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
user_do "vim -c :PlugInstall -c :q -c :q"

# Cinnamon menu
show_message "Copiando arquivos tema do cinnamon-menu"
user_do "cp -Tr ./assets/cinnamon-settings/menu@cinnamon.org ~/.config/cinnamon/spices/menu@cinnamon.org"

# Cinnamon panel launcher
show_message "Copiando arquivos tema do panel-launcher-cinnamon"
user_do "cp -Tr ./assets/cinnamon-settings/panel-launchers@cinnamon.org ~/.config/cinnamon/spices/panel-launchers@cinnamon.org"

# Cinnamon calendar
show_message "Copiando arquivos tema do cinnamon calendar"
user_do "cp -Tr ./assets/cinnamon-settings/calendar@cinnamon.org ~/.config/cinnamon/spices/calendar@cinnamon.org"

# Cinnamon sound
show_message "Copiando arquivos de configuração do sound"
user_do "cp -Tr ./assets/cinnamon-settings/sound@cinnamon.org ~/.config/cinnamon/spices/sound@cinnamon.org"

# Load dconf file
show_message "Carregando configurações do dconf"
user_do "DBUS_SESSION_BUS_ADDRESS='unix:path=/run/user/${RUSER_UID}/bus' dconf load / < ./assets/cinnamon-settings/dconf"

# Allow games run in fullscreen mode
echo "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0" >> /etc/environment

# Install grub themes
show_message "Instalando grub themes"
git clone https://github.com/vinceliuice/grub2-themes assets/grub2-themes
./assets/grub2-themes/install.sh -b -t tela

# Install grub-customizer
show_message "Instalando grub-customizer"
add-apt-repository ppa:danielrichter2007/grub-customizer -y
apt update
apt install -y grub-customizer

# Install snapd
show_message "Instalando snapd"
rm /etc/apt/preferences.d/nosnap.pref
apt update
apt install -y snapd

# Install bitwarden
show_message "Instalando bitwarden"
snap install bitwarden

# ---- Programming things
# Install apache, nginx, openssh
show_message "Instalando servidores"
apt install apache2 nginx openssh-server -y

# Install ASDF
show_message "Instalando ASDF"
user_do "git clone https://github.com/asdf-vm/asdf.git ~/.asdf"
user_zsh_do "asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git"
user_zsh_do "asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git"
user_zsh_do "asdf install nodejs latest"
user_zsh_do "asdf global nodejs latest"
user_zsh_do "asdf install ruby latest"
user_zsh_do "asdf global ruby latest"

# Install rails
show_message "Instalando Ruby on Rails"
user_zsh_do "gem install rails"

# Install npm global packages
show_message "Instalando pacotes npm globais"
user_zsh_do "npm i -g yarn"
user_zsh_do "npm i -g http-server"
user_zsh_do "npm i -g localtunnel"
user_zsh_do "npm i -g ngrok"

# Install PHP
show_message "Instalando PHP"
apt install -y php php-common php-bcmath php-json php-mbstring php-tokenizer php-xml libapache2-mod-php php-xmlrpc php-soap php-gd php-mysql php-cli php-curl php-zip php-pear php-dev libcurl3-openssl-dev

# Install MySQL
show_message "Instalando MySQL"
apt install -y mysql-server
mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

# Instalar Composer
show_message "Instalando Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
user_do "composer global require laravel/installer"

# Instalar Android Studio
show_message "Instalando Android Studio"
apt install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
android_studio_url=$(curl -s 'https://developer.android.com/studio/index.html' | grep -Po '(?<=href=")[^"]*(?=")' - | grep -m1 .tar.gz)
wget $android_studio_url -O /tmp/android-studio.tar.gz
tar -xvf /tmp/android-studio.tar.gz -C /usr/share/

# Instalar docker
show_message "Instalando Docker"
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
docker run hello-world
groupadd docker
usermod -aG docker $RUID

# Instalar Insomnia
show_message "Instalando Insomnia"
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
apt update
apt install -y insomnia

# Install Postman
show_message "Instalando Postman"
wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/Postman.tar.gz
tar -zxvf /tmp/Postman.tar.gz -C /usr/share/
mv assets/programs-settings/Postman.desktop /home/$RUID/.local/share/applications/

# Install anydesk
show_message "Instalando anydesk"
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
apt update
apt install -y anydesk

# remove legacy trusted gpg key
apt-key export CDFFDE29 | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/anydesk.gpg
apt-key --keyring /etc/apt/trusted.gpg del CDFFDE29

# store git credentials
show_message "Permitir o git salvar credenciais de acesso localmente"
user_do "git config --global credential.helper store"

# Customize Plymouth theme
show_message "Instalando tema do plymouth"
git clone https://github.com/adi1090x/plymouth-themes /usr/share/themes/plymouth-themes
cp -r /usr/share/themes/plymouth-themes/pack_2/hexagon_alt /usr/share/plymouth/themes/
update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/hexagon_alt/hexagon_alt.plymouth 100
sudo update-alternatives --config default.plymouth
update-initramfs -u

# Define zsh como shell padrão
show_message "Definir zsh como shell padrão"
user_do "chsh -s $(which zsh)"

# Reiniciar
show_message ""
while true; do
    read -p "Finalizado! Deseja reiniciar? (y/n): " yn
    case $yn in
        [Yy]* ) reboot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
