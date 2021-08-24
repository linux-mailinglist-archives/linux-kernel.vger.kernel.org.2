Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3134B3F58FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhHXH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhHXH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:28:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2570C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:27:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p38so43519491lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6tiMzLqXRHliylxjh1LdW7tP5mNrZmd0cSyUDmZ/AM=;
        b=ZPCmJUgwsGF2Uv3eL5+WfjzzC7XOdgwAkuu46Inh0OFvMhOzenpghrNqo4jbjKwRrJ
         KNf9A+Pvliee82I8f9B5v/mrLh46EoGpKj+j4xidj4FzamND9NL5Y++DNuC+fEMn5p7U
         x7CXAN24yGqzSqtwVxwMT10qobR7a4gOxnWNjrEVooBpKJ7NVyHXCRNENX67g2X4KAFS
         pDvusIsJvtdzr0tP/lX7nJoE89qgbHN6s6ptIcvJYczxT5s3M4rO5RAVsa+y+5QnE26C
         p2LNMvkJngRK7aZkrdU04/ljNso4lk0mOlmSsR22gUQH2a0uQ+iBzd3Zvl+5Oe0HfMmz
         /Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6tiMzLqXRHliylxjh1LdW7tP5mNrZmd0cSyUDmZ/AM=;
        b=LJv/nZLZf8XCmkEZ/C3bSQbV2icTNXOCNTR1xX8+BhxmBs7T9lG5Ixh0KaMYuAHtyr
         aQSpDHnqvn6jF4csQH6qJ/mUk+EOxMD6N7HZY+PsLGbqsab2OwbhlPWbWOhNT+Thh1WR
         Ltqp439R5nk/Lj6FjZnXnFw559r3N+HIHN5euca5N8gUrTpeH01o/9/kIvWEv9iS8scS
         GO+Ph8swzakVOCpbSwxQI/kYAPpLU7verqvfVEPA5OpL+pGAIPJ5iS+Bx8TKXCOp0Ltt
         4iqslHMtNPZwGHzhyPHZeIn2lKEy8802kunhtqZApDfckaPq5ydH6fFxRHX+Yr0MZ0KX
         Hljg==
X-Gm-Message-State: AOAM533BVTVt+nQq9y9+KWt45kITXBGEJRTPMcGTu3BUuwB55j+VgK7n
        YU2SWP+WhorsgEI0cmKqWtSg381SXRsvRA==
X-Google-Smtp-Source: ABdhPJyn5LJ8Ti+Iz5Z4gl7+iSstmQ6JrOZa74codDSL9VXtUJJb2ZXcs5tPN8oAL3bZxiVN4lzcSw==
X-Received: by 2002:a05:6512:20d3:: with SMTP id u19mr28412527lfr.104.1629790071912;
        Tue, 24 Aug 2021 00:27:51 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id b12sm1673614lfs.152.2021.08.24.00.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:27:51 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 6/6] staging: r8188eu: make ReadEFuse return an int
Date:   Tue, 24 Aug 2021 10:27:49 +0300
Message-Id: <e81937ce036228aacabd4f1ca167675a4478bd27.1629789580.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629789580.git.paskripkin@gmail.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ReadEFuse can fail in case of _rtw_read() failure. Callers should
handle this error to avoid uninit value bugs, since ReadEFuse
won't initialized passed pbuf in case of usb transfer failure.

To achieve it, ReadEFuseByte() now returns an int and all callers of
ReadEFuseByte() passes error code up to calltrace to rtw_usb_if1_init(),
which fails when reading regiters fails.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c      | 45 ++++++++-----
 drivers/staging/r8188eu/hal/hal_intf.c        |  6 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 65 ++++++++++++-------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 18 +++--
 drivers/staging/r8188eu/include/hal_intf.h    |  6 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_efuse.h   |  4 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  3 +-
 8 files changed, 96 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index dfe60bc6a547..5bfcf80b2678 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -149,7 +149,7 @@ Efuse_CalculateWordCnts(u8 word_en)
 /*  */
 /* 	Created by Roger, 2008.10.21. */
 /*  */
