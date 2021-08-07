Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F453E3478
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhHGJtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhHGJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958DC0617A1
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c16so14302064wrp.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOQM0bgXnBCiZQjJ/bKeFfLLhqNExKGKA4dlXPtuUTI=;
        b=DOE08b76Odr9xAv6RmeRNcugUkaYW4aATmfWOpfc68jnlbwoxal0iHX09n2czFKOB4
         s6hHUY6tHZIs1dA69m5DNT71SYmWYOLm2zNGiKySW7cTAf52f4NVK0SjT+Q4JhYDM7Al
         aTajxGs+ozipQut3FNh3/b/X6A0nBsakMUEdoTQRfex88cP5pkTGy/AOi+9vGbSIDpi8
         1fEK8W4Pu4KcV5ksuVjzfPS9uvaJ57dTkVzeL8RSkHoUmRCtEEojW6bGiBEekJwhXuI0
         +VPq2VF/7Y9M6dCIcDPcRK5h9iiJOP/SoS8g3ZPhzEuTjc2Gv7aKvRfs+15DGHCqGhtS
         kSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOQM0bgXnBCiZQjJ/bKeFfLLhqNExKGKA4dlXPtuUTI=;
        b=DAgmQkSTxaiEolZg2Qh+JHL6uJIfztm1nXW0kR3/DDU9UUKd5vtAV8EpIrKbpOwdmz
         CErJ97vfDl4IQrc17I/0Pl7VYzL90mhbB7K0LXEHCBjSK/BUqEyUUvhZJ3Uu8PLHpLRb
         L6bRbzlTO5DGQm+WTzVpQ66qPLo41vHpRPeuGp0WAlfn+rPBSzElEkhfEFkshEQD0EiK
         B9E+ds+RqnM7gmvkDaOsnNXbnI7sHZL6GjhZ6f90ZD311jcmmN7f0n1qNalUzAdWdRPD
         /RleT1mtiw9bLvzeKSGbod0jaQ1xj+n32Kz3rBMXC1Z8RZg4D6izpZEY485Vj6/UihJ/
         pNdg==
X-Gm-Message-State: AOAM531yBFsZyff7iFRz58ggMRPFkILCFFEGF/icOC7SRPhH/XfU3eEC
        VxsDa7jo8OPnubrqqy0apUGUD40WdW8=
X-Google-Smtp-Source: ABdhPJz1tO7xcf9gr4bAGNxXCDz++DdB30a6bFlMx9ziy7cpsltrDxQRzBZ3M+pDoKDtP5hjwtfEBw==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr15161548wrv.167.1628329712678;
        Sat, 07 Aug 2021 02:48:32 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id b14sm12964481wrm.43.2021.08.07.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] staging: rtl8723bs: remove rf type branching (second patch)
Date:   Sat,  7 Aug 2021 11:48:05 +0200
Message-Id: <fd41fbfba16df2b93a7593c1f853a874255e945c.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove RFType field in dm_odm_t struct, keep unconditioned
all code branches related to 1T1R path, delete the others.

