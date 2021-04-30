Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2B36F67E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhD3HpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhD3Ho4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:44:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E164C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n25so9409578edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhxcXKMaUKPoT182p0Sd/fFobdbV3m/bizsJuNY5yXU=;
        b=UbnQJqEodgfiPdJWbxi0LA9HCpNC/pQQ1NqJpwnxeyiWZ+sNEmlhEV98s2AgaHBT7K
         5LxGNpx7xu1575Ib0MwXSg5XVYdU5db3R269SfuVmV64gAzWLOgtTVwtMywAJUs1gFVl
         FWI7Zo1WXFm1LEW4q9gyja4+dXVyuhj/ZITqeawfQRhKKhkpp1046XetA1WcxjW6vB8F
         e5MTahNusFa5soVRtBYbLZaHth1RkLISmr2T36MXSOsG9bDrYgI3pDbvwKxOQUxGjDhW
         A4sLxIipjiEV5UMpk7CbJVW/v0UNL8t463KUbNXK3WJDZjHj7Sr4h1UfqcSUaHNtjrXR
         3Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhxcXKMaUKPoT182p0Sd/fFobdbV3m/bizsJuNY5yXU=;
        b=ZzbD7jGGSnnxFfBtXyYYE+e2N3s52upfTrzkbgbj52DTWT/ZJguncUfUIzk2P9FiXj
         5CoIFGGOCSPEwHCOoszEsQwAmK3/9aWxvI4PU3YWZKQH9HfonwFAvcVvnocvmjm5GvZK
         5d/MY5jMgalIDV7nSwGkzVJ/sqIpyLUdm6+hmNSLjJtf6uIYoiQVgvr8VmkWVcQoIhFF
         F4zeKW0lJvZcNJRmVRhXWjLFQwB+gHV42LKpgf5tCtvvXilZl4fGXrXtzHJf+a3cH5zN
         mBAQFzp+BLk5RXCX2CipNgj/iXwyii86DZ1fYg99J2Oa1QfpU10SBgOvvCkmXcDuB8tk
         DBXg==
X-Gm-Message-State: AOAM5317PNsrxPZ8JZs50CQdpDA9gfP5q43/xM5hG8SBzu3f15+lkLHK
        9bp6QlOQddeejCf46PWHW5n/+lKW0vr1Rw==
X-Google-Smtp-Source: ABdhPJwl/39k0VRILAswUWScjCZj+9yQaCLJjM6SWQe4aywbAHaL9RXK0CpVcNSVWcwCFKt3+zgsPg==
X-Received: by 2002:aa7:dd4d:: with SMTP id o13mr4196297edw.53.1619768645668;
        Fri, 30 Apr 2021 00:44:05 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id e16sm636638edu.94.2021.04.30.00.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/43] staging: rtl8723bs: remove ODM_RT_TRACE logs
Date:   Fri, 30 Apr 2021 09:43:19 +0200
Message-Id: <23e21c100ba4f0753c6f03a1bb28d9bd7729b64b.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all ODM_RT_TRACE logs.

ODM_RT_TRACE macro default behaviour
is _trace nothing_. To enable it a hand code
edit is needed in hal/odm_debug.c.
So just remove it.

Applied the semantic patch:

@@
@@

-	ODM_RT_TRACE(...);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |  62 ----
 .../staging/rtl8723bs/hal/HalHWImg8723B_MAC.c |  49 ---
 .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  |  63 ----
 drivers/staging/rtl8723bs/hal/HalPhyRf.c      | 325 +-----------------
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 140 +-------
 drivers/staging/rtl8723bs/hal/odm.c           |  34 --
 .../staging/rtl8723bs/hal/odm_CfoTracking.c   | 107 ------
 drivers/staging/rtl8723bs/hal/odm_DIG.c       | 319 -----------------
 .../rtl8723bs/hal/odm_EdcaTurboCheck.c        |  18 -
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  |  18 -
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  |  27 --
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c   |  14 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.c        |  66 ----
 13 files changed, 7 insertions(+), 1235 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
index 016d257b90a0..77b9c672ff0e 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
@@ -33,47 +33,6 @@ static bool CheckPositive(
 		pDM_Odm->TypeALNA << 16 |
 		pDM_Odm->TypeAPA << 24;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> [8812A] CheckPositive (cond1, cond2) = (0x%X 0x%X)\n",
-			cond1,
-			cond2
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> [8812A] CheckPositive (driver1, driver2) = (0x%X 0x%X)\n",
-			driver1,
-			driver2
-		)
-	);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		("	(Platform, Interface) = (0x%X, 0x%X)\n",
-			pDM_Odm->SupportPlatform,
-			pDM_Odm->SupportInterface
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"	(Board, Package) = (0x%X, 0x%X)\n",
-			pDM_Odm->BoardType,
-			pDM_Odm->PackageType
-		)
-	);
-
 
 	/*  Value Defined Check =============== */
 	/* QFN Type [15:12] and Cut Version [27:24] need to do value check */
@@ -263,13 +222,6 @@ void ODM_ReadAndConfig_MP_8723B_AGC_TAB(struct dm_odm_t *pDM_Odm)
 	u32 ArrayLen = ARRAY_SIZE(Array_MP_8723B_AGC_TAB);
 	u32 *Array = Array_MP_8723B_AGC_TAB;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		("===> ODM_ReadAndConfig_MP_8723B_AGC_TAB\n")
-	);
-
 	for (i = 0; i < ArrayLen; i += 2) {
 		u32 v1 = Array[i];
 		u32 v2 = Array[i+1];
@@ -532,13 +484,6 @@ void ODM_ReadAndConfig_MP_8723B_PHY_REG(struct dm_odm_t *pDM_Odm)
 	u32 ArrayLen = ARRAY_SIZE(Array_MP_8723B_PHY_REG);
 	u32 *Array = Array_MP_8723B_PHY_REG;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		("===> ODM_ReadAndConfig_MP_8723B_PHY_REG\n")
-	);
-
 	for (i = 0; i < ArrayLen; i += 2) {
 		u32 v1 = Array[i];
 		u32 v2 = Array[i+1];
@@ -611,13 +556,6 @@ void ODM_ReadAndConfig_MP_8723B_PHY_REG_PG(struct dm_odm_t *pDM_Odm)
 	u32 i = 0;
 	u32 *Array = Array_MP_8723B_PHY_REG_PG;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		("===> ODM_ReadAndConfig_MP_8723B_PHY_REG_PG\n")
-	);
-
 	pDM_Odm->PhyRegPgVersion = 1;
 	pDM_Odm->PhyRegPgValueType = PHY_REG_PG_EXACT_VALUE;
 
diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c
index 677bcfa10b0d..47e66f4ad9d1 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c
@@ -33,48 +33,6 @@ static bool CheckPositive(
 		pDM_Odm->TypeALNA << 16 |
 		pDM_Odm->TypeAPA  << 24;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> [8812A] CheckPositive (cond1, cond2) = (0x%X 0x%X)\n",
-			cond1,
-			cond2
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> [8812A] CheckPositive (driver1, driver2) = (0x%X 0x%X)\n",
-			driver1,
-			driver2
-		)
-	);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"	(Platform, Interface) = (0x%X, 0x%X)\n",
-			pDM_Odm->SupportPlatform,
-			pDM_Odm->SupportInterface
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"	(Board, Package) = (0x%X, 0x%X)\n",
-			pDM_Odm->BoardType,
-			pDM_Odm->PackageType
-		)
-	);
-
 
 	/*  Value Defined Check =============== */
 	/* QFN Type [15:12] and Cut Version [27:24] need to do value check */
@@ -234,13 +192,6 @@ void ODM_ReadAndConfig_MP_8723B_MAC_REG(struct dm_odm_t *pDM_Odm)
 	u32 ArrayLen = ARRAY_SIZE(Array_MP_8723B_MAC_REG);
 	u32 *Array = Array_MP_8723B_MAC_REG;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		("===> ODM_ReadAndConfig_MP_8723B_MAC_REG\n")
-	);
-
 	for (i = 0; i < ArrayLen; i += 2) {
 		u32 v1 = Array[i];
 		u32 v2 = Array[i+1];
diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
index 2c450c1ce7e7..e7a6566f2a24 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
@@ -33,48 +33,6 @@ static bool CheckPositive(
 		pDM_Odm->TypeALNA << 16 |
 		pDM_Odm->TypeAPA  << 24;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> [8812A] CheckPositive (cond1, cond2) = (0x%X 0x%X)\n",
-			cond1,
-			cond2
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> [8812A] CheckPositive (driver1, driver2) = (0x%X 0x%X)\n",
-			driver1,
-			driver2
-		)
-	);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"	(Platform, Interface) = (0x%X, 0x%X)\n",
-			pDM_Odm->SupportPlatform,
-			pDM_Odm->SupportInterface
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"	(Board, Package) = (0x%X, 0x%X)\n",
-			pDM_Odm->BoardType,
-			pDM_Odm->PackageType
-		)
-	);
-
 	/*  Value Defined Check =============== */
 	/* QFN Type [15:12] and Cut Version [27:24] need to do value check */
 
@@ -265,13 +223,6 @@ void ODM_ReadAndConfig_MP_8723B_RadioA(struct dm_odm_t *pDM_Odm)
 	u32 ArrayLen = ARRAY_SIZE(Array_MP_8723B_RadioA);
 	u32 *Array = Array_MP_8723B_RadioA;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		("===> ODM_ReadAndConfig_MP_8723B_RadioA\n")
-	);
-
 	for (i = 0; i < ArrayLen; i += 2) {
 		u32 v1 = Array[i];
 		u32 v2 = Array[i+1];
@@ -424,13 +375,6 @@ void ODM_ReadAndConfig_MP_8723B_TxPowerTrack_SDIO(struct dm_odm_t *pDM_Odm)
 {
 	struct odm_rf_cal_t *pRFCalibrateInfo = &pDM_Odm->RFCalibrateInfo;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		("===> ODM_ReadAndConfig_MP_MP_8723B\n")
-	);
-
 
 	memcpy(
 		pRFCalibrateInfo->DeltaSwingTableIdx_2GA_P,
@@ -760,13 +704,6 @@ void ODM_ReadAndConfig_MP_8723B_TXPWR_LMT(struct dm_odm_t *pDM_Odm)
 	u32 i = 0;
 	u8 **Array = Array_MP_8723B_TXPWR_LMT;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		("===> ODM_ReadAndConfig_MP_8723B_TXPWR_LMT\n")
-	);
-
 	for (i = 0; i < ARRAY_SIZE(Array_MP_8723B_TXPWR_LMT); i += 7) {
 		u8 *regulation = Array[i];
 		u8 *band = Array[i+1];
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.c b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
index 14426151faae..2e10817bf3dd 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
@@ -108,18 +108,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 	pDM_Odm->RFCalibrateInfo.TXPowerTrackingCallbackCnt++;
 	pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = true;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_TX_PWR_TRACK,
-		ODM_DBG_LOUD,
-		(
-			"===>ODM_TXPowerTrackingCallback_ThermalMeter,\npDM_Odm->BbSwingIdxCckBase: %d, pDM_Odm->BbSwingIdxOfdmBase[A]: %d, pDM_Odm->DefaultOfdmIndex: %d\n",
-			pDM_Odm->BbSwingIdxCckBase,
-			pDM_Odm->BbSwingIdxOfdmBase[ODM_RF_PATH_A],
-			pDM_Odm->DefaultOfdmIndex
-		)
-	);
-
 	ThermalValue = (u8)PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, c.ThermalRegAddr, 0xfc00);	/* 0x42: RF Reg[15:10] 88E */
 	if (
 		!pDM_Odm->RFCalibrateInfo.TxPowerTrackControl ||
@@ -131,11 +119,7 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 	/* 4 3. Initialize ThermalValues of RFCalibrateInfo */
 
 	if (pDM_Odm->RFCalibrateInfo.bReloadtxpowerindex)
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			("reload ofdm index for band switch\n")
-		);
+		{}
 
 	/* 4 4. Calculate average thermal meter */
 
