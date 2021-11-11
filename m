Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F844DD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhKKV37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhKKV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:29:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD7C0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 13:27:08 -0800 (PST)
Received: from ipservice-092-217-091-158.092.217.pools.vodafone-ip.de ([92.217.91.158] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlHb5-0006fH-Tt; Thu, 11 Nov 2021 22:27:04 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/7] staging: r8188eu: remove haldata's EEPROMSubCustomerID
Date:   Thu, 11 Nov 2021 22:26:40 +0100
Message-Id: <20211111212644.9011-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211111212644.9011-1-martin@kaiser.cx>
References: <20211111212644.9011-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is used only in a (disabled) debug print.

We can now remove two functions that parsed eeprom info and populated
haldata components.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  8 --------
 drivers/staging/r8188eu/hal/usb_halinit.c       | 17 -----------------
 drivers/staging/r8188eu/include/rtl8188e_hal.h  |  3 ---
 drivers/staging/r8188eu/include/rtl8188e_spec.h |  1 -
 4 files changed, 29 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 9efdc846ba33..566b49fd7478 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1584,14 +1584,6 @@ void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool Auto
 	DBG_88E("mlmepriv.ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan);
 }
 
-void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
-
-	if (AutoLoadFail)
-		pHalData->EEPROMSubCustomerID = 0;
-}
-
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool AutoLoadFail)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index caef99d0926f..1625873aa742 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -980,21 +980,6 @@ static void _ReadLEDSetting(struct adapter *Adapter, u8 *PROMContent, bool Autol
 	haldata->bLedOpenDrain = true;/*  Support Open-drain arrangement for controlling the LED. */
 }
 
-static void Hal_EfuseParsePIDVID_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
-{
-	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
-
-	if (!AutoLoadFail) {
-		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
-		haldata->EEPROMSubCustomerID = EEPROM_Default_SubCustomerID;
-	} else {
-		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
-		haldata->EEPROMSubCustomerID	= EEPROM_Default_SubCustomerID;
-	}
-
-	DBG_88E("SubCustomer ID: 0x%02X\n", haldata->EEPROMSubCustomerID);
-}
-
 static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
 {
 	u16 i;
@@ -1019,7 +1004,6 @@ readAdapterInfo_8188EU(
 
 	/* parse the eeprom/efuse content */
 	Hal_EfuseParseIDCode88E(adapt, eeprom->efuse_eeprom_data);
-	Hal_EfuseParsePIDVID_8188EU(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	Hal_EfuseParseMACAddr_8188EU(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 
 	Hal_ReadPowerSavingMode88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
@@ -1027,7 +1011,6 @@ readAdapterInfo_8188EU(
 	Hal_EfuseParseEEPROMVer88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	rtl8188e_EfuseParseChnlPlan(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	Hal_EfuseParseXtal_8188E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
-	Hal_EfuseParseCustomerID88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	Hal_ReadAntennaDiversity88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	Hal_EfuseParseBoardType88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	Hal_ReadThermalMeter_88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 19aac5c7cffb..3593334e24b6 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -177,7 +177,6 @@ struct hal_data_8188e {
 	/*  EEPROM setting. */
 	u16	EEPROMSVID;
 	u16	EEPROMSDID;
-	u8	EEPROMSubCustomerID;
 	u8	EEPROMVersion;
 	u8	EEPROMRegulatory;
 
@@ -327,8 +326,6 @@ void Hal_EfuseParseEEPROMVer88E(struct adapter *padapter, u8 *hwinfo,
 				bool AutoLoadFail);
 void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo,
 				 bool AutoLoadFail);
-void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo,
-				 bool AutoLoadFail);
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter,u8 *PROMContent,
 				 bool AutoLoadFail);
 void Hal_ReadThermalMeter_88E(struct adapter *	dapter, u8 *PROMContent,
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 8c62e8a2ca40..7dd55212e1be 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -1345,7 +1345,6 @@ Current IOREG MAP
 #define	EEPROM_DEFAULT_BT_OPTION		0x10
 
 /*  For debug */
-#define EEPROM_Default_SubCustomerID		0xCD
 #define EEPROM_Default_Version			0
 
 #define EEPROM_CHANNEL_PLAN_FCC			0x0
-- 
2.20.1

