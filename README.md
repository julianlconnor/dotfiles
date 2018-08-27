Grailed standard dotfiles.

Currently included configs:

* vim
* tmux

tmux.conf and vimrc layout lifted from [Square's Maximum Awesome](https://github.com/square/maximum-awesome).

## Installation

### Back up existing config!

If you have an existing VIM or TMUX config, **back it up before continuing**:

```
mv ~/.vimrc ~/.vimrc.bk
mv ~/.vim ~/.vim.bk
mv ~/.tmux.conf ~/.tmux.conf.bk
```

Also, if you have customized colors for iTerm 2 but want to try Solarized, make sure to back up your existing colors first (export to file).

### Terminal prep

* Install iTerm 2
* Install [solarized colors for iTerm](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)
* Set your terminal type to `xterm-256`
* Install and use [Monaco for Powerline](https://www.dropbox.com/s/wjtdj6kcylfecve/Monaco%20for%20Powerline.otf) (or another Powerline-patched font)
* Uncheck "draw bold text in bright colors" under the "Text" tab

### Vim

* Brew where needed:

```
brew install macvim --override-system-vim
brew install the_silver_searcher
```

* Update your path in your `.zshrc` or `.bashrc` so `/usr/local/bin` comes first. Example:

```
export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin
```

* Link standard files, so that when you `git pull` this repo your config will get updated:

```
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/vimrc.bundles ~/.vimrc.bundles
```

* Copy local (customizable) files:

```
cp vimrc.local ~/.vimrc.local
cp vimrc.bundles.local ~/.vimrc.bundles.local
```

* Install [Vundle](https://github.com/gmarik/vundle):

```
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```

* Open `vim` (ignore the theme error for now) and type:

```
:BundleInstall
```

This will install the various default vim plugins.

* Copy `vim` into `.vim/` for syntax-specific goodies:

```
cp -r vim/** ~/.vim
```

* Compile YouCompleteMe

```
cd ~/.vim/bundle/YouCompleteMe
./install.sh
```

### Zsh

If you want to use zsh (and you should):

```
brew install zsh
```

* Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

### Tmux

```
brew install tmux
brew install reattach-to-user-namespace
```

### Git

`gitignore_global` is, as the name implies, is a global gitignore that will keep you from accidentally commiting your `swp` files and weird OS-generated files (`DS_Store`, urgh).

```
cp gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```

## Usage

### vim

(todo)

### tmux

The default tmux config remaps the leader key shortcut to `ctrl-a` (instead of the default `ctrl-b`). It also just rebinds a lot of stuff, so here's a cheatsheet:

```
Windows (tabs)
--------
C-a space/n/t   move to next window
C-a bspace/p/T  move to previous window
C-a c           create window
C-a [1/2/3...]  go to window #

Panes
-------
C-a s           add a new pane below the current one (horizontal split)
C-a v           add a new pane to the right (vertical split)
C-a z           toggle full-screen current pane
C-a h/j/k/l     navigate between panes
C-a C-o         rotate panes
C-a a           move to last pane
C-a x           kill pane
C-[h/j/k/l]     super awesome smart pane switching between vim/tmux!

Preset Layouts
-------
C-a -           main-vertical

+-------+-----+
|       |     |
|       |     |
| main  +-----+
|       |     |
|       |     |
+-------+-----+

C-a +           main-horizontal

+-------------+
|     main    |
|             |
|------+------+
|      |      |
|      |      |
+------+------+

Command Line
-------
tmux                  create session
tmux list-sessions    list sessions
tmux attach -t [id]   reattach to session
```

## Known Issues

### vim

* [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) is the autocomplete plugin this config uses, chosen because it's the least-broken of all the VIM autocomplete plugins. The good thing is it generally works, the bad thing is that sometimes the daemon that powers it sometimes dies and you have to restart VIM. I'm currently open to suggestions on an alternative that doesn't have this bug.

### tmux

* The first pane/session you open in tmux doesn't get correctly attached to the clipboard. All subsequent panes get added correctly, so you can just open a new split and close the first one to fix. See [this bug](https://github.com/square/maximum-awesome/issues/124) on maximum-awesome.

## Todo

* Shell script for installing dependencies
* zsh config
* Powerline on the shell - powerline-shell vs powerline vs oh-my-zsh-powerline