@@ -154,16 +138,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 	/* Calculate Average ThermalValue after average enough times */
 	if (ThermalValue_AVG_count) {
 		ThermalValue = (u8)(ThermalValue_AVG / ThermalValue_AVG_count);
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_TX_PWR_TRACK,
-			ODM_DBG_LOUD,
-			(
-				"AVG Thermal Meter = 0x%X, EFUSE Thermal Base = 0x%X\n",
-				ThermalValue,
-				pHalData->EEPROMThermalMeter
-			)
-		);
 	}
 
 	/* 4 5. Calculate delta, delta_LCK, delta_IQK. */
@@ -181,31 +155,9 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		(ThermalValue - pDM_Odm->RFCalibrateInfo.ThermalValue_IQK) :
 		(pDM_Odm->RFCalibrateInfo.ThermalValue_IQK - ThermalValue);
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_TX_PWR_TRACK,
-		ODM_DBG_LOUD,
-		(
-			"(delta, delta_LCK, delta_IQK) = (%d, %d, %d)\n",
-			delta,
-			delta_LCK,
-			delta_IQK
-		)
-	);
-
 	/* 4 6. If necessary, do LCK. */
 	/*  Delta temperature is equal to or larger than 20 centigrade. */
 	if (delta_LCK >= c.Threshold_IQK) {
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_TX_PWR_TRACK,
-			ODM_DBG_LOUD,
-			(
-				"delta_LCK(%d) >= Threshold_IQK(%d)\n",
-				delta_LCK,
-				c.Threshold_IQK
-			)
-		);
 		pDM_Odm->RFCalibrateInfo.ThermalValue_LCK = ThermalValue;
 		if (c.PHY_LCCalibrate)
 			(*c.PHY_LCCalibrate)(pDM_Odm);
@@ -224,16 +176,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 
 		/* 4 7.1 The Final Power Index = BaseIndex + PowerIndexOffset */
 		if (ThermalValue > pHalData->EEPROMThermalMeter) {
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"deltaSwingTableIdx_TUP_A[%d] = %d\n",
-					delta,
-					deltaSwingTableIdx_TUP_A[delta]
-				)
-			);
 			pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_A] =
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A];
 			pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A] =
@@ -243,27 +185,7 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 			pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] =
 				deltaSwingTableIdx_TUP_A[delta];
 
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
-					pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A]
-				)
-			);
-
 			if (c.RfPathCount > 1) {
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_TX_PWR_TRACK,
-					ODM_DBG_LOUD,
-					(
-						"deltaSwingTableIdx_TUP_B[%d] = %d\n",
-						delta,
-						deltaSwingTableIdx_TUP_B[delta]
-					)
-				);
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_B] =
 					pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B];
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B] =
@@ -272,29 +194,9 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 				/*  Record delta swing for mix mode power tracking */
 				pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] =
 					deltaSwingTableIdx_TUP_B[delta];
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_TX_PWR_TRACK,
-					ODM_DBG_LOUD,
-					(
-						"******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] = %d\n",
-						pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B]
-					)
-				);
 			}
 
 		} else {
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"deltaSwingTableIdx_TDOWN_A[%d] = %d\n",
-					delta,
-					deltaSwingTableIdx_TDOWN_A[delta]
-				)
-			);
-
 			pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_A] =
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A];
 			pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_A] =
@@ -304,28 +206,7 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 			pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] =
 				-1 * deltaSwingTableIdx_TDOWN_A[delta];
 
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
-					pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A]
-				)
-			);
-
 			if (c.RfPathCount > 1) {
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_TX_PWR_TRACK,
-					ODM_DBG_LOUD,
-					(
-						"deltaSwingTableIdx_TDOWN_B[%d] = %d\n",
-						delta,
-						deltaSwingTableIdx_TDOWN_B[delta]
-					)
-				);
-
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[ODM_RF_PATH_B] =
 					pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B];
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[ODM_RF_PATH_B] =
@@ -334,30 +215,10 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 				 /*  Record delta swing for mix mode power tracking */
 				pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] =
 					-1 * deltaSwingTableIdx_TDOWN_B[delta];
-
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_TX_PWR_TRACK,
-					ODM_DBG_LOUD,
-					(
-						"******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] = %d\n",
-						pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B]
-					)
-				);
 			}
 		}
 
 		for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++) {
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"\n\n ================================ [Path-%c] Calculating PowerIndexOffset ================================\n",
-					(p == ODM_RF_PATH_A ? 'A' : 'B')
-				)
-			);
-
 			if (
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[p] ==
 				pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[p]
@@ -366,20 +227,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 			else
 				pDM_Odm->RFCalibrateInfo.PowerIndexOffset[p] = pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[p] - pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[p];      /*  Power Index Diff between 2 times Power Tracking */
 
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"[Path-%c] PowerIndexOffset(%d) = DeltaPowerIndex(%d) - DeltaPowerIndexLast(%d)\n",
-					(
-						p == ODM_RF_PATH_A ? 'A' : 'B'),
-						pDM_Odm->RFCalibrateInfo.PowerIndexOffset[p],
-						pDM_Odm->RFCalibrateInfo.DeltaPowerIndex[p],
-						pDM_Odm->RFCalibrateInfo.DeltaPowerIndexLast[p]
-					)
-				);
-
 			pDM_Odm->RFCalibrateInfo.OFDM_index[p] =
 				pDM_Odm->BbSwingIdxOfdmBase[p] +
 				pDM_Odm->RFCalibrateInfo.PowerIndexOffset[p];
@@ -394,87 +241,23 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 			pDM_Odm->BbSwingIdxOfdm[p] =
 				pDM_Odm->RFCalibrateInfo.OFDM_index[p];
 
-			/*  *************Print BB Swing Base and Index Offset************* */
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"The 'CCK' final index(%d) = BaseIndex(%d) + PowerIndexOffset(%d)\n",
-					pDM_Odm->BbSwingIdxCck,
-					pDM_Odm->BbSwingIdxCckBase,
-					pDM_Odm->RFCalibrateInfo.PowerIndexOffset[p]
-				)
-			);
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"The 'OFDM' final index(%d) = BaseIndex[%c](%d) + PowerIndexOffset(%d)\n",
-					pDM_Odm->BbSwingIdxOfdm[p],
-					(p == ODM_RF_PATH_A ? 'A' : 'B'),
-					pDM_Odm->BbSwingIdxOfdmBase[p],
-					pDM_Odm->RFCalibrateInfo.PowerIndexOffset[p]
-				)
-			);
-
 			/* 4 7.1 Handle boundary conditions of index. */
 			if (pDM_Odm->RFCalibrateInfo.OFDM_index[p] > c.SwingTableSize_OFDM-1)
 				pDM_Odm->RFCalibrateInfo.OFDM_index[p] = c.SwingTableSize_OFDM-1;
 			else if (pDM_Odm->RFCalibrateInfo.OFDM_index[p] < OFDM_min_index)
 				pDM_Odm->RFCalibrateInfo.OFDM_index[p] = OFDM_min_index;
 		}
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_TX_PWR_TRACK,
-			ODM_DBG_LOUD,
-			("\n\n ========================================================================================================\n")
-		);
 		if (pDM_Odm->RFCalibrateInfo.CCK_index > c.SwingTableSize_CCK-1)
 			pDM_Odm->RFCalibrateInfo.CCK_index = c.SwingTableSize_CCK-1;
 		/* else if (pDM_Odm->RFCalibrateInfo.CCK_index < 0) */
 			/* pDM_Odm->RFCalibrateInfo.CCK_index = 0; */
 	} else {
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_TX_PWR_TRACK,
-			ODM_DBG_LOUD,
-			(
-				"The thermal meter is unchanged or TxPowerTracking OFF(%d): ThermalValue: %d , pDM_Odm->RFCalibrateInfo.ThermalValue: %d\n",
-				pDM_Odm->RFCalibrateInfo.TxPowerTrackControl,
-				ThermalValue,
-				pDM_Odm->RFCalibrateInfo.ThermalValue
-			)
-		);
-
 			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
 				pDM_Odm->RFCalibrateInfo.PowerIndexOffset[p] = 0;
 	}
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_TX_PWR_TRACK,
-		ODM_DBG_LOUD,
-		(
-			"TxPowerTracking: [CCK] Swing Current Index: %d, Swing Base Index: %d\n",
-			pDM_Odm->RFCalibrateInfo.CCK_index,
-			pDM_Odm->BbSwingIdxCckBase
-		)
-	);
 
 	/* Print Swing base & current */
 	for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++) {
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_TX_PWR_TRACK,
-			ODM_DBG_LOUD,
-			(
-				"TxPowerTracking: [OFDM] Swing Current Index: %d, Swing Base Index[%c]: %d\n",
-				pDM_Odm->RFCalibrateInfo.OFDM_index[p],
-				(p == ODM_RF_PATH_A ? 'A' : 'B'),
-				pDM_Odm->BbSwingIdxOfdmBase[p]
-			)
-		);
 	}
 
 	if (
@@ -491,105 +274,20 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		/*  */
 		/*  2012/04/25 MH Add for tx power tracking to set tx power in tx agc for 88E. */
 		if (ThermalValue > pDM_Odm->RFCalibrateInfo.ThermalValue) {
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"Temperature Increasing(A): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-					pDM_Odm->RFCalibrateInfo.PowerIndexOffset[ODM_RF_PATH_A],
-					delta,
-					ThermalValue,
-					pHalData->EEPROMThermalMeter,
-					pDM_Odm->RFCalibrateInfo.ThermalValue
-				)
-			);
-
 			if (c.RfPathCount > 1)
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_TX_PWR_TRACK,
-					ODM_DBG_LOUD,
-					(
-						"Temperature Increasing(B): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-						pDM_Odm->RFCalibrateInfo.PowerIndexOffset[ODM_RF_PATH_B],
-						delta,
-						ThermalValue,
-						pHalData->EEPROMThermalMeter,
-						pDM_Odm->RFCalibrateInfo.ThermalValue
-					)
-				);
+				{}
 
 		} else if (ThermalValue < pDM_Odm->RFCalibrateInfo.ThermalValue) { /*  Low temperature */
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"Temperature Decreasing(A): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-					pDM_Odm->RFCalibrateInfo.PowerIndexOffset[ODM_RF_PATH_A],
-					delta,
-					ThermalValue,
-					pHalData->EEPROMThermalMeter,
-					pDM_Odm->RFCalibrateInfo.ThermalValue
-				)
-			);
 
 			if (c.RfPathCount > 1)
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_TX_PWR_TRACK,
-					ODM_DBG_LOUD,
-					(
-						"Temperature Decreasing(B): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-						pDM_Odm->RFCalibrateInfo.PowerIndexOffset[ODM_RF_PATH_B],
-						delta,
-						ThermalValue,
-						pHalData->EEPROMThermalMeter,
-						pDM_Odm->RFCalibrateInfo.ThermalValue
-					)
-				);
+				{}
 
 		}
 
 		if (ThermalValue > pHalData->EEPROMThermalMeter) {
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"Temperature(%d) higher than PG value(%d)\n",
-					ThermalValue,
-					pHalData->EEPROMThermalMeter
-				)
-			);
-
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				("**********Enter POWER Tracking MIX_MODE**********\n")
-			);
 			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
 					(*c.ODM_TxPwrTrackSetPwr)(pDM_Odm, MIX_MODE, p, 0);
 		} else {
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				(
-					"Temperature(%d) lower than PG value(%d)\n",
-					ThermalValue,
-					pHalData->EEPROMThermalMeter
-				)
-			);
-
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_TX_PWR_TRACK,
-				ODM_DBG_LOUD,
-				("**********Enter POWER Tracking MIX_MODE**********\n")
-			);
 			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
 				(*c.ODM_TxPwrTrackSetPwr)(pDM_Odm, MIX_MODE, p, Indexforchannel);
 		}
