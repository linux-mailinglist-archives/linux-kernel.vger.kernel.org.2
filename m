Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E374337C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhJSNyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhJSNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:54:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBA0C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso3122095wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAt3ss7oQNnV6xLJ2Fs/3pWmqU9uyoS5/AOSPJCSeWo=;
        b=b2ErpmAM//MpfN4UsehZtaHobw3E6YvVratgXFNSzpW7Ot5ZcRrFluuUFXMhQp5MV7
         f9b4RZroaiBeFbJJAq9Bf9KZOe3kRq+Y4FCOMBX1j7PsXUbxu1KxF8XC7MLLpPzsbTRg
         s27NwrQ8AwpG6VFTfvpIGqIEKoCvBNWDTS/A3DOZmFsRzX2Y68vU9ECJBktDm68anHkd
         3qTA6iTsd1DUxlnQbDGTR3Zl4Cbj2fQnTpAspgeRsnWAd2anEh3NXiRLRl0mBglvODD8
         CfFiA7EjJvp4uMG7DBmUdAxO2pnQRx9CN3wlotyjVczyaCNXuuIBX3corCzuF0ZeOTsm
         MEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAt3ss7oQNnV6xLJ2Fs/3pWmqU9uyoS5/AOSPJCSeWo=;
        b=lOSEESdgWzn6lvH9bp732dlCA+NVKZpBuZOqGDpv++9HimwDPcjNrs+tRWFiKNrLov
         Ds/n2xQ1nFSXlnEjo3gyodOD7czuXoFqXYSd5f+1trSdlXP2IODRAQ7LaBYRJtpKH8yV
         qFHZpm46p2EHfgxE4Gnc4YnCWWFOYAWoRxo1yMEKLh//sz8wjSdcC2q+gCEkxtONlHKM
         qk2yk7y1BSIRVWcxn5vvmS2qOwV0q5cHtP+B/erjISf2hkH9CHN59YFfFzgoiZAxTXf2
         7HEUh8rZ7CEF30DFUaPmHPDTszjI5/zCr0NWwT7X+OmfukJz//W2mGYeUpwXuvVfo4S0
         enqQ==
X-Gm-Message-State: AOAM531s+P9kBoGdfPgs4yRBlE9/XBITInmKUjuFLgmg2hkttC41M8UN
        V9WUuq/gmSC3YnadzhynWgs=
X-Google-Smtp-Source: ABdhPJwIdxFmacdQP36hB6x6hFr0ELZXo1RxOAShTwC2qiOpCA4E7whbggN99hAjNlp+jz0vadUwVg==
X-Received: by 2002:a1c:a302:: with SMTP id m2mr6342134wme.111.1634651507689;
        Tue, 19 Oct 2021 06:51:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: r8188eu: RFType type is always ODM_1T1R
Date:   Tue, 19 Oct 2021 15:51:37 +0200
Message-Id: <20211019135137.9893-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019135137.9893-1-straube.linux@gmail.com>
References: <20211019135137.9893-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for 1T1R chips. The field RfType of odm_dm_struct is
set to ODM_1T1R and never changed. Remove code that initializes RFType,
remove it from odm_dm_struct and remove resulting dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 82 ++------------------
 drivers/staging/r8188eu/hal/odm.c            | 40 +++-------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c    |  7 --
 drivers/staging/r8188eu/include/odm.h        | 14 ----
 4 files changed, 14 insertions(+), 129 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 9fcee29b42b8..60d4ba275196 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -583,50 +583,6 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 	}
 }
 
