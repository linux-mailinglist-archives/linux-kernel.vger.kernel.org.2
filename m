Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086DC3DC1EB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhGaAYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhGaAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B081C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b7so13343777wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBGimQZ7BaSluHhHM5cQLxN3F8ipeEhzFd8u4mEzwjc=;
        b=fm3oaUDRZbyqYkI2yPCMQMi2kyMQ58UAUEhkLJk1K0P0LMzcYIc9Sgp/m+/BE1if6o
         iRZkG16kOWpsT6VGgE44G001kL130D38XHKe5xX++GBBZ79iJwZMvq4Bj3Chr8t6cbT7
         BubZ2htSkYw1qmLR4y4CkibYZbmB63hr1ef+Kz/lbmz/z+Rope/yFAPYfKQa4YtbIK50
         mpMMtOB2lIw4zxtQgZjk+gAWyajQaWuPMZPX2f5vpqqEhU6qcw7dHuN7bh8O6BTWpEnF
         MYTis5w3Uk9G1qnK6Izw5cM6DHGpDvdnwVKoVCExG/q1a7h1HFaDXbgkile5OZ70FCUl
         +oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBGimQZ7BaSluHhHM5cQLxN3F8ipeEhzFd8u4mEzwjc=;
        b=jfroWCm1CI9yJQGR/IGEQ9NZFGIfsn4251qSC8Sh5/eeHYa+AFqWtdvVQDmZWONGwa
         iM/ioKO1bgphkWgdx4jPCWRLzFB/VRG9XJr8FMK6/IZBfOfMqLLEpbNHPgWe0xWzTd1U
         cjeBcjHmMj0MbrO13BIybmW7w83m00ouxQvNNG61vzx+7WsmqSTjHUMTvE+KEgK61G9q
         gZc8OH1XCgIRcBoAdHRe+6Jl5tKng4girLgzFzR73HreB2tZXawSDqlu4qIdl+Dm4TJZ
         RRzXsbioNEgbyhESYZ+kv6+MCZEYyg0rVnINs0UBwnMMunIHiBRbic9KZEA4nJLWZkmj
         pvfg==
X-Gm-Message-State: AOAM533nIv8+egoimki9p75X0nI7QFhKxmzHcMVXK8Op7EeLfTlxBA+3
        SUwPTdU53QlJ6X2xgMesyLQ2fA==
X-Google-Smtp-Source: ABdhPJyQHcP1P1cFqgYNQuG6FfC6AmjLCpMLuPNo8Zn+afn+B+FDAE9sz9KACOMqfvsY5MjVfyaR+A==
X-Received: by 2002:adf:f983:: with SMTP id f3mr5697199wrr.69.1627691039821;
        Fri, 30 Jul 2021 17:23:59 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:23:59 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] staging: r8188eu: remove ODM_RT_TRACE calls from hal/Hal8188ERateAdaptive.c
Date:   Sat, 31 Jul 2021 01:23:45 +0100
Message-Id: <20210731002353.68479-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE calls from hal/Hal8188ERateAdaptive.c, as by removing
these calls in this file and others, we can ultimately then remove the
macro definition itself, which does not follow best practice.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        | 99 +------------------
 1 file changed, 2 insertions(+), 97 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 2baea6141fe2..6e16122f9b93 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -113,8 +113,6 @@ static void odm_SetTxRPTTiming_8188E(
 			idx -= 1;
 	}
 	pRaInfo->RptTime = DynamicTxRPTTiming[idx];
-
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("pRaInfo->RptTime = 0x%x\n", pRaInfo->RptTime));
 }
 
 static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *pRaInfo)
@@ -122,18 +120,12 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *
 	u8 RateID, LowestRate, HighestRate;
 	u8 i;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("=====>odm_RateDown_8188E()\n"));
-	if (NULL == pRaInfo) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("odm_RateDown_8188E(): pRaInfo is NULL\n"));
+	if (NULL == pRaInfo)
 		return -1;
