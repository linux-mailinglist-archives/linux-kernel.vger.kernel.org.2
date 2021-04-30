Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47436FD18
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhD3O7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhD3O6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C022EC061353
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so82888398edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qqo23BBWvfRPpInFMgEIGt2hEIbFItq/UvhQi520Ig0=;
        b=bEFoYlV5qUOrrZDVcr+u2KYvrk1xBHOWEDyDd1OXlq4s8fOVy70wa2DCTDoYGItFSb
         u3Fg5UHyOIopUdDxAxio5D84epg2FYpXEChNQsnJzCaYxy47u1FxW6JR7Ij45kOh6i54
         ASsy1ww4s6VVw9DJUmdUQdmAhsrvEUR2byt25kmtJ+VNl/5mL05S/L0nmPJIpR6cxBcX
         uj4+HrtNQAA8hp4tGHBakT4GckImDSEqAZAs6Rq/6smmG1AfHr0lnlFG4pvMwXTfA869
         nNTeIicFsxzmyFWCIoMDgH9XzvhFFO5yfe3lXQGFXIsnVZ4YBUcqw7aUKguaypTDE7QQ
         ZVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qqo23BBWvfRPpInFMgEIGt2hEIbFItq/UvhQi520Ig0=;
        b=FNKGdpYo39Kr28pH68FD3c1XpSmqSw1mPlcUDwgkMcbwYFhfDnGx4baaTUFgWKes2a
         EXSW58BR/uLosh3V4Cbk15v3iyjRn8aBv/KTv/NqAPVrYArbqlVYigja4OMCxVrK23SH
         rxPvtASLFPGY7V9O5WzCmL0Gtm3W4hafz4U0radF97qAmWEhCbPXBBe79qwMMTo942pW
         xA99l585ms351WCs+OSCvehQiiUVaGeygnmqFg8Y6dIeEgsS8LgyOrNUN6JYR4/uH/nO
         m8BqwU91ln6wK5DEO/nyWhDAxiU9GJjHuG/+GgWyOsKNd1Me0jALvxl9ZpSZlc+U1jvd
         x1fw==
X-Gm-Message-State: AOAM5336i6aACMwkxwxptfhbIyIdgw3o4Esl732YG8pHDsRA9sCDy1O5
        pUz/fx9g0V3in5icUGfi6x6qEVm2I4E=
X-Google-Smtp-Source: ABdhPJyZ3/fKJXkKZJJciCr1lDVRQlLB3eF9m8aFqNbS5eQ3Q7bdM3bKvo540QnvHp4zrcoZGF53Yw==
X-Received: by 2002:a05:6402:cb4:: with SMTP id cn20mr6284134edb.167.1619794678372;
        Fri, 30 Apr 2021 07:57:58 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id ga33sm2027943ejc.11.2021.04.30.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 31/43] staging: rtl8723bs: remove unnecessary halbtcoutsrc_DbgInit() function
Date:   Fri, 30 Apr 2021 16:56:53 +0200
Message-Id: <f6c4f680b2d0ee8850f97532ca76dd405c1d50c3.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

halbtcoutsrc_DbgInit() static function was intended for
manual activation of private tracing facilities.

So remove it.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 28 ----------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 02d9997094f2..fd26187a976a 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -75,32 +75,6 @@ static u8 halbtcoutsrc_IsBtCoexistAvailable(struct btc_coexist *pBtCoexist)
 	return true;
 }
 
-static void halbtcoutsrc_DbgInit(void)
-{
-	u8 i;
-
-	for (i = 0; i < BTC_MSG_MAX; i++)
-		GLBtcDbgType[i] = 0;
-
-	GLBtcDbgType[BTC_MSG_INTERFACE]			=	\
-/* 			INTF_INIT								| */
-/* 			INTF_NOTIFY							| */
-			0;
-
-	GLBtcDbgType[BTC_MSG_ALGORITHM]			=	\
-/* 			ALGO_BT_RSSI_STATE					| */
-/* 			ALGO_WIFI_RSSI_STATE					| */
-/* 			ALGO_BT_MONITOR						| */
-/* 			ALGO_TRACE							| */
-/* 			ALGO_TRACE_FW						| */
-/* 			ALGO_TRACE_FW_DETAIL				| */
-/* 			ALGO_TRACE_FW_EXEC					| */
-/* 			ALGO_TRACE_SW						| */
-/* 			ALGO_TRACE_SW_DETAIL				| */
-/* 			ALGO_TRACE_SW_EXEC					| */
-			0;
-}
-
 static void halbtcoutsrc_LeaveLps(struct btc_coexist *pBtCoexist)
 {
 	struct adapter *padapter;
@@ -919,8 +893,6 @@ void hal_btcoex_Initialize(void *padapter)
 
 	/* pBtCoexist->statistics.cntBind++; */
 
-	halbtcoutsrc_DbgInit();
-
 	pBtCoexist->chipInterface = BTC_INTF_SDIO;
 
 	EXhalbtcoutsrc_BindBtCoexWithAdapter(padapter);
-- 
2.20.1

