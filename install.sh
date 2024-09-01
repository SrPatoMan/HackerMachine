#!/bin/bash

echo -e "\n####### By Manuel Ramos (a.k.a SrPatoMan) #######\n"
echo -e "\n[+] INICIANDO INSTALACIÓN DEL ESTUDIO\n\n"
echo -e "[+] ACTUALIZANDO EL SISTEMA\n\n"
sleep 3
sudo apt update && sudo apt upgrade -y

echo -e "\n\n\n[+] INSTALANDO PAQUETES BASICOS...\n\n\n"
sleep 3
sudo apt install neofetch zsh git curl wget flatpak net-tools kitty bat lsd golang nmap wireshark netcat-traditional openjdk-11-jre zip -y

echo -e "\n\n\n[+] ¿ESTAS USANDO GNOME? (y/n)(pulsa n sino lo sabes):\n" 
read gnome_respuesta
gnome_respuesta=$(echo "$gnome_respuesta" | tr '[:upper:]' '[:lower:]')
echo $gnome_respuesta
if [ $gnome_respuesta == 'y' ];then
echo -e "[+] Instalando GNOME Tweaks...\n"
sudo apt install gnome-tweaks -y
else
:
fi

echo -e "\n\n\n[+] INSTALANDO SPOTIFY...\n\n"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client


echo -e "\n\n\n[+] INSTALANDO BURPSUITE...\n\n"

wget "https://portswigger.net/burp/releases/download?product=community&version=2024.7.5&type=jar" -O burpsuite_community.jar
sudo chmod +x burpsuite_community.jar
java -jar burpsuite_community.jar
sudo rm burpsuite_community.jar

echo -e "\n\n[+] INSTALANDO HERRAMIENTAS PENTESTING\n"

echo -e "[+] AQUATONE\n\n\n"
wget "https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip"
unzip aquatone_linux_amd64_1.7.0.zip
sudo mv aquatone /usr/bin/
rm LICENSE.txt README.md aquatone_linux_amd64_1.7.0.zip

echo -e "\n\n[+] WAYBACKURLS\n\n\n"
go install github.com/tomnomnom/waybackurls@latest
sudo mv go/bin/waybackurls /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] GAU\n\n\n"
go install github.com/lc/gau/v2/cmd/gau@latest
sudo mv go/bin/gau /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] SUBFINDER\n\n\n"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo mv go/bin/subfinder /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] HTTPROBE\n\n\n"
git clone https://github.com/tomnomnom/httprobe
cd httprobe
go build main.go
mv main httprobe
sudo mv httprobe /usr/bin
cd ..;sudo rm -r httprobe

echo -e "\n\n[+] HTTPX\n\n\n"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
sudo mv go/bin/httpx /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] NUCLEI\n\n\n"
sudo go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
sudo mv go/bin/nuclei /usr/bin
sudo rm -rf go/

## Wallpapers ##

echo -e "\n\n[+] INSTALANDO FONDOS DE PANTALLA\n\n\n"
sudo git clone https://github.com/SrPatoMan/MaquinaCustom/
sudo mv MaquinaCustom/wallpapers /usr/share/backgrounds/

## Configuracion Kitty ##
echo -e "\n\n[+] CONFIGURANDO LA KITTY\n\n\n"
mkdir $HOME/.config/kitty
sudo mv MaquinaCustom/kitty_and_zsh_conf/kitty/kitty.conf $HOME/.config/kitty/
sudo mv MaquinaCustom/kitty_and_zsh_conf/kitty/color.ini $HOME/.config/kitty/
sudo mv MaquinaCustom/kitty_and_zsh_conf/zshrc $HOME/.zshrc