-	}
 	RateID = pRaInfo->PreRate;
 	LowestRate = pRaInfo->LowestRate;
 	HighestRate = pRaInfo->HighestRate;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" RateID =%d LowestRate =%d HighestRate =%d RateSGI =%d\n",
-		     RateID, LowestRate, HighestRate, pRaInfo->RateSGI));
 	if (RateID > HighestRate) {
 		RateID = HighestRate;
 	} else if (pRaInfo->RateSGI) {
@@ -166,10 +158,6 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *
 
 	pRaInfo->DecisionRate = RateID;
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 2);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("Rate down, RPT Timing default\n"));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("RAWaitingCounter %d, RAPendingCounter %d", pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("Rate down to RateID %d RateSGI %d\n", RateID, pRaInfo->RateSGI));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("<===== odm_RateDown_8188E()\n"));
 	return 0;
 }
 
@@ -181,16 +169,10 @@ static int odm_RateUp_8188E(
 	u8 RateID, HighestRate;
 	u8 i;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("=====>odm_RateUp_8188E()\n"));
-	if (NULL == pRaInfo) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("odm_RateUp_8188E(): pRaInfo is NULL\n"));
+	if (NULL == pRaInfo)
 		return -1;
-	}
 	RateID = pRaInfo->PreRate;
 	HighestRate = pRaInfo->HighestRate;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" RateID =%d HighestRate =%d\n",
-		     RateID, HighestRate));
 	if (pRaInfo->RAWaitingCounter == 1) {
 		pRaInfo->RAWaitingCounter = 0;
 		pRaInfo->RAPendingCounter = 0;
@@ -199,7 +181,6 @@ static int odm_RateUp_8188E(
 		goto RateUpfinish;
 	}
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 0);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("odm_RateUp_8188E():Decrease RPT Timing\n"));
 
 	if (RateID < HighestRate) {
 		for (i = RateID+1; i <= HighestRate; i++) {
@@ -223,9 +204,6 @@ static int odm_RateUp_8188E(
 		pRaInfo->RAWaitingCounter++;
 
 	pRaInfo->DecisionRate = RateID;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("Rate up to RateID %d\n", RateID));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("RAWaitingCounter %d, RAPendingCounter %d", pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("<===== odm_RateUp_8188E()\n"));
 	return 0;
 }
 
@@ -246,8 +224,6 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 	/* u32 pool_retry; */
 	static u8 DynamicTxRPTTimingCounter;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("=====>odm_RateDecision_8188E()\n"));
-
 	if (pRaInfo->Active && (pRaInfo->TOTAL > 0)) { /*  STA used and data packet exits */
 		if ((pRaInfo->RssiStaRA < (pRaInfo->PreRssiStaRA - 3)) ||
 		    (pRaInfo->RssiStaRA > (pRaInfo->PreRssiStaRA + 3))) {
@@ -265,16 +241,11 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 			RtyPtID = 1;
 		PenaltyID1 = RETRY_PENALTY_IDX[RtyPtID][RateID]; /* TODO by page */
 
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     (" NscDown init is %d\n", pRaInfo->NscDown));
 		pRaInfo->NscDown += pRaInfo->RTY[0] * RETRY_PENALTY[PenaltyID1][0];
 		pRaInfo->NscDown += pRaInfo->RTY[1] * RETRY_PENALTY[PenaltyID1][1];
 		pRaInfo->NscDown += pRaInfo->RTY[2] * RETRY_PENALTY[PenaltyID1][2];
 		pRaInfo->NscDown += pRaInfo->RTY[3] * RETRY_PENALTY[PenaltyID1][3];
 		pRaInfo->NscDown += pRaInfo->RTY[4] * RETRY_PENALTY[PenaltyID1][4];
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     (" NscDown is %d, total*penalty[5] is %d\n",
-			     pRaInfo->NscDown, (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5])));
 		if (pRaInfo->NscDown > (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5]))
 			pRaInfo->NscDown -= pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5];
 		else
