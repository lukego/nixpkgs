{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.spacenav;
in {

  ### interface

  options = {
    services.spacenav = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable Spacenav support for 3D input devices (such as 3Dconnexion Spacemouse.)
        '';
      };
    };
  };
  
  ### implementation

  config = mkIf cfg.enable {
#    services.udev.packages = [ pkgs.trezor-udev-rules ];

    systemd.services.spacenav = {
      description = "Spacenav daemon";
#      after = [ "systemd-udev-settle.service" "network.target" ];
#      wantedBy = [ "multi-user.target" ];
      path = [];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.spacenavd}/bin/spacenavd";
        User = "spacenav";
      };
    };

    users.users.spacenav = {
      group = "spacenav";
      description = "Spacenav daemon user";
      isSystemUser = true;
    };

    users.groups.spacenav = {};
  };
}
