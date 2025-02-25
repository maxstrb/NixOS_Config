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
  ]; 

  # Programs section
  gtk.enable = true;
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
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
    settings = {
      main.initial-window-mode = "maximized";
      main.font = "JetBrainsMono Nerd Font";
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

    settings = {
      show_banner = false;
    };

    shellAliases = {
      c = "clear";
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
