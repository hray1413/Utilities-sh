#!/bin/bash

# 使用 AppleScript 彈窗選單
browser=$(osascript -e 'choose from list {"Brave", "Firefox", "Chrome"} with prompt "選擇要安裝的瀏覽器："')
office=$(osascript -e 'choose from list {"LibreOffice", "OnlyOffice"} with prompt "選擇要安裝的 Office 工具："')
tools=$(osascript -e 'choose from list {"Java", "curl", "7-Zip"} with prompt "選擇要安裝的工具："')
minecraft=$(osascript -e 'display dialog "是否安裝 Minecraft Server？" buttons {"是", "否"} default button "是"')

# 安裝 Homebrew（如未安裝）
if ! command -v brew &> /dev/null; then
  echo "安裝 Homebrew 中..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 安裝瀏覽器
case $browser in
  *Brave*) brew install --cask brave-browser ;;
  *Firefox*) brew install --cask firefox ;;
  *Chrome*) brew install --cask google-chrome ;;
esac

# 安裝 Office 工具
case $office in
  *LibreOffice*) brew install --cask libreoffice ;;
  *OnlyOffice*) brew install --cask onlyoffice ;;
esac

# 安裝工具
[[ $tools == *Java* ]] && brew install openjdk
[[ $tools == *curl* ]] && brew install curl
[[ $tools == *7-Zip* ]] && brew install p7zip

# Minecraft Server 架設
if [[ $minecraft == *是* ]]; then
  mkdir -p ~/MinecraftServer
  cd ~/MinecraftServer
  curl -O https://launcher.mojang.com/v1/objects/your_server_jar_hash/server.jar
  echo "eula=true" > eula.txt
  java -Xmx2G -Xms2G -jar server.jar nogui
fi

echo ""
echo "所有選定工具已安裝完畢。儀式結束。"
