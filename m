Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE34310ED9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhBEPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhBEPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:52:52 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3202C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:34:53 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id k90so5777754qte.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lqblrx40cOeXNR+PvBIbJ4346eed6vA2slz2Dc36rws=;
        b=g23QkriSwOFF3ULYeHRIul3KnBuvXpFVQMFgUNTP2dhadFwyqkvoS8iT1hI7oxw9f7
         u1+hhH7kXrUExKdbbU67pgUS8ZTQpX4psoCpfEBqHm2T9WXmdBzKe1WOtKnmwpqGNsdH
         NWaYbl1NbD0oV1kF5zJQD32kZ2O8qk6Ig51aoRcBymAZjP08OevkQ0QQAgDYbZDh6noJ
         8NpL3iwkxQjjiLCsAgM90Onga+590srz3TVTYwa43UOWNrA+qTqw2gHHIydZUO7ohI/s
         AfjVgKw8nc89oQ2NuTM42VIUoQ/XxjwVlTzAms18MaKAjcyY3UXsI+zOR/mE314FsPkv
         C/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lqblrx40cOeXNR+PvBIbJ4346eed6vA2slz2Dc36rws=;
        b=XQ+6Tr+7zRcAgKEMG38eDw16csKtdElAmvsTblUMXiYLc00oQfO2j2xWjr+mGC9hyd
         PHCA9xvxyJ4mdf2SJc8PrSuRm6kF8fymsvt/2UA2N1Tdjr7JeE1/fdZRAatELNR6j0Tr
         pDGd7bkAPyixJgfQlPI0OQYs01RtoPM44ckQ0Js3QJlQaimzWyoJvUcTJHDtIJ1ZzNA/
         k0qlqVWwtaU1IgZm/N7bfna/5mvTpnKPdBJ+pK9J9rI2kslEngzF+2B9Ytzg0vQ1iEfS
         TdmQr04WOeFuggWs6uqIUTQwVT9Yru15Ggd3bhJ84ZctVib/6nvoXIz/Vpkz0nTQMiMZ
         MXXQ==
X-Gm-Message-State: AOAM532kSK5ruGOrX6PGNpAv+GpVZIPbyOv0li1Xrp30sdnNQwoK4A2H
        yNyxhaH1/3yPxfykEZWBaoJNduIveJXhXtKp
X-Google-Smtp-Source: ABdhPJyYRAxjWEwapKlGp89zabVkYAfPqiYTj/SPIKWC3AYOqdFBUlK65Ye0lDHrCSs2Bx7/IGPeRGC5Kd3DzPND
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f143:: with SMTP id
 y3mr5496897qvl.62.1612546492642; Fri, 05 Feb 2021 09:34:52 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:35 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <7c673ebca8d00f40a7ad6f04ab9a2bddeeae2097.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 01/13] kasan, mm: don't save alloc stacks twice
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  9 +++++++++
 mm/kasan/common.c     | 18 ++++++++++++++----
 mm/slab_common.c      |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 1011e4f30284..e6ed969e74b3 100644
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
index fe852f3cfa42..bfdf5464f4ef 100644
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
+				gfp_t flags, bool is_kmalloc)
 {
 	struct kasan_alloc_meta *alloc_meta;
 
+	/* Don't save alloc info for kmalloc caches in kasan_slab_alloc(). */
+	if (cache->kasan_info.is_kmalloc && !is_kmalloc)
+		return;
+
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (alloc_meta)
 		kasan_set_track(&alloc_meta->alloc_track, flags);
 }
 
 static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
-				size_t size, gfp_t flags, bool keep_tag)
+				size_t size, gfp_t flags, bool is_kmalloc)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
@@ -423,7 +433,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_GRANULE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_GRANULE_SIZE);
-	tag = assign_tag(cache, object, false, keep_tag);
+	tag = assign_tag(cache, object, false, is_kmalloc);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
 	kasan_unpoison(set_tag(object, tag), size);
@@ -431,7 +441,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 			   KASAN_KMALLOC_REDZONE);
 
 	if (kasan_stack_collection_enabled())
-		set_alloc_info(cache, (void *)object, flags);
+		set_alloc_info(cache, (void *)object, flags, is_kmalloc);
 
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

