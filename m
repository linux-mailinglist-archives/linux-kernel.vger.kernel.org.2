Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4B38F66B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhEXXoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:44:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhEXXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwQzm8eUz5Nw1xMuBtalv1Pc5Daif/yGnQTklAGkBIU=;
        b=gJJsfqaWBODXPdCASFx1YWBaz5sbou+xO+l+Le89QGr4sYcYjUkJxY7/NUYch4PUKpJnxb
        aTYJ+0RwAegFdrRy9pRkEXmaG2pImBBeaVSp/mvSzFrDYI1C2kPXnAasGzyZjQ4EckAa05
        UXLmgoybIIKG06p82wzbHelfrUFPsLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899650;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwQzm8eUz5Nw1xMuBtalv1Pc5Daif/yGnQTklAGkBIU=;
        b=2KXnSXyGR6qanADvziwgYbtW+dz7t6+KvCqQPauG9Imf+nZ14ocvgyDpr0UHutghhVUhBk
        Nsa4LeYOzOtypnCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B484AF5B;
        Mon, 24 May 2021 23:40:50 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 26/26] mm, slub: convert kmem_cpu_slab protection to local_lock
Date:   Tue, 25 May 2021 01:39:46 +0200
Message-Id: <20210524233946.20352-27-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embed local_lock into struct kmem_cpu_slab and use the irq-safe versions of
local_lock instead of plain local_irq_save/restore. On !PREEMPT_RT that's
equivalent, with better lockdep visibility. On PREEMPT_RT that means better
preemption.

Also update the comment about locking scheme in SLUB to reflect changes done
by this series.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h |  2 +
 mm/slub.c                | 90 ++++++++++++++++++++++++++++------------
 2 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index dcde82a4434c..b5bcac29b979 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -10,6 +10,7 @@
 #include <linux/kfence.h>
 #include <linux/kobject.h>
 #include <linux/reciprocal_div.h>
+#include <linux/local_lock.h>
 
 enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
