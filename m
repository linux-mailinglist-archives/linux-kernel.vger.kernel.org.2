Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90836F69F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhD3Hqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhD3Hpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D29C061350
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h10so81487184edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qqo23BBWvfRPpInFMgEIGt2hEIbFItq/UvhQi520Ig0=;
        b=NoNixB7h8rbBKmtlBAFwLvaFyGWzB12+PBKrLGSLHT2uqv1AsuNNPKUz45hpaq255f
         vCX9iaMFpmZHOgWg5D9EBeTNy/ezMAETw4WI4ifYwiOI0jHFSy9nLnZwIb5FEB0lX9Wv
         u1J3XzFeVzAYF/psPRth2dqAzm+stNSRsud8xBdq4wa5K70EjX+PEJsUqb0QfqJN7UEe
         EDav7KdIJkOKJK1yDiJN6HOwK46ShHCRtgwvj3Hrk+DB4Rn72FlqN5WoUC7aNPKFPnog
         7mIwLZItknE82UqVWrXjHhoO0VgY1NaufzurX3wbvv5ZNrLRrQ1yOKetXuPwfJYmlAUo
         3C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qqo23BBWvfRPpInFMgEIGt2hEIbFItq/UvhQi520Ig0=;
        b=uKMlCsqCBiN9OdCC6Y6UbtetpabvMZ8t7WJGDQ1DIm8f9gf6XQaYJEub7LHcTTA4BS
         1EPfbLjWTI9bMXHr1RqIQe/yl61bljQ8JuPeGcE4LgJmQQE8prIJ8hdQ5loKgR4KI4nq
         v0a10WUggCeCBvOT4vfF4XfF77hUbHShiDWw8bvyLriAgvoew4CqyaPc8Gq8x7cNl7ei
         L6dPaLQ3iZ8P3ww064IyZbwNaXP8OKTzv9VAJqjjAMW1UP3iQ4zlbmYOjlxeJZuhx1oq
         nCbMB/Tm304GSsjuqY4RbhZsX5b7PJs+BLmQ8H9n1Abjkoy9ZUF/C7YFcVBioxHYEtDj
         8Nfg==
X-Gm-Message-State: AOAM531hOsFqXvuE+yI4A5sP1qQPLJ2jae/xjgxjzFlpjqU27i+D6fCT
        B2mLhqZ6s8c132zc+moxPq4FaUw5NT948w==
X-Google-Smtp-Source: ABdhPJxu+HwmwUz/bw+qUvb9XW567odI8/YFDphYo6AXJDZchlE9JTHfGRTarQuCVgnLRmRML7EAog==
X-Received: by 2002:aa7:d658:: with SMTP id v24mr4081055edr.290.1619768697071;
        Fri, 30 Apr 2021 00:44:57 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id l1sm649452edt.59.2021.04.30.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 31/43] staging: rtl8723bs: remove unnecessary halbtcoutsrc_DbgInit() function
Date:   Fri, 30 Apr 2021 09:43:49 +0200
Message-Id: <81c0b2654dbca9356217ff5e1f4a2e2ec929e918.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

