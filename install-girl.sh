#!/bin/bash
echo "Installer script v0.2. Intended for Debian ARM-based SoC-distribution, but will work on most Debian distros."
echo "Script installs Gnome Internet Radio Locator > v9.9.0. by Ole Aamot. http://girl.software"
echo "Check if Synaptic packagemanager is installed..."
set -e
if ! hash apt-get 2>/dev/null; then
        echo "Sorry. This script requires a distribution with Synaptic package manager (Debian distributions)."
        exit 1
fi
# Check if script is ran in root context.
if [ "$(id -u)" -ne "0" ]; then
        echo "This script requires root."
        exit 1
fi
echo "Update repositories..."
sudo apt-get -y update
echo "Install build dependencies..."
sudo apt-get install -y build-essential yelp-tools libchamplain-gtk-0.12-dev debhelper libgtk-3-0 gtk+-2.0 glib-2.0 libgnome2-0 itstool libpango-1.0-0 libchamplain-gtk-0.12-0 gtk-doc-tools libgstreamer-plugins-base1.0-dev gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good streamer1.0-plugins-bad libgnomevfs2-dev libgnomeui-dev intltool pkg-config libgtk2.0-dev libgnome2-dev libxml2-dev streamripper
# Control will enter here if $DIRECTORY exists.
echo "Get latest GIRL source to user's context and enter directory..."
cd ~ && git clone git://git.gnome.org/girl && cd girl
echo "Build, make and install executable..."
./autogen.sh && make && sudo make install && cd
echo "Run program with command 'girl' and enjoy free Internet radio."
