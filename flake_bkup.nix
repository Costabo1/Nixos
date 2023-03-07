{
  description = "pi4-hyprland mininal";

  #
  inputs = {
    # 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";     
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    
    #rust-overlay.url = "github:oxalica/rust-overlay";
    #impermanence.url = "github:nix-community/impermanence";
    nur.url = "github:nix-community/NUR";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";
    flake-utils.url = "github:numtide/flake-utils";
    sops-nix.url = "github:Mic92/sops-nix";
    picom.url = "github:yaocccc/picom";
   
    hyprland-protocols = {
      url = "github:hyprwm/hyprland-protocols";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland-protocols.follows = "hyprland-protocols";
    };

    hyprland = {
        url = "github:hyprwm/Hyprland";

        inputs.nixpkgs.follows = "nixpkgs";
      };
     

     home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    
  };

};

  #output_
  outputs = { self, nixpkgs, flake-utils,hyprland,nixos-hardware,... }:
   
        let system = "aarch64"; #arm64-linux
	user   = "costabo1"; 
    
    in {
      nixosConfigurations.Nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
         nixos-hardware.nixosModules.raspberry-pi-4
          
         ./configuration.nix
        
         hyprland.nixosModules.default
        {programs.hyprland.enable = true;}
        ];
      };
    };
   
  
}
    # nixosConfigurations."nixos2" = nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   modules = [
    #     ./configuration2.nix
    #   ];
    # };
    #

