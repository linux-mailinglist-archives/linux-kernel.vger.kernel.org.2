Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C913C3DC1F1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhGaAY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhGaAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7EAC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k4so2523685wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kViqcxHDkxJx/PblHc8DWQVhUvQLc+5bGJ238RqSYNw=;
        b=YTF6ZfANcc9fJNPrv47RgtMswJ17Wbs7Te8mIr1lhBP9VBqZRy8ssel4v5pJD/Dp47
         nu7jpl9H258re37/AQfkh6busPfQET1NPVlgckv89zeNSHmBkXGX12KjbsEgV4z0HND0
         7bxtuEXNpgAWWn4y2ab4NNaFFq+RIwwcmx5lMpU1gSOXgktszLlKJpEQowYH03cc8yiD
         c8DwXWBiUqqvPK0JikGtzVIskqETiQ1tMemibiDCuBBpOnTznZ5DBpo+rQmF/5582PHm
         U/NDMbi00p7QQH0Z5m9vr6pxN72Y+mzPvOWrtEnA2r6c6sIsfHSBzb+ngB1bet5BMW8H
         ZZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kViqcxHDkxJx/PblHc8DWQVhUvQLc+5bGJ238RqSYNw=;
        b=diFJaX3mq9OKENxhVAnik+ViEbre6prEsF6E9vaOiBUHkxuZFa6ZARmYdYDtjjtTfj
         rB3OUOchrTJwn4MgscN0X/MKZ5gUZq9g7mOmOQa8L+Bk7vWepObDXlCruKYLSFfD4Rz4
         Qxmyeh50ZpyVO8E9DVPA64eT6sFFwzBwloJSSzDpLpEM51HDxX6hE9ynwEwQzwx8QaaB
         TefSbde5REpv5ltcblqFY61P8xmcWjTowUMAqtkCONq8F3nDGFUec3LxvY0u4WRPmDJc
         +Zg59k6EAaV6jU0ZsQI0JaKO+Di91XqwNjdxUF9CM0NMQvCPG0ann/DeLpVT4I/GrH+o
         9HRg==
X-Gm-Message-State: AOAM532yexJvh+Wrt+WAxt41Dt6U5rEEp7QbDLRpHLtg39/Ao7KRsCHE
        9mJdDTR0yV/2fTj4Yi1h6SBwuw==
X-Google-Smtp-Source: ABdhPJzL4ChiuAGMSxy/tZiDlcMsr625Fv1LVEcAB/osgFPOvyaFfztFyeTktCSq42hJ13E9N9eZeg==
X-Received: by 2002:adf:f485:: with SMTP id l5mr5605396wro.8.1627691043606;
        Fri, 30 Jul 2021 17:24:03 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:24:03 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm.c
Date:   Sat, 31 Jul 2021 01:23:50 +0100
Message-Id: <20210731002353.68479-12-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE calls from hal/odm.c, as by removing these calls
in this file and others, we can ultimately then remove the macro
definition itself, which does not follow best practice.

Also remove three empty functions and their calls from hal/odm.c, as
they only contained ODM_RT_TRACE calls, and remove the corresponding
include/odm_precomp.h declarations.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/odm.c             | 190 ++----------------
 drivers/staging/r8188eu/include/odm_precomp.h |   3 -
 2 files changed, 17 insertions(+), 176 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index fa3973393eda..927e1cce999e 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -160,7 +160,6 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 {
 	/* 2012.05.03 Luke: For all IC series */
 	odm_CommonInfoSelfInit(pDM_Odm);
-	odm_CmnInfoInit_Debug(pDM_Odm);
 	odm_DIGInit(pDM_Odm);
 	odm_RateAdaptiveMaskInit(pDM_Odm);
 
@@ -189,8 +188,6 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 {
 	/* 2012.05.03 Luke: For all IC series */
 	odm_GlobalAdapterCheck();
-	odm_CmnInfoHook_Debug(pDM_Odm);
-	odm_CmnInfoUpdate_Debug(pDM_Odm);
 	odm_CommonInfoSelfUpdate(pDM_Odm);
 	odm_FalseAlarmCounterStatistics(pDM_Odm);
 	odm_RSSIMonitorCheck(pDM_Odm);
@@ -202,13 +199,10 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 	if ((pDM_Odm->Adapter->pwrctrlpriv.pwr_mode != PS_MODE_ACTIVE) &&/*  in LPS mode */
 	    ((pDM_Odm->SupportICType & (ODM_RTL8723A)) ||
 	    (pDM_Odm->SupportICType & (ODM_RTL8188E) &&
-	    ((pDM_Odm->SupportInterface  == ODM_ITRF_SDIO))))) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("----Step1: odm_DIG is in LPS mode\n"));
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("---Step2: 8723AS is in LPS mode\n"));
+	    ((pDM_Odm->SupportInterface  == ODM_ITRF_SDIO)))))
 		odm_DIGbyRSSI_LPS(pDM_Odm);
