Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA88636F698
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhD3Hq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhD3Hpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE7C061349
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w3so103869754ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/6eqAh69XdAy4D/6jUl8yPTLxQZjwsVtZ88PaKHFNA=;
        b=B8kzCg+5GlLaZdVZAG/Tsdv04+g1GXDsIn2zkyA1SUiplSvlL3fnm12E5xOw6/1HZv
         ukMdIXOZhAytliPXr9Ph6QPkOYhaiVDMpLiBev9wN80tr2wGc8qVFc3gkre9aqFg/voF
         nfwXsdcg2e5sb/ruHX4SbQqElsuie1nEGkxDmn0Xm1q4JHk0EahlQ1r/AGr8MAR9fLG6
         wlnwWANbp79Bq8pWpOIcoeHmz2OKfHT29GKz6zGiIIiYjmkkI3EEMqfirJ+J7Vpe3A+8
         P9MpeviGMN+zYZKysgTw0xCWJwar9ek+F8VwBOFjYJ1U3WbjLeqmFB5e+ErzL+6MDQIt
         PrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/6eqAh69XdAy4D/6jUl8yPTLxQZjwsVtZ88PaKHFNA=;
        b=iEO53V8bpMEXHdRSOTmyPRV20uKG1goLkFc1mhTCupF4E3n+ZWhdD7lrDhTzOX30Qg
         N+sPaZq5FuEdJyuiv/jpf37E72kNFar0fli2Vj98EolPH+H5h1zpCqNtkkujL8Gi251o
         wxM8/jXKcjCxyJHBFwN1STUtmNhSwctcRkn6W7weG3WqOCL6+tmO7yJTp/c0mEHQbzYc
         LPOGvY4D22jBsRpRU6wtLF6fov2PVcytOhRJuRxggtBP73JmNVeX6c8UFXu7zu+xxSFi
         myd7xqdPxidcY37fVBsI70+BIdAr0YbZ00mGUJN6PemG6ZJDY8AlEVGrFsZ9ZilcpJHs
         ISqA==
X-Gm-Message-State: AOAM530uRl4lU0+4rzwK5PXodmc/0Fn4/bKpNG9ql7lYXO1Jt161S+e8
        Adqeh/Z8ey/g7CQo7L4g6bf20XK3AQd9eA==
X-Google-Smtp-Source: ABdhPJyY5BYYIBGH5J4waA1CKgMOEsIWTPQCzC/gF66gjN0+u20W18fgKdhhU6JKh48GeueOHWvtQw==
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr2857998ejb.175.1619768686734;
        Fri, 30 Apr 2021 00:44:46 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id lg20sm1470959ejb.13.2021.04.30.00.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 25/43] staging: rtl8723bs: remove BTC_PRINT_ADDR macro definitions
Date:   Fri, 30 Apr 2021 09:43:43 +0200
Message-Id: <f9b00f075bc285c9243084e801124c660d7d42b0.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused BTC_PRINT_ADDR macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index ad19ffc2de57..00705305305b 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -114,19 +114,6 @@ extern u32 		GLBtcDbgType[];
 
 /*  The following is for dbgview print */
 #if DBG
-#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr)\
-{\
-	if (GLBtcDbgType[dbgtype] & dbgflag) {\
-		int __i;\
-		u8 *ptr = (u8 *)_Ptr;\
-		DbgPrint printstr;\
-		DbgPrint(" ");\
-		for (__i = 0; __i < 6; __i++)\
-			DbgPrint("%02X%s", ptr[__i], (__i == 5) ? "" : "-");\
-		DbgPrint("\n");\
-	} \
-}
-
 #define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen)\
 {\
 	if (GLBtcDbgType[dbgtype] & dbgflag) {\
@@ -144,7 +131,6 @@ extern u32 		GLBtcDbgType[];
 
 #else
 #define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
-#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) no_printk printstr
 #define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen) \
 			no_printk("%s %p %zu", _TitleString, _HexData, _HexDataLen)
 #endif
-- 
2.20.1

