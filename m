Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C587644F4AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhKMS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhKMS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:43 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA049C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:50 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBm-0002H8-63; Sat, 13 Nov 2021 19:55:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/15] staging: r8188eu: remove test code for efuse shadow map
Date:   Sat, 13 Nov 2021 19:55:06 +0100
Message-Id: <20211113185518.23941-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFUSE_ShadowMapUpdate function has a parameter to replace the
actual read operations with test reads. The only caller of
EFUSE_ShadowMapUpdate does not use this test mode.

Remove the read test code from EFUSE_ShadowMapUpdate and the low-level
functions that it calls.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c      |  22 +--
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 125 ++++--------------
 drivers/staging/r8188eu/include/hal_intf.h    |   7 +-
 drivers/staging/r8188eu/include/rtw_efuse.h   |   4 +-
 4 files changed, 34 insertions(+), 124 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index d8ae995270bc..d799d0c7817f 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -83,18 +83,12 @@ void
 ReadEFuseByte(
 		struct adapter *Adapter,
 		u16 _offset,
-		u8 *pbuf,
-		bool pseudo)
+		u8 *pbuf)
 {
 	u32 value32;
 	u8 readbyte;
 	u16 retry;
 
-	if (pseudo) {
-		Efuse_Read1ByteFromFakeContent(_offset, pbuf);
-		return;
-	}
-
 	/* Write Address */
 	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
 	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2);
@@ -237,15 +231,15 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
  * 11/11/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 *Efuse, bool pseudo)
+static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 *Efuse)
 {
 	u16 mapLen = 0;
 
 	rtl8188e_EfusePowerSwitch(pAdapter, true);
 
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
-	rtl8188e_ReadEFuse(pAdapter, 0, mapLen, Efuse, pseudo);
+	rtl8188e_ReadEFuse(pAdapter, 0, mapLen, Efuse);
 
 	rtl8188e_EfusePowerSwitch(pAdapter, false);
 }
@@ -266,17 +260,15 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 *Efuse, bool pseudo)
  * 11/13/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-void EFUSE_ShadowMapUpdate(
-	struct adapter *pAdapter,
-	bool pseudo)
+void EFUSE_ShadowMapUpdate(struct adapter *pAdapter)
 {
 	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
 	u16 mapLen = 0;
 
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
 	else
-		Efuse_ReadAllMap(pAdapter, pEEPROM->efuse_eeprom_data, pseudo);
+		Efuse_ReadAllMap(pAdapter, pEEPROM->efuse_eeprom_data);
 } /*  EFUSE_ShadowMapUpdate */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b501419da0a1..84abbed51cbe 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -685,9 +685,7 @@ void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState)
 static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16			_offset,
 	u16			_size_byte,
