Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A675637AD26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEKRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:36:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D15C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:34:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h16so3832679pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8TzPphX9fli4xVAxW0kVe0k/sUt3bHTl0oZV5LGdFX0=;
        b=o8TcyGBuu/xqN9CD1W7SIKgpPvSiUZNKNqgzpKJ0cISTFNmxWSoLxyKVCyb+rgKM97
         Z3JYm5RZRWqtPs6Xy7MYQTp7cVdm6I143KeuQsFcoLaJWoUqvVViGS9qrwUyrUVRJzNR
         xx36APXiFD9FwbLsPqOEfhbFVQ0K1in3CO3IC1kX6Kr1FGL8GdfOPOaab577Aoqqsu2g
         ZkfB+NwwuvKv5vZfFwbdBWiRoj4PzS6R1wk1FLLS76CucXmFRY8+amzoADEojfExMxYf
         KWcXq49m2e7JWsDJtBbw6zy5cxAjs4/ft+jMmXaGNhOz371bsZaHWvUf7iOIebqtPnBn
         NAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8TzPphX9fli4xVAxW0kVe0k/sUt3bHTl0oZV5LGdFX0=;
        b=RmLRiCGbuHpYP6CgzpmjylZ4IU9YhaFH2ejA2usVZbJ4IW/C89nq+9j0FDdF7ny7nP
         65TBeK5KyQRw4ORpPtFeAqJ47nd4Bp67sqv4b6RS0irp8VuGsLqTwy7QpB4HFJGLCYB3
         AbchmkFlvrh9Bl6VquTatujsZrCYrxVBK9PpbE0g5BmIIE8AHrgz4Kg9pGrG4/zxlxlz
         9TfqLua5xUS+Z1aBAA9iMg2jV6IRRnUjZUHgtCU8CP2PZu2zs4Eah2UhJeBUNCw0O7i0
         p+Iv1OJTO/tPQN19XF3Jj8PdhB9ulPhXtKI536R8eNdLn4h/aLE/lQCGAmmzaXYhxpYR
         gblQ==
X-Gm-Message-State: AOAM531E8ZxMzRtCuMFcy/HENm4KImrYSEHgml/oW9avG+Yhst+n3JOl
        SKlvpYi+kCLvqv919PVC0jiKcKli/tbnwg==
X-Google-Smtp-Source: ABdhPJzUCtFgYMAmOanPYQGRfeTG8Fn0oSql+0cTgCk4RK2JBHfePXHdWaWq9gABUVwe1E+1ycWtoQ==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr31580737pgh.21.1620754493912;
        Tue, 11 May 2021 10:34:53 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id v22sm14007943pff.105.2021.05.11.10.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 10:34:53 -0700 (PDT)
Date:   Wed, 12 May 2021 02:34:48 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     vbabka@suse.cz, akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        42.hyeyoo@gmail.com
Subject: [PATCH v3] mm, slub: change run-time assertion in kmalloc_index() to
 compile-time
Message-ID: <20210511173448.GA54466@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently when size is not supported by kmalloc_index, compiler will
generate a run-time BUG() while compile-time error is also possible,
and better. so changed BUG to BUILD_BUG_ON_MSG to make compile-time
check possible.

also removed code that allocates more than 32MB because current
implementation supports only up to 32MB.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 7 +++++--
 mm/slab_common.c     | 7 +++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6d454886bcaf..df1937309df2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -345,6 +345,9 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
  * 1 =  65 .. 96 bytes
  * 2 = 129 .. 192 bytes
  * n = 2^(n-1)+1 .. 2^n
+ *
+ * Note: there's no need to optimize kmalloc_index because it's evaluated
+ * in compile-time.
  */
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
@@ -381,8 +384,8 @@ static __always_inline unsigned int kmalloc_index(size_t size)
 	if (size <=  8 * 1024 * 1024) return 23;
 	if (size <=  16 * 1024 * 1024) return 24;
 	if (size <=  32 * 1024 * 1024) return 25;
-	if (size <=  64 * 1024 * 1024) return 26;
-	BUG();
+
+	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
 
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index fe8b68482670..97664bbe8147 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1192,8 +1192,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
- * kmalloc_index() supports up to 2^26=64MB, so the final entry of the table is
- * kmalloc-67108864.
+ * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
+ * kmalloc-32M.
  */
 const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(0, 0),
@@ -1221,8 +1221,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(4194304, 4M),
 	INIT_KMALLOC_INFO(8388608, 8M),
 	INIT_KMALLOC_INFO(16777216, 16M),
-	INIT_KMALLOC_INFO(33554432, 32M),
-	INIT_KMALLOC_INFO(67108864, 64M)
+	INIT_KMALLOC_INFO(33554432, 32M)
 };
 
 /*
-- 
2.25.1

