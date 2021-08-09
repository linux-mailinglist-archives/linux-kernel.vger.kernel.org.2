Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21B83E4A40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhHIQvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhHIQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91303C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i4so4855364wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXi2HDmb/lkdzR+59uW066wb/DPjrIXx/F/3Td9PBkU=;
        b=dTqe15PZipcvLmzcjytdk37ioXPeMGVXvTxhsTUZTdX4epUBv7xJ3PXQVAwg7euu54
         LkBZfeC3GLpX2pgE5NBiPoWP+JYc/wxPqen6lT5+1t2zCXEAHHpbwbWk2TIVfVMtkss2
         DDq/+jfinaB4Q4H2rzntWH9W/0FZrv3FzQlyRQpauJUhUddWk7klm0Q2+RrthV+ULrRf
         /GPgJJGGQKnijLy3gRGbo+Pa1TMlfJ+QDiGoVQ3oJiWokFUOK+XB+5Cr9QLFcd5f3bnh
         +t0EJQAEp532yZw+lxqc+bOm+ZS4BHV504MwazbQhioG7rnVgyF/pCuA6fqQV7VUF2RT
         HF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXi2HDmb/lkdzR+59uW066wb/DPjrIXx/F/3Td9PBkU=;
        b=nQDgK78S57ZVKcXaGy9qdRkrxDcZUZTQHE/vt7p3uGAGU83DRxfEZHQNxDcpObsnPe
         rdyxfRNdha/t+Rbiiy9VWYuVYp8Z1DbVCzznAyJQg9Ez7yPR1lfkNYyCeQFRC7UvUykK
         GlpnKvSuyyVtI+H+iyxnyIs6tHtGdg2pUdR72LKR/S0N7SSf3a3he0r4dLTaMSRtUWKn
         46lsHfMOd89ADpymosjBHewASLEtyZlN8cxo20s5usG47W3U7RQvRru2LYzD5/4QvBsi
         SYNBm9lp97tawFHJ0XQam0tfrMarmgaq3UeZNWjpu32jRhwN+1RwO8L8B5DUpvLp9iEM
         LoxQ==
X-Gm-Message-State: AOAM532BUbqmHJL8cOyMiE5zhgixHbMo6n8FeCqejh0pKlmLaJv7GMmC
        VnyHpwuxTNoJrvzbygzLkwk=
X-Google-Smtp-Source: ABdhPJzLjR6tlFBlgUGGalcRD1vKTsHMpvW3Lb45aEv0rA1/rRBsPxPVidS+2RdLIJyAjM2p5MJ95g==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr3865404wrr.203.1628527847987;
        Mon, 09 Aug 2021 09:50:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 02/17] staging: r8188eu: remove unnecessary parentheses in hal dir
Date:   Mon,  9 Aug 2021 18:49:52 +0200
Message-Id: <20210809165007.23204-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in the hal directory reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  8 +--
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 16 +++---
 drivers/staging/r8188eu/hal/hal_intf.c        |  2 +-
 drivers/staging/r8188eu/hal/odm.c             | 44 +++++++--------
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 10 ++--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 56 +++++++++----------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 30 +++++-----
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  8 +--
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   | 12 ++--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  | 10 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 32 +++++------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  6 +-
 13 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 5307b10c1bc3..57839f8629ac 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -487,7 +487,7 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 	u8 WirelessMode = 0xFF; /* invalid value */
 	u8 max_rate_idx = 0x13; /* MCS7 */
 	if (dm_odm->pWirelessMode)
-		WirelessMode = *(dm_odm->pWirelessMode);
+		WirelessMode = *dm_odm->pWirelessMode;
 
 	if (WirelessMode != 0xFF) {
 		if (WirelessMode & ODM_WM_N24G)
@@ -580,7 +580,7 @@ void ODM_RA_UpdateRateInfo_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rate
 	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return;
 
-	pRaInfo = &(dm_odm->RAInfo[macid]);
+	pRaInfo = &dm_odm->RAInfo[macid];
 	pRaInfo->RateID = RateID;
 	pRaInfo->RateMask = RateMask;
 	pRaInfo->SGIEnable = SGIEnable;
@@ -594,7 +594,7 @@ void ODM_RA_SetRSSI_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rssi)
 	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return;
 
