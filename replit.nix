npm create cloudflare{ pkgs }: {
  deps = [
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}