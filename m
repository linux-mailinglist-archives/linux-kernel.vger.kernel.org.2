Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2626A3EDEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhHPU4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhHPU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:56:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i6so28448693edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9W1fabcxWyUXhC6xeawg5uH5kbI+xD1DktiGWeneoMM=;
        b=eO+lBvdgUYYf4LkD9MRQMqszRIgNT7YWOnbI51NIxhoAOpTLG+fqBIy0uHOWoe6SxG
         5Veo1fTYd047qvt5/vuhO3RqE8BzaZrP0DmeaayCxSz5rs8oInUWiM2/ZNdAeGnRQheI
         hVwM+baWpNSFxG3YXKNxJVNcUQh1D4zC0/INBn9uuwQFoUXOLEwP6znRRnei9TleUVR/
         zMtTw0Y6jqAKlPNB44jPp5Q4NQbG7Pia3SkYsrGYN9HtXY62cbNpkDkfL7kWecMurH1N
         pvpH47ZDS1zBGfb6nPFwFnLXGV08xNIABC8CldCjrolLfgLmyZ/hro4sV9nLBga/2prQ
         HLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9W1fabcxWyUXhC6xeawg5uH5kbI+xD1DktiGWeneoMM=;
        b=qDU8ovkjz91jSM8oVCqmn1RmsDNpHeKUxE6QkmKbhM21/uvO2KOIkGrLSVfzGj95ih
         +VAcu8r1aT3YWRkxTu/D2R17H2WRmLOAufsAm6oMJVS+CZWsN1CIA5rCmoYl1gC/e8kk
         LDTjryIoTxbpASAyfXCSwqxnn/Lw8iB4ElSiAPPhFYUSOPnBwwdEsKMd2+nHrtHXGcyM
         1BPMQqKyoEsjxBepWUPiNbPzQLkKE6X7YfWQvGcnfpnL75BIDhoCXrUMC1nVkoU2iKEj
         ShZaNhT1KTpdKbUT7aR2qFWZQMxAcSbx6C1/UucgQY6UiaoudoGtez2mJPK0Cta0YfLQ
         USgg==
X-Gm-Message-State: AOAM5321AvT6VTCeTqZE7OZEvi9cPiYhoiMMCx4UvccejYHc5xNAV7cc
        +h9uIvQSifFJ0uLbJ1W4TE0=
X-Google-Smtp-Source: ABdhPJxV9lXcee66Ghn/6has3eSoOrmd+e0yawcSn2TVw7+6dAe6gOb6vWNk2fw8oHwSOzeRhPI+OQ==
X-Received: by 2002:aa7:cac6:: with SMTP id l6mr71295edt.37.1629147371468;
        Mon, 16 Aug 2021 13:56:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id ck17sm36967edb.88.2021.08.16.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:56:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: clean up spacing style issues in hal dir, part 2
Date:   Mon, 16 Aug 2021 22:55:10 +0200
Message-Id: <20210816205511.20068-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816205511.20068-1-straube.linux@gmail.com>
References: <20210816205511.20068-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues reported by checkpatch in the next 10
files in the hal directory.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited before semicolon
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  84 +++----
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  70 +++---
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |   8 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  74 +++---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 238 +++++++++---------
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  40 +--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  60 ++---
 7 files changed, 287 insertions(+), 287 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 530357b58d66..ada22a526fee 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -15,7 +15,7 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 	else if (AntPower >= 0)
 		return	100;
 	else
-		return 100+AntPower;
+		return 100 + AntPower;
 }
 
 /*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
@@ -39,7 +39,7 @@ static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 Cu
 		if (CurrSig >= 51 && CurrSig <= 100)
 			RetSig = 100;
 		else if (CurrSig >= 41 && CurrSig <= 50)
-			RetSig = 80 + ((CurrSig - 40)*2);
+			RetSig = 80 + ((CurrSig - 40) * 2);
 		else if (CurrSig >= 31 && CurrSig <= 40)
 			RetSig = 66 + (CurrSig - 30);
 		else if (CurrSig >= 21 && CurrSig <= 30)
@@ -121,44 +121,44 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 		cck_highpwr = dm_odm->bCckHighPower;
 
-		cck_agc_rpt =  pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a ;
+		cck_agc_rpt =  pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a;
 
 		/* 2011.11.28 LukeLee: 88E use different LNA & VGA gain table */
 		/* The RSSI formula should be modified according to the gain table */
 		/* In 88E, cck_highpwr is always set to 1 */
-		if (dm_odm->SupportICType & (ODM_RTL8188E|ODM_RTL8812)) {
+		if (dm_odm->SupportICType & (ODM_RTL8188E | ODM_RTL8812)) {
 			LNA_idx = ((cck_agc_rpt & 0xE0) >> 5);
 			VGA_idx = (cck_agc_rpt & 0x1F);
 			switch (LNA_idx) {
 			case 7:
 				if (VGA_idx <= 27)
-					rx_pwr_all = -100 + 2*(27-VGA_idx); /* VGA_idx = 27~2 */
+					rx_pwr_all = -100 + 2 * (27 - VGA_idx); /* VGA_idx = 27~2 */
 				else
 					rx_pwr_all = -100;
 				break;
 			case 6:
-				rx_pwr_all = -48 + 2*(2-VGA_idx); /* VGA_idx = 2~0 */
+				rx_pwr_all = -48 + 2 * (2 - VGA_idx); /* VGA_idx = 2~0 */
 				break;
 			case 5:
-				rx_pwr_all = -42 + 2*(7-VGA_idx); /* VGA_idx = 7~5 */
+				rx_pwr_all = -42 + 2 * (7 - VGA_idx); /* VGA_idx = 7~5 */
 				break;
 			case 4:
-				rx_pwr_all = -36 + 2*(7-VGA_idx); /* VGA_idx = 7~4 */
+				rx_pwr_all = -36 + 2 * (7 - VGA_idx); /* VGA_idx = 7~4 */
 				break;
 			case 3:
-				rx_pwr_all = -24 + 2*(7-VGA_idx); /* VGA_idx = 7~0 */
+				rx_pwr_all = -24 + 2 * (7 - VGA_idx); /* VGA_idx = 7~0 */
 				break;
 			case 2:
 				if (cck_highpwr)
-					rx_pwr_all = -12 + 2*(5-VGA_idx); /* VGA_idx = 5~0 */
+					rx_pwr_all = -12 + 2 * (5 - VGA_idx); /* VGA_idx = 5~0 */
 				else
-					rx_pwr_all = -6 + 2*(5-VGA_idx);
+					rx_pwr_all = -6 + 2 * (5 - VGA_idx);
 				break;
 			case 1:
-					rx_pwr_all = 8-2*VGA_idx;
+					rx_pwr_all = 8 - 2 * VGA_idx;
 				break;
 			case 0:
-					rx_pwr_all = 14-2*VGA_idx;
+					rx_pwr_all = 14 - 2 * VGA_idx;
 				break;
 			default:
 				break;
@@ -167,7 +167,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
 			if (!cck_highpwr) {
 				if (PWDB_ALL >= 80)
-					PWDB_ALL = ((PWDB_ALL-80)<<1)+((PWDB_ALL-80)>>1)+80;
+					PWDB_ALL = ((PWDB_ALL - 80) << 1) + ((PWDB_ALL - 80) >> 1) + 80;
 				else if ((PWDB_ALL <= 78) && (PWDB_ALL >= 20))
 					PWDB_ALL += 3;
 				if (PWDB_ALL > 100)
@@ -175,7 +175,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			}
 		} else {
 			if (!cck_highpwr) {
-				report = (cck_agc_rpt & 0xc0)>>6;
+				report = (cck_agc_rpt & 0xc0) >> 6;
 				switch (report) {
 				/*  03312009 modified by cosa */
 				/*  Modify the RF RNA gain value to -40, -20, -2, 14 by Jenyu's suggestion */
@@ -194,19 +194,19 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 					break;
 				}
 			} else {
-				report = (cck_agc_rpt & 0x60)>>5;
+				report = (cck_agc_rpt & 0x60) >> 5;
 				switch (report) {
 				case 0x3:
-					rx_pwr_all = -46 - ((cck_agc_rpt & 0x1f)<<1) ;
+					rx_pwr_all = -46 - ((cck_agc_rpt & 0x1f) << 1);
 					break;
 				case 0x2:
-					rx_pwr_all = -26 - ((cck_agc_rpt & 0x1f)<<1);
+					rx_pwr_all = -26 - ((cck_agc_rpt & 0x1f) << 1);
 					break;
 				case 0x1:
-					rx_pwr_all = -12 - ((cck_agc_rpt & 0x1f)<<1);
+					rx_pwr_all = -12 - ((cck_agc_rpt & 0x1f) << 1);
 					break;
 				case 0x0:
-					rx_pwr_all = 16 - ((cck_agc_rpt & 0x1f)<<1);
+					rx_pwr_all = 16 - ((cck_agc_rpt & 0x1f) << 1);
 					break;
 				}
 			}
@@ -215,13 +215,13 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 			/* Modification for ext-LNA board */
 			if (dm_odm->BoardType == ODM_BOARD_HIGHPWR) {
-				if ((cck_agc_rpt>>7) == 0) {
-					PWDB_ALL = (PWDB_ALL > 94) ? 100 : (PWDB_ALL+6);
+				if ((cck_agc_rpt >> 7) == 0) {
+					PWDB_ALL = (PWDB_ALL > 94) ? 100 : (PWDB_ALL + 6);
 				} else {
 					if (PWDB_ALL > 38)
 						PWDB_ALL -= 16;
 					else
-						PWDB_ALL = (PWDB_ALL <= 16) ? (PWDB_ALL>>2) : (PWDB_ALL-12);
+						PWDB_ALL = (PWDB_ALL <= 16) ? (PWDB_ALL >> 2) : (PWDB_ALL - 12);
 				}
 
 				/* CCK modification */
@@ -254,7 +254,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 				else if (SQ_rpt < 20)
 					SQ = 100;
 				else
-					SQ = ((64-SQ_rpt) * 100) / 44;
+					SQ = ((64 - SQ_rpt) * 100) / 44;
 			}
 			pPhyInfo->SignalQuality = SQ;
 			pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = SQ;
@@ -270,7 +270,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			if (dm_odm->RFPathRxEnable & BIT(i))
 				rf_rx_num++;
 
-			rx_pwr[i] = ((pPhyStaRpt->path_agc[i].gain & 0x3F)*2) - 110;
+			rx_pwr[i] = ((pPhyStaRpt->path_agc[i].gain & 0x3F) * 2) - 110;
 			if (i == RF_PATH_A)
 				adapt->signal_strength = rx_pwr[i];
 
@@ -294,8 +294,8 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			pPhyInfo->RxMIMOSignalStrength[i] = (u8)RSSI;
 
 			/* Get Rx snr value in DB */
-			pPhyInfo->RxSNR[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
-			dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
+			pPhyInfo->RxSNR[i] = (s32)(pPhyStaRpt->path_rxsnr[i] / 2);
+			dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i] / 2);
 
 			/* Record Signal Strength for next packet */
 			if (pPktinfo->bPacketMatchBSSID) {
@@ -390,8 +390,8 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 		if (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV) {
 			if (pDM_FatTable->FAT_State == FAT_TRAINING_STATE) {
 				if (pPktinfo->bPacketToSelf) {
-					antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2<<2) |
-							(pDM_FatTable->antsel_rx_keep_1<<1) |
+					antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
+							(pDM_FatTable->antsel_rx_keep_1 << 1) |
 							pDM_FatTable->antsel_rx_keep_0;
 					pDM_FatTable->antSumRSSI[antsel_tr_mux] += pPhyInfo->RxPWDBAll;
 					pDM_FatTable->antRSSIcnt[antsel_tr_mux]++;
@@ -399,8 +399,8 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			}
 		} else if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
 			if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
-				antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2<<2) |
-						(pDM_FatTable->antsel_rx_keep_1<<1) | pDM_FatTable->antsel_rx_keep_0;
+				antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
+						(pDM_FatTable->antsel_rx_keep_1 << 1) | pDM_FatTable->antsel_rx_keep_0;
 				ODM_AntselStatistics_88E(dm_odm, antsel_tr_mux, pPktinfo->StationID, pPhyInfo->RxPWDBAll);
 			}
 		}
@@ -439,17 +439,17 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			} else {
 				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedOFDM) {
 					UndecoratedSmoothedOFDM =
-							(((UndecoratedSmoothedOFDM)*(Rx_Smooth_Factor-1)) +
+							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor - 1)) +
 							(RSSI_Ave)) / (Rx_Smooth_Factor);
 					UndecoratedSmoothedOFDM = UndecoratedSmoothedOFDM + 1;
 				} else {
 					UndecoratedSmoothedOFDM =
-							(((UndecoratedSmoothedOFDM)*(Rx_Smooth_Factor-1)) +
+							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor - 1)) +
 							(RSSI_Ave)) / (Rx_Smooth_Factor);
 				}
 			}
 
