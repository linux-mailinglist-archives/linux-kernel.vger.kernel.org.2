Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5344D40F685
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbhIQLJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbhIQLJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:09:36 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:08:14 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id g130-20020a1c2088000000b00308ecd761e8so1602777wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uDdPzmnsldiiwWZYw9Tc+4pkR1I79p2wunSmR5EOuHU=;
        b=GhWbwajvwU6gWT/WfCkQEE5S2PNRhuWVEfGsQCMR84tLFgU1NGIHaeO/hoeVjJ8h+s
         /HdcGxF3z4484w7xiSGhIPmkPEQpagGaj+eYt0A3wHxJQxOZ+x+LOxH9qUfoAAyXOZpV
         SXgQMIb941YjHDjFLQTb09m2TpI7bIJ1ELs4KJowe2/Nvm1ldm/GAYVkCq/JxKlsNZr4
         t3Y54vxPBwg0Qyo5UEVyY2ospn0C2bQLxAvAjdh67dGly5rMH/qOpKHNYYFEmSOQfBZc
         JOw/8nMsJ5xGcYRNjdJwWg//XaCsauDAmyKC4JfjWPjlzAbLeasf6pDiyo76QGachfFy
         I/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uDdPzmnsldiiwWZYw9Tc+4pkR1I79p2wunSmR5EOuHU=;
        b=LgRL5kBSnlcomv5BefIMbqnv/qfi0lGEs9BszzSbT+ERGXGGLNIyFfQp+/mR/wk1cJ
         1mQJ+DX0o1Ggy/KIRm/Hvma8IQRd/8deXFRt2vjxoqyVNvkj64nvqPfsZC0FygWBRhze
         xH92nJDCl53ZmJKYINMfyLIPZPyXrDAJ7fjx80JcoMAT0UQ7IHwiwnWyi4Gl0qK4nDBq
         nBMMzvGuU/AszSJ7bPFdsta3qJd7B2Iq9vTbT59nZrd5qt12pHFF7CD5u54AfwIT5/f0
         gQPEbevzID8LEOtcLaCNeBRddQpk0fOJk8oiDe8krJCi8OLoE5HIslxD4JeBFUhSYW6g
         /mPw==
X-Gm-Message-State: AOAM533+eAhpeb6AujeR7UL/XIuEJ8fFBivUDnnZog4an5tj6OvK9JTU
        Qy8LEFnwDq+HE7VPxdF0Pr61p0Sdpw==
X-Google-Smtp-Source: ABdhPJzYkSW58QCkcpEOq3/kGoz+mEMFQdCooNvcfL9KO3VtbWDFZ+bjP35dKmX7b6dh5f3ymdwjMLwr0Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1a57:84a3:9bae:8070])
 (user=elver job=sendgmr) by 2002:a5d:4591:: with SMTP id p17mr11339950wrq.59.1631876892798;
 Fri, 17 Sep 2021 04:08:12 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:07:55 +0200
In-Reply-To: <20210917110756.1121272-1-elver@google.com>
Message-Id: <20210917110756.1121272-2-elver@google.com>
Mime-Version: 1.0
References: <20210917110756.1121272-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 2/3] kfence: limit currently covered allocations when pool
 nearly full
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

One of KFENCE's main design principles is that with increasing uptime,
allocation coverage increases sufficiently to detect previously
undetected bugs.

We have observed that frequent long-lived allocations of the same
source (e.g. pagecache) tend to permanently fill up the KFENCE pool
with increasing system uptime, thus breaking the above requirement.
The workaround thus far had been increasing the sample interval and/or
increasing the KFENCE pool size, but is no reliable solution.

To ensure diverse coverage of allocations, limit currently covered
allocations of the same source once pool utilization reaches 75% or
above. The effect is retaining reasonable allocation coverage when the
pool is close to full.

A side-effect is that this also limits frequent long-lived allocations
of the same source filling up the pool permanently.

Uniqueness of an allocation for coverage purposes is based on its
(partial) allocation stack trace (the source). A lossy hash map is
used to check if an allocation is covered; if the allocation is
currently covered, the allocation is skipped by KFENCE.

Testing was done using:

	(a) a synthetic workload that performs frequent long-lived
	    allocations (default config values + <10ms sample intervals
	    + smaller-than-default pool sizes), and

	(b) normal desktop workloads on an otherwise idle machine where
	    the problem was first reported (default config values).

