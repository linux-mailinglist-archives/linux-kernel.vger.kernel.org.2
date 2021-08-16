Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C61D3EDEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhHPU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhHPU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:56:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CB5C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w5so34207658ejq.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKoHHsr/k9W94qeGZTn0Be9hjJ7LbIYy3nRp9HlzboM=;
        b=PuT0Ygkhr2RCrafiees6MWP1YN6dmf+gcIYxL5ILzvACFuVsVMMLpvOitWeJ0qjA7G
         6mXlmFIOzeowutqZgLtfEjjay7xVB+o26cjC/o7/rqWEWxv21fBDODERGj6jNOw9GhTW
         WHc3k2949NmLkeYCt/A5YCFRJzNVhxg91uSXIAM+8PcsT87NHA38TIrvZA+lBatjEYKY
         HPtZ8oET6sBTsAk1hpAdURh6y9Vj2IktBO6F63vPTkF0IUcA4bhSrSoY0soad4k6fzDs
         70SFBPwPZ84DE3UQynC/Ycr29fL3S1wfE+/1Yofh/pKtOl0mZG+HcLIFj0HY0XsWqkfz
         xx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKoHHsr/k9W94qeGZTn0Be9hjJ7LbIYy3nRp9HlzboM=;
        b=mR+Et2N2kRjqO5aVL+ly72e14ufsQv2bIbyfKLF5Dgqbk8DpMm/XgH9wyWlPupHa/9
         SIJimgQTxSWZru1tHBCecshKv2xFD4DhvVPSe2AV/qdbegO0n4z5jkZ1q0St0C07C+zY
         2I0eQaJ0uy4LMJOj7DDnzCZOUJppsL4JiYy+F6H2kMDvPNzWfClKD3GJS+HN/8BImBbf
         RBpAmNQKsnLdWDIkLeJJ8tibgSjaR74Sc4lFZFfuO0xEzhCZIOCLTgDpV90w7E+YIYxU
         gBAdZLn3YrR4tCCOo5mDOTY2Z7w74RPFvHPQHco4WlaAHmPi/mZ6haPIJOv4emWw8N1Q
         0qXQ==
X-Gm-Message-State: AOAM530CYZL6Ag8ypIUyz4fiNAw2uekClj3zQnGsqg8hmclhkIN+ibfM
        oIBhueOAXsWTJo9xgTGRUcI=
X-Google-Smtp-Source: ABdhPJxweBcDCouVjr0AVbdK2ZUd41E8hI0Twx0iHqKadofrg2+tNQIehPdlcOYzS/t9t6D9KLKcUA==
X-Received: by 2002:a17:906:3a98:: with SMTP id y24mr46377ejd.198.1629147370350;
        Mon, 16 Aug 2021 13:56:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id ck17sm36967edb.88.2021.08.16.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:56:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: clean up spacing style issues in hal dir, part 1
Date:   Mon, 16 Aug 2021 22:55:09 +0200
Message-Id: <20210816205511.20068-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816205511.20068-1-straube.linux@gmail.com>
References: <20210816205511.20068-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues reported by checkpatch in the first 10
files in the hal directory.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  48 +++---
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  22 +--
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   6 +-
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   6 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 138 +++++++++---------
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   2 +-
 drivers/staging/r8188eu/hal/hal_com.c         |  36 ++---
 drivers/staging/r8188eu/hal/hal_intf.c        |   4 +-
 drivers/staging/r8188eu/hal/odm.c             | 114 +++++++--------
 9 files changed, 188 insertions(+), 188 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 1f1ce5f36f83..d873672feb27 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -16,7 +16,7 @@ Major Change History:
 
 /*  Rate adaptive parameters */
 
-static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE+1] = {
+static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE + 1] = {
 		{5, 4, 3, 2, 0, 3},      /* 92 , idx = 0 */
 		{6, 5, 4, 3, 0, 4},      /* 86 , idx = 1 */
 		{6, 5, 4, 2, 0, 4},      /* 81 , idx = 2 */
@@ -42,7 +42,7 @@ static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE+1] = {
 		{49, 16, 16, 0, 0, 48}
 	}; /* 3, idx = 0x16 */
 
