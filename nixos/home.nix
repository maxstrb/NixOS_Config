{ inputs, config, pkgs, ... }: {
  home.username = "maxag";
  home.homeDirectory = "/home/maxag";

  home.stateVersion = "24.11";

  # Downloads
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.kdePackages.kate
    pkgs.trilium-next-desktop
    pkgs.libreoffice-qt
    pkgs.oh-my-posh
    pkgs.discord

    pkgs.dotnetCorePackages.sdk_8_0_3xx-bin

    pkgs.git-credential-manager
    pkgs.zellij

    pkgs.krita

    pkgs.mpv
  ];

  # Programs section
  gtk.enable = true;
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  programs.zellij.enable = true;
  programs.zellij.enableBashIntegration = false;
  
  programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "https://searx.aicampground.com";
            "browser.search.defaultenginename" = "Searx";
            "browser.search.order.1" = "Searx";
          };
          search = {
            force = true;
            default = "Searx";
            order = [ "Searx" "Google" ];
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };
              "Searx" = {
                urls = [{ template = "https://searx.aicampground.com/?q={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@searx" ];
              };
              "Bing".metaData.hidden = true;
              "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };
          };
        };
      };
    };


  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };

      useSystemClipboard = true;

      options = {
        tabstop = 2;
        autoindent = true;
        shiftwidth = 2;
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;

      languages = {
        enableLSP = true;
	      enableTreesitter = true;

        html.enable = true;
        html.treesitter.autotagHtml = true;

        nix.enable = true;
        rust.enable = true;
        ts.enable = true;
        csharp.enable = true;
      };
    };
  };

  programs.foot = {
    enable = true;
    settings.main = {
      initial-window-mode = "maximized";
      font = "JetBrainsMono Nerd Font";
      term = "xterm-256color";
    };
  };

  programs.git = {
    enable = true;

    userEmail = "max.stribrny@gmail.com";
    userName = "max_ag";

    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "maxstrb";
    extraConfig.credential.credentialStore = "cache";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.nushell = {
    enable = true;

    extraConfig = ''
      if "ZELLIJ" in $env == false {
        zellij
        exit
      }

      def garbage [] {
        sudo nix-collect-garbage --delete-old 
        sudo nixos-rebuild switch --flake /home/maxag/.nix_config
      }
    '';

    settings = {
      show_banner = false;
    };

    shellAliases = {
      c = "clear";
      zel = "zellij";
      rebuild = "sudo nixos-rebuild switch --flake /home/maxag/.nix_config";
      home = "nvim /home/maxag/.nix_config/nixos/home.nix";
    };
  };

  programs.oh-my-posh = {
    enable = true;

    useTheme = "catppuccin_macchiato";

    enableNushellIntegration = true;
    enableBashIntegration = true;
  };

  programs.bash.enable = true;

  # End of programs section

  catppuccin.flavor = "macchiato";
  catppuccin.enable = true;

  programs.home-manager.enable = true;
}