@@ -282,24 +253,16 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 
 		/*  rate up */
 		PenaltyID2 = RETRY_PENALTY_UP_IDX[RateID];
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     (" NscUp init is %d\n", pRaInfo->NscUp));
 		pRaInfo->NscUp += pRaInfo->RTY[0] * RETRY_PENALTY[PenaltyID2][0];
 		pRaInfo->NscUp += pRaInfo->RTY[1] * RETRY_PENALTY[PenaltyID2][1];
 		pRaInfo->NscUp += pRaInfo->RTY[2] * RETRY_PENALTY[PenaltyID2][2];
 		pRaInfo->NscUp += pRaInfo->RTY[3] * RETRY_PENALTY[PenaltyID2][3];
 		pRaInfo->NscUp += pRaInfo->RTY[4] * RETRY_PENALTY[PenaltyID2][4];
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-			     ("NscUp is %d, total*up[5] is %d\n",
-			     pRaInfo->NscUp, (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5])));
 		if (pRaInfo->NscUp > (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5]))
 			pRaInfo->NscUp -= pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5];
 		else
 			pRaInfo->NscUp = 0;
 
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE|ODM_COMP_INIT, ODM_DBG_LOUD,
-			     (" RssiStaRa = %d RtyPtID =%d PenaltyID1 = 0x%x  PenaltyID2 = 0x%x RateID =%d NscDown =%d NscUp =%d SGI =%d\n",
-			     pRaInfo->RssiStaRA, RtyPtID, PenaltyID1, PenaltyID2, RateID, pRaInfo->NscDown, pRaInfo->NscUp, pRaInfo->RateSGI));
 		if ((pRaInfo->NscDown < N_THRESHOLD_LOW[RateID]) ||
 		    (pRaInfo->DROP > DROPING_NECESSARY[RateID]))
 			odm_RateDown_8188E(dm_odm, pRaInfo);
@@ -316,8 +279,6 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 
 		if (DynamicTxRPTTimingCounter >= 4) {
 			odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 1);
-			ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
-				     ODM_DBG_LOUD, ("<===== Rate don't change 4 times, Extend RPT Timing\n"));
 			DynamicTxRPTTimingCounter = 0;
 		}
 
@@ -325,7 +286,6 @@ static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
 
 		odm_ResetRaCounter_8188E(pRaInfo);
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("<===== odm_RateDecision_8188E()\n"));
 }
 
 static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *pRaInfo)
@@ -405,15 +365,10 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 			pRaInfo->PTModeSS = 1;
 		else
 			pRaInfo->PTModeSS = 0;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("ODM_ARFBRefresh_8188E(): PTModeSS =%d\n", pRaInfo->PTModeSS));
 
 	if (pRaInfo->DecisionRate > pRaInfo->HighestRate)
 		pRaInfo->DecisionRate = pRaInfo->HighestRate;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("ODM_ARFBRefresh_8188E(): RateID =%d RateMask =%8.8x RAUseRate =%8.8x HighestRate =%d, DecisionRate =%d\n",
-		     pRaInfo->RateID, pRaInfo->RateMask, pRaInfo->RAUseRate, pRaInfo->HighestRate, pRaInfo->DecisionRate));
 	return 0;
 }
 
@@ -510,15 +465,10 @@ odm_RATxRPTTimerSetting(
 		u16 minRptTime
 )
 {
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, (" =====>odm_RATxRPTTimerSetting()\n"));
-
 	if (dm_odm->CurrminRptTime != minRptTime) {
-		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-			     (" CurrminRptTime = 0x%04x minRptTime = 0x%04x\n", dm_odm->CurrminRptTime, minRptTime));
 		rtw_rpt_timer_cfg_cmd(dm_odm->Adapter, minRptTime);
 		dm_odm->CurrminRptTime = minRptTime;
 	}
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, (" <===== odm_RATxRPTTimerSetting()\n"));
 }
 
 void
@@ -526,8 +476,6 @@ ODM_RASupport_Init(
 		struct odm_dm_struct *dm_odm
 	)
 {
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("=====>ODM_RASupport_Init()\n"));
-
 	/*  2012/02/14 MH Be noticed, the init must be after IC type is recognized!!!!! */
 	if (dm_odm->SupportICType == ODM_RTL8188E)
 		dm_odm->RaSupport88E = true;
