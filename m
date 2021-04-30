Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D736FD10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhD3O70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhD3O6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA04AC061348
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gx5so13611053ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8UHA9rSzQVhyxXvVNgcpiOrcASMmZu8u6+fbC09MUc=;
        b=QNKtYrJwpzJIhGfaCu2AIoSrRmMMmcc+orkeyaOJO6kovvcf4owrfJGyNmrf8l8ve6
         Rpcvorp+71ab0K9TTNxozGFpcmFld5pPZIt91Toy4F2BCtThayBS6JEu6CaIVSilI8Qa
         9fKAp7B7THyv8oTR9bBNvKnCtMUhIyfwQApfQH77Z4gNbrF3wUzMYlQyCIKicA0rr/A4
         jJn/GmJ2lkEgbqvIoAKGKvugCcVkyZEw/cbTBcWT7cHXun7rn/Y4LSVeRZPhuzMjCSsa
         Oo7qQ38ViBVqkdbdB+sYbZeIPVTy7dyZgUQ2+tBQUBRGFM14uqT/jUYOAOmUDIwSsYFN
         Yxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8UHA9rSzQVhyxXvVNgcpiOrcASMmZu8u6+fbC09MUc=;
        b=oEXOCAeICDakylbuZOgzmnSZKi0VBXOXEvzmgOyMxAd2IgQhr4QWZUKDDlgUIW8vQP
         cxLqLTt9CK4G/CstMF5GwR/ZaUB/GoAIJCN7IRY6zHNqcrrHPMOTVRf5dv2aFD02iP5T
         uRNbIVp2c2TS03/iNYhBm3svfrezBSoWIyg3FBRcPGxVks3DE0KzE52aOiRK/SSbfJEy
         3IrU4kTtS1x4q+5jvrJ96OBXfDJztzg/bWw+jozF6NjmjUHcxLdNEsC8iR/MzlH1zRnp
         hxxbmmnwb9CyKwpkIFQd5+p3JVPPfqC7hpGuPY6Ca/LF1u++EVxWpo9R/aoffex6VKtg
         +UCw==
X-Gm-Message-State: AOAM533tREDptIaO1U2iYH48jlYKanYa28y9bKBADYNDiZAgEsAWKngh
        VFL4R0sgC8hTuUnFORMOvI8Pfk06QO8=
X-Google-Smtp-Source: ABdhPJwPlV/kCn/OoDI2uihBUpdxNlamAyX32vJFeWR7guNxAdkh1cKAuzIn/XnyCU89Id2Mnf0zfw==
X-Received: by 2002:a17:907:8323:: with SMTP id mq35mr4825638ejc.391.1619794665346;
        Fri, 30 Apr 2021 07:57:45 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id zo6sm2096714ejb.77.2021.04.30.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/43] staging: rtl8723bs: remove commented out BTC_PRINT logs
Date:   Fri, 30 Apr 2021 16:56:45 +0200
Message-Id: <dd6ea6b65cb7db15254ac6ab3fbdfcabb7e66a1a.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out BTC_PRINT logs.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 911d753e51f6..300327f8706c 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1055,8 +1055,6 @@ static void halbtc8723b1ant_PsTdma(
 	s8 nWiFiDurationAdjust = 0x0;
 	/* u32 		fwVer = 0; */
 
-	/* BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW, ("[BTCoex], %s turn %s PS TDMA, type =%d\n", */
-	/* 	(bForceExec? "force to":""), (bTurnOn? "ON":"OFF"), type)); */
 	pCoexDm->bCurPsTdmaOn = bTurnOn;
 	pCoexDm->curPsTdma = type;
 
@@ -1423,9 +1421,6 @@ static void halbtc8723b1ant_TdmaDurationAdjustForAcl(
 		/* acquire the BT TRx retry count from BT_Info byte2 */
 		retryCount = pCoexSta->btRetryCnt;
 		btInfoExt = pCoexSta->btInfoExt;
-		/* BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], retryCount = %d\n", retryCount)); */
-		/* BTC_PRINT(BTC_MSG_ALGORITHM, ALGO_TRACE_FW_DETAIL, ("[BTCoex], up =%d, dn =%d, m =%d, n =%d, WaitCount =%d\n", */
-		/* 	up, dn, m, n, WaitCount)); */
 
 		if (pCoexSta->lowPriorityTx > 1050 || pCoexSta->lowPriorityRx > 1250)
 			retryCount++;
@@ -2788,13 +2783,11 @@ void EXhalbtc8723b1ant_ScanNotify(struct btc_coexist *pBtCoexist, u8 type)
 	}
 
 	if (BTC_SCAN_START == type) {
-		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN START notify\n")); */
 		if (!bWifiConnected)	/*  non-connected scan */
 			halbtc8723b1ant_ActionWifiNotConnectedScan(pBtCoexist);
 		else	/*  wifi is connected */
 			halbtc8723b1ant_ActionWifiConnectedScan(pBtCoexist);
 	} else if (BTC_SCAN_FINISH == type) {
-		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], SCAN FINISH notify\n")); */
 		if (!bWifiConnected)	/*  non-connected scan */
 			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
 		else
@@ -2844,11 +2837,8 @@ void EXhalbtc8723b1ant_ConnectNotify(struct btc_coexist *pBtCoexist, u8 type)
 	}
 
 	if (BTC_ASSOCIATE_START == type) {
-		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT START notify\n")); */
 		halbtc8723b1ant_ActionWifiNotConnectedAssoAuth(pBtCoexist);
 	} else if (BTC_ASSOCIATE_FINISH == type) {
-		/* BTC_PRINT(BTC_MSG_INTERFACE, INTF_NOTIFY, ("[BTCoex], CONNECT FINISH notify\n")); */
-
 		pBtCoexist->fBtcGet(pBtCoexist, BTC_GET_BL_WIFI_CONNECTED, &bWifiConnected);
 		if (!bWifiConnected) /*  non-connected scan */
 			halbtc8723b1ant_ActionWifiNotConnected(pBtCoexist);
-- 
2.20.1

