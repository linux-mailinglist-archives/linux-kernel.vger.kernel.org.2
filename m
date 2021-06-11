Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677063A38A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhFKA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFKA12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:27:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BDC0617AF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so7462232wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hv5If0dK2FX0fuz+4y/4HPgfUG0IUVtcKgOGjEtxos=;
        b=kfPd6iVh6IcqEiBWxWZ812bmBMj4RVnD57fP42FdbiZkiEQTdv+TQlGNskzDwZZgMi
         uW0AH5mdZmiJVvjjANnB4cBNa8RnSFiEQiJAKWrXpFa5+eeehhTAlZpj/SgFHyun25Tq
         lWc/6gDpdVNsrozF6NSVMv3p0jKOlpUIvDsFDNSnQcCLMAcIaylW1GfJGIoixVtbFikF
         DOuWRRN4hEDPtzWxHMp8yjRXrN0pfP6QSRq2DDe3j8+Y6G8A8uUb2omO4EHVojISpXac
         9mbXJDAoE1Ttj/4+Dvf6R3fuW78s19FXWS2PO7LdaB5jTD9fswT3IM7/lsOQ1Aco4IGC
         +oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hv5If0dK2FX0fuz+4y/4HPgfUG0IUVtcKgOGjEtxos=;
        b=AWNqGq4fZbqWnohJv1JY+wOMviE3dtihiwlS+r0x80dBfOFXJEmmmQh4G493pskHIM
         /GjlEgg9sNwwejaQoXSLMPInL2pmofWaiQPbkmFuPg0cGKYbp0cN9iu583PHRVKTWmz/
         yQE9QNNG2snRmFZhV1MZigA30PZf3krLj7Q2vqDMmRRcJ946cKqSZVfph0YrGKbf9Mlr
         PBkzFSGYgB3f85V9gfFsyTMnrvz97s6y/il9pox2RrmtTFDdkeSgeBE69MrB6KUkAKPy
         j1j+PkgqyGL8PrFG753wDfh0q8g4rmMEplwF21+nMBrByI6QV3BxM7xyUmqHpfMu+7vT
         Wljw==
X-Gm-Message-State: AOAM531XsMKP+YXuiFsPwRKwrKWYzksZBJIIXVG8Pb1r91pxyoRTk0yM
        5dUlCubtDzxLCGdX+WTi24pNig==
X-Google-Smtp-Source: ABdhPJzs81AaVEdLfM6WJF6PL3I2MMjsbXDZg4HB77e3GJh6/E1aTiZtsulTHatvyY7B9T7VLZpWSA==
X-Received: by 2002:a05:600c:b50:: with SMTP id k16mr1202962wmr.137.1623371112344;
        Thu, 10 Jun 2021 17:25:12 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id c2sm11386189wmf.24.2021.06.10.17.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:25:11 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        kaixuxia@tencent.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        unixbhaskar@gmail.com, gustavoars@kernel.org, martin@kaiser.cx,
        bkkarthik@pesu.pes.edu, dan.carpenter@oracle.com
Subject: [PATCH 4/6] staging: rtl8188eu: remove ODM_RT_TRACE calls from hal/odm.c
Date:   Fri, 11 Jun 2021 01:25:02 +0100
Message-Id: <20210611002504.166405-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611002504.166405-4-phil@philpotter.co.uk>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611002504.166405-2-phil@philpotter.co.uk>
 <20210611002504.166405-3-phil@philpotter.co.uk>
 <20210611002504.166405-4-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all ODM_RT_TRACE calls from hal/odm.c, as this debug code
is not optimal and doesn't follow best practices. This in concert with
other removals allows for the removal of include/odm_debug.h in its
entirety.

