Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF3311767
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBEXrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhBEORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:43 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F98C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:45:47 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id e15so5543198wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sdkgj896Qo+AFN+zvttnZapcO4bCa1e5ImK6MurFn1k=;
        b=UwU8BZglk6GLCdc+Y+3cPUnrMSIhuxzhkzQi7L+6RBq8L/Ja+DrNoAHGZ9tg8zuien
         9wQ/oFCEdEAqzF9q/ziTAcoTLx7uq4pe214ZPEfMRvBi41RZfpfTYdNJuR+aC1x1zhTG
         j/jMay7GnbyuMPEuOHGBxtKo4KuqGPs53RjpG84LK6ZFkEla+I+5zy8xZ15HdGMOVJzn
         tMaxk4y8mtz/jU4/R4uxAaF98U15EJgDBEMCthRK/vIO9tZkvEjazL4EP2GW385cy5Rd
         yohmn2hhYmmpppVhingV+70vLqHCr6HaWpy2qXGFbNromUr4VMO4xKXOBPfNa/3ZOwdR
         OO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sdkgj896Qo+AFN+zvttnZapcO4bCa1e5ImK6MurFn1k=;
        b=Ky9fOuC4iHoeGMzLom959JEcl1+KA5vzewcHx8H973ff6+t5XMIGUEq7TIGoEl90cM
         hIeUFFVw7aapCiZRRWb+T0Eq2N9uPbvzLCoYuVWRa/OuGrdWVBdmEEZCxPloAMh+GlfG
         qOuNKqrCvHi8U9uJFuE2aZhr/7VTHnvk8K5J1efS30JBNc+9iRGryKoccpP5DfLmuO3E
         3v69JET5K2TDf/Sy+vIGpMj6ffYULLRtr2LfrkAyIKLqUlh/La0p0TyORLZLWsFuWSja
         JbI+Ip85BvRN5IXGbTNsUbJdS/6oDLZqfWw6FRdijC8xP1sQke1uLoEA3+i/Sy2fik1q
         ynCQ==
X-Gm-Message-State: AOAM532ydFOWVENQpQh5SXLxbhH3841kfY3HNj6fhsEEpfzhzQpj5NuH
        VfYLf3EPL3nogExP5mYgykVn3ptbguxP7Wu0
X-Google-Smtp-Source: ABdhPJxDbLmIELc7j7WQJZu+Bpk80w6bKCbvSm27wbQqmOHDlPvAbZr77jAT0AHFGmy1CYo2Fg0HMKHW3zixhotB
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:21d2:: with SMTP id
 x18mr4105351wmj.186.1612539579825; Fri, 05 Feb 2021 07:39:39 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:10 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <3917dc59e3dbf99b2929a1e20d41df0c5930e026.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 09/12] kasan: ensure poisoning size alignment
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

A previous changes d99f6a10c161 ("kasan: don't round_up too much")
attempted to simplify the code by adding a round_up(size) call into
kasan_poison(). While this allows to have less round_up() calls around
the code, this results in round_up() being called multiple times.

This patch removes round_up() of size from kasan_poison() and ensures
that all callers round_up() the size explicitly. This patch also adds
WARN_ON() alignment checks for address and size to kasan_poison() and
kasan_unpoison().

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c |  9 ++++++---
 mm/kasan/kasan.h  | 33 ++++++++++++++++++++-------------
 mm/kasan/shadow.c | 37 ++++++++++++++++++++++---------------
 3 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a8a67dca5e55..7ffb1e6de2ef 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -261,7 +261,8 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 
 void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
-	kasan_poison(object, cache->object_size, KASAN_KMALLOC_REDZONE);
+	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
+			KASAN_KMALLOC_REDZONE);
 }
 
 /*
@@ -348,7 +349,8 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return true;
 	}
 
-	kasan_poison(object, cache->object_size, KASAN_KMALLOC_FREE);
+	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
+			KASAN_KMALLOC_FREE);
 
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
 		return false;
@@ -490,7 +492,8 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	/* Poison the aligned part of the redzone. */
 	redzone_start = round_up((unsigned long)(object + size),
 				KASAN_GRANULE_SIZE);
-	redzone_end = (unsigned long)object + cache->object_size;
+	redzone_end = round_up((unsigned long)(object + cache->object_size),
+				KASAN_GRANULE_SIZE);
 	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
 			   KASAN_KMALLOC_REDZONE);
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 6a2882997f23..98f70ffc9e1c 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -321,30 +321,37 @@ static inline u8 kasan_random_tag(void) { return 0; }
 
 #ifdef CONFIG_KASAN_HW_TAGS
 
-static inline void kasan_poison(const void *address, size_t size, u8 value)
+static inline void kasan_poison(const void *addr, size_t size, u8 value)
 {
-	address = kasan_reset_tag(address);
+	addr = kasan_reset_tag(addr);
 
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(address))
+	if (is_kfence_address(addr))
 		return;
 
