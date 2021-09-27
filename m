Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E438F41A174
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhI0VrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhI0VrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:47:19 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D596CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:45:40 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id p22-20020a4a8156000000b002a8c9ea1858so6473581oog.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tj37agy/vuXH7pxAjCwGHPYpbt0X0lj9X/ecDpchME=;
        b=dYRolrjU9CKWlx9tV8bK1rJOe1XfgjqZ+BidnnXGhypHznLOoXdVX8gLM78bToFknR
         8/3jHVXf599GllxnqU2SZnUG49XfQW4i0foNsYZaqzr9WV7zVBy4jK+vEy5d4aXSs44X
         M7dCr5q8B55ftH1RnAVONEmgJvuSFd8ZPgjIjBztShAwOUiAKoIpX5wnJ4rCQbv/joQ1
         MNuK5jWzzuInAH05g+5NsJauhDGviDo74nujc3TYnoBcVqGTXB7nm74ZXAiKDet4rH0e
         QkKoN5NY2bOQ5X9oOLo/BybeGdnv4c7UpUzoH7tbeyEuiN9DtjM8TI6REY4UOmPk2Ch9
         0Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6tj37agy/vuXH7pxAjCwGHPYpbt0X0lj9X/ecDpchME=;
        b=PTsbcjBOrBWaZJGBQ3IIBSiewjrHl5Q2mIGJE1otfOmVVb71+IZlcbnInTL17dcIFy
         eknz8NpWN+yQ00T+T10q8Fq/f1fvA/nvwYxQrnQZLu1CxBNwp4XAA8cjhjENYbakltkT
         MTUbp+5g5oaKt/Gx4OucpFIicewd8xlnevGJ3NptuTygWXwB5OaSEHFyxVY5QBZN62RG
         SVe7Z0qhnkvC8ov7IByJrjn4qfg882SAzuT2tWmIqWl3v/o2zoS6a3zOE8UzPS/07aPV
         Rfuqp8iXlOQnQOYSCDfrie2FUEpTIzqvSdms/l2pnU5YF8Kx5R/G/Rw/Ed5ZUAVxsGRN
         g0Vw==
X-Gm-Message-State: AOAM530FDzO08oyWBFMBjt+KW5D2FJXQKldVYkzJAZpwfhwvUM60M9sb
        J5vOKkSRw5OptyewAPKb5bc=
X-Google-Smtp-Source: ABdhPJw9oQTH8xnlWmQiBPLN5oZGoi5IijqSHt7eGeKCCIMxq1gJHsLLNNef6QiN68FnBosDjC6kQg==
X-Received: by 2002:a4a:c119:: with SMTP id s25mr1864015oop.22.1632779140119;
        Mon, 27 Sep 2021 14:45:40 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1014.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1014.res6.spectrum.com. [2603:8090:2005:39b3::1014])
        by smtp.gmail.com with ESMTPSA id z83sm4335735oiz.41.2021.09.27.14.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 14:45:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] staging: r8188eu: Remove unused macros and defines from odm.h
Date:   Mon, 27 Sep 2021 16:45:27 -0500
Message-Id: <20210927214527.5341-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header defines a number of symbols/macros that are not used and can
be removed. In addition, it defines a number of synonym symbols that are
used interchangeably in the source. Only one is now selected.

In addition to the above, a number of comments that have no meaning for
this chip have been removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  12 +-
 drivers/staging/r8188eu/include/odm.h         | 145 ++----------------
 2 files changed, 15 insertions(+), 142 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 8a6cb18b0f29..2d351f831289 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -538,7 +538,7 @@ int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm)
 
 u8 ODM_RA_GetShortGI_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 {
-	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+	if ((NULL == dm_odm) || (macid >= ODM_ASSOCIATE_ENTRY_NUM))
 		return 0;
 	return dm_odm->RAInfo[macid].RateSGI;
 }