Also remove three functions and their header declarations, as these
functions just contain ODM_RT_TRACE calls and nothing else.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/odm.c           | 141 ++----------------
 .../staging/rtl8188eu/include/odm_precomp.h   |   3 -
 2 files changed, 9 insertions(+), 135 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 041ee2965add..53959d310b47 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -163,7 +163,6 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 {
 	/* 2012.05.03 Luke: For all IC series */
 	odm_CommonInfoSelfInit(pDM_Odm);
-	odm_CmnInfoInit_Debug(pDM_Odm);
 	odm_DIGInit(pDM_Odm);
 	odm_RateAdaptiveMaskInit(pDM_Odm);
 
@@ -183,8 +182,6 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 {
 	/* 2012.05.03 Luke: For all IC series */
-	odm_CmnInfoHook_Debug(pDM_Odm);
-	odm_CmnInfoUpdate_Debug(pDM_Odm);
 	odm_CommonInfoSelfUpdate(pDM_Odm);
 	odm_FalseAlarmCounterStatistics(pDM_Odm);
 	odm_RSSIMonitorCheck(pDM_Odm);
@@ -249,48 +246,6 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 		pDM_Odm->bOneEntryOnly = false;
 }
 
-void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm)
-{
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("%s==>\n", __func__));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportPlatform=%d\n", pDM_Odm->SupportPlatform));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportAbility=0x%x\n", pDM_Odm->SupportAbility));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportInterface=%d\n", pDM_Odm->SupportInterface));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportICType=0x%x\n", pDM_Odm->SupportICType));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("CutVersion=%d\n", pDM_Odm->CutVersion));
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
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("%s==>\n", __func__));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pNumTxBytesUnicast=%llu\n", *pDM_Odm->pNumTxBytesUnicast));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pNumRxBytesUnicast=%llu\n", *pDM_Odm->pNumRxBytesUnicast));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pWirelessMode=0x%x\n", *pDM_Odm->pWirelessMode));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pSecChOffset=%d\n", *pDM_Odm->pSecChOffset));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pSecurity=%d\n", *pDM_Odm->pSecurity));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pBandWidth=%d\n", *pDM_Odm->pBandWidth));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pChannel=%d\n", *pDM_Odm->pChannel));
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pbScanInProcess=%d\n", *pDM_Odm->pbScanInProcess));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pbPowerSaving=%d\n", *pDM_Odm->pbPowerSaving));
-}
-
-void odm_CmnInfoUpdate_Debug(struct odm_dm_struct *pDM_Odm)
-{
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("%s==>\n", __func__));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFI_Direct=%d\n", pDM_Odm->bWIFI_Direct));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFI_Display=%d\n", pDM_Odm->bWIFI_Display));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bLinked=%d\n", pDM_Odm->bLinked));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RSSI_Min=%d\n", pDM_Odm->RSSI_Min));
-}
-
 void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
@@ -341,23 +296,15 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	u8 dm_dig_max, dm_dig_min;
 	u8 CurrentIGI = pDM_DigTable->CurIGValue;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s()==>\n", __func__));
-	if ((!(pDM_Odm->SupportAbility & ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-			     ("%s() Return: SupportAbility ODM_BB_DIG or ODM_BB_FA_CNT is disabled\n", __func__));
+	if ((!(pDM_Odm->SupportAbility & ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT)))
 		return;
-	}
 
-	if (*pDM_Odm->pbScanInProcess) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s() Return: In Scan Progress\n", __func__));
+	if (*pDM_Odm->pbScanInProcess)
 		return;
-	}
 
 	/* add by Neil Chen to avoid PSD is processing */
-	if (!pDM_Odm->bDMInitialGainEnable) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s() Return: PSD is Processing\n", __func__));
+	if (!pDM_Odm->bDMInitialGainEnable)
 		return;
-	}
 
 	DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
 	FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
