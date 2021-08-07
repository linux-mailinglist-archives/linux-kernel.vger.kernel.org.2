Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102683E3473
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhHGJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhHGJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA5EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso10613501wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anTNylBaFbPzQClsbJE6Ftmd0kLco7fvt+SbgKJbj2s=;
        b=erinW0BdfaWv6CGjSO25SXUdj+hf3LYAngqh5xAS3LkGHpRN3GyKpQHKGwQEKKWZc5
         ZJatnwCTwj9WK8lqVJIyaZfIeRk9sOk1I25EsMHBax+Pm0FEIEwD0U++Q4yPd6+uNZO+
         3OKqxdTRKykSwWYSaYdoEmQCjyOd7V4Wr2xgew52mrT1UvcqYg9vguMq4FA+NAna/Lnu
         LAdID/0yae9VrTaf/zmQDxuBi72/ebD+K0v7577uHUZVTY25/Dfn/i/s4Zgr2jdYNsQs
         C1cX4e2/nv08cSOVOHYkylBLsAx+CwoQ7uoAyiM4sL0S1IzYZYetel+Le8ctBAq4vOg3
         wN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anTNylBaFbPzQClsbJE6Ftmd0kLco7fvt+SbgKJbj2s=;
        b=NMjU2RBmMi1yhcW2Q98OrwtLgdpTb+pc3iPwCaZfgG9x5/kZUjYKK9nfoYdzHt3iq0
         S6GSI37p2FfZ/mRpsq/L1YYJfLg/haM+bnM0g88ziVSqq7dFF2Dis7rr3MQA/IaeUxXl
         rqXmgcxToSkPvEwrXhrAsabi6S660bQeNedv489N9kdSXYjzUx23G9ZpBuOc6/pQ4wgs
         OrhV/f16GeAFV7Hq1ovYCXf/aYd+u6hmCfO7sTdls8kgCGJyIlc4hWSM2zeMNhjNyyaj
         BlnTUi0fvzeB7CNaqvIcTMGx3CJ88/cxDCpecCmXhBUI/bpIwwqxuMM786GM3iEccRct
         2P8Q==
X-Gm-Message-State: AOAM532uRDSWBBAIT224bDub892662AcfScM6p458WIq2XpRG6STF8mf
        K6fDg3DtguB6Snfgnsp8B5W9bcRNNps=
X-Google-Smtp-Source: ABdhPJyPFjta9lKwdkmSdiZIZlbnwq4zLplY9Uf6CsIxpNvX5go4weOL5HcP1QtxTilFEz25vFcrPQ==
X-Received: by 2002:a05:600c:3223:: with SMTP id r35mr23723437wmp.145.1628329707344;
        Sat, 07 Aug 2021 02:48:27 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id i186sm15346703wmi.43.2021.08.07.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] staging: rtl8723bs: clean driver from unused RF paths
Date:   Sat,  7 Aug 2021 11:48:01 +0200
Message-Id: <23060c85ab9aa468c9c021378f0dc8a8f887a578.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl8723bs support only two rf paths (A and B), remove all
the others (C, D, BC, ...) as they are unused. Keep
just one enum selecting rf path, remove unused macro
indicating max rf path number, add an item in rf_path
enum for this pourpose.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf.c      |  52 +++---
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 164 +++++++++---------
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    |  22 +--
 drivers/staging/rtl8723bs/hal/odm.c           |   4 +-
 drivers/staging/rtl8723bs/hal/odm.h           |  20 ---
 .../staging/rtl8723bs/hal/odm_CfoTracking.c   |   2 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  |  36 ++--
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h  |   2 +-
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  |  18 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.c        |   4 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.h        |   2 +-
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  12 +-
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  42 ++---
 .../staging/rtl8723bs/hal/rtl8723b_rf6052.c   |  16 +-
 drivers/staging/rtl8723bs/include/hal_phy.h   |   3 +-
 15 files changed, 185 insertions(+), 214 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.c b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
index 9c6d3bf2f2ea..7bef05a9a063 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
@@ -30,7 +30,7 @@ void ODM_ClearTxPowerTrackingState(struct dm_odm_t *pDM_Odm)
 	pDM_Odm->BbSwingIdxCck = pDM_Odm->DefaultCckIndex;
 	pDM_Odm->RFCalibrateInfo.CCK_index = 0;
 
-	for (p = ODM_RF_PATH_A; p < MAX_RF_PATH; ++p) {
+	for (p = RF_PATH_A; p < MAX_RF_PATH; ++p) {
 		pDM_Odm->BbSwingIdxOfdmBase[p] = pDM_Odm->DefaultOfdmIndex;
 		pDM_Odm->BbSwingIdxOfdm[p] = pDM_Odm->DefaultOfdmIndex;
 		pDM_Odm->RFCalibrateInfo.OFDM_index[p] = pDM_Odm->DefaultOfdmIndex;
@@ -93,7 +93,7 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 	pDM_Odm->RFCalibrateInfo.TXPowerTrackingCallbackCnt++;
 	pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = true;
 
-	ThermalValue = (u8)PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, c.ThermalRegAddr, 0xfc00);	/* 0x42: RF Reg[15:10] 88E */
+	ThermalValue = (u8)PHY_QueryRFReg(pDM_Odm->Adapter, RF_PATH_A, c.ThermalRegAddr, 0xfc00);	/* 0x42: RF Reg[15:10] 88E */
 	if (
 		!pDM_Odm->RFCalibrateInfo.TxPowerTrackControl ||
 		pHalData->EEPROMThermalMeter == 0 ||
@@ -154,49 +154,49 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 
 		/* 4 7.1 The Final Power Index = BaseIndex + PowerIndexOffset */
 		if (ThermalValue > pHalData->EEPROMThermalMeter) {
-			pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_A] =
-				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A];
-			pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A] =
+			pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[RF_PATH_A] =
+				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_A];
+			pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_A] =
 				deltaSwingTableIdx_TUP_A[delta];
 
 			/*  Record delta swing for mix mode power tracking */
-			pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] =
+			pDM_Odm->Absolute_OFDMSwingIdx[RF_PATH_A] =
 				deltaSwingTableIdx_TUP_A[delta];
 
 			if (c.RfPathCount > 1) {
-				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_B] =
-					pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B];
-				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B] =
+				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[RF_PATH_B] =
+					pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_B];
+				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_B] =
 					deltaSwingTableIdx_TUP_B[delta];
 
 				/*  Record delta swing for mix mode power tracking */