-			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap<<1) | BIT(0);
+			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap << 1) | BIT(0);
 
 		} else {
 			RSSI_Ave = pPhyInfo->RxPWDBAll;
@@ -460,16 +460,16 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			} else {
 				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedCCK) {
 					UndecoratedSmoothedCCK =
-							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor-1)) +
+							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor - 1)) +
 							pPhyInfo->RxPWDBAll) / Rx_Smooth_Factor;
 					UndecoratedSmoothedCCK = UndecoratedSmoothedCCK + 1;
 				} else {
 					UndecoratedSmoothedCCK =
-							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor-1)) +
+							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor - 1)) +
 							pPhyInfo->RxPWDBAll) / Rx_Smooth_Factor;
 				}
 			}
-			pEntry->rssi_stat.PacketMap = pEntry->rssi_stat.PacketMap<<1;
+			pEntry->rssi_stat.PacketMap = pEntry->rssi_stat.PacketMap << 1;
 		}
 		/* 2011.07.28 LukeLee: modified to prevent unstable CCK RSSI */
 		if (pEntry->rssi_stat.ValidBit >= 64)
@@ -478,16 +478,16 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			pEntry->rssi_stat.ValidBit++;
 
 		for (i = 0; i < pEntry->rssi_stat.ValidBit; i++)
-			OFDM_pkt += (u8)(pEntry->rssi_stat.PacketMap>>i)&BIT(0);
+			OFDM_pkt += (u8)(pEntry->rssi_stat.PacketMap >> i) & BIT(0);
 
 		if (pEntry->rssi_stat.ValidBit == 64) {
-			Weighting = ((OFDM_pkt<<4) > 64) ? 64 : (OFDM_pkt<<4);
-			UndecoratedSmoothedPWDB = (Weighting*UndecoratedSmoothedOFDM+(64-Weighting)*UndecoratedSmoothedCCK)>>6;
+			Weighting = ((OFDM_pkt << 4) > 64) ? 64 : (OFDM_pkt << 4);
+			UndecoratedSmoothedPWDB = (Weighting * UndecoratedSmoothedOFDM + (64 - Weighting) * UndecoratedSmoothedCCK) >> 6;
 		} else {
 			if (pEntry->rssi_stat.ValidBit != 0)
 				UndecoratedSmoothedPWDB = (OFDM_pkt * UndecoratedSmoothedOFDM +
-							  (pEntry->rssi_stat.ValidBit-OFDM_pkt) *
-							  UndecoratedSmoothedCCK)/pEntry->rssi_stat.ValidBit;
+							  (pEntry->rssi_stat.ValidBit - OFDM_pkt) *
+							  UndecoratedSmoothedCCK) / pEntry->rssi_stat.ValidBit;
 			else
 				UndecoratedSmoothedPWDB = 0;
 		}
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index b6b95649f3af..10fe1ecc0342 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -8,7 +8,7 @@ void ODM_DIG_LowerBound_88E(struct odm_dm_struct *dm_odm)
 	struct rtw_dig *pDM_DigTable = &dm_odm->DM_DigTable;
 
 	if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
-		pDM_DigTable->rx_gain_range_min = (u8) pDM_DigTable->AntDiv_RSSI_max;
+		pDM_DigTable->rx_gain_range_min = (u8)pDM_DigTable->AntDiv_RSSI_max;
 	/* If only one Entry connected */
 }
 
@@ -25,9 +25,9 @@ static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
-	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT(23)|BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9)|BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
 	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
 	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(22), 1);	/* Regb2c[22]=1'b0	disable CS/CG switch */
 	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
@@ -47,15 +47,15 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 	if (*dm_odm->mp_mode == 1) {
 		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
 		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT(7), 0); /*  disable HW AntDiv */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5)|BIT(4)|BIT(3), 0); /* Default RX   (0/1) */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), 0); /* Default RX   (0/1) */
 		return;
 	}
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
-	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT(23)|BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9)|BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
 	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
 	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
 	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
@@ -70,8 +70,8 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 
 	/* antenna mapping table */
 	if (!dm_odm->bIsMPChip) { /* testchip */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(10)|BIT(9)|BIT(8), 1);	/* Reg858[10:8]=3'b001 */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(13)|BIT(12)|BIT(11), 2);	/* Reg858[13:11]=3'b010 */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
 	} else { /* MPchip */
 		ODM_SetBBReg(dm_odm, ODM_REG_ANT_MAPPING1_11N, bMaskDWord, 0x0201);	/* Reg914=3'b010, Reg915=3'b001 */
 	}
@@ -97,15 +97,15 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, 0x4c, bMaskDWord);
-	ODM_SetMACReg(dm_odm, 0x4c, bMaskDWord, value32|(BIT(23)|BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	ODM_SetMACReg(dm_odm, 0x4c, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	value32 = ODM_GetMACReg(dm_odm,  0x7B4, bMaskDWord);
-	ODM_SetMACReg(dm_odm, 0x7b4, bMaskDWord, value32|(BIT(16)|BIT(17))); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
+	ODM_SetMACReg(dm_odm, 0x7b4, bMaskDWord, value32 | (BIT(16) | BIT(17))); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
 
 	/* Match MAC ADDR */
 	ODM_SetMACReg(dm_odm, 0x7b4, 0xFFFF, 0);
 	ODM_SetMACReg(dm_odm, 0x7b0, bMaskDWord, 0);
 
-	ODM_SetBBReg(dm_odm, 0x870, BIT(9)|BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, 0x870, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
 	ODM_SetBBReg(dm_odm, 0x864, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
 	ODM_SetBBReg(dm_odm, 0xb2c, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
 	ODM_SetBBReg(dm_odm, 0xb2c, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
@@ -114,23 +114,23 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	/* antenna mapping table */
 	if (AntCombination == 2) {
 		if (!dm_odm->bIsMPChip) { /* testchip */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(10)|BIT(9)|BIT(8), 1);	/* Reg858[10:8]=3'b001 */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(13)|BIT(12)|BIT(11), 2);	/* Reg858[13:11]=3'b010 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
 		} else { /* MPchip */
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 1);
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 2);
 		}
 	} else if (AntCombination == 7) {
 		if (!dm_odm->bIsMPChip) { /* testchip */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(10)|BIT(9)|BIT(8), 0);	/* Reg858[10:8]=3'b000 */
-			ODM_SetBBReg(dm_odm, 0x858, BIT(13)|BIT(12)|BIT(11), 1);	/* Reg858[13:11]=3'b001 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(10) | BIT(9) | BIT(8), 0);	/* Reg858[10:8]=3'b000 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(13) | BIT(12) | BIT(11), 1);	/* Reg858[13:11]=3'b001 */
 			ODM_SetBBReg(dm_odm, 0x878, BIT(16), 0);
-			ODM_SetBBReg(dm_odm, 0x858, BIT(15)|BIT(14), 2);	/* Reg878[0],Reg858[14:15])=3'b010 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(19)|BIT(18)|BIT(17), 3);/* Reg878[3:1]=3b'011 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(22)|BIT(21)|BIT(20), 4);/* Reg878[6:4]=3b'100 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(25)|BIT(24)|BIT(23), 5);/* Reg878[9:7]=3b'101 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(28)|BIT(27)|BIT(26), 6);/* Reg878[12:10]=3b'110 */
-			ODM_SetBBReg(dm_odm, 0x878, BIT(31)|BIT(30)|BIT(29), 7);/* Reg878[15:13]=3b'111 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT(15) | BIT(14), 2);	/* Reg878[0],Reg858[14:15])=3'b010 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(19) | BIT(18) | BIT(17), 3);/* Reg878[3:1]=3b'011 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(22) | BIT(21) | BIT(20), 4);/* Reg878[6:4]=3b'100 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(25) | BIT(24) | BIT(23), 5);/* Reg878[9:7]=3b'101 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(28) | BIT(27) | BIT(26), 6);/* Reg878[12:10]=3b'110 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT(31) | BIT(30) | BIT(29), 7);/* Reg878[15:13]=3b'111 */
 		} else { /* MPchip */
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 0);
 			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 1);
@@ -145,11 +145,11 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 
 	/* Default Ant Setting when no fast training */
 	ODM_SetBBReg(dm_odm, 0x80c, BIT(21), 1); /* Reg80c[21]=1'b1		from TX Info */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(5)|BIT(4)|BIT(3), 0);	/* Default RX */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(8)|BIT(7)|BIT(6), 1);	/* Optional RX */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(5) | BIT(4) | BIT(3), 0);	/* Default RX */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(8) | BIT(7) | BIT(6), 1);	/* Optional RX */
 
 	/* Enter Traing state */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(2)|BIT(1)|BIT(0), (AntCombination-1));	/* Reg864[2:0]=3'd6	ant combination=reg864[2:0]+1 */
