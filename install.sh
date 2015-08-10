#!/bin/bash

wipefs -af /dev/sda
wipefs -af /dev/sdb

parted /dev/sdb mktable gpt
parted /dev/sdb mkpart primary linux-swap 1MiB 20GiB
parted /dev/sdb mkpart primary  ext3 20GiB 100%

mkfs.btrfs -d single /dev/sda /dev/sdb2
mkswap /dev/sdb1
swapon /dev/sdb1

mount /dev/sda /mnt
btrfs subvolume create /mnt/boot
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/var
btrfs subvolume create /mnt/data

pacman -Syy reflector
reflector --verbose --country 'United States' -l 20 -p http --sort rate --save /etc/pacman.d/mirrorlist</code>

pacstrap /mnt base base-devel
genfstab -U /mnt > /mnt/etc/fstab
arch-chroot /mnt /bin/bash
