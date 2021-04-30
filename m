Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3736FD0D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhD3O7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhD3O6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80807C061347
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g14so23291732edy.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auqmHaougiorEJiold25Fwbfcoe9phFoSmF9xCEzReU=;
        b=kILlZF3JkAYiT8+cq3igucLG8UBqezgW0iQ+w/CglQ6kufyaFYg/7MTbwgQ4wkoBxu
         DsiDuFTIhGFrgXXqLgXvI6BLU42HCfuw9jHhKwcjiVUNQZ7BntolIQlgZ0hLF9vrCrZn
         bUNZKxTvZ6FhK/+kK36uywVkjMHubD5Toh1pkORubegvWP0lCqAmxej868xhKh/HzYQm
         9PqY3CNen1obThxXPuYf4KTcHfBCbqR0cozG3vKrQ8gNcHsl6EQgByNfXlm+h9ZgRBm7
         mm1eYeZLor+gPhbmZ7OV/mYVljhtgtGXj1V22remNWUddJLrGjyd8i5nF3Y84/EW88Vj
         3zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auqmHaougiorEJiold25Fwbfcoe9phFoSmF9xCEzReU=;
        b=rqEt5Kd9jCE6wVmV0d7L5Is5C2o+GemlfavSey7FRVo82tUTJ//TbjQbAg4nI2dgMX
         0ei5zvSBx159h5KUYp1L8BQZPFTIX4PqMAz0GEubxAiG5zd9S85i/y9t5bF6sp8KojIY
         7Ep58n2gT76m0W0wzIHh3e9iMzFcdsYwuZazbm79+M5Xz8eQoVnoHT/EVaJTPgh2+KHk
         yFxWyazqtPliN/d+GGPch6iPMqIW8j8P8q13CiVBjboYC9y6rjSapKIET48UsH6GcT2M
         WTIrzE9EruiI4NTUebu2uu+/NSEUIILhl0dHIC7ntqpSw1VGjdNdbzMo3wz0f1ZlZJDf
         +KfA==
X-Gm-Message-State: AOAM531O0c9D8IGpSo2PRIzUp5E9wGCg1cTAz7OV5tBfgjOXgDkgOGay
        4mKG6KVEJ9vRycKoTXtpMu1lZCFqiKU=
X-Google-Smtp-Source: ABdhPJzrDtf/JQNPJBuqvNfv+lJSHEkWIcd5nTRNWcHYckZZu81D04+oEr1Vf3/KUOoxECcNJs19Ng==
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr6272454edb.135.1619794661855;
        Fri, 30 Apr 2021 07:57:41 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id h15sm2058466ejs.72.2021.04.30.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/43] staging: rtl8723bs: remove empty if-else blocks after BTC_PRINT removal
Date:   Fri, 30 Apr 2021 16:56:43 +0200
Message-Id: <102455368fa9535dc78584d7d24cd12ee4160737.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

