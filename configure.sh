#!/bin/bash

# Update + Upgrade
apt update && apt upgrade -y

# 32bits packages
dpkg --add-architecture i386

# Install apt packages
sudo apt install -y build-essential zsh git curl wget preload blender deepin-screenshot deepin-icon-theme vim gimp  blender cheese sublime-text screenfetch python2 python3 python3-gpg python3-pip inkscape virtualbox virtualbox-qt vlc filezilla steam gparted pinta nmap traceroute vlc ttf-mscorefonts-installer p7zip-full okular unrar rar bleachbit ubuntu-restricted-extras libdvd-pkg tlp tp-smapi-dkms acpi-call-dkms gimp-help-pt fonts-powerline calibre gnome-boxes audacity kazam htop neofetch openshot python3-setuptools scrcpy whois grub-customizer gnupg2 software-properties-common libncurses5-dev libgmp-dev libmysqlclient-dev remmina tree obs-studio pavucontrol gir1.2-gmenu-3.0 jstest-gtk speedtest-cli pv neovim wireshark clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev xclip;

# Install pylint
pip3 install pylint

# Install flatpak packages
flatpak install flathub com.github.calo001.fondo
flatpak install com.github.donadigo.appeditor

# Install Chrome + Bitwarden
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

install_chrome_extension () {
  preferences_dir_path="/opt/google/chrome/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  mkdir -p "$preferences_dir_path"
  echo "{" > "$pref_file_path"
  echo "  \"external_update_url\": \"$upd_url\"" >> "$pref_file_path"
  echo "}" >> "$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}

install_chrome_extension "nngceckbapebfimnlniiiahkandclblb" "Bitwarden"

# Install - Adapta Nokto Fonts
wget "https://fonts.google.com/download?family=Roboto" -O roboto.zip
wget "https://fonts.google.com/download?family=Noto Sans" -O noto_sans.zip

unzip roboto.zip -d Roboto
unzip noto_sans.zip -d Noto_Sans

mv Roboto Noto_Sans /usr/share/fonts/.

# Install - Adapta Nokto theme
wget "https://launchpad.net/\~tista/+archive/ubuntu/adapta/+files/adapta-gtk-theme_3.95.0.11-0ubuntu1\~bionic1_all.deb" -O adapta-gtk-theme.deb
dpkg -i adapta-gtk-theme.deb

# Install Sweet Theme
git clone https://github.com/EliverLara/Sweet /usr/share/themes/.

# Install Teamviewer
wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" -O teamviewer.deb
dpkg -i teamviewer.deb

# La Capitaine icons
git clone https://github.com/keeferrourke/la-capitaine-icon-theme /usr/share/icons/la-capitaine

# ZSH and Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
chsh -s $(which zsh);

# Disable Recent Files
rm ~/.local/share/recently-used.xbel
touch ~/.local/share/recently-used.xbel
sudo chattr +i ~/.local/share/recently-used.xbel

# WPS Office Fonts
git clone https://github.com/udoyen/wps-fonts.git /tmp/wps-fonts
mv /tmp/wps-fonts/wps /usr/share/fonts/.

# Home folder - config files
git clone https://github.com/quantux/home /tmp/home
mv -f /tmp/home/* ~/.

# Install ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# Install Dropbox
wget "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb" -O dropbox.deb
dpkg -i dropbox.deb


