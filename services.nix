{ config, pkgs, ... }:

{
  services = {

    aria2 = {
      enable = true;
      downloadDir = "/home/aria2";
    };

    cron.enable = true;

    cpupower-gui.enable = true;

    earlyoom.enable = true;

    fstrim.enable = true;

    onedrive.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };

    xserver = {
      excludePackages = [ pkgs.xterm ];
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

  };
}
