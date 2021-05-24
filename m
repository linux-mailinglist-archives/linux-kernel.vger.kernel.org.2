Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F6538F658
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhEXXm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:42:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhEXXmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN0hphSDK3nKGkgVbOG2HToirz6jOZ+xMG1Pe64zWc0=;
        b=MVxXWx6D1MTXp2qaoo3uTuNEVRsDDvqy06ITXd8U/CqSLI4D+VI9SwSCKhiPSyMd3ulswG
        peDsQ/6LboCYbhmRaOVOC2enK8VM/T3zE20Nn6gGAPmZ4rlmFmYru+kd34SohRxEb7gHmu
        nY0ljCx1EijQqDlxnfmKENFAp3rmdSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN0hphSDK3nKGkgVbOG2HToirz6jOZ+xMG1Pe64zWc0=;
        b=tt6FZ545rcVOWKtwHEwUbFmUhd5T21riPSQFLMJtgWKBz2Hrzfagfloy5ujAMXE8Qzh6fb
        qvuK3nTxUX+W9yCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36533AF27;
        Mon, 24 May 2021 23:40:48 +0000 (UTC)
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
Subject: [RFC 09/26] mm, slub: move disabling/enabling irqs to ___slab_alloc()
Date:   Tue, 25 May 2021 01:39:29 +0200
Message-Id: <20210524233946.20352-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
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
from becoming invalid via migrate_disable(). This does not protect against
access preemption, which is still done by disabled irq for most of
___slab_alloc(). As the small immediate benefit, slab_out_of_memory() call from
___slab_alloc() is now done with irqs enabled.

kmem_cache_alloc_bulk() disables irqs for its fastpath and then re-enables them
before calling ___slab_alloc(), which then disables them at its discretion. The
whole kmem_cache_alloc_bulk() operation also disables cpu migration.

When  ___slab_alloc() calls new_slab() to allocate a new page, re-enable
preemption, because new_slab() will re-enable interrupts in contexts that allow
blocking.

The patch itself will thus increase overhead a bit due to disabled migration
and increased disabling/enabling irqs in kmem_cache_alloc_bulk(), but that will
be gradually improved in the following patches.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 06f30c9ad361..c5f4f9282496 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2631,7 +2631,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
  * we need to allocate a new slab. This is the slowest path since it involves
  * a call to the page allocator and the setup of a new slab.
  *
- * Version of __slab_alloc to use when we know that interrupts are
+ * Version of __slab_alloc to use when we know that preemption is
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
@@ -2639,9 +2639,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 {
 	void *freelist;
 	struct page *page;
+	unsigned long flags;
 
 	stat(s, ALLOC_SLOWPATH);
 
+	local_irq_save(flags);
 	page = c->page;
 	if (!page) {
 		/*
@@ -2704,6 +2706,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	VM_BUG_ON(!c->page->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
+	local_irq_restore(flags);
 	return freelist;
 
 new_slab:
@@ -2721,14 +2724,17 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto check_new_page;
 	}
 
+	migrate_enable();
 	page = new_slab(s, gfpflags, node);
+	migrate_disable();
+	c = this_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!page)) {
+		local_irq_restore(flags);
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
 
-	c = raw_cpu_ptr(s->cpu_slab);
 	if (c->page)
 		flush_slab(s, c);
 
@@ -2768,6 +2774,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 return_single:
 
 	deactivate_slab(s, page, get_freepointer(s, freelist), c);
+	local_irq_restore(flags);
 	return freelist;
 }
 
@@ -2779,20 +2786,19 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			  unsigned long addr, struct kmem_cache_cpu *c)
 {
 	void *p;
-	unsigned long flags;
 
-	local_irq_save(flags);
+	migrate_disable();
 #ifdef CONFIG_PREEMPTION
 	/*
 	 * We may have been preempted and rescheduled on a different
-	 * cpu before disabling interrupts. Need to reload cpu area
+	 * cpu before disabling preemption. Need to reload cpu area
 	 * pointer.
 	 */
 	c = this_cpu_ptr(s->cpu_slab);
 #endif
 
 	p = ___slab_alloc(s, gfpflags, node, addr, c);
-	local_irq_restore(flags);
+	migrate_enable();
 	return p;
 }
 
@@ -3312,8 +3318,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * IRQs, which protects against PREEMPT and interrupts
 	 * handlers invoking normal fastpath.
 	 */
-	local_irq_disable();
+	migrate_disable();
 	c = this_cpu_ptr(s->cpu_slab);
+	local_irq_disable();
 
 	for (i = 0; i < size; i++) {
 		void *object = kfence_alloc(s, s->object_size, flags);
@@ -3334,6 +3341,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 */
 			c->tid = next_tid(c->tid);
 
+			local_irq_enable();
+
 			/*
 			 * Invoking slow path likely have side-effect
 			 * of re-populating per CPU c->freelist
@@ -3346,6 +3355,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			c = this_cpu_ptr(s->cpu_slab);
 			maybe_wipe_obj_freeptr(s, p[i]);
 
+			local_irq_disable();
+
 			continue; /* goto for-loop */
 		}
 		c->freelist = get_freepointer(s, object);
@@ -3354,6 +3365,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 	c->tid = next_tid(c->tid);
 	local_irq_enable();
+	migrate_enable();
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
-- 
2.31.1

