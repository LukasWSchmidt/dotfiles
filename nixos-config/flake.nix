# /etc/nixos/flake.nix
{
  inputs = {
    # NOTE: Replace "nixos-23.11" with that which is in system.stateVersion of
    # configuration.nix. You can also use latter versions if you wish to
    # upgrade.

		
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
    url = "github:hyprwm/hyprland-plugins";
    inputs.hyprland.follows = "hyprland";
  };
    
    home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
			url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
  		inputs.nixpkgs.follows = "nixpkgs";
    };


		## Packages added by me !:D
  };
  outputs = {
    self,
  	nixpkgs,
  	kmonad,
  	home-manager,
  	hyprland-plugins,
  ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
	in
  {

		home-manager.users.lukas = {
  		wayland.windowManager.hyprland.plugins = [
				inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
  		];
		};

    # NOTE: 'nixos' is the default hostname set by the installer
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        kmonad.nixosModules.default
        
      ];
    };
  };
}
