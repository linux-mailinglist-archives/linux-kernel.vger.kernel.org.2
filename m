Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D533E17E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbhHEPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:25:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbhHEPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C39FE20257;
        Thu,  5 Aug 2021 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GD0bm+3Isbs8mBqoJ+DSeyXp/F8XNigpZaahIkQUqtE=;
        b=QEOyl/68t9NMba846T1R3as5cotlxC38sIkRv2brAoT6+jOeIwydpSOti+8K1S48RgO8+F
        /1K5m8tpqqPshIaL3ZesMSDu8wkqHRzak9RXbboQ/OyHTgCrwN8L4g2bJlGL96I9QZ7rxp
        OUhM9c3WTqGzuKYfMKFg0gfs1luJiIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GD0bm+3Isbs8mBqoJ+DSeyXp/F8XNigpZaahIkQUqtE=;
        b=U3QzB56c1v0+kbiPEApEW+YzAtJr/6VozVVqhLUT689ZAMDDU7pvWeYVVOdIsFm3kSHMfg
        /pztz9Z3e9hL7BAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 932C513DAC;
        Thu,  5 Aug 2021 15:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oDFMI6oBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:10 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to local_lock
Date:   Thu,  5 Aug 2021 17:20:00 +0200
Message-Id: <20210805152000.12817-36-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embed local_lock into struct kmem_cpu_slab and use the irq-safe versions of
local_lock instead of plain local_irq_save/restore. On !PREEMPT_RT that's
equivalent, with better lockdep visibility. On PREEMPT_RT that means better
preemption.

However, the cost on PREEMPT_RT is the loss of lockless fast paths which only
work with cpu freelist. Those are designed to detect and recover from being
preempted by other conflicting operations (both fast or slow path), but the
slow path operations assume they cannot be preempted by a fast path operation,
which is guaranteed naturally with disabled irqs. With local locks on
PREEMPT_RT, the fast paths now also need to take the local lock to avoid races.

In the allocation fastpath slab_alloc_node() we can just defer to the slowpath
__slab_alloc() which also works with cpu freelist, but under the local lock.
In the free fastpath do_slab_free() we have to add a new local lock protected
version of freeing to the cpu freelist, as the existing slowpath only works
with the page freelist.

Also update the comment about locking scheme in SLUB to reflect changes done
by this series.

[ Mike Galbraith <efault@gmx.de>: use local_lock() without irq in PREEMPT_RT
  scope; debugging of RT crashes resulting in put_cpu_partial() locking changes ]
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slub_def.h |   2 +
 mm/slub.c                | 146 ++++++++++++++++++++++++++++++---------
 2 files changed, 115 insertions(+), 33 deletions(-)

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
index 690e762912b7..8052334fcc56 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -46,13 +46,21 @@
 /*
  * Lock order:
  *   1. slab_mutex (Global Mutex)
- *   2. node->list_lock
- *   3. slab_lock(page) (Only on some arches and for debugging)
+ *   2. node->list_lock (Spinlock)
+ *   3. kmem_cache->cpu_slab->lock (Local lock)
+ *   4. slab_lock(page) (Only on some arches or for debugging)
+ *   5. object_map_lock (Only for debugging)
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
@@ -61,6 +69,8 @@
  *	C. page->objects	-> Number of objects in page
  *	D. page->frozen		-> frozen state
  *
+ *   Frozen slabs
+ *
  *   If a slab is frozen then it is exempt from list management. It is not
  *   on any list except per cpu partial list. The processor that froze the
  *   slab is the one who can perform list operations on the page. Other
@@ -68,6 +78,8 @@
  *   froze the slab is the only one that can retrieve the objects from the
  *   page's freelist.
  *
+ *   list_lock
+ *
  *   The list_lock protects the partial and full list on each node and
  *   the partial slab counter. If taken then no new slabs may be added or
  *   removed from the lists nor make the number of partial slabs be modified.
@@ -79,10 +91,36 @@
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
+ *   On PREEMPT_RT, the local lock does not actually disable irqs (and thus
+ *   prevent the lockless operations), so fastpath operations also need to take
+ *   the lock and are no longer lockless.
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
+ *   In addition, preemption (or migration on PREEMPT_RT) is disabled in the
+ *   allocation slowpath, bulk allocation, and put_cpu_partial(), so that the
+ *   local cpu doesn't change in the process and e.g. the kmem_cache_cpu pointer
+ *   doesn't have to be revalidated in each section protected by the local lock.
  *
  * SLUB assigns one slab for allocation to each processor.
  * Allocations only occur from these slabs called cpu slabs.
@@ -2228,9 +2266,13 @@ static inline void note_cmpxchg_failure(const char *n,
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
@@ -2441,10 +2483,10 @@ static void unfreeze_partials(struct kmem_cache *s)
 	struct page *partial_page;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 	partial_page = this_cpu_read(s->cpu_slab->partial);
 	this_cpu_write(s->cpu_slab->partial, NULL);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
 	if (partial_page)
 		__unfreeze_partials(s, partial_page);
@@ -2477,7 +2519,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	int pages = 0;
 	int pobjects = 0;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 
 	oldpage = this_cpu_read(s->cpu_slab->partial);
 
@@ -2505,7 +2547,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 	this_cpu_write(s->cpu_slab->partial, page);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
 	if (page_to_unfreeze) {
 		__unfreeze_partials(s, page_to_unfreeze);
@@ -2529,7 +2571,7 @@ static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
 	struct page *page;
 
 	if (lock)
-		local_irq_save(flags);
+		local_lock_irqsave(&s->cpu_slab->lock, flags);
 
 	freelist = c->freelist;
 	page = c->page;
@@ -2539,7 +2581,7 @@ static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
 	c->tid = next_tid(c->tid);
 
 	if (lock)
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
 	if (page)
 		deactivate_slab(s, page, freelist);
@@ -2827,9 +2869,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto deactivate_slab;
 
 	/* must check again c->page in case we got preempted and it changed */
