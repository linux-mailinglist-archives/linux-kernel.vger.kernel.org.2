Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D9F3B0474
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhFVMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhFVMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF793C061760
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h11so5958289wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHA6JdEt4wWOxung69IViil9MS2sDaSosygLKD+KDNs=;
        b=DgfzYSemgwwbPi/77BNXGuGP62JG1of0ObsuFV5Q9TxdnovHsDm4IY8FvOMjLR1G0u
         iWdi7ZTVojge7NiADkFBc7LD7cruQpsSUP81nE6FPWOnIZUyL8ZGezOoHAgDQ1G/inyP
         bgtxstwGE0FsBpGBLUtK7DDR7rJPfT5fhdeIg/q1i3L9WjmS47QfPb4pshHNln7rBEcy
         /gVRNpE41xqPgIoSglbhBxjE2QEHkSBKKK5sAlG83OZ85RKLeAsqsw1MTRCo+VapRDma
         ++Nf4JQQGfIKYb/OqzDu2S8n9GS+R1Nt9CV9Y6FrahvzuLyq0p9CBdAuFCMQ2plbbKeW
         QAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHA6JdEt4wWOxung69IViil9MS2sDaSosygLKD+KDNs=;
        b=i7QLTaElj3JekkhNXmEA7Uykn2qlmfP9fCUgkt2hJSeEXvzEpEtd8V9L21nT89pJFd
         p3E2BGebXE64uxWVfnG7K05b8m9KIEf2biyA1OqHziXOZ31FqZnL/ZeYyIg19kdk6LUa
         Ym3+NZ5F+WB0DR7SBjQqLaQFsS+B9JEnk7cLcJURKzDwMwkG5c/ZFEmuTBeHzyqPYTr2
         Z1M0XHkHmOymqOC6+4Sly0+KI5ecj/io81NdtdSWvzMbcjyXeJmJ1S85zZaLHOvvKpVH
         Ji9Mk+Pw0Egidjc/cAS9uAZYlKKyb/Pv9hbNmI+0sbcsmIgziXe1iQnfQy8YiX4pGm3Z
         qPpg==
X-Gm-Message-State: AOAM532CMeFKvNXIwK9raVOt2WppBANAa/aezzr0Py+CCkd22Mlo8jNA
        pE/NCqC6Fa8eOAbZFrVItX/nejEKIKneXg==
X-Google-Smtp-Source: ABdhPJyp0sezPPrv/04kPjEjHPeT6dsAKQmWemn1PD0Nn7sRMtoySbETmvsG842nQugkQZtvL02ZOA==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr4461308wrm.258.1624365000266;
        Tue, 22 Jun 2021 05:30:00 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id a1sm27626283wra.63.2021.06.22.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:30:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/17] staging: rtl8723bs: remove 5Ghz code related to RF power calibration
Date:   Tue, 22 Jun 2021 14:29:36 +0200
Message-Id: <240cb3fbf28c6dc1779ad6a74c6c23b23e09730d.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
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

