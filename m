Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3866E4297FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhJKUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhJKUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:14:32 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D933C061749
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:12:31 -0700 (PDT)
Received: from dslb-188-097-046-226.188.097.pools.vodafone-ip.de ([188.97.46.226] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ma1es-0004mk-H5; Mon, 11 Oct 2021 22:12:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/8] staging: r8188eu: SupportICType is always ODM_RTL8188E
Date:   Mon, 11 Oct 2021 22:11:56 +0200
Message-Id: <20211011201159.10252-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211011201159.10252-1-martin@kaiser.cx>
References: <20211011201159.10252-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SupportICType in struct odm_dm_struct is always ODM_RTL8188E. Remove the
component and code that is executed only for other types.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c          | 172 +++++----------------
 drivers/staging/r8188eu/hal/odm_HWConfig.c |  58 ++++---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c |   5 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c  |   2 -
 drivers/staging/r8188eu/include/odm.h      |  15 --
 5 files changed, 68 insertions(+), 184 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 5bb5ce950438..abd0b1c8c5cd 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -225,9 +225,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_MP_TEST_CHIP:
 		pDM_Odm->bIsMPChip = (u8)Value;
 		break;
-	case	ODM_CMNINFO_IC_TYPE:
-		pDM_Odm->SupportICType = Value;
-		break;
 	case	ODM_CMNINFO_RF_TYPE:
 		pDM_Odm->RFType = (u8)Value;
 		break;
@@ -377,10 +374,6 @@ void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
 {
 	pDM_Odm->bCckHighPower = (bool)ODM_GetBBReg(pDM_Odm, 0x824, BIT(9));
 	pDM_Odm->RFPathRxEnable = (u8)ODM_GetBBReg(pDM_Odm, 0xc04, 0x0F);
-	if (pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8192D))
-		pDM_Odm->AntDivType = CG_TRX_HW_ANTDIV;
-	if (pDM_Odm->SupportICType & (ODM_RTL8723A))
-		pDM_Odm->AntDivType = CGCS_RX_SW_ANTDIV;
 }
 
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
@@ -467,86 +460,43 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	if (!pDM_Odm->bDMInitialGainEnable)
 		return;
 
-	if (pDM_Odm->SupportICType == ODM_RTL8192D) {
-		if (*pDM_Odm->pMacPhyMode == ODM_DMSP) {
-			if (*pDM_Odm->pbMasterOfDMSP) {
-				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
-				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
-				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
-			} else {
-				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_1;
-				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_1);
-				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
-			}
-		} else {
-			DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_1;
-			FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_1);
-			FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
-		}
-	} else {
-		DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
-		FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
-		FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
-	}
+	DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
+	FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
+	FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
 
 	/* 1 Boundary Decision */
