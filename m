Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918DA3312AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCHPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:55:35 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FADC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:55:34 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id x9so4967863wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X6Kq0xGmQS5bAjA8d68Q+kULujL4fPHXHY/8pBMKlOo=;
        b=bzQ6TpLMxBH878sYe+Pxvf7kvozJtWxbYOKjaLMYyr5mmCTLugYgp4gy645vl6CtC2
         gg1t3T+dAo6s5NySmsmsHHH88vMdyJdgfmKvHKN9Vm6kH6Nd5P+P60rXjaeBY8CscRWB
         rOhbj91xgNEkPHNLpz89aWPRu/RIl0ujqnnTR0VOs+5IU5oIpHggCvqLDMTYdOGR+WJg
         vcVArPoEHAcl4F09NBzH9e6v4mAvHPh9zEki7oMdq5WfJPjWmJEuTwXt31BMQ4sDDUMz
         mECZVIl1m2hgDuFK5lfosuU9TSOEch4pUTy0PLbzw/OXTrDmsvpTNwBfXomVAWcOuuTo
         zePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X6Kq0xGmQS5bAjA8d68Q+kULujL4fPHXHY/8pBMKlOo=;
        b=RUduZTBZx5q59zqH9YsxAVCHIcNTU7zcAwKd2yVwrLGjYd1uzm60f4/0dIUv+RZ448
         hoIWr1v0LFyvdJFHJXrqx2zbbPBP2yLIA6lnZfk9xqPOZrtuudJSDWbg7f1Nof7/h9GK
         K139PvsPPw/s8K5LH7CxUUP/gA6aSLG2zY47yVtPyIhlyZzaWHO53CzRgEAGWlTlxJ3R
         Thc5TfeE+09WZpyCP5yece+twO9gPtKGfRczRA/Pin+j0d1uZPhPIIlm1hH13Zeql0i3
         /83VTgpagN30PoUWUIeVDE1IP7RpI3yOstktxNtv0wAR+v5+5A6GCR69VUl7B1pYMbW6
         fMMA==
X-Gm-Message-State: AOAM531VRClAUwrZyenmE8Ju5HBGAipGHzhOj4tqiAoSMfC/lyNcdLhm
        YIu1jlcT+PvvSdN2L5ON38w7ZZA1B8839BAS
X-Google-Smtp-Source: ABdhPJxl4TyOh9rOor6BFw4eddLl2/Hv3MDnOLDT8Qyb/uaG8k3rUWxUfV95BiOqc0770lZY7/ywEET0gqVzTius
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:85fb:aac9:69ed:e574])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c188:: with SMTP id
 y8mr22255933wmi.76.1615218933600; Mon, 08 Mar 2021 07:55:33 -0800 (PST)
Date:   Mon,  8 Mar 2021 16:55:18 +0100
In-Reply-To: <cover.1615218180.git.andreyknvl@google.com>
Message-Id: <fe28431edf155e4749cd0f0b25c957f50744914d.1615218180.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1615218180.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 5/5] kasan, mm: integrate slab init_on_free with HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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

This change uses the previously added memory initialization feature
of HW_TAGS KASAN routines for slab memory when init_on_free is enabled.

With this change, memory initialization memset() is no longer called
when both HW_TAGS KASAN and init_on_free are enabled. Instead, memory
is initialized in KASAN runtime.

For SLUB, the memory initialization memset() is moved into
slab_free_hook() that currently directly follows the initialization loop.
A new argument is added to slab_free_hook() that indicates whether to
initialize the memory or not.

To avoid discrepancies with which memory gets initialized that can be
caused by future changes, both KASAN hook and initialization memset()
are put together and a warning comment is added.

Combining setting allocation tags with memory initialization improves
HW_TAGS KASAN performance when init_on_free is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 10 ++++++----
 mm/kasan/common.c     | 13 +++++++------
 mm/slab.c             | 15 +++++++++++----
 mm/slub.c             | 43 ++++++++++++++++++++++++-------------------
 4 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 85f2a8786606..ed08c419a687 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -203,11 +203,13 @@ static __always_inline void * __must_check kasan_init_slab_obj(
 	return (void *)object;
 }
 
-bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
-static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object)
+bool __kasan_slab_free(struct kmem_cache *s, void *object,
+			unsigned long ip, bool init);
+static __always_inline bool kasan_slab_free(struct kmem_cache *s,
+						void *object, bool init)
 {
 	if (kasan_enabled())
-		return __kasan_slab_free(s, object, _RET_IP_);
+		return __kasan_slab_free(s, object, _RET_IP_, init);
 	return false;
 }
 
@@ -313,7 +315,7 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
 {
 	return (void *)object;
 }
