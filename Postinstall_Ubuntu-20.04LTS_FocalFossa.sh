#!/bin/bash
#v1.0.6

# Script de post-installation pour "Ubuntu 20.04LTS Focal Fossa"

# Code couleur
rouge='\e[1;31m'
jaune='\e[1;33m' 
bleu='\e[1;34m' 
violet='\e[1;35m' 
vert='\e[1;32m'
neutre='\e[0;m'

# Vérification que le script n'est pas lancé directement avec sudo (le script contient déjà les sudos pour les actions lorsque c'est nécessaire)
if [ "$UID" -eq "0" ]
then
    echo -e "${rouge}Merci de ne pas lancer directement ce script avec les droits root : lancez le sans sudo (./Postinstall_Ubuntu-20.04LTS_FF.sh), le mot de passe sera demandé dans le terminal lors de la 1ère action nécessitant le droit administrateur.${neutre}"
    exit
fi

MY_DIR=$(dirname $0)
. $MY_DIR/Config_Function.sh
. $MY_DIR/Zenity_default_choice.sh

# Placement dans /tmp
cd /tmp

if [ $? = 0 ]
then
    	# Debut
	f_action_exec "$CA_PARTNER" "sudo sed -i.bak '/^# deb .*partner/ s/^# //' /etc/apt/sources.list"
	f_action_exec "$CA_UPGRADE" "sudo apt update || read -p 'Attention, la commande de mise à jour (apt update) renvoi une erreur, il est recommandé de stopper le script et de corriger le problème avant de le lancer mais si vous voulez quand même poursuivre, tapez entrée' ; sudo apt full-upgrade -y" "$NS_UPGRADE"
	f_action_install "$CA_PACKUTILE" "net-tools curl vim neofetch ncdu x264 x265 xterm inxi hdparm cpu-x"
    
    	# Sessions
    	f_action_install "$CA_GNOMEVANILLA" gnome-session
    	f_action_install "$CA_GNOMECLASSIC" gnome-shell-extensions
    	f_action_install "$CA_GNOMEFLASHBACKM" gnome-session-flashback
    	f_action_install "$CA_GNOMEFLASHBACKC" "gnome-session-flashback compiz compizconfig-settings-manager compiz-plugins compiz-plugins-extra"
    	f_action_install "$CA_UNITY" "unity-session unity-tweak-tool compiz --no-install-recommends" #Pour ne pas avoir des paquets inutiles de Cinnamon en +
    
   	# Navigateurs
    	f_action_snap_install "$CA_BEAKER" beaker-browser
    	f_RepositoryExt_Install "$CA_BRAVE" "brave-browser" "https://s3-us-west-2.amazonaws.com/brave-apt/keys.asc" "[arch=amd64] https://s3-us-west-2.amazonaws.com/brave-apt bionic main" "brave"
    	f_action_install "$CA_CHROMIUM" "chromium-browser chromium-browser-l10n"
    	f_action_snap_install "$CA_CLIQZ" "cliqz --beta"
    	f_action_install "$CA_DILLO" dillo
    	f_action_flatpak_install "$CA_EOLIE" org.gnome.Eolie
    	f_action_install "$CA_FALKON" falkon
   	f_action_ppa_install "$CA_FIREFOXBETA" ppa:mozillateam/firefox-next "firefox firefox-locale-fr"
   	f_action_LinInstall "$CA_FIREFOXDEVELOPER" FirefoxDeveloperEdition
   	f_action_ppa_install "$CA_FIREFOXESR" ppa:mozillateam/ppa "firefox-esr firefox-esr-locale-fr"
   	f_action_exec "$CA_FIREFOXESR" "sudo sed -i -e 's/focal/eoan/g' /etc/apt/sources.list.d/mozillateam-ubuntu-ppa*list ; sudo apt update" #(ligne temporaire en attendant que le ppa pr 20.04 soit actif)
   	f_action_install "$CA_FIREFOXESR" "firefox-esr firefox-esr-locale-fr"
   	f_action_ppa_install "$CA_FIREFOXNIGHTLY" ppa:ubuntu-mozilla-daily/ppa firefox-trunk 	
    	f_action_install "$CA_EPIPHANY" epiphany-browser	
    	f_RepositoryExt_Install "$CA_CHROME" "google-chrome" "https://dl-ssl.google.com/linux/linux_signing_key.pub" "[arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" "google-chrome-stable"
    	f_action_install "$CA_LYNX" lynx
   	f_action_install "$CA_MIDORI" midori
    	f_action_get "$CA_MIN" "https://github.com/minbrowser/min/releases/download/v1.11.2/min_1.11.2_amd64.deb"
    	f_action_snap_install "$CA_OPERA" opera
    	f_action_get "$CA_PALEMOON" "http://downloadcontent.opensuse.org/repositories/home:/stevenpusser/xUbuntu_19.10/amd64/palemoon_28.8.0+repack-1_amd64.deb"
    	f_action_get "$CA_SRWAREIRON" "http://www.srware.net/downloads/iron64.deb"
    	f_action_install "$CA_TORBROWSER" torbrowser-launcher  
    	f_action_get "$CA_VIVALDI" "https://downloads.vivaldi.com/stable/vivaldi-stable_2.9.1705.41-1_amd64.deb"

    	# Internet / Tchat / Messagerie / Téléchargement / Contrôle à distance
    	# (Section re-divisé en 3 parties cf Zenity_default_choice.sh)
    	f_RepositoryExt_Install "$CA_ANYDESK" "anydesk-stable" "https://keys.anydesk.com/repos/DEB-GPG-KEY" "http://deb.anydesk.com/ all main" "anydesk"
    	f_action_install "$CA_CLUSTERSSH" clusterssh
    	f_action_get_appimage "$CA_COZYDRIVE" "https://github.com/cozy-labs/cozy-desktop/releases/download/v3.17.0/Cozy-Drive-3.17.0-x86_64.AppImage"
    	f_action_install "$CA_DELUGE" deluge
	f_action_get "$CA_DISCORD" "https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb"
    	f_action_install "$CA_DROPBOX" nautilus-dropbox
	f_action_get "$CA_DUKTO" "https://download.opensuse.org/repositories/home:/colomboem/xUbuntu_16.04/amd64/dukto_6.0-1_amd64.deb" #{a reverifier}
    	f_action_exec "$CA_DWSERVICE" "wget https://www.dwservice.net/download/dwagent_x86.sh && chmod +x dwagent* && sudo ./dwagent_x86.sh ; rm dwagent*"
    	f_action_install "$CA_EISKALTDC" "eiskaltdcpp eiskaltdcpp-gtk3"
    	f_action_install "$CA_EMPATHY" empathy    
	f_action_install "$CA_EVOLUTION" evolution
	f_action_install "$CA_FILEZILLA" filezilla    
	f_action_get "$CA_FROSTWIRE" "https://prime.frostwire.com/frostwire/6.8.3/frostwire-6.8.3.amd64.deb"
   	f_action_install "$CA_GEARY" geary	
   	f_action_snap_install "$CA_GYDL" gydl
	f_action_install "$CA_HEXCHAT" hexchat  
	f_action_get "$CA_HUBIC" "http://mir7.ovh.net/ovh-applications/hubic/hubiC-Linux/2.1.0/hubiC-Linux-2.1.0.53-linux.deb"
	f_RepositoryExt_Install "$CA_JITSI" "jitsi-stable" "https://download.jitsi.org/jitsi-key.gpg.key" "https://download.jitsi.org stable/" "jitsi"
	f_action_install "$CA_LINPHONE" linphone 
	f_action_snap_install "$CA_MAILSPRING" mailspring
	f_action_install "$CA_MUMBLE" mumble 
	f_action_install "$CA_NICOTINE" nicotine
	f_action_install "$CA_OPENSSHSERVER" openssh-server
	f_action_install "$CA_PIDGIN" "pidgin pidgin-plugin-pack"
	f_action_install "$CA_POLARI" polari
	f_action_install "$CA_PSI" psi
	f_action_install "$CA_PUTTY" putty
	f_action_install "$CA_QBITTORRENT" qbittorrent	
	f_action_install "$CA_RDESKTOP" rdesktop	
	f_action_install "$CA_REMMINA" remmina
	f_action_install "$CA_RING" ring
	f_action_flatpak_install "$CA_RIOT" im.riot.Riot
	f_RepositoryExt_Install "$CA_SIGNAL" "signal-desktop" "https://updates.signal.org/desktop/apt/keys.asc" "[arch=amd64] https://updates.signal.org/desktop/apt xenial main" "signal-desktop"
    	f_action_get "$CA_SKYPE" "https://go.skype.com/skypeforlinux-64.deb" #Maj auto via dépot ajouté
	f_action_snap_install "$CA_SLACK" "slack --classic"
    	f_action_install "$CA_SUBDOWNLOADER" subdownloader
	f_action_flatpak_install "$CA_TEAMSPEAK" com.teamspeak.TeamSpeak
	f_action_get "$CA_TEAMVIEWER" "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
	f_action_install "$CA_TELEGRAM" telegram-desktop
	f_action_install "$CA_THUNDERBIRD" "thunderbird thunderbird-locale-fr thunderbird-gnome-support fonts-symbola"
	f_action_install "$CA_TRANSMISSION" transmission-gtk
	f_action_install "$CA_UGET" uget	
	f_action_snap_install "$CA_VUZE" "vuze-vs"
	f_action_install "$CA_WEECHAT" weechat
	f_action_get "$CA_WHALEBIRD" "https://github.com/h3poteto/whalebird-desktop/releases/download/3.0.0/Whalebird-3.0.0-linux-x64.deb"
	f_RepositoryExt_Install "$CA_WIRE" "wire-desktop" "http://wire-app.wire.com/linux/releases.key" "[arch=amd64] https://wire-app.wire.com/linux/debian stable main" "wire-desktop" ##PB : dépot bien ajouté mais n'installe pas les paquets
	f_action_install "$CA_WIRE" apt-transport-https #dépendance
	f_action_install "$CA_WORMHOLE" magic-wormhole
	f_action_install "$CA_X2GO" x2goclient
	f_action_install "$CA_X11VNC" x11vnc
	f_action_install "$CA_YTDLND" youtube-dl
	
	# Lecture Multimedia
	f_action_install "$CA_AUDACIOUS" audacious
	f_action_install "$CA_CLEMENTINE" clementine
	f_action_install "$CA_FLASH" "adobe-flashplugin pepperflashplugin-nonfree"
	f_action_flatpak_install "$CA_FONDO" com.github.calo001.fondo
    	f_action_install "$CA_GNOMEMPV" gnome-mpv
    	f_action_install "$CA_GNOMEMUSIC" gnome-music
    	f_action_install "$CA_GNOMETWITCH" gnome-twitch
	f_action_flatpak_install "$CA_GRADIO" de.haeckerfelix.gradio
	f_action_install "$CA_LOLLYPOP" lollypop
	f_action_install "$CA_MOLOTOVTV" "libgconf2-4 desktop-file-utils" #pré-requis pour Molotov.tv
	f_action_get_appimage "$CA_MOLOTOVTV" "http://desktop-auto-upgrade.molotov.tv/linux/4.2.1/molotov.AppImage"
	f_action_snap_install "$CA_ODIO" odio
	f_action_install "$CA_PACKCODEC" "flac opus-tools vorbis-tools lame mkvtoolnix mkvtoolnix-gui oggvideotools"
	f_action_install "$CA_PAROLE" parole
    	f_action_install "$CA_PAVUCONTROL" pavucontrol	
    	f_action_ppa_install "$CA_QARTE" ppa:vincent-vandevyvre/vvv qarte
    	f_action_install "$CA_QMMP" qmmp	
    	f_action_install "$CA_QUODLIBET" quodlibet	
    	f_action_install "$CA_RHYTHMBOX" rhythmbox		
    	f_action_install "$CA_SHOTWELL" shotwell	
    	f_action_install "$CA_SMPLAYER" "smplayer smplayer-l10n smplayer-themes"	    
    	f_RepositoryExt_Install "$CA_SPOTIFY" "spotify" "https://download.spotify.com/debian/pubkey.gpg" "http://repository.spotify.com stable non-free" "spotify-client spotify-client-gnome-support"
	f_action_install "$CA_VLCSTABLE" "vlc vlc-l10n"
    	f_action_install "$CA_RESTRICT_EXTRA" ubuntu-restricted-extras
		
	# Montage Multimédia
	# (Section re-divisé en 3 parties cf Zenity_default_choice.sh)
	f_action_exec "$CA_ARDOUR" "debconf-set-selections <<< 'jackd/tweak_rt_limits false'"
	f_action_get "$CA_ARDOUR" "http://ftp.fr.debian.org/debian/pool/main/a/ardour/ardour-video-timeline_5.12.0-3_all.deb"
	f_action_get "$CA_ARDOUR" "http://ftp.fr.debian.org/debian/pool/main/a/ardour/ardour-data_5.12.0-3_all.deb"
	f_action_get "$CA_ARDOUR" "http://ftp.fr.debian.org/debian/pool/main/a/ardour/ardour_5.12.0-3_amd64.deb"
	f_action_install "$CA_AUDACITY" audacity
	f_action_flatpak_install "$CA_AVIDEMUX" org.avidemux.Avidemux
	f_action_install "$CA_BLENDER" blender	
	f_action_get "$CA_CINELERRA" "https://cinelerra-gg.org/download/pkgs/ub18/cin_5.1.ub18.04-20191130_amd64.deb"
	f_action_install "$CA_CURA" cura
	f_action_install "$CA_DARKTABLE" darktable
	f_action_install "$CA_EASYTAG" easytag
	f_action_install "$CA_FFMPEG" ffmpeg
	f_action_snap_install "$CA_FLACON" flacon-tabetai
	f_action_install "$CA_FLAMESHOT" flameshot
	f_action_flatpak_install "$CA_FLOWBLADE" flowblade
	f_action_install "$CA_FREECAD" freecad
	f_action_install "$CA_GIADA" giada
	f_action_install "$CA_GIMP" "gimp gimp-help-fr gimp-data-extras"
	f_action_install "$CA_GNOMESOUNDRECORDER" gnome-sound-recorder
	f_action_install "$CA_GTHUMB" gthumb
	f_action_install "$CA_HANDBRAKE" handbrake
	f_action_install "$CA_HYDROGEN" hydrogen
	f_action_flatpak_install "$CA_IMCOMPRESSOR" com.github.huluti.ImCompressor
	f_action_install "$CA_INKSCAPE" inkscape
	# f_action_install "$CA_K3D" k3d
	f_action_install "$CA_KAZAM" kazam	
	f_action_install "$CA_KDENLIVE" kdenlive		
	f_action_install "$CA_KOLOURPAINT" kolourpaint	
	f_action_install "$CA_KRITA" krita
	f_action_get "$CA_LIGHTWORKS" "https://downloads.lwks.com/Lightworks-2020.1-Beta-118776.deb"
	f_action_install "$CA_LIBRECAD" librecad
	f_action_install "$CA_LIVES" lives	
	f_action_install "$CA_LUMINANCE" luminance-hdr
	f_action_install "$CA_LMMS" lmms	
	f_action_install "$CA_MHWAVEEDIT" mhwaveedit
	f_action_install "$CA_MINUET" minuet
	f_action_install "$CA_MIXXX" mixxx
	f_action_install "$CA_MUSESCORE" musescore3	
	f_action_ppa_install "$CA_MUSICBRAINZ" ppa:musicbrainz-developers/stable "picard" 
	f_action_install "$CA_MYPAINT" "mypaint mypaint-data-extras"	 
	f_action_snap_install "$CA_NATRON" natron
	f_action_install "$CA_OBS" "ffmpeg obs-studio"
	f_action_exec "$CA_OBS" "sudo sed -i -e 's/focal/eoan/g' /etc/apt/sources.list.d/obsproject*list && apt update && sudo apt install ffmpeg obs-studio -y" #(ligne temporaire en attendant que le ppa pr 20.04 soit actif)
	f_action_install "$CA_OPENSCAD" openscad
	f_action_install "$CA_OPENSHOT" openshot-qt
	f_action_snap_install "$CA_OPENTOONZ" opentoonz
	f_action_install "$CA_PEEK" peek
	f_action_install "$CA_PINTA" pinta	
	f_action_install "$CA_PITIVI" pitivi	
	f_action_get "$CA_PIXELUVO" "http://www.pixeluvo.com/downloads/pixeluvo_1.6.0-2_amd64.deb"
	f_action_install "$CA_ROSEGARDEN" rosegarden
	f_action_snap_install "$CA_SHOTCUT" "shotcut --classic"
	f_action_install "$CA_SIMPLESCREENRECORDER" simplescreenrecorder 
	f_action_install "$CA_SOUNDJUICER" sound-juicer
	f_action_install "$CA_SWEETHOME" sweethome3d
	f_action_get_appimage "$CA_UNITY3DEDITOR" "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage"
	f_action_install "$CA_WINFF" "winff winff-qt"
	
	# Bureautique/Mail
	f_action_install "$CA_CALLIGRA" calligra
	f_action_install "$CA_FRDIC" "myspell-fr-gut wfrench aspell-fr hyphen-fr mythes-fr"
	f_action_install "$CA_FBREADER" fbreader
	f_action_install "$CA_FEEDREADER" feedreader
	f_action_snap_install "$CA_FREEMIND" freemind
	f_action_get "$CA_FREEOFFICE" "https://www.softmaker.net/down/softmaker-freeoffice-2018_973-01_amd64.deb"
	f_action_install "$CA_FREEPLANE" freeplane
	f_action_install "$CA_GNOMEOFFICE" "abiword gnumeric dia planner glabels glom gnucash"	
	f_action_install "$CA_GRAMPS" gramps
	f_action_get_appimage "$CA_JOPLIN" "https://github.com/laurent22/joplin/releases/download/v1.0.175/Joplin-1.0.175-x86_64.AppImage"
    	f_action_install "$CA_LIBREOFFICEDEPOT" "libreoffice libreoffice-l10n-fr libreoffice-style-breeze"
	f_action_ppa_install "$CA_LIBREOFFICEFRESH" ppa:libreoffice/ppa "libreoffice libreoffice-l10n-fr libreoffice-style-breeze"
	f_action_install "$CA_LIBREOFFICESUP" "libreoffice-style-elementary libreoffice-style-oxygen libreoffice-style-human libreoffice-style-sifr libreoffice-style-tango libreoffice-templates openclipart-libreoffice"
	f_action_exec "$CA_LIBREOFFICESUP" "wget https://grammalecte.net/grammalecte/oxt/Grammalecte-fr-v1.6.0.oxt --no-check-certificate ; chmod +x Grammalecte*.oxt ; sudo unopkg add --shared Grammalecte*.oxt ; rm Grammalecte*.oxt"
	f_action_get "$CA_MASTERPDFEDITOR" "https://code-industry.net/public/master-pdf-editor-5.4.38-qt5.amd64.deb"
	f_action_snap_install "$CA_OFFICEWEBAPPS" "unofficial-webapp-office"
	f_action_flatpak_install "$CA_NOTESUP" com.github.philip_scott.notes-up  
	f_action_snap_install "$CA_ONLYOFFICE" onlyoffice-desktopeditors
    	f_action_LinInstall "$CA_OPENOFFICE" OpenOffice
    	f_action_install "$CA_PANDOC" pandoc
    	f_action_install "$CA_PDFMOD" pdfmod
	f_action_get "$CA_PDFSAM" "https://github.com/torakiki/pdfsam/releases/download/v4.0.5/pdfsam_4.0.5-1_amd64.deb"
    	f_action_install "$CA_PDFSHUFFLER" pdfshuffler
    	f_action_exec "$CA_POLICEMST" "echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo /usr/bin/debconf-set-selections ; sudo apt install ttf-mscorefonts-installer -y"
	f_action_snap_install "$CA_PROJECTLIBRE" "projectlibre" 
    	f_action_LinInstall "$CA_SCENARI" Scenari
    	f_action_install "$CA_SCRIBUS" "scribus scribus-template"	
	f_action_get "$CA_WPSOFFICE" "http://fr.archive.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb" 
	f_action_get "$CA_WPSOFFICE" "http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/8865/wps-office_11.1.0.8865_amd64.deb"
	f_action_get "$CA_XMIND" "https://www.xmind.net/xmind/downloads/XMind-ZEN-for-Linux-amd-64bit-10.0.0-201911260056.deb"
	f_action_install "$CA_XOURNAL" xournal
	f_action_install "$CA_XPAD" xpad
	f_action_install "$CA_ZIM" zim
	
	# Science/Education
	f_action_install "$CA_ALGOBOX" algobox
	f_action_install "$CA_AMC" auto-multiple-choice
	f_action_install "$CA_ASTROEDU" astro-education
	f_action_install "$CA_AVOGADRO" avogadro
	f_action_get_appimage "$CA_CELESTIA" "https://github.com/munix9/Celestia/releases/download/continuous/celestia-qt-continuous-x86_64.AppImage"
	f_action_install "$CA_CONVERTALL" convertall
	f_action_get "$CA_GANTTPROJECT" "https://dl.ganttproject.biz/ganttproject-2.8.10/ganttproject_2.8.10-r2364-1_all.deb"
	f_action_install "$CA_GCOMPRIS" "gcompris gcompris-qt gcompris-qt-data gnucap"
	f_action_install "$CA_GELEMENTAL" gelemental
	f_action_install "$CA_GEOGEBRA" geogebra
	f_action_install "$CA_GNOMEMAPS" gnome-maps
	f_action_get "$CA_GOOGLEEARTH" "https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb"
	f_action_exec "$CA_GOOGLEEARTH" "sudo rm -f /etc/apt/sources.list.d/google-earth-pro*" #dépot supprimé car pose soucis systématiquement
	f_action_install "$CA_MARBLE" "--no-install-recommends marble"
	f_action_install "$CA_MBLOCK" libgconf-2-4 #dépendance pour Mblock
	f_action_get "$CA_MBLOCK" "http://mblock.makeblock.com/mBlock4.0/mBlock_4.0.4_amd64.deb"
	f_action_install "$CA_OCTAVE" octave
	f_action_flatpak_install "$CA_OPENBOARD" ch.openboard.OpenBoard
	f_action_install "$CA_OPTGEO" optgeo
	f_action_install "$CA_PLANNER" planner
	f_action_flatpak_install "$CA_QGIS" org.qgis.qgis
	f_action_install "$CA_SAGEMATH" sagemath
	f_action_install "$CA_SCILAB" scilab
	f_action_exec "$CA_SCRATCH" "wget http://nux87.free.fr/script-postinstall-ubuntu/theme/scratch.png ; wget https://gitlab.com/simbd/Fichier_de_config/raw/master/scratch.desktop ; wget http://www.ac-grenoble.fr/maths/scratch/scratch.zip ; sudo unzip scratch.zip -d /opt/scratch3 ; rm scratch.zip ; sudo mv scratch.png /usr/share/icons/ ; sudo mv scratch.desktop /usr/share/applications/"
	f_action_install "$CA_STELLARIUM" stellarium
	f_action_install "$CA_TOUTENCLIC" python3-pyqt5
	f_action_exec "$CA_TOUTENCLIC" "wget http://www.bipede.fr/downloads/logiciels/ToutEnClic.zip ; unzip ToutEnClic.zip ; rm ToutEnClic.zip ; sudo mv ToutEnClic /opt/ ; wget https://gitlab.com/simbd/Fichier_de_config/raw/master/toutenclic.desktop --no-check-certificate ; sudo mv toutenclic.desktop /usr/share/applications/ ; wget http://nux87.free.fr/script-postinstall-ubuntu/theme/toutenclic.png --no-check-certificate ; sudo mv toutenclic.png /usr/share/icons/"
	f_action_install "$CA_XCAS" xcas

	# Virtualisation, Conteneurisation, Emulation & Déploiement
	f_action_install "$CA_ANBOX" anbox
	f_action_snap_install "$CA_CITRA" "--edge citra-mts"
	f_action_install "$CA_DESMUME" desmume
	f_action_install "$CA_DOCKER" "docker.io"
	f_action_install "$CA_DOLPHIN" dolphin-emu
	f_action_install "$CA_DOSBOX" dosbox
	f_action_install "$CA_GNOMEBOXES" gnome-boxes	
	f_action_ppa_install "$CA_GNS" "ppa:gns3/ppa"
	f_action_exec "$CA_GNS" "sudo sed -i -e 's/focal/eoan/g' /etc/apt/sources.list.d/gns3*list ; sudo apt update" #(ligne temporaire en attendant que le ppa pr 20.04 soit actif)
	f_action_install "$CA_GNS" gns3-gui
	f_action_install "$CA_QEMUKVM" "qemu qemu-kvm qemu-system-gui qemu-system-arm qemu-utils virt-manager virt-viewer"
	f_action_install "$CA_LXC" "lxc"
	f_action_install "$CA_MGBA" "mgba-qt"
	f_action_install "$CA_POL" playonlinux
	f_action_flatpak_install "$CA_PPSSPP" "org.ppsspp.PPSSPP"
	f_action_install "$CA_RETROARCH" retroarch
	f_action_install "$CA_VBOXDEPOT" "virtualbox virtualbox-qt virtualbox-ext-pack"
	f_RepositoryExt_Install "$CA_VBOXLAST" "virtualbox" "http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc" "[arch=amd64] http://download.virtualbox.org/virtualbox/debian eoan contrib" "virtualbox-6.1"
    	f_action_exec "$CA_VBOXLAST" "sudo usermod -G vboxusers -a $USER"
	f_action_exec "$CA_VMWARE" "wget http://download3.vmware.com/software/player/file/VMware-Player-15.5.1-15018445.x86_64.bundle && sudo chmod +x VMware-Player*.bundle ; sudo ./VMware-Player-15.5.1-15018445.x86_64.bundle --eulas-agreed --console --required ; sudo rm VMware-Player*"
	f_action_exec "$CA_VMWAREPRO" "wget https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-15.5.1-15018445.x86_64.bundle && sudo chmod +x VMware-Workstation*.bundle ; sudo ./VMware-Workstation-Full-15.5.1-15018445.x86_64.bundle --eulas-agreed --console --required ; sudo rm VMware-Workstation*"
	f_action_install "$CA_WINE" "wine-development wine64-development wine64-development-tools winetricks"
	
	# Utilitaires graphiques
	f_action_snap_install "$CA_APPOUTLET" app-outlet
	f_action_install "$CA_BRASERO" brasero
	f_action_install "$CA_CHEESE" cheese
	f_action_install "$CA_DEJADUP" deja-dup
	f_action_install "$CA_DIODON" diodon
	f_action_get_appimage "$CA_ELECTRUM" "https://download.electrum.org/3.3.8/electrum-3.3.8-x86_64.AppImage"
	f_action_exec "$CA_ETCHER" "wget https://github.com/balena-io/etcher/releases/download/v1.5.70/balena-etcher-electron-1.5.70-linux-ia32.zip && unzip balena-etcher* ; rm balena-etcher*.zip ; mkdir ~/AppImage ; mv *etcher*AppImage ~/AppImage/"
	f_action_get "$CA_ETHEREUMWALLET" "https://github.com/ethereum/mist/releases/download/v0.11.1/Ethereum-Wallet-linux64-0-11-1.deb"
	f_action_install "$CA_GITCOLA" git-cola
	f_action_install "$CA_GLABELS" glabels
	f_action_install "$CA_GNOME_DISK" gnome-disk-utility
	f_action_install "$CA_GNOMERECIPES" gnome-recipes
	f_action_install "$CA_GSHUTDOWN" gshutdown
	f_action_install "$CA_GSYSLOG" gnome-system-log
	f_action_install "$CA_GSYSMON" gnome-system-monitor
	f_action_install "$CA_HOMEBANK" homebank
	f_action_install "$CA_GPARTED" gparted
	f_action_install "$CA_MELD" meld
	f_RepositoryExt_Install "$CA_MULTISYSTEM" "multisystem" "http://liveusb.info/multisystem/depot/multisystem.asc" "http://liveusb.info/multisystem/depot all main" "multisystem"
	f_action_install "$CA_ARCHIVAGE" "unace rar unrar p7zip-rar p7zip-full sharutils uudeview mpack arj cabextract lzip lunzip"
	f_action_install "$CA_REDSHIFT" redshift-gtk
	f_action_exec "$CA_SUBLIM_NAUT" "wget https://raw.githubusercontent.com/Diaoul/nautilus-subliminal/master/install.sh -O - | sudo bash"
	f_action_install "$CA_SUB_EDIT" subtitleeditor
	f_action_install "$CA_SYNAPTIC" synaptic
	f_action_install "$CA_TERMINATOR" terminator
	f_action_install "$CA_TILIX" tilix
	f_action_install "$CA_TIMESHIFT" timeshift
	f_action_install "$CA_VARIETY" variety
	
	# Utilitaires en CLI
	f_action_install "$CA_ASCIINEMA" asciinema
	f_action_install "$CA_DDRESCUE" gddrescue
	f_action_install "$CA_FD" fd-find	
	f_action_install "$CA_GIT" git
	f_action_install "$CA_HTOP" htop
	f_action_install "$CA_GLANCES" glances
	f_action_install "$CA_HG" mercurial
	f_action_install "$CA_NIX" curl
	f_action_exec "$CA_NIX" "curl https://nixos.org/nix/install | sh"
	f_action_snap_install "$CA_POWERSHELL" "powershell --classic"	
	f_action_install "$CA_RIPGREP" ripgrep
	f_action_install "$CA_RTORRENT" rtorrent
	f_action_install "$CA_SCREEN" screen
	f_action_install "$CA_SMARTMONTOOLS" "--no-install-recommends smartmontools"
	f_action_install "$CA_TESTDISK" testdisk
	f_action_install "$CA_TLDR" tldr
	f_action_install "$CA_WORDGRINDER" "wordgrinder wordgrinder-x11"

	# Réseaux et sécurité
	f_action_install "$CA_ANSIBLE" ansible
	f_action_snap_install "$CA_BITWARDEN" bitwarden
	f_action_install "$CA_CISCOVPN" network-manager-openconnect-gnome
	f_action_get_appimage "$CA_CRYPTER" "https://github.com/HR/Crypter/releases/download/v4.0.0/Crypter-4.0.0.AppImage"
	f_action_get_appimage "$CA_CRYPTOMATOR" "https://dl.bintray.com/cryptomator/cryptomator/1.4.15/cryptomator-1.4.15-x86_64.AppImage"
	f_RepositoryExt_Install "$CA_ENPASS" "enpass" "https://dl.sinew.in/keys/enpass-linux.key" "http://repo.sinew.in/ stable main" "enpass"
	f_action_install "$CA_FUSIONINVENTORY" fusioninventory-agent
	f_action_install "$CA_GUFW" gufw
	f_action_install "$CA_GWAKEONLAN" gwakeonlan
	f_action_install "$CA_HACKINGPACK" "aircrack-ng ophcrack ophcrack-cli crunch john"
	f_action_install "$CA_KEEPASS" keepass2
    	f_action_install "$CA_KEEPASSXC" keepassxc
	f_action_install "$CA_MYSQLWB" mysql-workbench
	f_action_install "$CA_OCSINVENTORY" ocsinventory-agent
	f_action_install "$CA_PGADMIN" pgadmin3
	f_action_install "$CA_PUPPET" puppet
	f_action_install "$CA_SERVERLAMP" "apache2 php libapache2-mod-php mysql-server php-mysql php-curl php-gd php-intl php-json php-mbstring php-xml php-zip phpmyadmin"
	f_action_install "$CA_SIRIKALI" sirikali
	f_action_ppa_install "$CA_UPM" "ppa:adriansmith/upm"
	f_action_exec "$CA_UPM" "sudo sed -i -e 's/focal/bionic/g' /etc/apt/sources.list.d/adriansm*list ; sudo apt update ; sudo apt install upm -y" #(ligne temporaire en attendant que le ppa pr 20.04 soit actif)
	f_action_ppa_install "$CA_VERACRYPT" ppa:unit193/encryption veracrypt
	f_action_exec "$CA_VERACRYPT" "sudo sed -i -e 's/focal/eoan/g' /etc/apt/sources.list.d/unit193-ubuntu-encryption*list ; sudo apt update" #(ligne temporaire en attendant que le ppa pr 20.04 soit actif)
	f_action_install "$CA_VERACRYPT" veracrypt
	f_action_install "$CA_WIRESHARK" wireshark
	
	# Gaming
	f_action_install "$CA_0AD" 0ad
	f_action_flatpak_install "$CA_ALBION" com.albiononline.AlbionOnline
	f_action_install "$CA_ALIENARENA" alien-arena
	f_action_install "$CA_ASSAULTCUBE" assaultcube
	f_action_install "$CA_WESNOTH" wesnoth
	f_action_get_appimage "$CA_DOFUS" "https://ankama.akamaized.net/zaap/installers/production/Ankama%20Launcher-Setup-x86_64.AppImage"
	f_action_install "$CA_EXTREMETUXRACER" extremetuxracer
	f_action_install "$CA_FLIGHTGEAR" flightgear
	f_action_install "$CA_FROZENBUBBLE" frozen-bubble
	f_action_install "$CA_GNOMEGAMES" "gnome-games gnome-games-app"
	f_action_install "$CA_KAPMAN" kapman
	f_action_snap_install "$CA_LOL" "leagueoflegends --edge --devmode"
	f_action_ppa_install "$CA_LUTRIS" ppa:lutris-team/lutris lutris
	f_action_exec "$CA_LUTRIS" "sudo sed -i -e 's/focal/eoan/g' /etc/apt/sources.list.d/lutris*list ; sudo apt update" #(ligne temporaire en attendant que le ppa pr 20.04 soit actif)
	f_action_install "$CA_LUTRIS" lutris
	f_action_install "$CA_MEGAGLEST" megaglest
	f_action_get "$CA_MINECRAFT" "https://launcher.mojang.com/download/Minecraft.deb"
	f_action_install "$CA_MINETEST" "minetest minetest-mod-nether"
	f_action_install "$CA_OPENARENA" openarena
	f_action_get "$CA_OPENBVE" "https://vps.bvecornwall.co.uk/OpenBVE/Stable/OpenBVE-1.7.1.0.deb"
	f_action_install "$CA_PINGUS" pingus
	f_action_install "$CA_POKERTH" pokerth
	f_action_snap_install "$CA_QUAKE" quake-shareware
	f_action_install "$CA_REDECLIPSE" redeclipse
	f_action_install "$CA_RUNESCAPE" runescape
	f_action_install "$CA_STEAM" steam
	f_action_install "$CA_SUPERTUX" supertux
	f_action_install "$CA_SUPERTUXKART" supertuxkart	
	f_action_install "$CA_TEEWORLDS" teeworlds		
	f_action_snap_install "$CA_TMNF" tmnationsforever
	f_action_exec "$CA_UT4" "wget https://gitlab.com/simbd/LinInstall_Software/raw/master/LinInstall_UnrealTournament4 ; chmod +x LinInstall_Unreal*"
	f_action_install "$CA_XBOARD" "xboard gnuchess"
	f_action_exec "$CA_XPLANE" "wget https://www.x-plane.com/update/installers11/X-Plane11InstallerLinux.zip && unzip X-Plane11* ; rm X-Plane11*.zip"
	f_action_install "$CA_XQF" xqf
	
	# Programmation / Dev  
	f_action_ppa_install "$CA_ANDROIDSTUDIO" ppa:maarten-fonville/android-studio
	f_action_exec "$CA_ANDROIDSTUDIO" "sudo sed -i -e 's/focal/eoan/g' /etc/apt/sources.list.d/maarten-fonville*android*list ; sudo apt update ; sudo apt install android-studio -y"
	f_action_install "$CA_ANJUTA" "anjuta anjuta-extras"
	f_action_install "$CA_ARDUINOIDE" arduino 
	f_action_snap_install "$CA_ATOM" "atom --classic"
	f_action_install "$CA_BLUEFISH" "bluefish bluefish-plugins"
	f_action_get "$CA_BLUEGRIFFON" "http://bluegriffon.org/freshmeat/3.1/bluegriffon-3.1.Ubuntu18.04-x86_64.deb"
	f_action_snap_install "$CA_BRACKETS" "brackets --classic"
	f_action_install "$CA_CODEBLOCKS" "codeblocks codeblocks-contrib"
	f_action_snap_install "$CA_ECLIPSE" "eclipse --classic"
	f_action_install "$CA_EMACS" emacs
	f_action_LinInstall "$CA_GDEVELOP" Gdevelop
	f_action_install "$CA_GEANY" "geany geany-plugins"
	f_action_snap_install "$CA_INTELLIJIDEA" "intellij-idea-community --classic"
	f_action_install "$CA_IPYTHON" ipython
	f_action_exec "$CA_JAVA" "sudo add-apt-repository -y ppa:linuxuprising/java"
	f_action_exec "$CA_JAVA" "sudo sed -i -e 's/focal/eoan/g' /etc/apt/sources.list.d/linuxuprising-ubuntu-java*list ; sudo apt update" #(ligne temporaire en attendant que le ppa pr 20.04 soit actif)
	f_action_exec "$CA_JAVA" "echo oracle-java13-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections"
	f_action_install "$CA_JAVA" oracle-java13-installer
	f_action_install "$CA_LATEXFULL" "texlive-full fonts-freefont-ttf texlive-extra-utils texlive-fonts-extra texlive-lang-french texlive-latex-extra libreoffice-texmaths"
	f_action_install "$CA_NEOVIM" neovim
	f_action_install "$CA_NOTEPADQQ" notepadqq
	f_action_exec "$CA_PIP3" "sudo apt install python3-pip -y && sudo pip3 install spyder"
	f_action_snap_install "$CA_PYCHARM" "pycharm-community --classic"
	f_action_install "$CA_RSTUDIO" "r-base r-base-dev" #paquet R de base
	f_action_get "$CA_RSTUDIO" "https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb" #Pour l'appli graphique Rstudio
	f_action_install "$CA_SCITE" scite
	f_action_snap_install "$CA_SUBLIMETEXT" "sublime-text --classic"
	f_action_install "$CA_TEXMAKER" texmaker
	f_action_install "$CA_TEXSTUDIO" texstudio
	f_action_install "$CA_TEXWORKS" "texlive texlive-lang-french texworks"
	f_action_install "$CA_VIM" "vim vim-addon-manager vim-airline vim-asciidoc vim-athena vim-autopep8 vim-bitbake vim-conque vim-ctrlp vim-doc vim-editorconfig vim-fugitive vim-gocomplete vim-gtk3 vim-julia vim-khuno vim-lastplace vim-latexsuite vim-ledger vim-migemo vim-nox vim-pathogen vim-puppet vim-python-jedi vim-rails vim-scripts vim-snipmate vim-snippets vim-syntastic vim-tabular vim-textobj-user vim-tiny vim-tlib vim-vimerl vim-voom"
	f_RepositoryExt_Install "$CA_VSCODE" "vscode" "https://packages.microsoft.com/keys/microsoft.asc" "[arch=amd64] https://packages.microsoft.com/repos/vscode stable main" "code" ##PB : ne s'installe pas
	f_action_install "$CA_VSCODE" apt-transport-https #dépendance
	f_action_get "$CA_VSCODIUM" "https://github.com/VSCodium/vscodium/releases/download/1.41.1/codium_1.41.1-1576787344_amd64.deb"

	# Divers, Customisation et Optimisation
	f_action_install "$CA_IMPRIMANTE" "hplip hplip-doc hplip-gui sane sane-utils"
	f_action_exec "$CA_SECURITECPTE" "sudo chmod -R o=- /home/$USER"
	f_action_install "$CA_BLEACHBIT" bleachbit
	f_action_install "$CA_COLORFOLDER" folder-color
	f_action_exec "$CA_CONKY" "wget https://gitlab.com/simbd/Fichier_de_config/raw/master/.conkyrc && mv .conkyrc ~/ ; sudo apt install conky -y"
    	f_action_exec "$CA_APPORTOFF" "sudo sed -i 's/^enabled=1$/enabled=0/' /etc/default/apport"
	f_action_exec "$CA_EXTINCTIONAUTO" "echo '0 4 * * * root /sbin/shutdown -h now' | sudo tee -a /etc/cron.d/extinction-auto"
	f_action_install "$CA_GCONF" gconf-editor
	f_action_flatpak_install "$CA_GWE" com.leinardi.gwe
	f_action_exec "$CA_GS_AUGMENTATIONCAPTURE" "gsettings set org.gnome.settings-daemon.plugins.media-keys max-screencast-length 600"
	f_action_exec "$CA_GS_MINIMISATIONFENETRE" "gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'"
	f_action_install "$CA_GRUBCUSTOMIZER" grub-customizer
	f_action_exec "$CA_GRUBDEFAULT" "sudo sed -ri 's/GRUB_DEFAULT=0/GRUB_DEFAULT="saved"/g' /etc/default/grub ; echo 'GRUB_SAVEDEFAULT="true"' | sudo tee -a /etc/default/grub ; sudo update-grub"
	f_action_exec "$CA_GRUBATTENTE" "sudo sed -ri 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=2/g' /etc/default/grub ; sudo mkdir /boot/old ; sudo mv /boot/memtest86* /boot/old/ ; sudo update-grub"
	f_action_exec "$CA_GTWEAKTOOL" "if [ '$(which gnome-shell)' != '/dev/null' ] ; then sudo apt install gnome-tweak-tool -y ; fi"
	f_action_exec "$CA_DVDREAD" "sudo apt install libdvdcss2 libdvd-pkg libbluray2 -y ; sudo dpkg-reconfigure libdvd-pkg"
	f_action_install "$CA_PACKEXTENSION" "chrome-gnome-shell gnome-shell-extension-caffeine gnome-shell-extension-dashtodock gnome-shell-extension-dash-to-panel gnome-shell-extension-impatience gnome-shell-extension-weather gnome-shell-extension-system-monitor gnome-shell-extension-arc-menu gnome-shell-extension-gamemode gnome-shell-extension-gsconnect"
	f_action_install "$CA_PACKICON" "papirus-icon-theme numix-icon-theme breeze-icon-theme gnome-brave-icon-theme elementary-icon-theme oxygen-icon-theme"
	f_action_install "$CA_PACKTHEME" "arc-theme numix-blue-gtk-theme numix-gtk-theme materia-gtk-theme yuyo-gtk-theme human-theme"
	f_action_install "$CA_INTEL" intel-microcode
	f_action_ppa_install "$CA_NVIDIA_BP" ppa:graphics-drivers/ppa "nvidia-graphics-drivers-440 nvidia-settings vulkan-loader vulkan-tools"
	f_action_exec "$CA_OPTIMIS_SWAP" "echo vm.swappiness=5 | sudo tee /etc/sysctl.d/99-swappiness.conf ; echo vm.vfs_cache_pressure=50 | sudo tee -a /etc/sysctl.d/99-sysctl.conf ; sudo sysctl -p /etc/sysctl.d/99-sysctl.conf"
	f_action_exec "$CA_SNAPREMPLACEMENT" "sudo snap remove gnome-calculator gnome-characters gnome-logs gnome-system-monitor ; sudo apt install gnome-calculator gnome-characters gnome-logs gnome-system-monitor -y"
	f_action_install "$CA_NAUTILUS_EXTRA" "nautilus-compare nautilus-admin nautilus-extension-gnome-terminal nautilus-filename-repairer nautilus-gtkhash nautilus-script-audio-convert nautilus-sendto nautilus-share nautilus-wipe"
	f_action_install "$CA_SYSFIC" "btrfs-progs exfat-utils exfat-fuse hfsprogs hfsutils hfsplus xfsprogs xfsdump zfsutils-linux"
	f_action_install "$CA_TLP" "tlp tlp-rdw"
	f_action_ppa_install "$CA_TLP_THINKPAD" "ppa:linrunner/tlp" "tlp tlp-rdw tp-smapi-dkms acpi-call-tools"	
	f_action_install "$CA_ZRAM" zram-config
	
	# Pour finir
	f_action_exec "$CA_AUTOREMOVE" "sudo apt update ; sudo apt full-upgrade -y ; sudo apt autoremove --purge -y && sudo apt clean -y ; clear"
	f_action_exec "$CA_RES_DEP" "sudo apt install -fy"
    
	# Notification End 
	notify-send -i dialog-ok "$NS_END_TITLE" "$NS_END_TEXT" -t 2000

	zenity --warning --no-wrap --height 500 --width 950 --title "$MSG_END_TITLE" --text "$MSG_END_TEXT"
else
	zenity --question --title "$MSG_END_CANCEL_TITLE" --text "$MSG_END_CANCEL_TEXT"
	
	if [ $? == 0 ] 
	then
		gxmessage -center -geometry 500x950 -name "$MSG_END_TITLE" "$MSG_END_TEXT"
	fi
fi