-	if ((pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8723A)) &&
-	    (pDM_Odm->BoardType == ODM_BOARD_HIGHPWR)) {
-		if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
-			dm_dig_max = DM_DIG_MAX_AP_HP;
-			dm_dig_min = DM_DIG_MIN_AP_HP;
-		} else {
-			dm_dig_max = DM_DIG_MAX_NIC_HP;
-			dm_dig_min = DM_DIG_MIN_NIC_HP;
-		}
-		DIG_MaxOfMin = DM_DIG_MAX_AP_HP;
+	if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
+		dm_dig_max = DM_DIG_MAX_AP;
+		dm_dig_min = DM_DIG_MIN_AP;
+		DIG_MaxOfMin = dm_dig_max;
 	} else {
-		if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
-			dm_dig_max = DM_DIG_MAX_AP;
-			dm_dig_min = DM_DIG_MIN_AP;
-			DIG_MaxOfMin = dm_dig_max;
-		} else {
-			dm_dig_max = DM_DIG_MAX_NIC;
-			dm_dig_min = DM_DIG_MIN_NIC;
-			DIG_MaxOfMin = DM_DIG_MAX_AP;
-		}
+		dm_dig_max = DM_DIG_MAX_NIC;
+		dm_dig_min = DM_DIG_MIN_NIC;
+		DIG_MaxOfMin = DM_DIG_MAX_AP;
 	}
 	if (pDM_Odm->bLinked) {
-	      /* 2 8723A Series, offset need to be 10 */
-		if (pDM_Odm->SupportICType == (ODM_RTL8723A)) {
-			/* 2 Upper Bound */
-			if ((pDM_Odm->RSSI_Min + 10) > DM_DIG_MAX_NIC)
-				pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
-			else if ((pDM_Odm->RSSI_Min + 10) < DM_DIG_MIN_NIC)
-				pDM_DigTable->rx_gain_range_max = DM_DIG_MIN_NIC;
+		/* 2 8723A Series, offset need to be 10 */
+		/* 2 Modify DIG upper bound */
+		if ((pDM_Odm->RSSI_Min + 20) > dm_dig_max)
+			pDM_DigTable->rx_gain_range_max = dm_dig_max;
+		else if ((pDM_Odm->RSSI_Min + 20) < dm_dig_min)
+			pDM_DigTable->rx_gain_range_max = dm_dig_min;
+		else
+			pDM_DigTable->rx_gain_range_max = pDM_Odm->RSSI_Min + 20;
+		/* 2 Modify DIG lower bound */
+		if (pDM_Odm->bOneEntryOnly) {
+			if (pDM_Odm->RSSI_Min < dm_dig_min)
+				DIG_Dynamic_MIN = dm_dig_min;
+			else if (pDM_Odm->RSSI_Min > DIG_MaxOfMin)
+				DIG_Dynamic_MIN = DIG_MaxOfMin;
 			else
-				pDM_DigTable->rx_gain_range_max = pDM_Odm->RSSI_Min + 10;
-			/* 2 If BT is Concurrent, need to set Lower Bound */
-			DIG_Dynamic_MIN = DM_DIG_MIN_NIC;
+				DIG_Dynamic_MIN = pDM_Odm->RSSI_Min;
+		} else if (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV) {
+			/* 1 Lower Bound for 88E AntDiv */
+			if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)
+				DIG_Dynamic_MIN = (u8)pDM_DigTable->AntDiv_RSSI_max;
 		} else {
-			/* 2 Modify DIG upper bound */
-			if ((pDM_Odm->RSSI_Min + 20) > dm_dig_max)
-				pDM_DigTable->rx_gain_range_max = dm_dig_max;
-			else if ((pDM_Odm->RSSI_Min + 20) < dm_dig_min)
-				pDM_DigTable->rx_gain_range_max = dm_dig_min;
-			else
-				pDM_DigTable->rx_gain_range_max = pDM_Odm->RSSI_Min + 20;
-			/* 2 Modify DIG lower bound */
-			if (pDM_Odm->bOneEntryOnly) {
-				if (pDM_Odm->RSSI_Min < dm_dig_min)
-					DIG_Dynamic_MIN = dm_dig_min;
-				else if (pDM_Odm->RSSI_Min > DIG_MaxOfMin)
-					DIG_Dynamic_MIN = DIG_MaxOfMin;
-				else
-					DIG_Dynamic_MIN = pDM_Odm->RSSI_Min;
-			} else if ((pDM_Odm->SupportICType == ODM_RTL8188E) &&
-				   (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
-				/* 1 Lower Bound for 88E AntDiv */
-				if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)
-					DIG_Dynamic_MIN = (u8)pDM_DigTable->AntDiv_RSSI_max;
-			} else {
-				DIG_Dynamic_MIN = dm_dig_min;
-			}
+			DIG_Dynamic_MIN = dm_dig_min;
 		}
 	} else {
 		pDM_DigTable->rx_gain_range_max = dm_dig_max;
@@ -594,21 +544,12 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 		if (FirstConnect) {
 			CurrentIGI = pDM_Odm->RSSI_Min;
 		} else {
-			if (pDM_Odm->SupportICType == ODM_RTL8192D) {
-				if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_92D)
-					CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
-				else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1_92D)
-					CurrentIGI = CurrentIGI + 1; /* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
-				else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0_92D)
-					CurrentIGI = CurrentIGI - 1;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
-			} else {
-				if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2)
-						CurrentIGI = CurrentIGI + 4;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
-				else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1)
-						CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
-				else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0)
-						CurrentIGI = CurrentIGI - 2;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
-			}
+			if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2)
+					CurrentIGI = CurrentIGI + 4;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
+			else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1)
+					CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
+			else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0)
+					CurrentIGI = CurrentIGI - 2;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
 		}
 	} else {
 		if (FirstDisConnect) {
@@ -668,11 +609,9 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 				     FalseAlmCnt->Cnt_Crc8_fail + FalseAlmCnt->Cnt_Mcs_fail +
 				     FalseAlmCnt->Cnt_Fast_Fsync + FalseAlmCnt->Cnt_SB_Search_fail;
 
-	if (pDM_Odm->SupportICType == ODM_RTL8188E) {
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_SC_CNT_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_BW_LSC = (ret_value & 0xffff);
-		FalseAlmCnt->Cnt_BW_USC = ((ret_value & 0xffff0000) >> 16);
-	}
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_SC_CNT_11N, bMaskDWord);
+	FalseAlmCnt->Cnt_BW_LSC = (ret_value & 0xffff);
+	FalseAlmCnt->Cnt_BW_USC = ((ret_value & 0xffff0000) >> 16);
 
 	/* hold cck counter */
 	ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(12), 1);
