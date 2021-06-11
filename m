Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCC3A38A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFKA11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFKA10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:27:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE566C0617AD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e11so4150534wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAqSn/IpAEjuT9AfyjMpLY4iLmaT0lqoo/IcyqNWU80=;
        b=kE1m58VyDm2q73s+mes3AAMlTuP/FzWu+t84YlLq2OfUPczXCumBH3JbaiKDGhCxB1
         yTRVA1H2HBlxlhuvTI5TAVqMsIvRQyFZ1Zo1lbi+Y19lThIPCV04RZK9Rgh2ibIZrxiH
         sae2lJ/js6ofay+WQfFWSzEWmgH+gOfqKMe4f174cYi4OfbzusX9I6tcIGKXZpgIdpwE
         TGjTsn6VcmBnuil3OBk02fvIPT5PPYxt2183aUsC4qb8uyO21xEccqB/Wl17/oOHum9R
         QdxopRvWNyBaPPSZ9euszz41Pa1Itvo4GuqfTPZmlLU2ynPMTiT/pJHZD/tusV/mRxNw
         7YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAqSn/IpAEjuT9AfyjMpLY4iLmaT0lqoo/IcyqNWU80=;
        b=FL1mEk0JJzX9kw5U81P/ijVrowvri87XwDIj7acX2k7SJM/AyYQzek2Xu3Fl37HC4l
         dd4xf9CARnS9+hNc7TwkidCPJdwcxX6DcYhjiXHsGbYp349y2UFYKfaRqyrDfVn2sKiN
         +JsbNE27re+FZ4FU4/OjWyROXwb20v26HbPhyUxyo8z9Go7K5/tipoIG9sik6Ioj0YKd
         eE2IlZBVMkGqvU00c73XHCGkGRQ3RkCczXTaXzhSPG2JUjfzQXuSk9xoa55+i1xl5//l
         0pHd2QKww0v03a/+ro/nhU6GwZcCXP12uc3bxWQMttK1PcggBXHGh+c7hSUfBt4cmbZB
         Djxw==
X-Gm-Message-State: AOAM53191/8P8BFyhlEbGDFYjkbxY9YEo1dPDbmgzfCWEqEM86icxT6R
        FZJwc6qHZiK+Dqm1ZBS1C3cWVA==
X-Google-Smtp-Source: ABdhPJyZMG0HrZOqgM0+jrh7Lixa9pFIymvASCT7exPZVqtoyyq1igrFEn67SIBQsfbBGiLHUv8gfg==
X-Received: by 2002:adf:d209:: with SMTP id j9mr924003wrh.328.1623371110254;
        Thu, 10 Jun 2021 17:25:10 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id c2sm11386189wmf.24.2021.06.10.17.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:25:09 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        kaixuxia@tencent.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        unixbhaskar@gmail.com, gustavoars@kernel.org, martin@kaiser.cx,
        bkkarthik@pesu.pes.edu, dan.carpenter@oracle.com
Subject: [PATCH 2/6] staging: rtl8188eu: remove ODM_RT_TRACE calls from hal/hal8188e_rate_adaptive.c
Date:   Fri, 11 Jun 2021 01:25:00 +0100
Message-Id: <20210611002504.166405-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611002504.166405-2-phil@philpotter.co.uk>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611002504.166405-2-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all ODM_RT_TRACE calls from hal/hal8188e_rate_adaptive.c,
as this debug code is not optimal and doesn't follow best practices.
This in concert with other removals allows for the removal of
include/odm_debug.h in its entirety.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../rtl8188eu/hal/hal8188e_rate_adaptive.c    | 123 +-----------------
 1 file changed, 4 insertions(+), 119 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index 5792f491b59a..74fff76af16d 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -101,9 +101,6 @@ static void odm_SetTxRPTTiming_8188E(struct odm_dm_struct *dm_odm,
 			idx -= 1;
 	}
 	pRaInfo->RptTime = DynamicTxRPTTiming[idx];
-
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("pRaInfo->RptTime = 0x%x\n", pRaInfo->RptTime));
 }
 
 static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
