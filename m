Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3F3EB187
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbhHMHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbhHMHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:32:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D436FC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g138so6239516wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqc+yMVP2i+3acbZSR2lHwok1K9tZMulFHp9dkl3wSQ=;
        b=DKrnxnuNpIpq8XSd/3B/haU8XU+XipvaTRXVL+DyNLTz/jHJDEloCLNWVvzyhbHUb4
         SgiYrNtOpf8y37j0BM+UhBwbbTDKefnxYZWjHShSjmFFxl6V8j7DjRNA5yd0Cmb6vPtX
         zhxiqzcDqw+eDa+7TzR6fDrdAO14A1FAprDlo+jCidG3ovkpn+jSCdw3pSKStz6WkKhI
         MGS/Lwr7/VmI1TRvS0zLQL/LYQ9hwT2NMLnZtlzvWSAJrk7BgbvxZZn8dsUOiAkZkw48
         qNiBDO6sUDAtQLKHd0qSQpEnJg0IErJ19ZHV3CCqNnTZZ9M5dPjS6K4hR+gWlq8mmkmv
         c44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqc+yMVP2i+3acbZSR2lHwok1K9tZMulFHp9dkl3wSQ=;
        b=noOS6sTvN3HOMEgLci1mTX9RbVLJhMM29x2GogyL19D7We/N8kvO/YOZJJlVgnfoMo
         RV3Fibqig38LZ/B7M2vpBBmjYEaFImHhHmjFyevWGTLOI1Wa0T7pjMaBNr9yC1KNf3lp
         6JTB87wlrDT/Uhh4GHHsW4V21G7pcaZ7kv3/HB3Aj40/+H0SgKuG9+EdfbDR+y2c4yFi
         4mi4Oe01VoIcHoLrJNaEOVGVtuoSJLhUsLtunC7w0i7A573PDJ5Fg0JxX4OWfelJuRUe
         dvchInATS0+wMF+V3Hmqh42EHq+mm/0LIPh3tlCiXciEjnnyaa7Y2hFixFtI6gFLSmTu
         ETCw==
X-Gm-Message-State: AOAM530+y+v83r71WQM1zgXInM8CDdF525yctSXa5noX1ZppptXdHjH0
        2eISWQdWC3WAfm+zzUTmMbQ=
X-Google-Smtp-Source: ABdhPJzol8ay2u4gNsA/LnT/BNFJGc2TQlSCUjyFKtwMHwPSvSl+YhnB0kgeFg0I7UTsRG+gYx5D1A==
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr1221306wmd.67.1628839921489;
        Fri, 13 Aug 2021 00:32:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id k12sm697406wrd.75.2021.08.13.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 00:32:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: convert return type of Hal_GetChnlGroup88E() to void
Date:   Fri, 13 Aug 2021 09:31:07 +0200
Message-Id: <20210813073109.25609-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813073109.25609-1-straube.linux@gmail.com>
References: <20210813073109.25609-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of 5GHz code from Hal_GetChnlGroup88E() the function
always returns true now. Convert the return type to void and change the
only user Hal_ReadTxPowerInfo88E() accordingly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 30 ++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 634a0a022727..d3345fa0eb60 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2060,7 +2060,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 	}
 }
 
-static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
+static void Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
 {
 	if (chnl < 3)			/*  Channel 1-2 */
 		*pGroup = 0;
@@ -2074,8 +2074,6 @@ static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
 		*pGroup = 4;
 	else if (chnl == 14)		/*  Channel 14 */
 		*pGroup = 5;
-
-	return true;
 }
 
 void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
@@ -2107,7 +2105,7 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct txpowerinfo24g pwrInfo24G;
 	u8 rfPath, ch, group;
-	u8 bIn24G, TxCount;
+	u8 TxCount;
 
 	Hal_ReadPowerValueFromPROM_8188E(&pwrInfo24G, PROMContent, AutoLoadFail);
 
@@ -2116,19 +2114,17 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 
 	for (rfPath = 0; rfPath < pHalData->NumTotalRFPath; rfPath++) {
 		for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
-			bIn24G = Hal_GetChnlGroup88E(ch, &group);
-			if (bIn24G) {
-				pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
-				if (ch == 14)
-					pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][4];
-				else
-					pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
-			}
-			if (bIn24G) {
-				DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
-				DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
-				DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
-			}
+			Hal_GetChnlGroup88E(ch, &group);
+
+			pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
+			if (ch == 14)
+				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][4];
+			else
+				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
+
+			DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
+			DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
+			DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
 		}
 		for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
 			pHalData->CCK_24G_Diff[rfPath][TxCount] = pwrInfo24G.CCK_Diff[rfPath][TxCount];
-- 
2.32.0

