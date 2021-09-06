Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23412402043
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbhIFTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbhIFTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9EDC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h9so15146854ejs.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ylsz5hLK/1lXA/L9MdBP0SRDSx5HJpGwb+F0dPt9n6U=;
        b=Q8yPxunALisprQGaT3wCJctl/aJl+vqEDVLVPDScw3EtB6BXPDfdUb9S7XxIAw9B9x
         TiMGX0hqsP6flMXDhtWrfBZU4likiKh46UXboGLUKLDD27Tt9g/nuhLx4LutkWwU8sDn
         Ni58HehBrVADO5Pu8kVK+A7YiuW1VHoyTeqW4vWxAIP2wCrq4HcZe1JhdQeMlGdcQfhY
         Dm4lodHkRMVAg4UMh3xQK9aMkZmYLPZLzw0isF9g0Ic8PmMQMp2av3bY5d+Mp1qQTyqG
         HoNUdPT9zr2FF8jD9GcBBK2CSeOSfKxA0xG7LvUdnrgv2BeM5h57N8I8NOXDvov3w4zS
         XkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylsz5hLK/1lXA/L9MdBP0SRDSx5HJpGwb+F0dPt9n6U=;
        b=bCIA6B0Ot/xeOmBIhtrsR1QJHrfmldkvkZ1Om7nZDE0I/bbQMPsrZ7IKERlvLFYXc/
         08defNq5NyvJbOj5ADxlhdXy3wyKAP1Pw1rJ6pw6Gg4DHwi8yG5gqDloecZOe1h8yC7G
         SoDCG0nvtb+tJQGbm+j6Vy4/d3Qz+3PGYGkmkS0GgPViI+1FSWk7acbwS5Pk9e/Vz3Jl
         FbM2n2VUA6fw12E3wiBTYFvI1rvk1iLNlf7GBMOitEE0CdgyQYfO+tifKf4j8ih3JGNR
         o8hEbG1SNNty5WnyEjIFcZyW/Y9YTrY5H8Y9FyLWHmH/KGalBhO+ITqwXD1RfJBC+e7I
         yGpw==
X-Gm-Message-State: AOAM532gtJThpQR7P6zktIFzBn8Bq1ZeLEJ963Tl77E80Y+UCxRv736H
        bSwMHbHgt7BMrUc9GBre9c0=
X-Google-Smtp-Source: ABdhPJyjDAFHl8K5Ai8iYND58HWfAzlrDHFxlhReuawLAmu5HchcjNoFMMtFAt3Lb9az4/tPtXV67w==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr14845567ejk.290.1630954984701;
        Mon, 06 Sep 2021 12:03:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 26/40] staging: r8188eu: remove EfuseGetCurrentSize from hal_ops
Date:   Mon,  6 Sep 2021 21:02:09 +0200
Message-Id: <20210906190223.11396-27-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove EfuseGetCurrentSize from hal_ops and remove its wrapper
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