-	pRaInfo = &(dm_odm->RAInfo[macid]);
+	pRaInfo = &dm_odm->RAInfo[macid];
 	pRaInfo->RssiStaRA = Rssi;
 }
 
@@ -622,7 +622,7 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 		else
 			valid = (1 << MacId) & macid_entry0;
 
-		pRAInfo = &(dm_odm->RAInfo[MacId]);
+		pRAInfo = &dm_odm->RAInfo[MacId];
 		if (valid) {
 			pRAInfo->RTY[0] = (u16)GET_TX_REPORT_TYPE1_RERTY_0(pBuffer);
 			pRAInfo->RTY[1] = (u16)GET_TX_REPORT_TYPE1_RERTY_1(pBuffer);
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 166adaac371a..68e7c31cc720 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -86,7 +86,7 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 static void odm_TxPwrTrackSetPwr88E(struct odm_dm_struct *dm_odm)
 {
 	if (dm_odm->BbSwingFlagOfdm || dm_odm->BbSwingFlagCck) {
-		PHY_SetTxPowerLevel8188E(dm_odm->Adapter, *(dm_odm->pChannel));
+		PHY_SetTxPowerLevel8188E(dm_odm->Adapter, *dm_odm->pChannel);
 		dm_odm->BbSwingFlagOfdm = false;
 		dm_odm->BbSwingFlagCck	= false;
 	}
@@ -318,7 +318,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][4];
 					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][5];
 
-					if ((X != 0) && (*(dm_odm->pBandType) == ODM_BAND_2_4G)) {
+					if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
 						if ((X & 0x00000200) != 0)	/* consider minus */
 							X = X | 0xFFFFFC00;
 						ele_A = ((X * ele_D)>>8)&0x000003FF;
@@ -883,7 +883,7 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 							};
 
 	u32 retryCount = 9;
-	if (*(dm_odm->mp_mode) == 1)
+	if (*dm_odm->mp_mode == 1)
 		retryCount = 9;
 	else
 		retryCount = 2;
@@ -1086,7 +1086,7 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	struct mpt_context *pMptCtx = &(adapt->mppriv.MptCtx);
+	struct mpt_context *pMptCtx = &adapt->mppriv.MptCtx;
 	s32 result[4][8];	/* last is final result */
 	u8 i, final_candidate, Indexforchannel;
 	bool pathaok, pathbok;
@@ -1108,7 +1108,7 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
 		return;
 
