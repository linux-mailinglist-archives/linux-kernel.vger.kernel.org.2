Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768A53DC20C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhGaAkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhGaAjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A50C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so4771058wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXsvxJYJGqx9J7ZAoOfwSTHb7eejDN/D00rVYw4C2jk=;
        b=lBpPrWWgMNwqMZl96YJGWO5mq2Kyl8hfyWHRz9Z4EMAk1dHsIfeUCozO+v3Dj3DggR
         gUiSZKNzVCBSEFFptMtk5nXTR/BBh7r3XnXX0UW4IKQ+ERefZrQ5DSZ4zwdUecK0upOE
         t4yXUIgmvW4AwqfafSUWDvexNEv+EjCe/RnTXPq+bwsYzFrVbykHcrdvUKpI5PXIF5sx
         Xekuoobi+7E7rB9LQ7gSM+EplTnLWWiR0pVGGgiD/EeA88ZkzMkt2aKSy5Tuvb6yf6yV
         JeP0scsvFUu9aAPfT0cYw8MFEgsTuN/14W8MebywG3T9dTeUmBIyahTh0EWUPcRok7tr
         y6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXsvxJYJGqx9J7ZAoOfwSTHb7eejDN/D00rVYw4C2jk=;
        b=FTgVX8DP7R2iWLLMerDtKhY3PgeWf7q3mCm81nU/qG9/j+Cjov7to4HgO3u3jd3uwt
         K7UC052cWqvYsbdm7v668FP92V+HvwM7tceDMo0RQ8hGXE6K9Uq0Pe9x08GyHFiaIx71
         cI/LV/wzIxrBX1UydJURMXHX/rrcAbJBVLGv/l2513sBZmLnWVYaWrtlSY4Dz+HZ26Ao
         1MflJ9vvRLXkkIBMPOgbX7wxBTN/2Y32LPpFB+VntQwJ53dbVpNiRNLTtf2MZwdqKEFR
         OTamRYwMDGPo+VPMkoGRg8hhvZXk2BEefKPtwL/pR1pGboXiN8ut1vKn1rcAuNjcnZlK
         3TpA==
X-Gm-Message-State: AOAM532x88FDuX9+fcWfwpsx5mrV/gJ9plffdwkEZPWpD4VhM8rtohrf
        WZL5GWaScl9ZCbj+4Y9X6PjY8A==
X-Google-Smtp-Source: ABdhPJzF4EP/G26x5KdC7JPMKM65V36SHlDMpVFEa8Qd+001KV+sfhhQdPqQ4wdMZubCQbPpsGHMpA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr5546799wmh.151.1627691984599;
        Fri, 30 Jul 2021 17:39:44 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:44 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/14 resent] staging: r8188eu: remove ODM_RT_TRACE calls from hal/HalPhyRf_8188e.c
Date:   Sat, 31 Jul 2021 01:39:30 +0100
Message-Id: <20210731003937.68615-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE calls from hal/HalPhyRf_8188e.c, as by removing these
calls in this file and others, we can ultimately then remove the macro
definition itself, which does not follow best practice.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 228 +------------------
 1 file changed, 7 insertions(+), 221 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 1eb459532da5..d1613a9278c4 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -39,10 +39,6 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 	/*  Tx power tracking BB swing table. */
 	/*  The base index = 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB */
 	if (Type == 0) {		/*  For OFDM afjust */
-		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			     ("BbSwingIdxOfdm = %d BbSwingFlagOfdm=%d\n",
-			     dm_odm->BbSwingIdxOfdm, dm_odm->BbSwingFlagOfdm));
-
 		if (dm_odm->BbSwingIdxOfdm <= dm_odm->BbSwingIdxOfdmBase) {
 			*pDirection	= 1;
 			pwr_value		= (dm_odm->BbSwingIdxOfdmBase - dm_odm->BbSwingIdxOfdm);
@@ -50,15 +46,7 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 			*pDirection	= 2;
 			pwr_value		= (dm_odm->BbSwingIdxOfdm - dm_odm->BbSwingIdxOfdmBase);
 		}
