#!/bin/bash

HOST_ADDRESS="mc.example.com" # Cloudflare Tunnelのホスト名。例: mc.example.com
PORT=25565 # localhostでアクセス出来るMinecraftサーバーのポート番号。

LOG_NAME="mc_server"

CLOUDFLARED_PKG_URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-arm64.pkg"

# cloudflaredがインストールされているか確認して、なければインストールする
if ! command -v cloudflared &> /dev/null; then
  echo -e "\e[0;34m[$LOG_NAME]\e[0m cloudflaredをインストールします。"
  if command -v brew &> /dev/null; then
    echo -e "\e[0;34m[$LOG_NAME]\e[0m Homebrew経由でインストールします。"
    brew install cloudflared
  else
    echo -e "\e[0;34m[$LOG_NAME]\e[0m インストーラ形式でインストールします。"
    cd $(mktemp -d)
    curl -fL -O $CLOUDFLARED_PKG_URL
    echo -e "\e[0;34m[$LOG_NAME]\e[0m パスワードの入力が求められるから入力してください。"
    sudo installer -pkg cloudflared-arm64.pkg -target /
  fi

  if ! command -v cloudflared &> /dev/null; then
    echo -e "\e[0;34m[$LOG_NAME]\e[31m cloudflaredのインストールに失敗しました... 手動でインストールしてください。\e[0m"
    exit 1
  fi
  echo -e "\e[0;34m[$LOG_NAME]\e[32m cloudflaredのインストールに成功しました。\e[0m"
fi

cd ~
echo -e "\e[0;34m[$LOG_NAME]\e[0m Cloudflare Tunnelを起動します。"
echo -e "\e[0;34m[$LOG_NAME]\e[0m minecraftで\e[1;33mlocalhost:$PORT\e[0mに接続してください。"
cloudflared access tcp --hostname $HOST_ADDRESS --url localhost:$PORT
