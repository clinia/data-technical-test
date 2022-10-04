SHELL=/bin/bash

PYTHON_VERSION=3.8
LATEST_PYTHON_VERSION=$(shell pyenv install -l | tr -d " " | grep "^[0-9\.]*$$" | grep "^$(PYTHON_VERSION)" | sort -V | tail -n 1 | tr -d "\n")
PYENV_PIP=$(HOME)/.pyenv/versions/$(LATEST_PYTHON_VERSION)/bin/python -m pip
POETRY_ENV=$(HOME)/.pyenv/versions/$(LATEST_PYTHON_VERSION)/bin/poetry
PYTHON=$(POETRY_ENV) run python


.PHONY: init-pyenv ## Initialize pyenv & poetry
init-pyenv:
	pyenv install -s $(LATEST_PYTHON_VERSION)
	$(PYENV_PIP) install -U pip
	$(PYENV_PIP) install --upgrade pip
	$(PYENV_PIP) install poetry

.PHONY: init-dev
init-dev: init-pyenv  ## Initialize a new virtualenv suitable for development 
	$(POETRY_ENV) update
	$(POETRY_ENV) install

.PHONY: shell
shell:  ## Open shell
	$(POETRY_ENV) shell

PHONY: deinit
deinit: ## Remove associated virtualenv
	$(POETRY_ENV) env remove $(LATEST_PYTHON_VERSION)