-
-		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			     ("BbSwingIdxOfdm = %d BbSwingFlagOfdm=%d\n",
-			     dm_odm->BbSwingIdxOfdm, dm_odm->BbSwingFlagOfdm));
 	} else if (Type == 1) {	/*  For CCK adjust. */
-		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			     ("dm_odm->BbSwingIdxCck = %d dm_odm->BbSwingIdxCckBase = %d\n",
-			     dm_odm->BbSwingIdxCck, dm_odm->BbSwingIdxCckBase));
-
 		if (dm_odm->BbSwingIdxCck <= dm_odm->BbSwingIdxCckBase) {
 			*pDirection	= 1;
 			pwr_value		= (dm_odm->BbSwingIdxCckBase - dm_odm->BbSwingIdxCck);
@@ -98,7 +86,6 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 static void odm_TxPwrTrackSetPwr88E(struct odm_dm_struct *dm_odm)
 {
 	if (dm_odm->BbSwingFlagOfdm || dm_odm->BbSwingFlagCck) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD, ("odm_TxPwrTrackSetPwr88E CH=%d\n", *(dm_odm->pChannel)));
 		PHY_SetTxPowerLevel8188E(dm_odm->Adapter, *(dm_odm->pChannel));
 		dm_odm->BbSwingFlagOfdm = false;
 		dm_odm->BbSwingFlagCck	= false;
@@ -151,16 +138,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	/*  <Kordan> RFCalibrateInfo.RegA24 will be initialized when ODM HW configuring, but MP configures with para files. */
 	dm_odm->RFCalibrateInfo.RegA24 = 0x090e1317;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("===>dm_TXPowerTrackingCallback_ThermalMeter_8188E txpowercontrol %d\n",
-		     dm_odm->RFCalibrateInfo.TxPowerTrackControl));
-
 	ThermalValue = (u8)ODM_GetRFReg(dm_odm, RF_PATH_A, RF_T_METER_88E, 0xfc00);	/* 0x42: RF Reg[15:10] 88E */
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("Readback Thermal Meter = 0x%x pre thermal meter 0x%x EEPROMthermalmeter 0x%x\n",
-		     ThermalValue, dm_odm->RFCalibrateInfo.ThermalValue, pHalData->EEPROMThermalMeter));
-
 	if (is2t)
 		rf = 2;
 	else
@@ -173,9 +152,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			if (ele_D == (OFDMSwingTable[i]&bMaskOFDM_D)) {
 				OFDM_index_old[0] = (u8)i;
 				dm_odm->BbSwingIdxOfdmBase = (u8)i;
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("Initial pathA ele_D reg0x%x = 0x%x, OFDM_index=0x%x\n",
-					     rOFDM0_XATxIQImbalance, ele_D, OFDM_index_old[0]));
 				break;
 			}
 		}
@@ -186,9 +162,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
 				if (ele_D == (OFDMSwingTable[i]&bMaskOFDM_D)) {
 					OFDM_index_old[1] = (u8)i;
-					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-						     ("Initial pathB ele_D reg0x%x = 0x%x, OFDM_index=0x%x\n",
-						rOFDM0_XBTxIQImbalance, ele_D, OFDM_index_old[1]));
 					break;
 				}
 			}