@@ -695,24 +634,6 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 				FalseAlmCnt->Cnt_Cck_fail);
 
 	FalseAlmCnt->Cnt_CCA_all = FalseAlmCnt->Cnt_OFDM_CCA + FalseAlmCnt->Cnt_CCK_CCA;
-
-	if (pDM_Odm->SupportICType >= ODM_RTL8723A) {
-		/* reset false alarm counter registers */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 1);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 0);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 1);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 0);
-		/* update ofdm counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 0); /* update page C counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 0); /* update page D counter */
-
-		/* reset CCK CCA counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 0);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 2);
-		/* reset CCK FA counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 0);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 2);
-	}
 }
 
 /* 3============================================================ */
@@ -807,10 +728,6 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 
 	if (pDM_PSTable->pre_rf_state != pDM_PSTable->cur_rf_state) {
 		if (pDM_PSTable->cur_rf_state == RF_Save) {
-			/*  <tynli_note> 8723 RSSI report will be wrong. Set 0x874[5]=1 when enter BB power saving mode. */
-			/*  Suggested by SD3 Yu-Nan. 2011.01.20. */
-			if (pDM_Odm->SupportICType == ODM_RTL8723A)
-				ODM_SetBBReg(pDM_Odm, 0x874, BIT(5), 0x1); /* Reg874[5]=1b'1 */
 			ODM_SetBBReg(pDM_Odm, 0x874, 0x1C0000, 0x2); /* Reg874[20:18]=3'b010 */
 			ODM_SetBBReg(pDM_Odm, 0xc70, BIT(3), 0); /* RegC70[3]=1'b0 */
 			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, 0x63); /* Reg85C[31:24]=0x63 */
@@ -824,9 +741,6 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, pDM_PSTable->reg_85c);
 			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, pDM_PSTable->reg_a74);
 			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x0);
-
-			if (pDM_Odm->SupportICType == ODM_RTL8723A)
-				ODM_SetBBReg(pDM_Odm, 0x874, BIT(5), 0x0); /* Reg874[5]=1b'0 */
 		}
 		pDM_PSTable->pre_rf_state = pDM_PSTable->cur_rf_state;
 	}
@@ -1242,10 +1156,7 @@ void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
 	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
 
-	if (pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8192D))
-		;
-	else if (pDM_Odm->SupportICType == ODM_RTL8188E)
-		ODM_AntennaDiversityInit_88E(pDM_Odm);
+	ODM_AntennaDiversityInit_88E(pDM_Odm);
 }
 
 void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId, u32 PWDBAll, bool isCCKrate)
