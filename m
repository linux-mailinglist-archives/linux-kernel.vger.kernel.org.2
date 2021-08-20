Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA67A3F3200
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhHTRIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhHTRIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:08:23 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E07C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:07:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j12so3918598ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CpmQH/TaAKUBSDCapK5jQmWgRR8qnSLMoOd1LlAy1E=;
        b=R+7X8Atqf/oVmRLZ68rbIfef3OaYF4NCaPcCxypy3vlH9YVu0jMm+kswhyzdDMn6L6
         ii2TxtWHjdeZdYlU4HAF088mEexfuDJGb00tg45uqYItcqhJZvELGJoHCKtAJ3jgeo9t
         W64Kpojbq5FKAi5sTrYzbc6vqojq/zEUgV+QfDUMtbvRs/4YvWzdRnbuWFcvBicCTJXJ
         rqMPit13ie2oBDK6C1RSDrUvTxHJWxXWsoJxDjcuhQ17PixkE74iEaFQXJ87XkSfVLvH
         eb0apnUb98oezPToKB/220DuHKZ46CFrVeCf3lEnknoOjwbbF6HxhV/YO/Wn/eq0pcJ9
         8ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CpmQH/TaAKUBSDCapK5jQmWgRR8qnSLMoOd1LlAy1E=;
        b=FmbwVUm4dZbUz43x4/QA4xN/YvAYDN3JjsUSuqpkbBo1+l4gYtRgur2TjG+jnbMK3v
         zYUFG21k7zgG9xVZHwkaZZNhAhYlJRpdLyzzIjBL1m8bPWExyGz+Xa1H1MqQQ+hPT9SZ
         YgWXD6Th/0k84TU53mvGVIJ/R08qDAKiZO+ATqRadoAY4+FhDFf6E5PoLLeP0ZfibyfL
         aNj9KsKaloZ2Dz7LGon/PQGr611txoZ75Fe7jUu0eAP9hvbUaTacC26WEcDBnTzbhP4Y
         Ck9s1eX8wMPpv7LKHN4eFfzYy/w/a5ox84e3snRa18F8MecGQ1lc6IJFtD/ZWrV4EMr2
         q4aQ==
X-Gm-Message-State: AOAM530WjiVue7M032Ymdlttuw3lhWjRxFY293vu+qSwT5VWgRnkE3Uc
        sbrUxJRV4ebaKK1SR98gXlU=
X-Google-Smtp-Source: ABdhPJwozOmijmbbP23jsqhQYwrkQnfS4JdqhTgnMHv7Eeyiyz5MK0RxraYy857sMfsyV7Irkhkjiw==
X-Received: by 2002:a2e:a58b:: with SMTP id m11mr16797729ljp.342.1629479263261;
        Fri, 20 Aug 2021 10:07:43 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id m10sm614621ljq.126.2021.08.20.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:07:42 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC 2/3] staging: r8188eu: add error handling to ReadFuse
Date:   Fri, 20 Aug 2021 20:07:41 +0300
Message-Id: <0e2df1ac9e1031824a1cdb7b24594d2d1b99e382.1629479152.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629479152.git.paskripkin@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ReadEFuseByte() internally calls rtw_read8() which can fail. To avoid
uninit value bugs we should properly handle error sutiation and deliver
the error to caller.

To achieve it, some functions now return an int, and the error
which could occur in ReadEFuseByte() is handled on the top level.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c      | 46 +++++++++-----
 drivers/staging/r8188eu/hal/hal_intf.c        |  6 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 62 +++++++++++++------
 drivers/staging/r8188eu/hal/usb_halinit.c     | 20 ++++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 43 +++++++++++--
 drivers/staging/r8188eu/include/hal_intf.h    |  6 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_efuse.h   |  4 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  4 +-
 9 files changed, 138 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 47ff73b28380..5fcff0d6eb26 100644
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
@@ -163,32 +163,32 @@ ReadEFuseByte(
 
 	if (pseudo) {
 		Efuse_Read1ByteFromFakeContent(Adapter, _offset, pbuf);
-		return;
+		return 0;
 	}
 
 	/* Write Address */
 	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
 	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2, &error);
 	if (error)
-		return;
+		return error;
 	rtw_write8(Adapter, EFUSE_CTRL + 2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));
 
 	/* Write bit 32 0 */
 	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 3, &error);
 	if (error)
