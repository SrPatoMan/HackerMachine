#!/bin/bash

verde_oscuro='\033[0;32m'
azul='\033[0;34m'
reset_color='\033[0m'


echo -e "${verde_oscuro}
██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ ███╗   ███╗ █████╗  ██████╗██╗  ██╗██╗███╗   ██╗███████╗
██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔════╝██║  ██║██║████╗  ██║██╔════╝
███████║███████║██║     █████╔╝ █████╗  ██████╔╝██╔████╔██║███████║██║     ███████║██║██╔██╗ ██║█████╗  
██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║██║     ██╔══██║██║██║╚██╗██║██╔══╝  
██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║██║██║ ╚████║███████╗
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝
${reset_color}
"                                                                                                       
echo -e "${azul}
 __      __   __                   
|__)    (_  _|__)_ |_ _ |\/| _  _  
|__)\/  __)| |  (_||_(_)|  |(_|| ) 
    /                              
${reset_color}
"
sleep 2
echo -e "\n\n\n[+] INICIANDO INSTALACIÓN DEL ENTORNO\n\n"
echo -e "[+] ACTUALIZANDO EL SISTEMA\n\n"
sleep 4
sudo apt update && sudo apt upgrade -y

echo -e "\n\n\n[+] INSTALANDO PAQUETES BASICOS...\n\n\n"
sleep 3
sudo apt install ssh adb neofetch zsh git curl wget flatpak net-tools kitty ripgrep gcc make bat gedit picom lsd golang nmap wireshark netcat-traditional chromium unrar whatweb openjdk-21-jre zip python3 python3-pip python3-setuptools pipx cmatrix bspwm sxhkd build-essential cmake pkg-config polybar libxcb1-dev libxcb-xkb-dev libxcb-randr0-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-ewmh-dev libxcb-xrm0 libxcb-xrm-dev libx11-xcb-dev libxft-dev libfontconfig1-dev python3-sphinx libcairo2-dev libfontconfig1-dev libasound2-dev libcurl4-openssl-dev libmpdclient-dev libiw-dev libpulse-dev libxcb-composite0-dev xcb-proto python3-xcbgen libjsoncpp-dev libjsoncpp-dev -y

## Adivinando la interfaz del usuario ##
entorno_grafico=$(echo $XDG_CURRENT_DESKTOP)
if [[ $entorno_grafico == 'ubuntu:GNOME' || $entorno_grafico == 'GNOME' ]];then
sudo apt install gnome-tweaks -y
else
:
fi
########## FUNCION PARA INSTALAR HERRAMIENTAS SEGUN OS ###########

hacking_tools() {

echo -e "\n\n[+] INSTALANDO HERRAMIENTAS PENTESTING\n"
sleep 3

echo -e "\n\n[+] DIRSEARCH\n\n"
git clone "https://github.com/maurosoria/dirsearch.git"
cd dirsearch/
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

echo -e "\n\n\n[+] BURPSUITE...\n\n"

wget "https://portswigger.net/burp/releases/download?product=community&version=2024.7.5&type=jar" -O burpsuite_community.jar
sudo chmod +x burpsuite_community.jar
java -jar burpsuite_community.jar
sudo rm burpsuite_community.jar

#echo -e "\n\n\n[+] GOSPIDER...\n\n"

#echo -e "\n\n\n[+] ARJUN...\n\n"

#echo -e "\n\n\n[+] AMASS...\n\n"

#echo -e "\n\n\n[+] ASSETFINDER...\n\n"

#echo -e "\n\n\n[+] JADX...\n\n"

#echo -e "\n\n\n[+] FFUF...\n\n"

}

parrot_tools() {

echo -e "\n\n[+] SUBFINDER\n\n\n"
sleep 1
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo mv go/bin/subfinder /usr/bin
sudo rm -rf go/

}

## Comprobando del os donde se esta instalando ##

os_comprobacion=$(cat /etc/os-release | head -n1 | cut -d '=' -f 2 | tr -d '"' | cut -d " " -f 1)

if [ "$os_comprobacion" == "Kali" ]; then
echo -e "\n\n[+] INSTALANDO HERRAMIENTAS PENTESTING\n"
sleep 3
sudo apt install subfinder fuse dirsearch nuclei wfuzz gospider arjun amass assetfinder jadx ffuf apktool -y
elif [ $os_comprobacion == 'Parrot' ];then
echo -e "\n\n[+] INSTALANDO HERRAMIENTAS PENTESTING\n"
sleep 3
sudo apt install dirsearch fuse nuclei wfuzz gospider arjun assetfinder jadx ffuf apktool -y
## En el repo de Parrot hay herramientas que no estan mientra que en Kali si, esta funcion contiene las herramientas hace falta instalar a mano en Parrot OS ##
parrot_tools
else
sudo apt install wfuzz
hacking_tools
fi

## Instalar visual studio code##
echo -e "\n\n\n[+] INSTALANDO VSCODE...\n\n"
wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo mv 'download?build=stable&os=linux-deb-x64' code-deb-x64
sudo dpkg -i code-deb-x64
sudo rm code-deb-x64

## Instalar postman ##
echo -e "\n\n\n[+] INSTALANDO POSTMAN...\n\n"
wget "https://dl.pstmn.io/download/latest/linux_64"
sudo mv linux_64 linux_64.tar.gz
sudo tar -xzf linux_64.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman

## Xmind ##
wget "https://www.xmind.app/zen/download/linux_deb/"
mv index.html xmind.deb
sudo dpkg -i xmind.deb
mkdir -p $HOME/.local/xmind

## Herramientas hacking ##
echo -e "[+] EYEWITNESS\n\n\n"
sleep 1
git clone https://github.com/RedSiege/EyeWitness/
sudo ./EyeWitness/Python/setup/setup.sh

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

echo -e "\n\n[+] LOSTSEC\n\n\n"
sleep 1
wget 'https://raw.githubusercontent.com/coffinsp/lostools/refs/heads/main/lostsec.py'
sudo chmod +x lostsec.py
sudo mv lostsec.py /usr/bin

echo -e "\n\n[+] URO\n\n\n"
sleep 1
pipx install uro
sudo mv $HOME/.local/bin/uro /usr/bin

echo -e "\n\n[+] WAYMORE\n\n\n"
sleep 1
pipx install waymore

echo -e "\n\n[+] SUBZY\n\n\n"
sleep 1
go install -v github.com/PentestPad/subzy@latest
sudo mv go/bin/subzy /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] SHORTSCAN\n\n\n"
sleep 1
go install github.com/bitquark/shortscan/cmd/shortscan@latest
sudo mv go/bin/shortscan /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] GF\n\n\n"
sleep 1
go install github.com/tomnomnom/gf@latest
sudo mv go/bin/gf /usr/bin 
sudo rm -rf go/

