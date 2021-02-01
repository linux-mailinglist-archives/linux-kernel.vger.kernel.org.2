Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD830B0AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBATpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhBAToZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:44:25 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E8C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:43 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id x7so10985791wrp.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xUtTTHPe7DRCgRtwSi+4scq+pNy2/ibyykEGsvZRuk0=;
        b=e176a67fK1UTibZXT++SH5zHy4zoNchdCjdpLCcct5knc2liGlNDF3Yamqdq+stmzY
         UD1Pf4fnW56aHo0VWMIdu0X7NSh9tglx3uCnpOggFaqp7pk/zA0jLS91Vw8jJ1oBwAbv
         ZdfBExGNllbfqfRyNbp+stdcka9VoQV4HuCvyYKhFs4zFM3kQb0iNgSNATnD3q8SQnlS
         bo94eGEJb9nNfzLhllE6oILm36yWPrzsRKbNhMrwH4R+PLCtzzlDsNrAtHgIeRJqSKJ7
         KKt7zUyIWygctX6LyJdzJWWpJMrEjfTNbfEc77Ex501VCB2gl3GBeZo2AsAuv/+hTAsk
         ImoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xUtTTHPe7DRCgRtwSi+4scq+pNy2/ibyykEGsvZRuk0=;
        b=LXTO0tUDHCHLW81QUSjAGGrJTaAPLMldjM0NY2o+2FrT7s6NhTEi4vK6EGZsmSLPCC
         NI4/FnWNSu2pdvFko1IrZzamyAFUYIa7ZjknWtuUW+UQztSkiAnsCiqwDtc1Vow3IvvM
         jlTUyOZo7m+Efb+vP6hY9sNPPBxnuIk82nCL6UVK1phps9HWTrWbnaXijz3pzhL07URx
         H61QW8+JzcKma2NPpERFndofPi+n3sATfsdIBWhVfHM0Weg3TRDC9cYiyxtBU9SQ+2w6
         x8k5tbN5+da+DnnaiBbzb2p58Ln/1oV80CsR0L0pI71cvSK+gJIk3Czbfo8pqf8eUw6Z
         CtWw==
X-Gm-Message-State: AOAM532S8XLgsNwdlk1ryqdIhG30bQNZ5CMVSMif0wVRPlKGtS4kVcSc
        J6xiHriVxOntZUJOy7dUd8gcS0I/QHVLykGC
X-Google-Smtp-Source: ABdhPJw8tIfQ1xoMxW7zeobkrkFUwn4wKnbjCuC6YkGhqiO0pJ6PYdc4Nfm8BLCkJlGJR9HYDF5LqYLdtDMXC9jx
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:8109:: with SMTP id
 c9mr380514wmd.137.1612208622386; Mon, 01 Feb 2021 11:43:42 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:25 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <c153f78b173df7537c9be6f2f3a888ddf0b42a3b.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 01/12] kasan, mm: don't save alloc stacks twice
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Currently KASAN saves allocation stacks in both kasan_slab_alloc() and
kasan_kmalloc() annotations. This patch changes KASAN to save allocation
stacks for slab objects from kmalloc caches in kasan_kmalloc() only,
and stacks for other slab objects in kasan_slab_alloc() only.

This change requires ____kasan_kmalloc() knowing whether the object
belongs to a kmalloc cache. This is implemented by adding a flag field
to the kasan_info structure. That flag is only set for kmalloc caches
via a new kasan_cache_create_kmalloc() annotation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  9 +++++++++
 mm/kasan/common.c     | 18 ++++++++++++++----
 mm/slab_common.c      |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6d8f3227c264..2d5de4092185 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -83,6 +83,7 @@ static inline void kasan_disable_current(void) {}
 struct kasan_cache {
 	int alloc_meta_offset;
 	int free_meta_offset;
+	bool is_kmalloc;
 };
 
 #ifdef CONFIG_KASAN_HW_TAGS
@@ -143,6 +144,13 @@ static __always_inline void kasan_cache_create(struct kmem_cache *cache,
 		__kasan_cache_create(cache, size, flags);
 }
 
+void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
+static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
+{
+	if (kasan_enabled())
+		__kasan_cache_create_kmalloc(cache);
+}
+
 size_t __kasan_metadata_size(struct kmem_cache *cache);
 static __always_inline size_t kasan_metadata_size(struct kmem_cache *cache)
 {
@@ -278,6 +286,7 @@ static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
+static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 static inline void kasan_poison_slab(struct page *page) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index fe852f3cfa42..374049564ea3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -210,6 +210,11 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		*size = optimal_size;
 }
 
+void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
+{
+	cache->kasan_info.is_kmalloc = true;
+}
+
 size_t __kasan_metadata_size(struct kmem_cache *cache)
 {
 	if (!kasan_stack_collection_enabled())
@@ -394,17 +399,22 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	}
 }
 
-static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
+static void set_alloc_info(struct kmem_cache *cache, void *object,
+				gfp_t flags, bool kmalloc)
 {
 	struct kasan_alloc_meta *alloc_meta;
 
+	/* Don't save alloc info for kmalloc caches in kasan_slab_alloc(). */
+	if (cache->kasan_info.is_kmalloc && !kmalloc)
+		return;
+
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (alloc_meta)
 		kasan_set_track(&alloc_meta->alloc_track, flags);
 }
 
 static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
-				size_t size, gfp_t flags, bool keep_tag)
+				size_t size, gfp_t flags, bool kmalloc)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
@@ -423,7 +433,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_GRANULE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_GRANULE_SIZE);
-	tag = assign_tag(cache, object, false, keep_tag);
+	tag = assign_tag(cache, object, false, kmalloc);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
 	kasan_unpoison(set_tag(object, tag), size);
@@ -431,7 +441,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 			   KASAN_KMALLOC_REDZONE);
 
 	if (kasan_stack_collection_enabled())
-		set_alloc_info(cache, (void *)object, flags);
+		set_alloc_info(cache, (void *)object, flags, kmalloc);
 
 	return set_tag(object, tag);
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9aa3d2fe4c55..39d1a8ff9bb8 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -647,6 +647,7 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 		panic("Out of memory when creating slab %s\n", name);
 
 	create_boot_cache(s, name, size, flags, useroffset, usersize);
+	kasan_cache_create_kmalloc(s);
 	list_add(&s->list, &slab_caches);
 	s->refcount = 1;
 	return s;
-- 
2.30.0.365.g02bc693789-goog