-	u8 *pbuf,
-		bool bPseudoTest
-	)
+	u8 *pbuf)
 {
 	u8 *efuseTbl = NULL;
 	u8 rtemp8[1];
@@ -727,7 +725,7 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	/*  1. Read the first byte to check if efuse is empty!!! */
 	/*  */
 	/*  */
-	ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+	ReadEFuseByte(Adapter, eFuse_Addr, rtemp8);
 	if (*rtemp8 != 0xFF) {
 		efuse_utilized++;
 		eFuse_Addr++;
@@ -744,11 +742,11 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		if ((*rtemp8 & 0x1F) == 0x0F) {		/* extended header */
 			u1temp = ((*rtemp8 & 0xE0) >> 5);
 
-			ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+			ReadEFuseByte(Adapter, eFuse_Addr, rtemp8);
 
 			if ((*rtemp8 & 0x0F) == 0x0F) {
 				eFuse_Addr++;
-				ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+				ReadEFuseByte(Adapter, eFuse_Addr, rtemp8);
 
 				if (*rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E))
 					eFuse_Addr++;
@@ -769,13 +767,13 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 				/*  Check word enable condition in the section */
 				if (!(wren & 0x01)) {
-					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8);
 					eFuse_Addr++;
 					efuse_utilized++;
 					eFuseWord[offset][i] = (*rtemp8 & 0xff);
 					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
 						break;
-					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8);
 					eFuse_Addr++;
 					efuse_utilized++;
 					eFuseWord[offset][i] |= (((u16)*rtemp8 << 8) & 0xff00);
@@ -787,7 +785,7 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		}
 
 		/*  Read next PG header */
-		ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+		ReadEFuseByte(Adapter, eFuse_Addr, rtemp8);
 
 		if (*rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
 			efuse_utilized++;
@@ -815,38 +813,26 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	kfree(eFuseWord);
 }
 
-static void ReadEFuseByIC(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+static void ReadEFuseByIC(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf)
 {
-	if (!bPseudoTest) {
-		int ret = _FAIL;
-		if (rtw_IOL_applied(Adapter)) {
-			rtl8188eu_InitPowerOn(Adapter);
+	int ret = _FAIL;
+	if (rtw_IOL_applied(Adapter)) {
+		rtl8188eu_InitPowerOn(Adapter);
 
-			iol_mode_enable(Adapter, 1);
-			ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
-			iol_mode_enable(Adapter, 0);
+		iol_mode_enable(Adapter, 1);
+		ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
+		iol_mode_enable(Adapter, 0);
 
-			if (_SUCCESS == ret)
-				goto exit;
-		}
+		if (_SUCCESS == ret)
+			return;
 	}
-	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
-
-exit:
-	return;
-}
 
-static void ReadEFuse_Pseudo(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
-{
-	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
+	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf);
 }
 
-void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf)
 {
-	if (bPseudoTest)
-		ReadEFuse_Pseudo(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
-	else
-		ReadEFuseByIC(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
+	ReadEFuseByIC(Adapter, _offset, _size_byte, pbuf);
 }
 
 /* Do not support BT */
@@ -912,74 +898,9 @@ static void Hal_EFUSEGetEfuseDefinition88E(struct adapter *pAdapter, u8 type, vo
 	}
 }
 
-static void Hal_EFUSEGetEfuseDefinition_Pseudo88E(struct adapter *pAdapter, u8 type, void *pOut)
+void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut)
 {
-	switch (type) {
-	case TYPE_EFUSE_MAX_SECTION:
-		{
-			u8 *pMax_section;
-			pMax_section = (u8 *)pOut;
-			*pMax_section = EFUSE_MAX_SECTION_88E;
-		}
-		break;
-	case TYPE_EFUSE_REAL_CONTENT_LEN:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
-		}
-		break;
-	case TYPE_EFUSE_CONTENT_LEN_BANK:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
-		}
-		break;
-	case TYPE_AVAILABLE_EFUSE_BYTES_BANK:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
-		}
-		break;
-	case TYPE_AVAILABLE_EFUSE_BYTES_TOTAL:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
-		}
-		break;
-	case TYPE_EFUSE_MAP_LEN:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)EFUSE_MAP_LEN_88E;
-		}
-		break;
-	case TYPE_EFUSE_PROTECT_BYTES_BANK:
-		{
-			u8 *pu1Tmp;
-			pu1Tmp = (u8 *)pOut;
-			*pu1Tmp = (u8)(EFUSE_OOB_PROTECT_BYTES_88E);
-		}
-		break;
-	default:
-		{
-			u8 *pu1Tmp;
-			pu1Tmp = (u8 *)pOut;
-			*pu1Tmp = 0;
-		}
-		break;
-	}
-}
-
-void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut, bool bPseudoTest)
-{
-	if (bPseudoTest)
-		Hal_EFUSEGetEfuseDefinition_Pseudo88E(pAdapter, type, pOut);
-	else
-		Hal_EFUSEGetEfuseDefinition88E(pAdapter, type, pOut);
+	Hal_EFUSEGetEfuseDefinition88E(pAdapter, type, pOut);
 }
 
 static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoTest)
@@ -1058,7 +979,7 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 	u8 max_section = 0;
 	u8 tmp_header = 0;
 
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAX_SECTION, (void *)&max_section, bPseudoTest);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAX_SECTION, (void *)&max_section);
 
 	if (!data)
 		return false;
@@ -1311,7 +1232,7 @@ void
 Hal_InitPGData88E(struct adapter *padapter)
 {
 	if (!is_boot_from_eeprom(padapter))
-		EFUSE_ShadowMapUpdate(padapter, false);
+		EFUSE_ShadowMapUpdate(padapter);
 }
 
 void
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 59272570bc5d..de9744d065da 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -121,11 +121,8 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter,
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
 void rtl8188e_free_hal_data(struct adapter *padapter);
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState);
-void rtl8188e_ReadEFuse(struct adapter *Adapter,
-			u16 _offset, u16 _size_byte, u8 *pbuf,
-			bool bPseudoTest);
-void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter,
-				       u8 type, void *pOut, bool bPseudoTest);
+void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf);
+void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut);
 u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
 
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 0b5c8523d42f..c767e985f196 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -102,12 +102,12 @@ extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
 u8 Efuse_CalculateWordCnts(u8 word_en);
-void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
+void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 
-void EFUSE_ShadowMapUpdate(struct adapter *adapter, bool test);
+void EFUSE_ShadowMapUpdate(struct adapter *adapter);
 
 #endif
-- 
2.20.1

