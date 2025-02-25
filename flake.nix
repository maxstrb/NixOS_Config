{
  description = "My personal NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manger config
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nvf
    nvf.url = "github:notashelf/nvf";

    #Catppuccin
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, catppuccin, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      max-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };

          modules = [
            ./nixos/configuration.nix

            catppuccin.nixosModules.catppuccin

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.backupFileExtension = "backup_nix";

              home-manager.users.maxag = { 
                imports = [ 
                  nvf.homeManagerModules.default
                  ./nixos/home.nix

                  catppuccin.homeManagerModules.catppuccin
	              ];
	            };
	          }
        ];
      };
    };
  };
}
