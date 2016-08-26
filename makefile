# sauerbraten-server, a systemd service and zsh script to manage a Sauerbraten
# (Cube 2) server in the background.
# Copyright (C) 2016  Kevin Boxhoorn
#
# sauerbraten-server is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# sauerbraten-server is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with sauerbraten-server.  If not, see <http://www.gnu.org/licenses/>.

NAME=sauerbraten-server
SCRIPT_DIR=/usr/local/bin
SERVICE_DIR=/etc/systemd/system
LOGROTATE_DIR=/etc/logrotate.d

.PHONY: install-script install-service install-logrotate install uninstall

install-script: $(NAME)
	mkdir -pv $(SCRIPT_DIR)
	cp -v $< $(SCRIPT_DIR)

install-service: $(NAME).service
	cp -v $< $(SERVICE_DIR)
	systemctl daemon-reload
	systemctl enable $(NAME)

install-logrotate: $(NAME).conf
	cp -v $< $(LOGROTATE_DIR)
	logrotate -d $(LOGROTATE_DIR)/$<

install: install-script install-service install-logrotate

uninstall:
	rm -fv $(SCRIPT_DIR)/$(NAME)
	rm -fv $(SERVICE_DIR)/$(NAME).service
	rm -fv $(LOGROTATE_DIR)/$(NAME).conf