@@ -202,21 +175,12 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 				if (ODM_CompareMemory(dm_odm, (void *)&TempCCk, (void *)&CCKSwingTable_Ch14[i][2], 4) == 0) {
 					CCK_index_old = (u8)i;
 					dm_odm->BbSwingIdxCckBase = (u8)i;
-					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-						     ("Initial reg0x%x = 0x%x, CCK_index=0x%x, ch 14 %d\n",
-						     rCCK0_TxFilter2, TempCCk, CCK_index_old, dm_odm->RFCalibrateInfo.bCCKinCH14));
 					break;
 				}
 			} else {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("RegA24: 0x%X, CCKSwingTable_Ch1_Ch13[%d][2]: CCKSwingTable_Ch1_Ch13[i][2]: 0x%X\n",
-					     TempCCk, i, CCKSwingTable_Ch1_Ch13[i][2]));
 				if (ODM_CompareMemory(dm_odm, (void *)&TempCCk, (void *)&CCKSwingTable_Ch1_Ch13[i][2], 4) == 0) {
 					CCK_index_old = (u8)i;
 					dm_odm->BbSwingIdxCckBase = (u8)i;
-					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-						     ("Initial reg0x%x = 0x%x, CCK_index=0x%x, ch14 %d\n",
-						     rCCK0_TxFilter2, TempCCk, CCK_index_old, dm_odm->RFCalibrateInfo.bCCKinCH14));
 					break;
 				}
 			}
@@ -232,10 +196,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			dm_odm->RFCalibrateInfo.CCK_index = CCK_index_old;
 		}
 
-		if (dm_odm->RFCalibrateInfo.bReloadtxpowerindex)
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-				     ("reload ofdm index for band switch\n"));
-
 		/* calculate average thermal meter */
 		dm_odm->RFCalibrateInfo.ThermalValue_AVG[dm_odm->RFCalibrateInfo.ThermalValue_AVG_index] = ThermalValue;
 		dm_odm->RFCalibrateInfo.ThermalValue_AVG_index++;
@@ -249,11 +209,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			}
 		}
 
-		if (ThermalValue_AVG_count) {
+		if (ThermalValue_AVG_count)
 			ThermalValue = (u8)(ThermalValue_AVG / ThermalValue_AVG_count);
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-				     ("AVG Thermal Meter = 0x%x\n", ThermalValue));
-		}
 
 		if (dm_odm->RFCalibrateInfo.bReloadtxpowerindex) {
 			delta = ThermalValue > pHalData->EEPROMThermalMeter ?
@@ -276,16 +233,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 		delta_IQK = (ThermalValue > dm_odm->RFCalibrateInfo.ThermalValue_IQK) ?
 			    (ThermalValue - dm_odm->RFCalibrateInfo.ThermalValue_IQK) :
 			    (dm_odm->RFCalibrateInfo.ThermalValue_IQK - ThermalValue);
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-			     ("Readback Thermal Meter = 0x%x pre thermal meter 0x%x EEPROMthermalmeter 0x%x delta 0x%x delta_LCK 0x%x delta_IQK 0x%x\n",
-			     ThermalValue, dm_odm->RFCalibrateInfo.ThermalValue,
-			     pHalData->EEPROMThermalMeter, delta, delta_LCK, delta_IQK));
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-			     ("pre thermal meter LCK 0x%x pre thermal meter IQK 0x%x delta_LCK_bound 0x%x delta_IQK_bound 0x%x\n",
-			     dm_odm->RFCalibrateInfo.ThermalValue_LCK,
-			     dm_odm->RFCalibrateInfo.ThermalValue_IQK,
-			     dm_odm->RFCalibrateInfo.Delta_LCK,
-			     dm_odm->RFCalibrateInfo.Delta_IQK));
 
 		if ((delta_LCK >= 8)) { /*  Delta temperature is equal to or larger than 20 centigrade. */
 			dm_odm->RFCalibrateInfo.ThermalValue_LCK = ThermalValue;
@@ -314,19 +261,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 				OFDM_index[i] = dm_odm->RFCalibrateInfo.OFDM_index[i] + OFDM_index_mapping[j][offset];
 			CCK_index = dm_odm->RFCalibrateInfo.CCK_index + OFDM_index_mapping[j][offset];
 
-			if (is2t) {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("temp OFDM_A_index=0x%x, OFDM_B_index=0x%x, CCK_index=0x%x\n",
-					     dm_odm->RFCalibrateInfo.OFDM_index[0],
-					     dm_odm->RFCalibrateInfo.OFDM_index[1],
-					     dm_odm->RFCalibrateInfo.CCK_index));
-			} else {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("temp OFDM_A_index=0x%x, CCK_index=0x%x\n",
-					     dm_odm->RFCalibrateInfo.OFDM_index[0],
-					     dm_odm->RFCalibrateInfo.CCK_index));
-			}
-
 			for (i = 0; i < rf; i++) {
 				if (OFDM_index[i] > OFDM_TABLE_SIZE_92D-1)
 					OFDM_index[i] = OFDM_TABLE_SIZE_92D-1;
@@ -339,16 +273,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			else if (CCK_index < 0)
 				CCK_index = 0;
 
-			if (is2t) {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("new OFDM_A_index=0x%x, OFDM_B_index=0x%x, CCK_index=0x%x\n",
-					     OFDM_index[0], OFDM_index[1], CCK_index));
-			} else {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("new OFDM_A_index=0x%x, CCK_index=0x%x\n",
-					     OFDM_index[0], CCK_index));
-			}
-
 			/* 2 temporarily remove bNOPG */
 			/* Config by SwingTable */
 			if (dm_odm->RFCalibrateInfo.TxPowerTrackControl) {
@@ -387,10 +311,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					/*  to increase TX power. Otherwise, EVM will be bad. */
 				}
 
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("TxPwrTracking for path A: X=0x%x, Y=0x%x ele_A=0x%x ele_C=0x%x ele_D=0x%x 0xe94=0x%x 0xe9c=0x%x\n",
-					     (u32)X, (u32)Y, (u32)ele_A, (u32)ele_C, (u32)ele_D, (u32)X, (u32)Y));
-
 				if (is2t) {
 					ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000)>>22;
 
