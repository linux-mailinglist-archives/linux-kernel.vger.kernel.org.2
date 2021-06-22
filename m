Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE83B058D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhFVNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhFVNMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B465C061768
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1714241wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHA6JdEt4wWOxung69IViil9MS2sDaSosygLKD+KDNs=;
        b=mcoijCGCuwmOtE2l20R1PeNoS3LT/9rCLnhe/zvOWTfBISeSj/IPxK2TyKuEjofRvL
         TvKpjxkYxu6S3dpx6OeJl9O3gBdiIM1bY2IhOfyDFKtZQ6WDetaDd8FYz6PRzxFI6rGs
         dacRnBtH1wjR3erSt16fSwrcz/+Pw3un8LAeBKFusASm2c/33KUsRU4dqnetTc40tGBE
         bQxUizWUNWN87ZGIuEMDA2cykiqqn9P3Udyi+EV7lKxZZF+/6GVD3GNCyrewY3ExtCDn
         VlUX1Ybmsqoi0/bmBW2F+x6MxHJPgj6/xaQ9okvPO5lx6eNhnTDHH3GcAU4UCFOw7F+2
         Vp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHA6JdEt4wWOxung69IViil9MS2sDaSosygLKD+KDNs=;
        b=dTegz1+HGI5SbPoY1P/IpQ8QgUY3cNaeoggQauHioSAKi1E1QNLs3tiigVEdrFZzZb
         q7lbMU+IzCF11hn4S1fNKQSjqWRxpCOaXVeRG6xcOOTq+DlAu15jgzG+LfcWQWvqCo39
         9nNsfWoTgZ3PCuQAB5MWrYxnRBj6T9RjQElfnY82J7R+pQGNNq6uVTtJNaiNsP6yt2AH
         2QSpg1yGywKkwXAQM6Zq+LYVG+mQyvGMxXTfSnKKAgb4ttZNVCsvgrZ1FeSBk9lnBeZ1
         juZ5UzhTE3ZO9jnNsKqMHq5JRGWr8Wddj0a6zlaHjr9r2OH3UslK6XCKxlxtFk4vJ04I
         Lbsw==
X-Gm-Message-State: AOAM531VxjUhaPnVNkptf/gd2wrguhEM4fP7wobit3fGOJ2Vy8FpV8aM
        VHSNpiIT6y7MmLRQVw7379U8ULd5VjtctA==
X-Google-Smtp-Source: ABdhPJwSYB+NqEi6P8r1ZQSrM2K9Bc/H+RbJvGO/9u8pQ2uJRz1qdUm+eo76sPohulPEgVVMoPgC5w==
X-Received: by 2002:a7b:c089:: with SMTP id r9mr4412727wmh.167.1624367419938;
        Tue, 22 Jun 2021 06:10:19 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id o17sm1120871wmh.19.2021.06.22.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/17] staging: rtl8723bs: remove 5Ghz code related to RF power calibration
Date:   Tue, 22 Jun 2021 15:09:55 +0200
Message-Id: <f2096f71ae80f0cb7805a0e48536babc9809a3de.1624367072.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove 5Ghz code related to RF calibration. Remove
table arrays, variables and macros related to RF power
tracking.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  | 77 -------------------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 17 +---
 drivers/staging/rtl8723bs/hal/odm.c           |  8 --
 drivers/staging/rtl8723bs/hal/odm.h           | 14 +---
 4 files changed, 2 insertions(+), 114 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
index f49032dc5bef..00d429977ea9 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
@@ -282,62 +282,6 @@ void ODM_ReadAndConfig_MP_8723B_RadioA(struct dm_odm_t *pDM_Odm)
 *                           TxPowerTrack_SDIO.TXT
 ******************************************************************************/
 
