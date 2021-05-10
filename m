Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6746379295
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhEJPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhEJPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:24:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78887C07E5DD
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:02:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i14so13498842pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fO+jUmqEDUXSIis3oHW0Flx6cFL+pa0JnVYsPy9H5I=;
        b=bFZ2I95XqBU/PFzvrqyUF/2DiJ+BxRvWsCLG7v/9/rVTuulyQvEeMXOezUvG7Y9/2X
         AGuB+EkdZObLucVtZcxHn9jiRQvyoQ8ttoz7V3xzHJ1i+4RNu2Q2gLmdR9g8LX2d03CZ
         8tzzhdQCBdYMs3RoxPJHHXC0u5hoVUBoy94XivcekQvB8uOmlgXQEjsUB+i/VTBT6PCY
         sm4fPImkScmf8wPEWauw2AgHiMJe2pW9rSejFg5/jUEhEYvmt8l+gIjvszk2BAkUnrhE
         CDcHRDzsMayXf1u8YmpdW8HcA8xDTm/hq5zDmD2LJf36pwnJd6TZPVomR+zhZ6mEH3MJ
         +lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fO+jUmqEDUXSIis3oHW0Flx6cFL+pa0JnVYsPy9H5I=;
        b=M++MuS56EWUvxFD7QuhSfsCaiJDr4Q0qyPJk0+hxINZAbEc0GoI6iYN2HT5a7hOfd7
         5BugoarM3QRxa/Hio0VD9QnhVDkhInaj1Q1fM44AhRngE++231MiNxtWAk+PgKKbXjDf
         hX4SATfAdRQWyEbkt9M+xUV8zWqiiZK1w8S7j2G19LammB9OJzhWk6cEmYdNUq5R4UPU
         wCtJ8py3bDBghjXTMdqWV5P661BZgF3ttO6ruQqVuzDuWUoMroewONKU1A+f+0dk8Ah9
         MIMOhJAlw+8mnMxQmpcO5doWqcZIpZrJXDuUMnCqSPzAJSjiQysHMBmr1AtznbO8vqcu
         L6OA==
X-Gm-Message-State: AOAM532z4dQFiFoJ5iFInlJ6QJBYZq0/eaF3XaRcGX57oHKHO/H7f+KI
        4v2wELHjJxtN0rcz6j4q6MM=
X-Google-Smtp-Source: ABdhPJwkqw1ZCSxkz13/m97i+8H+bDz5Nn73JP5OO23EC+b2P1eYzE53Mns8FVUydAeWzWGOYiYlNw==
X-Received: by 2002:a63:4652:: with SMTP id v18mr26064909pgk.386.1620658956714;
        Mon, 10 May 2021 08:02:36 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id e27sm7600554pfm.144.2021.05.10.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:02:36 -0700 (PDT)
Date:   Tue, 11 May 2021 00:02:30 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        42.hyeyoo@gmail.com
Subject: [PATCH v2] mm: kmalloc_index: make compiler break when size is not
 supported
Message-ID: <20210510150230.GA74915@hyeyoo>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
 <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

updated patch. let me know if something is wrong!

--HlL+5n6rz5pIUxbD
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-kmalloc_index-make-compiler-break-when-size-is-no.patch"

From 8fe7ecdfb0f5bd5b08771512303d72f1c6447362 Mon Sep 17 00:00:00 2001
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Mon, 10 May 2021 23:57:34 +0900
Subject: [PATCH] mm: kmalloc_index: make compiler break when size is not
 supported

currently when size is not supported by kmalloc_index, compiler will not
break. so changed BUG to BUILD_BUG_ON_MSG to make compiler break if size is
wrong. this is done in compile time.

also removed code that allocates more than 32MB because current
implementation supports only up to 32MB.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 7 +++++--
 mm/slab_common.c     | 7 +++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0c97d788762c..fd0c7229d105 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -346,6 +346,9 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
  * 1 =  65 .. 96 bytes
  * 2 = 129 .. 192 bytes
  * n = 2^(n-1)+1 .. 2^n
+ *
+ * Note: you don't need to optimize kmalloc_index because it's evaluated
+ * in compile-time.
  */
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
@@ -382,8 +385,8 @@ static __always_inline unsigned int kmalloc_index(size_t size)
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
index f8833d3e5d47..39d4eca8cf9b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -745,8 +745,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
- * kmalloc_index() supports up to 2^26=64MB, so the final entry of the table is
- * kmalloc-67108864.
+ * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
+ * kmalloc-33554432.
  */
 const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(0, 0),
@@ -774,8 +774,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
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


--HlL+5n6rz5pIUxbD--
