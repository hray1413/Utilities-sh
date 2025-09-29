#!/bin/bash

# 檢查是否有 dialog

if ! command -v dialog &> /dev/null; then sudo pacman -Sy --noconfirm dialog fi

# 使用者選單

choices=$(dialog --checklist "選擇要安裝的工具：" 20 60 10 1 "Brave Browser" off 2 "Firefox" off 3 "LibreOffice" off 4 "Java (OpenJDK)" off 5 "7-Zip (p7zip)" off 6 "curl" off 7 "Minecraft Server" off 8 "Snappy Driver Installer (SDIO via Wine)" off 3>&1 1>&2 2>&3)

clear echo "你選擇了：$choices"

# 安裝對應工具

[[ $choices == "1" ]] && sudo pacman -Sy --noconfirm brave-bin [[ $choices == "2" ]] && sudo pacman -Sy --noconfirm firefox [[ $choices == "3" ]] && sudo pacman -Sy --noconfirm libreoffice-fresh [[ $choices == "4" ]] && sudo pacman -Sy --noconfirm jdk-openjdk [[ $choices == "5" ]] && sudo pacman -Sy --noconfirm p7zip [[ $choices == "6" ]] && sudo pacman -Sy --noconfirm curl

if [[ $choices == "7" ]]; then mkdir -p ~/MinecraftServer cd ~/MinecraftServer latest_hash=$(curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json | grep -oP '"url":\s*"\K+' | head -n 1 | xargs curl -s | grep -oP '"server":\s*"\K+') curl -O "$latest_hash" echo "eula=true" > eula.txt java -Xmx2G -Xms2G -jar server.jar nogui fi

if [[ $choices == "8" ]]; then echo "請使用系統內建的驅動管理工具進行安裝。" echo "例如：Settings → Hardware → Drivers 或使用 mhwd、modprobe 等指令。" fi

echo "所有選定工具已安裝完畢。儀式結束。"。"
