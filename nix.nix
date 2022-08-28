{ config, pkgs, options, lib, ... }:

let rp = import ./reverse-proxy.nix; in

{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
      ];
      keep-outputs = true;
      substituters = lib.mkForce [
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "${rp}https://cache.nixos.org"
        "${rp}https://nix-community.cachix.org"
        "${rp}https://nixos-cn.cachix.org"
        "${rp}https://linyinfeng.cachix.org"
        "${rp}https://shadowrz.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
        "linyinfeng.cachix.org-1:sPYQXcNrnCf7Vr7T0YmjXz5dMZ7aOKG3EqLja0xr9MM="
        "shadowrz.cachix.org-1:I+6FCWMtdGmN8zYVncKdys/LVsLkCMWO3tfXbwQPTU0="
      ];
    };
  };
}