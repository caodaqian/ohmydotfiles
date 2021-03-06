#!/bin/sh
##########################################
## @Author      : caodaqian
## @CreateTime  : 2020-11-08 13:57:58
## @LastEditors : caodaqian
## @LastEditTime: 2020-12-03 16:18:32
## @Description : install and sync config for tmux
##########################################

set -e
WORKDIR=$(dirname $(dirname $(readlink -f "$0")))

## install tmux
if [[ -z "$(tmux -V 2>/dev/null)" ]]; then
    echo "check not install tmux, then will install tmux secondly"
    git clone https://github.com/tmux/tmux.git
    sh tmux/autogen.sh
    ./tmux/configure && make && sudo make install
    rm -rf ./tmux
fi

## sync tmux.conf.local
if [[ ! -d ${HOME}/.tmux ]]; then
    echo "install oh-my-tmux"
    git clone https://github.com/gpakosz/.tmux.git ${HOME}/.tmux
    ln -s -f ${HOME}/.tmux/.tmux.conf ${HOME}/.tmux.conf
    cp ${WORKDIR}/tmux/tmux.conf.local ${HOME}/.tmux.conf.local
fi

## install tpm
if [[ ! -d ${HOME}/.tmux/plugins/tpm ]]; then
    echo "install tpm"
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
fi
