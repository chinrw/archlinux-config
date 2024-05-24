{ lib, pkgs, ... }: {

  programs.zsh = {
    enable = true;

    initExtra = "

      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r \"\${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh\" ]]; then
        source \"\${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh\"
      fi

      # Uncomment the following line to use hyphen-insensitive completion.
      # Case-sensitive completion must be off. _ and - will be interchangeable.
      HYPHEN_INSENSITIVE=\"true\"
      bindkey '\CI' expand-or-complete-prefix

      # User configuration
      zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -G -a --color auto --sort=accessed --git --icons -s type $realpath'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -G -a --color auto --sort=accessed --git --icons -s type $realpath'
      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false
      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}
      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

      # it is an example. you can change it
      zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \\
      	'git diff $word | delta'
      zstyle ':fzf-tab:complete:git-log:*' fzf-preview \\
      	'git log --color=always $word'
      zstyle ':fzf-tab:complete:git-help:*' fzf-preview \\
      	'git help $word | bat -plman --color=always'
      zstyle ':fzf-tab:complete:git-show:*' fzf-preview \\
      	'case \"\$group\" in
      	\"commit tag\") git show --color=always $word ;;
      	*) git show --color=always $word | delta ;;
      	esac'
      zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \\
      	'case \"\$group\" in
      	\"modified file\") git diff $word | delta ;;
      	\"recent commit object nam\") git show --color=always $word | delta ;;
      	*) git log --color=always $word ;;
      	esac'

        bindkey \"^P\" history-substring-search-up
      bindkey \"^N\" history-substring-search-down

      if [[ $TERM = dumb ]]; then
        unset zle_bracketed_paste
      fi

      ";

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];


    oh-my-zsh = {
      enable = true;
      plugins = [
        # "fzf-tab"
        "git"
        "rust"
        "python"
        "pip"
        "systemd"
        "ssh-agent"
        "docker"
        "docker-compose"
        "history-substring-search"
        # "zsh-syntax-highlighting"
        # "zoxide"
      ];
      extraConfig = "


      ";
    };

  };
}

