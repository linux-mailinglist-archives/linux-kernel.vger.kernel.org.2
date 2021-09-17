Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5363640F683
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbhIQLJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhIQLJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:09:35 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:08:12 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso3588776wrn.19
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=41pNklJY3f6bJq0CDDORqOJ/YTpKyKNMUQMh29DmX70=;
        b=pSdK3RNTGgb6ZR+LjmIjo/L8cGudhf0OuXhKFLqKwg05Z+MEl0PnXm93KhtX/6zjgK
         APC5h6GFg60E4Doe+AVgmgVE8a9vIURM87P3A0kDaMbvYHPvIgiMdQ16rQz/ETwku+ZX
         YV7mLjnAB6z9SVUo+mYW+unNoHeg0Fl4IWdade2tGwn19vQch3Wy0h9BSTHoKRTyOAR4
         LdK7zQ1sSXCISNSl+FRgARCS8WtMhcsBPWa/El/0J1BgpzahUv8l7w4Q+AlrG4wB0PZb
         Bl1eVanwkN8RX703FmFcNk2xGWAO+itGWYxXjkqH4gZlBLDBXf22xpY2dA4CzVgAUedT
         qokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=41pNklJY3f6bJq0CDDORqOJ/YTpKyKNMUQMh29DmX70=;
        b=HYO/4S54QKDeDUgtbW6KEN0AtngQup0iBIe1aW2te7HTFQ10QZDatAsJdxnSb+PFQ5
         PoChWwedXYQ2mSENPPk9dt0sN7mUvvFyKMqs2B3HaCRQLCY83u6tJjVx6jfrlPxdwbQO
         h4yTecxbIUBlxCNjpgYGmtZVWqjlKq+RpO0zFBq79T3W5xvsX++p9GUY4J3uf4xW4YZh
         JgnOEG6n4UUMv+epwJjRMU5Q1aAeKMJL/pJXpDI611q2qBqw5U8Y4W1heO87VKDiwLEr
         AMNcban1i0+9niKGLSTTRPs5lmu5i2dpVlAe7QxjqsiUp2zGXMGGdApU4fJ4Mwb9CEqP
         tNlg==
X-Gm-Message-State: AOAM533O6v1vBqgba2bFnihrZODQWwnc+DzVkUMstCSs15Utmm5cn761
        V1RRGzoRy0Qucp2xanY/9r+A1v+2jg==
X-Google-Smtp-Source: ABdhPJzDljaqKYaFNol+T+wBqwa8PBOn2KgT0SEtgTO/YpQkKcD7gcZ64ORPSnxnS0X/AnbRm282L7BKiQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1a57:84a3:9bae:8070])
 (user=elver job=sendgmr) by 2002:a05:600c:8a9:: with SMTP id
 l41mr14384504wmp.29.1631876890388; Fri, 17 Sep 2021 04:08:10 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:07:54 +0200
Message-Id: <20210917110756.1121272-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 1/3] kfence: count unexpectedly skipped allocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain a counter to count allocations that are skipped due to being
incompatible (oversized, incompatible gfp flags) or no capacity.

This is to compute the fraction of allocations that could not be
serviced by KFENCE, which we expect to be rare.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 7a97db8bc8e7..2755800f3e2a 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -112,6 +112,8 @@ enum kfence_counter_id {
 	KFENCE_COUNTER_FREES,
 	KFENCE_COUNTER_ZOMBIES,
 	KFENCE_COUNTER_BUGS,
+	KFENCE_COUNTER_SKIP_INCOMPAT,
+	KFENCE_COUNTER_SKIP_CAPACITY,
 	KFENCE_COUNTER_COUNT,
 };
 static atomic_long_t counters[KFENCE_COUNTER_COUNT];
@@ -121,6 +123,8 @@ static const char *const counter_names[] = {
 	[KFENCE_COUNTER_FREES]		= "total frees",
 	[KFENCE_COUNTER_ZOMBIES]	= "zombie allocations",
 	[KFENCE_COUNTER_BUGS]		= "total bugs",
+	[KFENCE_COUNTER_SKIP_INCOMPAT]	= "skipped allocations (incompatible)",
+	[KFENCE_COUNTER_SKIP_CAPACITY]	= "skipped allocations (capacity)",
 };
 static_assert(ARRAY_SIZE(counter_names) == KFENCE_COUNTER_COUNT);
 
@@ -272,7 +276,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	}
 	raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
 	if (!meta)
-		return NULL;
+		goto no_capacity;
 
 	if (unlikely(!raw_spin_trylock_irqsave(&meta->lock, flags))) {
 		/*
@@ -289,7 +293,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 		list_add_tail(&meta->list, &kfence_freelist);
 		raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
 
-		return NULL;
+		goto no_capacity;
 	}
 
 	meta->addr = metadata_to_pageaddr(meta);
@@ -349,6 +353,10 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCS]);
 
 	return addr;
+
+no_capacity:
+	atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_CAPACITY]);
+	return NULL;
 }
 
 static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool zombie)
@@ -740,8 +748,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	 * Perform size check before switching kfence_allocation_gate, so that
 	 * we don't disable KFENCE without making an allocation.
 	 */
-	if (size > PAGE_SIZE)
+	if (size > PAGE_SIZE) {
+		atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
 		return NULL;
+	}
 
 	/*
 	 * Skip allocations from non-default zones, including DMA. We cannot
@@ -749,8 +759,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	 * properties (e.g. reside in DMAable memory).
 	 */
 	if ((flags & GFP_ZONEMASK) ||
-	    (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
+	    (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32))) {
+		atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
 		return NULL;
+	}
 
 	/*
 	 * allocation_gate only needs to become non-zero, so it doesn't make
-- 
2.33.0.464.g1972c5931b-goog