-	} else {
+	else
 		odm_DIG(pDM_Odm);
-	}
 	odm_CCKPacketDetectionThresh(pDM_Odm);
 
 	if (*(pDM_Odm->pbPowerSaving))
@@ -475,53 +469,6 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 		pDM_Odm->bOneEntryOnly = false;
 }
 
-void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm)
-{
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoInit_Debug==>\n"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportPlatform=%d\n", pDM_Odm->SupportPlatform));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportAbility=0x%x\n", pDM_Odm->SupportAbility));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportInterface=%d\n", pDM_Odm->SupportInterface));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportICType=0x%x\n", pDM_Odm->SupportICType));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("CutVersion=%d\n", pDM_Odm->CutVersion));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("FabVersion=%d\n", pDM_Odm->FabVersion));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RFType=%d\n", pDM_Odm->RFType));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("BoardType=%d\n", pDM_Odm->BoardType));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtLNA=%d\n", pDM_Odm->ExtLNA));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtPA=%d\n", pDM_Odm->ExtPA));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtTRSW=%d\n", pDM_Odm->ExtTRSW));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("PatchID=%d\n", pDM_Odm->PatchID));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bInHctTest=%d\n", pDM_Odm->bInHctTest));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFITest=%d\n", pDM_Odm->bWIFITest));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bDualMacSmartConcurrent=%d\n", pDM_Odm->bDualMacSmartConcurrent));
-}
-
-void odm_CmnInfoHook_Debug(struct odm_dm_struct *pDM_Odm)
-{
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoHook_Debug==>\n"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pNumTxBytesUnicast=%llu\n", *(pDM_Odm->pNumTxBytesUnicast)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pNumRxBytesUnicast=%llu\n", *(pDM_Odm->pNumRxBytesUnicast)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pWirelessMode=0x%x\n", *(pDM_Odm->pWirelessMode)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pSecChOffset=%d\n", *(pDM_Odm->pSecChOffset)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pSecurity=%d\n", *(pDM_Odm->pSecurity)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pBandWidth=%d\n", *(pDM_Odm->pBandWidth)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pChannel=%d\n", *(pDM_Odm->pChannel)));
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pbScanInProcess=%d\n", *(pDM_Odm->pbScanInProcess)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pbPowerSaving=%d\n", *(pDM_Odm->pbPowerSaving)));
-
-	if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL))
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pOnePathCCA=%d\n", *(pDM_Odm->pOnePathCCA)));
-}
-
-void odm_CmnInfoUpdate_Debug(struct odm_dm_struct *pDM_Odm)
-{
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoUpdate_Debug==>\n"));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFI_Direct=%d\n", pDM_Odm->bWIFI_Direct));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFI_Display=%d\n", pDM_Odm->bWIFI_Display));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bLinked=%d\n", pDM_Odm->bLinked));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RSSI_Min=%d\n", pDM_Odm->RSSI_Min));
-}
-
 static int getIGIForDiff(int value_IGI)
 {
 	#define ONERCCA_LOW_TH		0x30
@@ -541,10 +488,6 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-		     ("ODM_REG(IGI_A,pDM_Odm)=0x%x, ODM_BIT(IGI,pDM_Odm)=0x%x\n",
-		     ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm)));
-
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
 		if (pDM_Odm->SupportPlatform & (ODM_CE|ODM_MP)) {
 			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
@@ -569,12 +512,9 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 					break;
 				}
 		}
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("CurrentIGI(0x%02x).\n", CurrentIGI));
 		/* pDM_DigTable->PreIGValue = pDM_DigTable->CurIGValue; */
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("ODM_Write_DIG():CurrentIGI=0x%x\n", CurrentIGI));
-
 /*  Add by Neil Chen to enable edcca to MP Platform */
 }
 
@@ -597,7 +537,6 @@ void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm)
 
 	/*  Using FW PS mode to make IGI */
 	if (bFwCurrentInPSMode) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("---Neil---odm_DIG is in LPS mode\n"));
 		/* Adjust by  FA in LPS MODE */
 		if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_LPS)
 			CurrentIGI = CurrentIGI+2;