-	if (*(dm_odm->mp_mode) == 1) {
+	if (*dm_odm->mp_mode == 1) {
 		singletone = pMptCtx->bSingleTone;
 		carrier_sup = pMptCtx->bCarrierSuppression;
 	}
@@ -1219,9 +1219,9 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 	u32 timeout = 2000, timecount = 0;
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
-	struct mpt_context *pMptCtx = &(adapt->mppriv.MptCtx);
+	struct mpt_context *pMptCtx = &adapt->mppriv.MptCtx;
 
-	if (*(dm_odm->mp_mode) == 1) {
+	if (*dm_odm->mp_mode == 1) {
 		singletone = pMptCtx->bSingleTone;
 		carrier_sup = pMptCtx->bCarrierSuppression;
 	}
@@ -1231,7 +1231,7 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 	if (singletone || carrier_sup)
 		return;
 
-	while (*(dm_odm->pbScanInProcess) && timecount < timeout) {
+	while (*dm_odm->pbScanInProcess && timecount < timeout) {
 		ODM_delay_ms(50);
 		timecount += 50;
 	}
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index e07d430dc7ba..87c3bd58b63b 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -248,7 +248,7 @@ void rtw_hal_free_recv_priv(struct adapter *adapt)
 
 void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
-	struct mlme_priv *pmlmepriv = &(adapt->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
 #ifdef CONFIG_88EU_AP_MODE
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 0deeb21c8006..99b61a6c3a7a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -205,7 +205,7 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 		odm_DIG(pDM_Odm);
 	odm_CCKPacketDetectionThresh(pDM_Odm);
 
-	if (*(pDM_Odm->pbPowerSaving))
+	if (*pDM_Odm->pbPowerSaving)
 		return;
 
 	odm_RefreshRateAdaptiveMask(pDM_Odm);
@@ -440,13 +440,13 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 	u8 i;
 	struct sta_info *pEntry;
 
-	if (*(pDM_Odm->pBandWidth) == ODM_BW40M) {
-		if (*(pDM_Odm->pSecChOffset) == 1)
-			pDM_Odm->ControlChannel = *(pDM_Odm->pChannel) - 2;
-		else if (*(pDM_Odm->pSecChOffset) == 2)
-			pDM_Odm->ControlChannel = *(pDM_Odm->pChannel) + 2;
+	if (*pDM_Odm->pBandWidth == ODM_BW40M) {
+		if (*pDM_Odm->pSecChOffset == 1)
+			pDM_Odm->ControlChannel = *pDM_Odm->pChannel - 2;
+		else if (*pDM_Odm->pSecChOffset == 2)
+			pDM_Odm->ControlChannel = *pDM_Odm->pChannel + 2;
 	} else {
-		pDM_Odm->ControlChannel = *(pDM_Odm->pChannel);
+		pDM_Odm->ControlChannel = *pDM_Odm->pChannel;
 	}
 
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
@@ -485,7 +485,7 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 				if (pDM_Odm->SupportICType != ODM_RTL8188E)
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 		} else if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
-			switch (*(pDM_Odm->pOnePathCCA)) {
+			switch (*pDM_Odm->pOnePathCCA) {
 			case ODM_CCA_2R:
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 					if (pDM_Odm->SupportICType != ODM_RTL8188E)
@@ -602,7 +602,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	if ((!(pDM_Odm->SupportAbility&ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility&ODM_BB_FA_CNT)))
 		return;
 
-	if (*(pDM_Odm->pbScanInProcess))
+	if (*pDM_Odm->pbScanInProcess)
 		return;
 
 	/* add by Neil Chen to avoid PSD is processing */
@@ -610,8 +610,8 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 		return;
 
 	if (pDM_Odm->SupportICType == ODM_RTL8192D) {
-		if (*(pDM_Odm->pMacPhyMode) == ODM_DMSP) {
-			if (*(pDM_Odm->pbMasterOfDMSP)) {
+		if (*pDM_Odm->pMacPhyMode == ODM_DMSP) {
+			if (*pDM_Odm->pbMasterOfDMSP) {
 				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
 				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
 				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
@@ -621,7 +621,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
 			}
 		} else {
-			if (*(pDM_Odm->pBandType) == ODM_BAND_5G) {
+			if (*pDM_Odm->pBandType == ODM_BAND_5G) {
 				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
 				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
 				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
@@ -791,7 +791,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 {
 	u32 ret_value;
-	struct false_alarm_stats *FalseAlmCnt = &(pDM_Odm->FalseAlmCnt);
+	struct false_alarm_stats *FalseAlmCnt = &pDM_Odm->FalseAlmCnt;
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
 		return;
@@ -884,7 +884,7 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
 {
 	u8 CurCCK_CCAThres;
-	struct false_alarm_stats *FalseAlmCnt = &(pDM_Odm->FalseAlmCnt);
+	struct false_alarm_stats *FalseAlmCnt = &pDM_Odm->FalseAlmCnt;
 
 	if (!(pDM_Odm->SupportAbility & (ODM_BB_CCK_PD|ODM_BB_FA_CNT)))
 		return;
@@ -1116,7 +1116,7 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 			} else if (rssi_level == DM_RATR_STA_MIDDLE) {
 				rate_bitmap = 0x000ff000;
 			} else {
-				if (*(pDM_Odm->pBandWidth) == ODM_BW40M)
+				if (*pDM_Odm->pBandWidth == ODM_BW40M)
 					rate_bitmap = 0x000ff015;
 				else
 					rate_bitmap = 0x000ff005;
@@ -1127,7 +1127,7 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 			} else if (rssi_level == DM_RATR_STA_MIDDLE) {
 				rate_bitmap = 0x0f8ff000;
 			} else {
-				if (*(pDM_Odm->pBandWidth) == ODM_BW40M)
+				if (*pDM_Odm->pBandWidth == ODM_BW40M)
 					rate_bitmap = 0x0f8ff015;
 				else
 					rate_bitmap = 0x0f8ff005;
@@ -1402,7 +1402,7 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 				/*  Report every sta's RSSI to FW */
 			} else {
 				ODM_RA_SetRSSI_8188E(
-				&(pHalData->odmpriv), (PWDB_rssi[i]&0xFF), (u8)((PWDB_rssi[i]>>16) & 0xFF));
+				&pHalData->odmpriv, (PWDB_rssi[i]&0xFF), (u8)((PWDB_rssi[i]>>16) & 0xFF));
 			}
 		}
 	}
@@ -1456,7 +1456,7 @@ void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->RFCalibrateInfo.bTXPowerTracking = true;
 	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
 	pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = false;
-	if (*(pDM_Odm->mp_mode) != 1)
+	if (*pDM_Odm->mp_mode != 1)
 		pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
 	MSG_88E("pDM_Odm TxPowerTrackControl = %d\n", pDM_Odm->RFCalibrateInfo.TxPowerTrackControl);
 
@@ -1624,11 +1624,11 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
 	u64	cur_rx_bytes = 0;
 	u8	bbtchange = false;
 	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
-	struct xmit_priv		*pxmitpriv = &(Adapter->xmitpriv);
-	struct recv_priv		*precvpriv = &(Adapter->recvpriv);
+	struct xmit_priv		*pxmitpriv = &Adapter->xmitpriv;
+	struct recv_priv		*precvpriv = &Adapter->recvpriv;
 	struct registry_priv	*pregpriv = &Adapter->registrypriv;
-	struct mlme_ext_priv	*pmlmeext = &(Adapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pregpriv->wifi_spec == 1)
 		goto dm_CheckEdcaTurbo_EXIT;
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 792284eac01f..02e44403fd31 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -16,7 +16,7 @@ static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 {
 	u32	value32;
 
-	if (*(dm_odm->mp_mode) == 1) {
+	if (*dm_odm->mp_mode == 1) {
 		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
 		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0); /*  disable HW AntDiv */
 		ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);  /*  1:CG, 0:CS */
@@ -44,7 +44,7 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 {
 	u32	value32;
 
-	if (*(dm_odm->mp_mode) == 1) {
+	if (*dm_odm->mp_mode == 1) {
 		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
 		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0); /*  disable HW AntDiv */
 		ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, 0); /* Default RX   (0/1) */
@@ -83,7 +83,7 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
 	u32	AntCombination = 2;
 
-	if (*(dm_odm->mp_mode) == 1)
+	if (*dm_odm->mp_mode == 1)
 		return;
 
 	for (i = 0; i < 6; i++) {
@@ -327,7 +327,7 @@ void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
 
 void odm_PrimaryCCA_Init(struct odm_dm_struct *dm_odm)
 {
-	struct dyn_primary_cca *PrimaryCCA = &(dm_odm->DM_PriCCA);
+	struct dyn_primary_cca *PrimaryCCA = &dm_odm->DM_PriCCA;
 
 	PrimaryCCA->DupRTS_flag = 0;
 	PrimaryCCA->intf_flag = 0;
@@ -338,7 +338,7 @@ void odm_PrimaryCCA_Init(struct odm_dm_struct *dm_odm)
 
 bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *dm_odm)
 {
-	struct dyn_primary_cca *PrimaryCCA = &(dm_odm->DM_PriCCA);
+	struct dyn_primary_cca *PrimaryCCA = &dm_odm->DM_PriCCA;
 
 	return	PrimaryCCA->DupRTS_flag;
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 712307bc674f..02eda8fae25c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -181,7 +181,7 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 	DBG_88E("%s=> mac_id:%d, raid:%d, ra_bitmap=0x%x, shortGIrate=0x%02x\n",
 		__func__, macid, raid, bitmap, shortGIrate);
 
-	ODM_RA_UpdateRateInfo_8188E(&(haldata->odmpriv), macid, raid, bitmap, shortGIrate);
+	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, shortGIrate);
 }
 
 void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
@@ -247,18 +247,18 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	__le16 *fctrl;
 	u32 rate_len, pktlen;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 
 	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
-	memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
 	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
@@ -300,7 +300,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pktlen);
 
 	/*  DS parameter set */
-	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pktlen);
+	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pktlen);
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 		u32 ATIMWindow;
@@ -330,14 +330,14 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 {
 	struct rtw_ieee80211_hdr	*pwlanhdr;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	__le16 *fctrl;
 
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
 	/*  Frame control. */
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 	SetPwrMgt(fctrl);
 	SetFrameSubType(pframe, WIFI_PSPOLL);
@@ -346,10 +346,10 @@ static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	SetDuration(pframe, (pmlmeinfo->aid | 0xc000));
 
 	/*  BSSID. */
-	memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+	memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
 	/*  TA. */
-	memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
 
 	*pLength = 16;
 }
@@ -367,8 +367,8 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	u32 pktlen;
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
 	struct wlan_network		*cur_network = &pmlmepriv->cur_network;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
@@ -380,21 +380,21 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	switch (cur_network->network.InfrastructureMode) {
 	case Ndis802_11Infrastructure:
 		SetToDs(fctrl);
-		memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
-		memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
+		memcpy(pwlanhdr->addr1, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
+		memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
 		memcpy(pwlanhdr->addr3, StaAddr, ETH_ALEN);
 		break;
 	case Ndis802_11APMode:
 		SetFrDs(fctrl);
 		memcpy(pwlanhdr->addr1, StaAddr, ETH_ALEN);
-		memcpy(pwlanhdr->addr2, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
-		memcpy(pwlanhdr->addr3, myid(&(adapt->eeprompriv)), ETH_ALEN);
+		memcpy(pwlanhdr->addr2, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
+		memcpy(pwlanhdr->addr3, myid(&adapt->eeprompriv), ETH_ALEN);
 		break;
 	case Ndis802_11IBSS:
 	default:
 		memcpy(pwlanhdr->addr1, StaAddr, ETH_ALEN);
-		memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
-		memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+		memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
+		memcpy(pwlanhdr->addr3, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 		break;
 	}
 
@@ -425,16 +425,16 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	__le16 *fctrl;
 	u8 *mac, *bssid;
 	u32 pktlen;
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
 
 	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
 
-	mac = myid(&(adapt->eeprompriv));
+	mac = myid(&adapt->eeprompriv);
 	bssid = cur_network->MacAddress;
 
-	fctrl = &(pwlanhdr->frame_ctl);
+	fctrl = &pwlanhdr->frame_ctl;
 	*(fctrl) = 0;
 	memcpy(pwlanhdr->addr1, StaAddr, ETH_ALEN);
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
@@ -582,8 +582,8 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 {
 	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
-	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	bool	bSendBeacon = false;
 	bool	bcn_valid = false;
 	u8 DLBcnCount = 0;
@@ -678,7 +678,7 @@ void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
 {
 #ifdef CONFIG_88EU_P2P
 	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
-	struct wifidirect_info	*pwdinfo = &(adapt->wdinfo);
+	struct wifidirect_info	*pwdinfo = &adapt->wdinfo;
 	struct P2P_PS_Offload_t	*p2p_ps_offload = &haldata->p2p_ps_offload;
 	u8 i;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 7ac4257d7ebe..fab385774400 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -30,7 +30,7 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 {
 	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
-	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 	u8 cut_ver, fab_ver;
 
 	/*  Init Value */
@@ -79,7 +79,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
 	struct pwrctrl_priv *pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
-	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
 	int i;
 
@@ -103,17 +103,17 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
 
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_TX_UNI, &(Adapter->xmitpriv.tx_bytes));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_RX_UNI, &(Adapter->recvpriv.rx_bytes));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &(pmlmeext->cur_wireless_mode));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &(hal_data->nCur40MhzPrimeSC));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_MODE, &(Adapter->securitypriv.dot11PrivacyAlgrthm));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &(hal_data->CurrentChannelBW));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_CHNL, &(hal_data->CurrentChannel));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_NET_CLOSED, &(Adapter->net_closed));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_MP_MODE, &(Adapter->registrypriv.mp_mode));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SCAN, &(pmlmepriv->bScanInProcess));
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_POWER_SAVING, &(pwrctrlpriv->bpower_saving));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_TX_UNI, &Adapter->xmitpriv.tx_bytes);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_RX_UNI, &Adapter->recvpriv.rx_bytes);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &pmlmeext->cur_wireless_mode);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &hal_data->nCur40MhzPrimeSC);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_MODE, &Adapter->securitypriv.dot11PrivacyAlgrthm);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &hal_data->CurrentChannelBW);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_CHNL, &hal_data->CurrentChannel);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_NET_CLOSED, &Adapter->net_closed);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_MP_MODE, &Adapter->registrypriv.mp_mode);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SCAN, &pmlmepriv->bScanInProcess);
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_POWER_SAVING, &pwrctrlpriv->bpower_saving);
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 
 	for (i = 0; i < NUM_STA; i++)
