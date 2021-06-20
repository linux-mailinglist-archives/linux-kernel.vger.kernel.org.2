Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1747B3ADFBE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFTR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFTRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:55:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7973FC06175F;
        Sun, 20 Jun 2021 10:53:39 -0700 (PDT)
Received: from dslb-084-059-235-131.084.059.pools.vodafone-ip.de ([84.59.235.131] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lv1dZ-00012S-9U; Sun, 20 Jun 2021 19:53:37 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/13] staging: rtl8188eu: remove more unused defines
Date:   Sun, 20 Jun 2021 19:53:01 +0200
Message-Id: <20210620175301.14988-13-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210620175301.14988-1-martin@kaiser.cx>
References: <20210620175301.14988-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some defines for register addresses and bits which obviously
refer to chipsets other than rtl8188eu.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/rtl8188eu/include/rtl8188e_spec.h | 148 +-----------------
 1 file changed, 1 insertion(+), 147 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_spec.h b/drivers/staging/rtl8188eu/include/rtl8188e_spec.h
index 94baea8bc068..fe0871bbb95f 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_spec.h
@@ -7,15 +7,8 @@
 #ifndef __RTL8188E_SPEC_H__
 #define __RTL8188E_SPEC_H__
 
-/*        8192C Register offset definition */
-
-#define		HAL_PS_TIMER_INT_DELAY	50	/*   50 microseconds */
-#define		HAL_92C_NAV_UPPER_UNIT	128	/*  micro-second */
-
-#define MAC_ADDR_LEN			6
 /*  8188E PKT_BUFF_ACCESS_CTRL value */
 #define TXPKT_BUF_SELECT		0x69
-#define RXPKT_BUF_SELECT		0xA5
 #define DISABLE_TRXPKT_BUF_ACCESS	0x0
 
 /*	0x0000h ~ 0x00FFh	System Configuration */
@@ -52,19 +45,7 @@
 #define REG_FSISR			0x0054
 #define REG_HSIMR			0x0058
 #define REG_HSISR			0x005c
-#define REG_GPIO_PIN_CTRL_2		0x0060 /*  RTL8723 WIFI/BT/GPS
-						* Multi-Function GPIO Pin Control.
-						*/
-#define REG_GPIO_IO_SEL_2		0x0062 /*  RTL8723 WIFI/BT/GPS
-						* Multi-Function GPIO Select.
-						*/
 #define REG_BB_PAD_CTRL			0x0064
-#define REG_MULTI_FUNC_CTRL		0x0068 /*  RTL8723 WIFI/BT/GPS
-						* Multi-Function control source.
-						*/
-#define REG_GPIO_OUTPUT			0x006c
-#define REG_AFE_XTAL_CTRL_EXT		0x0078 /* RTL8188E */
-#define REG_XCK_OUT_CTRL		0x007c /* RTL8188E */
 #define REG_MCUFWDL			0x0080
 #define REG_WOL_EVENT			0x0081 /* RTL8188E */
 #define REG_MCUTSTCFG			0x0084
@@ -172,9 +153,6 @@
 #define	REG_PCIE_HCPWM			0x0363	/* PCIe CPWM */
 #define	REG_WATCH_DOG			0x0368
 
-/*  RTL8723 series ------------------------------ */
-#define	REG_PCIE_HISR			0x03A0
-
 /*  spec version 11 */
 /*	0x0400h ~ 0x047Fh	Protocol Configuration */
 #define REG_VOQ_INFORMATION		0x0400
@@ -459,34 +437,6 @@
 #define	GPIO_IO_SEL			(REG_GPIO_PIN_CTRL + 2)
 #define	GPIO_MOD			(REG_GPIO_PIN_CTRL + 3)
 
