#=================================================
# https://github.com/P3TERX/Gitpod-OpenWrt
# Description: OpenWrt build environment in Gitpod
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

FROM p3terx/openwrt-build-env:18.04

LABEL maintainer P3TERX

USER root

RUN apt-get update -qqy && \
    apt-get upgrade -qqy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    useradd -l -u 33333 -G sudo -m -s /usr/bin/zsh gitpod && \
    echo 'gitpod:gitpod' | chpasswd && \
    echo 'gitpod ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/gitpod

USER gitpod

WORKDIR /home/gitpod

RUN sudo echo "Running 'sudo' for Gitpod: success"

RUN mkdir -p ~/.antigen && \
    curl -fsSL git.io/antigen > ~/.antigen/antigen.zsh && \
    curl -fsSL https://raw.githubusercontent.com/P3TERX/dotfiles/master/.zshrc > ~/.zshrc && \
    curl -fsSL git.io/oh-my-tmux.sh | bash && \
    mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh && \
    zsh ~/.zshrc && \
    echo "bash -c zsh" >> ~/.bashrc