@@ -124,7 +124,7 @@ void rtl8188e_InitHalDm(struct adapter *Adapter)
 {
 	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
-	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 
 	dm_InitGPIOSetting(Adapter);
 	pdmpriv->DM_Type = DM_Type_ByDriver;
@@ -216,7 +216,7 @@ u8 AntDivBeforeLink8188E(struct adapter *Adapter)
 	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 	struct sw_ant_switch *dm_swat_tbl = &dm_odm->DM_SWAT_Table;
-	struct mlme_priv *pmlmepriv = &(Adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
 
 	/*  Condition that does not need to use antenna diversity. */
 	if (hal_data->AntDivCfg == 0)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index cc24684945ef..f6d4029eae22 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -11,7 +11,7 @@
 s32 Hal_SetPowerTracking(struct adapter *padapter, u8 enable)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
-	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+	struct odm_dm_struct *pDM_Odm = &pHalData->odmpriv;
 
 	if (!netif_running(padapter->pnetdev))
 		return _FAIL;
@@ -30,7 +30,7 @@ s32 Hal_SetPowerTracking(struct adapter *padapter, u8 enable)
 void Hal_GetPowerTracking(struct adapter *padapter, u8 *enable)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
-	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+	struct odm_dm_struct *pDM_Odm = &pHalData->odmpriv;
 
 	*enable = pDM_Odm->RFCalibrateInfo.TxPowerTrackControl;
 }
@@ -135,7 +135,7 @@ void Hal_MPT_CCKTxPowerAdjustbyIndex(struct adapter *pAdapter, bool beven)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
 	struct mpt_context *pMptCtx = &pAdapter->mppriv.MptCtx;
-	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+	struct odm_dm_struct *pDM_Odm = &pHalData->odmpriv;
 	s32		TempCCk;
 	u8		CCK_index, CCK_index_old = 0;
 	u8		Action = 0;	/* 0: no action, 1: even->odd, 2:odd->even */
@@ -209,7 +209,7 @@ void Hal_SetChannel(struct adapter *pAdapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
 	struct mp_priv	*pmp = &pAdapter->mppriv;
-	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+	struct odm_dm_struct *pDM_Odm = &pHalData->odmpriv;
 	u8		eRFPath;
 	u8		channel = pmp->channel;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 6628ad1eb1bb..60fa7e4f5f2c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -186,7 +186,7 @@ i		 *  Currently, we cannot fully disable driver dynamic
 		}
 	}
 	for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
