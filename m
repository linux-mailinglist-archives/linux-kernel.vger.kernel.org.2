Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626C311131
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhBERqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhBEPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:54:58 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE30C061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:14 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id m4so6985706ejc.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qufdT2LxTRMhYRcFfEhB7241MbQS+EEn9OJq6bu53kI=;
        b=o3q+JKMBB2p6vxYp6UlNQonm7sinRipxEBzz0BaJM3rqo2apLOKCW0H29zn/wqpROs
         /iOZbrx0EpfNLyjqUm8hTQsjxWGPdm46yggYbtmuYywiKbQSRPJAFxEMFTe2i1VtBADV
         3YeuKIZmcNp4jRuVBRSGExLiNPQ0/9mX7ulWbwSalSRCHJaaddgKdEGlD5UIW4uewCgH
         u8sbQs+sZWKs3y2rejq6DyAEJy0OdPTNc79FOttdEOg46cmZar5QKvx3Fee86H3fb02X
         9JZob9YeC/kUfqm0uyfXeTmxYTa1Zi3gl3rVutvtV9CSaIRwIEessmkDKi+KSRqtI0ST
         76bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qufdT2LxTRMhYRcFfEhB7241MbQS+EEn9OJq6bu53kI=;
        b=N03bS5ItjelthbFQnuHJ6nfRHeTPtDQNuVNPKZPUXT3MlFmQWeJEPeNg91MqGm6cm9
         P5+lja8Cuz9WsRHiR9nWO8tKn4PGSvGOP4mik9dC/yfpcqCFAHff6PCOYi4ApM0p59YS
         n5HD/iw/Hd2uhIFmQv15saJQzPpKe2vIJ8D/JpxtrNUTImKSnR5xK6QNuHmUjHVcwtdu
         HfVUsybOcLl1oY4YY2d+vQwMcB6j2tPneuoVbJeyPx9CeYfhkyoCNxMCqgRsrWxCec+p
         qXSIvIijJjgVy76UhHv6XuUleMZ7n6L6kTj6K1ZrGDRfkxkF0agcfTo9zGJ8nZhoY6Xp
         7+tg==
X-Gm-Message-State: AOAM530Y4tCDDv1LAwXGjaETFBhbAEjCON3Eq553hU6aQcYVkijFMNUy
        VhGtCtK9R5Sk5zPuocIuq7SRlx9ieG/kTERd
X-Google-Smtp-Source: ABdhPJyWWe37oEqyJEJadVG8fp31IaMzdbGRH8rs/dpjbTP77F3EsdvHBUAogyehH3wl9neL0B5sNIh1QHWoxIWS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:5193:: with SMTP id
 q19mr4617213edd.264.1612546512746; Fri, 05 Feb 2021 09:35:12 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:43 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <3ffe8d4a246ae67a8b5e91f65bf98cd7cba9d7b9.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 09/13] kasan: ensure poisoning size alignment
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
index d0a3516e0909..cc787ba47e1b 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -318,30 +318,37 @@ static inline u8 kasan_random_tag(void) { return 0; }
 
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
@@ -358,7 +365,7 @@ static inline bool kasan_byte_accessible(const void *addr)
 /**
  * kasan_poison - mark the memory range as unaccessible
  * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
- * @size - range size
+ * @size - range size, must be aligned to KASAN_GRANULE_SIZE
  * @value - value that's written to metadata for the range
  *
  * The size gets aligned to KASAN_GRANULE_SIZE before marking the range.
@@ -368,7 +375,7 @@ void kasan_poison(const void *addr, size_t size, u8 value);
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

