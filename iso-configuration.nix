{ config, pkgs, lib, modulesPath, ... }:

{

  # New default from 26.11 onwards.
  boot.zfs.forceImportRoot = false;

  # The minimal ISO explicitly enables wpa_supplicant by default.
  # We use lib.mkForce to override that setting and disable it to let
  # NetworkManager to handle wireless connections.
  networking.wireless.enable = lib.mkForce false;

  # Enable NetworkManager.
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Include flakes and nix-command in the ISO environment.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Add extra batteries.
  environment.systemPackages = with pkgs; [
    networkmanager
    vim
    git
    curl
    pciutils
    usbutils
  ];

  # (Optional) Speeds up the ISO build process by using faster compression.
  # Comment this out if you prefer a smaller file size over build speed.
  # isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
