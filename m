Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC06311763
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBEXo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhBEORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:43 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F86C061797
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:46:09 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id u15so5583892wrn.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=q8NBwqooOPRUby5+8HD62t04N8TexwYKtcMMLD/hsYw=;
        b=N8dGmHEbsbmDY3Xr1kBJ5qp2vlfezU7Wn2sOBmtqjLc7astlSDlrYrHIYgx/Hxxz+o
         AGiHjTmgXxeUuUr8vHVQMMFDhhu9fxy8KVJV8jT5gioitqi1phPYh2pBXdsh16SrZnE1
         cZBmsz/S9moA1VbQKtAdFvKo278quUpv15w9RlEFBfL1tDDQQDKOQaKMPZe8dhtVpPmt
         zTe5A3rfInQaeqklm3ptrM00EOVdpUdkqBJe8YHAPLDwYJzUgKF0xceAGm9Vyd6vl0US
         AZalEr0wikduX6NeO5dNhgPtzDcI0LBhHy6aC93aif4F3M8ZDXlwLtQbsM7fzAsGN4WH
         Rakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q8NBwqooOPRUby5+8HD62t04N8TexwYKtcMMLD/hsYw=;
        b=J5O7vbISOec/qeqGT2YM2fBXozVYt7plwbPjnaivFsGzbxjVMdYXMGujxLvxamJC0Z
         89evPIyp8VkRMAKI3mvp881qXqBRi3P9M3H0ietTZeFk0iIwbeR8js56PFoy0NqGmSGi
         aWB0KkMGPn//vP4izE8F79cqvUODwzX1Xma12BAVe3yktq4MvihFK7QBdx/Th/nwCXQm
         O8kL/LwZtew0SOheHwCzg2wMccy04esTpsHC/HMkH9uDcDRtZ6krWUuPWvVk21ODZhX+
         zY0IifxPw7nQFstAm/tBqGMpCR7IFsDv2SMIET7U5TlwayqEpXLQFkcavZsluBhsE6dg
         cGvQ==
X-Gm-Message-State: AOAM531rMbV7CZbNEmV8O1K1sUjrGgi/6v9SDjmtPiyaYgpnem61zrhO
        rCnDzI/qgMySptUe7EmwpzzDJcZTPDYJ8BaX
X-Google-Smtp-Source: ABdhPJzjR0BPDS3Eaf6xpBfyulEPTn9B6ZW4BoDBH0heBGtCIrPnc5WHtwNTMu+azMOm3gvhxmLgdQ9FDPT5U+V6
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:48a8:: with SMTP id
 j40mr143776wmp.57.1612539560487; Fri, 05 Feb 2021 07:39:20 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:02 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <4aad006aea0dcf7cd24e0cac13026dc8b93a0961.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 01/12] kasan, mm: don't save alloc stacks twice
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