-static u8 PT_PENALTY[RETRYSIZE+1] = {34, 31, 30, 24, 0, 32};
+static u8 PT_PENALTY[RETRYSIZE + 1] = {34, 31, 30, 24, 0, 32};
 
 /*  wilson modify */
 static u8 RETRY_PENALTY_IDX[2][RATESIZE] = {
@@ -132,7 +132,7 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *
 		pRaInfo->RateSGI = 0;
 	} else if (RateID > LowestRate) {
 		if (RateID > 0) {
-			for (i = RateID-1; i > LowestRate; i--) {
+			for (i = RateID - 1; i > LowestRate; i--) {
 				if (pRaInfo->RAUseRate & BIT(i)) {
 					RateID = i;
 					goto RateDownFinish;
@@ -183,7 +183,7 @@ static int odm_RateUp_8188E(
 	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 0);
 
 	if (RateID < HighestRate) {
-		for (i = RateID+1; i <= HighestRate; i++) {
+		for (i = RateID + 1; i <= HighestRate; i++) {
 			if (pRaInfo->RAUseRate & BIT(i)) {
 				RateID = i;
 				goto RateUpfinish;
@@ -198,7 +198,7 @@ static int odm_RateUp_8188E(
 		RateID = HighestRate;
 	}
 RateUpfinish:
-	if (pRaInfo->RAWaitingCounter == (4+PendingForRateUpFail[pRaInfo->RAPendingCounter]))
+	if (pRaInfo->RAWaitingCounter == (4 + PendingForRateUpFail[pRaInfo->RAPendingCounter]))
 		pRaInfo->RAWaitingCounter = 0;
 	else
 		pRaInfo->RAWaitingCounter++;
@@ -212,8 +212,8 @@ static void odm_ResetRaCounter_8188E(struct odm_ra_info *pRaInfo)
 	u8 RateID;
 
 	RateID = pRaInfo->DecisionRate;
-	pRaInfo->NscUp = (N_THRESHOLD_HIGH[RateID]+N_THRESHOLD_LOW[RateID])>>1;
-	pRaInfo->NscDown = (N_THRESHOLD_HIGH[RateID]+N_THRESHOLD_LOW[RateID])>>1;
+	pRaInfo->NscUp = (N_THRESHOLD_HIGH[RateID] + N_THRESHOLD_LOW[RateID]) >> 1;
+	pRaInfo->NscDown = (N_THRESHOLD_HIGH[RateID] + N_THRESHOLD_LOW[RateID]) >> 1;
 }
 
 static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
@@ -295,41 +295,41 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 
 	switch (pRaInfo->RateID) {
 	case RATR_INX_WIRELESS_NGB:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff015;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0f8ff015;
 		break;
 	case RATR_INX_WIRELESS_NG:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff010;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0f8ff010;
 		break;
 	case RATR_INX_WIRELESS_NB:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff005;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0f8ff005;
 		break;
 	case RATR_INX_WIRELESS_N:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff000;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0f8ff000;
 		break;
 	case RATR_INX_WIRELESS_GB:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x00000ff5;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x00000ff5;
 		break;
 	case RATR_INX_WIRELESS_G:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x00000ff0;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x00000ff0;
 		break;
 	case RATR_INX_WIRELESS_B:
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0000000d;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0000000d;
 		break;
 	case 12:
 		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR0);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 13:
 		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR1);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 14:
 		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR2);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 15:
 		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR3);
-		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	default:
 		pRaInfo->RAUseRate = (pRaInfo->RateMask);
@@ -338,7 +338,7 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 	/*  Highest rate */
 	if (pRaInfo->RAUseRate) {
 		for (i = RATESIZE; i >= 0; i--) {
-			if ((pRaInfo->RAUseRate)&BIT(i)) {
+			if ((pRaInfo->RAUseRate) & BIT(i)) {
 				pRaInfo->HighestRate = i;
 				break;
 			}
@@ -443,15 +443,15 @@ static void odm_PTDecision_8188E(struct odm_ra_info *pRaInfo)
 	j = j >> 1;
 	temp_stage = (pRaInfo->PTStage + 1) >> 1;
 	if (temp_stage > j)
-		stage_id = temp_stage-j;
+		stage_id = temp_stage - j;
 	else
 		stage_id = 0;
 
-	pRaInfo->PTSmoothFactor = (pRaInfo->PTSmoothFactor>>1) + (pRaInfo->PTSmoothFactor>>2) + stage_id*16+2;
+	pRaInfo->PTSmoothFactor = (pRaInfo->PTSmoothFactor >> 1) + (pRaInfo->PTSmoothFactor >> 2) + stage_id * 16 + 2;
 	if (pRaInfo->PTSmoothFactor > 192)
 		pRaInfo->PTSmoothFactor = 192;
 	stage_id = pRaInfo->PTSmoothFactor >> 6;
-	temp_stage = stage_id*2;
+	temp_stage = stage_id * 2;
 	if (temp_stage != 0)
 		temp_stage -= 1;
 	if (pRaInfo->DROP > 3)
@@ -508,8 +508,8 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 	pRaInfo->PreRssiStaRA = 0;
 	pRaInfo->SGIEnable = 0;
 	pRaInfo->RAUseRate = 0xffffffff;
-	pRaInfo->NscDown = (N_THRESHOLD_HIGH[0x13]+N_THRESHOLD_LOW[0x13])/2;
-	pRaInfo->NscUp = (N_THRESHOLD_HIGH[0x13]+N_THRESHOLD_LOW[0x13])/2;
+	pRaInfo->NscDown = (N_THRESHOLD_HIGH[0x13] + N_THRESHOLD_LOW[0x13]) / 2;
+	pRaInfo->NscUp = (N_THRESHOLD_HIGH[0x13] + N_THRESHOLD_LOW[0x13]) / 2;
 	pRaInfo->RateSGI = 0;
 	pRaInfo->Active = 1;	/* Active is not used at present. by page, 110819 */
 	pRaInfo->RptTime = 0x927c;
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index 2fbac01dd969..55aa20a30342 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -8,7 +8,7 @@
 	 do {						\
 		 i += 2;				\
 		 v1 = array[i];				\
-		 v2 = array[i+1];			\
+		 v2 = array[i + 1];			\
 	 } while (0)
 
 static bool CheckCondition(const u32  condition, const u32  hex)
@@ -179,7 +179,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	u8     platform    = dm_odm->SupportPlatform;
 	u8     interfaceValue   = dm_odm->SupportInterface;
 	u8     board       = dm_odm->BoardType;
-	u32     arraylen    = sizeof(array_agc_tab_1t_8188e)/sizeof(u32);
+	u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
 	u32    *array       = array_agc_tab_1t_8188e;
 	bool		biol = false;
 	struct adapter *adapter =  dm_odm->Adapter;
@@ -203,7 +203,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 
 	for (i = 0; i < arraylen; i += 2) {
 		u32 v1 = array[i];
-		u32 v2 = array[i+1];
+		u32 v2 = array[i + 1];
 
 		/*  This (offset, data) pair meets the condition. */
 		if (v1 < 0xCDCDCDCD) {
@@ -459,7 +459,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 	u8     platform    = dm_odm->SupportPlatform;
 	u8     interfaceValue   = dm_odm->SupportInterface;
 	u8     board       = dm_odm->BoardType;
-	u32     arraylen    = sizeof(array_phy_reg_1t_8188e)/sizeof(u32);
+	u32     arraylen    = sizeof(array_phy_reg_1t_8188e) / sizeof(u32);
 	u32    *array       = array_phy_reg_1t_8188e;
 	bool	biol = false;
 	struct adapter *adapter =  dm_odm->Adapter;
@@ -482,7 +482,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 
 	for (i = 0; i < arraylen; i += 2) {
 		u32 v1 = array[i];
-		u32 v2 = array[i+1];
+		u32 v2 = array[i + 1];
 
 		/*  This (offset, data) pair meets the condition. */
 		if (v1 < 0xCDCDCDCD) {
@@ -676,8 +676,8 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 
 	for (i = 0; i < arraylen; i += 3) {
 		u32 v1 = array[i];
-		u32 v2 = array[i+1];
-		u32 v3 = array[i+2];
+		u32 v2 = array[i + 1];
+		u32 v3 = array[i + 2];
 
 		/*  this line is a line of pure_body */
 		if (v1 < 0xCDCDCDCD) {
@@ -688,13 +688,13 @@ void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
 				/*  don't need the hw_body */
 				i += 2; /*  skip the pair of expression */
 				v1 = array[i];
-				v2 = array[i+1];
-				v3 = array[i+2];
+				v2 = array[i + 1];
+				v3 = array[i + 2];
 				while (v2 != 0xDEAD) {
 					i += 3;
 					v1 = array[i];
-					v2 = array[i+1];
-					v3 = array[i+1];
+					v2 = array[i + 1];
+					v3 = array[i + 1];
 				}
 			}
 		}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 56b5d7c0bb9c..0ff2609c26bb 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -129,14 +129,14 @@ static u32 array_MAC_REG_8188E[] = {
 
 enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 {
-	#define READ_NEXT_PAIR(v1, v2, i) do { i += 2; v1 = array[i]; v2 = array[i+1]; } while (0)
+	#define READ_NEXT_PAIR(v1, v2, i) do { i += 2; v1 = array[i]; v2 = array[i + 1]; } while (0)
 
 	u32     hex         = 0;
 	u32     i;
 	u8     platform    = dm_odm->SupportPlatform;
 	u8     interface_val   = dm_odm->SupportInterface;
 	u8     board       = dm_odm->BoardType;
-	u32     array_len    = sizeof(array_MAC_REG_8188E)/sizeof(u32);
+	u32     array_len    = sizeof(array_MAC_REG_8188E) / sizeof(u32);
 	u32    *array       = array_MAC_REG_8188E;
 	bool	biol = false;
 
@@ -161,7 +161,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 
 	for (i = 0; i < array_len; i += 2) {
 		u32 v1 = array[i];
-		u32 v2 = array[i+1];
+		u32 v2 = array[i + 1];
 
 		/*  This (offset, data) pair meets the condition. */
 		if (v1 < 0xCDCDCDCD) {
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index c5895e0c798b..55e4b4a877a4 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -140,14 +140,14 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 {
 	#define READ_NEXT_PAIR(v1, v2, i) do	\
 		 { i += 2; v1 = Array[i];	\
-		 v2 = Array[i+1]; } while (0)
+		 v2 = Array[i + 1]; } while (0)
 
 	u32     hex         = 0;
 	u32     i           = 0;
 	u8     platform    = pDM_Odm->SupportPlatform;
 	u8     interfaceValue   = pDM_Odm->SupportInterface;
 	u8     board       = pDM_Odm->BoardType;
-	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E)/sizeof(u32);
+	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E) / sizeof(u32);
 	u32    *Array       = Array_RadioA_1T_8188E;
 	bool		biol = false;
 	struct adapter *Adapter =  pDM_Odm->Adapter;
@@ -171,7 +171,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 
 	for (i = 0; i < ArrayLen; i += 2) {
 		u32 v1 = Array[i];
-		u32 v2 = Array[i+1];
+		u32 v2 = Array[i + 1];
 
 		/*  This (offset, data) pair meets the condition. */
 		if (v1 < 0xCDCDCDCD) {
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index c92a76aebc11..356885e27edd 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -63,7 +63,7 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 	if (pwr_value >= ODM_TXPWRTRACK_MAX_IDX_88E && *pDirection == 1)
 		pwr_value = ODM_TXPWRTRACK_MAX_IDX_88E;
 
-	*pOutWriteVal = pwr_value | (pwr_value<<8) | (pwr_value<<16) | (pwr_value<<24);
+	*pOutWriteVal = pwr_value | (pwr_value << 8) | (pwr_value << 16) | (pwr_value << 24);
 }	/*  ODM_TxPwrTrackAdjust88E */
 
 /*-----------------------------------------------------------------------------
@@ -147,9 +147,9 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 	if (ThermalValue) {
 		/* Query OFDM path A default setting */
-		ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XATxIQImbalance, bMaskDWord)&bMaskOFDM_D;
+		ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XATxIQImbalance, bMaskDWord) & bMaskOFDM_D;
 		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
-			if (ele_D == (OFDMSwingTable[i]&bMaskOFDM_D)) {
+			if (ele_D == (OFDMSwingTable[i] & bMaskOFDM_D)) {
 				OFDM_index_old[0] = (u8)i;
 				dm_odm->BbSwingIdxOfdmBase = (u8)i;
 				break;
@@ -158,9 +158,9 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 		/* Query OFDM path B default setting */
 		if (is2t) {
-			ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord)&bMaskOFDM_D;
+			ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord) & bMaskOFDM_D;
 			for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
-				if (ele_D == (OFDMSwingTable[i]&bMaskOFDM_D)) {
+				if (ele_D == (OFDMSwingTable[i] & bMaskOFDM_D)) {
 					OFDM_index_old[1] = (u8)i;
 					break;
 				}
@@ -256,20 +256,20 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 				}
 			}
 			if (offset >= index_mapping_NUM_88E)
-				offset = index_mapping_NUM_88E-1;
+				offset = index_mapping_NUM_88E - 1;
 			for (i = 0; i < rf; i++)
 				OFDM_index[i] = dm_odm->RFCalibrateInfo.OFDM_index[i] + OFDM_index_mapping[j][offset];
 			CCK_index = dm_odm->RFCalibrateInfo.CCK_index + OFDM_index_mapping[j][offset];
 
 			for (i = 0; i < rf; i++) {
-				if (OFDM_index[i] > OFDM_TABLE_SIZE_92D-1)
-					OFDM_index[i] = OFDM_TABLE_SIZE_92D-1;
+				if (OFDM_index[i] > OFDM_TABLE_SIZE_92D - 1)
+					OFDM_index[i] = OFDM_TABLE_SIZE_92D - 1;
 				else if (OFDM_index[i] < OFDM_min_index)
 					OFDM_index[i] = OFDM_min_index;
 			}
 
-			if (CCK_index > CCK_TABLE_SIZE-1)
-				CCK_index = CCK_TABLE_SIZE-1;
+			if (CCK_index > CCK_TABLE_SIZE - 1)
+				CCK_index = CCK_TABLE_SIZE - 1;
 			else if (CCK_index < 0)
 				CCK_index = 0;
 
@@ -279,7 +279,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 				dm_odm->RFCalibrateInfo.bDoneTxpower = true;
 
 				/* Adujst OFDM Ant_A according to IQK result */
-				ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000)>>22;
+				ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000) >> 22;
 				X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][0];
 				Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][1];
 
@@ -300,19 +300,19 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 				if (X != 0) {
 					if ((X & 0x00000200) != 0)
 						X = X | 0xFFFFFC00;
-					ele_A = ((X * ele_D)>>8)&0x000003FF;
+					ele_A = ((X * ele_D) >> 8) & 0x000003FF;
 
 					/* new element C = element D x Y */
 					if ((Y & 0x00000200) != 0)
 						Y = Y | 0xFFFFFC00;
-					ele_C = ((Y * ele_D)>>8)&0x000003FF;
+					ele_C = ((Y * ele_D) >> 8) & 0x000003FF;
 
 					/*  2012/04/23 MH According to Luke's suggestion, we can not write BB digital */
 					/*  to increase TX power. Otherwise, EVM will be bad. */
 				}
 
 				if (is2t) {
-					ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000)>>22;
+					ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000) >> 22;
 
 					/* new element A = element D x X */
 					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][4];
@@ -321,21 +321,21 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
 						if ((X & 0x00000200) != 0)	/* consider minus */
 							X = X | 0xFFFFFC00;
-						ele_A = ((X * ele_D)>>8)&0x000003FF;
+						ele_A = ((X * ele_D) >> 8) & 0x000003FF;
 
 						/* new element C = element D x Y */
 						if ((Y & 0x00000200) != 0)
 							Y = Y | 0xFFFFFC00;
-						ele_C = ((Y * ele_D)>>8)&0x00003FF;
+						ele_C = ((Y * ele_D) >> 8) & 0x00003FF;
 
 						/* wtite new elements A, C, D to regC88 and regC9C, element B is always 0 */
-						value32 = (ele_D<<22) | ((ele_C&0x3F)<<16) | ele_A;
+						value32 = (ele_D << 22) | ((ele_C & 0x3F) << 16) | ele_A;
 						ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord, value32);
 
-						value32 = (ele_C&0x000003C0)>>6;
+						value32 = (ele_C & 0x000003C0) >> 6;
 						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, value32);
 
-						value32 = ((X * ele_D)>>7)&0x01;
+						value32 = ((X * ele_D) >> 7) & 0x01;
 						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(28), value32);
 					} else {
 						ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord, OFDMSwingTable[(u8)OFDM_index[1]]);
@@ -393,8 +393,8 @@ phy_PathA_IQK_8188E(struct adapter *adapt, bool configPathB)
 	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
 
 	if (!(regeac & BIT(28)) &&
-	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
-	    (((regE9C & 0x03FF0000)>>16) != 0x42))
+	    (((regE94 & 0x03FF0000) >> 16) != 0x142) &&
+	    (((regE9C & 0x03FF0000) >> 16) != 0x42))
 		result |= 0x01;
 	return result;
 }
@@ -447,13 +447,13 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
 
 	if (!(regeac & BIT(28)) &&
-	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
-	    (((regE9C & 0x03FF0000)>>16) != 0x42))
+	    (((regE94 & 0x03FF0000) >> 16) != 0x142) &&
+	    (((regE9C & 0x03FF0000) >> 16) != 0x42))
 		result |= 0x01;
 	else							/* if Tx not OK, ignore Rx */
 		return result;
 
