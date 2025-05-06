#!/bin/bash

echo "[✔] Création de l'arborescence..."
mkdir -p loult-twitch-bridge/{bot,config,data/logs}

echo "[✔] Création du fichier .env"
touch loult-twitch-bridge/config/.env

echo "[✔] Création du requirements.txt"
cat <<EOL > loult-twitch-bridge/requirements.txt
selenium
websocket-client
requests
python-dotenv
EOL

echo "[✔] Création du main.py avec ouverture Twitch via Firefox"
cat <<EOF > loult-twitch-bridge/main.py
from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options
import time

options = Options()
options.add_argument("--width=1200")
options.add_argument("--height=800")

print("💬 Entrez le nom de la chaîne Twitch à ouvrir :")
channel = input("🔗 twitch.tv/")

# Lance Firefox
service = Service()
driver = webdriver.Firefox(service=service, options=options)
driver.get(f"https://www.twitch.tv/{channel}")

print(f"🎥 Fenêtre ouverte sur https://www.twitch.tv/{channel}")
print("💡 Connecte-toi manuellement si besoin. Le scraping commencera après ton login.")

# Garde la fenêtre ouverte
try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("👋 Fermeture...")
    driver.quit()
EOF

echo "[✔] Setup terminé ! Lancez-le avec :"
echo "    cd loult-twitch-bridge && python main.py"
