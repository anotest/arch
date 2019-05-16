#!/bin/bash


passwd
pacman -S --noconfirm grub linux-headers ttf-dejavu i3 dmenu sddm networkmanager xorg-server 
systemctl enable sddm 
systemctl enable NetworkManager
add_user(){
    color yellow "Input the user name you want to use (must be lower case)"
    read USER
    useradd -m -g wheel $USER
    color yellow "Set the passwd"
    passwd $USER
    pacman -S --noconfirm sudo
    sed -i 's/\# \%wheel ALL=(ALL) ALL/\%wheel ALL=(ALL) ALL/g' /etc/sudoers
    sed -i 's/\# \%wheel ALL=(ALL) NOPASSWD: ALL/\%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
}
add_user
clean(){
    sed -i 's/\%wheel ALL=(ALL) NOPASSWD: ALL/\# \%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
}
clean
