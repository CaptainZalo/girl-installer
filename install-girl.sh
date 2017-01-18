#!/bin/bash
# Installer script v0.2.2. Intended for Debian ARM-based SoC-distribution and GIRL v9.5.2. 
# More info on GIRL by Ole Aamot at http://girl.software
# ** Support free software and internet radio. **
# Check if Synaptic packagemanager is installed.
set -e
if ! hash apt-get 2>/dev/null; then
        echo "Sorry. This script requires a distribution with Synaptic package manager."
        exit 1
fi
# Check if script is ran in root context.
if [ "$(id -u)" -ne "0" ]; then
        echo "This script requires root."
        exit 1
fi
# Update repositories.
sudo apt-get -y update
# Install build dependencies.
sudo apt-get -y install pkg-config gcc gtk+-2.0 glib-2.0 libgnome-2.0 libgnomeui-dev intltool itstool streamripper audacity
# Clean out girl residue in /tmp/ in case of rebuild in same boot period.
rm -rf /tmp/girl-*
# Get GIRL 9.5.0 source tarball, unzip and configure.
# Version 9.6.2 uses a built-in gstreamer playback routine. Link is https://download.gnome.org/sources/girl/9.6/girl-9.6.1.tar.xz
# Version 9.5.2 is a easier to configure for smaller systems and not as reliant on Gnome.
wget https://download.gnome.org/sources/girl/9.5/girl-9.5.2.tar.xz -O /tmp/girl.tar.xz
tar Jxvf /tmp/girl*
cd /tmp/girl-*
./configure
# Compile wih preferred player. Replace <program name> with preferred audio-player. Audacity added for easier use on smaller screens.
# make -e GIRL_HELPER_PLAYER=/usr/bin/<program name>
make -e GIRL_HELPER_PLAYER=/usr/bin/audacity
# Compile with Totem as default player by commenting out line below and just use make command.
sudo make install
