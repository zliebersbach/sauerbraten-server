# sauerbraten-server
A `systemd` service and `bash` script to manage a Sauerbraten (Cube 2) server in the background.

## Installation

### Prerequisites
Before you start, make sure that your system meets the following requirements:
 - Uses `systemd` (`apt-get install systemd`)
 - Has `bash` installed (`apt-get install bash`)
 - Has `make` installed (`apt-get install make`)
 - Has `unzip` installed (`apt-get install unzip`)
 - Has root access
 - And of course, a working installation of [Sauerbraten](http://sauerbraten.org/)

To begin, log into your system as the root user. Then, download the source code by entering the following command into your console:

	wget https://github.com/wincinderith/sauerbraten-server/archive/master.zip
	
Finally, unzip the download and change into the directory by running:

	unzip master.zip && cd sauerbraten-server-master

You should also have the `$EDITOR` environment variable set.

### Configuration
This section aims to give tips as to what to change in order to get `sauerbraten-server` to work in your environment.

#### `makefile`
Set `SCRIPT_DIR` to the location that you would like to install the script. It is preferable if it is somewhere in your `PATH`. Leaving it set to the default value is recommended. Defaults to `/usr/local/bin`.

Set `SERVICE_DIR` to the directory where `systemd` searches for service files. Defaults to `/etc/systemd/system` (the default on most systems).

#### `sauerbraten-server`
Change `GAME_DIR` to the directory of your Sauerbraten installation. Defaults to `/usr/games/sauerbraten`.

Set `GAME_EXEC` to the name of the binary for your system (`linux_server` for 32-bit systems and `linux_64_server` for 64-bit systems). Defaults to `linux_64_server`.

Alter `GAME_LOG` to the directory where you want to store the server log. Defaults to `/var/log/$NAME`.

#### `sauerbraten-server.service`
Alter the `ExecStart`, `ExecStop` and `ExecReload` paramaters of the `[Service]` section to point to the location of the `sauerbraten-server` script. You will only need to change this if you altered `SCRIPT_DIR` in the makefile. Defaults to `/usr/local/bin/sauerbraten-server`.

### Installation
To install `sauerbraten-server`, simply execute the following command (while still logged in as root):

	make install

## Usage

### CLI
The command line script has 4 options:
 - `start` - starts the server if it isn't already running.
 - `stop` - stops the server.
 - `restart` - restarts the server (useful after editing configuration files).
 - `run` - starts the server if it isn't already running and shows the log file.
 - `edit-config` - opens the server configuration file and restarts the server if the file was changed.

If you are using `systemd`, it is not recommended (or tested for that matter) to use the CLI script to control the server. You should use the `systemd` commands show [below](#systemd).

### `systemd`
The Sauerbraten server is automatically configured to start on boot by the makefile. However, the following commands give you on-the-fly control of the server through `systemd`:
 - `systemctl start sauerbraten-server` - see `start` under [CLI](#cli)
 - `systemctl stop sauerbraten-server` - see `stop` under [CLI](#cli)
 - `systemctl reload sauerbraten-server` - see `restart` under [CLI](#cli)

## License

    sauerbraten-server, a systemd service and bash script to manage a Sauerbraten
   	(Cube 2) server in the background.
    Copyright (C) 2016  Kevin Boxhoorn

    sauerbraten-server is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    sauerbraten-server is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with sauerbraten-server.  If not, see <http://www.gnu.org/licenses/>.