@@ -422,17 +342,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, 0x00);
 						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT28, 0x00);
 					}
-
-					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-						     ("TxPwrTracking path B: X=0x%x, Y=0x%x ele_A=0x%x ele_C=0x%x ele_D=0x%x 0xeb4=0x%x 0xebc=0x%x\n",
-						     (u32)X, (u32)Y, (u32)ele_A,
-						     (u32)ele_C, (u32)ele_D, (u32)X, (u32)Y));
 				}
-
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-					     ("TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
-					     ODM_GetBBReg(dm_odm, 0xc80, bMaskDWord), ODM_GetBBReg(dm_odm,
-					     0xc94, bMaskDWord), ODM_GetRFReg(dm_odm, RF_PATH_A, 0x24, bRFRegOffsetMask)));
 			}
 		}
 
@@ -444,8 +354,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 		if (dm_odm->RFCalibrateInfo.TxPowerTrackControl)
 			dm_odm->RFCalibrateInfo.ThermalValue = ThermalValue;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("<===dm_TXPowerTrackingCallback_ThermalMeter_8188E\n"));
 	dm_odm->RFCalibrateInfo.TXPowercount = 0;
 }
 
@@ -460,39 +368,30 @@ phy_PathA_IQK_8188E(struct adapter *adapt, bool configPathB)
 	u8 result = 0x00;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A IQK!\n"));
 
 	/* 1 Tx IQK */
 	/* path-A IQK setting */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A IQK setting!\n"));
 	ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x10008c1c);
 	ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x30008c1c);
 	ODM_SetBBReg(dm_odm, rTx_IQK_PI_A, bMaskDWord, 0x8214032a);
 	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
 
 	/* LO calibration setting */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n"));
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x00462911);
 
 	/* One shot, path A LOK & IQK */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_88E));
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
 	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xeac = 0x%x\n", regeac));
 	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe94 = 0x%x\n", regE94));
 	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xe9c = 0x%x\n", regE9C));
 	regEA4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xea4 = 0x%x\n", regEA4));
 
 	if (!(regeac & BIT28) &&
 	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
@@ -508,11 +407,9 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	u8 result = 0x00;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Rx IQK!\n"));
 
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table!\n"));
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
 	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
 	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
@@ -536,30 +433,19 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
 
 	/* LO calibration setting */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n"));
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
 
 	/* One shot, path A LOK & IQK */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("Delay %d ms for One shot, path A LOK & IQK.\n",
-		     IQK_DELAY_TIME_88E));
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
 	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xeac = 0x%x\n", regeac));
 	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xe94 = 0x%x\n", regE94));
 	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xe9c = 0x%x\n", regE9C));
 
 	if (!(regeac & BIT28) &&
 	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
@@ -570,11 +456,9 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 
 	u4tmp = 0x80007C00 | (regE94&0x3FF0000)  | ((regE9C&0x3FF0000) >> 16);
 	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, u4tmp);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe40 = 0x%x u4tmp = 0x%x\n", ODM_GetBBReg(dm_odm, rTx_IQK, bMaskDWord), u4tmp));
 
 	/* 1 RX IQK */
 	/* modify RXIQK mode table */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table 2!\n"));
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
 	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
 	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
