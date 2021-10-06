Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D315423A42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhJFJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbhJFJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:12:12 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA9C061755
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:10:20 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mY2wK-0006je-LZ; Wed, 06 Oct 2021 11:10:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] staging: r8188eu: Odm PatchID is always 0
Date:   Wed,  6 Oct 2021 11:09:48 +0200
Message-Id: <20211006090949.1694-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211006090949.1694-1-martin@kaiser.cx>
References: <20211006090949.1694-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PatchID is a copy of the hal customer id that is always 0.

Remove PatchID from struct odm_dm_struct and the code that is
executed only for PatchID != 0.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c          |  7 ---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 60 +++++++---------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c  |  1 -
 drivers/staging/r8188eu/include/odm.h      |  2 -
 4 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index bc49dc856a60..d15d62927db1 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -262,9 +262,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_EXT_TRSW:
 		pDM_Odm->ExtTRSW = (u8)Value;
 		break;
-	case	ODM_CMNINFO_PATCH_ID:
-		pDM_Odm->PatchID = (u8)Value;
-		break;
 	case	ODM_CMNINFO_BINHCT_TEST:
 		pDM_Odm->bInHctTest = (bool)Value;
 		break;
@@ -863,10 +860,6 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 	u8 Rssi_Up_bound = 30;
 	u8 Rssi_Low_bound = 25;
 
-	if (pDM_Odm->PatchID == 40) { /* RT_CID_819x_FUNAI_TV */
-		Rssi_Up_bound = 50;
-		Rssi_Low_bound = 45;
-	}
 	if (pDM_PSTable->initialize == 0) {
 		pDM_PSTable->reg_874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord) & 0x1CC000) >> 14;
 		pDM_PSTable->reg_c70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord) & BIT(3)) >> 3;
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 2383f965f689..c9c2bc35906c 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -43,17 +43,7 @@ static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 Cu
 
 static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 {
-	if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 10))
-		return 0;
-	else
-		return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
-}
-
-/* pMgntInfo->CustomerID == RT_CID_819x_Lenovo */
-static u8 odm_SQ_process_patch_RT_CID_819x_Lenovo(struct odm_dm_struct *dm_odm,
-	u8 isCCKrate, u8 PWDB_ALL, u8 path, u8 RSSI)
-{
-	return 0;
+	return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
 }
 
 static u8 odm_evm_db_to_percentage(s8 value)
@@ -158,9 +148,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		if (pPktinfo->bPacketMatchBSSID) {
 			u8 SQ, SQ_rpt;
 
-			if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 19)) {
-				SQ = odm_SQ_process_patch_RT_CID_819x_Lenovo(dm_odm, isCCKrate, PWDB_ALL, 0, 0);
-			} else if (pPhyInfo->RxPWDBAll > 40 && !dm_odm->bInHctTest) {
+			if (pPhyInfo->RxPWDBAll > 40 && !dm_odm->bInHctTest) {
 				SQ = 100;
 			} else {
 				SQ_rpt = pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all;
@@ -212,14 +200,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			/* Get Rx snr value in DB */
 			pPhyInfo->RxSNR[i] = (s32)(pPhyStaRpt->path_rxsnr[i] / 2);
 			dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i] / 2);
-
-			/* Record Signal Strength for next packet */
-			if (pPktinfo->bPacketMatchBSSID) {
-				if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 19)) {
-					if (i == RF_PATH_A)
-						pPhyInfo->SignalQuality = odm_SQ_process_patch_RT_CID_819x_Lenovo(dm_odm, isCCKrate, PWDB_ALL, i, RSSI);
-				}
-			}
 		}
 		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
@@ -232,26 +212,22 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		pPhyInfo->RxPower = rx_pwr_all;
 		pPhyInfo->RecvSignalPower = rx_pwr_all;
 
-		if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 19)) {
-			/* do nothing */
-		} else {
-			/*  (3)EVM of HT rate */
-			if (pPktinfo->Rate >= DESC92C_RATEMCS8 && pPktinfo->Rate <= DESC92C_RATEMCS15)
-				Max_spatial_stream = 2; /* both spatial stream make sense */
-			else
-				Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
-
-			for (i = 0; i < Max_spatial_stream; i++) {
-				/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
-				/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
-				/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
-				EVM = odm_evm_db_to_percentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
-
-				if (pPktinfo->bPacketMatchBSSID) {
-					if (i == RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
-						pPhyInfo->SignalQuality = (u8)(EVM & 0xff);
-					pPhyInfo->RxMIMOSignalQuality[i] = (u8)(EVM & 0xff);
-				}
+		/*  (3)EVM of HT rate */
+		if (pPktinfo->Rate >= DESC92C_RATEMCS8 && pPktinfo->Rate <= DESC92C_RATEMCS15)
+			Max_spatial_stream = 2; /* both spatial stream make sense */
+		else
+			Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
+
+		for (i = 0; i < Max_spatial_stream; i++) {
+			/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
+			/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
+			/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
+			EVM = odm_evm_db_to_percentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
+
+			if (pPktinfo->bPacketMatchBSSID) {
+				if (i == RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
+					pPhyInfo->SignalQuality = (u8)(EVM & 0xff);
+				pPhyInfo->RxMIMOSignalQuality[i] = (u8)(EVM & 0xff);
 			}
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 1bfe12b5fefb..d5fd97268145 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -52,7 +52,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
 
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_PATCH_ID, 0);
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
 
 	if (hal_data->rf_type == RF_1T1R)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 48d383f91c16..2a65c3dfad3a 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -285,7 +285,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_EXT_LNA,		/* true */
 	ODM_CMNINFO_EXT_PA,
 	ODM_CMNINFO_EXT_TRSW,
-	ODM_CMNINFO_PATCH_ID,		/* CUSTOMER ID */
 	ODM_CMNINFO_BINHCT_TEST,
 	ODM_CMNINFO_BWIFI_TEST,
 	ODM_CMNINFO_SMART_CONCURRENT,
@@ -693,7 +692,6 @@ struct odm_dm_struct {
 	u8	ExtPA;
 	/*  with external TRSW  NO/Yes = 0/1 */
 	u8	ExtTRSW;
-	u8	PatchID; /* Customer ID */
 	bool	bInHctTest;
 	bool	bWIFITest;
 
-- 
2.20.1