@@ -1274,8 +1185,7 @@ void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
 	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
 
-	if (pDM_Odm->SupportICType == ODM_RTL8188E)
-		ODM_AntennaDiversity_88E(pDM_Odm);
+	ODM_AntennaDiversity_88E(pDM_Odm);
 }
 
 /* EDCA Turbo */
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 8e419fd88a12..c36b4beeb216 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -254,6 +254,8 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	u32 OFDM_pkt = 0;
 	u32 Weighting = 0;
 	struct sta_info *pEntry;
+	u8 antsel_tr_mux;
+	struct fast_ant_train *pDM_FatTable = &dm_odm->DM_FatTable;
 
 	if (pPktinfo->StationID == 0xFF)
 		return;
@@ -266,28 +268,24 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
 
 	/* Smart Antenna Debug Message------------------  */
-	if (dm_odm->SupportICType == ODM_RTL8188E) {
-		u8 antsel_tr_mux;
-		struct fast_ant_train *pDM_FatTable = &dm_odm->DM_FatTable;
-
-		if (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV) {
-			if (pDM_FatTable->FAT_State == FAT_TRAINING_STATE) {
-				if (pPktinfo->bPacketToSelf) {
-					antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
-							(pDM_FatTable->antsel_rx_keep_1 << 1) |
-							pDM_FatTable->antsel_rx_keep_0;
-					pDM_FatTable->antSumRSSI[antsel_tr_mux] += pPhyInfo->RxPWDBAll;
-					pDM_FatTable->antRSSIcnt[antsel_tr_mux]++;
-				}
-			}
-		} else if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
-			if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
+	if (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV) {
+		if (pDM_FatTable->FAT_State == FAT_TRAINING_STATE) {
+			if (pPktinfo->bPacketToSelf) {
 				antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
-						(pDM_FatTable->antsel_rx_keep_1 << 1) | pDM_FatTable->antsel_rx_keep_0;
-				ODM_AntselStatistics_88E(dm_odm, antsel_tr_mux, pPktinfo->StationID, pPhyInfo->RxPWDBAll);
+						(pDM_FatTable->antsel_rx_keep_1 << 1) |
+						pDM_FatTable->antsel_rx_keep_0;
+				pDM_FatTable->antSumRSSI[antsel_tr_mux] += pPhyInfo->RxPWDBAll;
+				pDM_FatTable->antRSSIcnt[antsel_tr_mux]++;
 			}
 		}
+	} else if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
+		if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
+			antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
+					(pDM_FatTable->antsel_rx_keep_1 << 1) | pDM_FatTable->antsel_rx_keep_0;
+			ODM_AntselStatistics_88E(dm_odm, antsel_tr_mux, pPktinfo->StationID, pPhyInfo->RxPWDBAll);
+		}
 	}
+
 	/* Smart Antenna Debug Message------------------ */
 
 	UndecoratedSmoothedCCK =  pEntry->rssi_stat.UndecoratedSmoothedCCK;
