Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303723A12F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhFILmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46982 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhFILl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4CDC1FD66;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooHJLHsolbs8E/VsJWSGGh6r7etfcAEkF/VGN97pHs8=;
        b=2FEH2m+jM7t9BeLHL/Td6f3/iPF6vDWFE8O+HEgdPnkbkLdupKHuf3iMD3WRfepF1/SXou
        78IPycdJLQ6jBbmv0rwGpm5Ruv4I3Fw76WkDXDaxMBeYxrrM3GpoXKVKaHutEws0EbRdk1
        FE04A1MD2LKKfljjGhEVVuJjTdawPpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooHJLHsolbs8E/VsJWSGGh6r7etfcAEkF/VGN97pHs8=;
        b=LB74xd0RZSX+bW5kgk90zniYjKzdgnWOXfaverf0Zf5WSXwCuUKZ39fe2hWw1GMto0X9Ja
        R9014SoOeFha/JBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B2714118DD;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooHJLHsolbs8E/VsJWSGGh6r7etfcAEkF/VGN97pHs8=;
        b=2FEH2m+jM7t9BeLHL/Td6f3/iPF6vDWFE8O+HEgdPnkbkLdupKHuf3iMD3WRfepF1/SXou
        78IPycdJLQ6jBbmv0rwGpm5Ruv4I3Fw76WkDXDaxMBeYxrrM3GpoXKVKaHutEws0EbRdk1
        FE04A1MD2LKKfljjGhEVVuJjTdawPpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooHJLHsolbs8E/VsJWSGGh6r7etfcAEkF/VGN97pHs8=;
        b=LB74xd0RZSX+bW5kgk90zniYjKzdgnWOXfaverf0Zf5WSXwCuUKZ39fe2hWw1GMto0X9Ja
        R9014SoOeFha/JBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mCERK3WowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:33 +0000
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
Subject: [RFC v2 12/34] mm, slub: move disabling/enabling irqs to ___slab_alloc()
Date:   Wed,  9 Jun 2021 13:38:41 +0200
Message-Id: <20210609113903.1421-13-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
and increased disabling/enabling irqs in kmem_cache_alloc_bulk(), but that will
be gradually improved in the following patches.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6d6a9a69db8a..4800d768d0d3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2610,7 +2610,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
  * we need to allocate a new slab. This is the slowest path since it involves
  * a call to the page allocator and the setup of a new slab.
  *
- * Version of __slab_alloc to use when we know that interrupts are
+ * Version of __slab_alloc to use when we know that preemption is
  * already disabled (which is the case for bulk allocation).
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
@@ -2618,9 +2618,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 {
 	void *freelist;
 	struct page *page;
+	unsigned long flags;
 
 	stat(s, ALLOC_SLOWPATH);
 
+	local_irq_save(flags);
 	page = c->page;
 	if (!page) {
 		/*
@@ -2683,6 +2685,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	VM_BUG_ON(!c->page->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
+	local_irq_restore(flags);
 	return freelist;
 
 new_slab:
@@ -2700,14 +2703,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
 
@@ -2747,31 +2752,33 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
 #ifdef CONFIG_PREEMPTION
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
+#ifdef CONFIG_PREEMPTION
+	put_cpu_ptr(s->cpu_slab);
+#endif
 	return p;
 }
 
@@ -3291,8 +3298,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * IRQs, which protects against PREEMPT and interrupts
 	 * handlers invoking normal fastpath.
 	 */
+	c = get_cpu_ptr(s->cpu_slab);
 	local_irq_disable();
-	c = this_cpu_ptr(s->cpu_slab);
 
 	for (i = 0; i < size; i++) {
 		void *object = kfence_alloc(s, s->object_size, flags);
@@ -3313,6 +3320,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 */
 			c->tid = next_tid(c->tid);
 
+			local_irq_enable();
+
 			/*
 			 * Invoking slow path likely have side-effect
 			 * of re-populating per CPU c->freelist
@@ -3325,6 +3334,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			c = this_cpu_ptr(s->cpu_slab);
 			maybe_wipe_obj_freeptr(s, p[i]);
 
+			local_irq_disable();
+
 			continue; /* goto for-loop */
 		}
 		c->freelist = get_freepointer(s, object);
@@ -3333,6 +3344,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 	c->tid = next_tid(c->tid);
 	local_irq_enable();
+	put_cpu_ptr(s->cpu_slab);
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
-- 
2.31.1