@@ -599,26 +297,9 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
 			pDM_Odm->BbSwingIdxOfdmBase[p] = pDM_Odm->BbSwingIdxOfdm[p];
 
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			(
-				"pDM_Odm->RFCalibrateInfo.ThermalValue = %d ThermalValue = %d\n",
-				pDM_Odm->RFCalibrateInfo.ThermalValue,
-				ThermalValue
-			)
-		);
-
 		/* Record last Power Tracking Thermal Value */
 		pDM_Odm->RFCalibrateInfo.ThermalValue = ThermalValue;
 	}
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_TX_PWR_TRACK,
-		ODM_DBG_LOUD,
-		("<===ODM_TXPowerTrackingCallback_ThermalMeter\n")
-	);
-
 	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
 }
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index c70b9cf2da32..471418f3f724 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -129,9 +129,6 @@ static void setIqkMatrix_8723B(
 			break;
 		}
 	}
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD, ("TxPwrTracking path B: X = 0x%x, Y = 0x%x ele_A = 0x%x ele_C = 0x%x ele_D = 0x%x 0xeb4 = 0x%x 0xebc = 0x%x\n",
-	(u32)IqkResult_X, (u32)IqkResult_Y, (u32)ele_A, (u32)ele_C, (u32)ele_D, (u32)IqkResult_X, (u32)IqkResult_Y));
 }
 
 
@@ -210,8 +207,6 @@ void ODM_TxPwrTrackSetPwr_8723B(
 
 	}
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD, ("===>ODM_TxPwrTrackSetPwr8723B\n"));
-
 	if (TxRate != 0xFF) {
 		/* 2 CCK */
 		if ((TxRate >= MGN_1M) && (TxRate <= MGN_11M))
@@ -233,13 +228,10 @@ void ODM_TxPwrTrackSetPwr_8723B(
 		else
 			PwrTrackingLimit_OFDM =  pDM_Odm->DefaultOfdmIndex;   /* Default OFDM index = 30 */
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD, ("TxRate = 0x%x, PwrTrackingLimit =%d\n", TxRate, PwrTrackingLimit_OFDM));
 
 	if (Method == TXAGC) {
 		struct adapter *Adapter = pDM_Odm->Adapter;
 
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD, ("odm_TxPwrTrackSetPwr8723B CH =%d\n", *(pDM_Odm->pChannel)));
-
 		pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = pDM_Odm->Absolute_OFDMSwingIdx[RFPath];
 
 		pDM_Odm->Modify_TxAGC_Flag_PathA = true;
@@ -270,10 +262,6 @@ void ODM_TxPwrTrackSetPwr_8723B(
 		setCCKFilterCoefficient(pDM_Odm, Final_CCK_Swing_Index);
 
 	} else if (Method == MIX_MODE) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-			("pDM_Odm->DefaultOfdmIndex =%d,  pDM_Odm->DefaultCCKIndex =%d, pDM_Odm->Absolute_OFDMSwingIdx[RFPath]=%d, RF_Path = %d\n",
-			pDM_Odm->DefaultOfdmIndex, pDM_Odm->DefaultCckIndex, pDM_Odm->Absolute_OFDMSwingIdx[RFPath], RFPath));
-
 		Final_OFDM_Swing_Index = pDM_Odm->DefaultOfdmIndex + pDM_Odm->Absolute_OFDMSwingIdx[RFPath];
 		Final_CCK_Swing_Index = pDM_Odm->DefaultCckIndex + pDM_Odm->Absolute_OFDMSwingIdx[RFPath];
 
@@ -287,10 +275,6 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, HT_MCS0_MCS7);
-
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-				("******Path_A Over BBSwing Limit , PwrTrackingLimit = %d , Remnant TxAGC Value = %d\n",
-				PwrTrackingLimit_OFDM, pDM_Odm->Remnant_OFDMSwingIdx[RFPath]));
 		} else if (Final_OFDM_Swing_Index <= 0) {
 			pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = Final_OFDM_Swing_Index;
 
@@ -301,26 +285,16 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			pDM_Odm->Modify_TxAGC_Flag_PathA = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, HT_MCS0_MCS7);
-
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-				("******Path_A Lower then BBSwing lower bound  0 , Remnant TxAGC Value = %d\n",
-				pDM_Odm->Remnant_OFDMSwingIdx[RFPath]));
 		} else {
 			setIqkMatrix_8723B(pDM_Odm, Final_OFDM_Swing_Index, RFPath,
 				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][0],
 				pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[ChannelMappedIndex].Value[0][1]);
 
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-				("******Path_A Compensate with BBSwing , Final_OFDM_Swing_Index = %d\n", Final_OFDM_Swing_Index));
-
 			if (pDM_Odm->Modify_TxAGC_Flag_PathA) { /* If TxAGC has changed, reset TxAGC again */
 				pDM_Odm->Remnant_OFDMSwingIdx[RFPath] = 0;
 				PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, OFDM);
 				PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, HT_MCS0_MCS7);
 				pDM_Odm->Modify_TxAGC_Flag_PathA = false;
-
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-					("******Path_A pDM_Odm->Modify_TxAGC_Flag = false\n"));
 			}
 		}
 
@@ -329,30 +303,18 @@ void ODM_TxPwrTrackSetPwr_8723B(
 			setCCKFilterCoefficient(pDM_Odm, PwrTrackingLimit_CCK);
 			pDM_Odm->Modify_TxAGC_Flag_PathA_CCK = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, CCK);
-
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-				("******Path_A CCK Over Limit , PwrTrackingLimit_CCK = %d , pDM_Odm->Remnant_CCKSwingIdx  = %d\n", PwrTrackingLimit_CCK, pDM_Odm->Remnant_CCKSwingIdx));
 		} else if (Final_CCK_Swing_Index <= 0) { /*  Lowest CCK Index = 0 */
 			pDM_Odm->Remnant_CCKSwingIdx = Final_CCK_Swing_Index;
 			setCCKFilterCoefficient(pDM_Odm, 0);
 			pDM_Odm->Modify_TxAGC_Flag_PathA_CCK = true;
 			PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, CCK);
-
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-				("******Path_A CCK Under Limit , PwrTrackingLimit_CCK = %d , pDM_Odm->Remnant_CCKSwingIdx  = %d\n", 0, pDM_Odm->Remnant_CCKSwingIdx));
 		} else {
 			setCCKFilterCoefficient(pDM_Odm, Final_CCK_Swing_Index);
 
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-				("******Path_A CCK Compensate with BBSwing , Final_CCK_Swing_Index = %d\n", Final_CCK_Swing_Index));
-
 			if (pDM_Odm->Modify_TxAGC_Flag_PathA_CCK) { /* If TxAGC has changed, reset TxAGC again */
 				pDM_Odm->Remnant_CCKSwingIdx = 0;
 				PHY_SetTxPowerIndexByRateSection(Adapter, RFPath, pHalData->CurrentChannel, CCK);
 				pDM_Odm->Modify_TxAGC_Flag_PathA_CCK = false;
-
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
-					("******Path_A pDM_Odm->Modify_TxAGC_Flag_CCK = false\n"));
 			}
 		}
 	} else
@@ -442,8 +404,6 @@ static u8 phy_PathA_IQK_8723B(
 	/*  Save RF Path */
 	Path_SEL_BB = PHY_QueryBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord);
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A IQK!\n"));
-
 	/* leave IQK mode */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 
@@ -513,11 +473,6 @@ static u8 phy_PathA_IQK_8723B(
 	regEAC = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord);
 	regE94 = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord);
 	regE9C = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xeac = 0x%x\n", regEAC));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe94 = 0x%x, 0xe9c = 0x%x\n", regE94, regE9C));
-	/* monitor image power before & after IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe90(before IQK) = 0x%x, 0xe98(afer IQK) = 0x%x\n",
-	PHY_QueryBBReg(pDM_Odm->Adapter, 0xe90, bMaskDWord), PHY_QueryBBReg(pDM_Odm->Adapter, 0xe98, bMaskDWord)));
 
 
 	/* Allen 20131125 */
@@ -557,8 +512,6 @@ static u8 phy_PathA_RxIQK8723B(
 
 	/* leave IQK mode */
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A RX IQK:Get TXIMR setting\n"));
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
 /* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table!\n")); */
@@ -626,11 +579,6 @@ static u8 phy_PathA_RxIQK8723B(
 	regEAC = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord);
 	regE94 = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord);
 	regE9C = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xeac = 0x%x\n", regEAC));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe94 = 0x%x, 0xe9c = 0x%x\n", regE94, regE9C));
-	/* monitor image power before & after IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe90(before IQK) = 0x%x, 0xe98(afer IQK) = 0x%x\n",
-	PHY_QueryBBReg(pDM_Odm->Adapter, 0xe90, bMaskDWord), PHY_QueryBBReg(pDM_Odm->Adapter, 0xe98, bMaskDWord)));
 
 	/* Allen 20131125 */
 	tmp = (regE9C & 0x03FF0000)>>16;
@@ -651,11 +599,6 @@ static u8 phy_PathA_RxIQK8723B(
 
 	u4tmp = 0x80007C00 | (regE94&0x3FF0000) | ((regE9C&0x3FF0000) >> 16);
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK, bMaskDWord, u4tmp);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe40 = 0x%x u4tmp = 0x%x\n", PHY_QueryBBReg(pDM_Odm->Adapter, rTx_IQK, bMaskDWord), u4tmp));
-
-
-	/* 1 RX IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A RX IQK\n"));
 
 	/* modify RXIQK mode table */
 /* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table 2!\n")); */
@@ -726,11 +669,6 @@ static u8 phy_PathA_RxIQK8723B(
 	/*  Check failed */
 	regEAC = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord);
 	regEA4 = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xeac = 0x%x\n", regEAC));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xea4 = 0x%x, 0xeac = 0x%x\n", regEA4, regEAC));
-	/* monitor image power before & after IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xea0(before IQK) = 0x%x, 0xea8(afer IQK) = 0x%x\n",
-	PHY_QueryBBReg(pDM_Odm->Adapter, 0xea0, bMaskDWord), PHY_QueryBBReg(pDM_Odm->Adapter, 0xea8, bMaskDWord)));
 
 	/* 	PA/PAD controlled by 0x0 */
 	/* leave IQK mode */
@@ -752,7 +690,7 @@ static u8 phy_PathA_RxIQK8723B(
 	)
 		result |= 0x02;
 	else							/* if Tx not OK, ignore Rx */
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path A Rx IQK fail!!\n"));
+		{}
 	return result;
 }
 
@@ -764,8 +702,6 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path B IQK!\n"));
-
 	/*  Save RF Path */
 	Path_SEL_BB = PHY_QueryBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord);
 
@@ -839,11 +775,6 @@ static u8 phy_PathB_IQK_8723B(struct adapter *padapter)
 	regEAC = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord);
 	regE94 = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord);
 	regE9C = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xeac = 0x%x\n", regEAC));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe94 = 0x%x, 0xe9c = 0x%x\n", regE94, regE9C));
-	/* monitor image power before & after IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe90(before IQK) = 0x%x, 0xe98(afer IQK) = 0x%x\n",
-	PHY_QueryBBReg(pDM_Odm->Adapter, 0xe90, bMaskDWord), PHY_QueryBBReg(pDM_Odm->Adapter, 0xe98, bMaskDWord)));
 
 	/* Allen 20131125 */
 	tmp = (regE9C & 0x03FF0000)>>16;
@@ -880,9 +811,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 
 	/* switch to path B */
 	PHY_SetBBReg(pDM_Odm->Adapter, 0x948, bMaskDWord, 0x00000280);
-
-	/* 1 Get TXIMR setting */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B RX IQK:Get TXIMR setting!\n"));
 	/* modify RXIQK mode table */
 /* 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table!\n")); */
 	PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_WE_LUT, 0x80000, 0x1);
@@ -948,11 +876,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	regEAC = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord);
 	regE94 = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord);
 	regE9C = PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xeac = 0x%x\n", regEAC));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe94 = 0x%x, 0xe9c = 0x%x\n", regE94, regE9C));
-	/* monitor image power before & after IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe90(before IQK) = 0x%x, 0xe98(afer IQK) = 0x%x\n",
-		PHY_QueryBBReg(pDM_Odm->Adapter, 0xe90, bMaskDWord), PHY_QueryBBReg(pDM_Odm->Adapter, 0xe98, bMaskDWord)));
 
 	/* Allen 20131125 */
 	tmp = (regE9C & 0x03FF0000)>>16;
