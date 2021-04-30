Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16D36FCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhD3Oqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhD3Ops (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D2C061353
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i24so23351117edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/6eqAh69XdAy4D/6jUl8yPTLxQZjwsVtZ88PaKHFNA=;
        b=N35EmrJNUsZwYYKgXtBaGHeKRTkiUlExepJegpP98xvqGp5EABW5j5W615MkDcRax6
         oRsxgOfWiM4CmXxNn5fYDDq7C3j3TohQ5W+OQRKNTTJfi4rC6UTmlZL94aaRaswupuQT
         65O33CKOh7orkv+2CQTeQ3CsbvoLDav2R07tE2/7Mo69WLIxwJxClay/YKlv7F5BDV6P
         8Mf//N6FxghUPvb/uhcH6SX4GFk8Za8RNUn5OJ9m3QiLaGu2ulgnUxIYyhjvGs2b5kie
         iKkWaY6SWeXa4eVKTjB73ILuzEOgAnh+r09gazqE15BR8q/ly6hQFkgyAse/jiJgWdvv
         WANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/6eqAh69XdAy4D/6jUl8yPTLxQZjwsVtZ88PaKHFNA=;
        b=aEML6/S/I7H/nIQRAIk85J5vidIuqMRKr+jIedaFgqNeLSYk00iIMd9hvUa9UVwwC7
         V5BPVCuyw7WQjL8cEOtUo97Dds9xlkgzWLYBvh+g8STSzmdSRpIGnNZ3UONXj5IdaAT0
         3zEPPk9TzI+NM1uklsyeWLO0XJ8Bq5xbAajTOPbEzTwquMwWmY/jL+pqXDrHbRjdRVhL
         KihMTyNCjTmcTsDYVri18DUI4V52fMr7MAxTkUWBNbRhue9r9Y6ukbYoZock2g/OKdiY
         svKZuZ0LFw1420h2nhUe4bQammOtWkroiShcwYJCrmc6w9SvZ10YomWYbx0qHdbZbQIR
         WG+g==
X-Gm-Message-State: AOAM533gdyaolSoLlO3CuNwcB3s+Vjv3CYS+sXzKCurUDEMlUMrYMJoW
        I0keeRNLycz23kJUFVj7nkt+UkON3do=
X-Google-Smtp-Source: ABdhPJyLDt8GcL4l0CpVN8FTXBKy9hdMBUfmM8O/yrKBfvP0NhuFPfp8u7pele/L540lx1HDnEsUTw==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr6555692edu.57.1619793892179;
        Fri, 30 Apr 2021 07:44:52 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id z22sm1628440edm.57.2021.04.30.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/43] staging: rtl8723bs: remove BTC_PRINT_ADDR macro definitions
Date:   Fri, 30 Apr 2021 16:43:55 +0200
Message-Id: <1d260281e35713a70599618ab15fdebbfe10dda5.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