@@ -592,28 +476,21 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160c1f);
 
 	/* LO calibration setting */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n"));
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
 
 	/* One shot, path A LOK & IQK */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_88E));
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
 	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xeac = 0x%x\n", regeac));
 	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xe94 = 0x%x\n", regE94));
 	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xe9c = 0x%x\n", regE9C));
 	regEA4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xea4 = 0x%x\n", regEA4));
 
 	/* reload RF 0xdf */
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
@@ -623,8 +500,6 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	    (((regEA4 & 0x03FF0000)>>16) != 0x132) &&
 	    (((regeac & 0x03FF0000)>>16) != 0x36))
 		result |= 0x02;
-	else
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path A Rx IQK fail!!\n"));
 
 	return result;
 }
@@ -636,35 +511,20 @@ phy_PathB_IQK_8188E(struct adapter *adapt)
 	u8 result = 0x00;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path B IQK!\n"));
 
 	/* One shot, path B LOK & IQK */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Cont, bMaskDWord, 0x00000002);
 	ODM_SetBBReg(dm_odm, rIQK_AGC_Cont, bMaskDWord, 0x00000000);
 
 	/*  delay x ms */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("Delay %d ms for One shot, path B LOK & IQK.\n",
-		     IQK_DELAY_TIME_88E));
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
 
 	/*  Check failed */
 	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xeac = 0x%x\n", regeac));
 	regeb4 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xeb4 = 0x%x\n", regeb4));
 	regebc = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xebc = 0x%x\n", regebc));
 	regec4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xec4 = 0x%x\n", regec4));
 	regecc = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("0xecc = 0x%x\n", regecc));
 
 	if (!(regeac & BIT31) &&
 	    (((regeb4 & 0x03FF0000)>>16) != 0x142) &&
@@ -677,8 +537,7 @@ phy_PathB_IQK_8188E(struct adapter *adapt)
 	    (((regec4 & 0x03FF0000)>>16) != 0x132) &&
 	    (((regecc & 0x03FF0000)>>16) != 0x36))
 		result |= 0x02;
-	else
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path B Rx IQK fail!!\n"));
+
 	return result;
 }
 
@@ -688,9 +547,6 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 	s32 Y, TX0_C;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("Path A IQ Calibration %s !\n",
-		     (iqkok) ? "Success" : "Failed"));
 
 	if (final_candidate == 0xFF) {
 		return;
@@ -701,9 +557,6 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 		if ((X & 0x00000200) != 0)
 			X = X | 0xFFFFFC00;
 		TX0_A = (X * Oldval_0) >> 8;
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-			     ("X = 0x%x, TX0_A = 0x%x, Oldval_0 0x%x\n",
-			     X, TX0_A, Oldval_0));
 		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x3FF, TX0_A);
 
 		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(31), ((X * Oldval_0>>7) & 0x1));