+	ODM_SetBBReg(dm_odm, 0x864, BIT(2) | BIT(1) | BIT(0), (AntCombination - 1));	/* Reg864[2:0]=3'd6	ant combination=reg864[2:0]+1 */
 	ODM_SetBBReg(dm_odm, 0xc50, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
 }
 
@@ -181,13 +181,13 @@ void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
 		}
 
 		if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5)|BIT(4)|BIT(3), DefaultAnt);	/* Default RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8)|BIT(7)|BIT(6), OptionalAnt);		/* Optional RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_ANTSEL_CTRL_11N, BIT(14)|BIT(13)|BIT(12), DefaultAnt);	/* Default TX */
-			ODM_SetMACReg(dm_odm, ODM_REG_RESP_TX_11N, BIT(6)|BIT(7), DefaultAnt);	/* Resp Tx */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_ANTSEL_CTRL_11N, BIT(14) | BIT(13) | BIT(12), DefaultAnt);	/* Default TX */
+			ODM_SetMACReg(dm_odm, ODM_REG_RESP_TX_11N, BIT(6) | BIT(7), DefaultAnt);	/* Resp Tx */
 		} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5)|BIT(4)|BIT(3), DefaultAnt);	/* Default RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8)|BIT(7)|BIT(6), OptionalAnt);		/* Optional RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
 		}
 	}
 	dm_fat_tbl->RxIdleAnt = Ant;
@@ -204,9 +204,9 @@ static void odm_UpdateTxAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant, u32 MacId)
 		TargetAnt = MAIN_ANT_CG_TRX;
 	else
 		TargetAnt = AUX_ANT_CG_TRX;
-	dm_fat_tbl->antsel_a[MacId] = TargetAnt&BIT(0);
-	dm_fat_tbl->antsel_b[MacId] = (TargetAnt&BIT(1))>>1;
-	dm_fat_tbl->antsel_c[MacId] = (TargetAnt&BIT(2))>>2;
+	dm_fat_tbl->antsel_a[MacId] = TargetAnt & BIT(0);
+	dm_fat_tbl->antsel_b[MacId] = (TargetAnt & BIT(1)) >> 1;
+	dm_fat_tbl->antsel_c[MacId] = (TargetAnt & BIT(2)) >> 2;
 }
 
 void ODM_SetTxAntByTxInfo_88E(struct odm_dm_struct *dm_odm, u8 *pDesc, u8 macId)
@@ -255,8 +255,8 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 		pEntry = dm_odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(pEntry)) {
 			/* 2 Caculate RSSI per Antenna */
-			Main_RSSI = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ? (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
-			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i]/dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
+			Main_RSSI = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ? (dm_fat_tbl->MainAnt_Sum[i] / dm_fat_tbl->MainAnt_Cnt[i]) : 0;
+			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i] / dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
 			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
 			/* 2 Select MaxRSSI for DIG */
 			LocalMaxRSSI = (Main_RSSI > Aux_RSSI) ? Main_RSSI : Aux_RSSI;
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index ec8158e37cb3..1bc3b49cd67f 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -29,17 +29,17 @@ void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
 {
 	u32  content = 0x1000; /*  RF_Content: radioa_txt */
-	u32 maskforPhySet = (u32)(content&0xE000);
+	u32 maskforPhySet = (u32)(content & 0xE000);
 
-	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_A, Addr|maskforPhySet);
+	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_A, Addr | maskforPhySet);
 }
 
 void odm_ConfigRF_RadioB_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
 {
 	u32  content = 0x1001; /*  RF_Content: radiob_txt */
-	u32 maskforPhySet = (u32)(content&0xE000);
+	u32 maskforPhySet = (u32)(content & 0xE000);
 
-	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_B, Addr|maskforPhySet);
+	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_B, Addr | maskforPhySet);
 }
 
 void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 6cbda9ab6e3f..6afdebd4f367 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -80,26 +80,26 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 		*(u8 *)(&h2c_cmd) = ElementID;
 
 		if (CmdLen <= 3) {
-			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, CmdLen);
+			memcpy((u8 *)(&h2c_cmd) + 1, pCmdBuffer, CmdLen);
 		} else {
-			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, 3);
-			ext_cmd_len = CmdLen-3;
-			memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer+3, ext_cmd_len);
+			memcpy((u8 *)(&h2c_cmd) + 1, pCmdBuffer, 3);
+			ext_cmd_len = CmdLen - 3;
+			memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer + 3, ext_cmd_len);
 
 			/* Write Ext command */
 			msgbox_ex_addr = REG_HMEBOX_EXT_0 + (h2c_box_num * RTL88E_EX_MESSAGE_BOX_SIZE);
 			for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++) {
-				rtw_write8(adapt, msgbox_ex_addr+cmd_idx, *((u8 *)(&h2c_cmd_ex)+cmd_idx));
+				rtw_write8(adapt, msgbox_ex_addr + cmd_idx, *((u8 *)(&h2c_cmd_ex) + cmd_idx));
 			}
 		}
 		/*  Write command */
 		msgbox_addr = REG_HMEBOX_0 + (h2c_box_num * RTL88E_MESSAGE_BOX_SIZE);
 		for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++) {
-			rtw_write8(adapt, msgbox_addr+cmd_idx, *((u8 *)(&h2c_cmd)+cmd_idx));
+			rtw_write8(adapt, msgbox_addr + cmd_idx, *((u8 *)(&h2c_cmd) + cmd_idx));
 		}
 		bcmd_down = true;
 
-		haldata->LastHMEBoxNum = (h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
+		haldata->LastHMEBoxNum = (h2c_box_num + 1) % RTL88E_MAX_H2C_BOX_NUMS;
 
 	} while ((!bcmd_down) && (retry_cnts--));
 
@@ -157,24 +157,24 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 
 	u8 macid, init_rate, raid, shortGIrate = false;
 
-	macid = arg&0x1f;
+	macid = arg & 0x1f;
 
-	raid = (bitmap>>28) & 0x0f;
+	raid = (bitmap >> 28) & 0x0f;
 	bitmap &= 0x0fffffff;
 
 	if (rssi_level != DM_RATR_STA_INIT)
 		bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, macid, bitmap, rssi_level);
 
-	bitmap |= ((raid<<28)&0xf0000000);
+	bitmap |= ((raid << 28) & 0xf0000000);
 
-	init_rate = get_highest_rate_idx(bitmap&0x0fffffff)&0x3f;
+	init_rate = get_highest_rate_idx(bitmap & 0x0fffffff) & 0x3f;
 
-	shortGIrate = (arg&BIT(5)) ? true : false;
+	shortGIrate = (arg & BIT(5)) ? true : false;
 
 	if (shortGIrate)
 		init_rate |= BIT(6);
 
-	raid = (bitmap>>28) & 0x0f;
+	raid = (bitmap >> 28) & 0x0f;
 
 	bitmap &= 0x0fffffff;
 
@@ -216,7 +216,7 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 		break;
 	}
 
-	H2CSetPwrMode.SmartPS_RLBM = (((pwrpriv->smart_ps<<4)&0xf0) | (RLBM & 0x0f));
+	H2CSetPwrMode.SmartPS_RLBM = (((pwrpriv->smart_ps << 4) & 0xf0) | (RLBM & 0x0f));
 
 	H2CSetPwrMode.AwakeInterval = 1;
 
@@ -235,7 +235,7 @@ void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
 {
 	u8 opmode, macid;
 	u16 mst_rpt = le16_to_cpu(mstatus_rpt);
-	opmode = (u8) mst_rpt;
+	opmode = (u8)mst_rpt;
 	macid = (u8)(mst_rpt >> 8);
 
 	DBG_88E("### %s: MStatus=%x MACID=%d\n", __func__, opmode, macid);
@@ -283,9 +283,9 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	pframe += 2;
 	pktlen += 2;
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		pktlen += cur_network->IELength - sizeof(struct ndis_802_11_fixed_ie);
-		memcpy(pframe, cur_network->IEs+sizeof(struct ndis_802_11_fixed_ie), pktlen);
+		memcpy(pframe, cur_network->IEs + sizeof(struct ndis_802_11_fixed_ie), pktlen);
 
 		goto _ConstructBeacon;
 	}
@@ -302,7 +302,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	/*  DS parameter set */
 	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&cur_network->Configuration.DSConfig, &pktlen);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		u32 ATIMWindow;
 		/*  IBSS Parameter Set... */
 		ATIMWindow = 0;
@@ -516,43 +516,43 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	PageNum += PageNeed;
 	haldata->FwRsvdPageStartOffset = PageNum;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (2) ps-poll *1 page */
 	RsvdPageLoc.LocPsPoll = PageNum;
 	ConstructPSPoll(adapt, &ReservedPagePacket[BufIndex], &PSPollLength);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], PSPollLength, true, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], PSPollLength, true, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + PSPollLength);
 	PageNum += PageNeed;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (3) null data * 1 page */
 	RsvdPageLoc.LocNullData = PageNum;
 	ConstructNullFunctionData(adapt, &ReservedPagePacket[BufIndex], &NullDataLength, get_my_bssid(&pmlmeinfo->network), false, 0, 0, false);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], NullDataLength, false, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], NullDataLength, false, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + NullDataLength);
 	PageNum += PageNeed;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (4) probe response * 1page */
 	RsvdPageLoc.LocProbeRsp = PageNum;
 	ConstructProbeRsp(adapt, &ReservedPagePacket[BufIndex], &ProbeRspLength, get_my_bssid(&pmlmeinfo->network), false);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], ProbeRspLength, false, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], ProbeRspLength, false, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + ProbeRspLength);
 	PageNum += PageNeed;
 
