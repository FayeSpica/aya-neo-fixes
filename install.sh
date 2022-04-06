#!/bin/bash
set -e

MODULES=$(cat suspend-modules.conf)

echo "Adding WiFi fix for MT7921K"
cp rz608.conf /etc/modprobe.d/
cp 99-rz608.rules /etc/udev/rules.d/

echo "Adding reboot kernel panic fix."
cp mt7921e.shutdown /usr/lib/systemd/system-shutdown

echo "Adding suspend-modules fix."
for line in $MODULES; do
	if ! grep -Fxq $line /etc/suspend-modules.conf; then
		echo "Adding $line to /etc/suspend-modules.conf"
		echo $line >> /etc/suspend-modules.conf
	fi
done

echo "Enabling unmapped buttons. You will need to manually configure the new controller device in steam."
mkdir /usr/share/ayaneo
cp neo-controller.py /usr/share/ayaneo/
cp neo-controller.service /etc/systemd/system
systemctl enable neo-controller && systemctl start neo-controller
exit 0
