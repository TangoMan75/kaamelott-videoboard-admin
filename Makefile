#/**
# * TangoMan Api-platform React Admin
# *
# * @version  0.1.0
# * @author   "Matthias Morin" <mat@tangoman.io>
# * @license  MIT
# * @link     https://www.linkedin.com/in/morinmatthias
# */

.PHONY: help up shell open build start stop status network

#--------------------------------------------------
# Colors
#--------------------------------------------------

TITLE     = \033[1;42m
CAPTION   = \033[1;44m
BOLD      = \033[1;34m
LABEL     = \033[1;32m
DANGER    = \033[31m
SUCCESS   = \033[32m
WARNING   = \033[33m
SECONDARY = \033[34m
INFO      = \033[35m
PRIMARY   = \033[36m
DEFAULT   = \033[0m
NL        = \033[0m\n

#--------------------------------------------------
# React
#--------------------------------------------------

# app port
port?=3000

#--------------------------------------------------
# Help
#--------------------------------------------------

## Print this help
help:
	@printf "${TITLE} TangoMan Api-platform React Admin $(shell basename ${CURDIR}) ${NL}\n"

	@printf "${CAPTION} Infos:${NL}"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "system" "$(shell uname -s)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "node"   "$(shell node --version)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "npm"    "$(shell npm --version)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "yarn"   "$(shell yarn --version)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "port"   "${port}"
	@printf "${NL}"

	@printf "${CAPTION} Description:${NL}"
	@printf "${WARNING} TangoMan Api-platform React Admin${NL}\n"

	@printf "${CAPTION} Usage:${NL}"
	@printf "${WARNING}  make [command] port=[port]${NL}\n"

	@printf "${CAPTION} Commands:${NL}"
	@awk '/^### /{printf"\n${BOLD}%s${NL}",substr($$0,5)} \
	/^[a-zA-Z0-9_-]+:/{HELP="";if(match(PREV,/^## /))HELP=substr(PREV, 4); \
		printf " ${LABEL}%-12s${DEFAULT} ${PRIMARY}%s${NL}",substr($$1,0,index($$1,":")),HELP \
	}{PREV=$$0}' ${MAKEFILE_LIST}

##################################################
### React Docker
##################################################

## Create network, build, start docker, yarn install and serve
up: network build start

## Open a terminal in the node container
shell:
	@printf "${INFO}docker-compose exec node sh${NL}"
	@docker-compose exec node sh

## Open in default browser
open:
	@printf "${INFO}nohup xdg-open `docker inspect startups-admin --format 'http://{{.NetworkSettings.Networks.tango.IPAddress}}:3000' 2>/dev/null` >/dev/null 2>&1${NL}"
	@nohup xdg-open `docker inspect startups-admin --format 'http://{{.NetworkSettings.Networks.tango.IPAddress}}:3000' 2>/dev/null` >/dev/null 2>&1

##################################################
### Docker-Compose Container
##################################################

## Build container
build:
	@printf "${INFO}docker-compose build${NL}"
	@docker-compose build

## Start the environment
start:
	@printf "${INFO}docker-compose up --detach --remove-orphans${NL}"
	@docker-compose up --detach --remove-orphans

## Stop containers
stop:
	@printf "${INFO}docker-compose stop${NL}"
	@docker-compose stop

## List containers
status:
	@printf "${INFO}docker-compose ps${NL}"
	@docker-compose ps

## Restart container
restart: stop build start

##################################################
### Docker-Compose Network
##################################################

## Create "tango" network
network:
	@printf "${INFO}docker network create tango${NL}"
	-@docker network create tango
