Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA663E3481
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhHGJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhHGJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E645DC0617A0
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q11so2183389wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN2DxA5GTPk3m4/PzDyeBfC9vz8R14h93WEWYHPxGFk=;
        b=lkaR0u/oMUu2tQzJVESYFozquLiokgvDNbzscPak0tMm6G41AnBn6+bsXTJnA/LK/r
         tc9xur2bIrDMBzMeOcP4JIUGdivhKic6w+aJ91DyL5we6BQcfZkWCWCKK5jVnrme+Kyy
         17C1at1hiBemrkMfX1mfMeSPpf0zlIkgytbwjqQnXCorPi0s1K/3THt54efpiuxHc91T
         /CAKizXahOkPA2vKuSp9RhvsOLzWUc1Z0rs7sqcApew4liXC7+ugLaUhXPihny3nqBS6
         N22LCl+E+8/uXGxCO1A6aQAwMdtHMf9rJ14v6byaTiA6/il+zSK2vZOUkOwf6FN2dWey
         yekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN2DxA5GTPk3m4/PzDyeBfC9vz8R14h93WEWYHPxGFk=;
        b=ll8v+GWJlgmRdgmIf2WF28O79z7/mSL44vG8wvcj0BBSLUIe5xt8eRHKR/ZlGrogHK
         +hKr2VEzvNmrLR4sMV0gPatjcJi7GmgmNNtwqGd+6JVf/Yp930cBBY6Bm6EU5vrn0n7E
         OHltp4JPawpmqT0obpk4v9Cer/6oMvQuCFwaP/eIo9egkwMVj32Fn96QxGahn/5JL35w
         g81jUDownZN1xS7yGrGcbClOuVOzpOBYavhdYh7pchqjLBzjSeUOae3/noYLAgEom29/
         5P53/9RCKTzHWL3OA8YDa03nj0mnGsgPe1toNRoC3W8+4LxOV2EECsbo7BJRORjLfW8K
         g1yw==
X-Gm-Message-State: AOAM5332I6EWIIf5NTgyswzkr9uPHOafsTC7YBfORH3h3pG34zZuOsPU
        Udt0zvaJehzvfXx00yWKiSCYCsgCSKo=
X-Google-Smtp-Source: ABdhPJw7/84QG7vYhxalC8vBiwIBTkrvNHrKu/jNKYWFl9NSAJbBs+2DUQH8+B/XjsBTFdBi++yYFw==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr15100419wrq.326.1628329719423;
        Sat, 07 Aug 2021 02:48:39 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id p4sm12781359wre.83.2021.08.07.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] staging: rtl8723bs: remove RF_*TX enum
Date:   Sat,  7 Aug 2021 11:48:10 +0200
Message-Id: <3acc624742a933d90e83a83babb4eecb193cf869.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove RF_*TX enum, its only used value is RF_1TX.
So remove it and remove all indexes and loop over
these enum items.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |  17 ++-
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 120 +++++++-----------
 .../rtl8723bs/hal/odm_RegConfig8723B.c        |   3 +-
 .../rtl8723bs/hal/odm_RegConfig8723B.h        |   9 +-
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |   2 +-
 .../rtl8723bs/include/hal_com_phycfg.h        |  17 +--
 drivers/staging/rtl8723bs/include/hal_data.h  |   8 +-
 7 files changed, 64 insertions(+), 112 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
index 3de8dcb5ed7c..dd0f74b0cf0d 100644
--- a/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
+++ b/drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
@@ -543,12 +543,12 @@ void ODM_ReadAndConfig_MP_8723B_PHY_REG(struct dm_odm_t *pDM_Odm)
 ******************************************************************************/
 
 static u32 Array_MP_8723B_PHY_REG_PG[] = {
-	0, 0, 0x00000e08, 0x0000ff00, 0x00003800,
-	0, 0, 0x0000086c, 0xffffff00, 0x32343600,
-	0, 0, 0x00000e00, 0xffffffff, 0x40424444,
-	0, 0, 0x00000e04, 0xffffffff, 0x28323638,
-	0, 0, 0x00000e10, 0xffffffff, 0x38404244,
-	0, 0, 0x00000e14, 0xffffffff, 0x26303436
+	0, 0x00000e08, 0x0000ff00, 0x00003800,
+	0, 0x0000086c, 0xffffff00, 0x32343600,
+	0, 0x00000e00, 0xffffffff, 0x40424444,
+	0, 0x00000e04, 0xffffffff, 0x28323638,
+	0, 0x00000e10, 0xffffffff, 0x38404244,
+	0, 0x00000e14, 0xffffffff, 0x26303436
 };
 
 void ODM_ReadAndConfig_MP_8723B_PHY_REG_PG(struct dm_odm_t *pDM_Odm)