-static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
+static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init)
 {
 	return false;
 }
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7ea747b18c26..623cf94288a2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -322,8 +322,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static inline bool ____kasan_slab_free(struct kmem_cache *cache,
-				void *object, unsigned long ip, bool quarantine)
+static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
+				unsigned long ip, bool quarantine, bool init)
 {
 	u8 tag;
 	void *tagged_object;
@@ -351,7 +351,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache,
 	}
 
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_FREE, false);
+			KASAN_KMALLOC_FREE, init);
 
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
 		return false;
@@ -362,9 +362,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache,
 	return kasan_quarantine_put(cache, object);
 }
 
-bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
+bool __kasan_slab_free(struct kmem_cache *cache, void *object,
+				unsigned long ip, bool init)
 {
-	return ____kasan_slab_free(cache, object, ip, true);
+	return ____kasan_slab_free(cache, object, ip, true, init);
 }
 
 static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
@@ -409,7 +410,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 			return;
 		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE, false);
 	} else {
-		____kasan_slab_free(page->slab_cache, ptr, ip, false);
+		____kasan_slab_free(page->slab_cache, ptr, ip, false, false);
 	}
 }
 
diff --git a/mm/slab.c b/mm/slab.c
index 936dd686dec9..3adfe5bc3e2e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3425,17 +3425,24 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 					 unsigned long caller)
 {
+	bool init;
+
 	if (is_kfence_address(objp)) {
 		kmemleak_free_recursive(objp, cachep->flags);
 		__kfence_free(objp);
 		return;
 	}
 
-	if (unlikely(slab_want_init_on_free(cachep)))
+	/*
+	 * As memory initialization might be integrated into KASAN,
+	 * kasan_slab_free and initialization memset must be
+	 * kept together to avoid discrepancies in behavior.
+	 */
+	init = slab_want_init_on_free(cachep);
+	if (init && !kasan_has_integrated_init())
 		memset(objp, 0, cachep->object_size);
-
-	/* Put the object into the quarantine, don't touch it for now. */
-	if (kasan_slab_free(cachep, objp))
+	/* KASAN might put objp into memory quarantine, delaying its reuse. */
+	if (kasan_slab_free(cachep, objp, init))
 		return;
 
 	/* Use KCSAN to help debug racy use-after-free. */
diff --git a/mm/slub.c b/mm/slub.c
index f53df23760e3..37afe6251bcc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1532,7 +1532,8 @@ static __always_inline void kfree_hook(void *x)
 	kasan_kfree_large(x);
 }
 
-static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
+static __always_inline bool slab_free_hook(struct kmem_cache *s,
+						void *x, bool init)
 {
 	kmemleak_free_recursive(x, s->flags);
 
@@ -1558,8 +1559,25 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
 		__kcsan_check_access(x, s->object_size,
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
 
-	/* KASAN might put x into memory quarantine, delaying its reuse */
-	return kasan_slab_free(s, x);
+	/*
+	 * As memory initialization might be integrated into KASAN,
+	 * kasan_slab_free and initialization memset's must be
+	 * kept together to avoid discrepancies in behavior.
+	 *
+	 * The initialization memset's clear the object and the metadata,
+	 * but don't touch the SLAB redzone.
+	 */
+	if (init) {
+		int rsize;
+
+		if (!kasan_has_integrated_init())
+			memset(kasan_reset_tag(x), 0, s->object_size);
+		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
+		memset((char *)kasan_reset_tag(x) + s->inuse, 0,
+		       s->size - s->inuse - rsize);
+	}
+	/* KASAN might put x into memory quarantine, delaying its reuse. */
+	return kasan_slab_free(s, x, init);
 }
 
 static inline bool slab_free_freelist_hook(struct kmem_cache *s,
@@ -1569,10 +1587,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 	void *object;
 	void *next = *head;
 	void *old_tail = *tail ? *tail : *head;
-	int rsize;
 
 	if (is_kfence_address(next)) {
-		slab_free_hook(s, next);
+		slab_free_hook(s, next, false);
 		return true;
 	}
 
@@ -1584,20 +1601,8 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 		object = next;
 		next = get_freepointer(s, object);
 
-		if (slab_want_init_on_free(s)) {
-			/*
-			 * Clear the object and the metadata, but don't touch
-			 * the redzone.
-			 */
-			memset(kasan_reset_tag(object), 0, s->object_size);
-			rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad
-							   : 0;
-			memset((char *)kasan_reset_tag(object) + s->inuse, 0,
-			       s->size - s->inuse - rsize);
-
-		}
 		/* If object's reuse doesn't have to be delayed */
-		if (!slab_free_hook(s, object)) {
+		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
 			/* Move object to the new freelist */
 			set_freepointer(s, object, *head);
 			*head = object;
@@ -3235,7 +3240,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	}
 
 	if (is_kfence_address(object)) {
-		slab_free_hook(df->s, object);
+		slab_free_hook(df->s, object, false);
 		__kfence_free(object);
 		p[size] = NULL; /* mark object processed */
 		return size;
-- 
2.30.1.766.gb4fecdf3b7-goog