@@ -713,16 +566,13 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 			Y = Y | 0xFFFFFC00;
 
 		TX0_C = (Y * Oldval_0) >> 8;
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Y = 0x%x, TX = 0x%x\n", Y, TX0_C));
 		ODM_SetBBReg(dm_odm, rOFDM0_XCTxAFE, 0xF0000000, ((TX0_C&0x3C0)>>6));
 		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x003F0000, (TX0_C&0x3F));
 
 		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(29), ((Y * Oldval_0>>7) & 0x1));
 
-		if (txonly) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("patha_fill_iqk only Tx OK\n"));
+		if (txonly)
 			return;
-		}
 
 		reg = result[final_candidate][2];
 		ODM_SetBBReg(dm_odm, rOFDM0_XARxIQImbalance, 0x3FF, reg);
@@ -741,9 +591,6 @@ static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 	s32 Y, TX1_C;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("Path B IQ Calibration %s !\n",
-		     (iqkok) ? "Success" : "Failed"));
 
 	if (final_candidate == 0xFF) {
 		return;
@@ -754,7 +601,6 @@ static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 		if ((X & 0x00000200) != 0)
 			X = X | 0xFFFFFC00;
 		TX1_A = (X * Oldval_1) >> 8;
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("X = 0x%x, TX1_A = 0x%x\n", X, TX1_A));
 		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x3FF, TX1_A);
 
 		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(27), ((X * Oldval_1>>7) & 0x1));
@@ -764,7 +610,6 @@ static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 			Y = Y | 0xFFFFFC00;
 
 		TX1_C = (Y * Oldval_1) >> 8;
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Y = 0x%x, TX1_C = 0x%x\n", Y, TX1_C));
 		ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, 0xF0000000, ((TX1_C&0x3C0)>>6));
 		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x003F0000, (TX1_C&0x3F));
 
@@ -802,7 +647,6 @@ void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup
 	if (!ODM_CheckPowerStatus(adapt))
 		return;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Save ADDA parameters.\n"));
 	for (i = 0; i < RegisterNum; i++) {
 		ADDABackup[i] = ODM_GetBBReg(dm_odm, ADDAReg[i], bMaskDWord);
 	}
@@ -817,7 +661,6 @@ static void _PHY_SaveMACRegisters(
 	u32 i;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Save MAC parameters.\n"));
 	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++) {
 		MACBackup[i] = ODM_Read1Byte(dm_odm, MACReg[i]);
 	}
@@ -830,7 +673,6 @@ static void reload_adda_reg(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Reload ADDA power saving parameters !\n"));
 	for (i = 0; i < RegiesterNum; i++)
 		ODM_SetBBReg(dm_odm, ADDAReg[i], bMaskDWord, ADDABackup[i]);
 }
@@ -846,7 +688,6 @@ _PHY_ReloadMACRegisters(
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Reload MAC parameters !\n"));
 	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++) {
 		ODM_Write1Byte(dm_odm, MACReg[i], (u8)MACBackup[i]);
 	}
