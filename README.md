# Neovim Switch Config — ns

This is a plugin for zsh that allows you to open a
[Neovim](https://neovim.io/) with a matching config directory using [fzf](https://github.com/junegunn/fzf).

## Dependencies

- Neovim

### Install neovim using releases:
> - Visit [realeases](https://github.com/neovim/neovim/releases) page
> - Download your operating system binary
> - Paste it on your path.

### Install neovim using [asdf](https://github.com/asdf-vm/asdf):

Dependencies for asdf
```sh
pacman -S curl git
```
Install witg git clone (official way)
```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
```
And paste on ~/.zshrc
```zsh
. "$HOME/.asdf/asdf.sh"
```

Or install asdf from AUR
```sh
paru -S asdf-vm=0.14.0-1
```
And paste the init script on ~/.zshrc
```zsh
. /opt/asdf-vm/asdf.sh
```

Add neovim to asdf
```sh
asdf plugin add neovim
```

Install neovim version
```sh
asdf install neovim 0.9.1
```

Set neovim version as global
```sh
asdf global neovim 0.9.1
```

- fd
```sh
pacman -S fd
```

- Fzf
```
pacman -S fzf
```

## Install

To use it on [Zap](https://github.com/zap-zsh/zap) just put:

> Add this to the **end** of your config file (usually `~/.zshrc`):
>
> ```zsh
> plug "elvisgastelum/neovim-switch-config"
> ```
