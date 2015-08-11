#!/bin/bash
#Disabel pc speaker
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

#un comment en_US.UTF-8
nano /etc/locale.gen

locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=dvorak" > /etc/vconsole.conf
echo "FONT=lat9w-16" >> /etc/vconsole.conf

pacman -Syy brtfs-progs grub --noconfirm

ln -sf /usr/share/zoneinfo/US/Arizona /etc/localtime

hwclock --systohc --utc

echo capricorn13 > /etc/hostname

nano /etc/hosts

mkinitcpio -p linux

passwd

pacman -S grub
grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg


nano /etc/sudoers



echo "[xyne-x86_64]" >> /etc/pacman.conf
# A repo for Xyne's own projects: http://xyne.archlinux.ca/projects/
# Packages for the "x86_64" architecture.
# Note that this includes all packages in [xyne-any].
echo "SigLevel = Required" >> /etc/pacman.conf
echo "Server = http://xyne.archlinux.ca/repos/xyne" >> /etc/pacman.conf
#uncomment multilib
nano /etc/pacman.conf

pacman -Syy powerpill
sudo powerpill -S wget

sudo powerpill -S xorg-server xorg-server-utils xorg-apps xorg-xinit mesa-demos xterm xorg-xclock\
 nvidia nvidia-libgl lib32-nvidia-libgl alsa-utils bspwm sxhkd slim dmenu chromium firefox stow\
 libvirt qemu ebtables dnsmasq bridge-utils openbsd-netcat virt-manager virtviewer dmidecode ntp --noconfirm

echo "Section \"InputClass\"" > /etc/X11/xorg.conf.d/00-keyboard.conf
echo "Identifier \"system-keyboard\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "MatchIsKeyboard \"on\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "Option \"XkbLayout\" \"dvorak\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "Option \"XkbModel\" \"pc104\"" >> /etc/X11/xorg.conf.d/00-keyboard.conf
echo "EndSection" >> /etc/X11/xorg.conf.d/00-keyboard.conf
#nano /etc/X11/xorg.conf.d/20-nvidia.conf
#Section "Device"
#Identifier "Nvidia Card"
#Driver "nvidia"
#VendorName "NVIDIA Corporation"
#Option "NoLogo" "true"
#EndSection




useradd -m -G wheel,kvm -s /bin/bash x01000010


exit
