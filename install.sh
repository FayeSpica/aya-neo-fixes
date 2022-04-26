#!/bin/bash
set -e

echo "Adding WiFi fix for MT7921K"
cp -v rz608.conf /etc/modprobe.d/

echo "Adding reboot kernel panic fix."
cp -v mt7921e.shutdown /usr/lib/systemd/system-shutdown

echo "Adding suspend loss of wifi on suspend fix"
cp -v systemd-suspend-mods.conf /etc/systemd-suspend-mods.conf
cp -v systemd-suspend-mods.sh /usr/lib/systemd/system-sleep/systemd-suspend-mods.sh

echo "Enabling unmapped buttons. NEXT users will need to configure the Home button in steam."
cp -v neo-controller.py /usr/local/bin/
cp -v neo-controller.service /etc/systemd/system
cp -v Aya-Neo-Controller.cfg /usr/share/libretro/autoconfig/udev # retroarch config file
systemctl enable neo-controller && systemctl start neo-controller
exit 0
