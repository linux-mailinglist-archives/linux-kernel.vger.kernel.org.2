Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D22332710
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCINZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhCINYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:24:54 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:24:54 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id y5so6427307wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uDCq4UxGr+f+5TaIXWTYNeAihwfp2JNx0hDszCVrvYs=;
        b=LKXhZ/r7rmTbldAC2vl6SdFpNXfRUmS1JWRbKYrTFAg+m8728B8Fx9vqtDhq99uJab
         RF7C5bQ7DI8VintuaoOVWnarc6IajiF4aTT2zaq5EezjNnQZhxg8bHslGWsADoYjK1le
         EdJaOBPvDRA7OqHtuVaPjcuuapGDhCkWU6JrNyHCzJKfRgky8yoX3iqX79SHbmxTjYV/
         Awb1dlryP1PMgXBJgZdZc9fV9qnOsNL2Jl1PdsB2oQlfhzikiLUZrQ0pt0nPxbYTfrXm
         j70avRHqQIZeFg/2NP9rRCldJgrix91Qmh/tXvA4C02Ac0mkPnI1LrCu9DX9A7qqoo24
         emEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uDCq4UxGr+f+5TaIXWTYNeAihwfp2JNx0hDszCVrvYs=;
        b=TYDjou7XsOF0sOZb6OU9AhQOe8qTgv9c0Kqq8Qp5uQiATByDzBJJzXkv7YXexPiL4k
         wYH0btaVYdlaDHeMBqOPDwfvDqeOsDg0K0VKer47CQyam1Yq/5wSNF7U/xI4ZgYPhQ47
         sB/PGzferEyHJ5gLIRkZOtszqiVo1rb90jjXlsYd7pq0nfG1qB0NtB5kkImpcTyvsm6g
         1VHNC89HpnKOA2tQ4cpVS/U2C+LaIo4oBZB4px7UU4Z4BbVinu8K1ARVOexgxc9gz9NQ
         HymHpWXJNhKtFmRvxSzGkugbisNwfB/mIZeaXYj7fZWvNmqBuJm/cap4As6XCr/G8Fai
         HbkA==
X-Gm-Message-State: AOAM531rC84wVdwIDMj9ZwoJxtLi3IdVna0mWdLoxFRw54FskwIiJEZV
        cw90zxrfTMGm/Ybb5nEp78wnGavQQVGbGgoq
X-Google-Smtp-Source: ABdhPJwjAW9KlQkC3HMxRtxaXhk+o2uTKjE7kkdHtW43P31u9/x2JrL0EmVi5+TsDQ4HpjUK1mgwoGDR79/y0rJC
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:5802:818:ce92:dfef])
 (user=andreyknvl job=sendgmr) by 2002:adf:bc01:: with SMTP id
 s1mr28458737wrg.240.1615296292758; Tue, 09 Mar 2021 05:24:52 -0800 (PST)
Date:   Tue,  9 Mar 2021 14:24:38 +0100
In-Reply-To: <cover.1615296150.git.andreyknvl@google.com>
Message-Id: <c1292aeb5d519da221ec74a0684a949b027d7720.1615296150.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1615296150.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 4/5] kasan, mm: integrate slab init_on_alloc with HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses the previously added memory initialization feature
of HW_TAGS KASAN routines for slab memory when init_on_alloc is enabled.

With this change, memory initialization memset() is no longer called
when both HW_TAGS KASAN and init_on_alloc are enabled. Instead, memory
is initialized in KASAN runtime.

The memory initialization memset() is moved into slab_post_alloc_hook()
that currently directly follows the initialization loop. A new argument
is added to slab_post_alloc_hook() that indicates whether to initialize
the memory or not.

To avoid discrepancies with which memory gets initialized that can be
caused by future changes, both KASAN hook and initialization memset()
are put together and a warning comment is added.

Combining setting allocation tags with memory initialization improves
HW_TAGS KASAN performance when init_on_alloc is enabled.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  8 ++++----
 mm/kasan/common.c     |  4 ++--
 mm/slab.c             | 28 +++++++++++++---------------
 mm/slab.h             | 17 +++++++++++++----
 mm/slub.c             | 27 +++++++++++----------------
 5 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index c89613caa8cf..85f2a8786606 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -226,12 +226,12 @@ static __always_inline void kasan_slab_free_mempool(void *ptr)
 }
 
 void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
-				       void *object, gfp_t flags);
+				       void *object, gfp_t flags, bool init);
 static __always_inline void * __must_check kasan_slab_alloc(
-				struct kmem_cache *s, void *object, gfp_t flags)
+		struct kmem_cache *s, void *object, gfp_t flags, bool init)
 {
 	if (kasan_enabled())
-		return __kasan_slab_alloc(s, object, flags);
+		return __kasan_slab_alloc(s, object, flags, init);
 	return object;
 }
 
@@ -320,7 +320,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
 static inline void kasan_kfree_large(void *ptr) {}
 static inline void kasan_slab_free_mempool(void *ptr) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
-				   gfp_t flags)
+				   gfp_t flags, bool init)
 {
 	return object;
 }
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6107c795611f..7ea747b18c26 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -428,7 +428,7 @@ static void set_alloc_info(struct kmem_cache *cache, void *object,
 }
 
 void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
