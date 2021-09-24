Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491684175A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbhIXN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346173AbhIXN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:27:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93754C09CE64
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:02:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t7so27164784wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nem774aIDIH449b+9j/jMCwWdjaEqBhcPs9HQ8+G6o=;
        b=fZaJHWBqGkwZz0UXD65mS+PAixFja2Jpl9NKfHk8AKi5+3i8IZ0Xfmol5mIc6qfTzK
         F0gOWKIALZ1alJoxeR2+7ANTY8qpK/ZxTnXg682Rmmozlg4tpHZhkPzD9uwOqASVhFfm
         jXuHWh8hDCVg2Gdr+dU4Ddg+riaKzPv86GY/Y8JE+QhNaO4s2/wwTX7PZQCKlhskrq/h
         j2ivl8aXZcNbMjQufiu7bMB1DuqeS5Qok0vgAix+AYnOr+3OZDNpzSRwnq7a7CyN4vsQ
         M1KPzPpB8+vhSrIN6O8bl2SX4wtgzGOawqa5Lvdek8K579bzXMR1DEPCCTvyn6izI7RJ
         huKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nem774aIDIH449b+9j/jMCwWdjaEqBhcPs9HQ8+G6o=;
        b=YRwM4L0xtPx1KERzM0E1GQJAS61vpLTsCIk0XzLEEkNYwOEOxYS+xjBwiQNTgBbIDA
         niuGWegCCY87b95nsW4yZTU9lqKSqnDODAQJRp16as9wxBq0s8fN1HeWQ89w/OUhdJeP
         X6pXm705Tm8pku1FjNg8GP+e8EoIoXpqiAqhaEKBDIpX2U+WRlSC6RYyh7vgDplF5pIG
         Ua2NyoQMPVCbIpa/oYHqStK2nZ3ky6LVICcLsoVaehmUcSttWqQEwibwFc2GVIDTlPc4
         YqYk0TxmYhwqdAS2/Nqoi7UW+o+Ngo9ClPZcjxPXbn+6zuRGlsODZOO54ZK2EdVUcfsC
         qgmw==
X-Gm-Message-State: AOAM533gSKS5cz1G6R8rKSiwt87MJGpzpuTnD2JgB1XR+zugwWZOD1qb
        zUYpBPP5xJuV2LKSGrMO5YcmHQ==
X-Google-Smtp-Source: ABdhPJyPnlcEV6+SsMvvV1vzwVBA0hOU/vlgmzUxlOoHeJiko66yykXceA9Ima5H1fwRF5KrCmI+IA==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr1935567wmi.7.1632488522987;
        Fri, 24 Sep 2021 06:02:02 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:594c:8b31:64da:f783])
        by smtp.gmail.com with ESMTPSA id n66sm8235632wmn.2.2021.09.24.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:02:02 -0700 (PDT)
Date:   Fri, 24 Sep 2021 15:01:56 +0200
From:   Marco Elver <elver@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 4/5] kfence: limit currently covered allocations when
 pool nearly full
Message-ID: <YU3MRGaCaJiYht5g@elver.google.com>
References: <20210923104803.2620285-1-elver@google.com>
 <20210923104803.2620285-4-elver@google.com>
 <CACT4Y+Zvm4dXQY2tCuypso9aU97_6U2dLhfg2NNA8GTvcQoCLQ@mail.gmail.com>
 <CAG_fn=V31jEBeEVh0H2+uPAd2AhV9y6hYJmcP0P_i05UJ+MiTg@mail.gmail.com>
 <CANpmjNOh0ugPq90cVRPAbR-6qr=Q4CsQ_R1Qxk_Bi4TocgwUQA@mail.gmail.com>
 <20210923162811.3cc8188d6a30d9eed2375468@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923162811.3cc8188d6a30d9eed2375468@linux-foundation.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:28PM -0700, Andrew Morton wrote:
