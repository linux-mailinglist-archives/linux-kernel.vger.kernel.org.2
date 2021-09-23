Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA894415C36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhIWKtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbhIWKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:49:47 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:16 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso4790349wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fWJbOvO/9IQd66CKXhWeX2UUgjmgk+7Ytnnk5fprUlg=;
        b=YK7pY2T3iaVC5xj3yZsnws4HJRmKJ1x8OmasO4WGgABT7rft/ZvQs4eh1gFpy8QetD
         9KFo7eg38M1OU0JT69layBKo4st3huLUeepUVwNfVluaA7bxQ+sTdPwn6Xevo9ThbnmG
         jQQDmsU1F8ePO39RpE0bTfH97J7YRmeHXWGwGY2IhhhojpcORagCJnt8penB7I+v9yDj
         7vilSsCePqG+aodTc6Az7A1RmmZbD9Vzq1m1U9a/xZF4rtFOXa2naUGI9rjT2fthCoV/
         pH3tfvOHyvmn/yr6p+nVHw10RJ8IsJ5icn8k/qTaMN0WdIIt56ezcaixdz8RC479uBXQ
         gS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fWJbOvO/9IQd66CKXhWeX2UUgjmgk+7Ytnnk5fprUlg=;
        b=Ex/4nS2PpXTZ7kEvgkG2G6+c5c7z5qyLQy0cmSIcGA5fQwUHEuPaNPVG4l8ln2LbRC
         cLMK+cgU8BaAnGRMpkexwwxawpuFHsLCcJgoJdpyiovRWNn3tGaCK2v5svuofCQBe87G
         s7zs1oWKTu9Zqnmvq4OgO9bv05jPIKgp5BRvcefRsLa94g8+KFBIlRiYGyqMDTQmcAXP
         C/Oml3n5C6w2iR4DzfBDmoTy871LQjrhdGO2tEB3ECF/7jwhDNgfVvd17ikhhdVpB0Su
         g5l8VWXAsaINCRuV5WSNfTtT7l3abpzHdYn7mPfo/HlLcEgGrkHFASZFKzFsHmTwizf7
         J6+w==
X-Gm-Message-State: AOAM531rnf0+mWvCyzGFqXuMnXTAV/vcHQ9zOdpeRj8S2FqWylsy/0rg
        TpFUArSr1mdC5ESVbD46s9qJlhEkBg==
X-Google-Smtp-Source: ABdhPJww9Oj32004rlHlbgMaoG0LRo/rz6EFbKkPl4dyYvsN1SYDd8AmtefGBVYLegGFwkMLj0o33H8J5w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:bd72:fd35:a085:c2e3])
 (user=elver job=sendgmr) by 2002:a05:600c:4154:: with SMTP id
 h20mr15186317wmm.172.1632394094273; Thu, 23 Sep 2021 03:48:14 -0700 (PDT)
Date:   Thu, 23 Sep 2021 12:48:00 +0200
In-Reply-To: <20210923104803.2620285-1-elver@google.com>
Message-Id: <20210923104803.2620285-2-elver@google.com>
Mime-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 2/5] kfence: count unexpectedly skipped allocations
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
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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