-				pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] =
+				pDM_Odm->Absolute_OFDMSwingIdx[RF_PATH_B] =
 					deltaSwingTableIdx_TUP_B[delta];
 			}
 
 		} else {
-			pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_A] =
-				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A];
-			pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A] =
+			pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[RF_PATH_A] =
+				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_A];
+			pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_A] =
 				-1 * deltaSwingTableIdx_TDOWN_A[delta];
 
 			/*  Record delta swing for mix mode power tracking */
-			pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] =
+			pDM_Odm->Absolute_OFDMSwingIdx[RF_PATH_A] =
 				-1 * deltaSwingTableIdx_TDOWN_A[delta];
 
 			if (c.RfPathCount > 1) {
-				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_B] =
-					pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B];
-				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B] =
+				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[RF_PATH_B] =
+					pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_B];
+				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[RF_PATH_B] =
 					-1 * deltaSwingTableIdx_TDOWN_B[delta];
 
 				 /*  Record delta swing for mix mode power tracking */
-				pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] =
+				pDM_Odm->Absolute_OFDMSwingIdx[RF_PATH_B] =
 					-1 * deltaSwingTableIdx_TDOWN_B[delta];
 			}
 		}
 
-		for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++) {
+		for (p = RF_PATH_A; p < c.RfPathCount; p++) {
 			if (
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[p] ==
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[p]
@@ -230,17 +230,17 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		/* else if (pDM_Odm->RFCalibrateInfo.CCK_index < 0) */
 			/* pDM_Odm->RFCalibrateInfo.CCK_index = 0; */
 	} else {
-			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
+			for (p = RF_PATH_A; p < c.RfPathCount; p++)
 				pDM_Odm->RFCalibrateInfo.PowerIndexOffset[p] = 0;
 	}
 
 	/* Print Swing base & current */
-	for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++) {
+	for (p = RF_PATH_A; p < c.RfPathCount; p++) {
 	}
 
 	if (
-		(pDM_Odm->RFCalibrateInfo.PowerIndexOffset[ODM_RF_PATH_A] != 0 ||
-		 pDM_Odm->RFCalibrateInfo.PowerIndexOffset[ODM_RF_PATH_B] != 0) &&
+		(pDM_Odm->RFCalibrateInfo.PowerIndexOffset[RF_PATH_A] != 0 ||
+		 pDM_Odm->RFCalibrateInfo.PowerIndexOffset[RF_PATH_B] != 0) &&
 		 pDM_Odm->RFCalibrateInfo.TxPowerTrackControl
 	 ) {
 		/* 4 7.2 Configure the Swing Table to adjust Tx Power. */
@@ -253,16 +253,16 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		/*  2012/04/25 MH Add for tx power tracking to set tx power in tx agc for 88E. */
 
 		if (ThermalValue > pHalData->EEPROMThermalMeter) {
-			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
+			for (p = RF_PATH_A; p < c.RfPathCount; p++)
 					(*c.ODM_TxPwrTrackSetPwr)(pDM_Odm, MIX_MODE, p, 0);
 		} else {
-			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
+			for (p = RF_PATH_A; p < c.RfPathCount; p++)
 				(*c.ODM_TxPwrTrackSetPwr)(pDM_Odm, MIX_MODE, p, Indexforchannel);
 		}
 
 		/*  Record last time Power Tracking result as base. */
 		pDM_Odm->BbSwingIdxCckBase = pDM_Odm->BbSwingIdxCck;
-		for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
+		for (p = RF_PATH_A; p < c.RfPathCount; p++)
 			pDM_Odm->BbSwingIdxOfdmBase[p] = pDM_Odm->BbSwingIdxOfdm[p];
 
 		/* Record last Power Tracking Thermal Value */
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index c696569ae5cf..a52748f7b56e 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -67,9 +67,9 @@ static void setIqkMatrix_8723B(
 			IqkResult_Y = IqkResult_Y | 0xFFFFFC00;
 		ele_C = ((IqkResult_Y * ele_D)>>8)&0x000003FF;
 
-		/* if (RFPath == ODM_RF_PATH_A) */
+		/* if (RFPath == RF_PATH_A) */
 		switch (RFPath) {
-		case ODM_RF_PATH_A:
+		case RF_PATH_A:
 			/* write new elements A, C, D to regC80 and regC94,
 			 * element B is always 0
 			 */
@@ -82,7 +82,7 @@ static void setIqkMatrix_8723B(
 			value32 = ((IqkResult_X * ele_D)>>7)&0x01;
 			PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, BIT24, value32);
 			break;
-		case ODM_RF_PATH_B:
+		case RF_PATH_B:
 			/* write new elements A, C, D to regC88 and regC9C,
 			 * element B is always 0
 			 */
@@ -101,13 +101,13 @@ static void setIqkMatrix_8723B(
 		}
 	} else {
 		switch (RFPath) {
-		case ODM_RF_PATH_A:
+		case RF_PATH_A:
 			PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XATxIQImbalance, bMaskDWord, OFDMSwingTable_New[OFDM_index]);
 			PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XCTxAFE, bMaskH4Bits, 0x00);
 			PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, BIT24, 0x00);
 			break;
 
-		case ODM_RF_PATH_B:
+		case RF_PATH_B:
 			PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XBTxIQImbalance, bMaskDWord, OFDMSwingTable_New[OFDM_index]);
 			PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XDTxAFE, bMaskH4Bits, 0x00);
 			PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, BIT28, 0x00);
@@ -380,13 +380,13 @@ static u8 phy_PathA_IQK_8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 
 	/* 	enable path A PA in TXIQK mode */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0003f);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xc7f87);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0003f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xc7f87);
 	/* 	disable path B PA in TXIQK mode */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xed, bRFRegOffsetMask, 0x00020); */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x43, bRFRegOffsetMask, 0x40ec1); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xed, bRFRegOffsetMask, 0x00020); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x43, bRFRegOffsetMask, 0x40ec1); */
 
 	/* 1 Tx IQK */
 	/* IQK setting */
@@ -480,12 +480,12 @@ static u8 phy_PathA_RxIQK8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
 	/* LNA2 off, PA on for Dcut */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7fb7);
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x0); */
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7fb7);
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x0); */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x808000);
 
 	/* IQK setting */
