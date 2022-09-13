{ config, pkgs, ... }:

let
  rp = import ../reverse-proxy.nix;
in {
  imports = [ ./systemPackages.nix ];
  environment = {
    etc = {
      "makepkg.conf".source = "${pkgs.nur.repos.yes.archlinux.devtools}/share/devtools/makepkg-x86_64.conf";
      "pacman.conf".source = "/old-root/etc/pacman.conf";
      "pacman.d/gnupg".source = "${pkgs.nur.repos.yes.archlinux.pacman-gnupg}/etc/pacman.d/gnupg";
      "pacman.d/mirrorlist".text = ''
        Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
        Server = https://mirror.sjtu.edu.cn/archlinux/$repo/os/$arch
        Server = ${rp}https://geo.mirror.pkgbuild.com/$repo/os/$arch
      '';
    };

    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/x11/desktop-managers/gnome.nix
    gnome.excludePackages = with pkgs.gnome; [
      eog                     # use gthumb instead
      epiphany                # use firefox instead
      pkgs.gnome-text-editor  # use vscode instead
      gnome-calculator        # use xonsh instead
      gnome-contacts          # not managing contacts on PC
      gnome-music             # use gthumb instead
      pkgs.gnome-photos       # use gthumb instead
      gnome-weather           # ugly as hell
      simple-scan             # no scanner available
      totem                   # use gthumb instead
      evince                  # use many other apps for pdf
      geary                   # use web browser instead
    ];

    sessionVariables = {
      EDITOR = "nano";
      GST_PLUGIN_PATH_1_0 = ["${pkgs.gst_all_1.gst-vaapi}/lib/gstreamer-1.0"];
      LIBVA_DRIVER_NAME = "iHD";
      MOZ_DBUS_REMOTE = "1";
      MOZ_USE_XINPUT2 = "1";
      PYTHONPATH = ["${pkgs.my-python}/${pkgs.my-python.sitePackages}"];
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };
}
