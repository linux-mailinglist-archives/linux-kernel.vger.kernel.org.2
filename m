Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85633270F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhCINZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCINYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:24:52 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:24:52 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p15so6354900wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c/p2Irv0oGLny+pAqsKq0iE2bCIU3zeaZM7JLSHPDFk=;
        b=gzJBIzAY9hyDgxpbhQfHRjW6uVRYM96yZcDQENLSCQnztbnYzUK4hikXf0R95IczTD
         WpxaYBQeAQyO8rGYXxWZg0mQs62ykzhPbU4A+stN8k0fNKSAe/kgIjP37RciVbsBFxhi
         crtF0pHRFv17Frr9tO+8aq8osg/aJKJ0WQRLTseQWNovOSeAB3/qB80lPQGIdKujUu1B
         HIrCu4e1lwItAL2xGio/gI+OUgS7pHTdmtdceCrjvOxynJ+3wlUybbUuKCby93ZR6nUc
         Pgdsd9BV+QQF1N8R4ipjPrrlOm9KBx6vuk3Ichy1zl6FEhOvtmZ0D0cdKMk4MQPQDE23
         ztrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c/p2Irv0oGLny+pAqsKq0iE2bCIU3zeaZM7JLSHPDFk=;
        b=XWtZZ4hnlL0o8TkUQJViioPRxov6GwqGVDU6zDvp4Jf3dZt/VM+yvyXOr56eBX7MBC
         urDs9BzaGni9WoTX70QdBO+1ZN1kOa+Sy5l7rzyDMhgKj/yGMK2RuTYJ72RvqBESlShH
         WiTWmkdmtiGbzzld88H/sgW/FBhFWePEIqFjdn6wA2jbd0X//G5corJYDi0kEHFfGG+v
         BhSMdvxz1e4aHcUOrbys6pCsSCd2MA9DeKAuz52OveQLBnNc/dM6++Cmvy7AkUCZKrPV
         rPvVum6iUsYAiLkR/frdVTG212FqSrTTxwZP7ZPXyYkxH3w2y8i5y8gU2MHYfIziA0rp
         HHXA==
X-Gm-Message-State: AOAM532bNUJsCAgMbX67krVA+0zUvsbqLcRtG8i26NU+FYQp759+gAiY
        bUxXPBVfdSlhlk9WrbpC38/eUKFlS3OGdPAi
X-Google-Smtp-Source: ABdhPJzbY0rsJsdxST/CtjSw0M9bixuf6nmuojmg81V5WIXsnM5lCzwTQDkGk13BZ5VvfZKWsc1hr770BDSUZe/c
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:5802:818:ce92:dfef])
 (user=andreyknvl job=sendgmr) by 2002:a1c:6243:: with SMTP id
 w64mr565189wmb.0.1615296290069; Tue, 09 Mar 2021 05:24:50 -0800 (PST)
Date:   Tue,  9 Mar 2021 14:24:37 +0100
In-Reply-To: <cover.1615296150.git.andreyknvl@google.com>
Message-Id: <e77f0d5b1b20658ef0b8288625c74c2b3690e725.1615296150.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1615296150.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 3/5] kasan, mm: integrate page_alloc init with HW_TAGS
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
of HW_TAGS KASAN routines for page_alloc memory when init_on_alloc/free
is enabled.

With this change, kernel_init_free_pages() is no longer called when
both HW_TAGS KASAN and init_on_alloc/free are enabled. Instead, memory
is initialized in KASAN runtime.

To avoid discrepancies with which memory gets initialized that can be
caused by future changes, both KASAN and kernel_init_free_pages() hooks
are put together and a warning comment is added.

This patch changes the order in which memory initialization and page
poisoning hooks are called. This doesn't lead to any side-effects, as
whenever page poisoning is enabled, memory initialization gets disabled.

