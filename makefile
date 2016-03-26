SCRIPT_DIR=/root/bin
SERVICE_DIR=/etc/systemd/system

install-script: sauerbraten-server
	mkdir -pv $(SCRIPT_DIR)
	cp -v sauerbraten-server $(SCRIPT_DIR)

install-service: sauerbraten-server.service
	cp -v sauerbraten-server.service $(SERVICE_DIR)
	systemctl daemon-reload
	systemctl enable sauerbraten-server

install: install-script install-service
