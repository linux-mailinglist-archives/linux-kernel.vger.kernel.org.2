Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3324444F4AD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhKMS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbhKMS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:42 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F974C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:49 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBk-0002H8-CN; Sat, 13 Nov 2021 19:55:44 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/15] staging: r8188eu: remove efuse type from read functions
Date:   Sat, 13 Nov 2021 19:55:05 +0100
Message-Id: <20211113185518.23941-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Efuse_ReadAllMap, ReadEFuseByIC and ReadEFuse_Pseudo do not use their
efuseType parameter. Remove the parameter from these functions and
from their callers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        |  7 +++----
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 14 ++++++--------
 drivers/staging/r8188eu/include/hal_intf.h      |  2 +-
 drivers/staging/r8188eu/include/rtw_efuse.h     |  2 +-
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 9cad66f9df91..d8ae995270bc 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -237,7 +237,7 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
  * 11/11/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse, bool pseudo)
+static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 *Efuse, bool pseudo)
 {
 	u16 mapLen = 0;
 
@@ -245,7 +245,7 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
 
 	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
-	rtl8188e_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
+	rtl8188e_ReadEFuse(pAdapter, 0, mapLen, Efuse, pseudo);
 
 	rtl8188e_EfusePowerSwitch(pAdapter, false);
 }
@@ -268,7 +268,6 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
  *---------------------------------------------------------------------------*/
 void EFUSE_ShadowMapUpdate(
 	struct adapter *pAdapter,
-	u8 efuseType,
 	bool pseudo)
 {
 	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
@@ -279,5 +278,5 @@ void EFUSE_ShadowMapUpdate(
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
 	else
-		Efuse_ReadAllMap(pAdapter, efuseType, pEEPROM->efuse_eeprom_data, pseudo);
+		Efuse_ReadAllMap(pAdapter, pEEPROM->efuse_eeprom_data, pseudo);
 } /*  EFUSE_ShadowMapUpdate */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f0d51eb694e7..b501419da0a1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -815,7 +815,7 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	kfree(eFuseWord);
 }
 
-static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+static void ReadEFuseByIC(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
 {
 	if (!bPseudoTest) {
 		int ret = _FAIL;
@@ -836,19 +836,17 @@ static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u1
 	return;
 }
 
-static void ReadEFuse_Pseudo(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+static void ReadEFuse_Pseudo(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
 {
 	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
-void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
-			u16 _offset, u16 _size_byte, u8 *pbuf,
-			bool bPseudoTest)
+void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
 {
 	if (bPseudoTest)
-		ReadEFuse_Pseudo(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+		ReadEFuse_Pseudo(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
 	else
-		ReadEFuseByIC(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+		ReadEFuseByIC(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
 /* Do not support BT */
@@ -1313,7 +1311,7 @@ void
 Hal_InitPGData88E(struct adapter *padapter)
 {
 	if (!is_boot_from_eeprom(padapter))
-		EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+		EFUSE_ShadowMapUpdate(padapter, false);
 }
 
 void
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 6c53f2ca665d..59272570bc5d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -121,7 +121,7 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
 void rtl8188e_free_hal_data(struct adapter *padapter);
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState);
-void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
+void rtl8188e_ReadEFuse(struct adapter *Adapter,
 			u16 _offset, u16 _size_byte, u8 *pbuf,
 			bool bPseudoTest);
 void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter,
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 2e19b7be1075..0b5c8523d42f 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -108,6 +108,6 @@ u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 
-void EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype, bool test);
+void EFUSE_ShadowMapUpdate(struct adapter *adapter, bool test);
 
 #endif
-- 
2.20.1

