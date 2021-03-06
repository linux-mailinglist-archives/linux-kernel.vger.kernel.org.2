Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24D632F72F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCFAQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhCFAQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:16:06 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4EC061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 16:16:06 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id k10so3091673qte.17
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 16:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JV+4yHKwhA6hS5zl77p78vaE1RmKFL1mwbyUPs8dFiM=;
        b=qpZBzenaUm8U9gjmqHAi9lUT1FJi/EeHo1KPjkC4mWO1Ae8KiK1Zk4xcKR2BFWovXs
         bRAnN2aoBoFry5AjQ9v8Frq8fh41V2aEJVR64q7AUlKVEkFkraYplhp20YWYgg1ATYYy
         NwvHc26N/JC0pJcrCY4uGScNwMsL+HUQd+jYO/x0O04B7kvVD6LKqGnOahhXoPnE+IHO
         gp1co2W+kOleRZ3LwLXOdToNDq80HM+rdCNwRgMtivcMtlaIj961XVNKm5QpAECCbXS/
         fGgXgrL+u5XUZ2uBKDozWxE10fc8erjW3N+9eGR8Duy76npjEkp1h2pDcn/NKb6CHpaf
         2MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JV+4yHKwhA6hS5zl77p78vaE1RmKFL1mwbyUPs8dFiM=;
        b=ivZg60p6SBCrYMr/AjWv0VDTXZYo5gQKQa3AIAUYPsA5YsolfpGsubuVmvDJASU0Kh
         q/Th1JYU/VYPT4YIjA+dZsKAw3ATVF2vJ4DgCuVKdphd5UsRRM5oBCE5p3qdbCwcnW4b
         MG2JfBr3t6tN4EoVj1EuY+O7VtV9ATKpDGs3JXJZfLroAh4NkbyxIO4RxRXGSkaxvYgt
         pvq04ikvTc4dcf4haz1a3dew5LribaV4/JP+46MyTMOhh4PTOl4uEuI6L9JMXGS+wpHo
         pBysiCtX2vnRsRZVHyrdoxqJDpSRONXkRP7nSLJMCDtJOZT9ai6mP3daT2xZJ/pafljT
         7OeQ==
X-Gm-Message-State: AOAM5316P9fX5yEIZpnwud0O8hA4utKgIqUgUkdYf4iB+iYwBLN32Nzw
        +kgqIB1UvnRmdKtGwdkYCXxkh0Xa3IVZ4vBL
X-Google-Smtp-Source: ABdhPJwygryfylXl8C5v361HS8D5ZNHn6Yg9+lVSyvVowUaB3XkE1b5W4pkUUDPRUK01V5WtGJJW9sXsmJ8tyK+Z
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:953b:d7cf:2b01:f178])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4471:: with SMTP id
 s17mr11312797qvt.51.1614989765390; Fri, 05 Mar 2021 16:16:05 -0800 (PST)
Date:   Sat,  6 Mar 2021 01:15:52 +0100
In-Reply-To: <cover.1614989433.git.andreyknvl@google.com>
Message-Id: <a7f1d687b0550182c7f5b4a47c277a61425af65f.1614989433.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1614989433.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 3/5] kasan, mm: integrate page_alloc init with HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 16 ++++++++--------
 mm/kasan/common.c     |  8 ++++----
 mm/mempool.c          |  4 ++--
 mm/page_alloc.c       | 37 ++++++++++++++++++++++++++-----------
 4 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 1d89b8175027..4c0f414a893b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -120,20 +120,20 @@ static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
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
@@ -282,8 +282,8 @@ static inline slab_flags_t kasan_never_merge(void)
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
index 0efb07b5907c..175bdb36d113 100644
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
+	 * As memory initialization is integrated with hardware tag-based
+	 * KASAN, kasan_free_pages and kernel_init_free_pages must be
+	 * kept together to avoid discrepancies in behavior.
+	 *
 	 * With hardware tag-based KASAN, memory tags must be set before the
 	 * page becomes unavailable via debug_pagealloc or arch_free_page.
 	 */
-	kasan_free_nondeferred_pages(page, order, fpi_flags);
+	init = want_init_on_free();
+	if (init && !IS_ENABLED(CONFIG_KASAN_HW_TAGS))
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
+	 * As memory initialization is integrated with hardware tag-based
+	 * KASAN, kasan_alloc_pages and kernel_init_free_pages must be
+	 * kept together to avoid discrepancies in behavior.
+	 */
+	init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
+	kasan_alloc_pages(page, order, init);
+	if (init && !IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		kernel_init_free_pages(page, 1 << order);
+
+	kernel_unpoison_pages(page, 1 << order);
+	set_page_owner(page, order, gfp_flags);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
-- 
2.30.1.766.gb4fecdf3b7-goog

