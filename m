Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831EE3FB313
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhH3JXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbhH3JW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:22:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e26so2904195wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNazg38ZZpNIZO+mDQrkb2pijeBjr/Hr2yVsiJB4Qnk=;
        b=eAXdYW0Tnzxd8Pwwd6rTIzIJfqCJ3y486QrbVsw36IDjbczTL7LmH29XmtGu1TBW1a
         Zs6yMsOgY16tYAp0jqnsRAPKsuMsBsuVn73xb5GEFF1nOfvqMrJoYXD7evw9PXNLWrWs
         3MaeGP7OfiA2bA5IgEe6S+3EpO6J+5nF2s0Ytb/6akxccJ4iUue5ICIt39FE1UbK+/hI
         WjOwVGj/73aU3q+wzm2sThAviQDf/zc0ooy2zVdJyyffDu6ddiOAV/Nc9+b1O9mkrAXN
         zLQ5wM6Xq1yzw3+1EgIo90lzWwx5b5+piyuznyC3TK93xi63q6yIpGDJLaqvc+iVWJ9E
         Mrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNazg38ZZpNIZO+mDQrkb2pijeBjr/Hr2yVsiJB4Qnk=;
        b=DSWA3sXihE1CYGlNqGy/3iaJjFqY8AMbnKrRamtMniUfXGh62Ma80sDfUuQBWsGzbu
         HsPDCEXvGQF656NoPomg90vCG+rvBAYj392okVd5KTn/YcBF4wlgxnnpuSi2X+AK+dIp
         1EizJ3wc+KH1KOLROSmC9woC+sBpHzlnIElxdBtA7b/UImNSK5Coi0X4XbSvIpBTpg+x
         ccSyDVW6csRA9q/3oHAgD7pA/jzViV93YpiGQKQCmq3mR5ncFYWtuRtfmAFkrXaSxPYA
         E04IRESztZAYt8L6QMJhNyG3NJMMSYK7LfMptC0xYB5DuwItBX+Bg0JdEdENeULhdqu4
         TfOg==
X-Gm-Message-State: AOAM5321uKCC/SqvEvjsF4qBjG0yJbK4x9/nPKISVDJOE/FR7DRKZ42P
        ASAei+XikuQaTI6H/JQgK4Q=
X-Google-Smtp-Source: ABdhPJxIxLwBRnalgfALKdQ3fmtcygPN4OzRcjO43qqueD9k68MMBL+vVIGr7lNMVXubi38dnVUOJQ==
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr21564880wmc.148.1630315323729;
        Mon, 30 Aug 2021 02:22:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id j1sm18378248wrd.50.2021.08.30.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 02:22:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove ICType from struct HAL_VERSION
Date:   Mon, 30 Aug 2021 11:21:52 +0200
Message-Id: <20210830092153.9283-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830092153.9283-1-straube.linux@gmail.com>
References: <20210830092153.9283-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IC type is always 8188E. Remove ICType from struct HAL_VERSION,
all macros that check it and related code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_com.c         | 13 +---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  1 -
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     | 39 +++---------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 drivers/staging/r8188eu/include/HalVerDef.h   | 61 -------------------
 5 files changed, 11 insertions(+), 105 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index f09d4d49b159..eee57cbd6dd2 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -15,18 +15,7 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 	uint cnt = 0;
 	char buf[128];
 
-	if (IS_81XXC(chip_vers)) {
-		cnt += sprintf((buf + cnt), "Chip Version Info: %s_",
-			       IS_92C_SERIAL(chip_vers) ?
-			       "CHIP_8192C" : "CHIP_8188C");
-	} else if (IS_92D(chip_vers)) {
-		cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8192D_");
-	} else if (IS_8723_SERIES(chip_vers)) {
-		cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8723A_");
-	} else if (IS_8188E(chip_vers)) {
-		cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
-	}
-
+	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
 	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
 		       "Normal_Chip" : "Test_Chip");
 	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 14758361960c..3da5c27b6805 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1698,7 +1698,6 @@ static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
 	pHalData = GET_HAL_DATA(padapter);
 
 	value32 = rtw_read32(padapter, REG_SYS_CFG);
