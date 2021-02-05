Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08E6311802
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBFA5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:57:36 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37308 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBEJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612518954; x=1644054954;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=fbPqa0i6Q55n2DwbEWA5AKIB6CBk+PVmtHr/w6ianNM=;
  b=QZn4WvfAJgbUP+wXCDtK1e5gbfaJ0Lh9IQnci7BqjI58IhGQTxyE/6s5
   Q+9PP3XRnIxu9zIBzUuBLrqpBKG/UEmuBTpdJE3C5IRTuEXHTyRRF+tmT
   RkZfIS7a9aQybOWse+Q+BR8TayJZvnqSEfJtvktk+2cROakEipsMan2XC
   //T3TuxpXCm1oGwKbu0F/0ehpM1cHsyV90AM2TDbvTrbxqg3TlRBrQDWg
   7TaZ8iJc0XHsMoizhNUvB1hrM0VVnKvl3JX4MDfHVBSQLqi6hAkDDXUVg
   /wJ8yRjZWKXsnYHF2AgWuOT/2dWs6qSl4wVnvnkqovExRBHCn9pFaFi8H
   g==;
IronPort-SDR: BhNoyOiMCVytFg6DlR+bxDYZxeqxrU1VrU1v/w2y/nJqfEH2RC4t398KluUncz95qDFGYB6p2S
 m+H/a1c+MUOyfanZd0oJlXPG4mxPsQxVBqgq7X/J5oFuTDNqg2k8Y5LhPIq1mZ/v/KZE0S4iIG
 vdrT+re4wgpSvrwNh6hWyWbYuE8n7zwjUZ+kakoQoputtzwFsmh7gItCs0tFrqi8j/aad5rBwF
 CvlvOjkdLApwf+XnEeAwz5eliODX/KcRIlDSJ9WCIDqZIK2yqIq+HPMs2qaDo1/+SZaUJd90kw
 AHI=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="108139523"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 02:54:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 02:54:35 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 5 Feb 2021 02:54:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: configs: at91: enable drivers for sam9x60
Date:   Fri, 5 Feb 2021 11:54:31 +0200
Message-ID: <1612518871-9311-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable drivers for sam9x60/sam9x60-ek:
- shutdown controller
- CAN
- AT24 EEPROM (present on SAM9X60-EK)
- MCP23S08 (present on SAM9X60-EK)
- AES, TDES, SHA

And use "make savedefconfig".

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 5f3415c743ec..e274f8c492d2 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -17,8 +17,6 @@ CONFIG_SOC_SAM9X60=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
@@ -38,6 +36,8 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_DIAG is not set
 CONFIG_IPV6_SIT_6RD=y
+CONFIG_CAN=y
+CONFIG_CAN_AT91=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_DEVTMPFS=y
@@ -58,6 +58,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_ATMEL_SSC=y
+CONFIG_EEPROM_AT24=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -91,7 +92,6 @@ CONFIG_RT2800USB_UNKNOWN=y
 CONFIG_RTL8187=m
 CONFIG_RTL8192CU=m
 # CONFIG_RTLWIFI_DEBUG is not set
-CONFIG_INPUT_POLLDEV=y
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -111,8 +111,8 @@ CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_ATMEL_QUADSPI=y
+CONFIG_PINCTRL_MCP23S08=m
 CONFIG_POWER_RESET=y
-# CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC is not set
 CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
@@ -208,7 +208,9 @@ CONFIG_NLS_UTF8=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
-# CONFIG_CRYPTO_HW is not set
+CONFIG_CRYPTO_DEV_ATMEL_AES=y
+CONFIG_CRYPTO_DEV_ATMEL_TDES=y
+CONFIG_CRYPTO_DEV_ATMEL_SHA=y
 CONFIG_CRC_CCITT=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
-- 
2.7.4

