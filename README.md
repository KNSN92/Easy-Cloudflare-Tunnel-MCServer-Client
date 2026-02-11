# Easy Cloudflare Tunnel MCServer Client

Cloudflare Tunnel経由のminecraftサーバーへクライアント側が比較的容易に接続出来るようにする為のMacOS向けのシェルスクリプトです。\
cloudflaredコマンドがインストールされていない場合には自動でインストールする機能付きです。\
インストールする際にhomebrewがあればそちらを使います。賢いですね。

## どうやって使うの？これ

1. `mc_server.sh`の`HOST_ADDRESS="mc.example.com"`のURL部分を自分のホストアドレスに置き換えてください。
2. 「ターミナルを開いて`bash start.sh`って打って」というお願いと共に配布するだけです。
3. 出来ない！って報告があれば対処しましょう。
