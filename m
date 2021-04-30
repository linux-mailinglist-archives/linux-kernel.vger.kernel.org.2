Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0119536FD12
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhD3O7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhD3O6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B7C06134B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id di13so725127edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/6eqAh69XdAy4D/6jUl8yPTLxQZjwsVtZ88PaKHFNA=;
        b=jkwe0a9qQTg7k85Rlf+D2O/4MhuWnmhToVspBzxeJb09vmXa/5QQ68q8nI/OwhygtJ
         Nh2diNlPv/WjMndnyryJtoGQdZg8BFLrlwYKZpNlI2Imy6tYbezjJabBIfA97EfhZIoe
         IqNGgq0pL3l3D2qvGS/yWowEHEacivQ96EGtej8N28OBi/93MTtqPudBAcYo15SqLlyV
         JbO8rdjB2hNQB7XnmyUsWeKjOh1RDsPr4G6rt//8ZVWaQ4kB9B2cJ/t3orbxoRFSX+ms
         F5d2zv5IZAtyWZxSJMiAoWm2bv2MNJChj1OQoOTIz67K48y6l31z9SBQUHDTClFoG2VE
         OOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/6eqAh69XdAy4D/6jUl8yPTLxQZjwsVtZ88PaKHFNA=;
        b=gepQujeELICJY1KOmAkUP7b9PiIHZg+1YX6nXLuKmM8AoJaRqJ/lDbukrKYUmsqoR8
         qFqyS/uPvHYDwyNwGxrlI3w1tPg/OHm+DrpHkyuVzMmynzLMqCoxHm6j9bd8OwfuOycH
         pSyr6OMpQ2GrjV77hdNCU6Q0XLrj6riajh8r2KI/BZ4A/uWk6J1kAQBCvNsDypUTpZnB
         oKPa1O8ujO1LgwPT5/cZMIxC+UNJcC2V9SZsf/PYjUx6pvap5or32GzolWpL5WZhWoQb
         aN4ibV1k9HUlGtF+KH9uUp/YsPrtzsudgRAe2jtPipZKvaeYVKuMLRR3VDUZpmChJbv8
         U8CA==
X-Gm-Message-State: AOAM533GJdAwgG2JnnITnkSdY7Bh95GTow/j8mCAojzjK3CEOcReEf1q
        es5J7RHrM5OPaSF2Was8ynofG9sIYrA=
X-Google-Smtp-Source: ABdhPJz9oARWD4kOpHtbyNBKJLisXjlNtoSQJ9KcxHi7TQvw09yg5wj0tDI2ukwjAkglGuDo3/KsHQ==
X-Received: by 2002:a05:6402:1013:: with SMTP id c19mr6491946edu.213.1619794668608;
        Fri, 30 Apr 2021 07:57:48 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id z4sm2112850ejf.23.2021.04.30.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 25/43] staging: rtl8723bs: remove BTC_PRINT_ADDR macro definitions
Date:   Fri, 30 Apr 2021 16:56:47 +0200
Message-Id: <31af3e56cfd52f2797499d3beb38741bddaff65d.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