Combining setting allocation tags with memory initialization improves
HW_TAGS KASAN performance when init_on_alloc/free is enabled.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 30 ++++++++++++++++++++++--------
 mm/kasan/common.c     |  8 ++++----
 mm/mempool.c          |  4 ++--
 mm/page_alloc.c       | 37 ++++++++++++++++++++++++++-----------
 4 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 1d89b8175027..c89613caa8cf 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -96,6 +96,11 @@ static __always_inline bool kasan_enabled(void)
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
+static inline bool kasan_has_integrated_init(void)
+{
+	return kasan_enabled();
+}
+
 #else /* CONFIG_KASAN_HW_TAGS */
 
 static inline bool kasan_enabled(void)
@@ -103,6 +108,11 @@ static inline bool kasan_enabled(void)
 	return true;
 }
 
+static inline bool kasan_has_integrated_init(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 slab_flags_t __kasan_never_merge(void);
@@ -120,20 +130,20 @@ static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
 		__kasan_unpoison_range(addr, size);
 }
 
-void __kasan_alloc_pages(struct page *page, unsigned int order);
+void __kasan_alloc_pages(struct page *page, unsigned int order, bool init);
 static __always_inline void kasan_alloc_pages(struct page *page,
-						unsigned int order)
+						unsigned int order, bool init)
 {
 	if (kasan_enabled())
-		__kasan_alloc_pages(page, order);
+		__kasan_alloc_pages(page, order, init);
 }
 
-void __kasan_free_pages(struct page *page, unsigned int order);
+void __kasan_free_pages(struct page *page, unsigned int order, bool init);
 static __always_inline void kasan_free_pages(struct page *page,
-						unsigned int order)
+						unsigned int order, bool init)
 {
 	if (kasan_enabled())
-		__kasan_free_pages(page, order);
+		__kasan_free_pages(page, order, init);
 }
 
 void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
@@ -277,13 +287,17 @@ static inline bool kasan_enabled(void)
 {
 	return false;
 }
+static inline bool kasan_has_integrated_init(void)
+{
+	return false;
+}
 static inline slab_flags_t kasan_never_merge(void)
 {
 	return 0;
 }
 static inline void kasan_unpoison_range(const void *address, size_t size) {}
-static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
-static inline void kasan_free_pages(struct page *page, unsigned int order) {}
+static inline void kasan_alloc_pages(struct page *page, unsigned int order, bool init) {}
+static inline void kasan_free_pages(struct page *page, unsigned int order, bool init) {}
 static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 316f7f8cd8e6..6107c795611f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -97,7 +97,7 @@ slab_flags_t __kasan_never_merge(void)
 	return 0;
 }
 
-void __kasan_alloc_pages(struct page *page, unsigned int order)
+void __kasan_alloc_pages(struct page *page, unsigned int order, bool init)
 {
 	u8 tag;
 	unsigned long i;
@@ -108,14 +108,14 @@ void __kasan_alloc_pages(struct page *page, unsigned int order)
 	tag = kasan_random_tag();
 	for (i = 0; i < (1 << order); i++)
 		page_kasan_tag_set(page + i, tag);
-	kasan_unpoison(page_address(page), PAGE_SIZE << order, false);
+	kasan_unpoison(page_address(page), PAGE_SIZE << order, init);
 }
 