@@ -669,23 +608,15 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	u8 dm_dig_max, dm_dig_min;
 	u8 CurrentIGI = pDM_DigTable->CurIGValue;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG()==>\n"));
-	if ((!(pDM_Odm->SupportAbility&ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility&ODM_BB_FA_CNT))) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-			     ("odm_DIG() Return: SupportAbility ODM_BB_DIG or ODM_BB_FA_CNT is disabled\n"));
+	if ((!(pDM_Odm->SupportAbility&ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility&ODM_BB_FA_CNT)))
 		return;
-	}
 
-	if (*(pDM_Odm->pbScanInProcess)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() Return: In Scan Progress\n"));
+	if (*(pDM_Odm->pbScanInProcess))
 		return;
-	}
 
 	/* add by Neil Chen to avoid PSD is processing */
-	if (pDM_Odm->bDMInitialGainEnable == false) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() Return: PSD is Processing\n"));
+	if (pDM_Odm->bDMInitialGainEnable == false)
 		return;
-	}
 
 	if (pDM_Odm->SupportICType == ODM_RTL8192D) {
 		if (*(pDM_Odm->pMacPhyMode) == ODM_DMSP) {
@@ -765,21 +696,11 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 					DIG_Dynamic_MIN = DIG_MaxOfMin;
 				else
 					DIG_Dynamic_MIN = pDM_Odm->RSSI_Min;
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-					     ("odm_DIG() : bOneEntryOnly=true,  DIG_Dynamic_MIN=0x%x\n",
-					     DIG_Dynamic_MIN));
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-					     ("odm_DIG() : pDM_Odm->RSSI_Min=%d\n",
-					     pDM_Odm->RSSI_Min));
 			} else if ((pDM_Odm->SupportICType == ODM_RTL8188E) &&
 				   (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
 				/* 1 Lower Bound for 88E AntDiv */
-				if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV) {
+				if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)
 					DIG_Dynamic_MIN = (u8) pDM_DigTable->AntDiv_RSSI_max;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-						     ("odm_DIG(): pDM_DigTable->AntDiv_RSSI_max=%d\n",
-						     pDM_DigTable->AntDiv_RSSI_max));
-				}
 			} else {
 				DIG_Dynamic_MIN = dm_dig_min;
 			}
@@ -787,13 +708,10 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	} else {
 		pDM_DigTable->rx_gain_range_max = dm_dig_max;
 		DIG_Dynamic_MIN = dm_dig_min;
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() : No Link\n"));
 	}
 
 	/* 1 Modify DIG lower bound, deal with abnormally large false alarm */
 	if (pFalseAlmCnt->Cnt_all > 10000) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("dm_DIG(): Abnornally false alarm case.\n"));
-
 		if (pDM_DigTable->LargeFAHit != 3)
 			pDM_DigTable->LargeFAHit++;
 		if (pDM_DigTable->ForbiddenIGI < CurrentIGI) {
@@ -818,27 +736,20 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				if ((pDM_DigTable->ForbiddenIGI-1) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
 					pDM_DigTable->ForbiddenIGI = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
 					pDM_DigTable->rx_gain_range_min = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Normal Case: At Lower Bound\n"));
 				} else {
 					pDM_DigTable->ForbiddenIGI--;
 					pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Normal Case: Approach Lower Bound\n"));
 				}
 			} else {
 				pDM_DigTable->LargeFAHit = 0;
 			}
 		}
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-		     ("odm_DIG(): pDM_DigTable->LargeFAHit=%d\n",
-		     pDM_DigTable->LargeFAHit));
 
 	/* 1 Adjust initial gain by false alarm */
 	if (pDM_Odm->bLinked) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): DIG AfterLink\n"));
 		if (FirstConnect) {
 			CurrentIGI = pDM_Odm->RSSI_Min;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("DIG: First Connect\n"));
 		} else {
 			if (pDM_Odm->SupportICType == ODM_RTL8192D) {
 				if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_92D)
@@ -857,10 +768,8 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 			}
 		}
 	} else {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): DIG BeforeLink\n"));
 		if (FirstDisConnect) {
 			CurrentIGI = pDM_DigTable->rx_gain_range_min;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): First DisConnect\n"));
 		} else {
 			/* 2012.03.30 LukeLee: enable DIG before link but with very high thresholds */
 			if (pFalseAlmCnt->Cnt_all > 10000)
@@ -869,22 +778,14 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				CurrentIGI = CurrentIGI + 1;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
 			else if (pFalseAlmCnt->Cnt_all < 500)
 				CurrentIGI = CurrentIGI - 1;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): England DIG\n"));
 		}
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): DIG End Adjust IGI\n"));
 	/* 1 Check initial gain by upper/lower bound */
 	if (CurrentIGI > pDM_DigTable->rx_gain_range_max)
 		CurrentIGI = pDM_DigTable->rx_gain_range_max;
 	if (CurrentIGI < pDM_DigTable->rx_gain_range_min)
 		CurrentIGI = pDM_DigTable->rx_gain_range_min;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-		     ("odm_DIG(): rx_gain_range_max=0x%x, rx_gain_range_min=0x%x\n",
-		     pDM_DigTable->rx_gain_range_max, pDM_DigTable->rx_gain_range_min));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): TotalFA=%d\n", pFalseAlmCnt->Cnt_all));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): CurIGValue=0x%x\n", CurrentIGI));
-
 	/* 2 High power RSSI threshold */
 
 	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
