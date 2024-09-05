#!/bin/bash

echo -e "\n####### By Manuel Ramos (a.k.a SrPatoMan) #######\n"
echo -e "\n[+] INICIANDO INSTALACIÓN DEL ENTORNO\n\n"
echo -e "[+] ACTUALIZANDO EL SISTEMA\n\n"
sleep 4
sudo apt update && sudo apt upgrade -y

echo -e "\n\n\n[+] INSTALANDO PAQUETES BASICOS...\n\n\n"
sleep 3
sudo apt install neofetch zsh git curl wget flatpak net-tools kitty bat lsd golang nmap wireshark netcat-traditional openjdk-21-jre zip python3 python3-pip pipx -y

echo -e "\n\n\n[+] ¿ESTAS USANDO GNOME? (y/n)(pulsa n sino lo sabes):\n" 
read gnome_respuesta
gnome_respuesta=$(echo "$gnome_respuesta" | tr '[:upper:]' '[:lower:]')
if [ $gnome_respuesta == 'y' ];then
echo -e "[+] Instalando GNOME Tweaks...\n"
sudo apt install gnome-tweaks -y
else
:
fi
########## FUNCION PARA INSTALAR HERRAMIENTAS SEGUN OS ###########

hacking_tools_repo() {

echo -e "\n\n[+] INSTALANDO HERRAMIENTAS PENTESTING\n"
sleep 3

echo -e "\n\n[+] DIRSEARCH\n\n"
git clone "https://github.com/maurosoria/dirsearch.git"
cd dirsearch/ || { echo "Error al cambiar al directorio dirsearch"; sleep 3; } 
pipx install dirsearch
pipx ensurepath
source ~/.local/share/pipx/venvs/dirsearch/bin/activate
pipx runpip dirsearch install setuptools
rm -rf $PWD/dirsearch/

echo -e "\n\n[+] SUBFINDER\n\n\n"
sleep 1
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo mv go/bin/subfinder /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] HTTPX\n\n\n"
sleep 1
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
sudo mv go/bin/httpx /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] NUCLEI\n\n\n"
sleep 1
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
sudo mv go/bin/nuclei /usr/bin
sudo rm -rf go/

}

## Comprobando si se esta instalando en un kali ##

kali_comprobacion=$(cat /etc/os-release | head -n 1 | cut -d '=' -f 2 | tr -d '"')

if [ $kali_comprobacion == 'Kali GNU/Linux Rolling' ];then
sudo apt install subfinder dirsearch nuclei -y
else
hacking_tools_repo
fi



echo -e "\n\n\n[+] INSTALANDO BURPSUITE...\n\n"

wget "https://portswigger.net/burp/releases/download?product=community&version=2024.7.5&type=jar" -O burpsuite_community.jar
sudo chmod +x burpsuite_community.jar
java -jar burpsuite_community.jar
sudo rm burpsuite_community.jar

echo -e "\n\n\n[+] INSTALANDO POSTMAN...\n\n"
wget "https://dl.pstmn.io/download/latest/linux_64" -o postman.tar.gz
sudo tar -xzf postman.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman


echo -e "\n\n[+] INSTALANDO HERRAMIENTAS PENTESTING\n"
sleep 3

echo -e "[+] AQUATONE\n\n\n"
sleep 1
wget "https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip"
unzip aquatone_linux_amd64_1.7.0.zip
sudo mv aquatone /usr/bin/
rm LICENSE.txt README.md aquatone_linux_amd64_1.7.0.zip

echo -e "\n\n[+] WAYBACKURLS\n\n\n"
sleep 1
go install github.com/tomnomnom/waybackurls@latest
sudo mv go/bin/waybackurls /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] GAU\n\n\n"
sleep 1
go install github.com/lc/gau/v2/cmd/gau@latest
sudo mv go/bin/gau /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] HTTPROBE\n\n\n"
sleep 1
git clone https://github.com/tomnomnom/httprobe
cd httprobe
go build main.go
mv main httprobe
sudo mv httprobe /usr/bin
cd ..;sudo rm -r httprobe

echo -e "\n\n[+] HAKRAWLER\n\n\n"
sleep 1
go install github.com/hakluke/hakrawler@latest
sudo mv go/bin/hakrawler /usr/bin
sudo rm -rf go/

### HERRAMIENTAS PENTESTING ANDROID ###
echo -e "\n\n\n[+] INSTALANDO HERRAMIENTAS DE ANDROID HACKING..."
sleep 3

echo -e "\n\n\n[+] DEX2JAR"
sleep 1
wget "https://github.com/pxb1988/dex2jar/archive/refs/tags/v2.4.tar.gz"
tar -xzf v2.4.tar.gz
dex2jar-2.4/./gradlew build


## Wallpapers ##