-	u4tmp = 0x80007C00 | (regE94&0x3FF0000)  | ((regE9C&0x3FF0000) >> 16);
+	u4tmp = 0x80007C00 | (regE94 & 0x3FF0000)  | ((regE9C & 0x3FF0000) >> 16);
 	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, u4tmp);
 
 	/* 1 RX IQK */
@@ -496,8 +496,8 @@ phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
 	ODM_SetRFReg(dm_odm, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x180);
 
 	if (!(regeac & BIT(27)) &&		/* if Tx is OK, check whether Rx is OK */
-	    (((regEA4 & 0x03FF0000)>>16) != 0x132) &&
-	    (((regeac & 0x03FF0000)>>16) != 0x36))
+	    (((regEA4 & 0x03FF0000) >> 16) != 0x132) &&
+	    (((regeac & 0x03FF0000) >> 16) != 0x36))
 		result |= 0x02;
 
 	return result;
@@ -526,15 +526,15 @@ phy_PathB_IQK_8188E(struct adapter *adapt)
 	regecc = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord);
 
 	if (!(regeac & BIT(31)) &&
-	    (((regeb4 & 0x03FF0000)>>16) != 0x142) &&
-	    (((regebc & 0x03FF0000)>>16) != 0x42))
+	    (((regeb4 & 0x03FF0000) >> 16) != 0x142) &&
+	    (((regebc & 0x03FF0000) >> 16) != 0x42))
 		result |= 0x01;
 	else
 		return result;
 
 	if (!(regeac & BIT(30)) &&
-	    (((regec4 & 0x03FF0000)>>16) != 0x132) &&
-	    (((regecc & 0x03FF0000)>>16) != 0x36))
+	    (((regec4 & 0x03FF0000) >> 16) != 0x132) &&
+	    (((regecc & 0x03FF0000) >> 16) != 0x36))
 		result |= 0x02;
 
 	return result;
