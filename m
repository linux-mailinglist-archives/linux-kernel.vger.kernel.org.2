Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF1379D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhEKDBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEKDA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:00:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB8DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 19:59:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s20so10100217plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSJUUz/f4tLbua2BU6pbEJOw8M2Tk15/Iao3DwjhR3M=;
        b=NBm9MvSthgsH3p1QPhZiv8ZyGUJ2hJK1wOu7fHnwpCfIJ3213hxEWmYNe2DLxpac94
         A8WPX/Ekoh6FiHJz/wWXoQ+UguDT0FPxYjBocobFrnaZKWO1IisrLbtU8l2Iams6idy8
         xfJGGo24Il6Yv/SRmYZ/NRN7irli9FSvzTKxYtfFZFvAupovGXlMlqosjFWZKweHAWFU
         k3DhacQ6nTMpV8dDSw6hB2FP+9jjP0eRhiMVzIMFYw6DokLVoadybe+oeI0Fs6ntHJyh
         g9rr0RrWU9vPx3Ksn4EuBKBo5cgf8hRselzAZMHWuEuCwRtf5fM8NF4zmcEiP7psiw1+
         aXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSJUUz/f4tLbua2BU6pbEJOw8M2Tk15/Iao3DwjhR3M=;
        b=glKI0d+J+ilOMy3wR7P0SFUgmBzuwSQZ6xUZNtx9zakgyUiUaj+1yl+v5MkfXvFIVn
         8+OMNma+15PsgvVoX82RUWZ4c5yhQ81GSpAezl+F5ERULT0exf08gPZm/+QH0TGriAc3
         HMxckM5OaCAXByTZC0+TXqsAzEr0Uy0Z8EnsFrWeD0IC8+Qhi1RSUnwl9UVozUFcikVw
         zbNeMQbXkPlVjs+zOmQ2SIvMuwwbrumpJv41sYe/ndscabJ2BY4BJ3PfHNXfAiBfxm3g
         EFztmrcJEAn3hrswwVIpLAMpOzchoe+hRBJej8v16K6hH/jg6b/lUqupumlP0+WU4RQ+
         yDGw==
X-Gm-Message-State: AOAM533/E1pt6JUfRj9rPOIdp+hMCWv6oROrxZFsd2X1NPys0tICuKNK
        6wimVrn2BtcBbD3Ar8ucZBM=
X-Google-Smtp-Source: ABdhPJxqEe604ctRXMNgtR96MG4nb+LP029JD7OzOHFnTeNsp0Xl/1M1BX2JpsYEujKKuQxtu/WaDQ==
X-Received: by 2002:a17:90a:7a85:: with SMTP id q5mr2513894pjf.49.1620701991901;
        Mon, 10 May 2021 19:59:51 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id 132sm12441756pfw.38.2021.05.10.19.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:59:51 -0700 (PDT)
Date:   Tue, 11 May 2021 11:59:46 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: change run-time assertion in kmalloc_index() to
 compile-time
Message-ID: <20210511025946.GA98904@hyeyoo>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
 <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
 <90591d7e-41e4-9ae5-54ae-ded467c498cf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90591d7e-41e4-9ae5-54ae-ded467c498cf@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From c2b8fc4144f2c44b0ac5957a06207c385cc94d15 Mon Sep 17 00:00:00 2001
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 11 May 2021 11:53:23 +0900
Subject: [PATCH] mm, slub: change run-time assertion in kmalloc_index() to
 compile-time

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

