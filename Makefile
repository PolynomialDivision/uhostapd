#
# This software is licensed under the Public Domain.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=uhostapd
PKG_SOURCE_DATE:=2020-12-23
PKG_RELEASE:=1

PKG_MAINTAINER:=Nick Hainke <vincent@systemli.org>
PKG_LICENSE:=GPL-2.0-only

include $(INCLUDE_DIR)/package.mk

Build/Compile=

define Package/uhostapd
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Ubus Hostapd Lib
  URL:=https://github.com/PolynomialDivision/uhostapd
  DEPENDS:=+libubus +libubox +libubox-lua libubus-lua +luci-lib-json
endef

define Package/uhostapd/description
  Subscribe to hostapd via ubus.
endef

define Package/uhostapd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./src/uhostapd.lua $(1)/usr/sbin/uhostapd
endef

$(eval $(call BuildPackage,uhostapd))