@@ -410,10 +408,8 @@ enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
 					   enum rf_radio_path content,
 					   enum rf_radio_path rfpath)
 {
-	if (dm_odm->SupportICType == ODM_RTL8188E) {
-		if (rfpath == RF_PATH_A)
-			READ_AND_CONFIG(8188E, _RadioA_1T_);
-	}
+	if (rfpath == RF_PATH_A)
+		READ_AND_CONFIG(8188E, _RadioA_1T_);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -421,22 +417,20 @@ enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
 enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *dm_odm,
 					   enum odm_bb_config_type config_tp)
 {
-	if (dm_odm->SupportICType == ODM_RTL8188E) {
-		if (config_tp == CONFIG_BB_PHY_REG) {
-			READ_AND_CONFIG(8188E, _PHY_REG_1T_);
-		} else if (config_tp == CONFIG_BB_AGC_TAB) {
-			READ_AND_CONFIG(8188E, _AGC_TAB_1T_);
-		} else if (config_tp == CONFIG_BB_PHY_REG_PG) {
-			READ_AND_CONFIG(8188E, _PHY_REG_PG_);
-		}
+	if (config_tp == CONFIG_BB_PHY_REG) {
+		READ_AND_CONFIG(8188E, _PHY_REG_1T_);
+	} else if (config_tp == CONFIG_BB_AGC_TAB) {
+		READ_AND_CONFIG(8188E, _AGC_TAB_1T_);
+	} else if (config_tp == CONFIG_BB_PHY_REG_PG) {
+		READ_AND_CONFIG(8188E, _PHY_REG_PG_);
 	}
+
 	return HAL_STATUS_SUCCESS;
 }
 
 enum HAL_STATUS ODM_ConfigMACWithHeaderFile(struct odm_dm_struct *dm_odm)
 {
 	u8 result = HAL_STATUS_SUCCESS;
-	if (dm_odm->SupportICType == ODM_RTL8188E)
-		result = READ_AND_CONFIG(8188E, _MAC_REG_);
+	result = READ_AND_CONFIG(8188E, _MAC_REG_);
 	return result;
 }
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index ed1db2716aa3..e7a765f375d6 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -129,9 +129,6 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 
 void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *dm_odm)
 {
-	if (dm_odm->SupportICType != ODM_RTL8188E)
-		return;
-
 	if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)
 		odm_RX_HWAntDivInit(dm_odm);
 	else if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
@@ -270,7 +267,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
 {
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
-	if ((dm_odm->SupportICType != ODM_RTL8188E) || (!(dm_odm->SupportAbility & ODM_BB_ANT_DIV)))
+	if (!(dm_odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
 	if (!dm_odm->bLinked) {
 		if (dm_fat_tbl->bBecomeLinked) {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 6a96194bbc26..3a7e01540516 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -37,8 +37,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, ODM_ITRF_USB);
 
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_IC_TYPE, ODM_RTL8188E);
-
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
 
 	if (hal_data->rf_type == RF_1T1R)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index f4b427cfaeee..7097d1b495fb 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -265,7 +265,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_ABILITY,		/* ODM_ABILITY_E */
 	ODM_CMNINFO_INTERFACE,		/* ODM_INTERFACE_E */
 	ODM_CMNINFO_MP_TEST_CHIP,
-	ODM_CMNINFO_IC_TYPE,		/* ODM_IC_TYPE_E */
 	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
 	ODM_CMNINFO_BOARD_TYPE,		/* ODM_BOARD_TYPE_E */
 	/* HOOK BEFORE REG INIT-----------  */
@@ -354,17 +353,6 @@ enum odm_interface_def {
 	ODM_ITRF_ALL	=	0x7,
 };
 
-/*  ODM_CMNINFO_IC_TYPE */
-enum odm_ic_type {
-	ODM_RTL8192S	=	BIT(0),
-	ODM_RTL8192C	=	BIT(1),
-	ODM_RTL8192D	=	BIT(2),
-	ODM_RTL8723A	=	BIT(3),
-	ODM_RTL8188E	=	BIT(4),
-	ODM_RTL8812	=	BIT(5),
-	ODM_RTL8821	=	BIT(6),
-};
-
 /*  ODM_CMNINFO_RF_TYPE */
 /*  For example 1T2R (A+AB = BIT(0)|BIT(4)|BIT(5)) */
 enum odm_rf_path {
@@ -638,9 +626,6 @@ struct odm_dm_struct {
 	u32	SupportAbility;
 	/*  ODM PCIE/USB/SDIO/GSPI = 0/1/2/3 */
 	u8	SupportInterface;
-	/*  ODM composite or independent. Bit oriented/ 92C+92D+ .... or any
-	 *  other type = 1/2/3/... */
-	u32	SupportICType;
 	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
 	u8	RFType;
 	/*  Board Type Normal/HighPower/MiniCard/SLIM/Combo/. = 0/1/2/3/4/. */
-- 
2.20.1

