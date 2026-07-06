{
  description = "Minimal+ NixOS installation ISO";

  inputs = {
    # Use stable by commenting out the unstable channel below and uncommenting
    # this subsequent line.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Use unstable by commenting out the stable channel above and uncommenting
    # this subsequent line.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixos-minimal-plus-iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Inherit the default minimal ISO configuration from nixpkgs.
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

          # Custom extras.
          ./iso-configuration.nix
        ];
      };
    };
  };
}
