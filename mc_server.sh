#!/bin/bash

HOST_ADDRESS="mc.example.com" # Cloudflare Tunnelのホスト名。例: mc.example.com
PORT=25565 # localhostでアクセス出来るMinecraftサーバーのポート番号。

LOG_NAME="mc_server"

CLOUDFLARED_PKG_URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-arm64.pkg"

# cloudflaredがインストールされているか確認して、なければインストールする
if ! command -v cloudflared &> /dev/null; then
  printf "\033[0;34m[$LOG_NAME]\033[0m cloudflaredをインストールするよ〜\n"
  if command -v brew &> /dev/null; then
    printf "\033[0;34m[$LOG_NAME]\033[0m Homebrewがあるからそっちでインストールするよ〜\n"
    brew install cloudflared
  else
    printf "\033[0;34m[$LOG_NAME]\033[0m インストーラ形式でインストールするよ〜\n"
    cd $(mktemp -d)
    curl -fL -O $CLOUDFLARED_PKG_URL
    printf "\033[0;34m[$LOG_NAME]\033[0m パスワードの入力が求められるから入力してね〜\n"
    sudo installer -pkg cloudflared-arm64.pkg -target /
  fi

  if ! command -v cloudflared &> /dev/null; then
    printf "\033[0;34m[$LOG_NAME]\033[31m cloudflaredのインストールに失敗しました...\033[0m\n"
    exit 1
  fi
  printf "\033[0;34m[$LOG_NAME]\033[32m cloudflaredのインストールに成功したよ〜\033[0m\n"
fi

cd ~
printf "\033[0;34m[$LOG_NAME]\033[0m Cloudflare Tunnelを起動するよ〜\n"
printf "\033[0;34m[$LOG_NAME]\033[0m minecraftで\033[1;33mlocalhost:$PORT\033[0mに接続してね〜\n"
cloudflared access tcp --hostname $HOST_ADDRESS --url localhost:$PORT