Remove unused variable to silence gcc warning.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c           | 44 +++++--------------
 drivers/staging/rtl8723bs/hal/odm.h           |  3 --
 .../staging/rtl8723bs/hal/odm_CfoTracking.c   |  8 +---
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |  3 +-
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  |  5 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |  9 ----
 6 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index f87dd84434f7..31f65d817899 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -391,36 +391,20 @@ u32 ODM_Get_Rate_Bitmap(
 	case (ODM_WM_B|ODM_WM_G|ODM_WM_N24G):
 	case (ODM_WM_B|ODM_WM_N24G):
 	case (ODM_WM_G|ODM_WM_N24G):
-		if (pDM_Odm->RFType == ODM_1T2R || pDM_Odm->RFType == ODM_1T1R) {
-			if (rssi_level == DM_RATR_STA_HIGH)
-				rate_bitmap = 0x000f0000;
-			else if (rssi_level == DM_RATR_STA_MIDDLE)
-				rate_bitmap = 0x000ff000;
-			else {
-				if (*(pDM_Odm->pBandWidth) == ODM_BW40M)
-					rate_bitmap = 0x000ff015;
-				else
-					rate_bitmap = 0x000ff005;
-			}
-		} else {
-			if (rssi_level == DM_RATR_STA_HIGH)
-				rate_bitmap = 0x0f8f0000;
-			else if (rssi_level == DM_RATR_STA_MIDDLE)
-				rate_bitmap = 0x0f8ff000;
-			else {
-				if (*(pDM_Odm->pBandWidth) == ODM_BW40M)
-					rate_bitmap = 0x0f8ff015;
-				else
-					rate_bitmap = 0x0f8ff005;
-			}
+		if (rssi_level == DM_RATR_STA_HIGH)
+			rate_bitmap = 0x000f0000;
+		else if (rssi_level == DM_RATR_STA_MIDDLE)
+			rate_bitmap = 0x000ff000;
+		else {
+			if (*(pDM_Odm->pBandWidth) == ODM_BW40M)
+				rate_bitmap = 0x000ff015;
+			else
+				rate_bitmap = 0x000ff005;
 		}
 		break;
 
 	default:
-		if (pDM_Odm->RFType == RF_1T2R)
-			rate_bitmap = 0x000fffff;
-		else
-			rate_bitmap = 0x0fffffff;
+		rate_bitmap = 0x0fffffff;
 		break;
 	}
 
@@ -844,10 +828,6 @@ void ODM_CmnInfoInit(struct dm_odm_t *pDM_Odm, enum odm_cmninfo_e CmnInfo, u32 V
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
 
-	case ODM_CMNINFO_RF_TYPE:
-		pDM_Odm->RFType = (u8)Value;
-		break;
-
 	case ODM_CMNINFO_PLATFORM:
 		pDM_Odm->SupportPlatform = (u8)Value;
 		break;
@@ -1094,10 +1074,6 @@ void ODM_CmnInfoUpdate(struct dm_odm_t *pDM_Odm, u32 CmnInfo, u64 Value)
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
 
-	case ODM_CMNINFO_RF_TYPE:
-		pDM_Odm->RFType = (u8)Value;
-		break;
-
 	case ODM_CMNINFO_WIFI_DIRECT:
 		pDM_Odm->bWIFI_Direct = (bool)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 814f4d54a96d..19cfc2915458 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -285,7 +285,6 @@ enum odm_cmninfo_e {
 	ODM_CMNINFO_IC_TYPE,					/*  ODM_IC_TYPE_E */
 	ODM_CMNINFO_CUT_VER,					/*  ODM_CUT_VERSION_E */
 	ODM_CMNINFO_FAB_VER,					/*  ODM_FAB_E */
-	ODM_CMNINFO_RF_TYPE,					/*  ODM_RF_PATH_E or ODM_RF_TYPE_E? */
 	ODM_CMNINFO_RFE_TYPE,
 	ODM_CMNINFO_PACKAGE_TYPE,
 	ODM_CMNINFO_EXT_LNA,					/*  true */
@@ -422,7 +421,6 @@ enum { /* tag_ODM_Fab_Version_Definition */
 	ODM_UMC		=	1,
 };
 
-/*  ODM_CMNINFO_RF_TYPE */
 /*  */
 /*  For example 1T2R (A+AB = BIT0|BIT4|BIT5) */
 /*  */
@@ -719,7 +717,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	/*  Fab Version TSMC/UMC = 0/1 */
 	u8 FabVersion;
 	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
-	u8 RFType;
 	u8 RFEType;
 	/*  Board Type Normal/HighPower/MiniCard/SLIM/Combo/... = 0/1/2/3/4/... */
 	u8 BoardType;
diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index 1e084f01050e..928c58be6c9b 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -94,7 +94,7 @@ void ODM_CfoTracking(void *pDM_VOID)
 {
 	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
 	struct cfo_tracking *pCfoTrack = &pDM_Odm->DM_CfoTrack;
-	int CFO_kHz_A, CFO_kHz_B, CFO_ave = 0;
+	int CFO_kHz_A, CFO_ave = 0;
 	int CFO_ave_diff;
 	int CrystalCap = (int)pCfoTrack->CrystalCap;
 	u8 Adjust_Xtal = 1;
@@ -117,12 +117,8 @@ void ODM_CfoTracking(void *pDM_VOID)
 
 		/* 4 1.2 Calculate CFO */
 		CFO_kHz_A =  (int)(pCfoTrack->CFO_tail[0] * 3125)  / 1280;
-		CFO_kHz_B =  (int)(pCfoTrack->CFO_tail[1] * 3125)  / 1280;
 
-		if (pDM_Odm->RFType < ODM_2T2R)
-			CFO_ave = CFO_kHz_A;
-		else
-			CFO_ave = (int)(CFO_kHz_A + CFO_kHz_B) >> 1;
+		CFO_ave = CFO_kHz_A;
 
 		/* 4 1.3 Avoid abnormal large CFO */
 		CFO_ave_diff =
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index fb932e0618e2..beda7b8a7c6a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -302,8 +302,7 @@ void ODM_Write_DIG(void *pDM_VOID, u8 CurrentIGI)
 		/* 1 Set IGI value */
 		PHY_SetBBReg(pDM_Odm->Adapter, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 
-		if (pDM_Odm->RFType > ODM_1T1R)
-			PHY_SetBBReg(pDM_Odm->Adapter, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+		PHY_SetBBReg(pDM_Odm->Adapter, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
index 97acf75fc04e..392cc8a398f5 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
@@ -33,10 +33,7 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 
 	pDM_Odm->noise_level.noise_all = 0;
 
-	if ((pDM_Odm->RFType == ODM_1T2R) || (pDM_Odm->RFType == ODM_2T2R))
-		max_rf_path = 2;
-	else
-		max_rf_path = 1;
+	max_rf_path = 1;
 
 	memset(&noise_data, 0, sizeof(struct noise_level));
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index c1caeaf44943..2028791988e7 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -49,15 +49,6 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
 	/* 	ODM_CMNINFO_BINHCT_TEST only for MP Team */
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
 
-
-	if (pHalData->rf_type == RF_1T1R) {
-		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_1T1R);
-	} else if (pHalData->rf_type == RF_2T2R) {
-		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R);
-	} else if (pHalData->rf_type == RF_1T2R) {
-		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_RF_TYPE, ODM_1T2R);
-	}
-
 	pdmpriv->InitODMFlag = ODM_RF_CALIBRATION|ODM_RF_TX_PWR_TRACK;
 
 	ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
-- 
2.20.1

