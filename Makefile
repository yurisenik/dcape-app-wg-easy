## dcape-app-template Makefile
## This file extends Makefile.app from dcape
#:

SHELL               = /bin/bash
CFG                ?= .env
CFG_BAK            ?= $(CFG).bak

#- App name
APP_NAME           ?= wg-easy

#- Docker image name
IMAGE              ?= ghcr.io/wg-easy/wg-easy

#- Docker image tag
IMAGE_VER          ?= 13

#- Webapp language (Supports: en, ua, ru, tr, no, pl, fr, de, ca, es, ko, vi, nl, is, pt, chs, cht, it, th, hi)
WEBAPP_LANG               ?= en

#- app root
APP_ROOT           ?= $(PWD)

#- Host's public address
WG_HOST            ?= ${APP_SITE}

#- Webapp password
WEBAPP_PASSWORD           ?= $(shell openssl rand -hex 16; echo)

#- Webapp port
WEBAPP_PORT               ?= 51821

#- Wireguard port
WG_PORT            ?= 51820

#- Wireguard port for config
WG_CONFIG_PORT     ?= 51820

#- WG default address
WG_DEFAULT_ADDRESS ?= 10.100.10.x

#- WG default DNS
WG_DEFAULT_DNS     ?= 1.1.1.1

#- WG MTU
WG_MTU             ?= 1420

#- WG alolowed ips
WG_ALLOWED_IPS     ?= 0.0.0.0/0

#- WG_PERSISTENT_KEEPALIVE
WG_PERSISTENT_KEEPALIVE ?= 25

#- WG_PRE_UP=echo "Pre Up" > /etc/wireguard/pre-up.txt
WG_PRE_UP          ?= 

#- WG_POST_UP=echo "Post Up" > /etc/wireguard/post-up.txt
WG_POST_UP         ?=

#- WG_PRE_DOWN=echo "Pre Down" > /etc/wireguard/pre-down.txt
WG_PRE_DOWN        ?=

#- WG_POST_DOWN=echo "Post Down" > /etc/wireguard/post-down.txt
WG_POST_DOWN       ?=

#- UI_TRAFFIC_STATS
UI_TRAFFIC_STATS   ?= true

#- UI_CHART_TYPE (0 Charts disabled, 1 # Line chart, 2 # Area chart, 3 # Bar chart)
UI_CHART_TYPE      ?= 0

# USE TLS
USE_TLS            ?= true

# If you need database, uncomment this var
#USE_DB              = yes

# If you need user name and password, uncomment this var
#ADD_USER            = yes

# ------------------------------------------------------------------------------

# if exists - load old values
-include $(CFG_BAK)
export

-include $(CFG)
export

# This content will be added to .env
# define CONFIG_CUSTOM
# # ------------------------------------------------------------------------------
# # Sample config for .env
# #SOME_VAR=value
#
# endef

# ------------------------------------------------------------------------------
# Find and include DCAPE_ROOT/Makefile
DCAPE_COMPOSE   ?= dcape-compose
DCAPE_ROOT      ?= $(shell docker inspect -f "{{.Config.Labels.dcape_root}}" $(DCAPE_COMPOSE))

ifeq ($(shell test -e $(DCAPE_ROOT)/Makefile.app && echo -n yes),yes)
  include $(DCAPE_ROOT)/Makefile.app
else
  include /opt/dcape/Makefile.app
endif

# ------------------------------------------------------------------------------

## Template support code, used once
use-template:

.default-deploy: prep

prep:
	@echo "Just to show we able to attach"