-		return;
+		return error;
 	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
 	/* Check bit 32 read-ready */
 	retry = 0;
 	value32 = rtw_read32(Adapter, EFUSE_CTRL, &error);
 	if (error)
-		return;
+		return error;
 
 	while (!(((value32 >> 24) & 0xff) & 0x80)  && (retry < 10000)) {
 		value32 = rtw_read32(Adapter, EFUSE_CTRL, &error);
 		if (error)
-			return;
+			return error;
 		retry++;
 	}
 
@@ -199,9 +199,11 @@ ReadEFuseByte(
 	udelay(50);
 	value32 = rtw_read32(Adapter, EFUSE_CTRL, &error);
 	if (error)
-		return;
+		return error;
 
 	*pbuf = (u8)(value32 & 0xff);
+
+	return 0;
 }
 
 /*  */
@@ -222,9 +224,9 @@ ReadEFuseByte(
 /* 					write addr must be after sec5. */
 /*  */
 
-static void efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool pseudo)
+static int efuse_ReadEFuse(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool pseudo)
 {
-	Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, pseudo);
+	return Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, pseudo);
 }
 
 void EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool pseudo
@@ -539,6 +541,7 @@ u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
+	int res;
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
@@ -547,7 +550,9 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	efuse_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, false);
+	res = efuse_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, false);
+	if (res)
+		return _FAIL;
 
 	Efuse_PowerSwitch(padapter, false, false);
 
@@ -557,6 +562,7 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
+	int res;
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
@@ -565,7 +571,9 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 
 	Efuse_PowerSwitch(padapter, false, true);
 
-	efuse_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
+	res = efuse_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
+	if (res)
+		return _FAIL;
 
 	Efuse_PowerSwitch(padapter, false, false);
 
@@ -836,17 +844,22 @@ efuse_ShadowRead4Byte(
  * 11/11/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse, bool pseudo)
+static int Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse, bool pseudo)
 {
 	u16 mapLen = 0;
+	int res;
 
 	Efuse_PowerSwitch(pAdapter, false, true);
 
 	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
-	efuse_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
+	res = efuse_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
+	if (res)
+		return res;
 
 	Efuse_PowerSwitch(pAdapter, false, false);
+
+	return res;
 }
 
 /*-----------------------------------------------------------------------------
@@ -865,20 +878,23 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
  * 11/13/2008	MHC		Create Version 0.
  *
  *---------------------------------------------------------------------------*/
-void EFUSE_ShadowMapUpdate(
+int EFUSE_ShadowMapUpdate(
 	struct adapter *pAdapter,
 	u8 efuseType,
 	bool pseudo)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(pAdapter);
 	u16 mapLen = 0;
+	int res = 0;
 
 	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
 	else
-		Efuse_ReadAllMap(pAdapter, efuseType, pEEPROM->efuse_eeprom_data, pseudo);
+		res = Efuse_ReadAllMap(pAdapter, efuseType, pEEPROM->efuse_eeprom_data, pseudo);
+
+	return res;
 } /*  EFUSE_ShadowMapUpdate */
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index a6d589e89aeb..94536659cd7c 100644
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
+	return 0;
 }
 
 void rtw_hal_read_chip_version(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 0a2c08a24ad8..2ab58891ee9a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -864,7 +864,7 @@ rtl8188e_EfusePowerSwitch(
 	hal_EfusePowerSwitch_RTL8188E(pAdapter, bWrite, PwrState);
 }
 
-static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
+static int Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16			_offset,
 	u16			_size_byte,
 	u8 *pbuf,
@@ -879,6 +879,7 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16	**eFuseWord = NULL;
 	u16	efuse_utilized = 0;
 	u8 u1temp = 0;
+	int error;
 
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
@@ -909,12 +910,16 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	/*  1. Read the first byte to check if efuse is empty!!! */
 	/*  */
 	/*  */
-	ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
-	if (*rtemp8 != 0xFF) {
+	error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+	if (error) {
+		DBG_88E("Failed to read EFUSE byte\n");
+		goto exit;
+	} else if (*rtemp8 != 0xFF) {
 		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
 		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, *rtemp8);
+		error = -ENOENT;
 		goto exit;
 	}
 
@@ -926,11 +931,15 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
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
@@ -951,13 +960,19 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
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
@@ -969,7 +984,9 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 		}
 
 		/*  Read next PG header */
