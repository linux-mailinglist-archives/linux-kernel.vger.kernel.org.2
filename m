Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADB33F4CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhHWPAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:00:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51748 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD06021FE4;
        Mon, 23 Aug 2021 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lg82srUkTk4tLfdHE57Lzl+DmeGOtGtZsKtZdZRkMAA=;
        b=JrX3sdnNY9FdRqUxzo7GrH0gu8cDgISz4Wfh7kUhNdFLsklM72dKR3EEVanfFeTTGel2qm
        USy7/i7OMXFsANBAflEMzm3T1vLpprYKrLpc1KehvizbJgq+PzKx4TmdywfkApFAPFne+/
        XXxcAbSLI00N5dIY5CjvINUxRhvqevM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lg82srUkTk4tLfdHE57Lzl+DmeGOtGtZsKtZdZRkMAA=;
        b=W/LnqVgL8kvOYdDA4kDE4C+hXxKEv/M24xV7um4mBllwKVE6NsT/fZ7fcVKS3+QwiC08xG
        L+3WvTEV4x1cbqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A36DE13BE0;
        Mon, 23 Aug 2021 14:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aNRLJ5+3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:39 +0000
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
Subject: [PATCH v5 12/35] mm, slub: move disabling/enabling irqs to ___slab_alloc()
Date:   Mon, 23 Aug 2021 16:58:03 +0200
Message-Id: <20210823145826.3857-13-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __slab_alloc() disables irqs around the whole ___slab_alloc().  This
includes cases where this is not needed, such as when the allocation ends up in
the page allocator and has to awkwardly enable irqs back based on gfp flags.
Also the whole kmem_cache_alloc_bulk() is executed with irqs disabled even when
it hits the __slab_alloc() slow path, and long periods with disabled interrupts
are undesirable.

As a first step towards reducing irq disabled periods, move irq handling into
___slab_alloc(). Callers will instead prevent the s->cpu_slab percpu pointer
from becoming invalid via get_cpu_ptr(), thus preempt_disable(). This does not
protect against modification by an irq handler, which is still done by disabled
irq for most of ___slab_alloc(). As a small immediate benefit,
slab_out_of_memory() from ___slab_alloc() is now called with irqs enabled.

kmem_cache_alloc_bulk() disables irqs for its fastpath and then re-enables them
before calling ___slab_alloc(), which then disables them at its discretion. The
whole kmem_cache_alloc_bulk() operation also disables preemption.

When  ___slab_alloc() calls new_slab() to allocate a new page, re-enable
preemption, because new_slab() will re-enable interrupts in contexts that allow
blocking (this will be improved by later patches).

The patch itself will thus increase overhead a bit due to disabled preemption
(on configs where it matters) and increased disabling/enabling irqs in
kmem_cache_alloc_bulk(), but that will be gradually improved in the following
patches.

Note in __slab_alloc() we need to change the #ifdef CONFIG_PREEMPT guard to
CONFIG_PREEMPT_COUNT to make sure preempt disable/enable is properly paired in
all configurations. On configs without involuntary preemption and debugging
the re-read of kmem_cache_cpu pointer is still compiled out as it was before.

[ Mike Galbraith <efault@gmx.de>: Fix kmem_cache_alloc_bulk() error path ]
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f65d75077ce..31f946e03823 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2656,7 +2656,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
  * we need to allocate a new slab. This is the slowest path since it involves
  * a call to the page allocator and the setup of a new slab.
  *
- * Version of __slab_alloc to use when we know that interrupts are
+ * Version of __slab_alloc to use when we know that preemption is
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
@@ -2664,9 +2664,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 {
 	void *freelist;
 	struct page *page;
+	unsigned long flags;
 
 	stat(s, ALLOC_SLOWPATH);
 
+	local_irq_save(flags);
 	page = c->page;
 	if (!page) {
 		/*
@@ -2729,6 +2731,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	VM_BUG_ON(!c->page->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
+	local_irq_restore(flags);
 	return freelist;
 
 new_slab:
@@ -2746,14 +2749,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto check_new_page;
 	}
 
+	put_cpu_ptr(s->cpu_slab);
 	page = new_slab(s, gfpflags, node);
+	c = get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!page)) {
+		local_irq_restore(flags);
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
 
-	c = raw_cpu_ptr(s->cpu_slab);
 	if (c->page)
 		flush_slab(s, c);
 
@@ -2793,31 +2798,33 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 return_single:
 
 	deactivate_slab(s, page, get_freepointer(s, freelist), c);
+	local_irq_restore(flags);
 	return freelist;
 }
 
 /*
- * Another one that disabled interrupt and compensates for possible
- * cpu changes by refetching the per cpu area pointer.
+ * A wrapper for ___slab_alloc() for contexts where preemption is not yet
+ * disabled. Compensates for possible cpu changes by refetching the per cpu area
+ * pointer.
  */
 static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			  unsigned long addr, struct kmem_cache_cpu *c)
 {
 	void *p;
-	unsigned long flags;
 
-	local_irq_save(flags);
-#ifdef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_COUNT
 	/*
 	 * We may have been preempted and rescheduled on a different
-	 * cpu before disabling interrupts. Need to reload cpu area
+	 * cpu before disabling preemption. Need to reload cpu area
 	 * pointer.
 	 */
-	c = this_cpu_ptr(s->cpu_slab);
+	c = get_cpu_ptr(s->cpu_slab);
 #endif
 
 	p = ___slab_alloc(s, gfpflags, node, addr, c);
-	local_irq_restore(flags);
+#ifdef CONFIG_PREEMPT_COUNT
+	put_cpu_ptr(s->cpu_slab);
+#endif
 	return p;
 }
 
@@ -3345,8 +3352,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * IRQs, which protects against PREEMPT and interrupts
 	 * handlers invoking normal fastpath.
 	 */
+	c = get_cpu_ptr(s->cpu_slab);
 	local_irq_disable();
-	c = this_cpu_ptr(s->cpu_slab);
 
 	for (i = 0; i < size; i++) {
 		void *object = kfence_alloc(s, s->object_size, flags);
@@ -3367,6 +3374,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 */
 			c->tid = next_tid(c->tid);
 
+			local_irq_enable();
+
 			/*
 			 * Invoking slow path likely have side-effect
 			 * of re-populating per CPU c->freelist
@@ -3379,6 +3388,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			c = this_cpu_ptr(s->cpu_slab);
 			maybe_wipe_obj_freeptr(s, p[i]);
 
+			local_irq_disable();
+
 			continue; /* goto for-loop */
 		}
 		c->freelist = get_freepointer(s, object);
@@ -3387,6 +3398,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 	c->tid = next_tid(c->tid);
 	local_irq_enable();
+	put_cpu_ptr(s->cpu_slab);
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
@@ -3396,7 +3408,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 				slab_want_init_on_alloc(flags, s));
 	return i;
 error:
-	local_irq_enable();
+	put_cpu_ptr(s->cpu_slab);
 	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
-- 
2.32.0

