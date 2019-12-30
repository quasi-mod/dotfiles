dotfiles
========

dotfiles for my personal use.

Installation
------------

### Packages needed
All of these packages should be moved to setup.sh and made to work automatically
- [pyenv](https://github.com/pyenv/pyenv)
    - python package needed to use python 3.X 
- [neovim](https://github.com/neovim/neovim)
    - The main text editor used (install the latest version)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - zsh plugin that can be make zsh work like Fish shell.
    - can and should be moved to zplug
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - zsh plugin that can be make zsh work like Fish shell.
    - can and should be moved to zplug
- [golang](https://github.com/golang/go)
    - golang. Used to power powerline-go
- [powerline-go](https://github.com/justjanne/powerline-go)
    - a fancy looking shell extention.
- clang / llvm

### Recommended

This method allows you to edit files or work on different branches without
affecting your current configuration. It works by creating two separate
worktrees, one for editing and the other for deployment.

#### Debian/Ubuntu
```sh
cd ~/Documents
git clone https://github.com/quasi-mod/dotfiles.git
cd dotfiles
git branch --track local
git worktree add ~/.config/dotfiles local
cd ~/.config/dotfiles
./setup.sh --install-deps
```

#### NixOS

```sh
cd ~/Documents
git clone https://github.com/quasi-mod/dotfiles.git
cd dotfiles
git checkout nixos
git branch --track local
git worktree add ~/.config/dotfiles local
cd ~/.config/dotfiles
./setup.sh --install-deps
```

#### macOS

```sh
cd ~/Documents
git clone https://github.com/quasi-mod/dotfiles.git
cd dotfiles
git checkout osx
git branch --track local
git worktree add ~/Library/dotfiles local
cd ~/Library/dotfiles
./setup.sh --install-deps
```

### Simple

If you don't need a separate worktree for deployment, directly clone to the
deployment path instead.

#### Debian/Ubuntu

```sh
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/quasi-mod/dotfiles.git
cd dotfiles
./setup.sh --install-deps
```

#### NixOS

```sh
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/quasi-mod/dotfiles.git
cd dotfiles
git checkout nixos
./setup.sh --install-deps
```

#### macOS

```sh
cd ~/Library
git clone https://github.com/quasi-mod/dotfiles.git
cd dotfiles
git checkout osx
./setup.sh --install-deps
```