@@ -559,13 +559,12 @@ void ODM_ReadAndConfig_MP_8723B_PHY_REG_PG(struct dm_odm_t *pDM_Odm)
 	pDM_Odm->PhyRegPgVersion = 1;
 	pDM_Odm->PhyRegPgValueType = PHY_REG_PG_EXACT_VALUE;
 
-	for (i = 0; i < ARRAY_SIZE(Array_MP_8723B_PHY_REG_PG); i += 5) {
+	for (i = 0; i < ARRAY_SIZE(Array_MP_8723B_PHY_REG_PG); i += 4) {
 		u32 v1 = Array[i];
 		u32 v2 = Array[i+1];
 		u32 v3 = Array[i+2];
 		u32 v4 = Array[i+3];
-		u32 v5 = Array[i+4];
 
-		odm_ConfigBB_PHY_REG_PG_8723B(pDM_Odm, v1, v2, v3, v4, v5);
+		odm_ConfigBB_PHY_REG_PG_8723B(pDM_Odm, v1, v2, v3, v4);
 	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 4a249d20c661..272a9ec7a2d3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -11,7 +11,7 @@
 #include <linux/kernel.h>
 
 u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
-			    u8 TxNum, enum rate_section RateSection)
+			    enum rate_section RateSection)
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 	u8	value = 0;
@@ -21,13 +21,13 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
 
 	switch (RateSection) {
 	case CCK:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][0];
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][0];
 		break;
 	case OFDM:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][1];
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][1];
 		break;
 	case HT_MCS0_MCS7:
-		value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2];
+		value = pHalData->TxPwrByRateBase2_4G[RfPath][2];
 		break;
 	default:
 		break;
@@ -37,13 +37,8 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
 }
 
 static void
-phy_SetTxPowerByRateBase(
-	struct adapter *Adapter,
-	u8 RfPath,
-	enum rate_section	RateSection,
-	u8 TxNum,
-	u8 Value
-)
+phy_SetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
+			 enum rate_section RateSection, u8 Value)
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 
@@ -52,13 +47,13 @@ phy_SetTxPowerByRateBase(
 
 	switch (RateSection) {
 	case CCK:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][0] = Value;
+		pHalData->TxPwrByRateBase2_4G[RfPath][0] = Value;
 		break;
 	case OFDM:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][1] = Value;
+		pHalData->TxPwrByRateBase2_4G[RfPath][1] = Value;
 		break;
 	case HT_MCS0_MCS7:
-		pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][2] = Value;
+		pHalData->TxPwrByRateBase2_4G[RfPath][2] = Value;
 		break;
 	default:
 		break;
@@ -73,14 +68,14 @@ struct adapter *padapter
 	u8 path, base;
 
 	for (path = RF_PATH_A; path <= RF_PATH_B; ++path) {
-		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_11M);
-		phy_SetTxPowerByRateBase(padapter, path, CCK, RF_1TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, MGN_11M);
+		phy_SetTxPowerByRateBase(padapter, path, CCK, base);
 
-		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_54M);
-		phy_SetTxPowerByRateBase(padapter, path, OFDM, RF_1TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, MGN_54M);
+		phy_SetTxPowerByRateBase(padapter, path, OFDM, base);
 
-		base = PHY_GetTxPowerByRate(padapter, path, RF_1TX, MGN_MCS7);
-		phy_SetTxPowerByRateBase(padapter, path, HT_MCS0_MCS7, RF_1TX, base);
+		base = PHY_GetTxPowerByRate(padapter, path, MGN_MCS7);
+		phy_SetTxPowerByRateBase(padapter, path, HT_MCS0_MCS7, base);
 	}
 }
 
@@ -320,14 +315,8 @@ PHY_GetRateValuesOfTxPowerByRate(
 	}
 }
 
-static void PHY_StoreTxPowerByRateNew(
-	struct adapter *padapter,
-	u32	RfPath,
-	u32	TxNum,
-	u32	RegAddr,
-	u32	BitMask,
-	u32	Data
-)
+static void PHY_StoreTxPowerByRateNew(struct adapter *padapter,	u32 RfPath,
+				      u32 RegAddr, u32 BitMask, u32 Data)
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	u8 i = 0, rateIndex[4] = {0}, rateNum = 0;
@@ -338,11 +327,8 @@ static void PHY_StoreTxPowerByRateNew(
 	if (RfPath >= RF_PATH_MAX)
 		return;
 
-	if (TxNum > RF_MAX_TX_NUM)
-		return;
-
 	for (i = 0; i < rateNum; ++i) {
-		pHalData->TxPwrByRateOffset[RfPath][TxNum][rateIndex[i]] = PwrByRateVal[i];
+		pHalData->TxPwrByRateOffset[RfPath][rateIndex[i]] = PwrByRateVal[i];
 	}
 }
 