-void
+int
 ReadEFuseByte(
 		struct adapter *Adapter,
 		u16 _offset,
@@ -163,21 +163,21 @@ ReadEFuseByte(
 
 	if (pseudo) {
 		Efuse_Read1ByteFromFakeContent(Adapter, _offset, pbuf);
-		return;
+		return 0;
 	}
 
 	/* Write Address */
 	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
 	error = rtw_read8(Adapter, EFUSE_CTRL + 2, &readbyte);
 	if (error)
-		return;
+		return error;
 
 	rtw_write8(Adapter, EFUSE_CTRL + 2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));
 
 	/* Write bit 32 0 */
 	error = rtw_read8(Adapter, EFUSE_CTRL + 3, &readbyte);
 	if (error)
-		return;
+		return error;
 
 	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
@@ -185,12 +185,12 @@ ReadEFuseByte(
 	retry = 0;
 	error = rtw_read32(Adapter, EFUSE_CTRL, &value32);
 	if (error)
-		return;
+		return error;
 
 	while (!(((value32 >> 24) & 0xff) & 0x80)  && (retry < 10000)) {
 		error = rtw_read32(Adapter, EFUSE_CTRL, &value32);
 		if (error)
-			return;
+			return error;
 
 		retry++;
 	}
@@ -202,9 +202,11 @@ ReadEFuseByte(
 	udelay(50);
 	error = rtw_read32(Adapter, EFUSE_CTRL, &value32);
 	if (error)
-		return;
+		return error;
 
 	*pbuf = (u8)(value32 & 0xff);
+
+	return 0;
 }
 
 /*  */
@@ -225,9 +227,9 @@ ReadEFuseByte(
 /* 					write addr must be after sec5. */
 /*  */
 
-static void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool pseudo)
+static int efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool pseudo)
 {
-	Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, pseudo);
+	return Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, pseudo);
 }
 
 void EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool pseudo
@@ -538,6 +540,7 @@ u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
+	int error;
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
@@ -546,7 +549,9 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	efuse_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, false);
+	error = efuse_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, false);
+	if (error)
+		return _FAIL;
 
 	Efuse_PowerSwitch(padapter, false, false);
 
@@ -556,6 +561,7 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
+	int error;
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
@@ -564,7 +570,9 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	efuse_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
+	error = efuse_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
+	if (error)
+		return _FAIL;
 
 	Efuse_PowerSwitch(padapter, false, false);
 
@@ -835,17 +843,22 @@ efuse_ShadowRead4Byte(
  * 11/11/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse, bool pseudo)
+static int Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse, bool pseudo)
 {
 	u16 mapLen = 0;
+	int error;
 
 	Efuse_PowerSwitch(pAdapter, false, true);
 
 	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
-	efuse_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
+	error = efuse_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
+	if (error)
+		return error;
 
 	Efuse_PowerSwitch(pAdapter, false, false);
+
+	return 0;
 }
 
 /*-----------------------------------------------------------------------------
@@ -864,7 +877,7 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
  * 11/13/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-void EFUSE_ShadowMapUpdate(
+int EFUSE_ShadowMapUpdate(
 	struct adapter *pAdapter,
 	u8 efuseType,
 	bool pseudo)
@@ -877,7 +890,9 @@ void EFUSE_ShadowMapUpdate(
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
 	else
-		Efuse_ReadAllMap(pAdapter, efuseType, pEEPROM->efuse_eeprom_data, pseudo);
+		return Efuse_ReadAllMap(pAdapter, efuseType, pEEPROM->efuse_eeprom_data, pseudo);
+
+	return 0;
 } /*  EFUSE_ShadowMapUpdate */
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index a6d589e89aeb..dce9a58eaf6f 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -12,10 +12,12 @@ void rtw_hal_chip_configure(struct adapter *adapt)
 		adapt->HalFunc.intf_chip_configure(adapt);
 }
 
-void rtw_hal_read_chip_info(struct adapter *adapt)
+int rtw_hal_read_chip_info(struct adapter *adapt)
 {
 	if (adapt->HalFunc.read_adapter_info)
-		adapt->HalFunc.read_adapter_info(adapt);
+		return adapt->HalFunc.read_adapter_info(adapt);
+
+	return _FAIL;
 }
 
 void rtw_hal_read_chip_version(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 69649a381727..41cf432398e2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -871,7 +871,7 @@ rtl8188e_EfusePowerSwitch(
 	hal_EfusePowerSwitch_RTL8188E(pAdapter, bWrite, PwrState);
 }
 
-static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
+static int Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16			_offset,
 	u16			_size_byte,
 	u8 *pbuf,
@@ -886,24 +886,26 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16	**eFuseWord = NULL;
 	u16	efuse_utilized = 0;
 	u8 u1temp = 0;
+	int error = 0;
 
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
 	if ((_offset + _size_byte) > EFUSE_MAP_LEN_88E) {/*  total E-Fuse table is 512bytes */
 		DBG_88E("Hal_EfuseReadEFuse88E(): Invalid offset(%#x) with read bytes(%#x)!!\n", _offset, _size_byte);
-		goto exit;
+		return -EINVAL;
 	}
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (!efuseTbl) {
 		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
-		goto exit;
+		return -ENOMEM;
 	}
 
 	eFuseWord = rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
 	if (!eFuseWord) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+		error = -ENOMEM;
 		goto exit;
 	}
 