@@ -550,10 +498,6 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 			max_rate_idx = 0x03;
 	}
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("ODM_RAInfo_Init(): WirelessMode:0x%08x , max_raid_idx:0x%02x\n",
-		     WirelessMode, max_rate_idx));
-
 	pRaInfo->DecisionRate = max_rate_idx;
 	pRaInfo->PreRate = max_rate_idx;
 	pRaInfo->HighestRate = max_rate_idx;
@@ -594,7 +538,6 @@ int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm)
 {
 	u8 macid = 0;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("=====>\n"));
 	dm_odm->CurrminRptTime = 0;
 
 	for (macid = 0; macid < ODM_ASSOCIATE_ENTRY_NUM; macid++)
@@ -607,8 +550,6 @@ u8 ODM_RA_GetShortGI_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 {
 	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return 0;
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("macid =%d SGI =%d\n", macid, dm_odm->RAInfo[macid].RateSGI));
 	return dm_odm->RAInfo[macid].RateSGI;
 }
 
@@ -619,8 +560,6 @@ u8 ODM_RA_GetDecisionRate_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return 0;
 	DecisionRate = (dm_odm->RAInfo[macid].DecisionRate);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		(" macid =%d DecisionRate = 0x%x\n", macid, DecisionRate));
 	return DecisionRate;
 }
 
@@ -631,8 +570,6 @@ u8 ODM_RA_GetHwPwrStatus_8188E(struct odm_dm_struct *dm_odm, u8 macid)
 	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return 0;
 	PTStage = (dm_odm->RAInfo[macid].PTStage);
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     ("macid =%d PTStage = 0x%x\n", macid, PTStage));
 	return PTStage;
 }
 
@@ -640,9 +577,6 @@ void ODM_RA_UpdateRateInfo_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rate
 {
 	struct odm_ra_info *pRaInfo = NULL;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("macid =%d RateID = 0x%x RateMask = 0x%x SGIEnable =%d\n",
-		     macid, RateID, RateMask, SGIEnable));
 	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return;
 
@@ -657,8 +591,6 @@ void ODM_RA_SetRSSI_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rssi)
 {
 	struct odm_ra_info *pRaInfo = NULL;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
-		     (" macid =%d Rssi =%d\n", macid, Rssi));
 	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
 		return;
 
@@ -679,10 +611,6 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 	u32 valid = 0, ItemNum = 0;
 	u16 minRptTime = 0x927c;
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-		     ("=====>ODM_RA_TxRPT2Handle_8188E(): valid0 =%d valid1 =%d BufferLength =%d\n",
-		     macid_entry0, macid_entry1, TxRPT_Len));
-
 	ItemNum = TxRPT_Len >> 3;
 	pBuffer = TxRPT_Buf;
 
@@ -706,13 +634,6 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 					 pRAInfo->RTY[2] + pRAInfo->RTY[3] +
 					 pRAInfo->RTY[4] + pRAInfo->DROP;
 			if (pRAInfo->TOTAL != 0) {
-				ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
-					     ("macid =%d Total =%d R0 =%d R1 =%d R2 =%d R3 =%d R4 =%d D0 =%d valid0 =%x valid1 =%x\n",
-					     MacId, pRAInfo->TOTAL,
-					     pRAInfo->RTY[0], pRAInfo->RTY[1],
-					     pRAInfo->RTY[2], pRAInfo->RTY[3],
-					     pRAInfo->RTY[4], pRAInfo->DROP,
-					     macid_entry0 , macid_entry1));
 				if (pRAInfo->PTActive) {
 					if (pRAInfo->RAstage < 5)
 						odm_RateDecision_8188E(dm_odm, pRAInfo);
@@ -729,20 +650,6 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
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
 
@@ -754,6 +661,4 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 	} while (MacId < ItemNum);
 
 	odm_RATxRPTTimerSetting(dm_odm, minRptTime);
-
-	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("<===== ODM_RA_TxRPT2Handle_8188E()\n"));
 }
-- 
2.31.1

