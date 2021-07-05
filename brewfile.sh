#!/bin/bash

set -e

brew install \
  ffmpeg fish fnm fx fzf \
  gcc ghq gibo git git-flow git-lfs \
  htop hub \
  imagemagick \
  jq \
  lab lazydocker lazygit \
  neovim node \
  python \
  ripgrep rsync \
  tig tmux tokei translate-shell tree \
  zsh


# GNU utils
brew install \
  binutils coreutils diffutils findutils moreutils \
  gawk gzip gnu-tar gnu-sed gnu-time gnu-getopt


if test "$(uname)" == "Darwin"; then
  brew install \
    cocoapods
fi