@@ -112,20 +109,13 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
 	u8 RateID, LowestRate, HighestRate;
 	u8 i;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-		     ODM_DBG_TRACE, ("=====>%s()\n", __func__));
-	if (!pRaInfo) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			     ("%s(): pRaInfo is NULL\n", __func__));
+	if (!pRaInfo)
 		return -1;
-	}
+
 	RateID = pRaInfo->PreRate;
 	LowestRate = pRaInfo->LowestRate;
 	HighestRate = pRaInfo->HighestRate;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" RateID =%d LowestRate =%d HighestRate =%d RateSGI =%d\n",
-		     RateID, LowestRate, HighestRate, pRaInfo->RateSGI));
 	if (RateID > HighestRate) {
 		RateID = HighestRate;
 	} else if (pRaInfo->RateSGI) {
@@ -158,15 +148,6 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
 
 	pRaInfo->DecisionRate = RateID;
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 2);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-		     ODM_DBG_LOUD, ("Rate down, RPT Timing default\n"));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("RAWaitingCounter %d, RAPendingCounter %d",
-			 pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("Rate down to RateID %d RateSGI %d\n", RateID, pRaInfo->RateSGI));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("<===== %s()\n", __func__));
 	return 0;
 }
 
@@ -176,18 +157,11 @@ static int odm_RateUp_8188E(struct odm_dm_struct *dm_odm,
 	u8 RateID, HighestRate;
 	u8 i;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-		     ODM_DBG_TRACE, ("=====>%s()\n", __func__));
-	if (!pRaInfo) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			     ("%s(): pRaInfo is NULL\n", __func__));
+	if (!pRaInfo)
 		return -1;
-	}
+
 	RateID = pRaInfo->PreRate;
 	HighestRate = pRaInfo->HighestRate;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" RateID =%d HighestRate =%d\n",
-		     RateID, HighestRate));
 	if (pRaInfo->RAWaitingCounter == 1) {
 		pRaInfo->RAWaitingCounter = 0;
 		pRaInfo->RAPendingCounter = 0;
@@ -196,8 +170,6 @@ static int odm_RateUp_8188E(struct odm_dm_struct *dm_odm,
 		goto RateUpfinish;
 	}
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 0);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("%s():Decrease RPT Timing\n", __func__));
 
 	if (RateID < HighestRate) {
 		for (i = RateID + 1; i <= HighestRate; i++) {
@@ -222,13 +194,6 @@ static int odm_RateUp_8188E(struct odm_dm_struct *dm_odm,
 		pRaInfo->RAWaitingCounter++;
 
 	pRaInfo->DecisionRate = RateID;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("Rate up to RateID %d\n", RateID));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("RAWaitingCounter %d, RAPendingCounter %d",
-		      pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-		     ODM_DBG_TRACE, ("<===== %s()\n", __func__));
 	return 0;
 }
 
@@ -250,9 +215,6 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 	/* u32 pool_retry; */
 	static u8 DynamicTxRPTTimingCounter;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("=====>%s()\n", __func__));
-
 	if (pRaInfo->Active && (pRaInfo->TOTAL > 0)) { /*  STA used and data packet exits */
 		if ((pRaInfo->RssiStaRA < (pRaInfo->PreRssiStaRA - 3)) ||
 		    (pRaInfo->RssiStaRA > (pRaInfo->PreRssiStaRA + 3))) {
@@ -270,16 +232,9 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 			RtyPtID = 1;
 		PenaltyID1 = RETRY_PENALTY_IDX[RtyPtID][RateID]; /* TODO by page */
 
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     (" NscDown init is %d\n", pRaInfo->NscDown));
-
 		for (i = 0 ; i <= 4 ; i++)
 			pRaInfo->NscDown += pRaInfo->RTY[i] * RETRY_PENALTY[PenaltyID1][i];
 
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     (" NscDown is %d, total*penalty[5] is %d\n", pRaInfo->NscDown,
-			      (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5])));
-
 		if (pRaInfo->NscDown > (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5]))
 			pRaInfo->NscDown -= pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5];
 		else