-	ChipVersion.ICType = CHIP_8188E;
 	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
 
 	ChipVersion.RFType = RF_TYPE_1T1R;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index ec1d7e90547e..ee0c96890cf3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -487,9 +487,6 @@ void Hal_SetSingleCarrierTx(struct adapter *pAdapter, u8 bStart)
 
 void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
 {
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
-	bool		is92C = IS_92C_SERIAL(pHalData->VersionID);
-
 	u8 rfPath;
 	u32              reg58 = 0x0;
 	switch (pAdapter->mppriv.antenna_tx) {
@@ -518,21 +515,10 @@ void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
 		PHY_SetBBReg(pAdapter, rFPGA0_RFMOD, bCCKEn, 0x0);
 		PHY_SetBBReg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x0);
 
-		if (is92C) {
-			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT(19), 0x01);
-			rtw_usleep_os(100);
-			if (rfPath == RF_PATH_A)
-				write_rfreg(pAdapter, RF_PATH_B, 0x00, 0x10000); /*  PAD all on. */
-			else if (rfPath == RF_PATH_B)
-				write_rfreg(pAdapter, RF_PATH_A, 0x00, 0x10000); /*  PAD all on. */
-			write_rfreg(pAdapter, rfPath, 0x00, 0x2001f); /*  PAD all on. */
-			rtw_usleep_os(100);
-		} else {
-			write_rfreg(pAdapter, rfPath, 0x21, 0xd4000);
-			rtw_usleep_os(100);
-			write_rfreg(pAdapter, rfPath, 0x00, 0x2001f); /*  PAD all on. */
-			rtw_usleep_os(100);
-		}
+		write_rfreg(pAdapter, rfPath, 0x21, 0xd4000);
+		rtw_usleep_os(100);
+		write_rfreg(pAdapter, rfPath, 0x00, 0x2001f); /*  PAD all on. */
+		rtw_usleep_os(100);
 
 		/* for dynamic set Power index. */
 		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000500);
@@ -549,18 +535,11 @@ void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
 		}
 		write_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn, 0x1);
 		write_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
-		if (is92C) {
-			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT(19), 0x00);
-			rtw_usleep_os(100);
-			write_rfreg(pAdapter, RF_PATH_A, 0x00, 0x32d75); /*  PAD all on. */
-			write_rfreg(pAdapter, RF_PATH_B, 0x00, 0x32d75); /*  PAD all on. */
-			rtw_usleep_os(100);
-		} else {
-			write_rfreg(pAdapter, rfPath, 0x21, 0x54000);
-			rtw_usleep_os(100);
-			write_rfreg(pAdapter, rfPath, 0x00, 0x30000); /*  PAD all on. */
-			rtw_usleep_os(100);
-		}
+
+		write_rfreg(pAdapter, rfPath, 0x21, 0x54000);
+		rtw_usleep_os(100);
+		write_rfreg(pAdapter, rfPath, 0x00, 0x30000); /*  PAD all on. */
+		rtw_usleep_os(100);
 
 		/* Stop for dynamic set Power index. */
 		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000100);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 5cdabf43d4fd..147c51255878 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1765,7 +1765,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 			/*  Forece leave RF low power mode for 1T1R to prevent conficting setting in Fw power */
 			/*  saving sequence. 2010.06.07. Added by tynli. Suggested by SD3 yschang. */
-			if ((psmode != PS_MODE_ACTIVE) && (!IS_92C_SERIAL(haldata->VersionID)))
+			if (psmode != PS_MODE_ACTIVE)
 				ODM_RF_Saving(podmpriv, true);
 			rtl8188e_set_FwPwrMode_cmd(Adapter, psmode);
 		}
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index a0f5bf52e75a..3a687f7c5b82 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -3,20 +3,6 @@
 #ifndef __HAL_VERSION_DEF_H__
 #define __HAL_VERSION_DEF_H__
 
