Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DA3AD99E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhFSKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhFSKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251DC061756
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso10298205wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHA6JdEt4wWOxung69IViil9MS2sDaSosygLKD+KDNs=;
        b=klJ2kYE7o3BvB4+qAI4+vgbmCHNzBP9ez+YebbvzPyDq2sbuE1V0GksI5VX2kXN1Y0
         crWS2qOgq+q5qnVDO9/lM89zTb3o78Zqokkr5M6RiEplVQas/HF6Smhf4y3bpcY40yky
         l3t6FIog63zYlfuSjGQPNR/B7un39BWfXZ7+mjOmC4UTESkZSNWa1UPHyGGCGjQlIbNL
         G9rDe+9KJpDq0j3cpvAItg0IpbePKdG4BByGr6P3vkUcBttK9HJlaLbBWemr8H6v29zo
         7dJkHlGGAr4KF3hPYHfEopnMpHEunZQOh+9H5JvpIYjRnKZiV1RGdUNZPuufV3Z0jrlc
         7smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHA6JdEt4wWOxung69IViil9MS2sDaSosygLKD+KDNs=;
        b=EVnhY38mXzXCf4CnCno/v1/O717HoEKaOUIDopsWivOsAHJKDYIbuGiP4fQvt0Ky1k
         laVzeknIJkXnw7Ngyb8bRyzjk4MEpNWxZXkyzVMKP2Og+2lu9k04Zhr2CNhoTJ54PKnd
         rr5rVydSZHROolNxkRJ+j/W3NE33XbVpIlOhlzaBdzXM/qV+n7dhOcYXJUIa+Ktqc5bk
         JP16PDHrDHDD+TJ+z9JSfdSlh8VJRKbei2DBs8YJXrlpaOvvRtZZV3uyt5LpXYQ4QvoT
         plqgh+p77vT6plenbGw80DXWA5efVQ1S7y5djl4yKuOIIjxLeD8f9XwDfrnO8kLQezbt
         IG6w==
X-Gm-Message-State: AOAM533RC5t3j2nbjxam6m3Z58GGKKwb00edm38dv3fmYudrSJWGBscC
        XJCzDob8ly2K6vtPfa5+2sL5/lR6ni8p1w==
X-Google-Smtp-Source: ABdhPJz7Ha/aA+n9SMTgugS8yhyt1/kOO/NlDewMGqmrXKONX78Blg+wX5lENiP4y1veueHQyeRlng==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr7309859wmq.36.1624099658254;
        Sat, 19 Jun 2021 03:47:38 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id f14sm12911749wmq.10.2021.06.19.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] staging: rtl8723bs: remove 5Ghz code related to RF power calibration
Date:   Sat, 19 Jun 2021 12:47:14 +0200
Message-Id: <240cb3fbf28c6dc1779ad6a74c6c23b23e09730d.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
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

