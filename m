Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5833270E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhCINZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhCINYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:24:48 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57227C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:24:48 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 130so9985762qkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=juB8DGQdBNYffoVbxywhM+daO8QsN177ObTD+3lbjn4=;
        b=GuXS/wW0OuWW+f7PW1LT5G0RG2fXSr2icIoxDS29HpsCTYfgebX5PWcJ9jlp3tNRHN
         dR9dpV3ixmiE4UpQMOq1PyTtQ5zFC5Gb6S8iJRrHsImDa6M+mmF0rAAKmDq1CIGuxOSy
         Ae21LVK+Dg9LzJrEjThHd1+xX0FFB8B/9Y/NwmbqFy7E400Foot5OKaDKdflyMmrfrRf
         8+vmHBsA4spMewb1dO4qlzyaYVO2HBctt7d4shnv9im/CC/NTuRUBhF/ascLCo2gFTCK
         5UgpQLjO+Y+5SLKu6k3X3ChppHTT/K7AMAtnOTycQSdYmCQrQBrqPSxvdy7ZwyaPaGgV
         ZV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=juB8DGQdBNYffoVbxywhM+daO8QsN177ObTD+3lbjn4=;
        b=DSpxvb3Rpo2fMEvMhUg2yer0WTHWVEEkvoCzmBo4HyJISdTYauwcldV/qdFlIenVwu
         CR/zES7ZoO4N3LBTo6lZKMkoVoNFf/JW2dq9Ew6JIfPoRiVCvnVcClgn9viDmVqDnWRo
         NOH77o/fnxlpXHT72D3zyXwdclc2tU3ZXd6I7SRiYTTiGjIXBa0JQkQ2ttSWHrQ7hkn8
         Px4JORxhj2BKxSM1+SdWnt5M6JVxnbe/ujLeqo+Uba20GaEuQbFojT0KVM0uNa5hWozl
         I9TBWlKNfrWxjlhaiMlMyJ623lmqH2m64QUpLwNinyOK4eBxhq7JzRbJmLCu2npUzmmO
         i1qg==
X-Gm-Message-State: AOAM532jC4SwTwbMQGXcc39DHBLjiXTw6Kj7nxmDsvyKprYOtcL4Ays/
        GfH3FZqqRS6axyNimsdm7d2OylQyjAdOQ0C9
X-Google-Smtp-Source: ABdhPJxKeStguGdGG058801ZrWdwlYWiDvDjxt5I3CWbhmONL9FwJxCEbVtg2Hb3KvSYNPTE3baDbTdHrgTfeg6z
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:5802:818:ce92:dfef])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5851:: with SMTP id
 de17mr25461053qvb.6.1615296287502; Tue, 09 Mar 2021 05:24:47 -0800 (PST)
Date:   Tue,  9 Mar 2021 14:24:36 +0100
In-Reply-To: <cover.1615296150.git.andreyknvl@google.com>
Message-Id: <3054314039fa64510947e674180d675cab1b4c41.1615296150.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1615296150.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 2/5] kasan: init memory in kasan_(un)poison for HW_TAGS
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

This change adds an argument to kasan_poison() and kasan_unpoison()
that allows initializing memory along with setting the tags for HW_TAGS.

Combining setting allocation tags with memory initialization will
improve HW_TAGS KASAN performance when init_on_alloc/free is enabled.

This change doesn't integrate memory initialization with KASAN,
this is done is subsequent patches in this series.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c   |  4 ++--
 mm/kasan/common.c  | 28 ++++++++++++++--------------
 mm/kasan/generic.c | 12 ++++++------
 mm/kasan/kasan.h   | 14 ++++++++------
 mm/kasan/shadow.c  | 10 +++++-----
 mm/kasan/sw_tags.c |  2 +-
 6 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index e5647d147b35..d77c45edc7cd 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -1044,14 +1044,14 @@ static void match_all_mem_tag(struct kunit *test)
 			continue;
 
 		/* Mark the first memory granule with the chosen memory tag. */
-		kasan_poison(ptr, KASAN_GRANULE_SIZE, (u8)tag);
+		kasan_poison(ptr, KASAN_GRANULE_SIZE, (u8)tag, false);
 
 		/* This access must cause a KASAN report. */
 		KUNIT_EXPECT_KASAN_FAIL(test, *ptr = 0);
 	}
 
 	/* Recover the memory tag and free. */
-	kasan_poison(ptr, KASAN_GRANULE_SIZE, get_tag(ptr));
+	kasan_poison(ptr, KASAN_GRANULE_SIZE, get_tag(ptr), false);
 	kfree(ptr);
 }
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b5e08d4cefec..316f7f8cd8e6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -60,7 +60,7 @@ void kasan_disable_current(void)
 
 void __kasan_unpoison_range(const void *address, size_t size)
 {
-	kasan_unpoison(address, size);
+	kasan_unpoison(address, size, false);
 }
 
 #if CONFIG_KASAN_STACK