In the case of (b) the observed result confirms that sampled allocation
rate no longer drops to zero after a few days of uptime, all while
"allocations skipped (covered)" are no more than 2% of total sampled
allocations.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c   | 120 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/kfence/kfence.h |   2 +
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 2755800f3e2a..3b78402d7a5e 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -11,11 +11,13 @@
 #include <linux/bug.h>
 #include <linux/debugfs.h>
 #include <linux/irq_work.h>
+#include <linux/jhash.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/moduleparam.h>
 #include <linux/random.h>
@@ -86,6 +88,28 @@ module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_sample_inte
 char *__kfence_pool __ro_after_init;
 EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
 
+/*
+ * A lossy hash map of allocation stack trace coverage: limits currently covered
+ * allocations of the same source filling up the pool when close to full.
+ *
+ * The required data fits in 64 bits, and therefore we can avoid a per-entry (or
+ * global) lock by simply storing each entry's data in an atomic64_t.
+ */
+union alloc_covered_entry {
+	struct {
+		u32 alloc_stack_hash;	/* stack trace hash */
+		u32 covered;		/* current coverage count */
+	};
+	u64 entry;
+};
+#define ALLOC_COVERED_SIZE (1 << const_ilog2(CONFIG_KFENCE_NUM_OBJECTS | 128)) /* >= 128 */
+#define ALLOC_COVERED_MASK (ALLOC_COVERED_SIZE - 1)
+static atomic64_t alloc_covered[ALLOC_COVERED_SIZE];
+/* Stack depth used to determine uniqueness of an allocation. */
+#define UNIQUE_ALLOC_STACK_DEPTH 8
+/* Pool usage threshold when currently covered allocations are skipped. */
+#define SKIP_COVERED_THRESHOLD ((CONFIG_KFENCE_NUM_OBJECTS * 3) / 4) /* 75% */
+
 /*
  * Per-object metadata, with one-to-one mapping of object metadata to
  * backing pages (in __kfence_pool).
@@ -114,6 +138,7 @@ enum kfence_counter_id {
 	KFENCE_COUNTER_BUGS,
 	KFENCE_COUNTER_SKIP_INCOMPAT,
 	KFENCE_COUNTER_SKIP_CAPACITY,
+	KFENCE_COUNTER_SKIP_COVERED,
 	KFENCE_COUNTER_COUNT,
 };
 static atomic_long_t counters[KFENCE_COUNTER_COUNT];
@@ -125,11 +150,73 @@ static const char *const counter_names[] = {
 	[KFENCE_COUNTER_BUGS]		= "total bugs",
 	[KFENCE_COUNTER_SKIP_INCOMPAT]	= "skipped allocations (incompatible)",
 	[KFENCE_COUNTER_SKIP_CAPACITY]	= "skipped allocations (capacity)",
+	[KFENCE_COUNTER_SKIP_COVERED]	= "skipped allocations (covered)",
 };
 static_assert(ARRAY_SIZE(counter_names) == KFENCE_COUNTER_COUNT);
 
 /* === Internals ============================================================ */
 
+static u32 get_alloc_stack_hash(void)
+{
+	unsigned long stack_entries[UNIQUE_ALLOC_STACK_DEPTH];
+	size_t num_entries;
+
+	num_entries = stack_trace_save(stack_entries, UNIQUE_ALLOC_STACK_DEPTH, 1);
+	return jhash(stack_entries, num_entries * sizeof(stack_entries[0]), 0);
+}
+
+/*
+ * Check if the allocation stack trace hash @alloc_stack_hash is contained in
+ * @alloc_covered and currently covered.
+ */
+static bool alloc_covered_contains(u32 alloc_stack_hash)
+{
+	union alloc_covered_entry entry;
+
+	if (!alloc_stack_hash)
+		return false;
+
+	entry.entry = (u64)atomic64_read(&alloc_covered[alloc_stack_hash & ALLOC_COVERED_MASK]);
+	return entry.alloc_stack_hash == alloc_stack_hash && entry.covered;
+}
+
+/*
+ * Adds (or subtracts) coverage count to entry corresponding to
+ * @alloc_stack_hash. If @alloc_stack_hash is not yet contained in
+ * @alloc_covered, resets (potentially evicting existing) entry.
+ */
+static void alloc_covered_add(u32 alloc_stack_hash, int val)
+{
+	union alloc_covered_entry old;
+	union alloc_covered_entry new;
+	atomic64_t *bucket;
+
+	if (!alloc_stack_hash)
+		return;
+
+	bucket = &alloc_covered[alloc_stack_hash & ALLOC_COVERED_MASK];
+	old.entry = (u64)atomic64_read(bucket);
+	new.alloc_stack_hash = alloc_stack_hash;
+	do {
+		if (val > 0) {
+			new.covered = old.alloc_stack_hash == alloc_stack_hash
+					? old.covered + val	/* increment */
+					: val;			/* evict/reset */
+		} else if (old.alloc_stack_hash == alloc_stack_hash && old.covered) {
+			new.covered = old.covered + val;
+		} else {
+			/*
+			 * Hash mismatch or covered has become zero. The latter
+			 * is possible if we race with:
+			 *	reset (!= alloc_stack_hash)
+			 *	 -> reset (== alloc_stack_hash)
+			 *	  -> decrement
+			 */
+			break;
+		}
+	} while (!atomic64_try_cmpxchg_relaxed(bucket, (s64 *)&old.entry, (s64)new.entry));
+}
+
 static bool kfence_protect(unsigned long addr)
 {
 	return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true));