-	BufIndex += PageNeed*128;
+	BufIndex += PageNeed * 128;
 
 	/* 3 (5) Qos null data */
 	RsvdPageLoc.LocQosNull = PageNum;
 	ConstructNullFunctionData(adapt, &ReservedPagePacket[BufIndex],
 				  &QosNullLength, get_my_bssid(&pmlmeinfo->network), true, 0, 0, false);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], QosNullLength, false, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], QosNullLength, false, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + QosNullLength);
 	PageNum += PageNeed;
@@ -594,26 +594,26 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 	if (mstatus == 1) {
 		/*  We should set AID, correct TSF, HW seq enable before set JoinBssReport to Fw in 88/92C. */
 		/*  Suggested by filen. Added by tynli. */
-		rtw_write16(adapt, REG_BCN_PSR_RPT, (0xC000|pmlmeinfo->aid));
+		rtw_write16(adapt, REG_BCN_PSR_RPT, (0xC000 | pmlmeinfo->aid));
 		/*  Do not set TSF again here or vWiFi beacon DMA INT will not work. */
 
 		/* Set REG_CR bit 8. DMA beacon by SW. */
 		haldata->RegCR_1 |= BIT(0);
-		rtw_write8(adapt,  REG_CR+1, haldata->RegCR_1);
+		rtw_write8(adapt,  REG_CR + 1, haldata->RegCR_1);
 
 		/*  Disable Hw protection for a time which revserd for Hw sending beacon. */
 		/*  Fix download reserved page packet fail that access collision with the protection time. */
 		/*  2010.05.11. Added by tynli. */
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)&(~BIT(3)));
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)|BIT(4));
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(3)));
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(4));
 
-		if (haldata->RegFwHwTxQCtrl&BIT(6)) {
+		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
 			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
 			bSendBeacon = true;
 		}
 
 		/*  Set FWHW_TXQ_CTRL 0x422[6]=0 to tell Hw the packet is not a real beacon frame. */
-		rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl&(~BIT(6))));
+		rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl & (~BIT(6))));
 		haldata->RegFwHwTxQCtrl &= (~BIT(6));
 
 		/*  Clear beacon valid check bit. */
@@ -630,7 +630,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 				/*  check rsvd page download OK. */
 				rtw_hal_get_hwreg(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
 				poll++;
-			} while (!bcn_valid && (poll%10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
+			} while (!bcn_valid && (poll % 10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 
 		if (adapt->bSurpriseRemoved || adapt->bDriverStopped)
@@ -647,8 +647,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  */
 
 		/*  Enable Bcn */
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)|BIT(3));
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)&(~BIT(4)));
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(3));
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(4)));
 
 		/*  To make sure that if there exists an adapter which would like to send beacon. */
 		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
@@ -656,7 +656,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  the beacon cannot be sent by HW. */
 		/*  2010.06.23. Added by tynli. */
 		if (bSendBeacon) {
-			rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl|BIT(6)));
+			rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl | BIT(6)));
 			haldata->RegFwHwTxQCtrl |= BIT(6);
 		}
 
@@ -669,7 +669,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
 		haldata->RegCR_1 &= (~BIT(0));
-		rtw_write8(adapt,  REG_CR+1, haldata->RegCR_1);
+		rtw_write8(adapt,  REG_CR + 1, haldata->RegCR_1);
 	}
 
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 24a82fc41872..e27d8966498a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -17,7 +17,7 @@ static void iol_mode_enable(struct adapter *padapter, u8 enable)
 	if (enable) {
 		/* Enable initial offload */
 		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
-		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0|SW_OFFLOAD_EN);
+		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
 		if (!padapter->bFWReady) {
 			DBG_88E("bFWReady == false call reset 8051...\n");
@@ -37,9 +37,9 @@ static s32 iol_execute(struct adapter *padapter, u8 control)
 	u8 reg_0x88 = 0;
 	u32 start = 0, passing_time = 0;
 
-	control = control&0x0f;
+	control = control & 0x0f;
 	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
-	rtw_write8(padapter, REG_HMEBOX_E0,  reg_0x88|control);
+	rtw_write8(padapter, REG_HMEBOX_E0,  reg_0x88 | control);
 
 	start = jiffies;
 	while ((reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0)) & control &&
@@ -49,7 +49,7 @@ static s32 iol_execute(struct adapter *padapter, u8 control)
 
 	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
 	status = (reg_0x88 & control) ? _FAIL : _SUCCESS;
-	if (reg_0x88 & control<<4)
+	if (reg_0x88 & control << 4)
 		status = _FAIL;
 	return status;
 }
@@ -58,7 +58,7 @@ static s32 iol_InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 {
 	s32 rst = _SUCCESS;
 	iol_mode_enable(padapter, 1);
-	rtw_write8(padapter, REG_TDECTRL+1, txpktbuf_bndy);
+	rtw_write8(padapter, REG_TDECTRL + 1, txpktbuf_bndy);
 	rst = iol_execute(padapter, CMD_INIT_LLT);
 	iol_mode_enable(padapter, 0);
 	return rst;
@@ -97,7 +97,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	/*  1. Read the first byte to check if efuse is empty!!! */
 	/*  */
 	/*  */
-	rtemp8 = *(phymap+eFuse_Addr);
+	rtemp8 = *(phymap + eFuse_Addr);
 	if (rtemp8 != 0xFF) {
 		efuse_utilized++;
 		eFuse_Addr++;
@@ -113,10 +113,10 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 		/*  Check PG header for section num. */
 		if ((rtemp8 & 0x1F) == 0x0F) {		/* extended header */
 			u1temp = ((rtemp8 & 0xE0) >> 5);
-			rtemp8 = *(phymap+eFuse_Addr);
+			rtemp8 = *(phymap + eFuse_Addr);
 			if ((rtemp8 & 0x0F) == 0x0F) {
 				eFuse_Addr++;
-				rtemp8 = *(phymap+eFuse_Addr);
+				rtemp8 = *(phymap + eFuse_Addr);
 
 				if (rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E))
 					eFuse_Addr++;
@@ -136,13 +136,13 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 				/*  Check word enable condition in the section */
 				if (!(wren & 0x01)) {
-					rtemp8 = *(phymap+eFuse_Addr);
+					rtemp8 = *(phymap + eFuse_Addr);
 					eFuse_Addr++;
 					efuse_utilized++;
 					eFuseWord[offset][i] = (rtemp8 & 0xff);
 					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
 						break;
-					rtemp8 = *(phymap+eFuse_Addr);
+					rtemp8 = *(phymap + eFuse_Addr);
 					eFuse_Addr++;
 					efuse_utilized++;
 					eFuseWord[offset][i] |= (((u16)rtemp8 << 8) & 0xff00);
@@ -154,7 +154,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 			}
 		}
 		/*  Read next PG header */
-		rtemp8 = *(phymap+eFuse_Addr);
+		rtemp8 = *(phymap + eFuse_Addr);
 
 		if (rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
 			efuse_utilized++;
@@ -167,8 +167,8 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	/*  */
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++) {
 		for (j = 0; j < EFUSE_MAX_WORD_UNIT; j++) {
-			efuseTbl[(i*8)+(j*2)] = (eFuseWord[i][j] & 0xff);
-			efuseTbl[(i*8)+((j*2)+1)] = ((eFuseWord[i][j] >> 8) & 0xff);
+			efuseTbl[(i * 8) + (j * 2)] = (eFuseWord[i][j] & 0xff);
+			efuseTbl[(i * 8) + ((j * 2) + 1)] = ((eFuseWord[i][j] >> 8) & 0xff);
 		}
 	}
 
@@ -176,7 +176,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	/*  4. Copy from Efuse map to output pointer memory!!! */
 	/*  */
 	for (i = 0; i < _size_byte; i++)
-		pbuf[i] = efuseTbl[_offset+i];
+		pbuf[i] = efuseTbl[_offset + i];
 
 	/*  */
 	/*  5. Calculate Efuse utilization. */
@@ -205,16 +205,16 @@ static void efuse_read_phymap_from_txpktbuf(
 	u8 *pos = content;
 
 	if (bcnhead < 0) /* if not valid */
-		bcnhead = rtw_read8(adapter, REG_TDECTRL+1);
+		bcnhead = rtw_read8(adapter, REG_TDECTRL + 1);
 
 	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
 
 	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 
-	dbg_addr = bcnhead*128/8; /* 8-bytes addressing */
+	dbg_addr = bcnhead * 128 / 8; /* 8-bytes addressing */
 
 	while (1) {
-		rtw_write16(adapter, REG_PKTBUF_DBG_ADDR, dbg_addr+i);
+		rtw_write16(adapter, REG_PKTBUF_DBG_ADDR, dbg_addr + i);
 
 		rtw_write8(adapter, REG_TXPKTBUF_DBG, 0);
 		start = jiffies;
@@ -237,26 +237,26 @@ static void efuse_read_phymap_from_txpktbuf(
 
 			len = le32_to_cpu(lo32) & 0x0000ffff;
 
-			limit = (len-2 < limit) ? len-2 : limit;
+			limit = (len - 2 < limit) ? len - 2 : limit;
 
 			DBG_88E("%s len:%u, lenc:%u\n", __func__, len, lenc);
 
-			memcpy(pos, ((u8 *)&lo32)+2, (limit >= count+2) ? 2 : limit-count);
-			count += (limit >= count+2) ? 2 : limit-count;
-			pos = content+count;
+			memcpy(pos, ((u8 *)&lo32) + 2, (limit >= count + 2) ? 2 : limit - count);
+			count += (limit >= count + 2) ? 2 : limit - count;
+			pos = content + count;
 		} else {
-			memcpy(pos, ((u8 *)&lo32), (limit >= count+4) ? 4 : limit-count);
-			count += (limit >= count+4) ? 4 : limit-count;
-			pos = content+count;
+			memcpy(pos, ((u8 *)&lo32), (limit >= count + 4) ? 4 : limit - count);
+			count += (limit >= count + 4) ? 4 : limit - count;
+			pos = content + count;
 		}
 
-		if (limit > count && len-2 > count) {
-			memcpy(pos, (u8 *)&hi32, (limit >= count+4) ? 4 : limit-count);
-			count += (limit >= count+4) ? 4 : limit-count;
-			pos = content+count;
+		if (limit > count && len - 2 > count) {
+			memcpy(pos, (u8 *)&hi32, (limit >= count + 4) ? 4 : limit - count);
+			count += (limit >= count + 4) ? 4 : limit - count;
+			pos = content + count;
 		}
 
-		if (limit <= count || len-2 <= count)
+		if (limit <= count || len - 2 <= count)
 			break;
 		i++;
 	}
@@ -271,7 +271,7 @@ static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset
 	u8 physical_map[512];
 	u16 size = 512;
 
-	rtw_write8(padapter, REG_TDECTRL+1, txpktbuf_bndy);
+	rtw_write8(padapter, REG_TDECTRL + 1, txpktbuf_bndy);
 	memset(physical_map, 0xFF, 512);
 	rtw_write8(padapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 	status = iol_execute(padapter, CMD_READ_EFUSE_MAP);
@@ -301,7 +301,7 @@ static s32 iol_ioconfig(struct adapter *padapter, u8 iocfg_bndy)
 {
 	s32 rst = _SUCCESS;
 
-	rtw_write8(padapter, REG_TDECTRL+1, iocfg_bndy);
+	rtw_write8(padapter, REG_TDECTRL + 1, iocfg_bndy);
 	rst = iol_execute(padapter, CMD_IOCONFIG);
 	return rst;
 }
@@ -314,7 +314,7 @@ static int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_fram
 
 	if (rtw_IOL_append_END_cmd(xmit_frame) != _SUCCESS)
 		goto exit;
-	if (rtw_usb_bulk_size_boundary(adapter, TXDESC_SIZE+pattrib->last_txcmdsz)) {
+	if (rtw_usb_bulk_size_boundary(adapter, TXDESC_SIZE + pattrib->last_txcmdsz)) {
 		if (rtw_IOL_append_END_cmd(xmit_frame) != _SUCCESS)
 			goto exit;
 	}
@@ -324,7 +324,7 @@ static int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_fram
 	iol_mode_enable(adapter, 1);
 	for (i = 0; i < bndy_cnt; i++) {
 		u8 page_no = 0;
-		page_no = i*2;
+		page_no = i * 2;
 		ret = iol_ioconfig(adapter, page_no);
 		if (ret != _SUCCESS)
 			break;
@@ -332,7 +332,7 @@ static int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_fram
 	iol_mode_enable(adapter, 0);
 exit:
 	/* restore BCN_HEAD */
-	rtw_write8(adapter, REG_TDECTRL+1, 0);
+	rtw_write8(adapter, REG_TDECTRL + 1, 0);
 	return ret;
 }
 
@@ -340,8 +340,8 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 {
 	u32 fifo_data, reg_140;
 	u32 addr, rstatus, loop = 0;
-	u16 data_cnts = (data_len/8)+1;
-	u8 *pbuf = rtw_zvmalloc(data_len+10);
+	u16 data_cnts = (data_len / 8) + 1;
+	u8 *pbuf = rtw_zvmalloc(data_len + 10);
 	DBG_88E("###### %s ######\n", __func__);
 
 	rtw_write8(Adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
@@ -351,13 +351,13 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 			rtw_usleep_os(2);
 			loop = 0;
 			do {
-				rstatus = (reg_140 = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL)&BIT(24));
+				rstatus = (reg_140 = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL) & BIT(24));
 				if (rstatus) {
 					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_L);
-					memcpy(pbuf+(addr*8), &fifo_data, 4);
+					memcpy(pbuf + (addr * 8), &fifo_data, 4);
 
 					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_H);
-					memcpy(pbuf+(addr*8+4), &fifo_data, 4);
+					memcpy(pbuf + (addr * 8 + 4), &fifo_data, 4);
 				}
 				rtw_usleep_os(2);
 			} while (!rstatus && (loop++ < 10));
@@ -378,15 +378,15 @@ static void _FWDownloadEnable(struct adapter *padapter, bool enable)
 		rtw_write8(padapter, REG_MCUFWDL, tmp | 0x01);
 
 		/*  8051 reset */
-		tmp = rtw_read8(padapter, REG_MCUFWDL+2);
-		rtw_write8(padapter, REG_MCUFWDL+2, tmp&0xf7);
+		tmp = rtw_read8(padapter, REG_MCUFWDL + 2);
+		rtw_write8(padapter, REG_MCUFWDL + 2, tmp & 0xf7);
 	} else {
 		/*  MCU firmware download disable. */
 		tmp = rtw_read8(padapter, REG_MCUFWDL);
-		rtw_write8(padapter, REG_MCUFWDL, tmp&0xfe);
+		rtw_write8(padapter, REG_MCUFWDL, tmp & 0xfe);
 
 		/*  Reserved for fw extension. */
-		rtw_write8(padapter, REG_MCUFWDL+1, 0x00);
+		rtw_write8(padapter, REG_MCUFWDL + 1, 0x00);
 	}
 }
 
@@ -419,11 +419,11 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	if (remainSize_p1) {
 		offset = blockCount_p1 * blockSize_p1;
 
-		blockCount_p2 = remainSize_p1/blockSize_p2;
-		remainSize_p2 = remainSize_p1%blockSize_p2;
+		blockCount_p2 = remainSize_p1 / blockSize_p2;
+		remainSize_p2 = remainSize_p1 % blockSize_p2;
 
 		for (i = 0; i < blockCount_p2; i++) {
-			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i*blockSize_p2), blockSize_p2, (bufferPtr + offset + i*blockSize_p2));
+			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i * blockSize_p2), blockSize_p2, (bufferPtr + offset + i * blockSize_p2));
 
 			if (ret == _FAIL)
 				goto exit;