@@ -69,7 +69,7 @@ void kasan_unpoison_task_stack(struct task_struct *task)
 {
 	void *base = task_stack_page(task);
 
-	kasan_unpoison(base, THREAD_SIZE);
+	kasan_unpoison(base, THREAD_SIZE, false);
 }
 
 /* Unpoison the stack for the current task beyond a watermark sp value. */
@@ -82,7 +82,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 	 */
 	void *base = (void *)((unsigned long)watermark & ~(THREAD_SIZE - 1));
 
-	kasan_unpoison(base, watermark - base);
+	kasan_unpoison(base, watermark - base, false);
 }
 #endif /* CONFIG_KASAN_STACK */
 
@@ -108,14 +108,14 @@ void __kasan_alloc_pages(struct page *page, unsigned int order)
 	tag = kasan_random_tag();
 	for (i = 0; i < (1 << order); i++)
 		page_kasan_tag_set(page + i, tag);
-	kasan_unpoison(page_address(page), PAGE_SIZE << order);
+	kasan_unpoison(page_address(page), PAGE_SIZE << order, false);
 }
 
 void __kasan_free_pages(struct page *page, unsigned int order)
 {
 	if (likely(!PageHighMem(page)))
 		kasan_poison(page_address(page), PAGE_SIZE << order,
-			     KASAN_FREE_PAGE);
+			     KASAN_FREE_PAGE, false);
 }
 
 /*
@@ -251,18 +251,18 @@ void __kasan_poison_slab(struct page *page)
 	for (i = 0; i < compound_nr(page); i++)
 		page_kasan_tag_reset(page + i);
 	kasan_poison(page_address(page), page_size(page),
-		     KASAN_KMALLOC_REDZONE);
+		     KASAN_KMALLOC_REDZONE, false);
 }
 
 void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 {
-	kasan_unpoison(object, cache->object_size);
+	kasan_unpoison(object, cache->object_size, false);
 }
 
 void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_REDZONE);
+			KASAN_KMALLOC_REDZONE, false);
 }
 
 /*
@@ -351,7 +351,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache,
 	}
 
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_FREE);
+			KASAN_KMALLOC_FREE, false);
 
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
 		return false;
@@ -407,7 +407,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	if (unlikely(!PageSlab(page))) {
 		if (____kasan_kfree_large(ptr, ip))
 			return;
-		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE);
+		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE, false);
 	} else {
 		____kasan_slab_free(page->slab_cache, ptr, ip, false);
 	}
@@ -453,7 +453,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	 * Unpoison the whole object.
 	 * For kmalloc() allocations, kasan_kmalloc() will do precise poisoning.
 	 */
-	kasan_unpoison(tagged_object, cache->object_size);
+	kasan_unpoison(tagged_object, cache->object_size, false);
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
 	if (kasan_stack_collection_enabled())
@@ -496,7 +496,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
 	redzone_end = round_up((unsigned long)(object + cache->object_size),
 				KASAN_GRANULE_SIZE);
 	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
-			   KASAN_KMALLOC_REDZONE);
+			   KASAN_KMALLOC_REDZONE, false);
 
 	/*
 	 * Save alloc info (if possible) for kmalloc() allocations.
@@ -546,7 +546,7 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 				KASAN_GRANULE_SIZE);
 	redzone_end = (unsigned long)ptr + page_size(virt_to_page(ptr));
 	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
-		     KASAN_PAGE_REDZONE);
+		     KASAN_PAGE_REDZONE, false);
 
 	return (void *)ptr;
 }
@@ -563,7 +563,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	 * Part of it might already have been unpoisoned, but it's unknown
 	 * how big that part is.
 	 */
-	kasan_unpoison(object, size);
+	kasan_unpoison(object, size, false);
 
 	page = virt_to_head_page(object);
 
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 2e55e0f82f39..53cbf28859b5 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -208,11 +208,11 @@ static void register_global(struct kasan_global *global)
 {
 	size_t aligned_size = round_up(global->size, KASAN_GRANULE_SIZE);
 
-	kasan_unpoison(global->beg, global->size);
+	kasan_unpoison(global->beg, global->size, false);
 
 	kasan_poison(global->beg + aligned_size,
 		     global->size_with_redzone - aligned_size,
-		     KASAN_GLOBAL_REDZONE);
+		     KASAN_GLOBAL_REDZONE, false);
 }
 
 void __asan_register_globals(struct kasan_global *globals, size_t size)
@@ -292,11 +292,11 @@ void __asan_alloca_poison(unsigned long addr, size_t size)
 	WARN_ON(!IS_ALIGNED(addr, KASAN_ALLOCA_REDZONE_SIZE));
 
 	kasan_unpoison((const void *)(addr + rounded_down_size),
-			size - rounded_down_size);
+			size - rounded_down_size, false);
 	kasan_poison(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
-		     KASAN_ALLOCA_LEFT);
+		     KASAN_ALLOCA_LEFT, false);
 	kasan_poison(right_redzone, padding_size + KASAN_ALLOCA_REDZONE_SIZE,
-		     KASAN_ALLOCA_RIGHT);
+		     KASAN_ALLOCA_RIGHT, false);
 }
 EXPORT_SYMBOL(__asan_alloca_poison);
 