@@ -970,17 +871,6 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT15|BIT14, 0);
 			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT15|BIT14, 2);
 		}
-
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Enter odm_FalseAlarmCounterStatistics\n"));
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
-			     ("Cnt_Fast_Fsync=%d, Cnt_SB_Search_fail=%d\n",
-			     FalseAlmCnt->Cnt_Fast_Fsync, FalseAlmCnt->Cnt_SB_Search_fail));
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
-			     ("Cnt_Parity_Fail=%d, Cnt_Rate_Illegal=%d\n",
-			     FalseAlmCnt->Cnt_Parity_Fail, FalseAlmCnt->Cnt_Rate_Illegal));
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
-			     ("Cnt_Crc8_fail=%d, Cnt_Mcs_fail=%d\n",
-			     FalseAlmCnt->Cnt_Crc8_fail, FalseAlmCnt->Cnt_Mcs_fail));
 	} else { /* FOR ODM_IC_11AC_SERIES */
 		/* read OFDM FA counter */
 		FalseAlmCnt->Cnt_Ofdm_fail = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_11AC, bMaskLWord);
@@ -994,9 +884,6 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT15, 0);
 		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT15, 1);
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Cnt_Cck_fail=%d\n", FalseAlmCnt->Cnt_Cck_fail));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Cnt_Ofdm_fail=%d\n", FalseAlmCnt->Cnt_Ofdm_fail));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Total False Alarm=%d\n", FalseAlmCnt->Cnt_all));
 }
 
 /* 3============================================================ */
@@ -1266,10 +1153,6 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 		break;
 	}
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD,
-		     (" ==> rssi_level:0x%02x, WirelessMode:0x%02x, rate_bitmap:0x%08x\n",
-		     rssi_level, WirelessMode, rate_bitmap));
-
 	return rate_bitmap;
 }
 
@@ -1321,25 +1204,17 @@ void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm)
 	u8 i;
 	struct adapter *pAdapter = pDM_Odm->Adapter;
 
-	if (pAdapter->bDriverStopped) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_TRACE, ("<---- odm_RefreshRateAdaptiveMask(): driver is going to unload\n"));
+	if (pAdapter->bDriverStopped)
 		return;
-	}
 
-	if (!pDM_Odm->bUseRAMask) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("<---- odm_RefreshRateAdaptiveMask(): driver does not control rate adaptive mask\n"));
+	if (!pDM_Odm->bUseRAMask)
 		return;
-	}
 
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(pstat)) {
-			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false , &pstat->rssi_level)) {
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD,
-					     ("RSSI:%d, RSSI_LEVEL:%d\n",
-					     pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level));
+			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false , &pstat->rssi_level))
 				rtw_hal_update_ra_mask(pAdapter, i, pstat->rssi_level);
-			}
 		}
 	}
 }
@@ -1385,7 +1260,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 		RATRState = DM_RATR_STA_LOW;
 
 	if (*pRATRState != RATRState || bForceUpdate) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("RSSI Level %d -> %d\n", *pRATRState, RATRState));
 		*pRATRState = RATRState;
 		return true;
 	}
@@ -1681,10 +1555,8 @@ void odm_SwAntDivChkAntSwitchCallback(struct timer_list *t)
 
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
 {
-	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Return: Not Support HW AntDiv\n"));
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
-	}
 
 	if (pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8192D))
 		;
@@ -1715,10 +1587,8 @@ void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId, u32 PWDBA
 
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
 {
-	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Return: Not Support HW AntDiv\n"));
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
-	}
 
 	if (pDM_Odm->SupportICType == ODM_RTL8188E)
 		ODM_AntennaDiversity_88E(pDM_Odm);