-static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u8 final_candidate, bool txonly)
-{
-	u32 Oldval_1, X, TX1_A, reg;
-	s32 Y, TX1_C;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-
-	if (final_candidate == 0xFF) {
-		return;
-	} else if (iqkok) {
-		Oldval_1 = (ODM_GetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord) >> 22) & 0x3FF;
-
-		X = result[final_candidate][4];
-		if ((X & 0x00000200) != 0)
-			X = X | 0xFFFFFC00;
-		TX1_A = (X * Oldval_1) >> 8;
-		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x3FF, TX1_A);
-
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(27), ((X * Oldval_1 >> 7) & 0x1));
-
-		Y = result[final_candidate][5];
-		if ((Y & 0x00000200) != 0)
-			Y = Y | 0xFFFFFC00;
-
-		TX1_C = (Y * Oldval_1) >> 8;
-		ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, 0xF0000000, ((TX1_C & 0x3C0) >> 6));
-		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x003F0000, (TX1_C & 0x3F));
-
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(25), ((Y * Oldval_1 >> 7) & 0x1));
-
-		if (txonly)
-			return;
-
-		reg = result[final_candidate][6];
-		ODM_SetBBReg(dm_odm, rOFDM0_XBRxIQImbalance, 0x3FF, reg);
-
-		reg = result[final_candidate][7] & 0x3F;
-		ODM_SetBBReg(dm_odm, rOFDM0_XBRxIQImbalance, 0xFC00, reg);
-
-		reg = (result[final_candidate][7] >> 6) & 0xF;
-		ODM_SetBBReg(dm_odm, rOFDM0_AGCRSSITable, 0x0000F000, reg);
-	}
-}
-
 void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegisterNum)
 {
 	u32 i;
@@ -759,23 +715,11 @@ static bool phy_SimularityCompare_8188E(
 	)
 {
 	u32 i, j, diff, sim_bitmap, bound = 0;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 	u8 final_candidate[2] = {0xFF, 0xFF};	/* for path A and path B */
 	bool result = true;
-	bool is2t;
 	s32 tmp1 = 0, tmp2 = 0;
 
-	if ((dm_odm->RFType == ODM_2T2R) || (dm_odm->RFType == ODM_2T3R) || (dm_odm->RFType == ODM_2T4R))
-		is2t = true;
-	else
-		is2t = false;
-
-	if (is2t)
-		bound = 8;
-	else
-		bound = 4;
-
+	bound = 4;
 	sim_bitmap = 0;
 
 	for (i = 0; i < bound; i++) {
@@ -1049,8 +993,8 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 	s32 result[4][8];	/* last is final result */
 	u8 i, final_candidate;
-	bool pathaok, pathbok;
-	s32 RegE94, RegE9C, RegEA4, RegEB4, RegEBC, RegEC4;
+	bool pathaok;
+	s32 RegE94, RegE9C, RegEA4, RegEB4, RegEBC;
 	bool is12simular, is13simular, is23simular;
 	bool singletone = false, carrier_sup = false;
 	u32 IQK_BB_REG_92C[IQK_BB_REG_NUM] = {
@@ -1059,9 +1003,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 		rOFDM0_XATxIQImbalance, rOFDM0_XBTxIQImbalance,
 		rOFDM0_XCTxAFE, rOFDM0_XDTxAFE,
 		rOFDM0_RxIQExtAnta};
-	bool is2t;
-
-	is2t = (dm_odm->RFType == ODM_2T2R) ? true : false;
 
 	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
 		return;
@@ -1086,13 +1027,12 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	}
 	final_candidate = 0xff;
 	pathaok = false;
-	pathbok = false;
 	is12simular = false;
 	is23simular = false;
 	is13simular = false;
 
 	for (i = 0; i < 3; i++) {
-		phy_IQCalibrate_8188E(adapt, result, i, is2t);
+		phy_IQCalibrate_8188E(adapt, result, i, false);
 
 		if (i == 1) {
 			is12simular = phy_SimularityCompare_8188E(adapt, result, 0, 1);
@@ -1124,7 +1064,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 		RegEA4 = result[i][2];
 		RegEB4 = result[i][4];
 		RegEBC = result[i][5];
-		RegEC4 = result[i][6];
 	}
 
 	if (final_candidate != 0xff) {
@@ -1137,9 +1076,7 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 		dm_odm->RFCalibrateInfo.RegE9C = RegE9C;
 		dm_odm->RFCalibrateInfo.RegEB4 = RegEB4;
 		dm_odm->RFCalibrateInfo.RegEBC = RegEBC;
-		RegEC4 = result[final_candidate][6];
 		pathaok = true;
-		pathbok = true;
 	} else {
 		dm_odm->RFCalibrateInfo.RegE94 = 0x100;
 		dm_odm->RFCalibrateInfo.RegEB4 = 0x100;	/* X default value */
@@ -1148,10 +1085,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	}
 	if (RegE94 != 0)
 		patha_fill_iqk(adapt, pathaok, result, final_candidate, (RegEA4 == 0));
-	if (is2t) {
-		if (RegEB4 != 0)
-			pathb_fill_iqk(adapt, pathbok, result, final_candidate, (RegEC4 == 0));
-	}
 
 /* To Fix BSOD when final_candidate is 0xff */
 /* by sherry 20120321 */
@@ -1182,10 +1115,5 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 		timecount += 50;
 	}
 
-	if (dm_odm->RFType == ODM_2T2R) {
-		phy_LCCalibrate_8188E(adapt, true);
-	} else {
-		/*  For 88C 1T1R */
-		phy_LCCalibrate_8188E(adapt, false);
-	}
+	phy_LCCalibrate_8188E(adapt, false);
 }
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 3aa84078319e..47d8cdf1c3e8 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -202,9 +202,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_MP_TEST_CHIP:
 		pDM_Odm->bIsMPChip = (u8)Value;
 		break;
-	case	ODM_CMNINFO_RF_TYPE:
-		pDM_Odm->RFType = (u8)Value;
-		break;
 	case    ODM_CMNINFO_RF_ANTENNA_TYPE:
 		pDM_Odm->AntDivType = (u8)Value;
 		break;
@@ -275,9 +272,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	case	ODM_CMNINFO_ABILITY:
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
-	case	ODM_CMNINFO_RF_TYPE:
-		pDM_Odm->RFType = (u8)Value;
-		break;
 	case	ODM_CMNINFO_WIFI_DIRECT:
 		pDM_Odm->bWIFI_Direct = (bool)Value;
 		break;
@@ -714,36 +708,20 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 			rate_bitmap = 0x00000ff5;
 		break;
 	case (ODM_WM_B | ODM_WM_G | ODM_WM_N24G):
-		if (pDM_Odm->RFType == ODM_1T2R || pDM_Odm->RFType == ODM_1T1R) {
-			if (rssi_level == DM_RATR_STA_HIGH) {
-				rate_bitmap = 0x000f0000;
-			} else if (rssi_level == DM_RATR_STA_MIDDLE) {
-				rate_bitmap = 0x000ff000;
-			} else {
-				if (*pDM_Odm->pBandWidth == ODM_BW40M)
-					rate_bitmap = 0x000ff015;
-				else
-					rate_bitmap = 0x000ff005;
-			}
+		if (rssi_level == DM_RATR_STA_HIGH) {
+			rate_bitmap = 0x000f0000;
+		} else if (rssi_level == DM_RATR_STA_MIDDLE) {
+			rate_bitmap = 0x000ff000;
 		} else {
-			if (rssi_level == DM_RATR_STA_HIGH) {
-				rate_bitmap = 0x0f8f0000;
-			} else if (rssi_level == DM_RATR_STA_MIDDLE) {
-				rate_bitmap = 0x0f8ff000;
-			} else {
-				if (*pDM_Odm->pBandWidth == ODM_BW40M)
-					rate_bitmap = 0x0f8ff015;
-				else
-					rate_bitmap = 0x0f8ff005;
-			}
+			if (*pDM_Odm->pBandWidth == ODM_BW40M)
+				rate_bitmap = 0x000ff015;
+			else
+				rate_bitmap = 0x000ff005;
 		}
 		break;
 	default:
 		/* case WIRELESS_11_24N: */
-		if (pDM_Odm->RFType == RF_1T2R)
-			rate_bitmap = 0x000fffff;
-		else
-			rate_bitmap = 0x0fffffff;
+		rate_bitmap = 0x0fffffff;
 		break;
 	}
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index d3292956d818..4ce2c3749665 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -35,13 +35,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
 
-	if (hal_data->rf_type == RF_1T1R)
-		ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_RF_TYPE, ODM_1T1R);
-	else if (hal_data->rf_type == RF_2T2R)
-		ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R);
-	else if (hal_data->rf_type == RF_1T2R)
-		ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_RF_TYPE, ODM_1T2R);
-
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 
 	pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION |
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index eb46386ceddd..1fc90a8dc063 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -229,7 +229,6 @@ enum odm_common_info_def {
 	/* HOOK BEFORE REG INIT----------- */
 	ODM_CMNINFO_ABILITY,		/* ODM_ABILITY_E */
 	ODM_CMNINFO_MP_TEST_CHIP,
-	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
 	/* HOOK BEFORE REG INIT-----------  */
 
 	/*  Dynamic value: */
@@ -286,17 +285,6 @@ enum odm_ability_def {
 
 # define ODM_ITRF_USB 0x2
 
-enum odm_rf_type {
-	ODM_1T1R	=	0,
-	ODM_1T2R	=	1,
-	ODM_2T2R	=	2,
-	ODM_2T3R	=	3,
-	ODM_2T4R	=	4,
-	ODM_3T3R	=	5,
-	ODM_3T4R	=	6,
-	ODM_4T4R	=	7,
-};
-
 /*  ODM_CMNINFO_OP_MODE */
 enum odm_operation_mode {
 	ODM_NO_LINK		= BIT(0),
@@ -493,8 +481,6 @@ struct odm_dm_struct {
 /* HOOK BEFORE REG INIT----------- */
 	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/ �K�K = 1/2/3/�K */
 	u32	SupportAbility;
-	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
-	u8	RFType;
 
 	u32	BK_SupportAbility;
 	u8	AntDivType;
-- 
2.33.1