echo -e "\n\n[+] KATANA\n\n\n"
sleep 1
go install github.com/projectdiscovery/katana/cmd/katana@latest
sudo mv go/bin/katana /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] QSREPLACE\n\n\n"
sleep 1
go install github.com/tomnomnom/qsreplace@latest
sudo mv go/bin/qsreplace /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] AIRIXSS\n\n\n"
sleep 1
go install github.com/ferreiraklet/airixss@latest
sudo mv go/bin/airixss /usr/bin
sudo rm -rf go/

echo -e "\n\n[+] FUZZULI\n\n\n"
sleep 1
go install -v github.com/musana/fuzzuli@latest
sudo mv go/bin/fuzzuli /usr/bin
sudo rm -rf go/


echo -e "\n\n[+] SECRETFINDER\n\n\n"
sleep 1
git clone https://github.com/m4ll0k/SecretFinder.git secretfinder
sudo chmod +x secretfinder/SecretFinder.py
sudo mv secretfinder/SecretFinder.py /usr/bin

#####echo -e "\n\n[+] CORSY\n\n\n"

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
sudo git clone 'https://github.com/SrPatoMan/HackerMachine/'
sudo rm -rf /usr/share/backgrounds/*
sudo rm -rf /usr/share/wallpapers/*
sudo cp HackerMachine/wallpapers/* /usr/share/backgrounds/
sudo mv HackerMachine/wallpapers/* /usr/share/wallpapers/

## Instalando wordlists ##
echo -e "\n\n[+] INSTALANDO DICCIONARIOS\n\n\n"
sleep 1
ruta_wordlist1=$HOME/wordlists/payloads/xss_cheat_sheets
ruta_wordlist2=$HOME/wordlists/discovery
ruta_wordlist3=$HOME/wordlists/payloads/sqli
ruta_wordlist4=$HOME/wordlists/payloads/lfi
ruta_wordlist5=$HOME/wordlists/payloads/redirect
ruta_wordlist6=$HOME/wordlists/file_leaks
ruta_wordlist_idiomas=$HOME/wordlists/idiomas

mkdir -p $ruta_wordlist1
mkdir -p $ruta_wordlist2
mkdir -p $ruta_wordlist3
mkdir -p $ruta_wordlist4
mkdir -p $ruta_wordlist5
mkdir -p $ruta_wordlist6
mkdir -p $ruta_wordlist_idiomas


sudo mv HackerMachine/xss_cheat_sheet/* $ruta_wordlist1
wget 'https://raw.githubusercontent.com/coffinsp/lostools/refs/heads/main/xss.txt'
sudo mv xss.txt $ruta_wordlist1/xss_payloads2.txt
wget 'https://raw.githubusercontent.com/coffinsp/lostools/refs/heads/main/xsspollygots.txt'
sudo mv xsspollygots.txt $ruta_wordlist1/xss_payloads3.txt
git clone 'https://github.com/coffinsp/payloads' $HOME/wordlists/payloads/payloads
git clone 'https://github.com/coffinsp/lostools/tree/main/payloads'
sudo mv payloads $ruta_wordlist3
wget 'https://raw.githubusercontent.com/coffinsp/lostools/refs/heads/main/lfi.txt'
sudo mv lfi.txt $ruta_wordlist4
wget 'https://raw.githubusercontent.com/coffinsp/lostools/refs/heads/main/redirect.txt'
sudo mv redirect.txt $ruta_wordlist5
wget 'https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/big-list-of-naughty-strings.txt'
wget 'https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/CMS/wordpress.fuzz.txt'
wget 'https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/CMS/wp-plugins.fuzz.txt'
wget 'https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-medium.txt'
wget 'https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-big.txt'
wget 'https://raw.githubusercontent.com/SrPatoMan/bbtips/refs/heads/main/wordlists/bbtips.txt'
wget 'https://raw.githubusercontent.com/dkcyberz/Harpy/refs/heads/main/Hidden/database.txt'
wget 'https://wordlists-cdn.assetnote.io/data/automated/httparchive_subdomains_2024_05_28.txt'
sudo mv big-list-of-naughty-strings.txt $ruta_wordlist2
sudo mv wordpress.fuzz.txt $ruta_wordlist2
sudo mv wp-plugins.fuzz.txt $ruta_wordlist2
sudo mv directory-list-2.3-medium.txt $ruta_wordlist2
sudo mv directory-list-2.3-big.txt $ruta_wordlist2
sudo mv bbtips.txt $ruta_wordlist6
sudo mv database.txt $ruta_wordlist6
sudo mv zipfiles.txt $ruta_wordlist6
sudo mv httparchive_subdomains_2024_05_28.txt $ruta_wordlist2
git clone https://github.com/0xPugal/fuzz4bounty
sudo mv fuzz4bounty/fuzz4bounty $HOME/wordlists/file_leaks
sudo rm -rf fuzz4bounty
git clone 'https://github.com/gurkylee/Wordlist-Collection/'
sudo mv Wordlist-Collection/languages/* $ruta_wordlist_idiomas
sudo rm -rf Wordlist-Collection/

## Configurando Firefox ##

ruta_profiles=$HOME/.mozilla/firefox/profiles.ini
perfil_usuario=$(cat $ruta_profiles | grep "Path" | grep "default-esr" | cut -d '=' -f 2)
ruta_archivo=$HOME/.mozilla/firefox/$perfil_usuario/chrome
mkdir -p $ruta_archivo
sudo mv HackerMachine/config_files/firefox/userChrome.css $ruta_archivo
sudo mv HackerMachine/config_files/firefox/custom_firefox.rar .
unrar x custom_firefox.rar

## INSTALACION NEOVIM con NVCHAD + Prerrequisitos ##
wget 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip'
sudo unzip Hack.zip
sudo mv *.ttf /usr/share/fonts
sudo rm Hack.zip LICENSE.md README.md

wget 'https://github.com/neovim/neovim/releases/download/v0.10.0/nvim.appimage'
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/starter ~/.config/nvim

## Configurar BSPWM ##
mkdir -p ~/.config/bspwm ~/.config/sxhkd
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
chmod +x ~/.config/bspwm/bspwmrc
echo "exec bspwm" >> ~/.xinitrc


## Configuracion Kitty ##
echo -e "\n\n[+] CONFIGURANDO LA KITTY\n\n\n"
sleep 1
mkdir $HOME/.config/kitty
sudo mv HackerMachine/kitty_and_zsh_conf/kitty/kitty.conf $HOME/.config/kitty/
sudo mv HackerMachine/kitty_and_zsh_conf/kitty/color.ini $HOME/.config/kitty/
mkdir -p $HOME/.powerlevel10k/powerlevel10k.zsh-theme

## Configuracion nano ##
echo -e "\n\n[+] CONFIGURANDO NANO\n\n\n"
sleep 1
sudo mv HackerMachine/config_files/nanorc $HOME/.nanorc

### INSTALANDO Y CONFIGURANDO ZSH ###
echo -e "\n\n[+] INSTALANDO Y CONFIGURANDO ZSH\n\n"
sleep 1
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo rm $HOME/.zshrc
sudo mv HackerMachine/kitty_and_zsh_conf/zshrc $HOME/.zshrc

### AVISO ###
echo -e "\n\n[+]CONFIGURE LA SHELL AL ACABAR LA INSTALACION CON p10k configure\n"
echo -e "INSTALACION EN CURSO, NO TOCAR NADA AUN"
sudo rm -rf HackerMachine/
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
echo -e "\n\n\n[+] INSTALANDO SPOTIFY...\n\n"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.Client
else
:
fi


### COMPROBAR INSTALACION DE LAS HERRAMIENTAS ###

echo -e "\n\n\n[+] COMPROBANDO LA INSTALACION DE LAS HERRAMIENTAS...\n\n\n"
sleep 5

comprobar_instalacion() {

herramienta=$1
herramienta_mayusculas=$2

which $herramienta 1>/dev/null
if [ $? != 0 ]; then
echo -e "\n[-] $herramienta_mayusculas NO INSTALADO\n"
else
echo -e "\n[+] $herramienta_mayusculas INSTALADO CON ÉXITO\n"
fi
}

comprobar_instalacion "eyewitness" "EYEWITNESS"
comprobar_instalacion "dirsearch" "DIRSEARCH"
comprobar_instalacion "wfuzz" "WFUZZ"
comprobar_instalacion "burpsuite" "BURPSUITE"
comprobar_instalacion "nuclei" "NUCLEI"
comprobar_instalacion "httpx" "HTTPX"
comprobar_instalacion "subfinder" "SUBFINDER"
comprobar_instalacion "postman" "POSTMAN"
comprobar_instalacion "waybackurls" "WAYBACKURLS"
comprobar_instalacion "gau" "GAU"
comprobar_instalacion "httprobe" "HTTPROBE"
comprobar_instalacion "hakrawler" "HAKRAWLER"
comprobar_instalacion "lostsec.py" "LOSTSEC"
comprobar_instalacion "d2j-dex2jar" "DEX2JAR"
comprobar_instalacion "uro" "URO"
comprobar_instalacion "arjun" "ARJUN"
comprobar_instalacion "amass" "AMASS"
comprobar_instalacion "waymore" "WAYMORE"
comprobar_instalacion "subzy" "SUBZY"
comprobar_instalacion "shortscan" "SHORTSCAN"
comprobar_instalacion "jadx" "JADX"
comprobar_instalacion "ffuf" "FFUF"
comprobar_instalacion "gf" "GF"
comprobar_instalacion "katana" "KATANA"
comprobar_instalacion "qsreplace" "QSREPLACE"
comprobar_instalacion "airixss" "AIRIXSS"
comprobar_instalacion "xmind" "XMIND"
comprobar_instalacion "secretfinder" "SECRETFINDER"
comprobar_instalacion "apktool" "APKTOOL"
comprobar_instalacion "fuzzuli" "FUZZULI"

rm genymotion-3.7.1-linux_x64.bin linux_64.tar.gz v2.4.tar.gz xmind.deb

echo -e "\n\n\n################### INSTALACION FINALIZADA ###################\n\n\n"
