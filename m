Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E13435428
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhJTT4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJTT4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:56:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B82C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:54:35 -0700 (PDT)
Received: from dslb-188-096-142-022.188.096.pools.vodafone-ip.de ([188.96.142.22] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mdHfU-0007Cd-7b; Wed, 20 Oct 2021 21:54:32 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: odm_rate_adapt Type is constant
Date:   Wed, 20 Oct 2021 21:53:58 +0200
Message-Id: <20211020195401.12931-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211020195401.12931-1-martin@kaiser.cx>
References: <20211020195401.12931-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type in struct odm_rate_adapt is always DM_Type_ByDriver.
Therefore, bUseRAMask is always true.

Remove the constant components, unused defines and dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c     | 9 ---------
 drivers/staging/r8188eu/include/odm.h | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 47d8cdf1c3e8..67cf8f7baba5 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -669,12 +669,6 @@ void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct odm_rate_adapt *pOdmRA = &pDM_Odm->RateAdaptive;
 
-	pOdmRA->Type = DM_Type_ByDriver;
-	if (pOdmRA->Type == DM_Type_ByDriver)
-		pDM_Odm->bUseRAMask = true;
-	else
-		pDM_Odm->bUseRAMask = false;
-
 	pOdmRA->RATRState = DM_RATR_STA_INIT;
 	pOdmRA->HighRSSIThresh = 50;
 	pOdmRA->LowRSSIThresh = 20;
@@ -755,9 +749,6 @@ void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
 	if (pAdapter->bDriverStopped)
 		return;
 
-	if (!pDM_Odm->bUseRAMask)
-		return;
-
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(pstat)) {
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 1fc90a8dc063..f08655208b32 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -150,7 +150,6 @@ struct edca_turbo {
 };
 
 struct odm_rate_adapt {
-	u8	Type;		/*  DM_Type_ByFW/DM_Type_ByDriver */
 	u8	HighRSSIThresh;	/*  if RSSI > HighRSSIThresh	=> RATRState is DM_RATR_STA_HIGH */
 	u8	LowRSSIThresh;	/*  if RSSI <= LowRSSIThresh	=> RATRState is DM_RATR_STA_LOW */
 	u8	RATRState;	/*  Current RSSI level, DM_RATR_STA_HIGH/DM_RATR_STA_MIDDLE/DM_RATR_STA_LOW */
@@ -165,8 +164,6 @@ struct odm_rate_adapt {
 #define AVG_THERMAL_NUM		8
 #define IQK_Matrix_REG_NUM	8
 
-#define	DM_Type_ByDriver	1
-
 struct odm_phy_dbg_info {
 	/* ODM Write,debug info */
 	s8	RxSNRdB[MAX_PATH_NUM_92CS];
@@ -586,9 +583,6 @@ struct odm_dm_struct {
 	bool	bPSDinProcess;
 	bool	bDMInitialGainEnable;
 
-	/* for rate adaptive, in fact,  88c/92c fw will handle this */
-	u8	bUseRAMask;
-
 	struct odm_rate_adapt RateAdaptive;
 
 	struct odm_rf_cal RFCalibrateInfo;
-- 
2.20.1