@@ -564,16 +564,16 @@ static u8 phy_PathA_RxIQK8723B(
 
 	/* modify RXIQK mode table */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
 	/* LAN2 on, PA off for Dcut */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7d77);
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x0); */
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7d77);
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x0); */
 
 	/* PA, PAD setting */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xdf, bRFRegOffsetMask, 0xf80);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x55, bRFRegOffsetMask, 0x4021f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0xf80);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x55, bRFRegOffsetMask, 0x4021f);
 
 
 	/* IQK setting */
@@ -631,7 +631,7 @@ static u8 phy_PathA_RxIQK8723B(
 	/* 	PA/PAD controlled by 0x0 */
 	/* leave IQK mode */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x780);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x780);
 
 	/* Allen 20131125 */
 	tmp = (regEAC & 0x03FF0000)>>16;
@@ -666,13 +666,13 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 
 	/* 	in TXIQK mode */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1); */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x20000); */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0003f); */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xc7f87); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x20000); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0003f); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xc7f87); */
 	/* 	enable path B PA in TXIQK mode */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xed, 0x20, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x43, bRFRegOffsetMask, 0x30fc1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xed, 0x20, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x43, bRFRegOffsetMask, 0x30fc1);
 
 
 
@@ -700,7 +700,7 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
 
 	/* switch to path B */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, 0x00000280);
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xb0, bRFRegOffsetMask, 0xeffe0); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xb0, bRFRegOffsetMask, 0xeffe0); */
 
 	/* GNT_BT = 0 */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
@@ -760,13 +760,13 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	/* switch to path B */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, 0x00000280);
 	/* modify RXIQK mode table */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7fb7);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7fb7);
 	/* open PA S1 & SMIXER */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xed, 0x20, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x43, bRFRegOffsetMask, 0x30fcd);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xed, 0x20, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x43, bRFRegOffsetMask, 0x30fcd);
 
 
 	/* IQK setting */
@@ -794,7 +794,7 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 
 	/* switch to path B */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, 0x00000280);
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xb0, bRFRegOffsetMask, 0xeffe0); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xb0, bRFRegOffsetMask, 0xeffe0); */
 
 	/* GNT_BT = 0 */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
@@ -844,19 +844,19 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	/* modify RXIQK mode table */
 	/* 20121009, Kordan> RF Mode = 3 */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7d77);
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x0); */
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7d77);
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x0); */
 
 	/* open PA S1 & close SMIXER */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xed, 0x20, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x43, bRFRegOffsetMask, 0x30ebd);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xed, 0x20, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x43, bRFRegOffsetMask, 0x30ebd);
 
 	/* PA, PAD setting */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xdf, bRFRegOffsetMask, 0xf80); */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x56, bRFRegOffsetMask, 0x51000); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0xf80); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x56, bRFRegOffsetMask, 0x51000); */
 
 	/* IQK setting */
 	PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK, bMaskDWord, 0x01004800);
@@ -881,7 +881,7 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 
 	/* switch to path B */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, 0x00000280);
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xb0, bRFRegOffsetMask, 0xeffe0); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xb0, bRFRegOffsetMask, 0xeffe0); */
 
 	/* GNT_BT = 0 */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, 0x00000800);
@@ -909,7 +909,7 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	/* 	PA/PAD controlled by 0x0 */
 	/* leave IQK mode */
 /* 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, 0xffffff00, 0x00000000); */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_B, 0xdf, bRFRegOffsetMask, 0x180); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_B, 0xdf, bRFRegOffsetMask, 0x180); */
 
 
 
@@ -1384,7 +1384,7 @@ static void phy_IQCalibrate_8723B(
 
 	/* save RF path for 8723B */
 /* 	Path_SEL_BB = PHY_QueryBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord); */
-/* 	Path_SEL_RF = PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xb0, 0xfffff); */
+/* 	Path_SEL_RF = PHY_QueryRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xb0, 0xfffff); */
 
 	/* MAC settings */
 	_PHY_MACSettingCalibration8723B(padapter, IQK_MAC_REG, pDM_Odm->RFCalibrateInfo.IQK_MAC_backup);
@@ -1406,12 +1406,12 @@ static void phy_IQCalibrate_8723B(
 /* RX IQ calibration setting for 8723B D cut large current issue when leaving IPS */
 
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7fb7);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xed, 0x20, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x43, bRFRegOffsetMask, 0x60fbd);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7fb7);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xed, 0x20, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x43, bRFRegOffsetMask, 0x60fbd);
 
 /* path A TX IQK */
 	for (i = 0 ; i < retryCount ; i++) {
@@ -1420,7 +1420,7 @@ static void phy_IQCalibrate_8723B(
 		if (PathAOK == 0x01) {
 			/*  Path A Tx IQK Success */
 			PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
-			pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_A] = PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x8, bRFRegOffsetMask);
+			pDM_Odm->RFCalibrateInfo.TxLOK[RF_PATH_A] = PHY_QueryRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x8, bRFRegOffsetMask);
 
 				result[t][0] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
 				result[t][1] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
@@ -1452,7 +1452,7 @@ static void phy_IQCalibrate_8723B(
 			if (PathBOK == 0x01) {
 				/*  Path B Tx IQK Success */
 				PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
-				pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_B] = PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_B, 0x8, bRFRegOffsetMask);
+				pDM_Odm->RFCalibrateInfo.TxLOK[RF_PATH_B] = PHY_QueryRFReg(pDM_Odm->Adapter, RF_PATH_B, 0x8, bRFRegOffsetMask);
 
 				result[t][4] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
 				result[t][5] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
@@ -1489,7 +1489,7 @@ static void phy_IQCalibrate_8723B(
 
 		/* Reload RF path */
 /* 		PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, Path_SEL_BB); */
-/* 		PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xb0, 0xfffff, Path_SEL_RF); */
+/* 		PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xb0, 0xfffff, Path_SEL_RF); */
 
 		/* Allen initial gain 0xc50 */
 		/*  Restore RX initial gain */
@@ -1526,46 +1526,46 @@ static void phy_LCCalibrate_8723B(struct dm_odm_t *pDM_Odm, bool is2T)
 	if ((tmpReg&0x70) != 0) {
 		/* 1. Read original RF mode */
 		/* Path-A */
-		RF_Amode = PHY_QueryRFReg(padapter, ODM_RF_PATH_A, RF_AC, bMask12Bits);
+		RF_Amode = PHY_QueryRFReg(padapter, RF_PATH_A, RF_AC, bMask12Bits);
 
 		/* Path-B */
 		if (is2T)
-			RF_Bmode = PHY_QueryRFReg(padapter, ODM_RF_PATH_B, RF_AC, bMask12Bits);
+			RF_Bmode = PHY_QueryRFReg(padapter, RF_PATH_B, RF_AC, bMask12Bits);
 
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
-		PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode&0x8FFFF)|0x10000);
+		PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode&0x8FFFF)|0x10000);
 
 		/* Path-B */
 		if (is2T)