@@ -975,10 +898,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 
 	u4tmp = 0x80007C00 | (regE94&0x3FF0000)  | ((regE9C&0x3FF0000) >> 16);
 	PHY_SetBBReg(pDM_Odm->Adapter, rTx_IQK, bMaskDWord, u4tmp);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe40 = 0x%x u4tmp = 0x%x\n", PHY_QueryBBReg(pDM_Odm->Adapter, rTx_IQK, bMaskDWord), u4tmp));
-
-	/* 1 RX IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B RX IQK\n"));
 
 	/* modify RXIQK mode table */
 	/* 20121009, Kordan> RF Mode = 3 */
@@ -1048,12 +967,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	regEAC = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord);
 	regEA4 = PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord);
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xeac = 0x%x\n", regEAC));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xea4 = 0x%x, 0xeac = 0x%x\n", regEA4, regEAC));
-	/* monitor image power before & after IQK */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xea0(before IQK) = 0x%x, 0xea8(afer IQK) = 0x%x\n",
-		PHY_QueryBBReg(pDM_Odm->Adapter, 0xea0, bMaskDWord), PHY_QueryBBReg(pDM_Odm->Adapter, 0xea8, bMaskDWord)));
-
 	/* 	PA/PAD controlled by 0x0 */
 	/* leave IQK mode */
 /* 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, 0xffffff00, 0x00000000); */
@@ -1076,7 +989,7 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 	)
 		result |= 0x02;
 	else
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path B Rx IQK fail!!\n"));
+		{}
 
 	return result;
 }
@@ -1096,8 +1009,6 @@ static void _PHY_PathAFillIQKMatrix8723B(
 
 	struct odm_rf_cal_t *pRFCalibrateInfo = &pDM_Odm->RFCalibrateInfo;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path A IQ Calibration %s !\n", (bIQKOK)?"Success":"Failed"));
-
 	if (final_candidate == 0xFF)
 		return;
 
@@ -1108,7 +1019,6 @@ static void _PHY_PathAFillIQKMatrix8723B(
 		if ((X & 0x00000200) != 0)
 			X = X | 0xFFFFFC00;
 		TX0_A = (X * Oldval_0) >> 8;
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("X = 0x%x, TX0_A = 0x%x, Oldval_0 0x%x\n", X, TX0_A, Oldval_0));
 		PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XATxIQImbalance, 0x3FF, TX0_A);
 
 		PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, BIT(31), ((X*Oldval_0>>7) & 0x1));
@@ -1119,7 +1029,6 @@ static void _PHY_PathAFillIQKMatrix8723B(
 
 		/* 2 Tx IQC */
 		TX0_C = (Y * Oldval_0) >> 8;
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Y = 0x%x, TX = 0x%x\n", Y, TX0_C));
 		PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XCTxAFE, 0xF0000000, ((TX0_C&0x3C0)>>6));
 		pRFCalibrateInfo->TxIQC_8723B[PATH_S1][IDX_0xC94][KEY] = rOFDM0_XCTxAFE;
 		pRFCalibrateInfo->TxIQC_8723B[PATH_S1][IDX_0xC94][VAL] = PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XCTxAFE, bMaskDWord);
@@ -1133,8 +1042,6 @@ static void _PHY_PathAFillIQKMatrix8723B(
 		pRFCalibrateInfo->TxIQC_8723B[PATH_S1][IDX_0xC4C][VAL] = PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, bMaskDWord);
 
 		if (bTxOnly) {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("_PHY_PathAFillIQKMatrix8723B only Tx OK\n"));
-
 			/*  <20130226, Kordan> Saving RxIQC, otherwise not initialized. */
 			pRFCalibrateInfo->RxIQC_8723B[PATH_S1][IDX_0xCA0][KEY] = rOFDM0_RxIQExtAnta;
 			pRFCalibrateInfo->RxIQC_8723B[PATH_S1][IDX_0xCA0][VAL] = 0xfffffff & PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_RxIQExtAnta, bMaskDWord);
@@ -1176,8 +1083,6 @@ static void _PHY_PathBFillIQKMatrix8723B(
 
 	struct odm_rf_cal_t *pRFCalibrateInfo = &pDM_Odm->RFCalibrateInfo;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B IQ Calibration %s !\n", (bIQKOK)?"Success":"Failed"));
-
 	if (final_candidate == 0xFF)
 		return;
 
@@ -1188,7 +1093,6 @@ static void _PHY_PathBFillIQKMatrix8723B(
 		if ((X & 0x00000200) != 0)
 			X = X | 0xFFFFFC00;
 		TX1_A = (X * Oldval_1) >> 8;
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("X = 0x%x, TX1_A = 0x%x\n", X, TX1_A));
 
 		PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XBTxIQImbalance, 0x3FF, TX1_A);
 
@@ -1199,7 +1103,6 @@ static void _PHY_PathBFillIQKMatrix8723B(
 			Y = Y | 0xFFFFFC00;
 
 		TX1_C = (Y * Oldval_1) >> 8;
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Y = 0x%x, TX1_C = 0x%x\n", Y, TX1_C));
 
 		/* 2 Tx IQC */
 		PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XDTxAFE, 0xF0000000, ((TX1_C&0x3C0)>>6));
@@ -1217,8 +1120,6 @@ static void _PHY_PathBFillIQKMatrix8723B(
 		pRFCalibrateInfo->TxIQC_8723B[PATH_S0][IDX_0xC4C][VAL] = PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, bMaskDWord);
 
 		if (bTxOnly) {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("_PHY_PathBFillIQKMatrix8723B only Tx OK\n"));
-
 			pRFCalibrateInfo->RxIQC_8723B[PATH_S0][IDX_0xC14][KEY] = rOFDM0_XARxIQImbalance;
 /* 			pRFCalibrateInfo->RxIQC_8723B[PATH_S0][IDX_0xC14][VAL] = PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XARxIQImbalance, bMaskDWord); */
 			pRFCalibrateInfo->RxIQC_8723B[PATH_S0][IDX_0xC14][VAL] = 0x40000100;
@@ -1297,7 +1198,6 @@ static void _PHY_SaveADDARegisters8723B(
 	if (!ODM_CheckPowerStatus(padapter))
 		return;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Save ADDA parameters.\n"));
 	for (i = 0 ; i < RegisterNum ; i++) {
 		ADDABackup[i] = PHY_QueryBBReg(pDM_Odm->Adapter, ADDAReg[i], bMaskDWord);
 	}
@@ -1312,7 +1212,6 @@ static void _PHY_SaveMACRegisters8723B(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Save MAC parameters.\n"));
 	for (i = 0 ; i < (IQK_MAC_REG_NUM - 1); i++) {
 		MACBackup[i] = rtw_read8(pDM_Odm->Adapter, MACReg[i]);
 	}
@@ -1332,7 +1231,6 @@ static void _PHY_ReloadADDARegisters8723B(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Reload ADDA power saving parameters !\n"));
 	for (i = 0 ; i < RegiesterNum; i++) {
 		PHY_SetBBReg(pDM_Odm->Adapter, ADDAReg[i], bMaskDWord, ADDABackup[i]);
 	}
@@ -1362,8 +1260,6 @@ static void _PHY_PathADDAOn8723B(
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("ADDA ON.\n"));
-
 	pathOn = 0x01c00014;
 	if (!is2T) {
 		pathOn = 0x01c00014;
@@ -1386,8 +1282,6 @@ static void _PHY_MACSettingCalibration8723B(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("MAC settings for Calibration.\n"));
-
 	rtw_write8(pDM_Odm->Adapter, MACReg[i], 0x3F);
 
 	for (i = 1 ; i < (IQK_MAC_REG_NUM - 1); i++) {
@@ -1540,17 +1434,12 @@ static void phy_IQCalibrate_8723B(
 	/* u32 bbvalue; */
 
 	if (t == 0) {
-/* 		 bbvalue = PHY_QueryBBReg(pDM_Odm->Adapter, rFPGA0_RFMOD, bMaskDWord); */
-/* 			RT_DISP(FINIT, INIT_IQK, ("phy_IQCalibrate_8188E() ==>0x%08x\n", bbvalue)); */
-
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQ Calibration for %s for %d times\n", (is2T ? "2T2R" : "1T1R"), t));
 
 		/*  Save ADDA parameters, turn Path A ADDA on */
 		_PHY_SaveADDARegisters8723B(padapter, ADDA_REG, pDM_Odm->RFCalibrateInfo.ADDA_backup, IQK_ADDA_REG_NUM);
 		_PHY_SaveMACRegisters8723B(padapter, IQK_MAC_REG, pDM_Odm->RFCalibrateInfo.IQK_MAC_backup);
 		_PHY_SaveADDARegisters8723B(padapter, IQK_BB_REG_92C, pDM_Odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQ Calibration for %s for %d times\n", (is2T ? "2T2R" : "1T1R"), t));
 
 	_PHY_PathADDAOn8723B(padapter, ADDA_REG, is2T);
 
@@ -1596,7 +1485,6 @@ static void phy_IQCalibrate_8723B(
 			PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 			pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_A] = PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, 0x8, bRFRegOffsetMask);
 
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Tx IQK Success!!\n"));
 				result[t][0] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
 				result[t][1] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
 			break;
@@ -1607,19 +1495,16 @@ static void phy_IQCalibrate_8723B(
 	for (i = 0 ; i < retryCount ; i++) {
 		PathAOK = phy_PathA_RxIQK8723B(padapter, is2T, RF_Path);
 		if (PathAOK == 0x03) {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path A Rx IQK Success!!\n"));
 /* 				result[t][0] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16; */
 /* 				result[t][1] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16; */
 				result[t][2] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				result[t][3] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 			break;
 		} else {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Rx IQK Fail!!\n"));
 		}
 	}
 
 	if (0x00 == PathAOK) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A IQK failed!!\n"));
 	}
 
 /* path B IQK */
@@ -1633,7 +1518,6 @@ static void phy_IQCalibrate_8723B(
 				PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0x000000);
 				pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_B] = PHY_QueryRFReg(pDM_Odm->Adapter, ODM_RF_PATH_B, 0x8, bRFRegOffsetMask);
 
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B Tx IQK Success!!\n"));
 				result[t][4] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
 				result[t][5] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
 				break;
@@ -1644,25 +1528,21 @@ static void phy_IQCalibrate_8723B(
 		for (i = 0 ; i < retryCount ; i++) {
 			PathBOK = phy_PathB_RxIQK8723B(padapter, is2T);
 			if (PathBOK == 0x03) {
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path B Rx IQK Success!!\n"));
 /* 				result[t][0] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16; */
 /* 				result[t][1] = (PHY_QueryBBReg(pDM_Odm->Adapter, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16; */
 				result[t][6] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				result[t][7] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				break;
 			} else {
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B Rx IQK Fail!!\n"));
 			}
 		}
 
 /* Allen end */
 		if (0x00 == PathBOK) {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B IQK failed!!\n"));
 		}
 	}
 
 	/* Back to BB mode, load original value */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK:Back to BB mode, load original value!\n"));
 	PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_IQK, bMaskH3Bytes, 0);
 
 	if (t != 0) {
@@ -1692,7 +1572,6 @@ static void phy_IQCalibrate_8723B(
 		PHY_SetBBReg(pDM_Odm->Adapter, rRx_IQK_Tone_A, bMaskDWord, 0x01008c00);
 
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("phy_IQCalibrate_8723B() <==\n"));
 
 }
 
@@ -1868,12 +1747,10 @@ void PHY_IQCalibrate_8723B(
 	}
 
 	if (bReCovery) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD, ("PHY_IQCalibrate_8723B: Return due to bReCovery!\n"));
 		_PHY_ReloadADDARegisters8723B(padapter, IQK_BB_REG_92C, pDM_Odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
 		return;
 	}
 	StartTime = jiffies;
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK:Start!!!\n"));
 
 	/* save default GNT_BT */
 	GNT_BT_default = PHY_QueryBBReg(pDM_Odm->Adapter, 0x764, bMaskDWord);
@@ -1908,7 +1785,6 @@ void PHY_IQCalibrate_8723B(
 			is12simular = phy_SimularityCompare_8723B(padapter, result, 0, 1);
 			if (is12simular) {
 				final_candidate = 0;
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is12simular final_candidate is %x\n", final_candidate));
 				break;
 			}
 		}
@@ -1917,7 +1793,6 @@ void PHY_IQCalibrate_8723B(
 			is13simular = phy_SimularityCompare_8723B(padapter, result, 0, 2);
 			if (is13simular) {
 				final_candidate = 0;
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is13simular final_candidate is %x\n", final_candidate));
 
 				break;
 			}
@@ -1925,7 +1800,6 @@ void PHY_IQCalibrate_8723B(
 			is23simular = phy_SimularityCompare_8723B(padapter, result, 1, 2);
 			if (is23simular) {
 				final_candidate = 1;
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is23simular final_candidate is %x\n", final_candidate));
 			} else {
 				for (i = 0; i < 8; i++)
 					RegTmp += result[3][i];
@@ -1947,7 +1821,6 @@ void PHY_IQCalibrate_8723B(
 		RegEBC = result[i][5];
 		RegEC4 = result[i][6];
 		RegECC = result[i][7];
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: RegE94 =%x RegE9C =%x RegEA4 =%x RegEAC =%x RegEB4 =%x RegEBC =%x RegEC4 =%x RegECC =%x\n ", RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC));
 	}
 
 	if (final_candidate != 0xff) {
@@ -1959,12 +1832,8 @@ void PHY_IQCalibrate_8723B(
 		pDM_Odm->RFCalibrateInfo.RegEBC = RegEBC = result[final_candidate][5];
 		RegEC4 = result[final_candidate][6];
 		RegECC = result[final_candidate][7];
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK: final_candidate is %x\n", final_candidate));
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK: RegE94 =%x RegE9C =%x RegEA4 =%x RegEAC =%x RegEB4 =%x RegEBC =%x RegEC4 =%x RegECC =%x\n ", RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC));
 		bPathAOK = bPathBOK = true;
 	} else {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK: FAIL use default value\n"));
-
 		pDM_Odm->RFCalibrateInfo.RegE94 = pDM_Odm->RFCalibrateInfo.RegEB4 = 0x100;	/* X default value */
 		pDM_Odm->RFCalibrateInfo.RegE9C = pDM_Odm->RFCalibrateInfo.RegEBC = 0x0;		/* Y default value */
 	}
@@ -1985,7 +1854,6 @@ void PHY_IQCalibrate_8723B(
 			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
 		pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("\nIQK OK Indexforchannel %d.\n", 0));
 
 	_PHY_SaveADDARegisters8723B(padapter, IQK_BB_REG_92C, pDM_Odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
 
@@ -2016,9 +1884,7 @@ void PHY_IQCalibrate_8723B(
 
 	pDM_Odm->RFCalibrateInfo.bIQKInProgress = false;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK finished\n"));
 	ProgressingTime = jiffies_to_msecs(jiffies - StartTime);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK ProgressingTime = %d\n", ProgressingTime));
 
 
 }
@@ -2056,7 +1922,5 @@ void PHY_LCCalibrate_8723B(struct dm_odm_t *pDM_Odm)
 
 	pDM_Odm->RFCalibrateInfo.bLCKInProgress = false;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LCK:Finish!!!interface %d\n", pDM_Odm->InterfaceIndex));
 	ProgressingTime = jiffies_to_msecs(jiffies - StartTime);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("LCK ProgressingTime = %d\n", ProgressingTime));
 }
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 092b32c41ff3..a9f8d6a4a62c 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -323,32 +323,10 @@ static void odm_CommonInfoSelfUpdate(struct dm_odm_t *pDM_Odm)
 
 static void odm_CmnInfoInit_Debug(struct dm_odm_t *pDM_Odm)
 {
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoInit_Debug ==>\n"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportPlatform =%d\n", pDM_Odm->SupportPlatform));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportAbility = 0x%x\n", pDM_Odm->SupportAbility));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportInterface =%d\n", pDM_Odm->SupportInterface));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportICType = 0x%x\n", pDM_Odm->SupportICType));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("CutVersion =%d\n", pDM_Odm->CutVersion));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("FabVersion =%d\n", pDM_Odm->FabVersion));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RFType =%d\n", pDM_Odm->RFType));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("BoardType =%d\n", pDM_Odm->BoardType));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtLNA =%d\n", pDM_Odm->ExtLNA));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtPA =%d\n", pDM_Odm->ExtPA));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtTRSW =%d\n", pDM_Odm->ExtTRSW));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("PatchID =%d\n", pDM_Odm->PatchID));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bInHctTest =%d\n", pDM_Odm->bInHctTest));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFITest =%d\n", pDM_Odm->bWIFITest));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bDualMacSmartConcurrent =%d\n", pDM_Odm->bDualMacSmartConcurrent));
-
 }
 
 static void odm_BasicDbgMessage(struct dm_odm_t *pDM_Odm)
 {
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_BasicDbgMsg ==>\n"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bLinked = %d, RSSI_Min = %d,\n",
-		pDM_Odm->bLinked, pDM_Odm->RSSI_Min));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RxRate = 0x%x, RSSI_A = %d, RSSI_B = %d\n",
-		pDM_Odm->RxRate, pDM_Odm->RSSI_A, pDM_Odm->RSSI_B));
 }
 
 /* 3 ============================================================ */