@@ -359,18 +345,16 @@ static void PHY_StoreTxPowerByRateOld(
 void PHY_InitTxPowerByRate(struct adapter *padapter)
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
-	u8 rfPath, TxNum, rate;
+	u8 rfPath, rate;
 
 	for (rfPath = 0; rfPath < TX_PWR_BY_RATE_NUM_RF; ++rfPath)
-		for (TxNum = 0; TxNum < TX_PWR_BY_RATE_NUM_RF; ++TxNum)
-			for (rate = 0; rate < TX_PWR_BY_RATE_NUM_RATE; ++rate)
-				pHalData->TxPwrByRateOffset[rfPath][TxNum][rate] = 0;
+		for (rate = 0; rate < TX_PWR_BY_RATE_NUM_RATE; ++rate)
+			pHalData->TxPwrByRateOffset[rfPath][rate] = 0;
 }
 
 void PHY_StoreTxPowerByRate(
 	struct adapter *padapter,
 	u32	RfPath,
-	u32	TxNum,
 	u32	RegAddr,
 	u32	BitMask,
 	u32	Data
@@ -380,7 +364,7 @@ void PHY_StoreTxPowerByRate(
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
 	if (pDM_Odm->PhyRegPgVersion > 0)
-		PHY_StoreTxPowerByRateNew(padapter, RfPath, TxNum, RegAddr, BitMask, Data);
+		PHY_StoreTxPowerByRateNew(padapter, RfPath, RegAddr, BitMask, Data);
 	else if (pDM_Odm->PhyRegPgVersion == 0) {
 		PHY_StoreTxPowerByRateOld(padapter, RegAddr, BitMask, Data);
 	}
@@ -391,7 +375,7 @@ phy_ConvertTxPowerByRateInDbmToRelativeValues(
 struct adapter *padapter
 	)
 {
-	u8	base = 0, i = 0, value = 0, path = 0, txNum = 0;
+	u8	base = 0, i = 0, value = 0, path = 0;
 	u8	cckRates[4] = {
 		MGN_1M, MGN_2M, MGN_5_5M, MGN_11M
 	};
@@ -402,28 +386,25 @@ struct adapter *padapter
 		MGN_MCS0, MGN_MCS1, MGN_MCS2, MGN_MCS3, MGN_MCS4, MGN_MCS5, MGN_MCS6, MGN_MCS7
 	};
 	for (path = RF_PATH_A; path < RF_PATH_MAX; ++path) {
-		for (txNum = RF_1TX; txNum < RF_MAX_TX_NUM; ++txNum) {
-			/*  CCK */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_11M);
-			for (i = 0; i < ARRAY_SIZE(cckRates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, cckRates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, cckRates[i], value - base);
-			}
-
-			/*  OFDM */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_54M);
-			for (i = 0; i < sizeof(ofdmRates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, ofdmRates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, ofdmRates[i], value - base);
-			}
+		/*  CCK */
+		base = PHY_GetTxPowerByRate(padapter, path, MGN_11M);
+		for (i = 0; i < ARRAY_SIZE(cckRates); ++i) {
+			value = PHY_GetTxPowerByRate(padapter, path, cckRates[i]);
+			PHY_SetTxPowerByRate(padapter, path, cckRates[i], value - base);
+		}
 
-			/*  HT MCS0~7 */
-			base = PHY_GetTxPowerByRate(padapter, path, txNum, MGN_MCS7);
-			for (i = 0; i < sizeof(mcs0_7Rates); ++i) {
-				value = PHY_GetTxPowerByRate(padapter, path, txNum, mcs0_7Rates[i]);
-				PHY_SetTxPowerByRate(padapter, path, txNum, mcs0_7Rates[i], value - base);
-			}
+		/*  OFDM */
+		base = PHY_GetTxPowerByRate(padapter, path, MGN_54M);
+		for (i = 0; i < sizeof(ofdmRates); ++i) {
+			value = PHY_GetTxPowerByRate(padapter, path, ofdmRates[i]);
+			PHY_SetTxPowerByRate(padapter, path, ofdmRates[i], value - base);
+		}
 
+		/*  HT MCS0~7 */
+		base = PHY_GetTxPowerByRate(padapter, path, MGN_MCS7);
+		for (i = 0; i < sizeof(mcs0_7Rates); ++i) {
+			value = PHY_GetTxPowerByRate(padapter, path, mcs0_7Rates[i]);
+			PHY_SetTxPowerByRate(padapter, path, mcs0_7Rates[i], value - base);
 		}
 	}
 }