echo -e "\n\n[+] INSTALANDO FONDOS DE PANTALLA\n\n\n"
sleep 1
sudo git clone https://github.com/SrPatoMan/MaquinaCustom/
sudo rm -f /usr/share/backgrounds/*
sudo mv MaquinaCustom/wallpapers/* /usr/share/backgrounds/

## Configurando Firefox ##

ruta_profiles=$HOME/.mozilla/firefox/profiles.ini
perfil_usuario=$(cat $ruta_profiles | grep "Path" | grep "default-esr" | cut -d '=' -f 2)
ruta_archivo=$HOME/.mozilla/firefox/$perfil_usuario/chrome
mkdir -p $ruta_archivo
sudo mv MaquinaCustom/config_files/firefox/userChrome.css $ruta_archivo

## Configuracion Kitty ##
echo -e "\n\n[+] CONFIGURANDO LA KITTY\n\n\n"
sleep 1
mkdir $HOME/.config/kitty
sudo mv MaquinaCustom/kitty_and_zsh_conf/kitty/kitty.conf $HOME/.config/kitty/
sudo mv MaquinaCustom/kitty_and_zsh_conf/kitty/color.ini $HOME/.config/kitty/

## Configuracion nano ##
echo -e "\n\n[+] CONFIGURANDO NANO\n\n\n"
sleep 1
sudo mv MaquinaCustom/config_files/nanorc $HOME/.nanorc

### INSTALANDO Y CONFIGURANDO ZSH ###
echo -e "\n\n[+] INSTALANDO Y CONFIGURANDO ZSH\n\n"
sleep 1
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo rm $HOME/.zshrc
sudo mv MaquinaCustom/kitty_and_zsh_conf/zshrc $HOME/.zshrc

### AVISO ###
echo -e "\n\n[+]CONFIGURE LA SHELL AL ACABAR LA INSTALACION CON p10k configure\n"
echo -e "INSTALACION EN CURSO, NO TOCAR NADA AUN"
sudo rm -rf MaquinaCustom/
sleep 5

echo -e "\n\n\n¿ESTAS EN MAQUINA REAL (y/n)?"
read maquina_real
maquina_real=$(echo "$maquina_real" | tr '[:upper:]' '[:lower:]')
if [ $maquina_real == 'y' ];then
echo -e "\n\n\nINSTALANDO VIRTUAL BOX...\n\n"
sudo apt install virtualbox -y
wget "https://dl.genymotion.com/releases/genymotion-3.7.1/genymotion-3.7.1-linux_x64.bin"
chmod +x genymotion-3.7.1-linux_x64.bin
sudo ./genymotion-3.7.1-linux_x64.bin
sudo apt install adb
echo -e "\n\n\n[+] INSTALANDO SPOTIFY...\n\n"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client
else
:
fi


### COMPROBAR INSTALACION DE LAS HERRAMIENTAS ###

echo -e "\n\n\n[+] COMPROBANDO LA INSTALACION DE LAS HERRAMIENTAS...\n\n\n"
sleep 5

which burpsuite 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Burpsuite NO instalado\n"
else
echo -e "\n[+] BURPSUITE INSTALADO CON EXITO\n"
fi

which postman 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Postman NO instalado\n"
else
echo -e "\n[+] POSTMAN INSTALADO CON EXITO\n"
fi

which dirsearch 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Dirsearch NO instalado\n"
else
echo -e "\n[+] DIRSEARCH INSTALADO CON EXITO\n"
fi

which aquatone 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Aquatone NO instalado\n"
else
echo -e "\n[+] AQUATONE INSTALADO CON EXITO\n"
fi

which waybackurls 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Waybackurls NO instalado\n"
else
echo -e "\n[+] WAYBACKURLS INSTALADO CON EXITO\n"
fi

which gau 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Gau NO instalado\n"
else
echo -e "\n[+] GAU INSTALADO CON EXITO\n"
fi

which subfinder 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Subfinder NO instalado\n"
else
echo -e "\n[+] SUBFINDER INSTALADO CON EXITO\n"
fi

which httprobe 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Httprobe NO instalado\n"
else
echo -e "\n[+] HTTPROBE INSTALADO CON EXITO\n"
fi

which httpx 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Httpx NO instalado\n"
else
echo -e "\n[+] HTTPX INSTALADO CON EXITO\n"
fi

which nuclei 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Nuclei NO instalado\n"
else
echo -e "\n[+] NUCLEI INSTALADO CON EXITO\n"
fi

which hakrawler 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Hakrawler NO instalado\n"
else
echo -e "\n[+] HAKRAWLER INSTALADO CON EXITO\n"
fi

which d2j-dex2jar 1>/dev/null

if [ $? != 0 ];then
echo -e "\n[-] Dex2jar NO instalado\n"
else
echo -e "\n[+] DEX2JAR INSTALADO CON EXITO\n"
fi

echo -e "\n\n\n################### INSTALACION FINALIZADA ###################\n\n\n"
