#!/bin/bash
set -e
if ! hash apt-get 2>/dev/null; then
        echo "This script requires a Debian based distribution."
        exit 1
fi

if [ "$(id -u)" -ne "0" ]; then
        echo "This script requires root."
        exit 1
fi
# update repositories
apt-get -y update
# install build basics.
apt-get -y install pkg-config gtk+-2.0 glib-2.0 libgnome-2.0 libgnomeui-dev intltool itstool streamripper audacious
# get GIRL source, unzip and configure
cd /tmp
wget https://download.gnome.org/sources/girl/9.5/girl-9.5.0.tar.xz
tar Jxvf girl-9.5.0.tar.xz
cd girl-9.5.0
./configure
# compile wih Audacious as preferred player. Replace Audacious with preferred audio-player. Use make without switches for Totem as default player.
make -e GIRL_HELPER_PLAYER=/usr/bin/audacious
make install
