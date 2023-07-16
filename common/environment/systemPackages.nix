{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    authenticator
    gnome.dconf-editor
    obs-studio
    tdesktop
    virt-manager
    xournalpp
    zotero

    (makeAutostartItem {
      name = "firefox";
      package = config.programs.firefox.package;
    })

    ((vscode.override {
      commandLineArgs = "--touch-events -n";
    }).fhsWithPackages (ps: with ps; [
      nil                               # for nix IDE
      pacman                            # add a dummy makepkg.conf to FHS
      python3Packages.python-lsp-server # for xonsh IDE
    ]))

    # CLI programs
    archix.paru                   # frequently used to query AUR packages
    bat                           # frequently used to view text in terminal
    dig                           # must be available without Internet connection
    file                          # frequently used to view executable type
    jre                           # can always be detected by libreoffice
    nix-output-monitor            # frequently used in nix operations
    onedrive                      # required by gnomeExtensions.one-drive-resurrect
    pdftk                         # required by Jasminum
    starship                      # configured without nix
    texlive.combined.scheme-full  # required by Xournal++ and VSCode LateX Workshop
    wl-clipboard                  # required by WayDroid

    # direnv
    direnv
    nix-direnv

    # Out-of-tree packages
    yes.lx-music-desktop
  ];
}