@@ -453,8 +453,8 @@ static int _PageWrite(struct adapter *padapter, u32 page, void *buffer, u32 size
 	u8 value8;
 	u8 u8Page = (u8)(page & 0x07);
 
-	value8 = (rtw_read8(padapter, REG_MCUFWDL+2) & 0xF8) | u8Page;
-	rtw_write8(padapter, REG_MCUFWDL+2, value8);
+	value8 = (rtw_read8(padapter, REG_MCUFWDL + 2) & 0xF8) | u8Page;
+	rtw_write8(padapter, REG_MCUFWDL + 2, value8);
 
 	return _BlockWrite(padapter, buffer, size);
 }
@@ -473,7 +473,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 
 	for (page = 0; page < pageNums; page++) {
 		offset = page * MAX_PAGE_SIZE;
-		ret = _PageWrite(padapter, page, bufferPtr+offset, MAX_PAGE_SIZE);
+		ret = _PageWrite(padapter, page, bufferPtr + offset, MAX_PAGE_SIZE);
 
 		if (ret == _FAIL)
 			goto exit;
@@ -481,7 +481,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 	if (remainSize) {
 		offset = pageNums * MAX_PAGE_SIZE;
 		page = pageNums;
-		ret = _PageWrite(padapter, page, bufferPtr+offset, remainSize);
+		ret = _PageWrite(padapter, page, bufferPtr + offset, remainSize);
 
 		if (ret == _FAIL)
 			goto exit;
@@ -494,9 +494,9 @@ void _8051Reset88E(struct adapter *padapter)
 {
 	u8 u1bTmp;
 
-	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
-	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT(2)));
-	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp|(BIT(2)));
+	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
+	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp & (~BIT(2)));
+	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp | (BIT(2)));
 	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
 }
 
@@ -741,18 +741,18 @@ hal_EfusePowerSwitch_RTL8188E(
 
 		if (bWrite) {
 			/*  Enable LDO 2.5V before read/write action */
-			tempval = rtw_read8(pAdapter, EFUSE_TEST+3);
+			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3);
 			tempval &= 0x0F;
 			tempval |= (VOLTAGE_V25 << 4);
-			rtw_write8(pAdapter, EFUSE_TEST+3, (tempval | 0x80));
+			rtw_write8(pAdapter, EFUSE_TEST + 3, (tempval | 0x80));
 		}
 	} else {
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
 
 		if (bWrite) {
 			/*  Disable LDO 2.5V after read/write action */
-			tempval = rtw_read8(pAdapter, EFUSE_TEST+3);
-			rtw_write8(pAdapter, EFUSE_TEST+3, (tempval & 0x7F));
+			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3);
+			rtw_write8(pAdapter, EFUSE_TEST + 3, (tempval & 0x7F));
 		}
 	}
 }
@@ -882,14 +882,14 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	/*  3. Collect 16 sections and 4 word unit into Efuse map. */
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++) {
 		for (j = 0; j < EFUSE_MAX_WORD_UNIT; j++) {
-			efuseTbl[(i*8)+(j*2)] = (eFuseWord[i][j] & 0xff);
-			efuseTbl[(i*8)+((j*2)+1)] = ((eFuseWord[i][j] >> 8) & 0xff);
+			efuseTbl[(i * 8) + (j * 2)] = (eFuseWord[i][j] & 0xff);
+			efuseTbl[(i * 8) + ((j * 2) + 1)] = ((eFuseWord[i][j] >> 8) & 0xff);
 		}
 	}
 
 	/*  4. Copy from Efuse map to output pointer memory!!! */
 	for (i = 0; i < _size_byte; i++)
-		pbuf[i] = efuseTbl[_offset+i];
+		pbuf[i] = efuseTbl[_offset + i];
 
 	/*  5. Calculate Efuse utilization. */
 	rtw_hal_set_hwreg(Adapter, HW_VAR_EFUSE_BYTES, (u8 *)&eFuse_Addr);