@@ -482,9 +460,6 @@ u32 ODM_Get_Rate_Bitmap(
 		break;
 	}
 
-	/* printk("%s ==> rssi_level:0x%02x, WirelessMode:0x%02x, rate_bitmap:0x%08x\n", __func__, rssi_level, WirelessMode, rate_bitmap); */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, (" ==> rssi_level:0x%02x, WirelessMode:0x%02x, rate_bitmap:0x%08x\n", rssi_level, WirelessMode, rate_bitmap));
-
 	return ra_mask & rate_bitmap;
 
 }
@@ -495,12 +470,10 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 	struct adapter *padapter =  pDM_Odm->Adapter;
 
 	if (padapter->bDriverStopped) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_TRACE, ("<---- odm_RefreshRateAdaptiveMask(): driver is going to unload\n"));
 		return;
 	}
 
 	if (!pDM_Odm->bUseRAMask) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("<---- odm_RefreshRateAdaptiveMask(): driver does not control rate adaptive mask\n"));
 		return;
 	}
 
@@ -512,7 +485,6 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 				continue;
 
 			if (true == ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level)) {
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("RSSI:%d, RSSI_LEVEL:%d\n", pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level));
 				/* printk("RSSI:%d, RSSI_LEVEL:%d\n", pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level); */
 				rtw_hal_update_ra_mask(pstat, pstat->rssi_level);
 			}
@@ -541,9 +513,7 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 static void odm_RefreshRateAdaptiveMask(struct dm_odm_t *pDM_Odm)
 {
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_TRACE, ("odm_RefreshRateAdaptiveMask()---------->\n"));
 	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_TRACE, ("odm_RefreshRateAdaptiveMask(): Return cos not supported\n"));
 		return;
 	}
 	odm_RefreshRateAdaptiveMaskCE(pDM_Odm);
@@ -596,7 +566,6 @@ bool ODM_RAStateCheck(
 	/* printk("==>%s, RATRState:0x%02x , RSSI:%d\n", __func__, RATRState, RSSI); */
 
 	if (*pRATRState != RATRState || bForceUpdate) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("RSSI Level %d -> %d\n", *pRATRState, RATRState));
 		*pRATRState = RATRState;
 		return true;
 	}
@@ -858,7 +827,6 @@ void ODM_DMWatchdog(struct dm_odm_t *pDM_Odm)
 	odm_BasicDbgMessage(pDM_Odm);
 	odm_FalseAlarmCounterStatistics(pDM_Odm);
 	odm_NHMCounterStatistics(pDM_Odm);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): RSSI = 0x%x\n", pDM_Odm->RSSI_Min));
 
 	odm_RSSIMonitorCheck(pDM_Odm);
 
@@ -872,8 +840,6 @@ void ODM_DMWatchdog(struct dm_odm_t *pDM_Odm)
 		/* (pDM_Odm->SupportICType & (ODM_RTL8188E) &&(&&(((pDM_Odm->SupportInterface  == ODM_ITRF_SDIO))) */
 		/*  */
 	) {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("----Step1: odm_DIG is in LPS mode\n"));
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("---Step2: 8723AS is in LPS mode\n"));
 			odm_DIGbyRSSI_LPS(pDM_Odm);
 	} else
 		odm_DIG(pDM_Odm);
diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index 75471c6c168e..0f6b9d661e39 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -25,16 +25,6 @@ static void odm_SetCrystalCap(void *pDM_VOID, u8 CrystalCap)
 		0x00FFF000,
 		(CrystalCap | (CrystalCap << 6))
 	);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_CFO_TRACKING,
-		ODM_DBG_LOUD,
-		(
-			"odm_SetCrystalCap(): CrystalCap = 0x%x\n",
-			CrystalCap
-		)
-	);
 }
 
 static u8 odm_GetDefaultCrytaltalCap(void *pDM_VOID)
@@ -98,22 +88,6 @@ void ODM_CfoTrackingInit(void *pDM_VOID)
 		pCfoTrack->CrystalCap = odm_GetDefaultCrytaltalCap(pDM_Odm);
 	pCfoTrack->bATCStatus = odm_GetATCStatus(pDM_Odm);
 	pCfoTrack->bAdjust = true;
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_CFO_TRACKING,
-		ODM_DBG_LOUD,
-		("ODM_CfoTracking_init() =========>\n")
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_CFO_TRACKING,
-		ODM_DBG_LOUD,
-		(
-			"ODM_CfoTracking_init(): bATCStatus = %d, CrystalCap = 0x%x\n",
-			pCfoTrack->bATCStatus,
-			pCfoTrack->DefXCap
-		)
-	);
 }
 
 void ODM_CfoTracking(void *pDM_VOID)
@@ -127,47 +101,16 @@ void ODM_CfoTracking(void *pDM_VOID)
 
 	/* 4 Support ability */
 	if (!(pDM_Odm->SupportAbility & ODM_BB_CFO_TRACKING)) {
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_CFO_TRACKING,
-			ODM_DBG_LOUD,
-			("ODM_CfoTracking(): Return: SupportAbility ODM_BB_CFO_TRACKING is disabled\n")
-		);
 		return;
 	}
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_CFO_TRACKING,
-		ODM_DBG_LOUD,
-		("ODM_CfoTracking() =========>\n")
-	);
-
 	if (!pDM_Odm->bLinked || !pDM_Odm->bOneEntryOnly) {
 		/* 4 No link or more than one entry */
 		ODM_CfoTrackingReset(pDM_Odm);
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_CFO_TRACKING,
-			ODM_DBG_LOUD,
-			(
-				"ODM_CfoTracking(): Reset: bLinked = %d, bOneEntryOnly = %d\n",
-				pDM_Odm->bLinked,
-				pDM_Odm->bOneEntryOnly
-			)
-		);
 	} else {
 		/* 3 1. CFO Tracking */
 		/* 4 1.1 No new packet */
 		if (pCfoTrack->packetCount == pCfoTrack->packetCount_pre) {
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_CFO_TRACKING,
-				ODM_DBG_LOUD,
-				(
-					"ODM_CfoTracking(): packet counter doesn't change\n"
-				)
-			);
 			return;
 		}
 		pCfoTrack->packetCount_pre = pCfoTrack->packetCount;
@@ -180,17 +123,6 @@ void ODM_CfoTracking(void *pDM_VOID)
 			CFO_ave = CFO_kHz_A;
 		else
 			CFO_ave = (int)(CFO_kHz_A + CFO_kHz_B) >> 1;
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_CFO_TRACKING,
-			ODM_DBG_LOUD,
-			(
-				"ODM_CfoTracking(): CFO_kHz_A = %dkHz, CFO_kHz_B = %dkHz, CFO_ave = %dkHz\n",
-				CFO_kHz_A,
-				CFO_kHz_B,
-				CFO_ave
-			)
-		);
 
 		/* 4 1.3 Avoid abnormal large CFO */
 		CFO_ave_diff =