@@ -547,7 +547,7 @@ u8 ODM_RA_GetDecisionRate_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 {
 	u8 DecisionRate = 0;
 
-	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+	if ((NULL == dm_odm) || (macid >= ODM_ASSOCIATE_ENTRY_NUM))
 		return 0;
 	DecisionRate = (dm_odm->RAInfo[macid].DecisionRate);
 	return DecisionRate;
@@ -557,7 +557,7 @@ u8 ODM_RA_GetHwPwrStatus_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 {
 	u8 PTStage = 5;
 
-	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+	if ((NULL == dm_odm) || (macid >= ODM_ASSOCIATE_ENTRY_NUM))
 		return 0;
 	PTStage = (dm_odm->RAInfo[macid].PTStage);
 	return PTStage;
@@ -567,7 +567,7 @@ void ODM_RA_UpdateRateInfo_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rate
 {
 	struct odm_ra_info *pRaInfo = NULL;
 
-	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+	if ((NULL == dm_odm) || (macid >= ODM_ASSOCIATE_ENTRY_NUM))
 		return;
 
 	pRaInfo = &dm_odm->RAInfo[macid];
@@ -581,7 +581,7 @@ void ODM_RA_SetRSSI_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rssi)
 {
 	struct odm_ra_info *pRaInfo = NULL;
 
-	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+	if ((NULL == dm_odm) || (macid >= ODM_ASSOCIATE_ENTRY_NUM))
 		return;
 
 	pRaInfo = &dm_odm->RAInfo[macid];
@@ -605,7 +605,7 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 	pBuffer = TxRPT_Buf;
 
 	do {
-		if (MacId >= ASSOCIATE_ENTRY_NUM)
+		if (MacId >= ODM_ASSOCIATE_ENTRY_NUM)
 			valid = 0;
 		else if (MacId >= 32)
 			valid = (1 << (MacId - 32)) & macid_entry1;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 243ba0a14720..48d383f91c16 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -4,79 +4,16 @@
 #ifndef	__HALDMOUTSRC_H__
 #define __HALDMOUTSRC_H__
 
-/*  Definition */
-/*  Define all team support ability. */
-
-/*  Define for all teams. Please Define the constant in your precomp header. */
-
-/* define		DM_ODM_SUPPORT_AP			0 */
-/* define		DM_ODM_SUPPORT_ADSL			0 */
-/* define		DM_ODM_SUPPORT_CE			0 */
-/* define		DM_ODM_SUPPORT_MP			1 */
-
-/*  Define ODM SW team support flag. */
-
-/*  Antenna Switch Relative Definition. */
-
-/*  Add new function SwAntDivCheck8192C(). */
-/*  This is the main function of Antenna diversity function before link. */
-/*  Mainly, it just retains last scan result and scan again. */
-/*  After that, it compares the scan result to see which one gets better
- *  RSSI. It selects antenna with better receiving power and returns better
- *  scan result. */
-
-#define	TP_MODE			0
-#define	RSSI_MODE		1
-#define	TRAFFIC_LOW		0
-#define	TRAFFIC_HIGH		1
-
-/* 3 Tx Power Tracking */
-/* 3============================================================ */
-#define		DPK_DELTA_MAPPING_NUM	13
-#define		index_mapping_HP_NUM	15
-
 /*  */
 /* 3 PSD Handler */
 /* 3============================================================ */
 
-#define	AFH_PSD		1	/* 0:normal PSD scan, 1: only do 20 pts PSD */
-#define	MODE_40M	0	/* 0:20M, 1:40M */
-#define	PSD_TH2		3
-#define	PSD_CHM		20   /*  Minimum channel number for BT AFH */
-#define	SIR_STEP_SIZE	3
-#define Smooth_Size_1	5
-#define	Smooth_TH_1	3
-#define Smooth_Size_2	10
-#define	Smooth_TH_2	4
-#define Smooth_Size_3	20
-#define	Smooth_TH_3	4
-#define Smooth_Step_Size 5
-#define	Adaptive_SIR	1
-#define	PSD_RESCAN	4
-#define	PSD_SCAN_INTERVAL	700 /* ms */
-
-/* 8723A High Power IGI Setting */
-#define DM_DIG_HIGH_PWR_IGI_LOWER_BOUND	0x22
-#define DM_DIG_Gmode_HIGH_PWR_IGI_LOWER_BOUND 0x28
-#define DM_DIG_HIGH_PWR_THRESHOLD	0x3a
-
 /*  LPS define */
 #define DM_DIG_FA_TH0_LPS		4 /*  4 in lps */
 #define DM_DIG_FA_TH1_LPS		15 /*  15 lps */
 #define DM_DIG_FA_TH2_LPS		30 /*  30 lps */
 #define RSSI_OFFSET_DIG			0x05;
 
-/* ANT Test */
-#define ANTTESTALL		0x00	/* Ant A or B will be Testing */
-#define ANTTESTA		0x01	/* Ant A will be Testing */
-#define ANTTESTB		0x02	/* Ant B will be testing */
-
-/* RF REG */
-#define ODM_CHANNEL	0x18
-
-/* Ant Detect Reg */
-#define ODM_DPDT	0x300
-
 /*  structure and define */
 
 /*  Add for AP/ADSLpseudo DM structuer requirement. */
@@ -184,23 +121,13 @@ struct rx_hpc {
 	struct timer_list PSDTimer;
 };
 
-#define ASSOCIATE_ENTRY_NUM	32 /*  Max size of AsocEntry[]. */
-#define	ODM_ASSOCIATE_ENTRY_NUM	ASSOCIATE_ENTRY_NUM
+#define ODM_ASSOCIATE_ENTRY_NUM	32 /*  Max size of AsocEntry[]. */
 
 /*  This indicates two different steps. */
-/*  In SWAW_STEP_PEAK, driver needs to switch antenna and listen to
+/*  Using SWAW_STEP_PEAK, driver needs to switch antenna and listen to
  *  the signal on the air. */
-/*  In SWAW_STEP_DETERMINE, driver just compares the signal captured in
- *  SWAW_STEP_PEAK with original RSSI to determine if it is necessary to
- *  switch antenna. */
 
 #define SWAW_STEP_PEAK		0
-#define SWAW_STEP_DETERMINE	1
-
-#define	TP_MODE			0
-#define	RSSI_MODE		1
-#define	TRAFFIC_LOW		0
-#define	TRAFFIC_HIGH		1
 
 struct sw_ant_switch {
 	u8	try_flag;
@@ -232,13 +159,13 @@ struct sw_ant_switch {
 	u8	TrafficLoad;
 	struct timer_list SwAntennaSwitchTimer;
 	/* Hybrid Antenna Diversity */
-	u32	CCK_Ant1_Cnt[ASSOCIATE_ENTRY_NUM];
-	u32	CCK_Ant2_Cnt[ASSOCIATE_ENTRY_NUM];
-	u32	OFDM_Ant1_Cnt[ASSOCIATE_ENTRY_NUM];
-	u32	OFDM_Ant2_Cnt[ASSOCIATE_ENTRY_NUM];
-	u32	RSSI_Ant1_Sum[ASSOCIATE_ENTRY_NUM];
-	u32	RSSI_Ant2_Sum[ASSOCIATE_ENTRY_NUM];
-	u8	TxAnt[ASSOCIATE_ENTRY_NUM];
+	u32	CCK_Ant1_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	CCK_Ant2_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	OFDM_Ant1_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	OFDM_Ant2_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	RSSI_Ant1_Sum[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	RSSI_Ant2_Sum[ODM_ASSOCIATE_ENTRY_NUM];
+	u8	TxAnt[ODM_ASSOCIATE_ENTRY_NUM];
 	u8	TargetSTA;
 	u8	antsel;
 	u8	RxIdleAnt;
@@ -267,7 +194,6 @@ struct odm_rate_adapt {
 #define AVG_THERMAL_NUM		8
 #define IQK_Matrix_REG_NUM	8
 
-#define	DM_Type_ByFWi		0
 #define	DM_Type_ByDriver	1
 
 /*  Declare for common info */
@@ -980,42 +906,6 @@ enum dm_dig_op {
 #define		DM_DIG_BACKOFF_MIN		-4
 #define		DM_DIG_BACKOFF_DEFAULT		10
 
-/* 3=========================================================== */
-/* 3 AGC RX High Power Mode */
-/* 3=========================================================== */
-#define	  LNA_Low_Gain_1		0x64
-#define	  LNA_Low_Gain_2		0x5A
-#define	  LNA_Low_Gain_3		0x58
-
-#define	  FA_RXHP_TH1			5000
-#define	  FA_RXHP_TH2			1500
-#define	  FA_RXHP_TH3			800
-#define	  FA_RXHP_TH4			600
-#define	  FA_RXHP_TH5			500
-
-/* 3=========================================================== */
-/* 3 EDCA */
-/* 3=========================================================== */
-
-/* 3=========================================================== */
-/* 3 Dynamic Tx Power */
-/* 3=========================================================== */
-/* Dynamic Tx Power Control Threshold */
-#define		TX_POWER_NEAR_FIELD_THRESH_LVL2	74
-#define		TX_POWER_NEAR_FIELD_THRESH_LVL1	67
-#define		TX_POWER_NEAR_FIELD_THRESH_AP		0x3F
-
-#define		TxHighPwrLevel_Normal		0
-#define		TxHighPwrLevel_Level1		1
-#define		TxHighPwrLevel_Level2		2
-#define		TxHighPwrLevel_BT1		3
-#define		TxHighPwrLevel_BT2		4
-#define		TxHighPwrLevel_15		5
-#define		TxHighPwrLevel_35		6
-#define		TxHighPwrLevel_50		7
-#define		TxHighPwrLevel_70		8
-#define		TxHighPwrLevel_100		9
-
 /* 3=========================================================== */
 /* 3 Rate Adaptive */
 /* 3=========================================================== */
@@ -1049,11 +939,7 @@ enum dm_swas {
 	Antenna_MAX = 3,
 };
 
-/*  Maximal number of antenna detection mechanism needs to perform. */
-#define	MAX_ANTENNA_DETECTION_CNT	10
-
 /*  Extern Global Variables. */
-#define	OFDM_TABLE_SIZE_92C	37
 #define	OFDM_TABLE_SIZE_92D	43
 #define	CCK_TABLE_SIZE		33
 
@@ -1063,34 +949,21 @@ extern	u8 CCKSwingTable_Ch14 [CCK_TABLE_SIZE][8];
 
 /*  check Sta pointer valid or not */
 #define IS_STA_VALID(pSta)		(pSta)
-/*  20100514 Joseph: Add definition for antenna switching test after link. */
-/*  This indicates two different the steps. */
-/*  In SWAW_STEP_PEAK, driver needs to switch antenna and listen to the
- *  signal on the air. */
-/*  In SWAW_STEP_DETERMINE, driver just compares the signal captured in
- *  SWAW_STEP_PEAK */
-/*  with original RSSI to determine if it is necessary to switch antenna. */
-#define SWAW_STEP_PEAK		0
-#define SWAW_STEP_DETERMINE	1
 
 void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI);
 void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres);
 
 void ODM_SetAntenna(struct odm_dm_struct *pDM_Odm, u8 Antenna);
 
-#define dm_RF_Saving	ODM_RF_Saving
 void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal);
 
-#define SwAntDivRestAfterLink	ODM_SwAntDivRestAfterLink
 void ODM_SwAntDivRestAfterLink(struct odm_dm_struct *pDM_Odm);
 
-#define dm_CheckTXPowerTracking ODM_TXPowerTrackingCheck
 void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm);
 
 bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI,
 		      bool bForceUpdate, u8 *pRATRState);
 
-#define dm_SWAW_RSSI_Check	ODM_SwAntDivChkPerPktRssi
 void ODM_SwAntDivChkPerPktRssi(struct odm_dm_struct *pDM_Odm, u8 StationID,
 			       struct odm_phy_status_info *pPhyInfo);
 
-- 
2.33.0