-/* 8723/8188E Host System Interrupt Mask Register (offset 0x58, 32 byte) */
-#define	HSIMR_GPIO12_0_INT_EN		BIT(0)
-#define	HSIMR_SPS_OCP_INT_EN		BIT(5)
-#define	HSIMR_RON_INT_EN		BIT(6)
-#define	HSIMR_PDN_INT_EN		BIT(7)
-#define	HSIMR_GPIO9_INT_EN		BIT(25)
-
-/* 8723/8188E Host System Interrupt Status Register (offset 0x5C, 32 byte) */
-#define	HSISR_GPIO12_0_INT		BIT(0)
-#define	HSISR_SPS_OCP_INT		BIT(5)
-#define	HSISR_RON_INT_EN		BIT(6)
-#define	HSISR_PDNINT			BIT(7)
-#define	HSISR_GPIO9_INT			BIT(25)
-
-/*   8192C (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
-/*
- * Network Type
- * 00: No link
- * 01: Link in ad hoc network
- * 10: Link in infrastructure network
- * 11: AP mode
- * Default: 00b.
- */
-#define	MSR_NOLINK			0x00
-#define	MSR_ADHOC			0x01
-#define	MSR_INFRA			0x02
-#define	MSR_AP				0x03
-
 /*   88EU (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
 #define	USB_INTR_CONTENT_C2H_OFFSET	0
 #define	USB_INTR_CONTENT_CPWM1_OFFSET	16
@@ -505,34 +455,6 @@
 #define CMD_EFUSE_PATCH_ERR		BIT(6)
 #define CMD_IOCONFIG_ERR		BIT(7)
 
-/*  6. Adaptive Control Registers  (Offset: 0x0160 - 0x01CF) */
-/*  8192C Response Rate Set Register	(offset 0x181, 24bits) */
-#define	RRSR_1M				BIT(0)
-#define	RRSR_2M				BIT(1)
-#define	RRSR_5_5M			BIT(2)
-#define	RRSR_11M			BIT(3)
-#define	RRSR_6M				BIT(4)
-#define	RRSR_9M				BIT(5)
-#define	RRSR_12M			BIT(6)
-#define	RRSR_18M			BIT(7)
-#define	RRSR_24M			BIT(8)
-#define	RRSR_36M			BIT(9)
-#define	RRSR_48M			BIT(10)
-#define	RRSR_54M			BIT(11)
-#define	RRSR_MCS0			BIT(12)
-#define	RRSR_MCS1			BIT(13)
-#define	RRSR_MCS2			BIT(14)
-#define	RRSR_MCS3			BIT(15)
-#define	RRSR_MCS4			BIT(16)
-#define	RRSR_MCS5			BIT(17)
-#define	RRSR_MCS6			BIT(18)
-#define	RRSR_MCS7			BIT(19)
-
-/*  8192C Response Rate Set Register	(offset 0x1BF, 8bits) */
-/*  WOL bit information */
-#define	HAL92C_WOL_PTK_UPDATE_EVENT	BIT(0)
-#define	HAL92C_WOL_GTK_UPDATE_EVENT	BIT(1)
-
 /*        8192C BW_OPMODE bits		(Offset 0x203, 8bit) */
 #define	BW_OPMODE_20MHZ			BIT(2)
 #define	BW_OPMODE_5G			BIT(1)
@@ -565,12 +487,6 @@
 #define	SCR_TxSecEnable			0x02
 #define	SCR_RxSecEnable			0x04
 
-/*  10. Power Save Control Registers	 (Offset: 0x0260 - 0x02DF) */
-#define	WOW_PMEN			BIT(0) /*  Power management Enable. */
-#define	WOW_WOMEN			BIT(1) /*  WoW function on or off. */
-#define	WOW_MAGIC			BIT(2) /*  Magic packet */
-#define	WOW_UWF				BIT(3) /*  Unicast Wakeup frame. */
-
 /*  12. Host Interrupt Status Registers	 (Offset: 0x0300 - 0x030F) */
 /*        8188 IMR/ISR bits */
 #define	IMR_DISABLED_88E		0x0
@@ -648,21 +564,6 @@ So the following defines for 92C is not entire!!!!!!
  * 0x0600h ~ 0x07FFh   WMAC Configuration (512 Bytes)
  * 0x2000h ~ 0x3FFFh   8051 FW Download Region (8196 Bytes)
  */
-/*		 8192C (TXPAUSE) transmission pause (Offset 0x522, 8 bits) */
-/*  Note:
- *	The bits of stopping AC(VO/VI/BE/BK) queue in datasheet
- *	RTL8192S/RTL8192C are wrong,
- *	the correct arragement is VO - Bit0, VI - Bit1, BE - Bit2,
- *	and BK - Bit3.
- *	8723 and 88E may be not correct either in the earlier version.
- */
-#define		StopBecon			BIT(6)
-#define		StopHigh			BIT(5)
-#define		StopMgt				BIT(4)
-#define		StopBK				BIT(3)
-#define		StopBE				BIT(2)
-#define		StopVI				BIT(1)
-#define		StopVO				BIT(0)
 
 /*        8192C (RCR) Receive Configuration Register(Offset 0x608, 32 bits) */
 #define	RCR_APPFCS		BIT(31)	/* WMAC append FCS after payload */
