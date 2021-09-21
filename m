Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66840413154
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhIUKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhIUKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:11:54 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3AAC0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:25 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso8415095wrw.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xqqCxuPrLaI1bLHMtAoGnOmrTQGbiQ0pjESMOvziO8U=;
        b=qs17jDbteS5bWdNSKYisdGThfhw9mWQnXuLyDn6xh+msrxUA9pL4A27pn9TwTQrYnc
         moBRZ7rLgtd5xbvFGT+peg1BDWHZINSnPwjQsihQBR8kwVpvgwCLAVYdkYSefa0VxoS/
         Q+5b+qWoU3fZeGcpCQwQmtHjSt8ti2Z1t/n+CM1PoatMoed+scoju5sduDhnyIsVzicw
         y9RoxUQCrJxc6gtXTq0Ql69uBegGYNtHgMHBV4DPPDb6LVMtSUyfjyE7hmLqnTyrMNOi
         FMEUELhmmZAbG7nPbkA/UWCwEf0cq04sik7J2SQR8/5c1fzbxlm2QsRI2ZeLxSQ9fN6t
         zT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xqqCxuPrLaI1bLHMtAoGnOmrTQGbiQ0pjESMOvziO8U=;
        b=P7I7WtlWmaTKcseKJKP53LAaugSO6zXMjBVGx155TeYfSB1lthp52mOaSNhKVrQRS0
         Lsnt33id98IQSaq4zv57tW0ycrROEuwFjTkljapz2Bw9rXOo/iO+44v0mRQ46Od2Ni8V
         jx24IMbOaLC3h2rRTf7/s92DcE3Cwk4cKcXQWdTAc/H6KXYxtv3KUW5HQkSE7/cR8A8b
         EDoyHB2HvUbZC4/KJbvABxDl+OC0sSVMExBx6UkUHgXL+9+Yd319dOYGm7DfXFZa3D9K
         8R3SAW+5E6BAThGwqHprDbBS5EOnbbexkZ43ifufVDMzDVSPh2MU3EwAIsI4cnxm+BSA
         HRvw==
X-Gm-Message-State: AOAM531c8ctTIrfrjMEZepV9TYG6NT68phGuwktWkd9rTS5dPO65FGG0
        HOdyLdbGgezJdhB2lU7a8aK1ITWbkw==
X-Google-Smtp-Source: ABdhPJx3COIbhHiKgMNm57MtDHgPxrn6NCIlsrggderVlrIYqkuHZHIVgfoPpXY4sPnG4z78HjkMGPH1JQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dd03:c280:4625:60db])
 (user=elver job=sendgmr) by 2002:a1c:a713:: with SMTP id q19mr3631781wme.42.1632219023932;
 Tue, 21 Sep 2021 03:10:23 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:10:11 +0200
In-Reply-To: <20210921101014.1938382-1-elver@google.com>
Message-Id: <20210921101014.1938382-2-elver@google.com>
Mime-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 2/5] kfence: count unexpectedly skipped allocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
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
v2:
* Do not count deadlock-avoidance skips.
---
 mm/kfence/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 7a97db8bc8e7..249d75b7e5ee 100644
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
 
@@ -271,8 +275,10 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 		list_del_init(&meta->list);
 	}
 	raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
-	if (!meta)
+	if (!meta) {
+		atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_CAPACITY]);
 		return NULL;
+	}
 
 	if (unlikely(!raw_spin_trylock_irqsave(&meta->lock, flags))) {
 		/*
@@ -740,8 +746,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
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
@@ -749,8 +757,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
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