@@ -41,6 +42,7 @@ enum stat_item {
 	NR_SLUB_STAT_ITEMS };
 
 struct kmem_cache_cpu {
+	local_lock_t lock;	/* Protects the fields below except stat */
 	void **freelist;	/* Pointer to next available object */
 	unsigned long tid;	/* Globally unique transaction id */
 	struct page *page;	/* The slab from which we are allocating */
diff --git a/mm/slub.c b/mm/slub.c
index 8818c210cb97..5455c6bda997 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -43,13 +43,22 @@
 /*
  * Lock order:
  *   1. slab_mutex (Global Mutex)
- *   2. node->list_lock
+ *   2. node->list_lock (Spinlock)
+ *	OR
+ *	kmem_cache->cpu_slab->lock (Local lock)
  *   3. slab_lock(page) (Only on some arches and for debugging)
+ *   4. object_map_lock (Only for debugging)
  *
  *   slab_mutex
  *
  *   The role of the slab_mutex is to protect the list of all the slabs
  *   and to synchronize major metadata changes to slab cache structures.
+ *   Also synchronizes memory hotplug callbacks.
+ *
+ *   slab_lock
+ *
+ *   The slab_lock is a wrapper around the page lock, thus it is a bit
+ *   spinlock.
  *
  *   The slab_lock is only used for debugging and on arches that do not
  *   have the ability to do a cmpxchg_double. It only protects:
@@ -65,6 +74,8 @@
  *   froze the slab is the only one that can retrieve the objects from the
  *   page's freelist.
  *
+ *   list_lock
+ *
  *   The list_lock protects the partial and full list on each node and
  *   the partial slab counter. If taken then no new slabs may be added or
  *   removed from the lists nor make the number of partial slabs be modified.
@@ -76,10 +87,33 @@
  *   slabs, operations can continue without any centralized lock. F.e.
  *   allocating a long series of objects that fill up slabs does not require
  *   the list lock.
- *   Interrupts are disabled during allocation and deallocation in order to
- *   make the slab allocator safe to use in the context of an irq. In addition
- *   interrupts are disabled to ensure that the processor does not change
- *   while handling per_cpu slabs, due to kernel preemption.
+ *
+ *   cpu_slab->lock local lock
+ *
+ *   This locks protect slowpath manipulation of all kmem_cache_cpu fields
+ *   except the stat counters. This is a percpu structure manipulated only by
+ *   the local cpu, so the lock protects against being preempted or interrupted
+ *   by an irq. Fast path operations rely on lockless operations instead.
+ *
+ *   lockless fastpaths
+ *
+ *   The fast path allocation (slab_alloc_node()) and freeing (do_slab_free())
+ *   are fully lockless when satisfied from the percpu slab (and when
+ *   cmpxchg_double is possible to use, otherwise slab_lock is taken).
+ *   They also don't disable preemption or migration or irqs. They rely on
+ *   the transaction id (tid) field to detect being preempted or moved to
+ *   another cpu.
+ *
+ *   irq, preemption, migration considerations
+ *
+ *   Interrupts are disabled as part of list_lock or local_lock operations, or
+ *   around the slab_lock operation, in order to make the slab allocator safe
+ *   to use in the context of an irq.
+ *
+ *   In addition, migration is disabled in the allocation slowpath, bulk
+ *   allocation, and put_cpu_partial(), so that the local cpu doesn't change in
+ *   the process and e.g. the kmem_cache_cpu pointer doesn't have to be
+ *   revalidated in each section protected by the local lock.
  *
  * SLUB assigns one slab for allocation to each processor.
  * Allocations only occur from these slabs called cpu slabs.
@@ -427,7 +461,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 			page->freelist = freelist_new;
 			page->counters = counters_new;
 			slab_unlock(page);
-			local_irq_restore(flags);
+			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 			return true;
 		}
 		slab_unlock(page);
@@ -2157,9 +2191,13 @@ static inline void note_cmpxchg_failure(const char *n,
 static void init_kmem_cache_cpus(struct kmem_cache *s)
 {
 	int cpu;
+	struct kmem_cache_cpu *c;
 
-	for_each_possible_cpu(cpu)
-		per_cpu_ptr(s->cpu_slab, cpu)->tid = init_tid(cpu);
+	for_each_possible_cpu(cpu) {
+		c = per_cpu_ptr(s->cpu_slab, cpu);
+		local_lock_init(&c->lock);
+		c->tid = init_tid(cpu);
+	}
 }
 
 /*
@@ -2708,9 +2746,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto deactivate_slab;
 
 	/* must check again c->page in case of IRQ */
-	local_irq_save(flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 	if (unlikely(page != c->page)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_page;
 	}
 	freelist = c->freelist;
@@ -2721,7 +2759,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	if (!freelist) {
 		c->page = NULL;
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2737,37 +2775,37 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	VM_BUG_ON(!c->page->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 	return freelist;
 
 deactivate_slab:
-	local_irq_save(flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 	if (page != c->page) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_page;
 	}
 	freelist = c->freelist;
 	c->page = NULL;
 	c->freelist = NULL;
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 	deactivate_slab(s, page, freelist);
 
 new_slab:
 
 	if (slub_percpu_partial(c)) {
-		local_irq_save(flags);
+		local_lock_irqsave(&s->cpu_slab->lock, flags);
 		if (unlikely(c->page)) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 			goto reread_page;
 		}
 		if (unlikely(!slub_percpu_partial(c))) { /* stolen by IRQ? */
-			local_irq_restore(flags);
+			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 			goto new_objects;
 		}
 
 		page = c->page = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		stat(s, CPU_PARTIAL_ALLOC);
 		goto redo;
 	}
@@ -2820,7 +2858,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto return_single;
 
 retry_load_page:
-	local_irq_save(flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 	if (unlikely(c->page)) {
 		void *flush_freelist = c->freelist;
 		struct page *flush_page = c->page;
@@ -2829,7 +2867,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		c->freelist = NULL;
 		c->tid = next_tid(c->tid);
 
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
 		deactivate_slab(s, flush_page, flush_freelist);
 
@@ -3389,7 +3427,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 */
 	migrate_disable();
 	c = this_cpu_ptr(s->cpu_slab);
-	local_irq_disable();
+	local_lock_irq(&s->cpu_slab->lock);
 
 	for (i = 0; i < size; i++) {
 		void *object = kfence_alloc(s, s->object_size, flags);
@@ -3410,7 +3448,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 */
 			c->tid = next_tid(c->tid);
 
-			local_irq_enable();
+			local_unlock_irq(&s->cpu_slab->lock);
 
 			/*
 			 * Invoking slow path likely have side-effect
@@ -3424,7 +3462,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			c = this_cpu_ptr(s->cpu_slab);
 			maybe_wipe_obj_freeptr(s, p[i]);
 
-			local_irq_disable();
+			local_lock_irq(&s->cpu_slab->lock);
 
 			continue; /* goto for-loop */
 		}
@@ -3433,7 +3471,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 		maybe_wipe_obj_freeptr(s, p[i]);
 	}
 	c->tid = next_tid(c->tid);
-	local_irq_enable();
+	local_unlock_irq(&s->cpu_slab->lock);
 	migrate_enable();
 
 	/*
@@ -3444,7 +3482,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 				slab_want_init_on_alloc(flags, s));
 	return i;
 error:
-	local_irq_enable();
+	local_unlock_irq(&s->cpu_slab->lock);
 	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
-- 
2.31.1