@@ -590,9 +571,7 @@ u8 PHY_GetRateIndexOfTxPowerByRate(u8 Rate)
 	return index;
 }
 
-s8 PHY_GetTxPowerByRate(
-	struct adapter *padapter, u8 RFPath, u8 TxNum, u8 Rate
-)
+s8 PHY_GetTxPowerByRate(struct adapter *padapter, u8 RFPath, u8 Rate)
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 	s8 value = 0;
@@ -605,20 +584,16 @@ s8 PHY_GetTxPowerByRate(
 	if (RFPath >= RF_PATH_MAX)
 		return value;
 
-	if (TxNum >= RF_MAX_TX_NUM)
-		return value;
-
 	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return value;
 
-	return pHalData->TxPwrByRateOffset[RFPath][TxNum][rateIndex];
+	return pHalData->TxPwrByRateOffset[RFPath][rateIndex];
 
 }
 
 void PHY_SetTxPowerByRate(
 	struct adapter *padapter,
 	u8 RFPath,
-	u8 TxNum,
 	u8 Rate,
 	s8 Value
 )
@@ -629,13 +604,10 @@ void PHY_SetTxPowerByRate(
 	if (RFPath >= RF_PATH_MAX)
 		return;
 
-	if (TxNum >= RF_MAX_TX_NUM)
-		return;
-
 	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE)
 		return;
 
-	pHalData->TxPwrByRateOffset[RFPath][TxNum][rateIndex] = Value;
+	pHalData->TxPwrByRateOffset[RFPath][rateIndex] = Value;
 }
 
 void PHY_SetTxPowerLevelByPath(struct adapter *Adapter, u8 channel, u8 path)
@@ -797,11 +769,11 @@ void PHY_ConvertTxPowerLimitToPowerIndex(struct adapter *Adapter)
 					for (rfPath = RF_PATH_A; rfPath < MAX_RF_PATH_NUM; ++rfPath) {
 						if (pHalData->odmpriv.PhyRegPgValueType == PHY_REG_PG_EXACT_VALUE) {
 							if (rateSection == 2) /*  HT 1T */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, HT_MCS0_MCS7);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, HT_MCS0_MCS7);
 							else if (rateSection == 1) /*  OFDM */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, OFDM);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, OFDM);
 							else if (rateSection == 0) /*  CCK */
