#!/bin/bash


arch-chroot /mnt passwd
arch-chroot /mnt pacman -S --noconfirm grub linux-headers ttf-dejavu i3 dmenu sddm networkmanager xorg-server 
arch-chroot /mnt systemctl enable sddm 
arch-chroot /mnt systemctl enable NetworkManager