-		ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+		error = ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+		if (error)
+			goto exit;
 
 		if (*rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
 			efuse_utilized++;
@@ -995,10 +1012,14 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 exit:
 	kfree(efuseTbl);
 	kfree(eFuseWord);
+
+	return error;
 }
 
-static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+static int ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
 {
+	int res = 0;
+
 	if (!bPseudoTest) {
 		int ret = _FAIL;
 		if (rtw_IOL_applied(Adapter)) {
@@ -1012,25 +1033,25 @@ static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u1
 				goto exit;
 		}
 	}
-	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
+	res = Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
 
 exit:
-	return;
+	return res;
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
@@ -2043,21 +2064,24 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 	return status;
 }
 
-void
+int
 Hal_InitPGData88E(struct adapter *padapter)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
+	int res = 0;
 
 	if (!pEEPROM->bautoload_fail_flag) { /*  autoload OK. */
 		if (!is_boot_from_eeprom(padapter)) {
 			/*  Read EFUSE real map to shadow. */
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+			res = EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 		}
 	} else {/* autoload fail */
 		/* update to default value 0xFF */
 		if (!is_boot_from_eeprom(padapter))
-			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+			res = EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 	}
+
+	return res;
 }
 
 void
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 73ef2e0ead19..8df8a8b7c738 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1275,7 +1275,7 @@ readAdapterInfo_8188EU(
 	_ReadLEDSetting(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 }
 
-static void _ReadPROMContent(
+static int _ReadPROMContent(
 	struct adapter *Adapter
 	)
 {
@@ -1286,7 +1286,7 @@ static void _ReadPROMContent(
 	/* check system boot selection */
 	eeValue = rtw_read8(Adapter, REG_9346CR, &error);
 	if (error)
-		return;
+		return error;
 
 	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	eeprom->bautoload_fail_flag	= (eeValue & EEPROM_EN) ? false : true;
@@ -1294,8 +1294,13 @@ static void _ReadPROMContent(
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
@@ -1308,23 +1313,26 @@ static void _ReadRFType(struct adapter *Adapter)
 static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	u32 start = jiffies;
+	int res;
 
 	MSG_88E("====> %s\n", __func__);
 
 	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
-	_ReadPROMContent(Adapter);
+	res = _ReadPROMContent(Adapter);
+	if (res)
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
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 980af6c02be5..f137b775976c 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -118,8 +118,14 @@ static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr, int *error)
 	len = 1;
 
 	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
-	if (likely(error))
-		*error = res < 0? res: 0;
+	if (likely(error)) {
+		if (res < 0) {
+			pr_err("r8188eu: Failed to read 8 bytes: %d\n", res);
+			*error = res;
+		} else {
+			*error = 0;
+		}
+	}
 
 	return data;
 
@@ -130,12 +136,25 @@ static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr, int *error)
 	u8 requesttype;
 	u16 wvalue;
 	u16 len;
-	__le32 data;
+	__le32 data = 0;
+	int res;
+
+	if (unlikely(!error))
+		WARN_ON_ONCE("r8188eu: Reading w/o error checking is bad idea\n");
 
 	requesttype = 0x01;/* read_in */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	
+	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	if (likely(error)) {
+		if (res < 0) {
+			pr_err("r8188eu: Failed to read 8 bytes: %d\n", res);
+			*error = res;
+		} else {
+			*error = 0;
+		}
+	}
 
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
@@ -145,14 +164,26 @@ static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr, int *error)
 	u8 requesttype;
 	u16 wvalue;
 	u16 len;
-	__le32 data;
+	__le32 data = 0;
+	int res;
+
+	if (unlikely(!error))
+		WARN_ON_ONCE("r8188eu: Reading w/o error checking is bad idea\n");
 
 	requesttype = 0x01;/* read_in */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	if (likely(error)) {
+		if (res < 0) {
+			pr_err("r8188eu: Failed to read 8 bytes: %d\n", res);
+			*error = res;
+		} else {
+			*error = 0;
+		}
+	}
 
 	return le32_to_cpu(data);
 }
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
index e002070f7fba..f950a31d061e 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -608,7 +608,9 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtw_hal_chip_configure(padapter);
 
 	/* step read efuse/eeprom data and get mac_addr */
-	rtw_hal_read_chip_info(padapter);
+	status = rtw_hal_read_chip_info(padapter);
+	if (status)
+		goto free_hal_data;
 
 	/* step 5. */
 	if (rtw_init_drv_sw(padapter) == _FAIL)
-- 
2.32.0

