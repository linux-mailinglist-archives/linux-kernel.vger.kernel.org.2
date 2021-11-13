Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC2344F4AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhKMS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhKMS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:39 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4103C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:46 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBj-0002H8-0C; Sat, 13 Nov 2021 19:55:43 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/15] staging: r8188eu: remove efuse type from definition functions
Date:   Sat, 13 Nov 2021 19:55:04 +0100
Message-Id: <20211113185518.23941-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hal_EFUSEGetEfuseDefinition88E and Hal_EFUSEGetEfuseDefinition_Pseudo88E
do not use their efuseType parameter.

Remove the parameter from these functions and from their callers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        |  4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 12 ++++++------
 drivers/staging/r8188eu/include/hal_intf.h      |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index bcdacae1b058..9cad66f9df91 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -243,7 +243,7 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
 
 	rtl8188e_EfusePowerSwitch(pAdapter, true);
 
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
 	rtl8188e_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
 
@@ -274,7 +274,7 @@ void EFUSE_ShadowMapUpdate(
 	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
 	u16 mapLen = 0;
 
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 019e67a7989f..f0d51eb694e7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -852,7 +852,7 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 }
 
 /* Do not support BT */
-static void Hal_EFUSEGetEfuseDefinition88E(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut)
+static void Hal_EFUSEGetEfuseDefinition88E(struct adapter *pAdapter, u8 type, void *pOut)
 {
 	switch (type) {
 	case TYPE_EFUSE_MAX_SECTION:
@@ -914,7 +914,7 @@ static void Hal_EFUSEGetEfuseDefinition88E(struct adapter *pAdapter, u8 efuseTyp
 	}
 }
 
-static void Hal_EFUSEGetEfuseDefinition_Pseudo88E(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut)
+static void Hal_EFUSEGetEfuseDefinition_Pseudo88E(struct adapter *pAdapter, u8 type, void *pOut)
 {
 	switch (type) {
 	case TYPE_EFUSE_MAX_SECTION:
@@ -976,12 +976,12 @@ static void Hal_EFUSEGetEfuseDefinition_Pseudo88E(struct adapter *pAdapter, u8 e
 	}
 }
 
-void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest)
+void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut, bool bPseudoTest)
 {
 	if (bPseudoTest)
-		Hal_EFUSEGetEfuseDefinition_Pseudo88E(pAdapter, efuseType, type, pOut);
+		Hal_EFUSEGetEfuseDefinition_Pseudo88E(pAdapter, type, pOut);
 	else
-		Hal_EFUSEGetEfuseDefinition88E(pAdapter, efuseType, type, pOut);
+		Hal_EFUSEGetEfuseDefinition88E(pAdapter, type, pOut);
 }
 
 static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoTest)
@@ -1060,7 +1060,7 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 	u8 max_section = 0;
 	u8 tmp_header = 0;
 
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, (void *)&max_section, bPseudoTest);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAX_SECTION, (void *)&max_section, bPseudoTest);
 
 	if (!data)
 		return false;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e27300678114..6c53f2ca665d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -124,7 +124,7 @@ void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState);
 void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 			u16 _offset, u16 _size_byte, u8 *pbuf,
 			bool bPseudoTest);
-void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType,
+void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter,
 				       u8 type, void *pOut, bool bPseudoTest);
 u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
-- 
2.20.1