@@ -930,7 +930,7 @@ static void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 			       bool bPseudoTest)
 {
 	if (bPseudoTest)
-		ReadEFuse_Pseudo (Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+		ReadEFuse_Pseudo(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
 	else
 		ReadEFuseByIC(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
 }
@@ -964,14 +964,14 @@ static void Hal_EFUSEGetEfuseDefinition88E(struct adapter *pAdapter, u8 efuseTyp
 		{
 			u16 *pu2Tmp;
 			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
 		}
 		break;
 	case TYPE_AVAILABLE_EFUSE_BYTES_TOTAL:
 		{
 			u16 *pu2Tmp;
 			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
 		}
 		break;
 	case TYPE_EFUSE_MAP_LEN:
@@ -1026,14 +1026,14 @@ static void Hal_EFUSEGetEfuseDefinition_Pseudo88E(struct adapter *pAdapter, u8 e
 		{
 			u16 *pu2Tmp;
 			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
 		}
 		break;
 	case TYPE_AVAILABLE_EFUSE_BYTES_TOTAL:
 		{
 			u16 *pu2Tmp;
 			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
 		}
 		break;
 	case TYPE_EFUSE_MAP_LEN:
@@ -1077,43 +1077,43 @@ static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr,
 
 	memset((void *)tmpdata, 0xff, PGPKT_DATA_SIZE);
 
-	if (!(word_en&BIT(0))) {
+	if (!(word_en & BIT(0))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[0], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[1], bPseudoTest);
 
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[0], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[1], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[1], bPseudoTest);
 		if ((data[0] != tmpdata[0]) || (data[1] != tmpdata[1]))
 			badworden &= (~BIT(0));
 	}
-	if (!(word_en&BIT(1))) {
+	if (!(word_en & BIT(1))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[2], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[3], bPseudoTest);
 
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[2], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[3], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[3], bPseudoTest);
 		if ((data[2] != tmpdata[2]) || (data[3] != tmpdata[3]))
 			badworden &= (~BIT(1));
 	}
-	if (!(word_en&BIT(2))) {
+	if (!(word_en & BIT(2))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[4], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[5], bPseudoTest);
 
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[4], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[5], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[5], bPseudoTest);
 		if ((data[4] != tmpdata[4]) || (data[5] != tmpdata[5]))
 			badworden &= (~BIT(2));
 	}
-	if (!(word_en&BIT(3))) {
+	if (!(word_en & BIT(3))) {
 		tmpaddr = start_addr;
 		efuse_OneByteWrite(pAdapter, start_addr++, data[6], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[7], bPseudoTest);
 
 		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[6], bPseudoTest);
-		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[7], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr + 1, &tmpdata[7], bPseudoTest);
 		if ((data[6] != tmpdata[6]) || (data[7] != tmpdata[7]))
 			badworden &= (~BIT(3));
 	}
@@ -1133,7 +1133,7 @@ static u8 rtl8188e_Efuse_WordEnableDataWrite(struct adapter *pAdapter, u16 efuse
 	u8 ret = 0;
 
 	if (bPseudoTest)
-		ret = Hal_EfuseWordEnableDataWrite_Pseudo (pAdapter, efuse_addr, word_en, data, bPseudoTest);
+		ret = Hal_EfuseWordEnableDataWrite_Pseudo(pAdapter, efuse_addr, word_en, data, bPseudoTest);
 	else
 		ret = Hal_EfuseWordEnableDataWrite(pAdapter, efuse_addr, word_en, data, bPseudoTest);
 	return ret;
@@ -1155,7 +1155,7 @@ static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoT
 	       efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest) &&
 	       AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 		if (efuse_data != 0xFF) {
-			if ((efuse_data&0x1F) == 0x0F) {		/* extended header */
+			if ((efuse_data & 0x1F) == 0x0F) {		/* extended header */
 				hoffset = efuse_data;
 				efuse_addr++;
 				efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest);
@@ -1167,12 +1167,12 @@ static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoT
 					hworden = efuse_data & 0x0F;
 				}
 			} else {
-				hoffset = (efuse_data>>4) & 0x0F;
+				hoffset = (efuse_data >> 4) & 0x0F;
 				hworden =  efuse_data & 0x0F;
 			}
 			word_cnts = Efuse_CalculateWordCnts(hworden);
 			/* read next header */
-			efuse_addr = efuse_addr + (word_cnts*2)+1;
+			efuse_addr = efuse_addr + (word_cnts * 2) + 1;
 		} else {
 			bContinual = false;
 		}
@@ -1225,8 +1225,8 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 	if (offset > max_section)
 		return false;
 
-	memset((void *)data, 0xff, sizeof(u8)*PGPKT_DATA_SIZE);
-	memset((void *)tmpdata, 0xff, sizeof(u8)*PGPKT_DATA_SIZE);
+	memset((void *)data, 0xff, sizeof(u8) * PGPKT_DATA_SIZE);
+	memset((void *)tmpdata, 0xff, sizeof(u8) * PGPKT_DATA_SIZE);
 
 	/*  <Roger_TODO> Efuse has been pre-programmed dummy 5Bytes at the end of Efuse by CP. */
 	/*  Skip dummy parts to prevent unexpected data read from Efuse. */
@@ -1248,15 +1248,15 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 						continue;
 					}
 				} else {
-					hoffset = (efuse_data>>4) & 0x0F;
+					hoffset = (efuse_data >> 4) & 0x0F;
 					hworden =  efuse_data & 0x0F;
 				}
 				word_cnts = Efuse_CalculateWordCnts(hworden);
 				bDataEmpty = true;
 
 				if (hoffset == offset) {
-					for (tmpidx = 0; tmpidx < word_cnts*2; tmpidx++) {
-						if (efuse_OneByteRead(pAdapter, efuse_addr+1+tmpidx, &efuse_data, bPseudoTest)) {
+					for (tmpidx = 0; tmpidx < word_cnts * 2; tmpidx++) {
+						if (efuse_OneByteRead(pAdapter, efuse_addr + 1 + tmpidx, &efuse_data, bPseudoTest)) {
 							tmpdata[tmpidx] = efuse_data;
 							if (efuse_data != 0xff)
 								bDataEmpty = false;
@@ -1265,11 +1265,11 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 					if (bDataEmpty == false) {
 						ReadState = PG_STATE_DATA;
 					} else {/* read next header */
-						efuse_addr = efuse_addr + (word_cnts*2)+1;
+						efuse_addr = efuse_addr + (word_cnts * 2) + 1;
 						ReadState = PG_STATE_HEADER;
 					}
 				} else {/* read next header */
-					efuse_addr = efuse_addr + (word_cnts*2)+1;
+					efuse_addr = efuse_addr + (word_cnts * 2) + 1;
 					ReadState = PG_STATE_HEADER;
 				}
 			} else {
@@ -1278,7 +1278,7 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 		} else if (ReadState & PG_STATE_DATA) {
 		/*   Data section Read ------------- */
 			efuse_WordEnableDataRead(hworden, tmpdata, data);
-			efuse_addr = efuse_addr + (word_cnts*2)+1;
+			efuse_addr = efuse_addr + (word_cnts * 2) + 1;
 			ReadState = PG_STATE_HEADER;
 		}
 
@@ -1312,7 +1312,7 @@ static int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *
 	int	ret;
 
 	if (bPseudoTest)
-		ret = Hal_EfusePgPacketRead_Pseudo (pAdapter, offset, data, bPseudoTest);
+		ret = Hal_EfusePgPacketRead_Pseudo(pAdapter, offset, data, bPseudoTest);
 	else
 		ret = Hal_EfusePgPacketRead(pAdapter, offset, data, bPseudoTest);
 	return ret;
@@ -1328,7 +1328,7 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 
 	if (Efuse_PgPacketRead(pAdapter, pFixPkt->offset, originaldata, bPseudoTest)) {
 		/* check if data exist */
-		badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr+1, pFixPkt->word_en, originaldata, bPseudoTest);
+		badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pFixPkt->word_en, originaldata, bPseudoTest);
 
 		if (badworden != 0xf) {	/*  write fail */
 			PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pFixPkt->offset, badworden, originaldata, bPseudoTest);
@@ -1338,10 +1338,10 @@ static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, st
 			else
 				efuse_addr = Efuse_GetCurrentSize(pAdapter, efuseType, bPseudoTest);
 		} else {
-			efuse_addr = efuse_addr + (pFixPkt->word_cnts*2) + 1;
+			efuse_addr = efuse_addr + (pFixPkt->word_cnts * 2) + 1;
 		}
 	} else {
-		efuse_addr = efuse_addr + (pFixPkt->word_cnts*2) + 1;
+		efuse_addr = efuse_addr + (pFixPkt->word_cnts * 2) + 1;
 	}
 	*pAddr = efuse_addr;
 	return true;
@@ -1437,7 +1437,7 @@ static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuse
 		bRet = true;
 	} else {
 		struct pgpkt	fixPkt;
-		fixPkt.offset = (tmp_header>>4) & 0x0F;
+		fixPkt.offset = (tmp_header >> 4) & 0x0F;
 		fixPkt.word_en = tmp_header & 0x0F;
 		fixPkt.word_cnts = Efuse_CalculateWordCnts(fixPkt.word_en);
 		if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr, bPseudoTest))
@@ -1455,7 +1455,7 @@ static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u
 	u32	PgWriteSuccess = 0;
 
 	badworden = 0x0f;