-enum HAL_IC_TYPE {
-	CHIP_8192S	=	0,
-	CHIP_8188C	=	1,
-	CHIP_8192C	=	2,
-	CHIP_8192D	=	3,
-	CHIP_8723A	=	4,
-	CHIP_8188E	=	5,
-	CHIP_8881A	=	6,
-	CHIP_8812A	=	7,
-	CHIP_8821A	=	8,
-	CHIP_8723B	=	9,
-	CHIP_8192E	=	10,
-};
-
 enum HAL_CHIP_TYPE {
 	TEST_CHIP	=	0,
 	NORMAL_CHIP	=	1,
@@ -50,7 +36,6 @@ enum HAL_RF_TYPE {
 };
 
 struct HAL_VERSION {
-	enum HAL_IC_TYPE	ICType;
 	enum HAL_CHIP_TYPE	ChipType;
 	enum HAL_CUT_VERSION	CUTVersion;
 	enum HAL_VENDOR		VendorType;
@@ -59,7 +44,6 @@ struct HAL_VERSION {
 };
 
 /*  Get element */
-#define GET_CVID_IC_TYPE(version)	(((version).ICType))
 #define GET_CVID_CHIP_TYPE(version)	(((version).ChipType))
 #define GET_CVID_RF_TYPE(version)	(((version).RFType))
 #define GET_CVID_MANUFACTUER(version)	(((version).VendorType))
@@ -69,17 +53,6 @@ struct HAL_VERSION {
 /* Common Macro. -- */
 /* HAL_VERSION VersionID */
 
-/*  HAL_IC_TYPE_E */
-#define IS_81XXC(version)				\
-	(((GET_CVID_IC_TYPE(version) == CHIP_8192C) ||	\
-	 (GET_CVID_IC_TYPE(version) == CHIP_8188C)) ? true : false)
-#define IS_8723_SERIES(version)				\
-	((GET_CVID_IC_TYPE(version) == CHIP_8723A) ? true : false)
-#define IS_92D(version)					\
-	((GET_CVID_IC_TYPE(version) == CHIP_8192D) ? true : false)
-#define IS_8188E(version)				\
-	((GET_CVID_IC_TYPE(version) == CHIP_8188E) ? true : false)
-
 /* HAL_CHIP_TYPE_E */
 #define IS_TEST_CHIP(version)				\
 	((GET_CVID_CHIP_TYPE(version) == TEST_CHIP) ? true : false)
@@ -112,38 +85,4 @@ struct HAL_VERSION {
 #define IS_2T2R(version)				\
 	((GET_CVID_RF_TYPE(version) == RF_TYPE_2T2R) ? true : false)
 
-/* Chip version Macro. -- */
-#define IS_81XXC_TEST_CHIP(version)			\
-	((IS_81XXC(version) && (!IS_NORMAL_CHIP(version))) ? true : false)
-
-#define IS_92C_SERIAL(version)				\
-	((IS_81XXC(version) && IS_2T2R(version)) ? true : false)
-#define IS_81xxC_VENDOR_UMC_A_CUT(version)		\
-	(IS_81XXC(version) ? (IS_CHIP_VENDOR_UMC(version) ?	\
-	(IS_A_CUT(version) ? true : false) : false) : false)
-#define IS_81xxC_VENDOR_UMC_B_CUT(version)		\
-	(IS_81XXC(version) ? (IS_CHIP_VENDOR_UMC(version) ?	\
-	(IS_B_CUT(version) ? true : false) : false) : false)
-#define IS_81xxC_VENDOR_UMC_C_CUT(version)		\
-	(IS_81XXC(version) ? (IS_CHIP_VENDOR_UMC(version) ? \
-	 (IS_C_CUT(version) ? true : false) : false) : false)
-
-#define IS_NORMAL_CHIP92D(version)			\
-	((IS_92D(version)) ?				\
-	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false) : false)
-
-#define IS_92D_SINGLEPHY(version)			\
-	((IS_92D(version)) ? (IS_2T2R(version) ? true : false) : false)
-#define IS_92D_C_CUT(version)				\
-	((IS_92D(version)) ? (IS_C_CUT(version) ? true : false) : false)
-#define IS_92D_D_CUT(version)				\
-	((IS_92D(version)) ? (IS_D_CUT(version) ? true : false) : false)
-#define IS_92D_E_CUT(version)				\
-	((IS_92D(version)) ? (IS_E_CUT(version) ? true : false) : false)
-
-#define IS_8723A_A_CUT(version)				\
-	((IS_8723_SERIES(version)) ? (IS_A_CUT(version) ? true : false) : false)
-#define IS_8723A_B_CUT(version)				\
-	((IS_8723_SERIES(version)) ? (IS_B_CUT(version) ? true : false) : false)
-
 #endif
-- 
2.33.0