@@ -695,14 +596,8 @@ So the following defines for 92C is not entire!!!!!!
 #define	RCR_FIFO_OFFSET		13
 
 /*	0xFE00h ~ 0xFE55h	USB Configuration */
-#define REG_USB_INFO			0xFE17
-#define REG_USB_SPECIAL_OPTION		0xFE55
-#define REG_USB_DMA_AGG_TO		0xFE5B
-#define REG_USB_AGG_TO			0xFE5C
-#define REG_USB_AGG_TH			0xFE5D
-
 #define REG_USB_HRPWM			0xFE58
-#define REG_USB_HCPWM			0xFE57
+
 /*        8192C Register Bit and Content definition */
 /*	0x0000h ~ 0x00FFh	System Configuration */
 
@@ -1140,14 +1035,6 @@ So the following defines for 92C is not entire!!!!!!
 /*  GPS function enable */
 #define	GPS_FUNC_EN				BIT(22)
 
-/* 3 REG_LIFECTRL_CTRL */
-#define	HAL92C_EN_PKT_LIFE_TIME_BK		BIT(3)
-#define	HAL92C_EN_PKT_LIFE_TIME_BE		BIT(2)
-#define	HAL92C_EN_PKT_LIFE_TIME_VI		BIT(1)
-#define	HAL92C_EN_PKT_LIFE_TIME_VO		BIT(0)
-
-#define	HAL92C_MSDU_LIFE_TIME_UNIT		128	/*  in us */
-
 /*  General definitions */
 #define LAST_ENTRY_OF_TX_PKT_BUFFER		176 /*  22k 22528 bytes */
 
@@ -1173,48 +1060,15 @@ So the following defines for 92C is not entire!!!!!!
 #define	EEPROM_CUSTOMERID_88E			0xC5
 #define	EEPROM_RF_ANTENNA_OPT_88E		0xC9
 
-/*  RTL88EE */
-#define	EEPROM_MAC_ADDR_88EE			0xD0
-#define	EEPROM_VID_88EE				0xD6
-#define	EEPROM_DID_88EE				0xD8
-#define	EEPROM_SVID_88EE			0xDA
-#define	EEPROM_SMID_88EE			0xDC
-
 /* RTL88EU */
 #define	EEPROM_MAC_ADDR_88EU			0xD7
 #define	EEPROM_VID_88EU				0xD0
 #define	EEPROM_PID_88EU				0xD2
 #define EEPROM_USB_OPTIONAL_FUNCTION0		0xD4
 
-/*  RTL88ES */
-#define	EEPROM_MAC_ADDR_88ES			0x11A
-
 /*		EEPROM/Efuse Value Type */
 #define EETYPE_TX_PWR				0x0
 
-/*  Default Value for EEPROM or EFUSE!!! */
-#define EEPROM_Default_TSSI			0x0
-#define EEPROM_Default_TxPowerDiff		0x0
-#define EEPROM_Default_CrystalCap		0x5
-/*  Default: 2X2, RTL8192CE(QFPN68) */
-#define EEPROM_Default_BoardType		0x02
-#define EEPROM_Default_TxPower			0x1010
-#define EEPROM_Default_HT2T_TxPwr		0x10
-
-#define EEPROM_Default_LegacyHTTxPowerDiff	0x3
-#define EEPROM_Default_ThermalMeter		0x12
-
-#define EEPROM_Default_AntTxPowerDiff		0x0
-#define EEPROM_Default_TxPwDiff_CrystalCap	0x5
-#define EEPROM_Default_TxPowerLevel		0x2A
-
-#define EEPROM_Default_HT40_2SDiff		0x0
-/*  HT20<->40 default Tx Power Index Difference */
-#define EEPROM_Default_HT20_Diff		2
-#define EEPROM_Default_LegacyHTTxPowerDiff	0x3
-#define EEPROM_Default_HT40_PwrMaxOffset	0
-#define EEPROM_Default_HT20_PwrMaxOffset	0
-
 #define EEPROM_Default_CrystalCap_88E		0x20
 #define	EEPROM_Default_ThermalMeter_88E		0x18
 
-- 
2.20.1