@@ -306,7 +306,7 @@ void __asan_allocas_unpoison(const void *stack_top, const void *stack_bottom)
 	if (unlikely(!stack_top || stack_top > stack_bottom))
 		return;
 
-	kasan_unpoison(stack_top, stack_bottom - stack_top);
+	kasan_unpoison(stack_top, stack_bottom - stack_top, false);
 }
 EXPORT_SYMBOL(__asan_allocas_unpoison);
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 7fbb32234414..823a90d6a0cd 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -331,7 +331,7 @@ static inline u8 kasan_random_tag(void) { return 0; }
 
 #ifdef CONFIG_KASAN_HW_TAGS
 
-static inline void kasan_poison(const void *addr, size_t size, u8 value)
+static inline void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	addr = kasan_reset_tag(addr);
 
@@ -344,10 +344,10 @@ static inline void kasan_poison(const void *addr, size_t size, u8 value)
 	if (WARN_ON(size & KASAN_GRANULE_MASK))
 		return;
 
-	hw_set_mem_tag_range((void *)addr, size, value, false);
+	hw_set_mem_tag_range((void *)addr, size, value, init);
 }
 
-static inline void kasan_unpoison(const void *addr, size_t size)
+static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 {
 	u8 tag = get_tag(addr);
 
@@ -361,7 +361,7 @@ static inline void kasan_unpoison(const void *addr, size_t size)
 		return;
 	size = round_up(size, KASAN_GRANULE_SIZE);
 
-	hw_set_mem_tag_range((void *)addr, size, tag, false);
+	hw_set_mem_tag_range((void *)addr, size, tag, init);
 }
 
 static inline bool kasan_byte_accessible(const void *addr)
@@ -380,22 +380,24 @@ static inline bool kasan_byte_accessible(const void *addr)
  * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
  * @size - range size, must be aligned to KASAN_GRANULE_SIZE
  * @value - value that's written to metadata for the range
+ * @init - whether to initialize the memory range (only for hardware tag-based)
  *
  * The size gets aligned to KASAN_GRANULE_SIZE before marking the range.
  */
-void kasan_poison(const void *addr, size_t size, u8 value);
+void kasan_poison(const void *addr, size_t size, u8 value, bool init);
 
 /**
  * kasan_unpoison - mark the memory range as accessible
  * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
  * @size - range size, can be unaligned
+ * @init - whether to initialize the memory range (only for hardware tag-based)
  *
  * For the tag-based modes, the @size gets aligned to KASAN_GRANULE_SIZE before
  * marking the range.
  * For the generic mode, the last granule of the memory range gets partially
  * unpoisoned based on the @size.
  */
-void kasan_unpoison(const void *addr, size_t size);
+void kasan_unpoison(const void *addr, size_t size, bool init);
 
 bool kasan_byte_accessible(const void *addr);
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 63f43443f5d7..727ad4629173 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -69,7 +69,7 @@ void *memcpy(void *dest, const void *src, size_t len)
 	return __memcpy(dest, src, len);
 }
 
-void kasan_poison(const void *addr, size_t size, u8 value)
+void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
@@ -106,7 +106,7 @@ void kasan_poison_last_granule(const void *addr, size_t size)
 }
 #endif
 
-void kasan_unpoison(const void *addr, size_t size)
+void kasan_unpoison(const void *addr, size_t size, bool init)
 {
 	u8 tag = get_tag(addr);
 
@@ -129,7 +129,7 @@ void kasan_unpoison(const void *addr, size_t size)
 		return;
 
 	/* Unpoison all granules that cover the object. */
-	kasan_poison(addr, round_up(size, KASAN_GRANULE_SIZE), tag);
+	kasan_poison(addr, round_up(size, KASAN_GRANULE_SIZE), tag, false);
 
 	/* Partially poison the last granule for the generic mode. */
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
@@ -344,7 +344,7 @@ void kasan_poison_vmalloc(const void *start, unsigned long size)
 		return;
 
 	size = round_up(size, KASAN_GRANULE_SIZE);
-	kasan_poison(start, size, KASAN_VMALLOC_INVALID);
+	kasan_poison(start, size, KASAN_VMALLOC_INVALID, false);
 }
 
 void kasan_unpoison_vmalloc(const void *start, unsigned long size)
@@ -352,7 +352,7 @@ void kasan_unpoison_vmalloc(const void *start, unsigned long size)
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
-	kasan_unpoison(start, size);
+	kasan_unpoison(start, size, false);
 }
 
 static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 94c2d33be333..bd0c64d4e4d9 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -159,7 +159,7 @@ EXPORT_SYMBOL(__hwasan_storeN_noabort);
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
 {
-	kasan_poison((void *)addr, size, tag);
+	kasan_poison((void *)addr, size, tag, false);
 }
 EXPORT_SYMBOL(__hwasan_tag_memory);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

