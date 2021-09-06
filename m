Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22B401FAB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245079AbhIFS1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbhIFS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D0C0613C1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lc21so14953561ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gn3JZ721xkF8UAoF6bD2hb3gNt9uYsYsyqOLJDbpNX8=;
        b=Rc9K8vBFWaownlIVMWExh8P7baEUe8vzvdaEaNoaoSFGA6Bkq75E6qK3Czp+gGadPB
         8Ki5xzpSOWlJvzQE5NZGIJoKCgvWQkle+IC01BLFxj+HeF0XTZWABTsYtCJIYTbQpx03
         VqkO4RDJwWHRbGj2Ks50PJB6s4vZawlwRhYIM1h0HImolVwLbsxPZD2QDmvHpYrSpf9D
         1U34C2oqog2iSM4b9YXP1EpLjMpws8ZfUPp6gcmlbpYztWTqcoa+mgfrx1XBa6ECqw/h
         ch8dCeR0kgwuToNMBxjw7VyWoO+X+t0/Yby8ZPUBXqejSf3TPnah1t0bwej1G1Tv30of
         A8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gn3JZ721xkF8UAoF6bD2hb3gNt9uYsYsyqOLJDbpNX8=;
        b=dMc1BaoDS0HPHNIr5c0xiqJ8Envap0vjwqSSuiSs2jUkTbHmW9yJtL6azdXoC9lsXD
         hdgsfTj45EIkKVIuMuD65X5gbt/dwzWEkOKJHEb3dBnC6GcP7mVxaJPALaFupJQjHcPJ
         ODZos3yWt5q5TSYN7AHmVbqL9GOK/t8gmo7Gr7VpcznTxDgglNci8Js5ERJZIdJddBg1
         HOlQiufmkLolDAYcUSnkOFNgbaF1AOWcgvMfWWCv5jqKlOViXt00ZDYZCiB8TiWBEU3Y
         o+BqWaFM0ZCrtrfxd0BNok0A3vwZrOkeW7eM28d4gOnIn5Lj0wXYBmC+defYSsxCoTpg
         QVkg==
X-Gm-Message-State: AOAM530lhZMiFiOhUUC4DxCi+Y/roLRkUqCkDnWi4BXks3lXLv/SevCn
        lJ3YLVHERUOfHrZqrALhBGI=
X-Google-Smtp-Source: ABdhPJzQcRwi66nA9boHXsEocfHfK7/twfbAlfCWC6IuhE5QZucRmuPeYgS5q8adbU5ZZpEt/URQwA==
X-Received: by 2002:a17:906:4994:: with SMTP id p20mr14975639eju.38.1630952720555;
        Mon, 06 Sep 2021 11:25:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 26/40] staging: r8188eu: remove EfuseGetCurrentSize from hal_ops
Date:   Mon,  6 Sep 2021 20:24:24 +0200
Message-Id: <20210906182438.5417-27-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove EfuseGetCurrentSize hal_ops and remove its wrapper
Efuse_GetCurrentSize(). Call rtl8188e_EfuseGetCurrentSize() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c      | 31 +------------------
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  7 ++---
 drivers/staging/r8188eu/include/hal_intf.h    |  3 +-
 drivers/staging/r8188eu/include/rtw_efuse.h   |  1 -
 4 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 42462a91ac58..bae9a32ec27e 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -58,35 +58,6 @@ Efuse_Write1ByteToFakeContent(
 	return true;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	efuse_GetCurrentSize
- *
- * Overview:	Get current efuse size!!!
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/16/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-u16
-Efuse_GetCurrentSize(
-	struct adapter *pAdapter,
-	u8 efuseType,
-	bool pseudo)
-{
-	u16 ret = 0;
-
-	ret = pAdapter->HalFunc.EfuseGetCurrentSize(pAdapter, efuseType, pseudo);
-
-	return ret;
-}
-
 /*  11/16/2008 MH Add description. Get current efuse area enabled word!!. */
 u8
 Efuse_CalculateWordCnts(u8 word_en)
@@ -404,7 +375,7 @@ u16 efuse_GetMaxSize(struct adapter *padapter)
 u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 {
 	rtl8188e_EfusePowerSwitch(padapter, false, true);
-	*size = Efuse_GetCurrentSize(padapter, EFUSE_WIFI, false);
+	*size = rtl8188e_EfuseGetCurrentSize(padapter, EFUSE_WIFI, false);
 	rtl8188e_EfusePowerSwitch(padapter, false, false);
 
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 47bc2f6ee37e..8b7fde0a49f1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1181,7 +1181,7 @@ static u16 Hal_EfuseGetCurrentSize_Pseudo(struct adapter *pAdapter, bool bPseudo
 	return ret;
 }
 
-static u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest)
+u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest)
 {
 	u16	ret = 0;
 
@@ -1323,7 +1323,7 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 			if (!PgWriteSuccess)
 				return false;
 			else
-				efuse_addr = Efuse_GetCurrentSize(pAdapter, efuseType, bPseudoTest);
+				efuse_addr = rtl8188e_EfuseGetCurrentSize(pAdapter, efuseType, bPseudoTest);
 		} else {
 			efuse_addr = efuse_addr + (pFixPkt->word_cnts * 2) + 1;
 		}
@@ -1612,7 +1612,7 @@ hal_EfusePgCheckAvailableAddr(
 	/* Change to check TYPE_EFUSE_MAP_LEN , because 8188E raw 256, logic map over 256. */
 	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&efuse_max_available_len, false);
 
-	if (Efuse_GetCurrentSize(pAdapter, efuseType, bPseudoTest) >= efuse_max_available_len)
+	if (rtl8188e_EfuseGetCurrentSize(pAdapter, efuseType, bPseudoTest) >= efuse_max_available_len)
 		return false;
 	return true;
 }
@@ -1782,7 +1782,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	/*  Efuse related function */
-	pHalFunc->EfuseGetCurrentSize = &rtl8188e_EfuseGetCurrentSize;
 	pHalFunc->Efuse_PgPacketRead = &rtl8188e_Efuse_PgPacketRead;
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 6db73da08e2b..640195a4c830 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -177,8 +177,6 @@ struct hal_ops {
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 
-	u16	(*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType,
-				       bool bPseudoTest);
 	int	(*Efuse_PgPacketRead)(struct adapter *adapter, u8 offset,
 				      u8 *data, bool bPseudoTest);
 	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset,
@@ -221,6 +219,7 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 			bool bPseudoTest);
 void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType,
 				       u8 type, void *pOut, bool bPseudoTest);
+u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 1dc49d82abf4..5cd1313dbe36 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -111,7 +111,6 @@ u8 rtw_BT_efuse_map_read(struct adapter *adapter, u16 addr,
 			 u16 cnts, u8 *data);
 u8 rtw_BT_efuse_map_write(struct adapter *adapter, u16 addr,
 			  u16 cnts, u8 *data);
-u16 Efuse_GetCurrentSize(struct adapter *adapter, u8 efusetype, bool test);
 u8 Efuse_CalculateWordCnts(u8 word_en);
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
-- 
2.33.0

