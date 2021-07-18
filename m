Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C9C3CCA1E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhGRRkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhGRRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 13:40:32 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49950C061762;
        Sun, 18 Jul 2021 10:37:34 -0700 (PDT)
Received: from dslb-178-004-206-019.178.004.pools.vodafone-ip.de ([178.4.206.19] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m5AjJ-0006oR-TM; Sun, 18 Jul 2021 19:37:29 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/10] staging: rtl8188eu: remove struct eeprom_priv's EepromOrEfuse
Date:   Sun, 18 Jul 2021 19:36:05 +0200
Message-Id: <20210718173610.894-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210718173610.894-1-martin@kaiser.cx>
References: <20210718173610.894-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This setting is used only in one place. There's no need to store it
in a global struct.

While at it, merge the two-line Hal_InitPGData88E function and its
only caller.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 6 ------
 drivers/staging/rtl8188eu/hal/usb_halinit.c       | 5 +++--
 drivers/staging/rtl8188eu/include/hal_intf.h      | 2 --
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h  | 3 ---
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index d1086699f952..62cbe052397f 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -228,12 +228,6 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 	return status;
 }
 
-void Hal_InitPGData88E(struct adapter *padapter)
-{
-	if (!is_boot_from_eeprom(padapter))
-		EFUSE_ShadowMapUpdate(padapter);
-}
-
 void Hal_EfuseParseIDCode88E(struct adapter *padapter, u8 *hwinfo)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 26c445a77e35..e0961919fcf8 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -995,10 +995,11 @@ void rtw_hal_read_chip_info(struct adapter *Adapter)
 	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(Adapter);
 	u8 eeValue = usb_read8(Adapter, REG_9346CR);
 
-	eeprom->EepromOrEfuse = (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	eeprom->bautoload_fail_flag = (eeValue & EEPROM_EN) ? false : true;
 
-	Hal_InitPGData88E(Adapter);
+	if (eeValue & BOOT_FROM_EEPROM)
+		EFUSE_ShadowMapUpdate(Adapter);
+
 	readAdapterInfo_8188EU(Adapter);
 }
 
diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index c74249fc200f..4d4e0a259050 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -131,8 +131,6 @@ enum hardware_type {
 
 #define GET_EEPROM_EFUSE_PRIV(adapter) (&adapter->eeprompriv)
 
-#define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
-
 void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level);
 u32 rtl8188eu_hal_deinit(struct adapter *Adapter);
 u32 rtl8188eu_hal_init(struct adapter *Adapter);
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index 2c16d3f33e1c..f585cbe21a6f 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -196,8 +196,6 @@ struct hal_data_8188e {
 	u8	bTXPowerDataReadFromEEPORM;
 	u8	EEPROMThermalMeter;
 
-	bool	EepromOrEfuse;
-
 	u8	Index24G_CCK_Base[MAX_RF_PATH][CHANNEL_MAX_NUMBER];
 	u8	Index24G_BW40_Base[MAX_RF_PATH][CHANNEL_MAX_NUMBER];
 	/* If only one tx, only BW20 and OFDM are used. */
@@ -298,7 +296,6 @@ void rtl8188e_InitializeFirmwareVars(struct adapter *padapter);
 s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
 
 /*  EFuse */
-void Hal_InitPGData88E(struct adapter *padapter);
 void Hal_EfuseParseIDCode88E(struct adapter *padapter, u8 *hwinfo);
 void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *hwinfo,
 			    bool AutoLoadFail);
-- 
2.20.1