@@ -865,7 +706,6 @@ _PHY_PathADDAOn(
 	u32 i;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("ADDA ON.\n"));
 
 	pathOn = isPathAOn ? 0x04db25a4 : 0x0b1b25a4;
 	if (!is2t) {
@@ -890,8 +730,6 @@ _PHY_MACSettingCalibration(
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("MAC settings for Calibration.\n"));
-
 	ODM_Write1Byte(dm_odm, MACReg[i], 0x3F);
 
 	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++) {
@@ -908,8 +746,6 @@ _PHY_PathAStandBy(
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path-A standby mode!\n"));
-
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x0);
 	ODM_SetBBReg(dm_odm, 0x840, bMaskDWord, 0x00010000);
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
@@ -924,8 +760,6 @@ static void _PHY_PIModeSwitch(
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("BB Switch to %s mode!\n", (PIMode ? "PI" : "SI")));
-
 	mode = PIMode ? 0x01000100 : 0x01000000;
 	ODM_SetBBReg(dm_odm, rFPGA0_XA_HSSIParameter1, bMaskDWord, mode);
 	ODM_SetBBReg(dm_odm, rFPGA0_XB_HSSIParameter1, bMaskDWord, mode);
@@ -956,8 +790,6 @@ static bool phy_SimularityCompare_8188E(
 	else
 		bound = 4;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("===> IQK:phy_SimularityCompare_8188E c1 %d c2 %d!!!\n", c1, c2));
-
 	sim_bitmap = 0;
 
 	for (i = 0; i < bound; i++) {
@@ -979,10 +811,6 @@ static bool phy_SimularityCompare_8188E(
 		diff = (tmp1 > tmp2) ? (tmp1 - tmp2) : (tmp2 - tmp1);
 
 		if (diff > MAX_TOLERANCE) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-				     ("IQK:phy_SimularityCompare_8188E differnece overflow index %d compare1 0x%x compare2 0x%x!!!\n",
-				     i, resulta[c1][i], resulta[c2][i]));
-
 			if ((i == 2 || i == 6) && !sim_bitmap) {
 				if (resulta[c1][i] + resulta[c1][i+1] == 0)
 					final_candidate[(i/4)] = c2;
@@ -996,8 +824,6 @@ static bool phy_SimularityCompare_8188E(
 		}
 	}
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK:phy_SimularityCompare_8188E sim_bitmap   %d !!!\n", sim_bitmap));
-
 	if (sim_bitmap == 0) {
 		for (i = 0; i < (bound/4); i++) {
 			if (final_candidate[i] != 0xFF) {
@@ -1066,14 +892,11 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	/* 		PHY_REG.txt , and radio_a, radio_b.txt */
 
 	if (t == 0) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQ Calibration for %s for %d times\n", (is2t ? "2T2R" : "1T1R"), t));
-
 		/*  Save ADDA parameters, turn Path A ADDA on */
 		_PHY_SaveADDARegisters(adapt, ADDA_REG, dm_odm->RFCalibrateInfo.ADDA_backup, IQK_ADDA_REG_NUM);
 		_PHY_SaveMACRegisters(adapt, IQK_MAC_REG, dm_odm->RFCalibrateInfo.IQK_MAC_backup);
 		_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQ Calibration for %s for %d times\n", (is2t ? "2T2R" : "1T1R"), t));
 
 	_PHY_PathADDAOn(adapt, ADDA_REG, true, is2t);
 	if (t == 0)
@@ -1111,7 +934,6 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 		ODM_SetBBReg(dm_odm, rConfig_AntB, bMaskDWord, 0x0f600000);
 
 	/*  IQ calibration setting */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK setting!\n"));
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
 	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, 0x01007c00);
 	ODM_SetBBReg(dm_odm, rRx_IQK, bMaskDWord, 0x81004800);
@@ -1119,9 +941,8 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	for (i = 0; i < retryCount; i++) {
 		PathAOK = phy_PathA_IQK_8188E(adapt, is2t);
 		if (PathAOK == 0x01) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Tx IQK Success!!\n"));
-				result[t][0] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
-				result[t][1] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
+			result[t][0] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
+			result[t][1] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
 			break;
 		}
 	}
@@ -1129,19 +950,12 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	for (i = 0; i < retryCount; i++) {
 		PathAOK = phy_PathA_RxIQK(adapt, is2t);
 		if (PathAOK == 0x03) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path A Rx IQK Success!!\n"));
-				result[t][2] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
-				result[t][3] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
+			result[t][2] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
+			result[t][3] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 			break;
-		} else {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Rx IQK Fail!!\n"));
 		}
 	}
 
-	if (0x00 == PathAOK) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A IQK failed!!\n"));
-	}
-
 	if (is2t) {
 		_PHY_PathAStandBy(adapt);
 
@@ -1151,26 +965,19 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 		for (i = 0; i < retryCount; i++) {
 			PathBOK = phy_PathB_IQK_8188E(adapt);
 			if (PathBOK == 0x03) {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B IQK Success!!\n"));
 				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord)&0x3FF0000)>>16;
 				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord)&0x3FF0000)>>16;
 				result[t][6] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord)&0x3FF0000)>>16;
 				result[t][7] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord)&0x3FF0000)>>16;
 				break;
 			} else if (i == (retryCount - 1) && PathBOK == 0x01) {	/* Tx IQK OK */
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B Only Tx IQK Success!!\n"));
 				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord)&0x3FF0000)>>16;
 				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord)&0x3FF0000)>>16;
 			}
 		}
