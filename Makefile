-include .env

BASEDIR = $(realpath .)

API = $(BASEDIR)/api
FRONTEND = $(BASEDIR)/frontend

VIRTUALENV = $(VIRTUAL_ENV)

NODE_MODULES = $(FRONTEND)/node_modules
NODEBINARIES = $(NODE_MODULES)/.bin

PYBINARIES = $(VIRTUALENV)/bin
PYTHON = $(PYBINARIES)/python
PIP = $(PYBINARIES)/pip
HONCHO = $(PYBINARIES)/honcho

NPM ?= npm

clean.frontend:
	rm -rf $(NODE_MODULES)

clean:
	make clean.frontend

install:
	$(PIP) install --ignore-installed -r $(API)/requirements.txt
	$(NPM) --prefix $(FRONTEND) install


lock:
	# Lock Dependencies
	
	rm $(API)/requirements.txt
	$(PIP) freeze > $(API)/requirements.txt

upgrade:
	$(npm) --prefix $(FRONTEND) upgrade

build:
	$(NPM) --prefix $(FRONTEND) build

start:
	$(HONCHO) start --procfile $(BASEDIR)/Procfile.dev