@@ -261,7 +348,8 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
 	}
 }
 
-static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
+static void *
+kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp, u32 alloc_stack_hash)
 {
 	struct kfence_metadata *meta = NULL;
 	unsigned long flags;
@@ -322,6 +410,8 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	/* Pairs with READ_ONCE() in kfence_shutdown_cache(). */
 	WRITE_ONCE(meta->cache, cache);
 	meta->size = size;
+	meta->alloc_stack_hash = alloc_stack_hash;
+
 	for_each_canary(meta, set_canary_byte);
 
 	/* Set required struct page fields. */
@@ -334,6 +424,8 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 
 	raw_spin_unlock_irqrestore(&meta->lock, flags);
 
+	alloc_covered_add(alloc_stack_hash, 1);
+
 	/* Memory initialization. */
 
 	/*
@@ -362,6 +454,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool zombie)
 {
 	struct kcsan_scoped_access assert_page_exclusive;
+	u32 alloc_stack_hash;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&meta->lock, flags);
@@ -404,8 +497,13 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 	/* Mark the object as freed. */
 	metadata_update_state(meta, KFENCE_OBJECT_FREED);
 
+	alloc_stack_hash = meta->alloc_stack_hash;
+	meta->alloc_stack_hash = 0;
+
 	raw_spin_unlock_irqrestore(&meta->lock, flags);
 
+	alloc_covered_add(alloc_stack_hash, -1);
+
 	/* Protect to detect use-after-frees. */
 	kfence_protect((unsigned long)addr);
 
@@ -744,6 +842,8 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 
 void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 {
+	u32 alloc_stack_hash;
+
 	/*
 	 * Perform size check before switching kfence_allocation_gate, so that
 	 * we don't disable KFENCE without making an allocation.
@@ -788,7 +888,23 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (!READ_ONCE(kfence_enabled))
 		return NULL;
 
-	return kfence_guarded_alloc(s, size, flags);
+	/*
+	 * Do expensive check for coverage of allocation in slow-path after
+	 * allocation_gate has already become non-zero, even though it might
+	 * mean not making any allocation within a given sample interval.
+	 *
+	 * This ensures reasonable allocation coverage when the pool is almost
+	 * full, including avoiding long-lived allocations of the same source
+	 * filling up the pool (e.g. pagecache allocations).
+	 */
+	alloc_stack_hash = get_alloc_stack_hash();
+	if (atomic_long_read(&counters[KFENCE_COUNTER_ALLOCATED]) > SKIP_COVERED_THRESHOLD &&
+	    alloc_covered_contains(alloc_stack_hash)) {
+		atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_COVERED]);
+		return NULL;
+	}
+
+	return kfence_guarded_alloc(s, size, flags, alloc_stack_hash);
 }
 
 size_t kfence_ksize(const void *addr)
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index c1f23c61e5f9..2a2d5de9d379 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -87,6 +87,8 @@ struct kfence_metadata {
 	/* Allocation and free stack information. */
 	struct kfence_track alloc_track;
 	struct kfence_track free_track;
+	/* For updating alloc_covered on frees. */
+	u32 alloc_stack_hash;
 };
 
 extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
-- 
2.33.0.464.g1972c5931b-goog