@@ -558,17 +558,17 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 		TX0_A = (X * Oldval_0) >> 8;
 		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x3FF, TX0_A);
 
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(31), ((X * Oldval_0>>7) & 0x1));
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(31), ((X * Oldval_0 >> 7) & 0x1));
 
 		Y = result[final_candidate][1];
 		if ((Y & 0x00000200) != 0)
 			Y = Y | 0xFFFFFC00;
 
 		TX0_C = (Y * Oldval_0) >> 8;
-		ODM_SetBBReg(dm_odm, rOFDM0_XCTxAFE, 0xF0000000, ((TX0_C&0x3C0)>>6));
-		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x003F0000, (TX0_C&0x3F));
+		ODM_SetBBReg(dm_odm, rOFDM0_XCTxAFE, 0xF0000000, ((TX0_C & 0x3C0) >> 6));
+		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x003F0000, (TX0_C & 0x3F));
 
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(29), ((Y * Oldval_0>>7) & 0x1));
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(29), ((Y * Oldval_0 >> 7) & 0x1));
 
 		if (txonly)
 			return;
@@ -602,17 +602,17 @@ static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 		TX1_A = (X * Oldval_1) >> 8;
 		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x3FF, TX1_A);
 
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(27), ((X * Oldval_1>>7) & 0x1));
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(27), ((X * Oldval_1 >> 7) & 0x1));
 
 		Y = result[final_candidate][5];
 		if ((Y & 0x00000200) != 0)
 			Y = Y | 0xFFFFFC00;
 
 		TX1_C = (Y * Oldval_1) >> 8;
-		ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, 0xF0000000, ((TX1_C&0x3C0)>>6));
-		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x003F0000, (TX1_C&0x3F));
+		ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, 0xF0000000, ((TX1_C & 0x3C0) >> 6));
+		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x003F0000, (TX1_C & 0x3F));
 
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(25), ((Y * Oldval_1>>7) & 0x1));
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(25), ((Y * Oldval_1 >> 7) & 0x1));
 
 		if (txonly)
 			return;
@@ -732,9 +732,9 @@ _PHY_MACSettingCalibration(
 	ODM_Write1Byte(dm_odm, MACReg[i], 0x3F);
 
 	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++) {
-		ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT(3))));
+		ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i] & (~BIT(3))));
 	}
-	ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT(5))));
+	ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i] & (~BIT(5))));
 }
 
 void