-static u8 gDeltaSwingTableIdx_MP_5GB_N_TxPowerTrack_SDIO_8723B[][DELTA_SWINGIDX_SIZE] = {
-	{
-		0, 1, 1, 2, 2, 3, 4, 5, 5, 6,  6,  7,  7,  8,  8,  9,
-		9, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14, 14
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  7,  8,  8,  9,  9, 10,
-		10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14, 14
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  7,  8,  8,  9,  9, 10,
-		10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14, 14
-	},
-};
-static u8 gDeltaSwingTableIdx_MP_5GB_P_TxPowerTrack_SDIO_8723B[][DELTA_SWINGIDX_SIZE] = {
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  8,  9,  9, 10, 11, 12,
-		12, 13, 14, 15, 15, 16, 16, 17, 17, 18, 19, 20, 20, 20
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  8,  9,  9, 10, 11, 12,
-		12, 13, 14, 15, 15, 16, 17, 18, 18, 19, 19, 20, 20, 20
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  8,  9,  9, 10, 11, 12,
-		12, 13, 14, 15, 15, 16, 17, 18, 18, 19, 20, 21, 21, 21
-	},
-};
-static u8 gDeltaSwingTableIdx_MP_5GA_N_TxPowerTrack_SDIO_8723B[][DELTA_SWINGIDX_SIZE] = {
-	{
-		0, 1, 2, 3, 3, 4, 4, 5, 5, 6,  7,  8,  8,  9,  9, 10,
-		10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14, 14
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 6,  7,  7,  8,  8,  9, 10,
-		11, 11, 12, 13, 13, 14, 15, 16, 16, 16, 16, 16, 16, 16
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  8,  9,  9, 10, 10, 11,
-		11, 12, 13, 14, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16
-	},
-};
-static u8 gDeltaSwingTableIdx_MP_5GA_P_TxPowerTrack_SDIO_8723B[][DELTA_SWINGIDX_SIZE] = {
-	{
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  8,  9,  9, 10, 11, 12,
-		12, 13, 14, 15, 15, 16, 17, 18, 18, 19, 20, 21, 21, 21
-	},
-	{
-		0, 1, 2, 3, 3, 4, 5, 6, 6, 7,  8,  9,  9, 10, 11, 12,
-		12, 13, 14, 15, 15, 16, 17, 18, 18, 19, 20, 21, 21, 21
-	},
-};
 static u8 gDeltaSwingTableIdx_MP_2GB_N_TxPowerTrack_SDIO_8723B[] = {
 	0, 0, 1, 2, 2, 2, 3, 3, 3, 4,  5,  5,  6,  6, 6,  6,
 	7,  7,  7, 8,  8,  9,  9, 10, 10, 11, 12, 13, 14, 15
@@ -417,27 +361,6 @@ void ODM_ReadAndConfig_MP_8723B_TxPowerTrack_SDIO(struct dm_odm_t *pDM_Odm)
 		gDeltaSwingTableIdx_MP_2GCCKB_N_TxPowerTrack_SDIO_8723B,
 		DELTA_SWINGIDX_SIZE
 	);
