Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B311E379257
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhEJPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:17:56 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:56114 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241634AbhEJPQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:16:30 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 61FC4B005CE; Mon, 10 May 2021 17:15:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 608DCB002EA;
        Mon, 10 May 2021 17:15:23 +0200 (CEST)
Date:   Mon, 10 May 2021 17:15:23 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
In-Reply-To: <20210510150230.GA74915@hyeyoo>
Message-ID: <alpine.DEB.2.22.394.2105101714170.749526@gentwo.de>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com> <YJccjBMBiwLqFrB8@casper.infradead.org> <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com> <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz> <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz> <20210510150230.GA74915@hyeyoo>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY=HlL+5n6rz5pIUxbD
Content-ID: <alpine.DEB.2.22.394.2105101714171.749526@gentwo.de>
Content-Disposition: INLINE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.22.394.2105101714172.749526@gentwo.de>
Content-Disposition: INLINE

I guess this needs to be reviewed and tested by the users of architectures
that can use large MAXORDER pages such as powerpc and Itanium.

On Tue, 11 May 2021, Hyeonggon Yoo wrote:

> updated patch. let me know if something is wrong!
>
--HlL+5n6rz5pIUxbD
Content-Type: text/x-diff; CHARSET=us-ascii
Content-ID: <alpine.DEB.2.22.394.2105101714173.749526@gentwo.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=0001-mm-kmalloc_index-make-compiler-break-when-size-is-no.patch

>From 8fe7ecdfb0f5bd5b08771512303d72f1c6447362 Mon Sep 17 00:00:00 2001
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