@@ -203,7 +135,6 @@ void ODM_CfoTracking(void *pDM_VOID)
 			pCfoTrack->largeCFOHit == 0 &&
 			!pCfoTrack->bAdjust
 		) {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_CFO_TRACKING, ODM_DBG_LOUD, ("ODM_CfoTracking(): first large CFO hit\n"));
 			pCfoTrack->largeCFOHit = 1;
 			return;
 		} else
@@ -223,12 +154,6 @@ void ODM_CfoTracking(void *pDM_VOID)
 		if (pDM_Odm->bBtEnabled) {
 			pCfoTrack->bAdjust = false;
 			odm_SetCrystalCap(pDM_Odm, pCfoTrack->DefXCap);
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_CFO_TRACKING,
-				ODM_DBG_LOUD,
-				("ODM_CfoTracking(): Disable CFO tracking for BT!!\n")
-			);
 		}
 
 		/* 4 1.6 Big jump */
@@ -237,16 +162,6 @@ void ODM_CfoTracking(void *pDM_VOID)
 				Adjust_Xtal = Adjust_Xtal+((CFO_ave-CFO_TH_XTAL_LOW)>>2);
 			else if (CFO_ave < (-CFO_TH_XTAL_LOW))
 				Adjust_Xtal = Adjust_Xtal+((CFO_TH_XTAL_LOW-CFO_ave)>>2);
-
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_CFO_TRACKING,
-				ODM_DBG_LOUD,
-				(
-					"ODM_CfoTracking(): Crystal cap offset = %d\n",
-					Adjust_Xtal
-				)
-			);
 		}
 
 		/* 4 1.7 Adjust Crystal Cap. */
@@ -263,34 +178,12 @@ void ODM_CfoTracking(void *pDM_VOID)
 
 			odm_SetCrystalCap(pDM_Odm, (u8)CrystalCap);
 		}
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_CFO_TRACKING,
-			ODM_DBG_LOUD,
-			(
-				"ODM_CfoTracking(): Crystal cap = 0x%x, Default Crystal cap = 0x%x\n",
-				pCfoTrack->CrystalCap,
-				pCfoTrack->DefXCap
-			)
-		);
 
 		/* 3 2. Dynamic ATC switch */
 		if (CFO_ave < CFO_TH_ATC && CFO_ave > -CFO_TH_ATC) {
 			odm_SetATCStatus(pDM_Odm, false);
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_CFO_TRACKING,
-				ODM_DBG_LOUD,
-				("ODM_CfoTracking(): Disable ATC!!\n")
-			);
 		} else {
 			odm_SetATCStatus(pDM_Odm, true);
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_CFO_TRACKING,
-				ODM_DBG_LOUD,
-				("ODM_CfoTracking(): Enable ATC!!\n")
-			);
 		}
 	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index dcef7fb17389..4bb558426427 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -81,17 +81,6 @@ void odm_NHMBB(void *pDM_VOID)
 		*(pDM_Odm->pNumTxBytesUnicast);
 	pDM_Odm->NHMLastRxOkcnt =
 		*(pDM_Odm->pNumRxBytesUnicast);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		(
-			"NHM_cnt_0 =%d, NHMCurTxOkcnt = %llu, NHMCurRxOkcnt = %llu\n",
-			pDM_Odm->NHM_cnt_0,
-			pDM_Odm->NHMCurTxOkcnt,
-			pDM_Odm->NHMCurRxOkcnt
-		)
-	);
 
 
 	if ((pDM_Odm->NHMCurTxOkcnt) + 1 > (u64)(pDM_Odm->NHMCurRxOkcnt<<2) + 1) { /* Tx > 4*Rx possible for adaptivity test */
@@ -127,8 +116,6 @@ void odm_NHMBB(void *pDM_VOID)
 			}
 		}
 	}
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("adaptivity_flag = %d\n ", pDM_Odm->adaptivity_flag));
 }
 
 void odm_SearchPwdBLowerBound(void *pDM_VOID, u8 IGI_target)
@@ -199,8 +186,6 @@ void odm_SearchPwdBLowerBound(void *pDM_VOID, u8 IGI_target)
 			pDM_Odm->Adaptivity_IGI_upper = IGI;
 		}
 	}
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("IGI = 0x%x, H2L_lb = 0x%x, L2H_lb = 0x%x\n", IGI, pDM_Odm->H2L_lb, pDM_Odm->L2H_lb));
 }
 
 void odm_AdaptivityInit(void *pDM_VOID)
@@ -239,12 +224,8 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI)
 	bool EDCCA_State = false;
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_ADAPTIVITY)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("Go to odm_DynamicEDCCA()\n"));
 		return;
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_Adaptivity() =====>\n"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("ForceEDCCA =%d, IGI_Base = 0x%x, TH_L2H_ini = %d, TH_EDCCA_HL_diff = %d, AdapEn_RSSI = %d\n",
-		pDM_Odm->ForceEDCCA, pDM_Odm->IGI_Base, pDM_Odm->TH_L2H_ini, pDM_Odm->TH_EDCCA_HL_diff, pDM_Odm->AdapEn_RSSI));
 
 	if (*pDM_Odm->pBandWidth == ODM_BW20M) /* CHANNEL_WIDTH_20 */
 		IGI_target = pDM_Odm->IGI_Base;
@@ -284,19 +265,6 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI)
 	)
 		odm_NHMBB(pDM_Odm);
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		(
-			"BandWidth =%s, IGI_target = 0x%x, EDCCA_State =%d\n",
-			(*pDM_Odm->pBandWidth == ODM_BW80M) ? "80M" :
-			((*pDM_Odm->pBandWidth == ODM_BW40M) ? "40M" : "20M"),
-			IGI_target,
-			EDCCA_State
-		)
-	);
-
 	if (EDCCA_State) {
 		Diff = IGI_target-(s8)IGI;
 		TH_L2H_dmc = pDM_Odm->TH_L2H_ini + Diff;
@@ -314,8 +282,6 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI)
 		TH_L2H_dmc = 0x7f;
 		TH_H2L_dmc = 0x7f;
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("IGI = 0x%x, TH_L2H_dmc = %d, TH_H2L_dmc = %d\n",
-		IGI, TH_L2H_dmc, TH_H2L_dmc));
 	PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, bMaskByte0, (u8)TH_L2H_dmc);
 	PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_ECCAThreshold, bMaskByte2, (u8)TH_H2L_dmc);
 }
@@ -326,18 +292,13 @@ void ODM_Write_DIG(void *pDM_VOID, u8 CurrentIGI)
 	struct dig_t *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->bStopDIG) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("Stop Writing IGI\n"));
 		return;
 	}
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_TRACE, ("ODM_REG(IGI_A, pDM_Odm) = 0x%x, ODM_BIT(IGI, pDM_Odm) = 0x%x\n",
-		ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm)));
-
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
 		/* 1 Check initial gain by upper bound */
 		if (!pDM_DigTable->bPSDInProgress) {
 			if (CurrentIGI > pDM_DigTable->rx_gain_range_max) {
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_TRACE, ("CurrentIGI(0x%02x) is larger than upper bound !!\n", pDM_DigTable->rx_gain_range_max));
 				CurrentIGI = pDM_DigTable->rx_gain_range_max;
 			}
 
@@ -352,8 +313,6 @@ void ODM_Write_DIG(void *pDM_VOID, u8 CurrentIGI)
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_TRACE, ("CurrentIGI(0x%02x).\n", CurrentIGI));
-
 }
 
 void odm_PauseDIG(
@@ -366,18 +325,10 @@ void odm_PauseDIG(
 	struct dig_t *pDM_DigTable = &pDM_Odm->DM_DigTable;
 	static bool bPaused;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_PauseDIG() =========>\n"));
-
 	if (
 		(pDM_Odm->SupportAbility & ODM_BB_ADAPTIVITY) &&
 		pDM_Odm->TxHangFlg == true
 	) {
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_DIG,
-			ODM_DBG_LOUD,
-			("odm_PauseDIG(): Dynamic adjust threshold in progress !!\n")
-		);
 		return;
 	}
 
@@ -385,12 +336,6 @@ void odm_PauseDIG(
 		!bPaused && (!(pDM_Odm->SupportAbility & ODM_BB_DIG) ||
 		!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
 	){
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_DIG,
-			ODM_DBG_LOUD,
-			("odm_PauseDIG(): Return: SupportAbility ODM_BB_DIG or ODM_BB_FA_CNT is disabled\n")
-		);
 		return;
 	}
 
@@ -399,18 +344,15 @@ void odm_PauseDIG(
 	case ODM_PAUSE_DIG:
 		/* 2 Disable DIG */
 		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_ABILITY, pDM_Odm->SupportAbility & (~ODM_BB_DIG));
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_PauseDIG(): Pause DIG !!\n"));
 
 		/* 2 Backup IGI value */
 		if (!bPaused) {
 			pDM_DigTable->IGIBackup = pDM_DigTable->CurIGValue;
 			bPaused = true;
 		}
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_PauseDIG(): Backup IGI  = 0x%x\n", pDM_DigTable->IGIBackup));
 
 		/* 2 Write new IGI value */
 		ODM_Write_DIG(pDM_Odm, IGIValue);
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_PauseDIG(): Write new IGI = 0x%x\n", IGIValue));
 		break;
 
 	/* 1 Resume DIG */
@@ -419,16 +361,13 @@ void odm_PauseDIG(
 			/* 2 Write backup IGI value */
 			ODM_Write_DIG(pDM_Odm, pDM_DigTable->IGIBackup);
 			bPaused = false;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_PauseDIG(): Write original IGI = 0x%x\n", pDM_DigTable->IGIBackup));
 
 			/* 2 Enable DIG */
 			ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_ABILITY, pDM_Odm->SupportAbility | ODM_BB_DIG);
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_PauseDIG(): Resume DIG !!\n"));
 		}
 		break;
 
 	default:
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_PauseDIG(): Wrong  type !!\n"));
 		break;
 	}
 }
@@ -439,25 +378,21 @@ bool odm_DigAbort(void *pDM_VOID)
 
 	/* SupportAbility */
 	if (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Return: SupportAbility ODM_BB_FA_CNT is disabled\n"));
 		return	true;
 	}
 
 	/* SupportAbility */
 	if (!(pDM_Odm->SupportAbility & ODM_BB_DIG)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Return: SupportAbility ODM_BB_DIG is disabled\n"));
 		return	true;
 	}
 
 	/* ScanInProcess */
 	if (*(pDM_Odm->pbScanInProcess)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Return: In Scan Progress\n"));
 		return	true;
 	}
 
 	/* add by Neil Chen to avoid PSD is processing */
 	if (pDM_Odm->bDMInitialGainEnable == false) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Return: PSD is Processing\n"));
 		return	true;
 	}
 
@@ -523,8 +458,6 @@ void odm_DIG(void *pDM_VOID)
 	if (odm_DigAbort(pDM_Odm))
 		return;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() ===========================>\n\n"));
-
 	if (pDM_Odm->adaptivity_flag == true)
 		Adap_IGI_Upper = pDM_Odm->Adaptivity_IGI_upper;
 
@@ -540,15 +473,12 @@ void odm_DIG(void *pDM_VOID)
 	dm_dig_min = DM_DIG_MIN_NIC;
 	DIG_MaxOfMin = DM_DIG_MAX_AP;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Absolutely upper bound = 0x%x, lower bound = 0x%x\n", dm_dig_max, dm_dig_min));
