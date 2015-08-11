#!/bin/bash

rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

mv /etc/locale.gen /etc/local.gen.orig
mv /configs/locale.gen /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf

echo "KEYMAP=dvorak" > /etc/vconsole.conf
echo "FONT=lat9w-16" >> /etc/vconsole.conf

pacman -Syy brtfs-progs grub --noconfirm

ln -sf /usr/share/zoneinfo/US/Arizona /etc/localtime

hwclock --systohc --utc

echo capricorn13 > /etc/hostname
nano /etc/hosts

mkinitcpio -p linux
root password
passwd

grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
exit