-	badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr+1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
+	badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr + 1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
 	if (badworden == 0x0F) {
 		/*  write ok */
 		return true;
@@ -1519,8 +1519,8 @@ static bool hal_EfuseCheckIfDatafollowed(struct adapter *pAdapter, u8 word_cnts,
 	bool bRet = false;
 	u8 i, efuse_data;
 
-	for (i = 0; i < (word_cnts*2); i++) {
-		if (efuse_OneByteRead(pAdapter, (startAddr+i), &efuse_data, bPseudoTest) && (efuse_data != 0xFF))
+	for (i = 0; i < (word_cnts * 2); i++) {
+		if (efuse_OneByteRead(pAdapter, (startAddr + i), &efuse_data, bPseudoTest) && (efuse_data != 0xFF))
 			bRet = true;
 	}
 	return bRet;
@@ -1539,16 +1539,16 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 
 	if (efuseType == EFUSE_WIFI) {
 		if (bPseudoTest) {
-			startAddr = (u16)(fakeEfuseUsedBytes%EFUSE_REAL_CONTENT_LEN);
+			startAddr = (u16)(fakeEfuseUsedBytes % EFUSE_REAL_CONTENT_LEN);
 		} else {
 			rtw_hal_get_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&startAddr);
 			startAddr %= EFUSE_REAL_CONTENT_LEN;
 		}
 	} else {
 		if (bPseudoTest)
-			startAddr = (u16)(fakeBTEfuseUsedBytes%EFUSE_REAL_CONTENT_LEN);
+			startAddr = (u16)(fakeBTEfuseUsedBytes % EFUSE_REAL_CONTENT_LEN);
 		else
-			startAddr = (u16)(BTEfuseUsedBytes%EFUSE_REAL_CONTENT_LEN);
+			startAddr = (u16)(BTEfuseUsedBytes % EFUSE_REAL_CONTENT_LEN);
 	}
 
 	while (1) {
@@ -1571,7 +1571,7 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 				}
 			} else {
 				cur_header  =  efuse_data;
-				curPkt.offset = (cur_header>>4) & 0x0F;
+				curPkt.offset = (cur_header >> 4) & 0x0F;
 				curPkt.word_en = cur_header & 0x0F;
 			}
 
@@ -1579,10 +1579,10 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 			/*  if same header is found but no data followed */
 			/*  write some part of data followed by the header. */
 			if ((curPkt.offset == pTargetPkt->offset) &&
-			    (!hal_EfuseCheckIfDatafollowed(pAdapter, curPkt.word_cnts, startAddr+1, bPseudoTest)) &&
+			    (!hal_EfuseCheckIfDatafollowed(pAdapter, curPkt.word_cnts, startAddr + 1, bPseudoTest)) &&
 			    wordEnMatched(pTargetPkt, &curPkt, &matched_wden)) {
 				/*  Here to write partial data */
-				badworden = Efuse_WordEnableDataWrite(pAdapter, startAddr+1, matched_wden, pTargetPkt->data, bPseudoTest);
+				badworden = Efuse_WordEnableDataWrite(pAdapter, startAddr + 1, matched_wden, pTargetPkt->data, bPseudoTest);
 				if (badworden != 0x0F) {
 					u32	PgWriteSuccess = 0;
 					/*  if write fail on some words, write these bad words again */
@@ -1596,13 +1596,13 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 				}
 				/*  partial write ok, update the target packet for later use */
 				for (i = 0; i < 4; i++) {
-					if ((matched_wden & (0x1<<i)) == 0)	/*  this word has been written */
-						pTargetPkt->word_en |= (0x1<<i);	/*  disable the word */
+					if ((matched_wden & (0x1 << i)) == 0)	/*  this word has been written */
+						pTargetPkt->word_en |= (0x1 << i);	/*  disable the word */
 				}
 				pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
 			}
 			/*  read from next header */
-			startAddr = startAddr + (curPkt.word_cnts*2) + 1;
+			startAddr = startAddr + (curPkt.word_cnts * 2) + 1;
 		} else {
 			/*  not used header, 0xff */
 			*pAddr = startAddr;
@@ -1632,7 +1632,7 @@ hal_EfusePgCheckAvailableAddr(
 
 static void hal_EfuseConstructPGPkt(u8 offset, u8 word_en, u8 *pData, struct pgpkt *pTargetPkt)
 {
-	memset((void *)pTargetPkt->data, 0xFF, sizeof(u8)*8);
+	memset((void *)pTargetPkt->data, 0xFF, sizeof(u8) * 8);
 	pTargetPkt->offset = offset;
 	pTargetPkt->word_en = word_en;
 	efuse_WordEnableDataRead(word_en, pData, pTargetPkt->data);
@@ -1683,7 +1683,7 @@ static int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8
 	int	ret;
 
 	if (bPseudoTest)
-		ret = Hal_EfusePgPacketWrite_Pseudo (pAdapter, offset, word_en, data, bPseudoTest);
+		ret = Hal_EfusePgPacketWrite_Pseudo(pAdapter, offset, word_en, data, bPseudoTest);
 	else
 		ret = Hal_EfusePgPacketWrite(pAdapter, offset, word_en, data, bPseudoTest);
 	return ret;
@@ -1703,7 +1703,7 @@ static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
 
 	ChipVersion.RFType = RF_TYPE_1T1R;
 	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
-	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK)>>CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
+	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK) >> CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
 
 	/*  For regulator mode. by tynli. 2011.01.14 */
 	pHalData->RegulatorMode = ((value32 & TRP_BT_EN) ? RT_LDO_REGULATOR : RT_SWITCHING_REGULATOR);
@@ -1786,10 +1786,10 @@ static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT(1));
+		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
 	} else {
 		DBG_88E("Disable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT(1));
+		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
 	}
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
@@ -1996,7 +1996,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 			if (pwrInfo24G->IndexCCK_Base[rfPath][group] == 0xFF)
 				pwrInfo24G->IndexCCK_Base[rfPath][group] = EEPROM_DEFAULT_24G_INDEX;
 		}
-		for (group = 0; group < MAX_CHNL_GROUP_24G-1; group++) {
+		for (group = 0; group < MAX_CHNL_GROUP_24G - 1; group++) {
 			pwrInfo24G->IndexBW40_Base[rfPath][group] =	PROMContent[eeAddr++];
 			if (pwrInfo24G->IndexBW40_Base[rfPath][group] == 0xFF)
 				pwrInfo24G->IndexBW40_Base[rfPath][group] =	EEPROM_DEFAULT_24G_INDEX;
@@ -2007,7 +2007,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] = EEPROM_DEFAULT_24G_HT20_DIFF;
 				} else {
-					pwrInfo24G->BW20_Diff[rfPath][TxCount] = (PROMContent[eeAddr]&0xf0)>>4;
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] = (PROMContent[eeAddr] & 0xf0) >> 4;
 					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -2015,7 +2015,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_24G_OFDM_DIFF;
 				} else {
-					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0x0f);
 					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -2025,7 +2025,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
+					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0xf0) >> 4;
 					if (pwrInfo24G->BW40_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW40_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -2033,7 +2033,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0x0f);
 					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -2042,7 +2042,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] = EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0xf0) >> 4;
 					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -2050,7 +2050,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0x0f);
 					if (pwrInfo24G->CCK_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->CCK_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -2141,9 +2141,9 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 
 	/*  2010/10/19 MH Add Regulator recognize for CU. */
 	if (!AutoLoadFail) {
-		pHalData->EEPROMRegulatory = (PROMContent[EEPROM_RF_BOARD_OPTION_88E]&0x7);	/* bit0~2 */
+		pHalData->EEPROMRegulatory = (PROMContent[EEPROM_RF_BOARD_OPTION_88E] & 0x7);	/* bit0~2 */
 		if (PROMContent[EEPROM_RF_BOARD_OPTION_88E] == 0xFF)
-			pHalData->EEPROMRegulatory = (EEPROM_DEFAULT_BOARD_OPTION&0x7);	/* bit0~2 */
+			pHalData->EEPROMRegulatory = (EEPROM_DEFAULT_BOARD_OPTION & 0x7);	/* bit0~2 */
 	} else {
 		pHalData->EEPROMRegulatory = 0;
 	}
@@ -2169,7 +2169,7 @@ void Hal_EfuseParseBoardType88E(struct adapter *pAdapter, u8 *hwinfo, bool AutoL
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(pAdapter);
 
 	if (!AutoLoadFail)
-		pHalData->BoardType = ((hwinfo[EEPROM_RF_BOARD_OPTION_88E]&0xE0)>>5);
+		pHalData->BoardType = ((hwinfo[EEPROM_RF_BOARD_OPTION_88E] & 0xE0) >> 5);
 	else
 		pHalData->BoardType = 0;
 	DBG_88E("Board Type: 0x%2x\n", pHalData->BoardType);
@@ -2220,9 +2220,9 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 	if (!AutoLoadFail) {
 		/*  Antenna Diversity setting. */
 		if (registry_par->antdiv_cfg == 2) { /*  2:By EFUSE */
-			pHalData->AntDivCfg = (PROMContent[EEPROM_RF_BOARD_OPTION_88E]&0x18)>>3;
+			pHalData->AntDivCfg = (PROMContent[EEPROM_RF_BOARD_OPTION_88E] & 0x18) >> 3;
 			if (PROMContent[EEPROM_RF_BOARD_OPTION_88E] == 0xFF)
-				pHalData->AntDivCfg = (EEPROM_DEFAULT_BOARD_OPTION&0x18)>>3;;
+				pHalData->AntDivCfg = (EEPROM_DEFAULT_BOARD_OPTION & 0x18) >> 3;;
 		} else {
 			pHalData->AntDivCfg = registry_par->antdiv_cfg;  /*  0:OFF , 1:ON, 2:By EFUSE */
 		}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index a26a5816a45f..7d412b10e6c3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -78,8 +78,8 @@ void Hal_MPT_CCKTxPowerAdjust(struct adapter *Adapter, bool bInCH14)
 		/*  Readback the current bb cck swing value and compare with the table to */
 		/*  get the current swing index */
 		for (i = 0; i < CCK_TABLE_SIZE; i++) {
-			if (((CurrCCKSwingVal&0xff) == (u32)CCKSwingTable_Ch1_Ch13[i][0]) &&
-			    (((CurrCCKSwingVal&0xff00)>>8) == (u32)CCKSwingTable_Ch1_Ch13[i][1])) {
+			if (((CurrCCKSwingVal & 0xff) == (u32)CCKSwingTable_Ch1_Ch13[i][0]) &&
+			    (((CurrCCKSwingVal & 0xff00) >> 8) == (u32)CCKSwingTable_Ch1_Ch13[i][1])) {
 				CCKSwingIndex = i;
 				break;
 			}
@@ -87,23 +87,23 @@ void Hal_MPT_CCKTxPowerAdjust(struct adapter *Adapter, bool bInCH14)
 
 		/* Write 0xa22 0xa23 */
 		TempVal = CCKSwingTable_Ch1_Ch13[CCKSwingIndex][0] +
-				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][1]<<8);
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][1] << 8);
 
 		/* Write 0xa24 ~ 0xa27 */
 		TempVal2 = 0;
 		TempVal2 = CCKSwingTable_Ch1_Ch13[CCKSwingIndex][2] +
-				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][3]<<8) +
-				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][4]<<16)+
-				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][5]<<24);
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][3] << 8) +
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][4] << 16) +
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][5] << 24);
 
 		/* Write 0xa28  0xa29 */
 		TempVal3 = 0;
 		TempVal3 = CCKSwingTable_Ch1_Ch13[CCKSwingIndex][6] +