@@ -811,22 +811,22 @@ static bool phy_SimularityCompare_8188E(
 
 		if (diff > MAX_TOLERANCE) {
 			if ((i == 2 || i == 6) && !sim_bitmap) {
-				if (resulta[c1][i] + resulta[c1][i+1] == 0)
-					final_candidate[(i/4)] = c2;
-				else if (resulta[c2][i] + resulta[c2][i+1] == 0)
-					final_candidate[(i/4)] = c1;
+				if (resulta[c1][i] + resulta[c1][i + 1] == 0)
+					final_candidate[(i / 4)] = c2;
+				else if (resulta[c2][i] + resulta[c2][i + 1] == 0)
+					final_candidate[(i / 4)] = c1;
 				else
-					sim_bitmap = sim_bitmap | (1<<i);
+					sim_bitmap = sim_bitmap | (1 << i);
 			} else {
-				sim_bitmap = sim_bitmap | (1<<i);
+				sim_bitmap = sim_bitmap | (1 << i);
 			}
 		}
 	}
 
 	if (sim_bitmap == 0) {
-		for (i = 0; i < (bound/4); i++) {
+		for (i = 0; i < (bound / 4); i++) {
 			if (final_candidate[i] != 0xFF) {
-				for (j = i*4; j < (i+1)*4-2; j++)
+				for (j = i * 4; j < (i + 1) * 4 - 2; j++)
 					resulta[3][j] = resulta[final_candidate[i]][j];
 				result = false;
 			}
@@ -940,8 +940,8 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	for (i = 0; i < retryCount; i++) {
 		PathAOK = phy_PathA_IQK_8188E(adapt, is2t);
 		if (PathAOK == 0x01) {
-			result[t][0] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
-			result[t][1] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
+			result[t][0] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord) & 0x3FF0000) >> 16;
+			result[t][1] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord) & 0x3FF0000) >> 16;
 			break;
 		}
 	}
@@ -949,8 +949,8 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 	for (i = 0; i < retryCount; i++) {
 		PathAOK = phy_PathA_RxIQK(adapt, is2t);
 		if (PathAOK == 0x03) {
-			result[t][2] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
-			result[t][3] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
+			result[t][2] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord) & 0x3FF0000) >> 16;
+			result[t][3] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord) & 0x3FF0000) >> 16;
 			break;
 		}
 	}
@@ -964,14 +964,14 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t,
 		for (i = 0; i < retryCount; i++) {
 			PathBOK = phy_PathB_IQK_8188E(adapt);
 			if (PathBOK == 0x03) {
-				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord)&0x3FF0000)>>16;
-				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord)&0x3FF0000)>>16;
-				result[t][6] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord)&0x3FF0000)>>16;
-				result[t][7] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord)&0x3FF0000)>>16;
+				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
+				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
+				result[t][6] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord) & 0x3FF0000) >> 16;
+				result[t][7] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord) & 0x3FF0000) >> 16;
 				break;
 			} else if (i == (retryCount - 1) && PathBOK == 0x01) {	/* Tx IQK OK */
-				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord)&0x3FF0000)>>16;
-				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord)&0x3FF0000)>>16;
+				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
+				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord) & 0x3FF0000) >> 16;
 			}
 		}
 	}
@@ -1014,12 +1014,12 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	/* Check continuous TX and Packet TX */
 	tmpreg = ODM_Read1Byte(dm_odm, 0xd03);
 
-	if ((tmpreg&0x70) != 0)			/* Deal with contisuous TX case */
-		ODM_Write1Byte(dm_odm, 0xd03, tmpreg&0x8F);	/* disable all continuous TX */
+	if ((tmpreg & 0x70) != 0)			/* Deal with contisuous TX case */
+		ODM_Write1Byte(dm_odm, 0xd03, tmpreg & 0x8F);	/* disable all continuous TX */
 	else							/*  Deal with Packet TX case */
 		ODM_Write1Byte(dm_odm, REG_TXPAUSE, 0xFF);			/*  block all queues */
 
-	if ((tmpreg&0x70) != 0) {
+	if ((tmpreg & 0x70) != 0) {
 		/* 1. Read original RF mode */
 		/* Path-A */
 		RF_Amode = PHY_QueryRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits);
@@ -1030,23 +1030,23 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
-		ODM_SetRFReg(dm_odm, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode&0x8FFFF)|0x10000);
+		ODM_SetRFReg(dm_odm, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode & 0x8FFFF) | 0x10000);
 
 		/* Path-B */
 		if (is2t)
-			ODM_SetRFReg(dm_odm, RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode&0x8FFFF)|0x10000);
+			ODM_SetRFReg(dm_odm, RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode & 0x8FFFF) | 0x10000);
 	}
 
 	/* 3. Read RF reg18 */
 	LC_Cal = PHY_QueryRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits);
 
 	/* 4. Set LC calibration begin	bit15 */
-	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal|0x08000);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
 
 	ODM_sleep_ms(100);
 
 	/* Restore original situation */
-	if ((tmpreg&0x70) != 0) {
+	if ((tmpreg & 0x70) != 0) {
 		/* Deal with continuous TX case */
 		/* Path-A */
 		ODM_Write1Byte(dm_odm, 0xd03, tmpreg);
@@ -1239,14 +1239,14 @@ static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2
 
 	if (is2t) {	/* 92C */
 		if (main)
-			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5)|BIT(6), 0x1);	/* 92C_Path_A */
+			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5) | BIT(6), 0x1);	/* 92C_Path_A */
 		else
-			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5)|BIT(6), 0x2);	/* BT */
+			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(5) | BIT(6), 0x2);	/* BT */
 	} else {			/* 88C */
 		if (main)
-			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8)|BIT(9), 0x2);	/* Main */
+			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8) | BIT(9), 0x2);	/* Main */
 		else
-			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8)|BIT(9), 0x1);	/* Aux */
+			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(8) | BIT(9), 0x1);	/* Aux */
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 15386d42b0da..0fd11aca7ac7 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -78,7 +78,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
 					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
 				else
