Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11F36F696
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhD3HqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhD3Hpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C70DC061344
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g14so21815033edy.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8UHA9rSzQVhyxXvVNgcpiOrcASMmZu8u6+fbC09MUc=;
        b=Fg6Ag5znNlFFxSDmFsZ4E8L0shdlBl2MpkjpcHv0hi9VqvuUibO+yrH676D9xQu32i
         f3f57I8ZYzHo6Ojh2kF24dhFg3EPrBXfr0D2CSSQolw9nJKq2Guu+vXFc58qsfCSbgsk
         RevLQZpsTdLMjfNKk33AOJb0GDXqfpY0mqYtAiggiz9Ru7XxhFOZcQbkAYpU7P7TTvqX
         SixJ61KH8d4bL63aoKQZKjQQ+Y/XL5Hqwt2Gh4+s67rrMb+ptCeKLmXgMOwfXfsGsEpd
         FUh8+/n6GUJYODxZvFwTSkc43xGRhH+NYFhyvMYylIHC5zV80mc4Ndn6gmoV05b4tZMM
         MG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8UHA9rSzQVhyxXvVNgcpiOrcASMmZu8u6+fbC09MUc=;
        b=eGy3V23McZIOdyAbaCk3APF6znyh42KONga6sMbOVS2A8wc/9BTwawS6j9hWmzjrJA
         siXdgbM/UPyqpAMyf+XWt3MFZde7p2crXPLSVoOlvoZDA97GOwO57iWJU38tNak3ZK3t
         25IWn4vHxFMhRhAhYQtt/XjyJe11PKv1VNxia2pifBJcAJNT7rC0hIV23H027HP9aU1o
         AzuxTE9IDazBohqHGMx5i0tG8rezp/h1XMpqDg4cdAHYram1h9tAiOzIt6oAqgJwxM2K
         ZnghxZD9prVejX6L4dL34VjGf+1EHdANwIo9njvoU8wQgxnM5pZCT3GJwuq8hcdfuPm1
         q4Tg==
X-Gm-Message-State: AOAM533qh5knBnJe2T/UiZ9nkTagdxZerxs0BQEX/7Nq0gYfuAb/5I+I
        B5qn1ThdVDlRD/SdgLSYA/Dn8NFcFIKnAQ==
X-Google-Smtp-Source: ABdhPJzcEH2H2XjHXP00X5BUtngMTgHL+nYW3C30pFooI75WFNnK+95fsnKLxceRoEnELij7z7wKwg==
X-Received: by 2002:a05:6402:1547:: with SMTP id p7mr4158138edx.319.1619768683146;
        Fri, 30 Apr 2021 00:44:43 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id ga31sm1398146ejc.10.2021.04.30.00.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 23/43] staging: rtl8723bs: remove commented out BTC_PRINT logs
Date:   Fri, 30 Apr 2021 09:43:41 +0200
Message-Id: <58d9c623560e7ce7f3f27f2aa254de0ff7eb9011.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