-				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][7]<<8);
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][7] << 8);
 	} else {
 		for (i = 0; i < CCK_TABLE_SIZE; i++) {
-			if (((CurrCCKSwingVal&0xff) == (u32)CCKSwingTable_Ch14[i][0]) &&
-			    (((CurrCCKSwingVal&0xff00)>>8) == (u32)CCKSwingTable_Ch14[i][1])) {
+			if (((CurrCCKSwingVal & 0xff) == (u32)CCKSwingTable_Ch14[i][0]) &&
+			    (((CurrCCKSwingVal & 0xff00) >> 8) == (u32)CCKSwingTable_Ch14[i][1])) {
 				CCKSwingIndex = i;
 				break;
 			}
@@ -111,19 +111,19 @@ void Hal_MPT_CCKTxPowerAdjust(struct adapter *Adapter, bool bInCH14)
 
 		/* Write 0xa22 0xa23 */
 		TempVal = CCKSwingTable_Ch14[CCKSwingIndex][0] +
-				(CCKSwingTable_Ch14[CCKSwingIndex][1]<<8);
+				(CCKSwingTable_Ch14[CCKSwingIndex][1] << 8);
 
 		/* Write 0xa24 ~ 0xa27 */
 		TempVal2 = 0;
 		TempVal2 = CCKSwingTable_Ch14[CCKSwingIndex][2] +
-				(CCKSwingTable_Ch14[CCKSwingIndex][3]<<8) +
-				(CCKSwingTable_Ch14[CCKSwingIndex][4]<<16)+
-				(CCKSwingTable_Ch14[CCKSwingIndex][5]<<24);
+				(CCKSwingTable_Ch14[CCKSwingIndex][3] << 8) +
+				(CCKSwingTable_Ch14[CCKSwingIndex][4] << 16) +
+				(CCKSwingTable_Ch14[CCKSwingIndex][5] << 24);
 
 		/* Write 0xa28  0xa29 */
 		TempVal3 = 0;
 		TempVal3 = CCKSwingTable_Ch14[CCKSwingIndex][6] +
-				(CCKSwingTable_Ch14[CCKSwingIndex][7]<<8);
+				(CCKSwingTable_Ch14[CCKSwingIndex][7] << 8);
 	}
 
 	write_bbreg(Adapter, rCCK0_TxFilter1, bMaskHWord, TempVal);
@@ -247,12 +247,12 @@ void Hal_SetCCKTxPower(struct adapter *pAdapter, u8 *TxPower)
 
 	/*  rf-A cck tx power */
 	write_bbreg(pAdapter, rTxAGC_A_CCK1_Mcs32, bMaskByte1, TxPower[RF_PATH_A]);
-	tmpval = (TxPower[RF_PATH_A]<<16) | (TxPower[RF_PATH_A]<<8) | TxPower[RF_PATH_A];
+	tmpval = (TxPower[RF_PATH_A] << 16) | (TxPower[RF_PATH_A] << 8) | TxPower[RF_PATH_A];
 	write_bbreg(pAdapter, rTxAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
 
 	/*  rf-B cck tx power */
 	write_bbreg(pAdapter, rTxAGC_B_CCK11_A_CCK2_11, bMaskByte0, TxPower[RF_PATH_B]);
-	tmpval = (TxPower[RF_PATH_B]<<16) | (TxPower[RF_PATH_B]<<8) | TxPower[RF_PATH_B];
+	tmpval = (TxPower[RF_PATH_B] << 16) | (TxPower[RF_PATH_B] << 8) | TxPower[RF_PATH_B];
 	write_bbreg(pAdapter, rTxAGC_B_CCK1_55_Mcs32, 0xffffff00, tmpval);
 }
 
@@ -263,7 +263,7 @@ void Hal_SetOFDMTxPower(struct adapter *pAdapter, u8 *TxPower)
 
 	/*  HT Tx-rf(A) */
 	tmpval = TxPower[RF_PATH_A];
-	TxAGC = (tmpval<<24) | (tmpval<<16) | (tmpval<<8) | tmpval;
+	TxAGC = (tmpval << 24) | (tmpval << 16) | (tmpval << 8) | tmpval;
 
 	write_bbreg(pAdapter, rTxAGC_A_Rate18_06, bMaskDWord, TxAGC);
 	write_bbreg(pAdapter, rTxAGC_A_Rate54_24, bMaskDWord, TxAGC);
@@ -274,7 +274,7 @@ void Hal_SetOFDMTxPower(struct adapter *pAdapter, u8 *TxPower)
 
 	/*  HT Tx-rf(B) */
 	tmpval = TxPower[RF_PATH_B];
-	TxAGC = (tmpval<<24) | (tmpval<<16) | (tmpval<<8) | tmpval;
+	TxAGC = (tmpval << 24) | (tmpval << 16) | (tmpval << 8) | tmpval;
 
 	write_bbreg(pAdapter, rTxAGC_B_Rate18_06, bMaskDWord, TxAGC);
 	write_bbreg(pAdapter, rTxAGC_B_Rate54_24, bMaskDWord, TxAGC);
@@ -312,7 +312,7 @@ void Hal_SetAntennaPathPower(struct adapter *pAdapter)
 	case RF_6052:
 		Hal_SetCCKTxPower(pAdapter, TxPowerLevel);
 		if (pAdapter->mppriv.rateidx < MPT_RATE_6M)	/*  CCK rate */
-			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath]%2 == 0);
+			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath] % 2 == 0);
 		Hal_SetOFDMTxPower(pAdapter, TxPowerLevel);
 		break;
 	default:
@@ -351,7 +351,7 @@ void Hal_SetTxPower(struct adapter *pAdapter)
 	case RF_6052:
 		Hal_SetCCKTxPower(pAdapter, TxPowerLevel);
 		if (pAdapter->mppriv.rateidx < MPT_RATE_6M)	/*  CCK rate */
-			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath]%2 == 0);
+			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath] % 2 == 0);
 		Hal_SetOFDMTxPower(pAdapter, TxPowerLevel);
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 9af91ec92d36..30a9dca8f453 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -47,7 +47,7 @@ static	u32 phy_CalculateBitShift(u32 BitMask)
 	u32 i;
 
 	for (i = 0; i <= 31; i++) {
-		if (((BitMask>>i) &  0x1) == 1)
+		if (((BitMask >> i) & 0x1) == 1)
 			break;
 	}
 	return i;
@@ -167,9 +167,9 @@ phy_RFSerialRead(
 	else
 		tmplong2 = PHY_QueryBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord);
 
-	tmplong2 = (tmplong2 & (~bLSSIReadAddress)) | (NewOffset<<23) | bLSSIReadEdge;	/* T65 RF */
+	tmplong2 = (tmplong2 & (~bLSSIReadAddress)) | (NewOffset << 23) | bLSSIReadEdge;	/* T65 RF */
 
-	PHY_SetBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord, tmplong&(~bLSSIReadEdge));
+	PHY_SetBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord, tmplong & (~bLSSIReadEdge));
 	udelay(10);/*  PlatformStallExecution(10); */
 
 	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord, tmplong2);
@@ -258,7 +258,7 @@ phy_RFSerialWrite(
 	/*  */
 	/*  Put write addr in [5:0]  and write data in [31:16] */
 	/*  */
-	DataAndAddr = ((NewOffset<<20) | (Data&0x000fffff)) & 0x0fffffff;	/*  T65 RF */
+	DataAndAddr = ((NewOffset << 20) | (Data & 0x000fffff)) & 0x0fffffff;	/*  T65 RF */
 
 	/*  */
 	/*  Write Operation */
@@ -582,11 +582,11 @@ PHY_BBConfig8188E(
 
 	/*  Enable BB and RF */
 	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN);
-	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal|BIT(13)|BIT(0)|BIT(1)));
+	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal | BIT(13) | BIT(0) | BIT(1)));
 
 	/*  20090923 Joseph: Advised by Steven and Jenyu. Power sequence before init RF. */
 
-	rtw_write8(Adapter, REG_RF_CTRL, RF_EN|RF_RSTB|RF_SDMRSTB);
+	rtw_write8(Adapter, REG_RF_CTRL, RF_EN | RF_RSTB | RF_SDMRSTB);
 
 	rtw_write8(Adapter, REG_SYS_FUNC_EN, FEN_USBA | FEN_USBD | FEN_BB_GLB_RSTn | FEN_BBRSTB);
 
@@ -787,10 +787,10 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 			/*  1. CCK */
 			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
 			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
 				pHalData->OFDM_24G_Diff[TxCount][RF_PATH_A];
 			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
 				pHalData->BW20_24G_Diff[TxCount][RF_PATH_A];
 			/* 2. BW40 */
 			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
@@ -798,12 +798,12 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 			/*  1. CCK */
 			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
 			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
 			pHalData->BW20_24G_Diff[TxCount][index];
 			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[TxCount][RF_PATH_A]+
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[TxCount][RF_PATH_A] +
 			pHalData->BW20_24G_Diff[TxCount][index];
 			/* 2. BW40 */
 			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
@@ -811,14 +811,14 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 			/*  1. CCK */
 			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
 			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
 			pHalData->BW20_24G_Diff[TxCount][index];
 			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
 			pHalData->BW20_24G_Diff[TxCount][index];
 			/* 2. BW40 */
 			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
@@ -826,17 +826,17 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 			/*  1. CCK */
 			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
 			/* 2. OFDM */
-			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_C][index]+
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_C][index] +
 			pHalData->BW20_24G_Diff[TxCount][index];
 
 			/*  1. BW20 */
-			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
-			pHalData->BW20_24G_Diff[RF_PATH_C][index]+
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
+			pHalData->BW20_24G_Diff[RF_PATH_C][index] +
 			pHalData->BW20_24G_Diff[TxCount][index];
 
 			/* 2. BW40 */
@@ -976,7 +976,7 @@ _PHY_SetBWMode92C(
 	/* 3 */
 
 	regBwOpMode = rtw_read8(Adapter, REG_BWOPMODE);
-	regRRSR_RSC = rtw_read8(Adapter, REG_RRSR+2);
+	regRRSR_RSC = rtw_read8(Adapter, REG_RRSR + 2);
 
 	switch (pHalData->CurrentChannelBW) {
 	case HT_CHANNEL_WIDTH_20:
@@ -988,8 +988,8 @@ _PHY_SetBWMode92C(
 		regBwOpMode &= ~BW_OPMODE_20MHZ;
 		/*  2007/02/07 Mark by Emily because we have not verify whether this register works */
 		rtw_write8(Adapter, REG_BWOPMODE, regBwOpMode);
-		regRRSR_RSC = (regRRSR_RSC&0x90) | (pHalData->nCur40MhzPrimeSC<<5);
-		rtw_write8(Adapter, REG_RRSR+2, regRRSR_RSC);
+		regRRSR_RSC = (regRRSR_RSC & 0x90) | (pHalData->nCur40MhzPrimeSC << 5);
+		rtw_write8(Adapter, REG_RRSR + 2, regRRSR_RSC);
 		break;
 	default:
 		break;
@@ -1009,7 +1009,7 @@ _PHY_SetBWMode92C(
 		PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bRFMOD, 0x1);
 		PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x1);
 		/*  Set Control channel to upper or lower. These settings are required only for 40MHz */
-		PHY_SetBBReg(Adapter, rCCK0_System, bCCKSideBand, (pHalData->nCur40MhzPrimeSC>>1));
+		PHY_SetBBReg(Adapter, rCCK0_System, bCCKSideBand, (pHalData->nCur40MhzPrimeSC >> 1));
 		PHY_SetBBReg(Adapter, rOFDM1_LSTF, 0xC00, pHalData->nCur40MhzPrimeSC);
 		PHY_SetBBReg(Adapter, 0x818, (BIT(26) | BIT(27)),
 			     (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) ? 2 : 1);
-- 
2.32.0