@@ -1732,10 +1602,6 @@ void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->DM_EDCA_Table.bIsCurRDLState = false;
 	Adapter->recvpriv.bIsAnyNonBEPkts = false;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial VO PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_VO_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial VI PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_VI_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial BE PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_BE_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial BK PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_BK_PARAM)));
 }	/*  ODM_InitEdcaTurbo */
 
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
@@ -1743,8 +1609,6 @@ void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
 	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
 	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
 	/*  HW dynamic mechanism. */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("odm_EdcaTurboCheck========================>\n"));
-
 	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
 		return;
 
@@ -1758,7 +1622,6 @@ void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
 	case	ODM_ADSL:
 		break;
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("<========================odm_EdcaTurboCheck\n"));
 }	/*  odm_CheckEdcaTurbo */
 
 void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
@@ -2073,44 +1936,30 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 	/* Reload AFE Registers */
 	odm_PHY_ReloadAFERegisters(pDM_Odm, AFE_REG_8723A, AFE_Backup, 16);
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("psd_report_A[%d]= %d\n", 2416, AntA_report));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("psd_report_B[%d]= %d\n", 2416, AntB_report));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("psd_report_O[%d]= %d\n", 2416, AntO_report));
-
 	if (pDM_Odm->SupportICType == ODM_RTL8723A) {
 	/* 2 Test Ant B based on Ant A is ON */
 		if (mode == ANTTESTB) {
 			if (AntA_report >= 100) {
-				if (AntB_report > (AntA_report+1)) {
+				if (AntB_report > (AntA_report+1))
 					pDM_SWAT_Table->ANTB_ON = false;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Single Antenna A\n"));
-				} else {
+				else
 					pDM_SWAT_Table->ANTB_ON = true;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Dual Antenna is A and B\n"));
-				}
 			} else {
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Need to check again\n"));
 				pDM_SWAT_Table->ANTB_ON = false; /*  Set Antenna B off as default */
 				bResult = false;
 			}
 		} else if (mode == ANTTESTALL) {
 			/* 2 Test Ant A and B based on DPDT Open */
 			if ((AntO_report >= 100)&(AntO_report < 118)) {
-				if (AntA_report > (AntO_report+1)) {
+				if (AntA_report > (AntO_report+1))
 					pDM_SWAT_Table->ANTA_ON = false;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant A is OFF"));
-				} else {
+				else
 					pDM_SWAT_Table->ANTA_ON = true;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant A is ON"));
-				}
 
-				if (AntB_report > (AntO_report+2)) {
+				if (AntB_report > (AntO_report+2))
 					pDM_SWAT_Table->ANTB_ON = false;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant B is OFF"));
-				} else {
+				else
 					pDM_SWAT_Table->ANTB_ON = true;
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant B is ON"));
-				}
 			}
 		}
 	} else if (pDM_Odm->SupportICType == ODM_RTL8192C) {
@@ -2119,20 +1968,15 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 				pDM_SWAT_Table->ANTA_ON = false;
 				pDM_SWAT_Table->ANTB_ON = true;
 				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_B);
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Single Antenna B\n"));
 			} else if (AntA_report > (AntB_report+2)) {
 				pDM_SWAT_Table->ANTA_ON = true;
 				pDM_SWAT_Table->ANTB_ON = false;
 				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_A);
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Single Antenna A\n"));
 			} else {
 				pDM_SWAT_Table->ANTA_ON = true;
 				pDM_SWAT_Table->ANTB_ON = true;
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-					     ("ODM_SingleDualAntennaDetection(): Dual Antenna\n"));
 			}
 		} else {
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Need to check again\n"));
 			pDM_SWAT_Table->ANTA_ON = true; /*  Set Antenna A on as default */
 			pDM_SWAT_Table->ANTB_ON = false; /*  Set Antenna B off as default */
 			bResult = false;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 2ff2e93a759c..9072acd26386 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -36,8 +36,6 @@
 #include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
-void odm_CmnInfoHook_Debug(struct odm_dm_struct *pDM_Odm);
-void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm);
 void odm_DIGInit(struct odm_dm_struct *pDM_Odm);
 void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
@@ -46,7 +44,6 @@ void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivInit_NIC(struct odm_dm_struct *pDM_Odm);
 void odm_GlobalAdapterCheck(void);
-void odm_CmnInfoUpdate_Debug(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_DIG(struct odm_dm_struct *pDM_Odm);
-- 
2.31.1