-		ptr = (u8 *)(&(TxAGC[idx1]));
+		ptr = (u8 *)(&TxAGC[idx1]);
 		for (idx2 = 0; idx2 < 4; idx2++) {
 			if (*ptr > RF6052_MAX_TX_PWR)
 				*ptr = RF6052_MAX_TX_PWR;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 51fd30b25a5f..2c573e86d3f8 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -74,21 +74,21 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 /*		Initialize all LED_871x objects. */
 void rtl8188eu_InitSwLeds(struct adapter *padapter)
 {
-	struct led_priv *pledpriv = &(padapter->ledpriv);
+	struct led_priv *pledpriv = &padapter->ledpriv;
 
 	pledpriv->LedControlHandler = LedControl8188eu;
 
-	InitLed871x(padapter, &(pledpriv->SwLed0), LED_PIN_LED0);
+	InitLed871x(padapter, &pledpriv->SwLed0, LED_PIN_LED0);
 
-	InitLed871x(padapter, &(pledpriv->SwLed1), LED_PIN_LED1);
+	InitLed871x(padapter, &pledpriv->SwLed1, LED_PIN_LED1);
 }
 
 /*	Description: */
 /*		DeInitialize all LED_819xUsb objects. */
 void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv	*ledpriv = &padapter->ledpriv;
 
-	DeInitLed871x(&(ledpriv->SwLed0));
-	DeInitLed871x(&(ledpriv->SwLed1));
+	DeInitLed871x(&ledpriv->SwLed0);
+	DeInitLed871x(&ledpriv->SwLed1);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index e4aa0b3bc7b7..a38e10b16233 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -170,7 +170,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
 	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	int	bmcst = IS_MCAST(pattrib->ra);
 
 	if (adapt->registrypriv.mp_mode == 0) {
@@ -489,23 +489,23 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 	switch (pfirstframe->attrib.priority) {
 	case 1:
 	case 2:
-		ptxservq = &(psta->sta_xmitpriv.bk_q);
+		ptxservq = &psta->sta_xmitpriv.bk_q;
 		phwxmit = pxmitpriv->hwxmits + 3;
 		break;
 	case 4:
 	case 5:
-		ptxservq = &(psta->sta_xmitpriv.vi_q);
+		ptxservq = &psta->sta_xmitpriv.vi_q;
 		phwxmit = pxmitpriv->hwxmits + 1;
 		break;
 	case 6:
 	case 7:
-		ptxservq = &(psta->sta_xmitpriv.vo_q);
+		ptxservq = &psta->sta_xmitpriv.vo_q;
 		phwxmit = pxmitpriv->hwxmits;
 		break;
 	case 0:
 	case 3:
 	default:
-		ptxservq = &(psta->sta_xmitpriv.be_q);
+		ptxservq = &psta->sta_xmitpriv.be_q;
 		phwxmit = pxmitpriv->hwxmits + 2;
 		break;
 	}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 6ecadba17963..2bce4334ba68 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -409,7 +409,7 @@ static void _InitBeaconMaxError(struct adapter *Adapter, bool		InfraMode)
 
 static void _InitHWLed(struct adapter *Adapter)
 {
-	struct led_priv *pledpriv = &(Adapter->ledpriv);
+	struct led_priv *pledpriv = &Adapter->ledpriv;
 
 	if (pledpriv->LedStrategy != HW_LED)
 		return;
@@ -1053,7 +1053,7 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	struct recv_buf *precvbuf;
 	uint	status;
 	struct intf_hdl *pintfhdl = &Adapter->iopriv.intf;
-	struct recv_priv *precvpriv = &(Adapter->recvpriv);
+	struct recv_priv *precvpriv = &Adapter->recvpriv;
 	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
 
 	_read_port = pintfhdl->io_ops._read_port;
@@ -1092,7 +1092,7 @@ static unsigned int rtl8188eu_inirp_deinit(struct adapter *Adapter)
 /*  */
 static void _ReadLEDSetting(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
 {
-	struct led_priv *pledpriv = &(Adapter->ledpriv);
+	struct led_priv *pledpriv = &Adapter->ledpriv;
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 
 	pledpriv->bRegUseLed = true;
@@ -1428,7 +1428,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u64	tsf;
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-			struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue,
 							  pmlmeinfo->bcn_interval * 1024) - 1024; /* us */
@@ -1486,7 +1486,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(4));
 		} else { /* sitesurvey done */
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-			struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 			if ((is_client_associated_to_ap(Adapter)) ||
 			    ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE)) {
@@ -1556,7 +1556,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 u1bAIFS, aSifsTime;
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-			struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 			rtw_write8(Adapter, REG_SLOT, val[0]);
 
@@ -1980,19 +1980,19 @@ GetHalDefVar8188EUsb(
 	case HAL_DEF_RA_DECISION_RATE:
 		{
 			u8 MacID = *((u8 *)pValue);
-			*((u8 *)pValue) = ODM_RA_GetDecisionRate_8188E(&(haldata->odmpriv), MacID);
+			*((u8 *)pValue) = ODM_RA_GetDecisionRate_8188E(&haldata->odmpriv, MacID);
 		}
 		break;
 	case HAL_DEF_RA_SGI:
 		{
 			u8 MacID = *((u8 *)pValue);
-			*((u8 *)pValue) = ODM_RA_GetShortGI_8188E(&(haldata->odmpriv), MacID);
+			*((u8 *)pValue) = ODM_RA_GetShortGI_8188E(&haldata->odmpriv, MacID);
 		}
 		break;
 	case HAL_DEF_PT_PWR_STATUS:
 		{
 			u8 MacID = *((u8 *)pValue);
-			*((u8 *)pValue) = ODM_RA_GetHwPwrStatus_8188E(&(haldata->odmpriv), MacID);
+			*((u8 *)pValue) = ODM_RA_GetHwPwrStatus_8188E(&haldata->odmpriv, MacID);
 		}
 		break;
 	case HW_VAR_MAX_RX_AMPDU_FACTOR:
@@ -2089,8 +2089,8 @@ static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_l
 	struct sta_info	*psta;
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
 
 	if (mac_id >= NUM_STA) /* CAM_SIZE */
 		return;
@@ -2103,8 +2103,8 @@ static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_l
 		networkType = judge_network_type(adapt, cur_network->SupportedRates, supportRateNum) & 0xf;
 		raid = networktype_to_raid(networkType);
 		mask = update_supported_rate(cur_network->SupportedRates, supportRateNum);
-		mask |= (pmlmeinfo->HT_enable) ? update_MSC_rate(&(pmlmeinfo->HT_caps)) : 0;
-		if (support_short_GI(adapt, &(pmlmeinfo->HT_caps)))
+		mask |= (pmlmeinfo->HT_enable) ? update_MSC_rate(&pmlmeinfo->HT_caps) : 0;
+		if (support_short_GI(adapt, &pmlmeinfo->HT_caps))
 			shortGIrate = true;
 		break;
 	case 1:/* for broadcast/multicast */
@@ -2150,7 +2150,7 @@ static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_l
 		/* to do ,for 8188E-SMIC */
 		rtl8188e_set_raid_cmd(adapt, mask);
 	} else {
-		ODM_RA_UpdateRateInfo_8188E(&(haldata->odmpriv),
+		ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv,
 				mac_id,
 				raid,
 				mask,
@@ -2165,8 +2165,8 @@ static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_l
 static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 {
 	u32 value32;
-	struct mlme_ext_priv	*pmlmeext = &(adapt->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 bcn_ctrl_reg			= REG_BCN_CTRL;
 	/* reset TSF, enable update TSF, correcting TSF On Beacon */
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 80d44aafd8ea..012846ea8263 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -279,12 +279,12 @@ static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbu
 	}
 
 	/*  HISR */
-	memcpy(&(haldata->IntArray[0]), &(pbuf[USB_INTR_CONTENT_HISR_OFFSET]), 4);
-	memcpy(&(haldata->IntArray[1]), &(pbuf[USB_INTR_CONTENT_HISRE_OFFSET]), 4);
+	memcpy(&haldata->IntArray[0], &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
+	memcpy(&haldata->IntArray[1], &pbuf[USB_INTR_CONTENT_HISRE_OFFSET], 4);
 
 	/*  C2H Event */
 	if (pbuf[0] != 0)
-		memcpy(&(haldata->C2hArray[0]), &(pbuf[USB_INTR_CONTENT_C2H_OFFSET]), 16);
+		memcpy(&haldata->C2hArray[0], &pbuf[USB_INTR_CONTENT_C2H_OFFSET], 16);
 }
 
 static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
-- 
2.32.0