-
 	/* 1 Adjust boundary by RSSI */
 	if (pDM_Odm->bLinked && bPerformance) {
 		/* 2 Modify DIG upper bound */
 		/* 4 Modify DIG upper bound for 92E, 8723A\B, 8821 & 8812 BT */
 		if (pDM_Odm->bBtLimitedDig == 1) {
 			offset = 10;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Coex. case: Force upper bound to RSSI + %d !!!!!!\n", offset));
 		} else
 			offset = 15;
 
@@ -586,49 +516,9 @@ void odm_DIG(void *pDM_VOID)
 					DIG_Dynamic_MIN = DIG_MaxOfMin;
 				else
 					DIG_Dynamic_MIN = (u8) pDM_DigTable->AntDiv_RSSI_max;
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_ANT_DIV,
-					ODM_DBG_LOUD,
-					(
-						"odm_DIG(): Antenna diversity case: Force lower bound to 0x%x !!!!!!\n",
-						DIG_Dynamic_MIN
-					)
-				);
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_ANT_DIV,
-					ODM_DBG_LOUD,
-					(
-						"odm_DIG(): Antenna diversity case: RSSI_max = 0x%x !!!!!!\n",
-						pDM_DigTable->AntDiv_RSSI_max
-					)
-				);
 			}
 		}
 	}
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		(
-			"odm_DIG(): Adjust boundary by RSSI Upper bound = 0x%x, Lower bound = 0x%x\n",
-			pDM_DigTable->rx_gain_range_max,
-			DIG_Dynamic_MIN
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		(
-			"odm_DIG(): Link status: bLinked = %d, RSSI = %d, bFirstConnect = %d, bFirsrDisConnect = %d\n\n",
-			pDM_Odm->bLinked,
-			pDM_Odm->RSSI_Min,
-			FirstConnect,
-			FirstDisConnect
-		)
-	);
 
 	/* 1 Modify DIG lower bound, deal with abnormal case */
 	/* 2 Abnormal false alarm case */
@@ -645,47 +535,20 @@ void odm_DIG(void *pDM_VOID)
 			pDM_Odm->bsta_state
 		) {
 			pDM_DigTable->rx_gain_range_min = dm_dig_min;
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_DIG,
-				ODM_DBG_LOUD,
-				(
-					"odm_DIG(): Abnormal #beacon (%d) case in STA mode: Force lower bound to 0x%x !!!!!!\n\n",
-					pDM_Odm->PhyDbgInfo.NumQryBeaconPkt,
-					pDM_DigTable->rx_gain_range_min
-				)
-			);
 		}
 	}
 
 	/* 2 Abnormal lower bound case */
 	if (pDM_DigTable->rx_gain_range_min > pDM_DigTable->rx_gain_range_max) {
 		pDM_DigTable->rx_gain_range_min = pDM_DigTable->rx_gain_range_max;
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_DIG,
-			ODM_DBG_LOUD,
-			(
-				"odm_DIG(): Abnormal lower bound case: Force lower bound to 0x%x !!!!!!\n\n",
-				pDM_DigTable->rx_gain_range_min
-			)
-		);
 	}
 
 
 	/* 1 False alarm threshold decision */
 	odm_FAThresholdCheck(pDM_Odm, bDFSBand, bPerformance, RxTp, TxTp, dm_FA_thres);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): False alarm threshold = %d, %d, %d\n\n", dm_FA_thres[0], dm_FA_thres[1], dm_FA_thres[2]));
 
 	/* 1 Adjust initial gain by false alarm */
 	if (pDM_Odm->bLinked && bPerformance) {
-		/* 2 After link */
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_DIG,
-			ODM_DBG_LOUD,
-			("odm_DIG(): Adjust IGI after link\n")
-		);
 
 		if (bFirstTpTarget || (FirstConnect && bPerformance)) {
 			pDM_DigTable->LargeFAHit = 0;
@@ -698,16 +561,6 @@ void odm_DIG(void *pDM_VOID)
 					CurrentIGI = DIG_MaxOfMin;
 			}
 
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_DIG,
-				ODM_DBG_LOUD,
-				(
-					"odm_DIG(): First connect case: IGI does on-shot to 0x%x\n",
-					CurrentIGI
-				)
-			);
-
 		} else {
 			if (pFalseAlmCnt->Cnt_all > dm_FA_thres[2])
 				CurrentIGI = CurrentIGI + 4;
@@ -722,35 +575,12 @@ void odm_DIG(void *pDM_VOID)
 				(pDM_Odm->bsta_state)
 			) {
 				CurrentIGI = pDM_DigTable->rx_gain_range_min;
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_DIG,
-					ODM_DBG_LOUD,
-					(
-						"odm_DIG(): Abnormal #beacon (%d) case: IGI does one-shot to 0x%x\n",
-						pDM_Odm->PhyDbgInfo.NumQryBeaconPkt,
-						CurrentIGI
-					)
-				);
 			}
 		}
 	} else {
-		/* 2 Before link */
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_DIG,
-			ODM_DBG_LOUD,
-			("odm_DIG(): Adjust IGI before link\n")
-		);
 
 		if (FirstDisConnect || bFirstCoverage) {
 			CurrentIGI = dm_dig_min;
-			ODM_RT_TRACE(
-				pDM_Odm,
-				ODM_COMP_DIG,
-				ODM_DBG_LOUD,
-				("odm_DIG(): First disconnect case: IGI does on-shot to lower bound\n")
-			);
 		} else {
 			if (pFalseAlmCnt->Cnt_all > dm_FA_thres[2])
 				CurrentIGI = CurrentIGI + 4;
@@ -768,17 +598,6 @@ void odm_DIG(void *pDM_VOID)
 	if (CurrentIGI > pDM_DigTable->rx_gain_range_max)
 		CurrentIGI = pDM_DigTable->rx_gain_range_max;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		(
-			"odm_DIG(): CurIGValue = 0x%x, TotalFA = %d\n\n",
-			CurrentIGI,
-			pFalseAlmCnt->Cnt_all
-		)
-	);
-
 	/* 1 Force upper bound and lower bound for adaptivity */
 	if (
 		pDM_Odm->SupportAbility & ODM_BB_ADAPTIVITY &&
@@ -791,8 +610,6 @@ void odm_DIG(void *pDM_VOID)
 			if (CurrentIGI < pDM_Odm->IGI_LowerBound)
 				CurrentIGI = pDM_Odm->IGI_LowerBound;
 		}
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Adaptivity case: Force upper bound to 0x%x !!!!!!\n", Adap_IGI_Upper));
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Adaptivity case: Force lower bound to 0x%x !!!!!!\n\n", pDM_Odm->IGI_LowerBound));
 	}
 
 
@@ -831,13 +648,6 @@ void odm_DIGbyRSSI_LPS(void *pDM_VOID)
 
 	CurrentIGI = CurrentIGI+RSSI_OFFSET_DIG;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		("odm_DIGbyRSSI_LPS() ==>\n")
-	);
-
 	/*  Using FW PS mode to make IGI */
 	/* Adjust by  FA in LPS MODE */
 	if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_LPS)
@@ -862,26 +672,6 @@ void odm_DIGbyRSSI_LPS(void *pDM_VOID)
 	else if (CurrentIGI < RSSI_Lower)
 		CurrentIGI = RSSI_Lower;
 
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		("odm_DIGbyRSSI_LPS(): pFalseAlmCnt->Cnt_all = %d\n", pFalseAlmCnt->Cnt_all)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		("odm_DIGbyRSSI_LPS(): pDM_Odm->RSSI_Min = %d\n", pDM_Odm->RSSI_Min)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_DIG,
-		ODM_DBG_LOUD,
-		("odm_DIGbyRSSI_LPS(): CurrentIGI = 0x%x\n", CurrentIGI)
-	);
-
 	ODM_Write_DIG(pDM_Odm, CurrentIGI);
 	/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
 }
@@ -970,86 +760,6 @@ void odm_FalseAlarmCounterStatistics(void *pDM_VOID)
 
 	FalseAlmCnt->Cnt_CCA_all =
 		FalseAlmCnt->Cnt_OFDM_CCA + FalseAlmCnt->Cnt_CCK_CCA;
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Enter odm_FalseAlarmCounterStatistics\n")
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		(
-			"Cnt_Fast_Fsync =%d, Cnt_SB_Search_fail =%d\n",
-			FalseAlmCnt->Cnt_Fast_Fsync,
-			FalseAlmCnt->Cnt_SB_Search_fail
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		(
-			"Cnt_Parity_Fail =%d, Cnt_Rate_Illegal =%d\n",
-			FalseAlmCnt->Cnt_Parity_Fail,
-			FalseAlmCnt->Cnt_Rate_Illegal
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		(
-			"Cnt_Crc8_fail =%d, Cnt_Mcs_fail =%d\n",
-			FalseAlmCnt->Cnt_Crc8_fail,
-			FalseAlmCnt->Cnt_Mcs_fail
-		)
-	);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Cnt_OFDM_CCA =%d\n", FalseAlmCnt->Cnt_OFDM_CCA)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Cnt_CCK_CCA =%d\n", FalseAlmCnt->Cnt_CCK_CCA)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Cnt_CCA_all =%d\n", FalseAlmCnt->Cnt_CCA_all)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Cnt_Ofdm_fail =%d\n",	FalseAlmCnt->Cnt_Ofdm_fail)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Cnt_Cck_fail =%d\n",	FalseAlmCnt->Cnt_Cck_fail)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Cnt_Ofdm_fail =%d\n",	FalseAlmCnt->Cnt_Ofdm_fail)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_FA_CNT,
-		ODM_DBG_LOUD,
-		("Total False Alarm =%d\n",	FalseAlmCnt->Cnt_all)
-	);
 }
 
 
@@ -1084,8 +794,6 @@ u8 odm_ForbiddenIGICheck(void *pDM_VOID, u8 DIG_Dynamic_MIN, u8 CurrentIGI)
 	u8 rx_gain_range_min = pDM_DigTable->rx_gain_range_min;
 
 	if (pFalseAlmCnt->Cnt_all > 10000) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Abnormally false alarm case.\n"));
-
 		if (pDM_DigTable->LargeFAHit != 3)
 			pDM_DigTable->LargeFAHit++;
 
@@ -1102,22 +810,18 @@ u8 odm_ForbiddenIGICheck(void *pDM_VOID, u8 DIG_Dynamic_MIN, u8 CurrentIGI)
 			else
 				rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 2);
 			pDM_DigTable->Recover_cnt = 1800;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Abnormally false alarm case: Recover_cnt = %d\n", pDM_DigTable->Recover_cnt));
 		}
 	} else {
 		if (pDM_DigTable->Recover_cnt != 0) {
 			pDM_DigTable->Recover_cnt--;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Normal Case: Recover_cnt = %d\n", pDM_DigTable->Recover_cnt));
 		} else {
 			if (pDM_DigTable->LargeFAHit < 3) {
 				if ((pDM_DigTable->ForbiddenIGI - 2) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
 					pDM_DigTable->ForbiddenIGI = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
 					rx_gain_range_min = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Normal Case: At Lower Bound\n"));
 				} else {
 					pDM_DigTable->ForbiddenIGI -= 2;
 					rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 2);
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Normal Case: Approach Lower Bound\n"));
 				}
 			} else
 				pDM_DigTable->LargeFAHit = 0;
@@ -1143,25 +847,12 @@ void odm_CCKPacketDetectionThresh(void *pDM_VOID)
 		!(pDM_Odm->SupportAbility & ODM_BB_CCK_PD) ||
 		!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT)
 	) {
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_CCK_PD,
-			ODM_DBG_LOUD,
-			("odm_CCKPacketDetectionThresh()  return ==========\n")
-		);
 		return;
 	}
 
 	if (pDM_Odm->ExtLNA)
 		return;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_CCK_PD,
-		ODM_DBG_LOUD,
-		("odm_CCKPacketDetectionThresh()  ==========>\n")
-	);
-
 	if (pDM_Odm->bLinked) {
 		if (pDM_Odm->RSSI_Min > 25)
 			CurCCK_CCAThres = 0xcd;
@@ -1181,16 +872,6 @@ void odm_CCKPacketDetectionThresh(void *pDM_VOID)
 	}
 
 	ODM_Write_CCK_CCA_Thres(pDM_Odm, CurCCK_CCAThres);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_CCK_PD,
-		ODM_DBG_LOUD,
-		(
-			"odm_CCKPacketDetectionThresh()  CurCCK_CCAThres = 0x%x\n",
-			CurCCK_CCAThres
-		)
-	);
 }
 
 void ODM_Write_CCK_CCA_Thres(void *pDM_VOID, u8 CurCCK_CCAThres)
