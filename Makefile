#!/usr/bin/make -f

.PHONY: help
help:	
	@echo "$(MAKE)                      affiche ce message"
	@echo "$(MAKE) all                  compile le programme"
	@echo "$(MAKE) run STDIN=test.txt   compile le programme et l'execute avec le fichier test.txt comme entrée"

.PHONY: all
all: run

bin/%: %.f03 bin
	gfortran -Wall -fno-backtrace -O2 -o $@ $<

bin:
	mkdir -p bin

.PHONY: run
run: bin/newton
	cat $(STDIN) | ./bin/newton