-								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, RF_1TX, CCK);
+								BW40PwrBasedBm2_4G = PHY_GetTxPowerByRateBase(Adapter, rfPath, CCK);
 						} else
 							BW40PwrBasedBm2_4G = Adapter->registrypriv.RegPowerBase * 2;
 
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
index 0f71b1adea40..1df42069bd5c 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
@@ -118,7 +118,6 @@ void odm_ConfigBB_AGC_8723B(
 void odm_ConfigBB_PHY_REG_PG_8723B(
 	struct dm_odm_t *pDM_Odm,
 	u32 RfPath,
-	u32 TxNum,
 	u32 Addr,
 	u32 Bitmask,
 	u32 Data
@@ -127,7 +126,7 @@ void odm_ConfigBB_PHY_REG_PG_8723B(
 	if (Addr == 0xfe || Addr == 0xffe)
 		msleep(50);
 	else {
-		PHY_StoreTxPowerByRate(pDM_Odm->Adapter, RfPath, TxNum, Addr, Bitmask, Data);
+		PHY_StoreTxPowerByRate(pDM_Odm->Adapter, RfPath, Addr, Bitmask, Data);
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
index b8d4c2aa6d4d..fba7053ee3e1 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
@@ -24,13 +24,8 @@ void odm_ConfigBB_AGC_8723B(struct dm_odm_t *pDM_Odm,
 			    u32 Data
 );
 
-void odm_ConfigBB_PHY_REG_PG_8723B(struct dm_odm_t *pDM_Odm,
-				   u32 RfPath,
-				   u32 TxNum,
-				   u32 Addr,
-				   u32 Bitmask,
-				   u32 Data
-);
+void odm_ConfigBB_PHY_REG_PG_8723B(struct dm_odm_t *pDM_Odm, u32 RfPath, u32 Addr,
+				   u32 Bitmask, u32 Data);
 
 void odm_ConfigBB_PHY_8723B(struct dm_odm_t *pDM_Odm,
 			    u32 Addr,
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 4b362320ce31..a3bff27af523 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -538,7 +538,7 @@ u8 PHY_GetTxPowerIndex(
 	s8 txPower = 0, powerDiffByRate = 0, limit = 0;
 
 	txPower = (s8) PHY_GetTxPowerIndexBase(padapter, RFPath, Rate, BandWidth, Channel);
-	powerDiffByRate = PHY_GetTxPowerByRate(padapter, RF_PATH_A, RF_1TX, Rate);
+	powerDiffByRate = PHY_GetTxPowerByRate(padapter, RF_PATH_A, Rate);
 
 	limit = phy_get_tx_pwr_lmt(
 		padapter,
diff --git a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
index 637089fed93d..cb7c7ed74146 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
@@ -18,15 +18,6 @@ enum rate_section {
 	HT_MCS0_MCS7,
 };
 
-enum {
-	RF_1TX = 0,
-	RF_2TX,
-	RF_3TX,
-	RF_4TX,
-	RF_MAX_TX_NUM,
-	RF_TX_NUM_NONIMPLEMENT,
-};
-
 #define MAX_POWER_INDEX			0x3F
 
 enum {
@@ -63,7 +54,7 @@ struct bb_register_def {
 
 };
 
-u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath, u8 TxNum,
+u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
 			    enum rate_section RateSection);
 
 u8 PHY_GetRateSectionIndexOfTxPowerByRate(struct adapter *padapter, u32	RegAddr,
@@ -78,9 +69,9 @@ u8 PHY_GetRateIndexOfTxPowerByRate(u8 Rate);
 void PHY_SetTxPowerIndexByRateSection(struct adapter *padapter, u8 RFPath, u8 Channel,
 				      u8 RateSection);
 
-s8 PHY_GetTxPowerByRate(struct adapter *padapter, u8 RFPath, u8	TxNum, u8 RateIndex);
+s8 PHY_GetTxPowerByRate(struct adapter *padapter, u8 RFPath, u8 RateIndex);
 
-void PHY_SetTxPowerByRate(struct adapter *padapter, u8 RFPath, u8 TxNum, u8 Rate,
+void PHY_SetTxPowerByRate(struct adapter *padapter, u8 RFPath, u8 Rate,
 			  s8 Value);
 
 void PHY_SetTxPowerLevelByPath(struct adapter *Adapter, u8 channel, u8 path);
@@ -91,7 +82,7 @@ void PHY_SetTxPowerIndexByRateArray(struct adapter *padapter, u8 RFPath,
 
 void PHY_InitTxPowerByRate(struct adapter *padapter);
 
-void PHY_StoreTxPowerByRate(struct adapter *padapter, u32 RfPath, u32 TxNum,
+void PHY_StoreTxPowerByRate(struct adapter *padapter, u32 RfPath,
 			    u32	RegAddr, u32 BitMask, u32 Data);
 
 void PHY_TxPowerByRateConfiguration(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index 2bd7a7151db1..7bbf81ce3045 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -241,9 +241,7 @@ struct hal_com_data {
 	/*  CCK = 0 OFDM = 1/2 HT-MCS 0-15 =3/4/56 VHT =7/8/9/10/11 */
 	u8 TxPwrByRateTable;
 	u8 TxPwrByRateBand;
-	s8 TxPwrByRateOffset[TX_PWR_BY_RATE_NUM_RF]
-			    [TX_PWR_BY_RATE_NUM_RF]
-			    [TX_PWR_BY_RATE_NUM_RATE];
+	s8 TxPwrByRateOffset[TX_PWR_BY_RATE_NUM_RF][TX_PWR_BY_RATE_NUM_RATE];
 	/*  */
 
 	/* 2 Power Limit Table */
@@ -261,9 +259,7 @@ struct hal_com_data {
 						[MAX_RF_PATH_NUM];
 
 	/*  Store the original power by rate value of the base of each rate section of rf path A & B */
-	u8 TxPwrByRateBase2_4G[TX_PWR_BY_RATE_NUM_RF]
-						[TX_PWR_BY_RATE_NUM_RF]
-						[MAX_BASE_NUM_IN_PHY_REG_PG_2_4G];
+	u8 TxPwrByRateBase2_4G[TX_PWR_BY_RATE_NUM_RF][MAX_BASE_NUM_IN_PHY_REG_PG_2_4G];
 
 	/*  For power group */
 	u8 PwrGroupHT20[RF_PATH_MAX_92C_88E][CHANNEL_MAX_NUMBER];
-- 
2.20.1