-void __kasan_free_pages(struct page *page, unsigned int order)
+void __kasan_free_pages(struct page *page, unsigned int order, bool init)
 {
 	if (likely(!PageHighMem(page)))
 		kasan_poison(page_address(page), PAGE_SIZE << order,
-			     KASAN_FREE_PAGE, false);
+			     KASAN_FREE_PAGE, init);
 }
 
 /*
diff --git a/mm/mempool.c b/mm/mempool.c
index 79959fac27d7..fe19d290a301 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -106,7 +106,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
 		kasan_slab_free_mempool(element);
 	else if (pool->alloc == mempool_alloc_pages)
-		kasan_free_pages(element, (unsigned long)pool->pool_data);
+		kasan_free_pages(element, (unsigned long)pool->pool_data, false);
 }
 
 static void kasan_unpoison_element(mempool_t *pool, void *element)
@@ -114,7 +114,7 @@ static void kasan_unpoison_element(mempool_t *pool, void *element)
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
 		kasan_unpoison_range(element, __ksize(element));
 	else if (pool->alloc == mempool_alloc_pages)
-		kasan_alloc_pages(element, (unsigned long)pool->pool_data);
+		kasan_alloc_pages(element, (unsigned long)pool->pool_data, false);
 }
 
 static __always_inline void add_element(mempool_t *pool, void *element)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0efb07b5907c..aba9cd673eac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -396,14 +396,14 @@ static DEFINE_STATIC_KEY_TRUE(deferred_pages);
  * initialization is done, but this is not likely to happen.
  */
 static inline void kasan_free_nondeferred_pages(struct page *page, int order,
-							fpi_t fpi_flags)
+						bool init, fpi_t fpi_flags)
 {
 	if (static_branch_unlikely(&deferred_pages))
 		return;
 	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
 			(fpi_flags & FPI_SKIP_KASAN_POISON))
 		return;
-	kasan_free_pages(page, order);
+	kasan_free_pages(page, order, init);
 }
 
 /* Returns true if the struct page for the pfn is uninitialised */
@@ -455,12 +455,12 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 }
 #else
 static inline void kasan_free_nondeferred_pages(struct page *page, int order,
-							fpi_t fpi_flags)
+						bool init, fpi_t fpi_flags)
 {
 	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
 			(fpi_flags & FPI_SKIP_KASAN_POISON))
 		return;
-	kasan_free_pages(page, order);
+	kasan_free_pages(page, order, init);
 }
 
 static inline bool early_page_uninitialised(unsigned long pfn)
@@ -1242,6 +1242,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			unsigned int order, bool check_free, fpi_t fpi_flags)
 {
 	int bad = 0;
+	bool init;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1299,16 +1300,21 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		debug_check_no_obj_freed(page_address(page),
 					   PAGE_SIZE << order);
 	}
-	if (want_init_on_free())
-		kernel_init_free_pages(page, 1 << order);
 
 	kernel_poison_pages(page, 1 << order);
 
 	/*
+	 * As memory initialization might be integrated into KASAN,
+	 * kasan_free_pages and kernel_init_free_pages must be
+	 * kept together to avoid discrepancies in behavior.
+	 *
 	 * With hardware tag-based KASAN, memory tags must be set before the
 	 * page becomes unavailable via debug_pagealloc or arch_free_page.
 	 */
-	kasan_free_nondeferred_pages(page, order, fpi_flags);
+	init = want_init_on_free();
+	if (init && !kasan_has_integrated_init())
+		kernel_init_free_pages(page, 1 << order);
+	kasan_free_nondeferred_pages(page, order, init, fpi_flags);
 
 	/*
 	 * arch_free_page() can make the page's contents inaccessible.  s390
@@ -2315,17 +2321,26 @@ static bool check_new_pages(struct page *page, unsigned int order)
 inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags)
 {
+	bool init;
+
 	set_page_private(page, 0);
 	set_page_refcounted(page);
 
 	arch_alloc_page(page, order);
 	debug_pagealloc_map_pages(page, 1 << order);
-	kasan_alloc_pages(page, order);
-	kernel_unpoison_pages(page, 1 << order);
-	set_page_owner(page, order, gfp_flags);
 
-	if (!want_init_on_free() && want_init_on_alloc(gfp_flags))
+	/*
+	 * As memory initialization might be integrated into KASAN,
+	 * kasan_alloc_pages and kernel_init_free_pages must be
+	 * kept together to avoid discrepancies in behavior.
+	 */
+	init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
+	kasan_alloc_pages(page, order, init);
+	if (init && !kasan_has_integrated_init())
 		kernel_init_free_pages(page, 1 << order);
+
+	kernel_unpoison_pages(page, 1 << order);
+	set_page_owner(page, order, gfp_flags);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
-- 
2.30.1.766.gb4fecdf3b7-goog