-			PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode&0x8FFFF)|0x10000);
+			PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode&0x8FFFF)|0x10000);
 	}
 
 	/* 3. Read RF reg18 */
-	LC_Cal = PHY_QueryRFReg(padapter, ODM_RF_PATH_A, RF_CHNLBW, bMask12Bits);
+	LC_Cal = PHY_QueryRFReg(padapter, RF_PATH_A, RF_CHNLBW, bMask12Bits);
 
 	/* 4. Set LC calibration begin	bit15 */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xB0, bRFRegOffsetMask, 0xDFBE0); /*  LDO ON */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal|0x08000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xB0, bRFRegOffsetMask, 0xDFBE0); /*  LDO ON */
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal|0x08000);
 
 	mdelay(100);
 
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xB0, bRFRegOffsetMask, 0xDFFE0); /*  LDO OFF */
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xB0, bRFRegOffsetMask, 0xDFFE0); /*  LDO OFF */
 
 	/*  Channel 10 LC calibration issue for 8723bs with 26M xtal */
 	if (pDM_Odm->SupportInterface == ODM_ITRF_SDIO && pDM_Odm->PackageType >= 0x2) {
-		PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal);
+		PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal);
 	}
 
 	/* Restore original situation */
 	if ((tmpReg&0x70) != 0) { /* Deal with contisuous TX case */
 		/* Path-A */
 		rtw_write8(pDM_Odm->Adapter, 0xd03, tmpReg);
-		PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
+		PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
 
 		/* Path-B */
 		if (is2T)
-			PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_B, RF_AC, bMask12Bits, RF_Bmode);
+			PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_B, RF_AC, bMask12Bits, RF_Bmode);
 	} else /*  Deal with Packet TX case */
 		rtw_write8(pDM_Odm->Adapter, REG_TXPAUSE, 0x00);
 }
@@ -1625,7 +1625,7 @@ void PHY_IQCalibrate_8723B(
 		u8 path, bResult = SUCCESS;
 		struct odm_rf_cal_t *pRFCalibrateInfo = &pDM_Odm->RFCalibrateInfo;
 
-		path = (PHY_QueryBBReg(pDM_Odm->Adapter, rS0S1_PathSwitch, bMaskByte0) == 0x00) ? ODM_RF_PATH_A : ODM_RF_PATH_B;
+		path = (PHY_QueryBBReg(pDM_Odm->Adapter, rS0S1_PathSwitch, bMaskByte0) == 0x00) ? RF_PATH_A : RF_PATH_B;
 
 		/*  Restore TX IQK */
 		for (i = 0; i < 3; ++i) {
@@ -1649,11 +1649,11 @@ void PHY_IQCalibrate_8723B(
 			PHY_SetBBReg(pDM_Odm->Adapter, offset, bMaskDWord, data);
 		}
 
-		if (pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_A] == 0) {
+		if (pDM_Odm->RFCalibrateInfo.TxLOK[RF_PATH_A] == 0) {
 			bResult = FAIL;
 		} else {
-			PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXM_IDAC, bRFRegOffsetMask, pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_A]);
-			PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_B, RF_TXM_IDAC, bRFRegOffsetMask, pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_B]);
+			PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXM_IDAC, bRFRegOffsetMask, pDM_Odm->RFCalibrateInfo.TxLOK[RF_PATH_A]);
+			PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_B, RF_TXM_IDAC, bRFRegOffsetMask, pDM_Odm->RFCalibrateInfo.TxLOK[RF_PATH_B]);
 		}
 
 		if (bResult == SUCCESS)
@@ -1669,7 +1669,7 @@ void PHY_IQCalibrate_8723B(
 	GNT_BT_default = PHY_QueryBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord);
 	/*  Save RF Path */
 /* 	Path_SEL_BB = PHY_QueryBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord); */
-/* 	Path_SEL_RF = PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xb0, 0xfffff); */
+/* 	Path_SEL_RF = PHY_QueryRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xb0, 0xfffff); */
 
     /* set GNT_BT = 0, pause BT traffic */
 /* 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, BIT12, 0x0); */
@@ -1770,15 +1770,15 @@ void PHY_IQCalibrate_8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord, GNT_BT_default);
 	/*  Restore RF Path */
 /* 	PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, Path_SEL_BB); */
-/* 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xb0, 0xfffff, Path_SEL_RF); */
+/* 	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xb0, 0xfffff, Path_SEL_RF); */
 
 	/* Resotr RX mode table parameter */
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xe6177);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0xed, 0x20, 0x1);
-	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x43, bRFRegOffsetMask, 0x300bd);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x18000);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0001f);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xe6177);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0xed, 0x20, 0x1);
+	PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, 0x43, bRFRegOffsetMask, 0x300bd);
 
 	/* set GNT_BT = HW control */
 /* 	PHY_SetBBReg(pDM_Odm->Adapter, 0x764, BIT12, 0x0); */
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index a47a0a1cae22..3e426c975828 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -16,7 +16,7 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 	u8	value = 0;
 