-					void *object, gfp_t flags)
+					void *object, gfp_t flags, bool init)
 {
 	u8 tag;
 	void *tagged_object;
@@ -453,7 +453,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	 * Unpoison the whole object.
 	 * For kmalloc() allocations, kasan_kmalloc() will do precise poisoning.
 	 */
-	kasan_unpoison(tagged_object, cache->object_size, false);
+	kasan_unpoison(tagged_object, cache->object_size, init);
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
 	if (kasan_stack_collection_enabled())
diff --git a/mm/slab.c b/mm/slab.c
index 51fd424e0d6d..936dd686dec9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3216,6 +3216,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 	void *ptr;
 	int slab_node = numa_mem_id();
 	struct obj_cgroup *objcg = NULL;
+	bool init = false;
 
 	flags &= gfp_allowed_mask;
 	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
@@ -3254,12 +3255,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
   out:
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
-
-	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
-		memset(ptr, 0, cachep->object_size);
+	init = slab_want_init_on_alloc(flags, cachep);
 
 out_hooks:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
 	return ptr;
 }
 
@@ -3301,6 +3300,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
 	unsigned long save_flags;
 	void *objp;
 	struct obj_cgroup *objcg = NULL;
+	bool init = false;
 
 	flags &= gfp_allowed_mask;
 	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
@@ -3317,12 +3317,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
-
-	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
-		memset(objp, 0, cachep->object_size);
+	init = slab_want_init_on_alloc(flags, cachep);
 
 out:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
 	return objp;
 }
 
@@ -3542,18 +3540,18 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 
 	cache_alloc_debugcheck_after_bulk(s, flags, size, p, _RET_IP_);
 
-	/* Clear memory outside IRQ disabled section */
-	if (unlikely(slab_want_init_on_alloc(flags, s)))
-		for (i = 0; i < size; i++)
-			memset(p[i], 0, s->object_size);
-
-	slab_post_alloc_hook(s, objcg, flags, size, p);
+	/*
+	 * memcg and kmem_cache debug support and memory initialization.
+	 * Done outside of the IRQ disabled section.
+	 */
+	slab_post_alloc_hook(s, objcg, flags, size, p,
+				slab_want_init_on_alloc(flags, s));
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
 	return size;
 error:
 	local_irq_enable();
 	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
-	slab_post_alloc_hook(s, objcg, flags, i, p);
+	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
diff --git a/mm/slab.h b/mm/slab.h
index 076582f58f68..c6f0e55a674a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -506,15 +506,24 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 }
 
 static inline void slab_post_alloc_hook(struct kmem_cache *s,
-					struct obj_cgroup *objcg,
-					gfp_t flags, size_t size, void **p)
+					struct obj_cgroup *objcg, gfp_t flags,
+					size_t size, void **p, bool init)
 {
 	size_t i;
 
 	flags &= gfp_allowed_mask;
+
+	/*
+	 * As memory initialization might be integrated into KASAN,
+	 * kasan_slab_alloc and initialization memset must be
+	 * kept together to avoid discrepancies in behavior.
+	 *
+	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
+	 */
 	for (i = 0; i < size; i++) {
-		p[i] = kasan_slab_alloc(s, p[i], flags);
-		/* As p[i] might get tagged, call kmemleak hook after KASAN. */
+		p[i] = kasan_slab_alloc(s, p[i], flags, init);
+		if (p[i] && init && !kasan_has_integrated_init())
+			memset(p[i], 0, s->object_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
 	}
diff --git a/mm/slub.c b/mm/slub.c
index e26c274b4657..f53df23760e3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2822,6 +2822,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	struct page *page;
 	unsigned long tid;
 	struct obj_cgroup *objcg = NULL;
+	bool init = false;
 
 	s = slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
 	if (!s)
@@ -2899,12 +2900,10 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	}
 
 	maybe_wipe_obj_freeptr(s, object);
-
-	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
-		memset(kasan_reset_tag(object), 0, s->object_size);
+	init = slab_want_init_on_alloc(gfpflags, s);
 
 out:
-	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
+	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
 
 	return object;
 }
@@ -3356,20 +3355,16 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	c->tid = next_tid(c->tid);
 	local_irq_enable();
 
-	/* Clear memory outside IRQ disabled fastpath loop */
-	if (unlikely(slab_want_init_on_alloc(flags, s))) {
-		int j;
-
-		for (j = 0; j < i; j++)
-			memset(kasan_reset_tag(p[j]), 0, s->object_size);
-	}
-
-	/* memcg and kmem_cache debug support */
-	slab_post_alloc_hook(s, objcg, flags, size, p);
+	/*
+	 * memcg and kmem_cache debug support and memory initialization.
+	 * Done outside of the IRQ disabled fastpath loop.
+	 */
+	slab_post_alloc_hook(s, objcg, flags, size, p,
+				slab_want_init_on_alloc(flags, s));
 	return i;
 error:
 	local_irq_enable();
-	slab_post_alloc_hook(s, objcg, flags, i, p);
+	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
@@ -3579,7 +3574,7 @@ static void early_kmem_cache_node_alloc(int node)
 	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
 	init_tracking(kmem_cache_node, n);
 #endif
-	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL);
+	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
 	page->freelist = get_freepointer(kmem_cache_node, n);
 	page->inuse = 1;
 	page->frozen = 0;
-- 
2.30.1.766.gb4fecdf3b7-goog

