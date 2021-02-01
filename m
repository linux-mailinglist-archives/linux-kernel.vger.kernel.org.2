Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3630B0BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhBATrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhBATp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:45:26 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B248C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:44:06 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id dj13so12035465qvb.20
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NVeqfy8PnyvgWAdKHeCgVfqveCjCMDJegzzrq5UVB6U=;
        b=b1lXS5TDAM0t8/OObzI88t9G9V6LITLxK5/HlZBBUXX7GfRsMrQIJFL7iZyApowvVV
         +V+FY2IUUWYkNTWeXZxdzf34OrHTRKwVqQcNL6fICTVHh3TpEujGh1tnocawM4hwAb4b
         TtuC53IMGp9hqR2Xewo3b/F1Q4iYHl+9mIZ2/lzggJuzIJcI4NBXgM0WrryaLtGR0m2a
         sq8jarjd69t2LKd1B5QHWJUUseYqkrYYJ/nB6l/GCPk5F1j7V1sJb7Xohp/yNGB1c8xk
         Doov5OEX30RUucXGXr1esBwDjbnsH9P77ukc8FOoY5A7aAkf1kP4LapMQoBp2hVkGH5G
         FQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NVeqfy8PnyvgWAdKHeCgVfqveCjCMDJegzzrq5UVB6U=;
        b=FUrjSLrMm9Bwi/GarzLFwMaMOyjLQkqFLQGFrhll1qOMu4UxzFfaTiospLtf4/uj+g
         zvbAfDAO5TSX2PDXW2Tzzh6Ns46loYdNIAILAGxfplD+Q3aucqOiCBraZxeqovB6r7E4
         gsO3mK1PybuIhAhcJshKkpsOyVBx1OZj99Wo0DiG6DSFpl4Gba5aIETjIwzXxSOsDQBz
         Pn8VJ2yaNyL1QIKdXP5qz9PkkqLGl6Zd0ovzfMjXtMn/3PX0GqgG87Ml7oTkWm9D6d1w
         qhQqPIQEQwAxp81qHWL+aPjvZHujjBbSa6fiL0SVm8s4kCO6NsGRMAhLG00ZtIjaDrUU
         yEYQ==
X-Gm-Message-State: AOAM532nAEvmE6af0mHGMVU4qIRXeMJMgk3OEkRcRX0BSia3pUR6OdHg
        k4LNb/3nAtfsM25bcsUJxR8udacRyTuEpYJM
X-Google-Smtp-Source: ABdhPJy3LMcMO1RRr1wTMaZvcYIHJ2lGN1Rm3XmR+DCe/2CyvjEerR8l4ufrmsSLp/ooBcba4JiSkTlvY93N5sqV
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:725:: with SMTP id
 c5mr16904134qvz.27.1612208645795; Mon, 01 Feb 2021 11:44:05 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:35 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <05a45017b4cb15344395650e880bbab0fe6ba3e4.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 11/12] kasan: always inline HW_TAGS helper functions
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

Mark all static functions in common.c and kasan.h that are used for
hardware tag-based KASAN as __always_inline to avoid unnecessary
function calls.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 13 +++++++------
 mm/kasan/kasan.h  |  6 +++---
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 5691cca69397..2004ecd6e43c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -279,7 +279,8 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
  *    based on objects indexes, so that objects that are next to each other
  *    get different tags.
  */
-static u8 assign_tag(struct kmem_cache *cache, const void *object, bool init)
+static __always_inline u8 assign_tag(struct kmem_cache *cache,
+					const void *object, bool init)
 {
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
 		return 0xff;
@@ -321,8 +322,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
-			      unsigned long ip, bool quarantine)
+static __always_inline bool ____kasan_slab_free(struct kmem_cache *cache,
+				void *object, unsigned long ip, bool quarantine)
 {
 	u8 tag;
 	void *tagged_object;
@@ -366,7 +367,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return ____kasan_slab_free(cache, object, ip, true);
 }
 
-static bool ____kasan_kfree_large(void *ptr, unsigned long ip)
+static __always_inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr))) {
 		kasan_report_invalid_free(ptr, ip);
@@ -461,8 +462,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	return tagged_object;
 }
 
-static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
-					size_t size, gfp_t flags)
+static __always_inline void *____kasan_kmalloc(struct kmem_cache *cache,
+				const void *object, size_t size, gfp_t flags)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 2f7400a3412f..d5fe72747a53 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -321,7 +321,7 @@ static inline u8 kasan_random_tag(void) { return 0; }
 
 #ifdef CONFIG_KASAN_HW_TAGS
 
-static inline void kasan_poison(const void *addr, size_t size, u8 value)
+static __always_inline void kasan_poison(const void *addr, size_t size, u8 value)
 {
 	addr = kasan_reset_tag(addr);
 
@@ -337,7 +337,7 @@ static inline void kasan_poison(const void *addr, size_t size, u8 value)
 	hw_set_mem_tag_range((void *)addr, size, value);
 }
 
-static inline void kasan_unpoison(const void *addr, size_t size)
+static __always_inline void kasan_unpoison(const void *addr, size_t size)
 {
 	u8 tag = get_tag(addr);
 
@@ -354,7 +354,7 @@ static inline void kasan_unpoison(const void *addr, size_t size)
 	hw_set_mem_tag_range((void *)addr, size, tag);
 }
 
-static inline bool kasan_byte_accessible(const void *addr)
+static __always_inline bool kasan_byte_accessible(const void *addr)
 {
 	u8 ptr_tag = get_tag(addr);
 	u8 mem_tag = hw_get_mem_tag((void *)addr);
-- 
2.30.0.365.g02bc693789-goog