-					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd)*1000);
+					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd) * 1000);
 				break;
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index c3c76a37e52f..f09d4d49b159 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -16,46 +16,46 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 	char buf[128];
 
 	if (IS_81XXC(chip_vers)) {
-		cnt += sprintf((buf+cnt), "Chip Version Info: %s_",
+		cnt += sprintf((buf + cnt), "Chip Version Info: %s_",
 			       IS_92C_SERIAL(chip_vers) ?
 			       "CHIP_8192C" : "CHIP_8188C");
 	} else if (IS_92D(chip_vers)) {
-		cnt += sprintf((buf+cnt), "Chip Version Info: CHIP_8192D_");
+		cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8192D_");
 	} else if (IS_8723_SERIES(chip_vers)) {
-		cnt += sprintf((buf+cnt), "Chip Version Info: CHIP_8723A_");
+		cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8723A_");
 	} else if (IS_8188E(chip_vers)) {
-		cnt += sprintf((buf+cnt), "Chip Version Info: CHIP_8188E_");
+		cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
 	}
 
-	cnt += sprintf((buf+cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
+	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
 		       "Normal_Chip" : "Test_Chip");
-	cnt += sprintf((buf+cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
+	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
 		       "TSMC" : "UMC");
 	if (IS_A_CUT(chip_vers))
-		cnt += sprintf((buf+cnt), "A_CUT_");
+		cnt += sprintf((buf + cnt), "A_CUT_");
 	else if (IS_B_CUT(chip_vers))
-		cnt += sprintf((buf+cnt), "B_CUT_");
+		cnt += sprintf((buf + cnt), "B_CUT_");
 	else if (IS_C_CUT(chip_vers))
-		cnt += sprintf((buf+cnt), "C_CUT_");
+		cnt += sprintf((buf + cnt), "C_CUT_");
 	else if (IS_D_CUT(chip_vers))
-		cnt += sprintf((buf+cnt), "D_CUT_");
+		cnt += sprintf((buf + cnt), "D_CUT_");
 	else if (IS_E_CUT(chip_vers))
-		cnt += sprintf((buf+cnt), "E_CUT_");
+		cnt += sprintf((buf + cnt), "E_CUT_");
 	else
-		cnt += sprintf((buf+cnt), "UNKNOWN_CUT(%d)_",
+		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_",
 			       chip_vers.CUTVersion);
 
 	if (IS_1T1R(chip_vers))
-		cnt += sprintf((buf+cnt), "1T1R_");
+		cnt += sprintf((buf + cnt), "1T1R_");
 	else if (IS_1T2R(chip_vers))
-		cnt += sprintf((buf+cnt), "1T2R_");
+		cnt += sprintf((buf + cnt), "1T2R_");
 	else if (IS_2T2R(chip_vers))
-		cnt += sprintf((buf+cnt), "2T2R_");
+		cnt += sprintf((buf + cnt), "2T2R_");
 	else
-		cnt += sprintf((buf+cnt), "UNKNOWN_RFTYPE(%d)_",
+		cnt += sprintf((buf + cnt), "UNKNOWN_RFTYPE(%d)_",
 			       chip_vers.RFType);
 
-	cnt += sprintf((buf+cnt), "RomVer(%d)\n", chip_vers.ROMVer);
+	cnt += sprintf((buf + cnt), "RomVer(%d)\n", chip_vers.ROMVer);
 
 	pr_info("%s", buf);
 }
@@ -337,7 +337,7 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 	memset(c2h_evt, 0, 16);
 
 	*buf = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL);
-	*(buf+1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1);
+	*(buf + 1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1);
 
 	/* Read the content */
 	for (i = 0; i < c2h_evt->plen; i++)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 87c3bd58b63b..3937b65db5cc 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -254,8 +254,8 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 #ifdef CONFIG_88EU_AP_MODE
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
-		if ((mac_id-1) > 0)
-			psta = pstapriv->sta_aid[(mac_id-1) - 1];
+		if ((mac_id - 1) > 0)
+			psta = pstapriv->sta_aid[(mac_id - 1) - 1];
 		if (psta)
 			add_RATid(adapt, psta, 0);/* todo: based on rssi_level*/
 #endif
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 8a56b1a2516b..babe37e4be8b 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -426,9 +426,9 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
 {
-	pDM_Odm->bCckHighPower = (bool) ODM_GetBBReg(pDM_Odm, 0x824, BIT(9));
-	pDM_Odm->RFPathRxEnable = (u8) ODM_GetBBReg(pDM_Odm, 0xc04, 0x0F);
-	if (pDM_Odm->SupportICType & (ODM_RTL8192C|ODM_RTL8192D))
+	pDM_Odm->bCckHighPower = (bool)ODM_GetBBReg(pDM_Odm, 0x824, BIT(9));
+	pDM_Odm->RFPathRxEnable = (u8)ODM_GetBBReg(pDM_Odm, 0xc04, 0x0F);
+	if (pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8192D))
 		pDM_Odm->AntDivType = CG_TRX_HW_ANTDIV;
 	if (pDM_Odm->SupportICType & (ODM_RTL8723A))
 		pDM_Odm->AntDivType = CGCS_RX_SW_ANTDIV;
@@ -480,11 +480,11 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
-		if (pDM_Odm->SupportPlatform & (ODM_CE|ODM_MP)) {
+		if (pDM_Odm->SupportPlatform & (ODM_CE | ODM_MP)) {
 			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
 			if (pDM_Odm->SupportICType != ODM_RTL8188E)
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
-		} else if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
+		} else if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
 			switch (*pDM_Odm->pOnePathCCA) {
 			case ODM_CCA_2R:
 				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
@@ -530,11 +530,11 @@ void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm)
 	if (bFwCurrentInPSMode) {
 		/* Adjust by  FA in LPS MODE */
 		if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_LPS)
-			CurrentIGI = CurrentIGI+2;
+			CurrentIGI = CurrentIGI + 2;
 		else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1_LPS)
-			CurrentIGI = CurrentIGI+1;
+			CurrentIGI = CurrentIGI + 1;
 		else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0_LPS)
-			CurrentIGI = CurrentIGI-1;
+			CurrentIGI = CurrentIGI - 1;
 	} else {
 		CurrentIGI = RSSI_Lower;
 	}
@@ -542,8 +542,8 @@ void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm)
 	/* Lower bound checking */
 
 	/* RSSI Lower bound check */
-	if ((pDM_Odm->RSSI_Min-10) > DM_DIG_MIN_NIC)
-		RSSI_Lower = (pDM_Odm->RSSI_Min-10);
+	if ((pDM_Odm->RSSI_Min - 10) > DM_DIG_MIN_NIC)
+		RSSI_Lower = (pDM_Odm->RSSI_Min - 10);
 	else
 		RSSI_Lower = DM_DIG_MIN_NIC;
 
@@ -560,7 +560,7 @@ void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
-	pDM_DigTable->CurIGValue = (u8) ODM_GetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm));
+	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm));
 	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
 	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
 	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
@@ -599,7 +599,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	u8 dm_dig_max, dm_dig_min;
 	u8 CurrentIGI = pDM_DigTable->CurIGValue;
 
-	if ((!(pDM_Odm->SupportAbility&ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility&ODM_BB_FA_CNT)))
+	if ((!(pDM_Odm->SupportAbility & ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT)))
 		return;
 
 	if (*pDM_Odm->pbScanInProcess)
@@ -632,9 +632,9 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	}
 
 	/* 1 Boundary Decision */
-	if ((pDM_Odm->SupportICType & (ODM_RTL8192C|ODM_RTL8723A)) &&
+	if ((pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8723A)) &&
 	    ((pDM_Odm->BoardType == ODM_BOARD_HIGHPWR) || pDM_Odm->ExtLNA)) {
-		if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
+		if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
 			dm_dig_max = DM_DIG_MAX_AP_HP;
 			dm_dig_min = DM_DIG_MIN_AP_HP;
 		} else {
@@ -643,7 +643,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 		}
 		DIG_MaxOfMin = DM_DIG_MAX_AP_HP;
 	} else {
-		if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
+		if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
 			dm_dig_max = DM_DIG_MAX_AP;
 			dm_dig_min = DM_DIG_MIN_AP;
 			DIG_MaxOfMin = dm_dig_max;
@@ -685,7 +685,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 				   (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
 				/* 1 Lower Bound for 88E AntDiv */
 				if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)
-					DIG_Dynamic_MIN = (u8) pDM_DigTable->AntDiv_RSSI_max;
+					DIG_Dynamic_MIN = (u8)pDM_DigTable->AntDiv_RSSI_max;
 			} else {
 				DIG_Dynamic_MIN = dm_dig_min;
 			}
