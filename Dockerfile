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

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended && \
    git clone git://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    echo "autoload -U compinit && compinit" >> ~/.zshrc && \
    sed -i '/^ZSH_THEME=/c\ZSH_THEME="ys"' ~/.zshrc && \
    sed -i '/^plugins=/c\plugins=(git sudo z command-not-found zsh-syntax-highlighting zsh-autosuggestions zsh-completions)' ~/.zshrc && \
    curl -fsSL git.io/oh-my-tmux.sh | bash && \
    mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh
