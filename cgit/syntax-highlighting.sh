#!/usr/bin/env bash

BASENAME="$1"
EXTENSION="${BASENAME##*.}"
TABSTOP="4"

if [ -z "${EXTENSION}" ] || [ "${BASENAME}" = "${EXTENSION}" ]; then
	EXTENSION=txt
fi

while \
	[ "${EXTENSION}" = "in" ] || \
	[ "${EXTENSION}" = "inc" ] || \
	[ "${EXTENSION}" = "filters" ] || \
	[ "${EXTENSION}" = "template" ]; do
	BASENAME="${BASENAME%.*}"
	EXTENSION="${BASENAME##*.}"
done

case "${EXTENSION}" in
	*project)                           EXTENSION=xml  ;; # Eclipse
	anjuta)                             EXTENSION=xml  ;; # Anjuta
	etspec|galview)                     EXTENSION=xml  ;; # Evolution
	schemas)                            EXTENSION=xml  ;; # GConf
	ui|glade*)                          EXTENSION=xml  ;; # Glade
	page)                               EXTENSION=xml  ;; # Mallard
	*proj|*props)                       EXTENSION=xml  ;; # MS Visual Studio
	policy)                             EXTENSION=xml  ;; # polkit
	doap)                               EXTENSION=xml  ;; # project description
	client)                             EXTENSION=xml  ;; # Telepathy
	rdf|omf)                            EXTENSION=xml  ;;
	convert)                            EXTENSION=ini  ;; # dconf
	service)                            EXTENSION=ini  ;; # D-BUS
	desktop)                            EXTENSION=ini  ;; # Launcher
	socket|device|mount|automount)      EXTENSION=ini  ;; # Systemd
	swap|target|path)                   EXTENSION=ini  ;; # Systemd
	timer|snapshot|slice|scope)         EXTENSION=ini  ;; # Systemd
	ac|m4)                              EXTENSION=sh   ;; # Autoconf
	po|pot)                             EXTENSION=sh   ;; # Gettext
	dirs)                               EXTENSION=sh   ;; # user-dirs.dirs
	install)                            EXTENSION=sh   ;; # Arch Linux PKGBUILD
	am)                                 EXTENSION=mk   ;; # Automake
	p)                                  EXTENSION=c    ;; # MapleBBS
	xpm)                                EXTENSION=c    ;;
	s)                                  EXTENSION=asm  ;;
	rules)                              EXTENSION=js   ;; # polkit
	json)                               EXTENSION=js   ;;
	ru)                                 EXTENSION=rb   ;; # config.ru
esac

case "${BASENAME%%.*}" in
	BSDmakefile)                        EXTENSION=mk   ;; # BSD make
	GNUmakefile)                        EXTENSION=mk   ;; # GNU make
	Makefile|makefile)                  EXTENSION=mk   ;; # Make
	Makevars)                           EXTENSION=mk   ;;
	configure)                          EXTENSION=sh   ;; # Autoconf
	PKGBUILD)                           EXTENSION=sh   ;; # Arch Linux PKGBUILD
	bashrc|bash_login|bash_profile)     EXTENSION=sh   ;; # Bash login script
	bash_logout)                        EXTENSION=sh   ;; # Bash logout script
	bash_include)                       EXTENSION=sh   ;;
	ebuild)                             EXTENSION=sh   ;; # Gentoo ebuild
	pkg-install|pkg-deinstall)          EXTENSION=sh   ;; # FreeBSD ports
	pkg-req|pkg-plist)                  EXTENSION=sh   ;; # FreeBSD ports
	rc)                                 EXTENSION=sh   ;; # FreeBSD rc
	kshrc)                              EXTENSION=sh   ;; # ksh script
	zshrc)                              EXTENSION=sh   ;; # zsh script
	login|cshrc|tcshrc)                 EXTENSION=tcsh ;; # tcsh script
	POTFILES)                           EXTENSION=ini  ;; # Gettext
	patch-*)                            EXTENSION=diff ;; # FreeBSD ports
	vimrc)                              EXTENSION=vim  ;; # vim script
	vimadd)                             EXTENSION=vim  ;;
	Gemfile|Rakefile)                   EXTENSION=rb   ;;
esac

case "${CGIT_REPO_NAME}" in
	taiwan-online-judge*) TABSTOP=8 ;;
	*) TABSTOP=4 ;;
esac

HIGHLIGHT=(
	highlight --force -f -I --inline-css
	-s edit-gedit -O xhtml
	-t "${TABSTOP}" -S "${EXTENSION}"
)

case "${CGIT_REPO_NAME}" in
	*bbs|maple3-itoc)
		iconv -c -f Big5 -t UTF-8 2>/dev/null | "${HIGHLIGHT[@]}" 2>/dev/null
		;;
	*)
		exec "${HIGHLIGHT[@]}" 2>/dev/null
		;;
esac