-
-		if (0x00 == PathBOK) {
-			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B IQK failed!!\n"));
-		}
 	}
 
 	/* Back to BB mode, load original value */
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK:Back to BB mode, load original value!\n"));
 	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0);
 
 	if (t != 0) {
@@ -1196,7 +1003,6 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 		ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x01008c00);
 		ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x01008c00);
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("phy_IQCalibrate_8188E() <==\n"));
 }
 
 #define ODM_TARGET_CHNL_NUM_2G_5G	59
@@ -1313,11 +1119,9 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 		return;
 
 	if (recovery) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, ("PHY_IQCalibrate_8188E: Return due to recovery!\n"));
 		reload_adda_reg(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
 		return;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK:Start!!!\n"));
 
 	for (i = 0; i < 8; i++) {
 		result[0][i] = 0;
@@ -1342,7 +1146,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 			is12simular = phy_SimularityCompare_8188E(adapt, result, 0, 1);
 			if (is12simular) {
 				final_candidate = 0;
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is12simular final_candidate is %x\n", final_candidate));
 				break;
 			}
 		}
@@ -1351,14 +1154,12 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 			is13simular = phy_SimularityCompare_8188E(adapt, result, 0, 2);
 			if (is13simular) {
 				final_candidate = 0;
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is13simular final_candidate is %x\n", final_candidate));
 
 				break;
 			}
 			is23simular = phy_SimularityCompare_8188E(adapt, result, 1, 2);
 			if (is23simular) {
 				final_candidate = 1;
-				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is23simular final_candidate is %x\n", final_candidate));
 			} else {
 				final_candidate = 3;
 			}
@@ -1374,9 +1175,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 		RegEBC = result[i][5];
 		RegEC4 = result[i][6];
 		RegECC = result[i][7];
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-			     ("IQK: RegE94=%x RegE9C=%x RegEA4=%x RegEAC=%x RegEB4=%x RegEBC=%x RegEC4=%x RegECC=%x\n",
-			     RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC));
 	}
 
 	if (final_candidate != 0xff) {
@@ -1392,15 +1190,9 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 		dm_odm->RFCalibrateInfo.RegEBC = RegEBC;
 		RegEC4 = result[final_candidate][6];
 		RegECC = result[final_candidate][7];
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-			     ("IQK: final_candidate is %x\n", final_candidate));
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-			     ("IQK: RegE94=%x RegE9C=%x RegEA4=%x RegEAC=%x RegEB4=%x RegEBC=%x RegEC4=%x RegECC=%x\n",
-			     RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC));
 		pathaok = true;
 		pathbok = true;
 	} else {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK: FAIL use default value\n"));
 		dm_odm->RFCalibrateInfo.RegE94 = 0x100;
 		dm_odm->RFCalibrateInfo.RegEB4 = 0x100;	/* X default value */
 		dm_odm->RFCalibrateInfo.RegE9C = 0x0;
@@ -1422,11 +1214,8 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][i] = result[final_candidate][i];
 		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].bIQKDone = true;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("\nIQK OK Indexforchannel %d.\n", Indexforchannel));
 
 	_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
-
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK finished\n"));
 }
 
 void PHY_LCCalibrate_8188E(struct adapter *adapt)
@@ -1462,9 +1251,6 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 	}
 
 	dm_odm->RFCalibrateInfo.bLCKInProgress = false;
-
-	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
-		     ("LCK:Finish!!!interface %d\n", dm_odm->InterfaceIndex));
 }
 
 static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2t)
-- 
2.31.1