-	local_irq_save(flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 	if (unlikely(page != c->page)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_page;
 	}
 	freelist = c->freelist;
@@ -2840,7 +2882,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	if (!freelist) {
 		c->page = NULL;
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2849,7 +2891,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 load_freelist:
 
-	lockdep_assert_irqs_disabled();
+#ifdef CONFIG_PREEMPT_RT
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
+#else
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
+#endif
 
 	/*
 	 * freelist is pointing to the list of objects to be used.
@@ -2859,39 +2905,39 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
 		if (unlikely(!slub_percpu_partial(c))) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 			/* we were preempted and partial list got empty */
 			goto new_objects;
 		}
 
 		page = c->page = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		stat(s, CPU_PARTIAL_ALLOC);
 		goto redo;
 	}
@@ -2944,7 +2990,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 retry_load_page:
 
-	local_irq_save(flags);
+	local_lock_irqsave(&s->cpu_slab->lock, flags);
 	if (unlikely(c->page)) {
 		void *flush_freelist = c->freelist;
 		struct page *flush_page = c->page;
@@ -2953,7 +2999,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		c->freelist = NULL;
 		c->tid = next_tid(c->tid);
 
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
 		deactivate_slab(s, flush_page, flush_freelist);
 
@@ -3072,7 +3118,15 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 
 	object = c->freelist;
 	page = c->page;
-	if (unlikely(!object || !page || !node_match(page, node))) {
+	/*
+	 * We cannot use the lockless fastpath on PREEMPT_RT because if a
+	 * slowpath has taken the local_lock_irqsave(), it is not protected
+	 * against a fast path operation in an irq handler. So we need to take
+	 * the slow path which uses local_lock. It is still relatively fast if
+	 * there is a suitable cpu freelist.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
+	    unlikely(!object || !page || !node_match(page, node))) {
 		object = __slab_alloc(s, gfpflags, node, addr, c);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
@@ -3332,6 +3386,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	barrier();
 
 	if (likely(page == c->page)) {
+#ifndef CONFIG_PREEMPT_RT
 		void **freelist = READ_ONCE(c->freelist);
 
 		set_freepointer(s, tail_obj, freelist);
@@ -3344,6 +3399,31 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 			note_cmpxchg_failure("slab_free", s, tid);
 			goto redo;
 		}
+#else /* CONFIG_PREEMPT_RT */
+		/*
+		 * We cannot use the lockless fastpath on PREEMPT_RT because if
+		 * a slowpath has taken the local_lock_irqsave(), it is not
+		 * protected against a fast path operation in an irq handler. So
+		 * we need to take the local_lock. We shouldn't simply defer to
+		 * __slab_free() as that wouldn't use the cpu freelist at all.
+		 */
+		void **freelist;
+
+		local_lock(&s->cpu_slab->lock);
+		c = this_cpu_ptr(s->cpu_slab);
+		if (unlikely(page != c->page)) {
+			local_unlock(&s->cpu_slab->lock);
+			goto redo;
+		}
+		tid = c->tid;
+		freelist = c->freelist;
+
+		set_freepointer(s, tail_obj, freelist);
+		c->freelist = head;
+		c->tid = next_tid(tid);
+
+		local_unlock(&s->cpu_slab->lock);
+#endif
 		stat(s, FREE_FASTPATH);
 	} else
 		__slab_free(s, page, head, tail_obj, cnt, addr);
@@ -3522,7 +3602,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * handlers invoking normal fastpath.
 	 */
 	c = slub_get_cpu_ptr(s->cpu_slab);
-	local_irq_disable();
+	local_lock_irq(&s->cpu_slab->lock);
 
 	for (i = 0; i < size; i++) {
 		void *object = kfence_alloc(s, s->object_size, flags);
@@ -3543,7 +3623,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 */
 			c->tid = next_tid(c->tid);
 
-			local_irq_enable();
+			local_unlock_irq(&s->cpu_slab->lock);
 
 			/*
 			 * Invoking slow path likely have side-effect
@@ -3557,7 +3637,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			c = this_cpu_ptr(s->cpu_slab);
 			maybe_wipe_obj_freeptr(s, p[i]);
 
-			local_irq_disable();
+			local_lock_irq(&s->cpu_slab->lock);
 
 			continue; /* goto for-loop */
 		}
@@ -3566,7 +3646,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 		maybe_wipe_obj_freeptr(s, p[i]);
 	}
 	c->tid = next_tid(c->tid);
-	local_irq_enable();
+	local_unlock_irq(&s->cpu_slab->lock);
 	slub_put_cpu_ptr(s->cpu_slab);
 
 	/*
-- 
2.32.0

