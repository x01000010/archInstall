#!/bin/bash
#Disabel pc speaker
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

#un comment en_US.UTF-8
nano /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=dvorak > /etc/vconsole.conf
echo FONT=lat9w-16 >> /etc/vconsole.conf

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
exit
