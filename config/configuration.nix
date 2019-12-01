{ config, lib, pkgs, ... }:
{
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

environment.systemPackages = with pkgs; [

    git
    tmux

  ];

}
