# Update + Upgrade
apt update && apt upgrade -y

# 32bits packages
dpkg --add-architecture i386

# Install packages
sudo apt install -y build-essential zsh git curl wget preload blender deepin-screenshot deepin-icon-theme vim gimp  blender cheese sublime-text screenfetch python2 python3 python3-gpg python3-pip inkscape virtualbox virtualbox-qt vlc filezilla steam gparted pinta nmap traceroute vlc ttf-mscorefonts-installer p7zip-full okular unrar rar bleachbit ubuntu-restricted-extras libdvd-pkg tlp tp-smapi-dkms acpi-call-dkms gimp-help-pt fonts-powerline calibre gnome-boxes audacity kazam htop neofetch openshot python3-setuptools scrcpy whois grub-customizer gnupg2 software-properties-common libncurses5-dev libgmp-dev libmysqlclient-dev remmina tree obs-studio pavucontrol gir1.2-gmenu-3.0 jstest-gtk speedtest-cli pv neovim wireshark clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev xclip;

# Install pylint
pip3 install pylint