@@ -384,33 +331,20 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				DIG_Dynamic_MIN = DIG_MaxOfMin;
 			else
 				DIG_Dynamic_MIN = pDM_Odm->RSSI_Min;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-				     ("%s() : bOneEntryOnly=true,  DIG_Dynamic_MIN=0x%x\n",
-				      __func__, DIG_Dynamic_MIN));
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-				     ("%s() : pDM_Odm->RSSI_Min=%d\n",
-				      __func__, pDM_Odm->RSSI_Min));
 		} else if (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV) {
 			/* 1 Lower Bound for 88E AntDiv */
-			if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV) {
+			if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)
 				DIG_Dynamic_MIN = (u8)pDM_DigTable->AntDiv_RSSI_max;
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
-					     ("%s(): pDM_DigTable->AntDiv_RSSI_max=%d\n",
-					      __func__, pDM_DigTable->AntDiv_RSSI_max));
-			}
 		} else {
 			DIG_Dynamic_MIN = dm_dig_min;
 		}
 	} else {
 		pDM_DigTable->rx_gain_range_max = dm_dig_max;
 		DIG_Dynamic_MIN = dm_dig_min;
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s() : No Link\n", __func__));
 	}
 
 	/* 1 Modify DIG lower bound, deal with abnormally large false alarm */
 	if (pFalseAlmCnt->Cnt_all > 10000) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("dm_DIG(): Abnormally false alarm case.\n"));
-
 		if (pDM_DigTable->LargeFAHit != 3)
 			pDM_DigTable->LargeFAHit++;
 		if (pDM_DigTable->ForbiddenIGI < CurrentIGI) {
@@ -435,27 +369,20 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				if ((pDM_DigTable->ForbiddenIGI - 1) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
 					pDM_DigTable->ForbiddenIGI = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
 					pDM_DigTable->rx_gain_range_min = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): Normal Case: At Lower Bound\n", __func__));
 				} else {
 					pDM_DigTable->ForbiddenIGI--;
 					pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
-					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): Normal Case: Approach Lower Bound\n", __func__));
 				}
 			} else {
 				pDM_DigTable->LargeFAHit = 0;
 			}
 		}
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-		     ("%s(): pDM_DigTable->LargeFAHit=%d\n",
-		      __func__, pDM_DigTable->LargeFAHit));
 
 	/* 1 Adjust initial gain by false alarm */
 	if (pDM_Odm->bLinked) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): DIG AfterLink\n", __func__));
 		if (FirstConnect) {
 			CurrentIGI = pDM_Odm->RSSI_Min;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("DIG: First Connect\n"));
 		} else {
 			if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2)
 				CurrentIGI = CurrentIGI + 4;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
@@ -465,10 +392,8 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				CurrentIGI = CurrentIGI - 2;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
 		}
 	} else {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): DIG BeforeLink\n", __func__));
 		if (FirstDisConnect) {
 			CurrentIGI = pDM_DigTable->rx_gain_range_min;
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): First DisConnect\n", __func__));
 		} else {
 			/* 2012.03.30 LukeLee: enable DIG before link but with very high thresholds */
 			if (pFalseAlmCnt->Cnt_all > 10000)
@@ -477,24 +402,15 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				CurrentIGI = CurrentIGI + 1;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
 			else if (pFalseAlmCnt->Cnt_all < 500)
 				CurrentIGI = CurrentIGI - 1;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
-			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): England DIG\n", __func__));
 		}
 	}
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): DIG End Adjust IGI\n", __func__));
 	/* 1 Check initial gain by upper/lower bound */
 	if (CurrentIGI > pDM_DigTable->rx_gain_range_max)
 		CurrentIGI = pDM_DigTable->rx_gain_range_max;
 	if (CurrentIGI < pDM_DigTable->rx_gain_range_min)
 		CurrentIGI = pDM_DigTable->rx_gain_range_min;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
-		     ("%s(): rx_gain_range_max=0x%x, rx_gain_range_min=0x%x\n",
-		      __func__, pDM_DigTable->rx_gain_range_max, pDM_DigTable->rx_gain_range_min));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): TotalFA=%d\n", __func__, pFalseAlmCnt->Cnt_all));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("%s(): CurIGValue=0x%x\n", __func__, CurrentIGI));
-
 	/* 2 High power RSSI threshold */
-
 	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
 	pDM_DigTable->bMediaConnect_0 = pDM_Odm->bLinked;
 	pDM_DigTable->DIG_Dynamic_MIN_0 = DIG_Dynamic_MIN;