diff --git a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
index 12b37c17ea0c..f3856e47bfd3 100644
--- a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
+++ b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
@@ -37,19 +37,6 @@ void ODM_EdcaTurboInit(void *pDM_VOID)
 	pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = false;
 	pDM_Odm->DM_EDCA_Table.bIsCurRDLState = false;
 	Adapter->recvpriv.bIsAnyNonBEPkts = false;
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Original VO PARAM: 0x%x\n",
-		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_VO_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Original VI PARAM: 0x%x\n",
-		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_VI_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Original BE PARAM: 0x%x\n",
-		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_BE_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Original BK PARAM: 0x%x\n",
-		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_BK_PARAM)));
 }	/*  ODM_InitEdcaTurbo */
 
 void odm_EdcaTurboCheck(void *pDM_VOID)
@@ -60,15 +47,10 @@ void odm_EdcaTurboCheck(void *pDM_VOID)
 	 */
 	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("odm_EdcaTurboCheck ========================>\n"));
-
 	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
 		return;
 
 	odm_EdcaTurboCheckCE(pDM_Odm);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("<========================odm_EdcaTurboCheck\n"));
 }	/*  odm_CheckEdcaTurbo */
 
 void odm_EdcaTurboCheckCE(void *pDM_VOID)
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 638c16f5c668..c7010015b334 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -427,12 +427,6 @@ enum hal_status ODM_ConfigRFWithHeaderFile(
 	enum odm_rf_radio_path_e eRFPath
 )
 {
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-				("===>ODM_ConfigRFWithHeaderFile (%s)\n", (pDM_Odm->bIsMPChip) ? "MPChip" : "TestChip"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-				("pDM_Odm->SupportPlatform: 0x%X, pDM_Odm->SupportInterface: 0x%X, pDM_Odm->BoardType: 0x%X\n",
-				pDM_Odm->SupportPlatform, pDM_Odm->SupportInterface, pDM_Odm->BoardType));
-
 	if (ConfigType == CONFIG_RF_RADIO)
 		READ_AND_CONFIG(8723B, _RadioA);
 	else if (ConfigType == CONFIG_RF_TXPWR_LMT)
@@ -443,12 +437,6 @@ enum hal_status ODM_ConfigRFWithHeaderFile(
 
 enum hal_status ODM_ConfigRFWithTxPwrTrackHeaderFile(struct dm_odm_t *pDM_Odm)
 {
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-				 ("===>ODM_ConfigRFWithTxPwrTrackHeaderFile (%s)\n", (pDM_Odm->bIsMPChip) ? "MPChip" : "TestChip"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-				 ("pDM_Odm->SupportPlatform: 0x%X, pDM_Odm->SupportInterface: 0x%X, pDM_Odm->BoardType: 0x%X\n",
-				 pDM_Odm->SupportPlatform, pDM_Odm->SupportInterface, pDM_Odm->BoardType));
-
 	if (pDM_Odm->SupportInterface == ODM_ITRF_SDIO)
 		READ_AND_CONFIG(8723B, _TxPowerTrack_SDIO);
 
@@ -459,12 +447,6 @@ enum hal_status ODM_ConfigBBWithHeaderFile(
 	struct dm_odm_t *pDM_Odm, enum ODM_BB_Config_Type ConfigType
 )
 {
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-				("===>ODM_ConfigBBWithHeaderFile (%s)\n", (pDM_Odm->bIsMPChip) ? "MPChip" : "TestChip"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-				("pDM_Odm->SupportPlatform: 0x%X, pDM_Odm->SupportInterface: 0x%X, pDM_Odm->BoardType: 0x%X\n",
-				pDM_Odm->SupportPlatform, pDM_Odm->SupportInterface, pDM_Odm->BoardType));
-
 	if (ConfigType == CONFIG_BB_PHY_REG)
 		READ_AND_CONFIG(8723B, _PHY_REG);
 	else if (ConfigType == CONFIG_BB_AGC_TAB)
diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
index 956e5a725a5d..ad169704f3e9 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
@@ -38,8 +38,6 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 	else
 		max_rf_path = 1;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_DebugControlInbandNoise_Nseries() ==>\n"));
-
 	memset(&noise_data, 0, sizeof(struct noise_level));
 
 	/*  */
@@ -64,7 +62,6 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 
 		/* Read Noise Floor Report */
 		tmp4b = PHY_QueryBBReg(pDM_Odm->Adapter, 0x8f8, bMaskDWord);
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("Noise Floor Report (0x8f8) = 0x%08x\n", tmp4b));
 
 		/* PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XAAGCCore1, bMaskByte0, TestInitialGain); */
 		/* if (max_rf_path == 2) */
@@ -76,17 +73,10 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 		noise_data.value[ODM_RF_PATH_A] = (u8)(tmp4b&0xff);
 		noise_data.value[ODM_RF_PATH_B]  = (u8)((tmp4b&0xff00)>>8);
 
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("value_a = 0x%x(%d), value_b = 0x%x(%d)\n",
-			noise_data.value[ODM_RF_PATH_A], noise_data.value[ODM_RF_PATH_A], noise_data.value[ODM_RF_PATH_B], noise_data.value[ODM_RF_PATH_B]));
-
 		for (rf_path = ODM_RF_PATH_A; rf_path < max_rf_path; rf_path++) {
 			noise_data.sval[rf_path] = (s8)noise_data.value[rf_path];
 			noise_data.sval[rf_path] /= 2;
 		}
-
-
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("sval_a = %d, sval_b = %d\n",
-			noise_data.sval[ODM_RF_PATH_A], noise_data.sval[ODM_RF_PATH_B]));
 		/* mdelay(10); */
 		/* msleep(10); */
 
@@ -94,11 +84,8 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 			if ((noise_data.valid_cnt[rf_path] < ValidCnt) && (noise_data.sval[rf_path] < Valid_Max && noise_data.sval[rf_path] >= Valid_Min)) {
 				noise_data.valid_cnt[rf_path]++;
 				noise_data.sum[rf_path] += noise_data.sval[rf_path];
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RF_Path:%d Valid sval = %d\n", rf_path, noise_data.sval[rf_path]));
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("Sum of sval = %d,\n", noise_data.sum[rf_path]));
 				if (noise_data.valid_cnt[rf_path] == ValidCnt) {
 					valid_done++;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("After divided, RF_Path:%d , sum = %d\n", rf_path, noise_data.sum[rf_path]));
 				}
 
 			}
@@ -119,37 +106,23 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 	}
 	reg_c50 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XAAGCCore1, bMaskByte0);
 	reg_c50 &= ~BIT7;
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("0x%x = 0x%02x(%d)\n", rOFDM0_XAAGCCore1, reg_c50, reg_c50));
 	pDM_Odm->noise_level.noise[ODM_RF_PATH_A] = -110 + reg_c50 + noise_data.sum[ODM_RF_PATH_A];
 	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[ODM_RF_PATH_A];
 
 	if (max_rf_path == 2) {
 		reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
 		reg_c58 &= ~BIT7;
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("0x%x = 0x%02x(%d)\n", rOFDM0_XBAGCCore1, reg_c58, reg_c58));
 		pDM_Odm->noise_level.noise[ODM_RF_PATH_B] = -110 + reg_c58 + noise_data.sum[ODM_RF_PATH_B];
 		pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[ODM_RF_PATH_B];
 	}
 	pDM_Odm->noise_level.noise_all /= max_rf_path;
 
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_COMMON,
-		ODM_DBG_LOUD,
-		(
-			"noise_a = %d, noise_b = %d\n",
-			pDM_Odm->noise_level.noise[ODM_RF_PATH_A],
-			pDM_Odm->noise_level.noise[ODM_RF_PATH_B]
-		)
-	);
-
 	/*  */
 	/*  Step 4. Recover the Dig */
 	/*  */
 	if (bPauseDIG)
 		odm_PauseDIG(pDM_Odm, ODM_RESUME_DIG, IGIValue);
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_DebugControlInbandNoise_Nseries() <==\n"));
 	return pDM_Odm->noise_level.noise_all;
 
 }
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
index 92b708265d47..cfcbc3741803 100644
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
+++ b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
@@ -12,12 +12,7 @@ void odm_PathDiversityInit(void *pDM_VOID)
 	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_PATH_DIV))
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_PATH_DIV,
-			ODM_DBG_LOUD,
-			("Return: Not Support PathDiv\n")
-		);
+		{}
 }
 
 void odm_PathDiversity(void *pDM_VOID)
@@ -25,10 +20,5 @@ void odm_PathDiversity(void *pDM_VOID)
 	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_PATH_DIV))
-		ODM_RT_TRACE(
-			pDM_Odm,
-			ODM_COMP_PATH_DIV,
-			ODM_DBG_LOUD,
-			("Return: Not Support PathDiv\n")
-		);
+		{}
 }
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
index 63bf5ba3e0d5..b77c61598294 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
@@ -38,17 +38,6 @@ void odm_ConfigRFReg_8723B(
 				PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH, RegAddr, bRFRegOffsetMask, Data);
 				udelay(1);
 				getvalue = PHY_QueryRFReg(pDM_Odm->Adapter, RF_PATH, Addr, bMaskDWord);
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_INIT,
-					ODM_DBG_TRACE,
-					(
-						"===> ODM_ConfigRFWithHeaderFile: [B6] getvalue 0x%x, Data 0x%x, count %d\n",
-						getvalue,
-						Data,
-						count
-					)
-				);
 				if (count > 5)
 					break;
 			}
@@ -86,17 +75,6 @@ void odm_ConfigRFReg_8723B(
 				getvalue = PHY_QueryRFReg(
 					pDM_Odm->Adapter, RF_PATH, Addr, bMaskDWord
 				);
-				ODM_RT_TRACE(
-					pDM_Odm,
-					ODM_COMP_INIT,
-					ODM_DBG_TRACE,
-					(
-						"===> ODM_ConfigRFWithHeaderFile: [B2] getvalue 0x%x, Data 0x%x, count %d\n",
-						getvalue,
-						Data,
-						count
-					)
-				);
 
 				if (count > 5)
 					break;
@@ -118,32 +96,11 @@ void odm_ConfigRF_RadioA_8723B(struct dm_odm_t *pDM_Odm, u32 Addr, u32 Data)
 		ODM_RF_PATH_A,
 		Addr|maskforPhySet
 	);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> ODM_ConfigRFWithHeaderFile: [RadioA] %08X %08X\n",
-			Addr,
-			Data
-		)
-	);
 }
 
 void odm_ConfigMAC_8723B(struct dm_odm_t *pDM_Odm, u32 Addr, u8 Data)
 {
 	rtw_write8(pDM_Odm->Adapter, Addr, Data);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> ODM_ConfigMACWithHeaderFile: [MAC_REG] %08X %08X\n",
-			Addr,
-			Data
-		)
-	);
 }
 
 void odm_ConfigBB_AGC_8723B(
@@ -156,17 +113,6 @@ void odm_ConfigBB_AGC_8723B(
 	PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
 	/*  Add 1us delay between BB/RF register setting. */
 	udelay(1);
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_TRACE,
-		(
-			"===> ODM_ConfigBBWithHeaderFile: [AGC_TAB] %08X %08X\n",
-			Addr,
-			Data
-		)
-	);
 }
 
 void odm_ConfigBB_PHY_REG_PG_8723B(
@@ -184,17 +130,6 @@ void odm_ConfigBB_PHY_REG_PG_8723B(
 	else {
 		PHY_StoreTxPowerByRate(pDM_Odm->Adapter, Band, RfPath, TxNum, Addr, Bitmask, Data);
 	}
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		(
-			"===> ODM_ConfigBBWithHeaderFile: [PHY_REG] %08X %08X %08X\n",
-			Addr,
-			Bitmask,
-			Data
-		)
-	);
 }
 
 void odm_ConfigBB_PHY_8723B(
@@ -222,7 +157,6 @@ void odm_ConfigBB_PHY_8723B(
 
 	/*  Add 1us delay between BB/RF register setting. */
 	udelay(1);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("===> ODM_ConfigBBWithHeaderFile: [PHY_REG] %08X %08X\n", Addr, Data));
 }
 
 void odm_ConfigBB_TXPWR_LMT_8723B(
-- 
2.20.1