@@ -705,7 +705,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 		}
 
 		if (pDM_DigTable->LargeFAHit >= 3) {
-			if ((pDM_DigTable->ForbiddenIGI+1) > pDM_DigTable->rx_gain_range_max)
+			if ((pDM_DigTable->ForbiddenIGI + 1) > pDM_DigTable->rx_gain_range_max)
 				pDM_DigTable->rx_gain_range_min = pDM_DigTable->rx_gain_range_max;
 			else
 				pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
@@ -718,7 +718,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 			pDM_DigTable->Recover_cnt--;
 		} else {
 			if (pDM_DigTable->LargeFAHit < 3) {
-				if ((pDM_DigTable->ForbiddenIGI-1) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
+				if ((pDM_DigTable->ForbiddenIGI - 1) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
 					pDM_DigTable->ForbiddenIGI = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
 					pDM_DigTable->rx_gain_range_min = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
 				} else {
@@ -796,16 +796,16 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 1); /* hold page D counter */
 
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_Fast_Fsync = (ret_value&0xffff);
-		FalseAlmCnt->Cnt_SB_Search_fail = ((ret_value&0xffff0000)>>16);
+		FalseAlmCnt->Cnt_Fast_Fsync = (ret_value & 0xffff);
+		FalseAlmCnt->Cnt_SB_Search_fail = ((ret_value & 0xffff0000) >> 16);
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE2_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_OFDM_CCA = (ret_value&0xffff);
-		FalseAlmCnt->Cnt_Parity_Fail = ((ret_value&0xffff0000)>>16);
+		FalseAlmCnt->Cnt_OFDM_CCA = (ret_value & 0xffff);
+		FalseAlmCnt->Cnt_Parity_Fail = ((ret_value & 0xffff0000) >> 16);
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE3_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_Rate_Illegal = (ret_value&0xffff);
-		FalseAlmCnt->Cnt_Crc8_fail = ((ret_value&0xffff0000)>>16);
+		FalseAlmCnt->Cnt_Rate_Illegal = (ret_value & 0xffff);
+		FalseAlmCnt->Cnt_Crc8_fail = ((ret_value & 0xffff0000) >> 16);
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE4_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_Mcs_fail = (ret_value&0xffff);
+		FalseAlmCnt->Cnt_Mcs_fail = (ret_value & 0xffff);
 
 		FalseAlmCnt->Cnt_Ofdm_fail = FalseAlmCnt->Cnt_Parity_Fail + FalseAlmCnt->Cnt_Rate_Illegal +
 					     FalseAlmCnt->Cnt_Crc8_fail + FalseAlmCnt->Cnt_Mcs_fail +
@@ -813,8 +813,8 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 
 		if (pDM_Odm->SupportICType == ODM_RTL8188E) {
 			ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_SC_CNT_11N, bMaskDWord);
-			FalseAlmCnt->Cnt_BW_LSC = (ret_value&0xffff);
-			FalseAlmCnt->Cnt_BW_USC = ((ret_value&0xffff0000)>>16);
+			FalseAlmCnt->Cnt_BW_LSC = (ret_value & 0xffff);
+			FalseAlmCnt->Cnt_BW_USC = ((ret_value & 0xffff0000) >> 16);
 		}
 
 		/* hold cck counter */
@@ -824,10 +824,10 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
 		FalseAlmCnt->Cnt_Cck_fail = ret_value;
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_MSB_11N, bMaskByte3);
-		FalseAlmCnt->Cnt_Cck_fail +=  (ret_value & 0xff)<<8;
+		FalseAlmCnt->Cnt_Cck_fail +=  (ret_value & 0xff) << 8;
 
 		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_CCA_CNT_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_CCK_CCA = ((ret_value&0xFF)<<8) | ((ret_value&0xFF00)>>8);
+		FalseAlmCnt->Cnt_CCK_CCA = ((ret_value & 0xFF) << 8) | ((ret_value & 0xFF00) >> 8);
 
 		FalseAlmCnt->Cnt_all = (FalseAlmCnt->Cnt_Fast_Fsync +
 					FalseAlmCnt->Cnt_SB_Search_fail +
@@ -850,11 +850,11 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 0); /* update page D counter */
 
 			/* reset CCK CCA counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13)|BIT(12), 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13)|BIT(12), 2);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 2);
 			/* reset CCK FA counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15)|BIT(14), 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15)|BIT(14), 2);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 2);
 		}
 	} else { /* FOR ODM_IC_11AC_SERIES */
 		/* read OFDM FA counter */
@@ -880,7 +880,7 @@ void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
 	u8 CurCCK_CCAThres;
 	struct false_alarm_stats *FalseAlmCnt = &pDM_Odm->FalseAlmCnt;
 
-	if (!(pDM_Odm->SupportAbility & (ODM_BB_CCK_PD|ODM_BB_FA_CNT)))
+	if (!(pDM_Odm->SupportAbility & (ODM_BB_CCK_PD | ODM_BB_FA_CNT)))
 		return;
 	if (pDM_Odm->ExtLNA)
 		return;
@@ -935,7 +935,7 @@ void odm_DynamicBBPowerSaving(struct odm_dm_struct *pDM_Odm)
 		return;
 	if (!(pDM_Odm->SupportAbility & ODM_BB_PWR_SAVE))
 		return;
-	if (!(pDM_Odm->SupportPlatform & (ODM_MP|ODM_CE)))
+	if (!(pDM_Odm->SupportPlatform & (ODM_MP | ODM_CE)))
 		return;
 
 	/* 1 2.Power Saving for 92C */
@@ -993,10 +993,10 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 		Rssi_Low_bound = 45;
 	}
 	if (pDM_PSTable->initialize == 0) {
-		pDM_PSTable->Reg874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord)&0x1CC000)>>14;
-		pDM_PSTable->RegC70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord)&BIT(3))>>3;
-		pDM_PSTable->Reg85C = (ODM_GetBBReg(pDM_Odm, 0x85c, bMaskDWord)&0xFF000000)>>24;
-		pDM_PSTable->RegA74 = (ODM_GetBBReg(pDM_Odm, 0xa74, bMaskDWord)&0xF000)>>12;
+		pDM_PSTable->Reg874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord) & 0x1CC000) >> 14;
+		pDM_PSTable->RegC70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord) & BIT(3)) >> 3;
+		pDM_PSTable->Reg85C = (ODM_GetBBReg(pDM_Odm, 0x85c, bMaskDWord) & 0xFF000000) >> 24;
+		pDM_PSTable->RegA74 = (ODM_GetBBReg(pDM_Odm, 0xa74, bMaskDWord) & 0xF000) >> 12;
 		pDM_PSTable->initialize = 1;
 	}
 