@@ -287,24 +242,15 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 
 		/*  rate up */
 		PenaltyID2 = RETRY_PENALTY_UP_IDX[RateID];
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     (" NscUp init is %d\n", pRaInfo->NscUp));
 
 		for (i = 0 ; i <= 4 ; i++)
 			pRaInfo->NscUp += pRaInfo->RTY[i] * RETRY_PENALTY[PenaltyID2][i];
 
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     ("NscUp is %d, total*up[5] is %d\n",
-			     pRaInfo->NscUp, (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5])));
-
 		if (pRaInfo->NscUp > (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5]))
 			pRaInfo->NscUp -= pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5];
 		else
 			pRaInfo->NscUp = 0;
 
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE | ODM_COMP_INIT, ODM_DBG_LOUD,
-			     (" RssiStaRa = %d RtyPtID =%d PenaltyID1 = 0x%x  PenaltyID2 = 0x%x RateID =%d NscDown =%d NscUp =%d SGI =%d\n",
-			     pRaInfo->RssiStaRA, RtyPtID, PenaltyID1, PenaltyID2, RateID, pRaInfo->NscDown, pRaInfo->NscUp, pRaInfo->RateSGI));
 		if ((pRaInfo->NscDown < N_THRESHOLD_LOW[RateID]) ||
 		    (pRaInfo->DROP > DROPING_NECESSARY[RateID]))
 			odm_RateDown_8188E(dm_odm, pRaInfo);
@@ -321,8 +267,6 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 
 		if (DynamicTxRPTTimingCounter >= 4) {
 			odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 1);
-			ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-				     ODM_DBG_LOUD, ("<===== Rate don't change 4 times, Extend RPT Timing\n"));
 			DynamicTxRPTTimingCounter = 0;
 		}
 
@@ -330,8 +274,6 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 
 		odm_ResetRaCounter_8188E(pRaInfo);
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("<===== %s()\n", __func__));
 }
 
 static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *pRaInfo)
@@ -414,15 +356,9 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 	else
 		pRaInfo->PTModeSS = 0;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("ODM_ARFBRefresh_8188E(): PTModeSS =%d\n", pRaInfo->PTModeSS));
-
 	if (pRaInfo->DecisionRate > pRaInfo->HighestRate)
 		pRaInfo->DecisionRate = pRaInfo->HighestRate;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("ODM_ARFBRefresh_8188E(): RateID =%d RateMask =%8.8x RAUseRate =%8.8x HighestRate =%d, DecisionRate =%d\n",
-		     pRaInfo->RateID, pRaInfo->RateMask, pRaInfo->RAUseRate, pRaInfo->HighestRate, pRaInfo->DecisionRate));
 	return 0;
 }
 
@@ -518,17 +454,10 @@ static void odm_PTDecision_8188E(struct odm_ra_info *pRaInfo)
 static void odm_RATxRPTTimerSetting(struct odm_dm_struct *dm_odm,
 				    u16 minRptTime)
 {
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" =====>%s()\n", __func__));
-
 	if (dm_odm->CurrminRptTime != minRptTime) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			     (" CurrminRptTime = 0x%04x minRptTime = 0x%04x\n", dm_odm->CurrminRptTime, minRptTime));
 		rtw_rpt_timer_cfg_cmd(dm_odm->Adapter, minRptTime);
 		dm_odm->CurrminRptTime = minRptTime;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" <===== %s()\n", __func__));
 }
 
 int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
@@ -549,10 +478,6 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 			max_rate_idx = 0x03;
 	}
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("%s(): WirelessMode:0x%08x , max_raid_idx:0x%02x\n",
-		      __func__, WirelessMode, max_rate_idx));
-
 	pRaInfo->DecisionRate = max_rate_idx;
 	pRaInfo->PreRate = max_rate_idx;
 	pRaInfo->HighestRate = max_rate_idx;
@@ -593,7 +518,6 @@ int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm)
 {
 	u8 macid = 0;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("=====>\n"));
 	dm_odm->CurrminRptTime = 0;
 
 	for (macid = 0; macid < ODM_ASSOCIATE_ENTRY_NUM; macid++)