-	if (RfPath > ODM_RF_PATH_D)
+	if (RfPath >= RF_PATH_MAX)
 		return 0;
 
 	switch (RateSection) {
@@ -47,7 +47,7 @@ phy_SetTxPowerByRateBase(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 
-	if (RfPath > ODM_RF_PATH_D)
+	if (RfPath >= RF_PATH_MAX)
 		return;
 
 	switch (RateSection) {
@@ -72,7 +72,7 @@ struct adapter *padapter
 {
 	u8 path, base;
 
-	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_B; ++path) {
+	for (path = RF_PATH_A; path <= RF_PATH_B; ++path) {
 		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_11M);
 		phy_SetTxPowerByRateBase(padapter, path, CCK, RF_1TX, base);
 
@@ -347,7 +347,7 @@ static void PHY_StoreTxPowerByRateNew(
 
 	PHY_GetRateValuesOfTxPowerByRate(padapter, RegAddr, BitMask, Data, rateIndex, PwrByRateVal, &rateNum);
 
-	if (RfPath > ODM_RF_PATH_D)
+	if (RfPath >= RF_PATH_MAX)
 		return;
 
 	if (TxNum > RF_MAX_TX_NUM)
@@ -418,7 +418,7 @@ struct adapter *padapter
 	u8 mcs0_7Rates[8] = {
 		MGN_MCS0, MGN_MCS1, MGN_MCS2, MGN_MCS3, MGN_MCS4, MGN_MCS5, MGN_MCS6, MGN_MCS7
 	};
-	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_D; ++path) {
+	for (path = RF_PATH_A; path < RF_PATH_MAX; ++path) {
 		for (txNum = RF_1TX; txNum < RF_MAX_TX_NUM; ++txNum) {
 			/*  CCK */
 			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_11M);
@@ -619,7 +619,7 @@ s8 PHY_GetTxPowerByRate(
 		   padapter->registrypriv.RegEnableTxPowerByRate == 0)
 		return 0;
 
-	if (RFPath > ODM_RF_PATH_D)
+	if (RFPath >= RF_PATH_MAX)
 		return value;
 
 	if (TxNum >= RF_MAX_TX_NUM)
@@ -643,7 +643,7 @@ void PHY_SetTxPowerByRate(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	u8 rateIndex = PHY_GetRateIndexOfTxPowerByRate(Rate);
 
-	if (RFPath > ODM_RF_PATH_D)
+	if (RFPath >= RF_PATH_MAX)
 		return;
 
 	if (TxNum >= RF_MAX_TX_NUM)
@@ -809,9 +809,9 @@ void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
 		for (bw = 0; bw < MAX_2_4G_BANDWIDTH_NUM; ++bw) {
 			for (channel = 0; channel < CHANNEL_MAX_NUMBER_2G; ++channel) {
 				for (rateSection = 0; rateSection < MAX_RATE_SECTION_NUM; ++rateSection) {
-					tempPwrLmt = pHalData->TxPwrLimit_2_4G[regulation][bw][rateSection][channel][ODM_RF_PATH_A];
+					tempPwrLmt = pHalData->TxPwrLimit_2_4G[regulation][bw][rateSection][channel][RF_PATH_A];
 
-					for (rfPath = ODM_RF_PATH_A; rfPath < MAX_RF_PATH_NUM; ++rfPath) {
+					for (rfPath = RF_PATH_A; rfPath < MAX_RF_PATH_NUM; ++rfPath) {
 						if (pHalData->odmpriv.PhyRegPgValueType == PHY_REG_PG_EXACT_VALUE) {
 							if (rateSection == 2) /*  HT 1T */
 								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, HT_MCS0_MCS7);
@@ -904,10 +904,10 @@ void PHY_SetTxPowerLimit(
 	if (channelIndex == -1)
 		return;
 
-	prevPowerLimit = pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A];
+	prevPowerLimit = pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][RF_PATH_A];
 
 	if (powerLimit < prevPowerLimit)
-		pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A] = powerLimit;
+		pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channelIndex][RF_PATH_A] = powerLimit;
 }
 
 void Hal_ChannelPlanToRegulation(struct adapter *Adapter, u16 ChannelPlan)
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 45fdd51b784e..fd5656398c3d 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -718,7 +718,7 @@ void odm_TXPowerTrackingInit(struct dm_odm_t *pDM_Odm)
 	pDM_Odm->BbSwingIdxCckBase = pDM_Odm->DefaultCckIndex;
 	pDM_Odm->RFCalibrateInfo.CCK_index = pDM_Odm->DefaultCckIndex;
 
-	for (p = ODM_RF_PATH_A; p < MAX_RF_PATH; ++p) {
+	for (p = RF_PATH_A; p < MAX_RF_PATH; ++p) {
 		pDM_Odm->BbSwingIdxOfdmBase[p] = pDM_Odm->DefaultOfdmIndex;
 		pDM_Odm->RFCalibrateInfo.OFDM_index[p] = pDM_Odm->DefaultOfdmIndex;
 		pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[p] = 0;
@@ -736,7 +736,7 @@ void ODM_TXPowerTrackingCheck(struct dm_odm_t *pDM_Odm)
 		return;
 
 	if (!pDM_Odm->RFCalibrateInfo.TM_Trigger) { /* at least delay 1 sec */
-		PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_T_METER_NEW, (BIT17 | BIT16), 0x03);
+		PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RF_T_METER_NEW, (BIT17 | BIT16), 0x03);
 
 		pDM_Odm->RFCalibrateInfo.TM_Trigger = 1;
 		return;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index abf6547518fb..c77fb6e341b2 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -998,26 +998,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	#endif
 };
 
-#define ODM_RF_PATH_MAX 2
-
-enum odm_rf_radio_path_e {
-	ODM_RF_PATH_A = 0,   /* Radio Path A */
-	ODM_RF_PATH_B = 1,   /* Radio Path B */
-	ODM_RF_PATH_C = 2,   /* Radio Path C */
-	ODM_RF_PATH_D = 3,   /* Radio Path D */
-	ODM_RF_PATH_AB,
-	ODM_RF_PATH_AC,
-	ODM_RF_PATH_AD,
-	ODM_RF_PATH_BC,
-	ODM_RF_PATH_BD,
-	ODM_RF_PATH_CD,
-	ODM_RF_PATH_ABC,
-	ODM_RF_PATH_ACD,
-	ODM_RF_PATH_BCD,
-	ODM_RF_PATH_ABCD,
-	/*   ODM_RF_PATH_MAX,    Max RF number 90 support */
-};
-
  enum odm_rf_content {
 	odm_radioa_txt = 0x1000,
 	odm_radiob_txt = 0x1001,
diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index a99d567468b2..1e084f01050e 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -203,7 +203,7 @@ void odm_parsing_cfo(void *dm_void, void *pkt_info_void, s8 *cfotail)
 		 * 3 Update CFO report for path-A & path-B
 		 * Only paht-A and path-B have CFO tail and short CFO
 		 */
-		for (i = ODM_RF_PATH_A; i <= ODM_RF_PATH_B; i++)
+		for (i = RF_PATH_A; i <= RF_PATH_B; i++)
 			cfo_track->CFO_tail[i] = (int)cfotail[i];
 
 		/* 3 Update packet counter */
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 16d479dbd069..994b8c578e7a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -113,8 +113,8 @@ static void odm_rx_phy_status_parsing(struct dm_odm_t *dm_odm,
 	struct phy_status_rpt_8192cd_t *phy_sta_rpt = (struct phy_status_rpt_8192cd_t *)phy_status;
 
 	is_cck_rate = pkt_info->data_rate <= DESC_RATE11M;
-	phy_info->rx_mimo_signal_quality[ODM_RF_PATH_A] = -1;
-	phy_info->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
+	phy_info->rx_mimo_signal_quality[RF_PATH_A] = -1;
+	phy_info->rx_mimo_signal_quality[RF_PATH_B] = -1;
 
 
 	if (is_cck_rate) {
@@ -166,8 +166,8 @@ static void odm_rx_phy_status_parsing(struct dm_odm_t *dm_odm,
 			}
 
 			phy_info->signal_quality = sq;
-			phy_info->rx_mimo_signal_quality[ODM_RF_PATH_A] = sq;
-			phy_info->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
+			phy_info->rx_mimo_signal_quality[RF_PATH_A] = sq;
+			phy_info->rx_mimo_signal_quality[RF_PATH_B] = -1;
 		}
 	} else { /* is OFDM rate */
 		dm_odm->PhyDbgInfo.NumQryPhyStatusOFDM++;
@@ -176,7 +176,7 @@ static void odm_rx_phy_status_parsing(struct dm_odm_t *dm_odm,
 		 * (1)Get RSSI for HT rate
 		 */
 
-		for (i = ODM_RF_PATH_A; i < ODM_RF_PATH_MAX; i++) {
+		for (i = RF_PATH_A; i < RF_PATH_MAX; i++) {
 			/*  2008/01/30 MH we will judge RF RX path now. */
 			if (dm_odm->RFPathRxEnable & BIT(i))
 				rf_rx_num++;
@@ -227,7 +227,7 @@ static void odm_rx_phy_status_parsing(struct dm_odm_t *dm_odm,
 		/*  Fill value in RFD, Get the first spatial stream only */
 		phy_info->signal_quality = (u8)(evm & 0xff);
 
-		phy_info->rx_mimo_signal_quality[ODM_RF_PATH_A] = (u8)(evm & 0xff);
+		phy_info->rx_mimo_signal_quality[RF_PATH_A] = (u8)(evm & 0xff);
 
 		odm_parsing_cfo(dm_odm, pkt_info, phy_sta_rpt->path_cfotail);
 	}
@@ -290,23 +290,23 @@ static void odm_Process_RSSIForDM(
 	if (pPktinfo->to_self || pPktinfo->is_beacon) {
 
 		if (!isCCKrate) { /* ofdm rate */
-			if (pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B] == 0) {
-				RSSI_Ave = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
-				pDM_Odm->RSSI_A = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
+			if (pPhyInfo->rx_mimo_signal_strength[RF_PATH_B] == 0) {
+				RSSI_Ave = pPhyInfo->rx_mimo_signal_strength[RF_PATH_A];
+				pDM_Odm->RSSI_A = pPhyInfo->rx_mimo_signal_strength[RF_PATH_A];
 				pDM_Odm->RSSI_B = 0;
 			} else {
-				pDM_Odm->RSSI_A =  pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
-				pDM_Odm->RSSI_B = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B];
+				pDM_Odm->RSSI_A =  pPhyInfo->rx_mimo_signal_strength[RF_PATH_A];
+				pDM_Odm->RSSI_B = pPhyInfo->rx_mimo_signal_strength[RF_PATH_B];
 
 				if (
-					pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A] >
-					pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B]
+					pPhyInfo->rx_mimo_signal_strength[RF_PATH_A] >
+					pPhyInfo->rx_mimo_signal_strength[RF_PATH_B]
 				) {
-					RSSI_max = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
-					RSSI_min = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B];
+					RSSI_max = pPhyInfo->rx_mimo_signal_strength[RF_PATH_A];
+					RSSI_min = pPhyInfo->rx_mimo_signal_strength[RF_PATH_B];
 				} else {
-					RSSI_max = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B];
-					RSSI_min = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
+					RSSI_max = pPhyInfo->rx_mimo_signal_strength[RF_PATH_B];
+					RSSI_min = pPhyInfo->rx_mimo_signal_strength[RF_PATH_A];
 				}
 
 				if ((RSSI_max-RSSI_min) < 3)
@@ -411,7 +411,7 @@ void odm_phy_status_query(struct dm_odm_t *dm_odm, struct odm_phy_info *phy_info
 enum hal_status ODM_ConfigRFWithHeaderFile(
 	struct dm_odm_t *pDM_Odm,
 	enum ODM_RF_Config_Type ConfigType,
-	enum odm_rf_radio_path_e eRFPath
+	enum rf_path eRFPath
 )
 {
 	if (ConfigType == CONFIG_RF_RADIO)
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
index b2eae7d993fa..2e10974ffef1 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
@@ -84,7 +84,7 @@ enum hal_status ODM_ConfigRFWithTxPwrTrackHeaderFile(struct dm_odm_t *pDM_Odm);
 enum hal_status ODM_ConfigRFWithHeaderFile(
 	struct dm_odm_t *pDM_Odm,
 	enum ODM_RF_Config_Type ConfigType,
-	enum odm_rf_radio_path_e eRFPath
+	enum rf_path eRFPath
 );
 
 enum hal_status ODM_ConfigBBWithHeaderFile(
diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
index ad169704f3e9..97acf75fc04e 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
@@ -70,17 +70,17 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 		/* update idle time pwer report per 5us */
 		PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_TxGainStage, BIT25, 0);
 
-		noise_data.value[ODM_RF_PATH_A] = (u8)(tmp4b&0xff);
-		noise_data.value[ODM_RF_PATH_B]  = (u8)((tmp4b&0xff00)>>8);
+		noise_data.value[RF_PATH_A] = (u8)(tmp4b&0xff);
+		noise_data.value[RF_PATH_B]  = (u8)((tmp4b&0xff00)>>8);
 
-		for (rf_path = ODM_RF_PATH_A; rf_path < max_rf_path; rf_path++) {
+		for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
 			noise_data.sval[rf_path] = (s8)noise_data.value[rf_path];
 			noise_data.sval[rf_path] /= 2;
 		}
 		/* mdelay(10); */
 		/* msleep(10); */
 
-		for (rf_path = ODM_RF_PATH_A; rf_path < max_rf_path; rf_path++) {
+		for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
 			if ((noise_data.valid_cnt[rf_path] < ValidCnt) && (noise_data.sval[rf_path] < Valid_Max && noise_data.sval[rf_path] >= Valid_Min)) {
 				noise_data.valid_cnt[rf_path]++;
 				noise_data.sum[rf_path] += noise_data.sval[rf_path];
@@ -94,7 +94,7 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 
 		/* printk("####### valid_done:%d #############\n", valid_done); */
 		if ((valid_done == max_rf_path) || (jiffies_to_msecs(jiffies - start) > max_time)) {
-			for (rf_path = ODM_RF_PATH_A; rf_path < max_rf_path; rf_path++) {
+			for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
 				/* printk("%s PATH_%d - sum = %d, valid_cnt = %d\n", __func__, rf_path, noise_data.sum[rf_path], noise_data.valid_cnt[rf_path]); */
 				if (noise_data.valid_cnt[rf_path])
 					noise_data.sum[rf_path] /= noise_data.valid_cnt[rf_path];
@@ -106,14 +106,14 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 	}
 	reg_c50 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XAAGCCore1, bMaskByte0);
 	reg_c50 &= ~BIT7;
-	pDM_Odm->noise_level.noise[ODM_RF_PATH_A] = -110 + reg_c50 + noise_data.sum[ODM_RF_PATH_A];
-	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[ODM_RF_PATH_A];
+	pDM_Odm->noise_level.noise[RF_PATH_A] = -110 + reg_c50 + noise_data.sum[RF_PATH_A];
+	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_A];
 
 	if (max_rf_path == 2) {
 		reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
 		reg_c58 &= ~BIT7;
-		pDM_Odm->noise_level.noise[ODM_RF_PATH_B] = -110 + reg_c58 + noise_data.sum[ODM_RF_PATH_B];
-		pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[ODM_RF_PATH_B];
+		pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
+		pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
 	}
 	pDM_Odm->noise_level.noise_all /= max_rf_path;
 
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
index a29bd9375023..0f71b1adea40 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
@@ -11,7 +11,7 @@ void odm_ConfigRFReg_8723B(
 	struct dm_odm_t *pDM_Odm,
 	u32 Addr,
 	u32 Data,
-	enum odm_rf_radio_path_e RF_PATH,
+	enum rf_path RF_PATH,
 	u32 RegAddr
 )
 {
@@ -93,7 +93,7 @@ void odm_ConfigRF_RadioA_8723B(struct dm_odm_t *pDM_Odm, u32 Addr, u32 Data)
 		pDM_Odm,
 		Addr,
 		Data,
-		ODM_RF_PATH_A,
+		RF_PATH_A,
 		Addr|maskforPhySet
 	);
 }
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
index bdd6fde49fc6..b8d4c2aa6d4d 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
@@ -10,7 +10,7 @@
 void odm_ConfigRFReg_8723B(struct dm_odm_t *pDM_Odm,
 			   u32 Addr,
 			   u32 Data,
-			   enum odm_rf_radio_path_e RF_PATH,
+			   enum rf_path RF_PATH,
 			   u32 RegAddr
 );
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 713ee0179dda..ce4f81828a65 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2280,21 +2280,21 @@ void Hal_EfuseParseBTCoexistInfo_8723B(
 		tempval = hwinfo[EEPROM_RF_BT_SETTING_8723B];
 		if (tempval != 0xFF) {
 			pHalData->EEPROMBluetoothAntNum = tempval & BIT(0);
-			/*  EFUSE_0xC3[6] == 0, S1(Main)-ODM_RF_PATH_A; */
-			/*  EFUSE_0xC3[6] == 1, S0(Aux)-ODM_RF_PATH_B */
-			pHalData->ant_path = (tempval & BIT(6))?ODM_RF_PATH_B:ODM_RF_PATH_A;
+			/*  EFUSE_0xC3[6] == 0, S1(Main)-RF_PATH_A; */
+			/*  EFUSE_0xC3[6] == 1, S0(Aux)-RF_PATH_B */
+			pHalData->ant_path = (tempval & BIT(6))? RF_PATH_B : RF_PATH_A;
 		} else {
 			pHalData->EEPROMBluetoothAntNum = Ant_x1;
 			if (pHalData->PackageType == PACKAGE_QFN68)
-				pHalData->ant_path = ODM_RF_PATH_B;
+				pHalData->ant_path = RF_PATH_B;
 			else
-				pHalData->ant_path = ODM_RF_PATH_A;
+				pHalData->ant_path = RF_PATH_A;
 		}
 	} else {
 		pHalData->EEPROMBluetoothCoexist = false;
 		pHalData->EEPROMBluetoothType = BT_RTL8723B;
 		pHalData->EEPROMBluetoothAntNum = Ant_x1;
-		pHalData->ant_path = ODM_RF_PATH_A;
+		pHalData->ant_path = RF_PATH_A;
 	}
 
 	if (padapter->registrypriv.ant_num > 0) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index ca6b548171b4..4b362320ce31 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -308,28 +308,28 @@ static void phy_InitBBRFRegisterDefinition(struct adapter *Adapter)
 	struct hal_com_data		*pHalData = GET_HAL_DATA(Adapter);
 
 	/*  RF Interface Sowrtware Control */
-	pHalData->PHYRegDef[ODM_RF_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 LSBs if read 32-bit from 0x870 */
-	pHalData->PHYRegDef[ODM_RF_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 MSBs if read 32-bit from 0x870 (16-bit for 0x872) */
+	pHalData->PHYRegDef[RF_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 LSBs if read 32-bit from 0x870 */
+	pHalData->PHYRegDef[RF_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 MSBs if read 32-bit from 0x870 (16-bit for 0x872) */
 
 	/*  RF Interface Output (and Enable) */
-	pHalData->PHYRegDef[ODM_RF_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x860 */
-	pHalData->PHYRegDef[ODM_RF_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x864 */
+	pHalData->PHYRegDef[RF_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x860 */
+	pHalData->PHYRegDef[RF_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x864 */
 
 	/*  RF Interface (Output and)  Enable */
-	pHalData->PHYRegDef[ODM_RF_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
-	pHalData->PHYRegDef[ODM_RF_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x864 (16-bit for 0x866) */
+	pHalData->PHYRegDef[RF_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
+	pHalData->PHYRegDef[RF_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x864 (16-bit for 0x866) */
 
-	pHalData->PHYRegDef[ODM_RF_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */
-	pHalData->PHYRegDef[ODM_RF_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
+	pHalData->PHYRegDef[RF_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */
+	pHalData->PHYRegDef[RF_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
 
-	pHalData->PHYRegDef[ODM_RF_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
-	pHalData->PHYRegDef[ODM_RF_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;  /* wire control parameter2 */
+	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
+	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;  /* wire control parameter2 */
 
 	/*  Tranceiver Readback LSSI/HSPI mode */
-	pHalData->PHYRegDef[ODM_RF_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
-	pHalData->PHYRegDef[ODM_RF_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
-	pHalData->PHYRegDef[ODM_RF_PATH_A].rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
-	pHalData->PHYRegDef[ODM_RF_PATH_B].rfLSSIReadBackPi = TransceiverB_HSPI_Readback;
+	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
+	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
+	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
+	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBackPi = TransceiverB_HSPI_Readback;
 
 }
 
@@ -399,7 +399,7 @@ int PHY_BBConfig8723B(struct adapter *Adapter)
 
 	msleep(1);
 
-	PHY_SetRFReg(Adapter, ODM_RF_PATH_A, 0x1, 0xfffff, 0x780);
+	PHY_SetRFReg(Adapter, RF_PATH_A, 0x1, 0xfffff, 0x780);
 
 	rtw_write8(Adapter, REG_SYS_FUNC_EN, FEN_PPLL|FEN_PCIEA|FEN_DIO_PCIE|FEN_BB_GLB_RSTn|FEN_BBRSTB);
 
@@ -453,7 +453,7 @@ void PHY_SetTxPowerIndex(
 	u8 Rate
 )
 {
-	if (RFPath == ODM_RF_PATH_A || RFPath == ODM_RF_PATH_B) {
+	if (RFPath == RF_PATH_A || RFPath == RF_PATH_B) {
 		switch (Rate) {
 		case MGN_1M:
 			PHY_SetBBReg(Adapter, rTxAGC_A_CCK1_Mcs32, bMaskByte1, PowerIndex);
@@ -538,7 +538,7 @@ u8 PHY_GetTxPowerIndex(
 	s8 txPower = 0, powerDiffByRate = 0, limit = 0;
 
 	txPower = (s8) PHY_GetTxPowerIndexBase(padapter, RFPath, Rate, BandWidth, Channel);
-	powerDiffByRate = PHY_GetTxPowerByRate(padapter, ODM_RF_PATH_A, RF_1TX, Rate);
+	powerDiffByRate = PHY_GetTxPowerByRate(padapter, RF_PATH_A, RF_1TX, Rate);
 
 	limit = phy_get_tx_pwr_lmt(
 		padapter,
@@ -565,10 +565,10 @@ void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 Channel)
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 	struct fat_t *pDM_FatTable = &pDM_Odm->DM_FatTable;
-	u8 RFPath = ODM_RF_PATH_A;
+	u8 RFPath = RF_PATH_A;
 
 	if (pHalData->AntDivCfg) {/*  antenna diversity Enable */
-		RFPath = ((pDM_FatTable->RxIdleAnt == MAIN_ANT) ? ODM_RF_PATH_A : ODM_RF_PATH_B);
+		RFPath = ((pDM_FatTable->RxIdleAnt == MAIN_ANT) ? RF_PATH_A : RF_PATH_B);
 	} else { /*  antenna diversity disable */
 		RFPath = pHalData->ant_path;
 	}
@@ -672,8 +672,8 @@ static void phy_SwChnl8723B(struct adapter *padapter)
 	if (pHalData->rf_chip == RF_PSEUDO_11N)
 		return;
 	pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff00) | channelToSW);
-	PHY_SetRFReg(padapter, ODM_RF_PATH_A, RF_CHNLBW, 0x3FF, pHalData->RfRegChnlVal[0]);
-	PHY_SetRFReg(padapter, ODM_RF_PATH_B, RF_CHNLBW, 0x3FF, pHalData->RfRegChnlVal[0]);
+	PHY_SetRFReg(padapter, RF_PATH_A, RF_CHNLBW, 0x3FF, pHalData->RfRegChnlVal[0]);
+	PHY_SetRFReg(padapter, RF_PATH_B, RF_CHNLBW, 0x3FF, pHalData->RfRegChnlVal[0]);
 }
 
 static void phy_SwChnlAndSetBwMode8723B(struct adapter *Adapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index 38228b46b1ee..51865f81b1fe 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -63,14 +63,14 @@ void PHY_RF6052SetBandwidth8723B(
 	switch (Bandwidth) {
 	case CHANNEL_WIDTH_20:
 		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT10 | BIT11);
-		PHY_SetRFReg(Adapter, ODM_RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
-		PHY_SetRFReg(Adapter, ODM_RF_PATH_B, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		PHY_SetRFReg(Adapter, RF_PATH_B, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
 		break;
 
 	case CHANNEL_WIDTH_40:
 		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT10);
-		PHY_SetRFReg(Adapter, ODM_RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
-		PHY_SetRFReg(Adapter, ODM_RF_PATH_B, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		PHY_SetRFReg(Adapter, RF_PATH_B, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
 		break;
 
 	default:
@@ -97,11 +97,9 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 		/*----Store original RFENV control type----*/
 		switch (eRFPath) {
 		case RF_PATH_A:
-		case RF_PATH_C:
 			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV);
 			break;
 		case RF_PATH_B:
-		case RF_PATH_D:
 			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16);
 			break;
 		}
@@ -128,19 +126,14 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 			ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv,
 						   CONFIG_RF_RADIO, eRFPath);
 			break;
-		case RF_PATH_C:
-		case RF_PATH_D:
-			break;
 		}
 
 		/*----Restore RFENV control type----*/
 		switch (eRFPath) {
 		case RF_PATH_A:
-		case RF_PATH_C:
 			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
 			break;
 		case RF_PATH_B:
-		case RF_PATH_D:
 			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16, u4RegValue);
 			break;
 		}
@@ -163,7 +156,6 @@ int PHY_RF6052_Config8723B(struct adapter *Adapter)
 	/*  */
 	/*  Initialize general global value */
 	/*  */
-	/*  TODO: Extend RF_PATH_C and RF_PATH_D in the future */
 	if (pHalData->rf_type == RF_1T1R)
 		pHalData->NumTotalRFPath = 1;
 	else
diff --git a/drivers/staging/rtl8723bs/include/hal_phy.h b/drivers/staging/rtl8723bs/include/hal_phy.h
index 861aa71cd179..3d71a4f41592 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy.h
@@ -30,8 +30,7 @@ enum {
 enum rf_path {
 	RF_PATH_A = 0,
 	RF_PATH_B,
-	RF_PATH_C,
-	RF_PATH_D
+	RF_PATH_MAX
 };
 
 #define	TX_1S			0
-- 
2.20.1