@@ -1088,7 +1088,7 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 		else
 			rate_bitmap = 0x0000000f;
 		break;
-	case (ODM_WM_B|ODM_WM_G):
+	case (ODM_WM_B | ODM_WM_G):
 		if (rssi_level == DM_RATR_STA_HIGH)
 			rate_bitmap = 0x00000f00;
 		else if (rssi_level == DM_RATR_STA_MIDDLE)
@@ -1096,7 +1096,7 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 		else
 			rate_bitmap = 0x00000ff5;
 		break;
-	case (ODM_WM_B|ODM_WM_G|ODM_WM_N24G):
+	case (ODM_WM_B | ODM_WM_G | ODM_WM_N24G):
 		if (pDM_Odm->RFType == ODM_1T2R || pDM_Odm->RFType == ODM_1T1R) {
 			if (rssi_level == DM_RATR_STA_HIGH) {
 				rate_bitmap = 0x000f0000;
@@ -1378,7 +1378,7 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 			if (psta->rssi_stat.UndecoratedSmoothedPWDB > tmpEntryMaxPWDB)
 				tmpEntryMaxPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
 			if (psta->rssi_stat.UndecoratedSmoothedPWDB != (-1))
-				PWDB_rssi[sta_cnt++] = (psta->mac_id | (psta->rssi_stat.UndecoratedSmoothedPWDB<<16));
+				PWDB_rssi[sta_cnt++] = (psta->mac_id | (psta->rssi_stat.UndecoratedSmoothedPWDB << 16));
 		}
 	}
 
@@ -1388,7 +1388,7 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 				/*  Report every sta's RSSI to FW */
 			} else {
 				ODM_RA_SetRSSI_8188E(
-				&pHalData->odmpriv, (PWDB_rssi[i]&0xFF), (u8)((PWDB_rssi[i]>>16) & 0xFF));
+				&pHalData->odmpriv, (PWDB_rssi[i] & 0xFF), (u8)((PWDB_rssi[i] >> 16) & 0xFF));
 			}
 		}
 	}
@@ -1693,7 +1693,7 @@ u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point, u8 initial_gai
 	/* Read PSD report, Reg8B4[15:0] */
 	psd_report = ODM_GetBBReg(pDM_Odm, 0x8B4, bMaskDWord) & 0x0000FFFF;
 
-	psd_report = (u32) (ConvertTo_dB(psd_report))+(u32)(initial_gain_psd-0x1c);
+	psd_report = (u32)(ConvertTo_dB(psd_report)) + (u32)(initial_gain_psd - 0x1c);
 
 	return psd_report;
 }
@@ -1718,7 +1718,7 @@ u32 ConvertTo_dB(u32 Value)
 			break;
 	}
 
-	dB = i*12 + j + 1;
+	dB = i * 12 + j + 1;
 
 	return dB;
 }
@@ -1783,19 +1783,19 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 		rSleep, rPMPD_ANAEN,
 		rFPGA0_XCD_SwitchControl, rBlue_Tooth};
 
-	if (!(pDM_Odm->SupportICType & (ODM_RTL8723A|ODM_RTL8192C)))
+	if (!(pDM_Odm->SupportICType & (ODM_RTL8723A | ODM_RTL8192C)))
 		return bResult;
 
-	if (!(pDM_Odm->SupportAbility&ODM_BB_ANT_DIV))
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
 		return bResult;
 
 	if (pDM_Odm->SupportICType == ODM_RTL8192C) {
 		/* Which path in ADC/DAC is turnned on for PSD: both I/Q */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT(10)|BIT(11), 0x3);
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT(10) | BIT(11), 0x3);
 		/* Ageraged number: 8 */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT(12)|BIT(13), 0x1);
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT(12) | BIT(13), 0x1);
 		/* pts = 128; */
-		ODM_SetBBReg(pDM_Odm, 0x808, BIT(14)|BIT(15), 0x0);
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT(14) | BIT(15), 0x0);
 	}
 
 	/* 1 Backup Current RF/BB Settings */
@@ -1817,7 +1817,7 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 	odm_PHY_SaveAFERegisters(pDM_Odm, AFE_REG_8723A, AFE_Backup, 16);
 
 	/* Set PSD 128 pts */
-	ODM_SetBBReg(pDM_Odm, rFPGA0_PSDFunction, BIT(14)|BIT(15), 0x0);  /* 128 pts */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_PSDFunction, BIT(14) | BIT(15), 0x0);  /* 128 pts */
 
 	/*  To SET CH1 to do */
 	ODM_SetRFReg(pDM_Odm, RF_PATH_A, ODM_CHANNEL, bRFRegOffsetMask, 0x01);     /* Channel 1 */
@@ -1917,7 +1917,7 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 	/* 2 Test Ant B based on Ant A is ON */
 		if (mode == ANTTESTB) {
 			if (AntA_report >= 100) {
-				if (AntB_report > (AntA_report+1))
+				if (AntB_report > (AntA_report + 1))
 					pDM_SWAT_Table->ANTB_ON = false;
 				else
 					pDM_SWAT_Table->ANTB_ON = true;
@@ -1927,13 +1927,13 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 			}
 		} else if (mode == ANTTESTALL) {
 			/* 2 Test Ant A and B based on DPDT Open */
-			if ((AntO_report >= 100)&(AntO_report < 118)) {
-				if (AntA_report > (AntO_report+1))
+			if ((AntO_report >= 100) & (AntO_report < 118)) {
+				if (AntA_report > (AntO_report + 1))
 					pDM_SWAT_Table->ANTA_ON = false;
 				else
 					pDM_SWAT_Table->ANTA_ON = true;
 
-				if (AntB_report > (AntO_report+2))
+				if (AntB_report > (AntO_report + 2))
 					pDM_SWAT_Table->ANTB_ON = false;
 				else
 					pDM_SWAT_Table->ANTB_ON = true;
@@ -1941,11 +1941,11 @@ bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
 		}
 	} else if (pDM_Odm->SupportICType == ODM_RTL8192C) {
 		if (AntA_report >= 100) {
-			if (AntB_report > (AntA_report+2)) {
+			if (AntB_report > (AntA_report + 2)) {
 				pDM_SWAT_Table->ANTA_ON = false;
 				pDM_SWAT_Table->ANTB_ON = true;
 				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_B);
-			} else if (AntA_report > (AntB_report+2)) {
+			} else if (AntA_report > (AntB_report + 2)) {
 				pDM_SWAT_Table->ANTA_ON = true;
 				pDM_SWAT_Table->ANTB_ON = false;
 				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_A);
-- 
2.32.0

