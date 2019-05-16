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
  cryptsetup luksFormat /dev/sda2
  cryptsetup open --type luks /dev/sda2 lvm
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