@@ -606,8 +530,6 @@ u8 ODM_RA_GetShortGI_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 {
 	if ((!dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return 0;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("macid =%d SGI =%d\n", macid, dm_odm->RAInfo[macid].RateSGI));
 	return dm_odm->RAInfo[macid].RateSGI;
 }
 
@@ -618,8 +540,6 @@ u8 ODM_RA_GetDecisionRate_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 	if ((!dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return 0;
 	DecisionRate = dm_odm->RAInfo[macid].DecisionRate;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" macid =%d DecisionRate = 0x%x\n", macid, DecisionRate));
 	return DecisionRate;
 }
 
@@ -630,8 +550,6 @@ u8 ODM_RA_GetHwPwrStatus_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 	if ((!dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return 0;
 	PTStage = dm_odm->RAInfo[macid].PTStage;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("macid =%d PTStage = 0x%x\n", macid, PTStage));
 	return PTStage;
 }
 
@@ -641,9 +559,6 @@ void ODM_RA_UpdateRateInfo_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rate
 
 	if ((!dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("macid =%d RateID = 0x%x RateMask = 0x%x SGIEnable =%d\n",
-		     macid, RateID, RateMask, SGIEnable));
 
 	pRaInfo = &dm_odm->RAInfo[macid];
 	pRaInfo->RateID = RateID;
@@ -658,8 +573,6 @@ void ODM_RA_SetRSSI_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rssi)
 
 	if ((!dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" macid =%d Rssi =%d\n", macid, Rssi));
 
 	pRaInfo = &dm_odm->RAInfo[macid];
 	pRaInfo->RssiStaRA = Rssi;
@@ -680,10 +593,6 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 	u32 valid = 0, ItemNum = 0;
 	u16 minRptTime = 0x927c;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("=====>%s(): valid0 =%d valid1 =%d BufferLength =%d\n",
-		      __func__, macid_entry0, macid_entry1, TxRPT_Len));
-
 	ItemNum = TxRPT_Len >> 3;
 	pBuffer = TxRPT_Buf;
 
@@ -707,13 +616,6 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 					 pRAInfo->RTY[2] + pRAInfo->RTY[3] +
 					 pRAInfo->RTY[4] + pRAInfo->DROP;
 			if (pRAInfo->TOTAL != 0) {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-					     ("macid =%d Total =%d R0 =%d R1 =%d R2 =%d R3 =%d R4 =%d D0 =%d valid0 =%x valid1 =%x\n",
-					     MacId, pRAInfo->TOTAL,
-					     pRAInfo->RTY[0], pRAInfo->RTY[1],
-					     pRAInfo->RTY[2], pRAInfo->RTY[3],
-					     pRAInfo->RTY[4], pRAInfo->DROP,
-					     macid_entry0, macid_entry1));
 				if (pRAInfo->PTActive) {
 					if (pRAInfo->RAstage < 5)
 						odm_RateDecision_8188E(dm_odm, pRAInfo);
@@ -730,20 +632,6 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 				} else {
 					odm_RateDecision_8188E(dm_odm, pRAInfo);
 				}
-				ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-					     ("macid =%d R0 =%d R1 =%d R2 =%d R3 =%d R4 =%d drop =%d valid0 =%x RateID =%d SGI =%d\n",
-					     MacId,
-					     pRAInfo->RTY[0],
-					     pRAInfo->RTY[1],
-					     pRAInfo->RTY[2],
-					     pRAInfo->RTY[3],
-					     pRAInfo->RTY[4],
-					     pRAInfo->DROP,
-					     macid_entry0,
-					     pRAInfo->DecisionRate,
-					     pRAInfo->RateSGI));
-			} else {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, (" TOTAL = 0!!!!\n"));
 			}
 		}
 
@@ -755,7 +643,4 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 	} while (MacId < ItemNum);
 
 	odm_RATxRPTTimerSetting(dm_odm, minRptTime);
-
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("<===== %s()\n", __func__));
 }
-- 
2.30.2

