# -*-makefile-*-
#
# Copyright (C) 2003-2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EVREMOTE2) += evremote2

#
# Paths and names
#
EVREMOTE2_VERSION	:=1.0
EVREMOTE2		:= evremote2
EVREMOTE2_URL		:= lndir://$(PTXDIST_WORKSPACE)/local_src/tools/$(EVREMOTE2)
EVREMOTE2_DIR		:= $(BUILDDIR)/$(EVREMOTE2)
EVREMOTE2_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EVREMOTE2_PATH	:= PATH=$(CROSS_PATH)
EVREMOTE2_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
EVREMOTE2_CONF_TOOL := autoconf
EVREMOTE2_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

$(STATEDIR)/evremote2.prepare:
	@$(call targetinfo)
	cd $(EVREMOTE2_DIR); \
		cp $(PTXDIST_SYSROOT_HOST)/share/libtool/config/ltmain.sh .; \
		touch NEWS README AUTHORS ChangeLog; \
		aclocal; automake -a; autoconf
	@$(call world/prepare, EVREMOTE2)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/evremote2.compile:
#	@$(call targetinfo)
#	
#	cd $(EVREMOTE2_DIR) && \
#		$(MAKE) $(CROSS_ENV_CC) evremote2.so
#	
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/evremote2.install:
	@$(call targetinfo)
	@$(call world/install, EVREMOTE2)
	
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/evremote2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, evremote2)
	@$(call install_fixup, evremote2,PRIORITY,optional)
	@$(call install_fixup, evremote2,SECTION,base)
	@$(call install_fixup, evremote2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, evremote2,DESCRIPTION,missing)

	@$(call install_copy, evremote2, 0, 0, 0755, -, /usr/bin/$(EVREMOTE2))

	@$(call install_finish, evremote2)

	@$(call touch)

# vim: syntax=make