@@ -916,12 +918,16 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	/*  1. Read the first byte to check if efuse is empty!!! */
 	/*  */
 	/*  */
-	ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+	error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+	if (error)
+		goto exit;
+
 	if (*rtemp8 != 0xFF) {
 		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
 		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, *rtemp8);
+		error = -EAGAIN;
 		goto exit;
 	}
 
@@ -933,11 +939,15 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		if ((*rtemp8 & 0x1F) == 0x0F) {		/* extended header */
 			u1temp = ((*rtemp8 & 0xE0) >> 5);
 
-			ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+			error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+			if (error)
+				goto exit;
 
 			if ((*rtemp8 & 0x0F) == 0x0F) {
 				eFuse_Addr++;
-				ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+				error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+				if (error)
+					goto exit;
 
 				if (*rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E))
 					eFuse_Addr++;
@@ -958,13 +968,19 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 				/*  Check word enable condition in the section */
 				if (!(wren & 0x01)) {
-					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					if (error)
+						goto exit;
+
 					eFuse_Addr++;
 					efuse_utilized++;
 					eFuseWord[offset][i] = (*rtemp8 & 0xff);
 					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
 						break;
-					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					if (error)
+						goto exit;
+
 					eFuse_Addr++;
 					efuse_utilized++;
 					eFuseWord[offset][i] |= (((u16)*rtemp8 << 8) & 0xff00);
@@ -976,7 +992,9 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		}
 
 		/*  Read next PG header */
-		ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+		error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+		if (error)
+			goto exit;
 
 		if (*rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
 			efuse_utilized++;
@@ -1002,9 +1020,11 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 exit:
 	kfree(efuseTbl);
 	kfree(eFuseWord);
+
+	return error;
 }
 
-static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+static int ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
 {
 	if (!bPseudoTest) {
 		int ret = _FAIL;
@@ -1016,28 +1036,25 @@ static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u1
 			iol_mode_enable(Adapter, 0);
 
 			if (_SUCCESS == ret)
-				goto exit;
+				return 0;
 		}
 	}
-	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
-
-exit:
-	return;
+	return Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
-static void ReadEFuse_Pseudo(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+static int ReadEFuse_Pseudo(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
 {
-	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
+	return Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
-static void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
+static int rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 			       u16 _offset, u16 _size_byte, u8 *pbuf,
 			       bool bPseudoTest)
 {
 	if (bPseudoTest)
-		ReadEFuse_Pseudo(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+		return ReadEFuse_Pseudo(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
 	else
-		ReadEFuseByIC(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+		return ReadEFuseByIC(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
 /* Do not support BT */
@@ -2045,7 +2062,7 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 	return status;
 }
 
-void
+int
 Hal_InitPGData88E(struct adapter *padapter)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
@@ -2053,13 +2070,15 @@ Hal_InitPGData88E(struct adapter *padapter)
 	if (!pEEPROM->bautoload_fail_flag) { /*  autoload OK. */
 		if (!is_boot_from_eeprom(padapter)) {
 			/*  Read EFUSE real map to shadow. */
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+			return EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 		}
 	} else {/* autoload fail */
 		/* update to default value 0xFF */
 		if (!is_boot_from_eeprom(padapter))
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+			return EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 	}
+
+	return 0;
 }
 
 void
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 3826476e3396..687baf4d9d97 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1296,7 +1296,7 @@ readAdapterInfo_8188EU(
 	_ReadLEDSetting(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 }
 
-static void _ReadPROMContent(
+static int _ReadPROMContent(
 	struct adapter *Adapter
 	)
 {
@@ -1307,7 +1307,7 @@ static void _ReadPROMContent(
 	/* check system boot selection */
 	error = rtw_read8(Adapter, REG_9346CR, &eeValue);
 	if (error)
-		return;
+		return error;
 
 	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	eeprom->bautoload_fail_flag	= (eeValue & EEPROM_EN) ? false : true;
@@ -1315,8 +1315,13 @@ static void _ReadPROMContent(
 	DBG_88E("Boot from %s, Autoload %s !\n", (eeprom->EepromOrEfuse ? "EEPROM" : "EFUSE"),
 		(eeprom->bautoload_fail_flag ? "Fail" : "OK"));
 
-	Hal_InitPGData88E(Adapter);
+	error = Hal_InitPGData88E(Adapter);
+	if (error)
+		return error;
+
 	readAdapterInfo_8188EU(Adapter);
+
+	return 0;
 }
 
 static void _ReadRFType(struct adapter *Adapter)
@@ -1333,19 +1338,20 @@ static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
 	MSG_88E("====> %s\n", __func__);
 
 	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
-	_ReadPROMContent(Adapter);
+	if (_ReadPROMContent(Adapter))
+		return _FAIL;
 
 	MSG_88E("<==== %s in %d ms\n", __func__, rtw_get_passing_time_ms(start));
 
 	return _SUCCESS;
 }
 
-static void ReadAdapterInfo8188EU(struct adapter *Adapter)
+static int ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	/*  Read EEPROM size before call any EEPROM function */
 	Adapter->EepromAddressSize = GetEEPROMSize8188E(Adapter);
 
-	_ReadAdapterInfo8188EU(Adapter);
+	return _ReadAdapterInfo8188EU(Adapter);
 }
 
 #define GPIO_DEBUG_PORT_NUM 0
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fa252540e596..9241af39e3a3 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -154,7 +154,7 @@ struct hal_ops {
 
 	void	(*intf_chip_configure)(struct adapter *padapter);
 
-	void	(*read_adapter_info)(struct adapter *padapter);
+	int	(*read_adapter_info)(struct adapter *padapter);
 
 	void	(*enable_interrupt)(struct adapter *padapter);
 	void	(*disable_interrupt)(struct adapter *padapter);
@@ -222,7 +222,7 @@ struct hal_ops {
 
 	void (*EfusePowerSwitch)(struct adapter *padapter, u8 bWrite,
 				 u8 PwrState);
-	void (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset,
+	int (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset,
 			  u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType,
 					u8 type, void *pOut, bool bPseudoTest);
@@ -324,7 +324,7 @@ void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
 void rtw_hal_chip_configure(struct adapter *padapter);
-void rtw_hal_read_chip_info(struct adapter *padapter);
+int rtw_hal_read_chip_info(struct adapter *padapter);
 void rtw_hal_read_chip_version(struct adapter *padapter);
 
 u8 rtw_hal_set_def_var(struct adapter *padapter,
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 3939bf053de1..db9adbd0b024 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -410,7 +410,7 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
 
 /*  EFuse */
 u8 GetEEPROMSize8188E(struct adapter *padapter);
-void Hal_InitPGData88E(struct adapter *padapter);
+int Hal_InitPGData88E(struct adapter *padapter);
 void Hal_EfuseParseIDCode88E(struct adapter *padapter, u8 *hwinfo);
 void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *hwinfo,
 			    bool AutoLoadFail);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index b3ff46db2091..9657b66679e3 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -113,7 +113,7 @@ u8 rtw_BT_efuse_map_write(struct adapter *adapter, u16 addr,
 			  u16 cnts, u8 *data);
 u16 Efuse_GetCurrentSize(struct adapter *adapter, u8 efusetype, bool test);
 u8 Efuse_CalculateWordCnts(u8 word_en);
-void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
+int ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
 void EFUSE_GetEfuseDefinition(struct adapter *adapt, u8 type, u8 type1,
 			      void *out, bool bPseudoTest);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
@@ -128,7 +128,7 @@ u8 Efuse_WordEnableDataWrite(struct adapter *adapter, u16 efuse_addr,
 			     u8 word_en, u8 *data, bool test);
 
 u8 EFUSE_Read1Byte(struct adapter *adapter, u16 address);
-void EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype, bool test);
+int EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype, bool test);
 void EFUSE_ShadowRead(struct adapter *adapt, u8 type, u16 offset, u32 *val);
 
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index e002070f7fba..7a1a296f66b5 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -608,7 +608,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtw_hal_chip_configure(padapter);
 
 	/* step read efuse/eeprom data and get mac_addr */
-	rtw_hal_read_chip_info(padapter);
+	if (rtw_hal_read_chip_info(padapter) == _FAIL)
+		goto free_hal_data;
 
 	/* step 5. */
 	if (rtw_init_drv_sw(padapter) == _FAIL)
-- 
2.32.0