> On Thu, 23 Sep 2021 15:44:10 +0200 Marco Elver <elver@google.com> wrote:
[...]
> > I'm worried about next_pseudo_random32() changing their implementation
> > to longer be deterministic or change in other ways that break our
> > usecase. In this case we want pseudorandomness, but we're not
> > implementing a PRNG.
> > 
> > Open-coding the constants (given they are from "Numerical Recipes") is
> > more reliable and doesn't introduce unwanted reliance on
> > next_pseudo_random32()'s behaviour.
> 
> Perhaps we could summarize this in an additional comment?

Hmm, on second thought, while trying to write the comment realized it's
unnecessary altogether. I've switched to just using hash_32() which is
probably better suited.

> Also, this:
> 
> +static u32 get_alloc_stack_hash(unsigned long *stack_entries, size_t num_entries)
> +{
> +	/* Some randomness across reboots / different machines. */
> +	u32 seed = (u32)((unsigned long)__kfence_pool >> (BITS_PER_LONG - 32));
> 
> seems a bit weak.  Would it be better to seed this at boot time with
> a randomish number?

Sure, makes sense.

Both fixes are included in the below fixup. (Let me know if resending as
v4 is better, but I've seen the patches already appeared in -mm.)

Thank you!

-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Fri, 24 Sep 2021 14:17:38 +0200
Subject: [PATCH] fixup! kfence: limit currently covered allocations when pool
 nearly full

* Simplify and just use hash_32().
* Use more random stack_hash_seed.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 58a0f6f1acc5..545999d04af4 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/debugfs.h>
+#include <linux/hash.h>
 #include <linux/irq_work.h>
 #include <linux/jhash.h>
 #include <linux/kcsan-checks.h>
@@ -122,14 +123,21 @@ atomic_t kfence_allocation_gate = ATOMIC_INIT(1);
  *	P(alloc_traces) = (1 - e^(-HNUM * (alloc_traces / SIZE)) ^ HNUM
  */
 #define ALLOC_COVERED_HNUM	2
-#define ALLOC_COVERED_SIZE	(1 << (const_ilog2(CONFIG_KFENCE_NUM_OBJECTS) + 2))
-#define ALLOC_COVERED_HNEXT(h)	(1664525 * (h) + 1013904223)
+#define ALLOC_COVERED_ORDER	(const_ilog2(CONFIG_KFENCE_NUM_OBJECTS) + 2)
+#define ALLOC_COVERED_SIZE	(1 << ALLOC_COVERED_ORDER)
+#define ALLOC_COVERED_HNEXT(h)	hash_32(h, ALLOC_COVERED_ORDER)
 #define ALLOC_COVERED_MASK	(ALLOC_COVERED_SIZE - 1)
 static atomic_t alloc_covered[ALLOC_COVERED_SIZE];
 
 /* Stack depth used to determine uniqueness of an allocation. */
 #define UNIQUE_ALLOC_STACK_DEPTH 8UL
 
+/*
+ * Randomness for stack hashes, making the same collisions across reboots and
+ * different machines less likely.
+ */
+static u32 stack_hash_seed __ro_after_init;
+
 /* Statistics counters for debugfs. */
 enum kfence_counter_id {
 	KFENCE_COUNTER_ALLOCATED,
@@ -166,12 +174,9 @@ static inline bool should_skip_covered(void)
 
 static u32 get_alloc_stack_hash(unsigned long *stack_entries, size_t num_entries)
 {
-	/* Some randomness across reboots / different machines. */
-	u32 seed = (u32)((unsigned long)__kfence_pool >> (BITS_PER_LONG - 32));
-
 	num_entries = min(num_entries, UNIQUE_ALLOC_STACK_DEPTH);
 	num_entries = filter_irq_stacks(stack_entries, num_entries);
-	return jhash(stack_entries, num_entries * sizeof(stack_entries[0]), seed);
+	return jhash(stack_entries, num_entries * sizeof(stack_entries[0]), stack_hash_seed);
 }
 
 /*
@@ -759,6 +764,7 @@ void __init kfence_init(void)
 	if (!kfence_sample_interval)
 		return;
 
+	stack_hash_seed = (u32)random_get_entropy();
 	if (!kfence_init_pool()) {
 		pr_err("%s failed\n", __func__);
 		return;
-- 
2.33.0.685.g46640cef36-goog

