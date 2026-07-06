# NixOS Minimal+ ISO
This repository contains a nix flake to create a nixos installation iso that is
mostly minimal with some extra batteries.

## Install and Enable Nix.
Install nix.
For example on Arch Linux, one can run:
```sh
sudo pacman -S nix
```
Then enable the nix-daemon and modify your user permissions to be able
to use nix.
```sh
sudo systemctl enable --now nix-daemon.service
sudo usermod -aG nix-users "$USER"
```

## Build the ISO
Build the ISO
```sh
nix --extra-experimental-features "nix-command flakes" \
  build .#nixosConfigurations.nixos-minimal-plus-iso.config.system.build.isoImage
```

Check that the ISO has bee built; it should appear here:
```sh
ls -lh result/iso/*.iso
```

## Flash the ISO to USB
Identify the USB device:
```sh
lsblk -o NAME,SIZE,MODEL,TRAN,MOUNTPOINTS
```

Suppose the USB is `/dev/sdX`.
Use the whole disk, not a partition like `/dev/sdX1`.
First unmount the device and then flash to it.
```sh
sudo umount /dev/sdX?* 2>/dev/null

sudo dd if=result/iso/*.iso of=/dev/sdX bs=4M status=progress oflag=sync
sync
```

## After booting the ISO
### Connect to wifi
Check NetworkManager
```sh
nmcli device
nmcli radio wifi
nmcli device wifi list
```

You should be able to connect to wifi using:
```sh
nmcli device wifi connect "SSID" password "PASSWORD"
```

### Connect to NixOS installation target machine using ssh
On the **host machine** (the one running the Live ISO), you need to set a
password for the default `nixos` user and find the machine's IP address.

```sh
# Set a temporary password for the 'nixos' user
passwd

# Find the IP address of the machine (look for the wlan0 or ethernet interface)
ip -brief addr show
```

On your client machine, you can now connect to the host using the IP address you
just found:
```sh
ssh nixos@<ip-address>
```
