WIFI_AIC8800_SITE_METHOD = git
WIFI_AIC8800_SITE = https://github.com/openipc/aic8800
WIFI_AIC8800_SITE_BRANCH = master
WIFI_AIC8800_VERSION = $(shell git ls-remote $(WIFI_AIC8800_SITE) $(WIFI_AIC8800_SITE_BRANCH) | head -1 | cut -f1)

WIFI_AIC8800_LICENSE = GPL-2.0

define WIFI_AIC8800_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_WLAN)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS_EXT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_CORE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_PROC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_PRIV)
	$(call KCONFIG_SET_OPT,CONFIG_CFG80211,y)
	$(call KCONFIG_SET_OPT,CONFIG_MAC80211,y)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_MINSTREL)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_MINSTREL_HT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_DEFAULT_MINSTREL)
	$(call KCONFIG_SET_OPT,CONFIG_MAC80211_RC_DEFAULT,"minstrel_ht")
endef

define WIFI_AIC8800_INSTALL_FIRMWARE
	$(INSTALL) -m 755 -d $(TARGET_DIR)/lib/firmware/aic8800D80
	$(INSTALL) -m 644 $(@D)/fw/aic8800D80/fw_patch_table_8800d80_u02.bin $(TARGET_DIR)/lib/firmware/aic8800D80/fw_patch_table_8800d80_u02.bin
	$(INSTALL) -m 644 $(@D)/fw/aic8800D80/fw_adid_8800d80_u02.bin $(TARGET_DIR)/lib/firmware/aic8800D80/fw_adid_8800d80_u02.bin
	$(INSTALL) -m 644 $(@D)/fw/aic8800D80/fw_patch_8800d80_u02.bin $(TARGET_DIR)/lib/firmware/aic8800D80/fw_patch_8800d80_u02.bin
	$(INSTALL) -m 644 $(@D)/fw/aic8800D80/fw_patch_8800d80_u02_ext0.bin $(TARGET_DIR)/lib/firmware/aic8800D80/fw_patch_8800d80_u02_ext0.bin
	$(INSTALL) -m 644 $(@D)/fw/aic8800D80/fmacfw_8800d80_u02.bin $(TARGET_DIR)/lib/firmware/aic8800D80/fmacfw_8800d80_u02.bin
	$(INSTALL) -m 644 $(@D)/fw/aic8800D80/aic_userconfig_8800d80.txt $(TARGET_DIR)/lib/firmware/aic8800D80/aic_userconfig_8800d80.txt
endef

WIFI_AIC8800_POST_INSTALL_TARGET_HOOKS += WIFI_AIC8800_INSTALL_FIRMWARE

$(eval $(kernel-module))
$(eval $(generic-package))
