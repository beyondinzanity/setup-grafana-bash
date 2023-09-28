#!/usr/bin/env bash

GF_ORIGINAL=grafana-kiosk.linux.armv7
GF_NEW=grafana-kiosk
GF_USR_BIN_PATH=/usr/bin
GF_CONFIG=config-grafana.yml

ETC_GRAFANA=/etc/grafana

#check if the grafana kiosk binary exists
if [ -e "$GF_ORIGINAL" ]; then
	echo "$GF_ORIGINAL exists and is alive and well"
	echo
	
	#check if the grafana config file exists
	if [ -e "$GF_CONFIG" ]; then
		echo "$GF_CONFIG exists and is alive and well"
		
		#check if dir /etc/grafana exists
		if [ ! -d "$ETC_GRAFANA" ]; then 
			sudo mkdir ${ETC_GRAFANA}
		
			#check if the grafana config file already exist in /etc/grafana
			if [ ! -e "${ETC_GRAFANA}/${GF_CONFIG}" ]; then
				sudo cp ${GF_CONFIG} ${ETC_GRAFANA}
				
			else
				echo "File /$GF_CONFIG already exists at location $ETC_GRAFANA"
				exit 1
			fi
			
			#check if the grafana kiosk exists at /usr/bin 
			if [ ! -e "${GF_USR_BIN_PATH}/${GF_NEW}" ]; then
				sudo cp -p ${GF_ORIGINAL} ${GF_USR_BIN_PATH}/${GF_NEW}
				sudo chmod 755 ${GF_USR_BIN_PATH}/${GF_NEW}
			else
				echo "file $GF_NEW already exists at location $GF_USR_BIN_PATH"
				exit 1
			fi
			
			##### Setup autostart on startup #####
			LXDE_HOME=/home/pi/.config/lxsession/LXDE-pi
			LXDE_DEFAULT=/etc/xdg/lxsession/LXDE-pi
			#check if dir /home/pi/.config/lxsession/LXDE-pi exists
			if [ -d "$LXDE_HOME" ]; then
				#check if file /autostart exists at /home/pi/.config/lxsession/LXDE-pi/
				if [ -e "${LXDE_HOME}/autostart" ]; then
					### append the following line to the end of the autostart file ###
					### ./usr/bin/grafana-kiosk -c /etc/grafana/config-grafana.yml ###
					
					echo | sudo tee --append ${LXDE_HOME}/autostart
					echo | sudo tee --append ${LXDE_HOME}/autostart
					### sudo tee --append appends the line to the file if the file exists.
					### if the file doesn't exist the file will be created and the line will be added
					echo "./${GF_USR_BIN_PATH}/${GF_NEW} -c ${ETC_GRAFANA}/${GF_CONFIG}" | sudo tee --append ${LXDE_HOME}/autostart
				fi
				
			elif [ -d "$LXDE_DEFAULT" ]; then
				#check if file /autostart exists at /etc/xdg/lxsession/LXDE-pi
				if [ -e "${LXDE_DEFAULT}/autostart" ]; then
					### append the following line to the end of the autostart file ###
					### ./usr/bin/grafana-kiosk -c /etc/grafana/config-grafana.yml ###
					
					echo | sudo tee --append ${LXDE_DEFAULT}/autostart
					echo | sudo tee --append ${LXDE_DEFAULT}/autostart
					### sudo tee --append appends the line to the file if the file exists.
					### if the file doesn't exist the file will be created and the line will be added
					echo "./${GF_USR_BIN_PATH}/${GF_NEW} -c ${ETC_GRAFANA}/${GF_CONFIG}" | sudo tee --append ${LXDE_DEFAULT}/autostart
				fi
				
			else
				echo "Neither of the following paths exist"
				echo "  => /home/pi/.config/lxsession/LXDE-pi"
				echo "  => /etc/xdg/lxsession/LXDE-pi"
			
		else
			echo "Directory $ETC_GRAFANA already exists"
			exit 1
		fi
		
	else
		echo "[ERROR] Could not find file /$GF_CONFIG" 
		echo "[MESSAGE] Make sure the file is in this directory"
		exit 1
	fi
	
else
	echo "[ERROR] Could not find file /$GF_ORIGINAL" 
	echo "[MESSAGE] Make sure the file is in this directory"
	exit 1
fi