-	hw_set_mem_tag_range((void *)address,
-			round_up(size, KASAN_GRANULE_SIZE), value);
+	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
+		return;
+	if (WARN_ON(size & KASAN_GRANULE_MASK))
+		return;
+
+	hw_set_mem_tag_range((void *)addr, size, value);
 }
 
-static inline void kasan_unpoison(const void *address, size_t size)
+static inline void kasan_unpoison(const void *addr, size_t size)
 {
-	u8 tag = get_tag(address);
+	u8 tag = get_tag(addr);
 
-	address = kasan_reset_tag(address);
+	addr = kasan_reset_tag(addr);
 
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(address))
+	if (is_kfence_address(addr))
 		return;
 
-	hw_set_mem_tag_range((void *)address,
-			round_up(size, KASAN_GRANULE_SIZE), tag);
+	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
+		return;
+	size = round_up(size, KASAN_GRANULE_SIZE);
+
+	hw_set_mem_tag_range((void *)addr, size, tag);
 }
 
 static inline bool kasan_byte_accessible(const void *addr)
@@ -361,7 +368,7 @@ static inline bool kasan_byte_accessible(const void *addr)
 /**
  * kasan_poison - mark the memory range as unaccessible
  * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
- * @size - range size
+ * @size - range size, must be aligned to KASAN_GRANULE_SIZE
  * @value - value that's written to metadata for the range
  *
  * The size gets aligned to KASAN_GRANULE_SIZE before marking the range.
@@ -371,7 +378,7 @@ void kasan_poison(const void *addr, size_t size, u8 value);
 /**
  * kasan_unpoison - mark the memory range as accessible
  * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
- * @size - range size
+ * @size - range size, can be unaligned
  *
  * For the tag-based modes, the @size gets aligned to KASAN_GRANULE_SIZE before
  * marking the range.
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 1ed7817e4ee6..63f43443f5d7 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -69,7 +69,7 @@ void *memcpy(void *dest, const void *src, size_t len)
 	return __memcpy(dest, src, len);
 }
 
-void kasan_poison(const void *address, size_t size, u8 value)
+void kasan_poison(const void *addr, size_t size, u8 value)
 {
 	void *shadow_start, *shadow_end;
 
@@ -78,55 +78,62 @@ void kasan_poison(const void *address, size_t size, u8 value)
 	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
 	 * addresses to this function.
 	 */
-	address = kasan_reset_tag(address);
+	addr = kasan_reset_tag(addr);
 
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
-	if (is_kfence_address(address))
+	if (is_kfence_address(addr))
 		return;
 
-	size = round_up(size, KASAN_GRANULE_SIZE);
-	shadow_start = kasan_mem_to_shadow(address);
-	shadow_end = kasan_mem_to_shadow(address + size);
+	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
+		return;
+	if (WARN_ON(size & KASAN_GRANULE_MASK))
+		return;
+
+	shadow_start = kasan_mem_to_shadow(addr);
+	shadow_end = kasan_mem_to_shadow(addr + size);
 
 	__memset(shadow_start, value, shadow_end - shadow_start);
 }
 EXPORT_SYMBOL(kasan_poison);
 
 #ifdef CONFIG_KASAN_GENERIC
-void kasan_poison_last_granule(const void *address, size_t size)
+void kasan_poison_last_granule(const void *addr, size_t size)
 {
 	if (size & KASAN_GRANULE_MASK) {
-		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
+		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
 		*shadow = size & KASAN_GRANULE_MASK;
 	}
 }
 #endif
 
-void kasan_unpoison(const void *address, size_t size)
+void kasan_unpoison(const void *addr, size_t size)
 {
-	u8 tag = get_tag(address);
+	u8 tag = get_tag(addr);
 
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
 	 * addresses to this function.
 	 */
-	address = kasan_reset_tag(address);
+	addr = kasan_reset_tag(addr);
 
 	/*
 	 * Skip KFENCE memory if called explicitly outside of sl*b. Also note
 	 * that calls to ksize(), where size is not a multiple of machine-word
 	 * size, would otherwise poison the invalid portion of the word.
 	 */
-	if (is_kfence_address(address))
+	if (is_kfence_address(addr))
+		return;
+
+	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
 
-	/* Unpoison round_up(size, KASAN_GRANULE_SIZE) bytes. */
-	kasan_poison(address, size, tag);
+	/* Unpoison all granules that cover the object. */
+	kasan_poison(addr, round_up(size, KASAN_GRANULE_SIZE), tag);
 
 	/* Partially poison the last granule for the generic mode. */
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
-		kasan_poison_last_granule(address, size);
+		kasan_poison_last_granule(addr, size);
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.30.0.365.g02bc693789-goog

