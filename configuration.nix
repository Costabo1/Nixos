  { config, pkgs, lib, ... }:

let
    user = "";
    password = "";
    SSID = "";
    SSIDpassword = "";
    interface = "";
    hostname = "Nixos"; 

  nix.settings = {
	package = pkgs.nixUnstable;
      	experimental-features =  [ "nix-command" "flakes" ];

    
	substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };


  in {

imports = [
 ./hardware-configuration.nix
];

# Allow proprietary software (such as the NVIDIA drivers).
  nixpkgs.config.allowUnfree = true;
  #home-manager.useGlobalPkgs = true;
  #home-manager.useUserPackages = true;

# Set your time zone.
  time.timeZone = "US/Eastern";

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    };

    networking = {
      hostName = hostname;
      wireless = {
        enable = true;
        networks."${SSID}".psk = SSIDpassword;
        interfaces = [ interface ];
      };
    };

   environment.systemPackages = with pkgs; [
       
       lsd
       vim
       #neovim-nightly
       wayland
       #etcher
       gparted
       dunst
       blocky
       wget
       curl
       git
       lazygit
       killall
       xclip
       fd
       ripgrep
       ripgrep-all
       htop
       neofetch
       gimp
       firefox
       terminal-colors
       wofi
       btop
       fish
       oh-my-fish
       oh-my-zsh
       zsh
       nextcloud24
       fzf
       grc
       kitty
       openvpn
       alsa-lib
       alsa-firmware
       pulseaudio
       picom
       neovim
       pipes
       cava
       mesa
       metasploit
       nmap
       evil-winrm
       toybox
       chisel
       swaybg
       pwncat
       john
 ];

    services.openssh.enable = true;
    
    programs.fish.enable = true;
   
    boot.loader.grub.device = "nodev";

 # Fonts
  fonts.fonts = with pkgs; [
    fira-code
    fira
    cooper-hewitt
    ibm-plex
    jetbrains-mono
    iosevka
    # bitmap
    spleen
    fira-code-symbols
    powerline-fonts
    nerdfonts
  ];   

 
    #default options, you don't need to set them
   #package = hyprland.packages.${pkgs.system}.default;


   # xwayland = {

     # enable = true;
      #hidpi = true;
    #};

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  #services.xserver.desktopManager.plasma5.enable = true;

 programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      mako # notification daemon
      grim
      kanshi
      slurp
     alacritty # Alacritty is the default terminal in the config
     dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  programs.waybar.enable = true;

  # QT
  qt.platformTheme = "qt5ct";



    users = {
      mutableUsers = false;
      users."${user}" = {
        isNormalUser = true;
        password = password;
        extraGroups = [ "wheel" "audio" "sound" "video" "networkmanager" "input" "tty" ];
      };
    };

    # Enable GPU acceleration
    #hardware.raspberry-pi."4".fkms-3d.enable = true;

     #services.xserver = {
      # enable = true;
       #displayManager.lightdm.enable = true;
       #desktopManager.xfce.enable = true;
    #};
    
    sound.enable =true;
    hardware.pulseaudio.enable = true;
    boot.loader.raspberryPi.firmwareConfig = ''
    dtparam=audio=on
'';
  
system.stateVersion = lib.mkForce "23.05";
}
