Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0036F693
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhD3HqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhD3Hpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B527C06138F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so103858837ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auqmHaougiorEJiold25Fwbfcoe9phFoSmF9xCEzReU=;
        b=h1YveRiEHzhMBx7bMTTxjBqHEVv3TSrCoClhOQydIoBNi/UvnQxcLxWX5UnUrGRvI+
         EKGcC+pFs77Z4NidOadyWqxLcaPZkIlGrHJldgHmoXko/j9QwewwM/gb5aT+J21w8q2A
         y2GKDWyGLccvYrWA0tWWO3wWyEBHA2Aypjl00Vq8uqP5JqzSWsLiQWPjb2k1LwXlWctS
         YXbN+dLBFFRQVnmMlHbW2ww2tj4OtC3I+QJcVc0DBaQljq3DZYd2byX26E8qbXMbv14f
         LXJeWZlQNm62JdEJGUxooapH0+J2uCNfxt+aVzAnoLDtGCm15PY8osRGmjOM/9Q5412c
         fquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auqmHaougiorEJiold25Fwbfcoe9phFoSmF9xCEzReU=;
        b=OtXSdqQWFy3SQMgK/Kwy54qVU8bcnKzzfJQ89O0+qOPJg705KnKDmVY2g8WTD2i7Pm
         QHsCahqe6dBvJJlz5eEYxA0OrsJhpfa9LGK80NbPumszlyT7iKa82DdLNT5NbpMTBI93
         l9q5hnwRILT9Fpu18qJwcj90n5Jj7U7SUFmWN285gfJvFP5cKkdEeI/WSCTzZtWl/u0d
         qTBw8Hsz/aaLbtHTeA+WJPk0fClOP7nZVGogIQXUbQGz9v9iEISobgCNQn7JN2eBPHNA
         oGplHrGhGTTHcBSHZKbH5eVdesJr/rpb+j3XTamQZKf1MtJQkj14gXXu8blV2E9Z3dtC
         QbbA==
X-Gm-Message-State: AOAM532WxIBHbKcRZUjYl/Zat9ZE7wuQG5TPBR8+67C5mBfKnYpKnGI4
        l726qTZl/iltFYnaCpij09QLZ1KU5GbVGg==
X-Google-Smtp-Source: ABdhPJwnK3VHV3x/KUoBSliBJQ6bOIU12OwYHaqaDS0genoU35ihBmOyHiKtZKDbhiQm5sJov32SuQ==
X-Received: by 2002:a17:906:6703:: with SMTP id a3mr2822710ejp.240.1619768679671;
        Fri, 30 Apr 2021 00:44:39 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id b19sm622470edd.66.2021.04.30.00.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 21/43] staging: rtl8723bs: remove empty if-else blocks after BTC_PRINT removal
Date:   Fri, 30 Apr 2021 09:43:39 +0200
Message-Id: <56cb29d5559b7db9bbcbfc14bfbf6118973434db.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove if-else blocks left empty after BTC_PRINT removal.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 16 +---------------
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 12 +-----------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 28f41a637c96..57579d7eab71 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -606,8 +606,7 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bPanExist &&
 				pBtLinkInfo->bA2dpExist
 			) {
-				if (bBtHsOn) {
-				} else {
+				if (!bBtHsOn) {
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}
 			}
@@ -1063,10 +1062,6 @@ static void halbtc8723b1ant_PsTdma(
 
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_BUSY, &bWifiBusy);
 
-	if (pCoexDm->bCurPsTdmaOn) {
-	} else {
-	}
-
 	if (!bForceExec) {
 		if (
 			(pCoexDm->bPrePsTdmaOn == pCoexDm->bCurPsTdmaOn) &&
@@ -1373,10 +1368,6 @@ static bool halbtc8723b1ant_IsCommonAction(struct btc_coexist *pBtCoexist)
 
 		bCommon = true;
 	} else {
-		if (bWifiBusy) {
-		} else {
-		}
-
 		bCommon = false;
 	}
 
@@ -1528,7 +1519,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 				halbtc8723b1ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, 1);
 				pCoexDm->psTdmaDuAdjType = 1;
 			}
-		} else {	  /* no change */
 		}
 
 		if (
@@ -3012,10 +3002,6 @@ void EXhalbtc8723b1ant_BtInfoNotify(
 		pCoexSta->btInfoC2h[rspSource][i] = tmpBuf[i];
 		if (i == 1)
 			btInfo = tmpBuf[i];
-		if (i == length - 1)
-			{}
-		else
-			{}
 	}
 
 	if (BT_INFO_SRC_8723B_1ANT_WIFI_FW != rspSource) {
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 73f1cc6bc27c..15304feb2442 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -1621,8 +1621,7 @@ static void halbtc8723b2ant_TdmaDurationAdjust(
 
 		if (!bScan && !bLink && !bRoam)
 			halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, pCoexDm->psTdmaDuAdjType);
-		else {
-		}
+
 	}
 }
 
@@ -2859,10 +2858,6 @@ void EXhalbtc8723b2ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 	u8 wifiCentralChnl;
 	u8 apNum = 0;
 
-	if (BTC_MEDIA_CONNECT == type) {
-	} else {
-	}
-
 	/*  only 2.4G we need to inform bt the chnl mask */
 	pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_U1_WIFI_CENTRAL_CHNL, &wifiCentralChnl);
 	if ((BTC_MEDIA_CONNECT == type) && (wifiCentralChnl <= 14)) {
@@ -2889,8 +2884,6 @@ void EXhalbtc8723b2ant_MediaStatusNotify(struct btc_coexist *pBtCoexist, u8 type
 
 void EXhalbtc8723b2ant_SpecialPacketNotify(struct btc_coexist *pBtCoexist, u8 type)
 {
-	if (type == BTC_PACKET_DHCP) {
-	}
 }
 
 void EXhalbtc8723b2ant_BtInfoNotify(
@@ -2915,9 +2908,6 @@ void EXhalbtc8723b2ant_BtInfoNotify(
 		if (i == 1)
 			btInfo = tmpBuf[i];
 
-		if (i == length - 1) {
-		} else {
-		}
 	}
 
 	if (pBtCoexist->bManualControl) {
-- 
2.20.1

