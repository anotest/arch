set -xe
timedatectl set-ntp true

fdisk /dev/sda <<EOF
o
n
p
1

+7G
n
p
2

+512M
a
2
t
1
8e
w
EOF
setup_LVM() {
  cryptsetup luksFormat /dev/sda1
  cryptsetup open --type luks /dev/sda1 lvm
  pvcreate /dev/mapper/lvm
  vgcreate volgroup0 /dev/mapper/lvm
  lvcreate -L 3GB volgroup0 -n lv_root
  lvcreate -L 1GB volgroup0 -n lv_swap
  lvcreate -l 100%FREE volgroup0 -n lv_home
  modprobe dm_mod
 vgscan
 vgchange -ay

}
setup_LVM
mkfs.ext2 /dev/sda2
mkfs.ext4 /dev/volgroup0/lv_root
mkfs.ext4 /dev/volgroup0/lv_home

mount /dev/volgroup0/lv_root /mnt 
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

mkdir /mnt/home 
mount /dev/volgroup0/lv_home /mnt/home 
