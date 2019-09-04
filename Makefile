#!/usr/bin/make -f

.PHONY: help
help:	
	@echo "$(MAKE)                    affiche ce message"
	@echo "$(MAKE) all                compile le programme"
	@echo "$(MAKE) run ARG=test.txt   compile le programme et l'execute avec le fichier test.txt comme entrée"

.PHONY: all
all: run

bin/%: %.f03 bin
	gfortran -Wall -O2 -o $@ $<

bin:
	mkdir bin

.PHONY: run
run: bin/newton
	cat $(ARG) | ./bin/newton