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
PACKAGES-$(PTXCONF_FPCONTROL) += fpcontrol

#
# Paths and names
#
FPCONTROL_VERSION	:=1.0
FPCONTROL		:= fpcontrol
FPCONTROL_URL		:= lndir://$(PTXDIST_WORKSPACE)/local_src/tools/fp_control
FPCONTROL_DIR		:= $(BUILDDIR)/$(FPCONTROL)
FPCONTROL_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FPCONTROL_PATH	:= PATH=$(CROSS_PATH)
FPCONTROL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FPCONTROL_CONF_TOOL := autoconf
FPCONTROL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

$(STATEDIR)/fpcontrol.prepare:
	@$(call targetinfo)
	cd $(FPCONTROL_DIR); \
		cp $(PTXDIST_SYSROOT_HOST)/share/libtool/config/ltmain.sh .; \
		touch NEWS README AUTHORS ChangeLog; \
		aclocal; automake -a; autoconf
	@$(call world/prepare, FPCONTROL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/fpcontrol.compile:
#	@$(call targetinfo)
#	
#	cd $(FPCONTROL_DIR) && \
#		$(MAKE) $(CROSS_ENV_CC) fpcontrol.so
#	
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fpcontrol.install:
	@$(call targetinfo)
	@$(call world/install, FPCONTROL)
	
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fpcontrol.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fpcontrol)
	@$(call install_fixup, fpcontrol,PRIORITY,optional)
	@$(call install_fixup, fpcontrol,SECTION,base)
	@$(call install_fixup, fpcontrol,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fpcontrol,DESCRIPTION,missing)

	@$(call install_copy, fpcontrol, 0, 0, 0755, -, /usr/bin/fp_control)

	@$(call install_finish, fpcontrol)

	@$(call touch)

# vim: syntax=make