-
-	memcpy(
-		pRFCalibrateInfo->DeltaSwingTableIdx_5GA_P,
-		gDeltaSwingTableIdx_MP_5GA_P_TxPowerTrack_SDIO_8723B,
-		DELTA_SWINGIDX_SIZE*3
-	);
-	memcpy(
-		pRFCalibrateInfo->DeltaSwingTableIdx_5GA_N,
-		gDeltaSwingTableIdx_MP_5GA_N_TxPowerTrack_SDIO_8723B,
-		DELTA_SWINGIDX_SIZE*3
-	);
-	memcpy(
-		pRFCalibrateInfo->DeltaSwingTableIdx_5GB_P,
-		gDeltaSwingTableIdx_MP_5GB_P_TxPowerTrack_SDIO_8723B,
-		DELTA_SWINGIDX_SIZE*3
-	);
-	memcpy(
-		pRFCalibrateInfo->DeltaSwingTableIdx_5GB_N,
-		gDeltaSwingTableIdx_MP_5GB_N_TxPowerTrack_SDIO_8723B,
-		DELTA_SWINGIDX_SIZE*3
-	);
 }
 
 /******************************************************************************
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 9fa91023abfd..8121b8eb45b6 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -347,22 +347,7 @@ static void GetDeltaSwingTable_8723B(
 			*TemperatureUP_B   = pRFCalibrateInfo->DeltaSwingTableIdx_2GB_P;
 			*TemperatureDOWN_B = pRFCalibrateInfo->DeltaSwingTableIdx_2GB_N;
 		}
-	} /*else if (36 <= channel && channel <= 64) {
-		*TemperatureUP_A   = pRFCalibrateInfo->DeltaSwingTableIdx_5GA_P[0];
-		*TemperatureDOWN_A = pRFCalibrateInfo->DeltaSwingTableIdx_5GA_N[0];
-		*TemperatureUP_B   = pRFCalibrateInfo->DeltaSwingTableIdx_5GB_P[0];
-		*TemperatureDOWN_B = pRFCalibrateInfo->DeltaSwingTableIdx_5GB_N[0];
-	} else if (100 <= channel && channel <= 140) {
-		*TemperatureUP_A   = pRFCalibrateInfo->DeltaSwingTableIdx_5GA_P[1];
-		*TemperatureDOWN_A = pRFCalibrateInfo->DeltaSwingTableIdx_5GA_N[1];
-		*TemperatureUP_B   = pRFCalibrateInfo->DeltaSwingTableIdx_5GB_P[1];
-		*TemperatureDOWN_B = pRFCalibrateInfo->DeltaSwingTableIdx_5GB_N[1];
-	} else if (149 <= channel && channel <= 173) {
-		*TemperatureUP_A   = pRFCalibrateInfo->DeltaSwingTableIdx_5GA_P[2];
-		*TemperatureDOWN_A = pRFCalibrateInfo->DeltaSwingTableIdx_5GA_N[2];
-		*TemperatureUP_B   = pRFCalibrateInfo->DeltaSwingTableIdx_5GB_P[2];
-		*TemperatureDOWN_B = pRFCalibrateInfo->DeltaSwingTableIdx_5GB_N[2];
-	}*/else {
+	} else {
 		*TemperatureUP_A   = (u8 *)DeltaSwingTableIdx_2GA_P_8188E;
 		*TemperatureDOWN_A = (u8 *)DeltaSwingTableIdx_2GA_N_8188E;
 		*TemperatureUP_B   = (u8 *)DeltaSwingTableIdx_2GA_P_8188E;
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 0307ea383806..4c959efd447a 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -896,18 +896,10 @@ void ODM_CmnInfoInit(struct dm_odm_t *pDM_Odm, enum odm_cmninfo_e CmnInfo, u32 V
 		pDM_Odm->ExtLNA = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_5G_EXT_LNA:
-		pDM_Odm->ExtLNA5G = (u8)Value;
-		break;
-
 	case ODM_CMNINFO_EXT_PA:
 		pDM_Odm->ExtPA = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_5G_EXT_PA:
-		pDM_Odm->ExtPA5G = (u8)Value;
-		break;
-
 	case ODM_CMNINFO_GPA:
 		pDM_Odm->TypeGPA = (enum odm_type_gpa_e)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index afb36de7a4e5..a5bca7d7826a 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -151,7 +151,6 @@ struct swat_t { /* _SW_Antenna_Switch_ */
 	bool ANTB_ON;	/* To indicate Ant B is on or not */
 	bool Pre_Aux_FailDetec;
 	bool RSSI_AntDect_bResult;
-	u8 Ant5G;
 	u8 Ant2G;
 
 	s32 RSSI_sum_A;
@@ -295,9 +294,7 @@ enum odm_cmninfo_e {
 	ODM_CMNINFO_BOARD_TYPE,				/*  ODM_BOARD_TYPE_E */
 	ODM_CMNINFO_PACKAGE_TYPE,
 	ODM_CMNINFO_EXT_LNA,					/*  true */
-	ODM_CMNINFO_5G_EXT_LNA,
 	ODM_CMNINFO_EXT_PA,
-	ODM_CMNINFO_5G_EXT_PA,
 	ODM_CMNINFO_GPA,
 	ODM_CMNINFO_APA,
 	ODM_CMNINFO_GLNA,
@@ -514,7 +511,6 @@ struct odm_rf_cal_t { /* ODM_RF_Calibration_Structure */
 	bool bTXPowerTracking;
 	u8 TxPowerTrackControl; /* for mp mode, turn off txpwrtracking as default */
 	u8 TM_Trigger;
-	u8 InternalPA5G[2];	/* pathA / pathB */
 
 	u8 ThermalMeter[2];    /*  ThermalMeter, index 0 for RFIC0, and 1 for RFIC1 */
 	u8 ThermalValue;
@@ -549,7 +545,7 @@ struct odm_rf_cal_t { /* ODM_RF_Calibration_Structure */
 	bool bIQKInProgress;
 	u8 Delta_IQK;
 	u8 Delta_LCK;
-	s8 BBSwingDiff2G, BBSwingDiff5G; /*  Unit: dB */
+	s8 BBSwingDiff2G; /*  Unit: dB */
 	u8 DeltaSwingTableIdx_2GCCKA_P[DELTA_SWINGIDX_SIZE];
 	u8 DeltaSwingTableIdx_2GCCKA_N[DELTA_SWINGIDX_SIZE];
 	u8 DeltaSwingTableIdx_2GCCKB_P[DELTA_SWINGIDX_SIZE];
@@ -558,10 +554,6 @@ struct odm_rf_cal_t { /* ODM_RF_Calibration_Structure */
 	u8 DeltaSwingTableIdx_2GA_N[DELTA_SWINGIDX_SIZE];
 	u8 DeltaSwingTableIdx_2GB_P[DELTA_SWINGIDX_SIZE];
 	u8 DeltaSwingTableIdx_2GB_N[DELTA_SWINGIDX_SIZE];
-	u8 DeltaSwingTableIdx_5GA_P[BAND_NUM][DELTA_SWINGIDX_SIZE];
-	u8 DeltaSwingTableIdx_5GA_N[BAND_NUM][DELTA_SWINGIDX_SIZE];
-	u8 DeltaSwingTableIdx_5GB_P[BAND_NUM][DELTA_SWINGIDX_SIZE];
-	u8 DeltaSwingTableIdx_5GB_N[BAND_NUM][DELTA_SWINGIDX_SIZE];
 	u8 DeltaSwingTableIdx_2GA_P_8188E[DELTA_SWINGIDX_SIZE];
 	u8 DeltaSwingTableIdx_2GA_N_8188E[DELTA_SWINGIDX_SIZE];
 
@@ -627,7 +619,6 @@ struct fat_t { /* _FAST_ANTENNA_TRAINNING_ */
 	bool	bBecomeLinked;
 	u32 MinMaxRSSI;
 	u8 idx_AntDiv_counter_2G;
-	u8 idx_AntDiv_counter_5G;
 	u32 CCK_counter_main;
 	u32 CCK_counter_aux;
 	u32 OFDM_counter_main;
@@ -746,10 +737,8 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	u8 TypeAPA;
 	/*  with external LNA  NO/Yes = 0/1 */
 	u8 ExtLNA;
-	u8 ExtLNA5G;
 	/*  with external PA  NO/Yes = 0/1 */
 	u8 ExtPA;
-	u8 ExtPA5G;
 	/*  with external TRSW  NO/Yes = 0/1 */
 	u8 ExtTRSW;
 	u8 PatchID; /* Customer ID */
@@ -1046,7 +1035,6 @@ enum ODM_BB_Config_Type {
 	CONFIG_BB_PHY_REG,
 	CONFIG_BB_AGC_TAB,
 	CONFIG_BB_AGC_TAB_2G,
-	CONFIG_BB_AGC_TAB_5G,
 	CONFIG_BB_PHY_REG_PG,
 	CONFIG_BB_PHY_REG_MP,
 	CONFIG_BB_AGC_TAB_DIFF,
-- 
2.20.1