@@ -558,20 +474,6 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 				FalseAlmCnt->Cnt_Cck_fail);
 
 	FalseAlmCnt->Cnt_CCA_all = FalseAlmCnt->Cnt_OFDM_CCA + FalseAlmCnt->Cnt_CCK_CCA;
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Enter %s\n", __func__));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
-		     ("Cnt_Fast_Fsync=%d, Cnt_SB_Search_fail=%d\n",
-		     FalseAlmCnt->Cnt_Fast_Fsync, FalseAlmCnt->Cnt_SB_Search_fail));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
-		     ("Cnt_Parity_Fail=%d, Cnt_Rate_Illegal=%d\n",
-		     FalseAlmCnt->Cnt_Parity_Fail, FalseAlmCnt->Cnt_Rate_Illegal));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
-		     ("Cnt_Crc8_fail=%d, Cnt_Mcs_fail=%d\n",
-		     FalseAlmCnt->Cnt_Crc8_fail, FalseAlmCnt->Cnt_Mcs_fail));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Cnt_Cck_fail=%d\n", FalseAlmCnt->Cnt_Cck_fail));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Cnt_Ofdm_fail=%d\n", FalseAlmCnt->Cnt_Ofdm_fail));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Total False Alarm=%d\n", FalseAlmCnt->Cnt_all));
 }
 
 /* 3============================================================ */
@@ -752,10 +654,6 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 		break;
 	}
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD,
-		     (" ==> rssi_level:0x%02x, WirelessMode:0x%02x, rate_bitmap:0x%08x\n",
-		     rssi_level, WirelessMode, rate_bitmap));
-
 	return rate_bitmap;
 }
 
@@ -777,26 +675,18 @@ void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm)
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
-			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level)) {
-				ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD,
-					     ("RSSI:%d, RSSI_LEVEL:%d\n",
-					     pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level));
+			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level))
 				rtw_hal_update_ra_mask(pAdapter, i, pstat->rssi_level);
-			}
 		}
 	}
 }
@@ -840,7 +730,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 		RATRState = DM_RATR_STA_LOW;
 
 	if (*pRATRState != RATRState || bForceUpdate) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("RSSI Level %d -> %d\n", *pRATRState, RATRState));
 		*pRATRState = RATRState;
 		return true;
 	}
@@ -979,20 +868,16 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
 {
-	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Return: Not Support HW AntDiv\n"));
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
-	}
 
 	rtl88eu_dm_antenna_div_init(pDM_Odm);
 }
 
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
 {
-	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Return: Not Support HW AntDiv\n"));
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
-	}
 
 	rtl88eu_dm_antenna_diversity(pDM_Odm);
 }
@@ -1005,11 +890,6 @@ void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = false;
 	pDM_Odm->DM_EDCA_Table.bIsCurRDLState = false;
 	Adapter->recvpriv.bIsAnyNonBEPkts = false;
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original VO PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_VO_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original VI PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_VI_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original BE PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_BE_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original BK PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_BK_PARAM)));
 }	/*  ODM_InitEdcaTurbo */
 
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
@@ -1017,13 +897,10 @@ void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
 	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
 	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
 	/*  HW dynamic mechanism. */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("%s========================>\n", __func__));
-
 	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
 		return;
 
 	odm_EdcaTurboCheckCE(pDM_Odm);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("<========================%s\n", __func__));
 }	/*  odm_CheckEdcaTurbo */
 
 void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index 5254d875f96b..ef1afc83f9ac 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -33,8 +33,6 @@
 
 #include "odm_rtl8188e.h"
 
-void odm_CmnInfoHook_Debug(struct odm_dm_struct *pDM_Odm);
-void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm);
 void odm_DIGInit(struct odm_dm_struct *pDM_Odm);
 void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
@@ -42,7 +40,6 @@ void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivInit_NIC(struct odm_dm_struct *pDM_Odm);
-void odm_CmnInfoUpdate_Debug(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_DIG(struct odm_dm_struct *pDM_Odm);
-- 
2.30.2

