Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FAC38F663
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhEXXnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhEXXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z47ExFtnRGFnfiCGP/JwGcYzfZ2YQagpDfZvgOIHMOM=;
        b=etD4sdJFbpVk6sGv2tg+Xp2lntEyVckFJOzH45FoRc1fiAkUszCGR2nbcxjPoISzz3jR8q
        Mafte0RMIp2KZnu48RgOAOHRqi7rW+C40jpreY2DxbuCeDYnnH3aL/EjsfoVskehnfAvOa
        gtGzVrY5RPxYt4O3mD8HX6NX6XDgvxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z47ExFtnRGFnfiCGP/JwGcYzfZ2YQagpDfZvgOIHMOM=;
        b=PjFn9aSEYXME1fsoPDPInHhzGA5mmfRVp9m3R2c0a4o3QrNof//bNLEcdQX3+oUyRwIyYK
        O4y+zgWt6MssNZBQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 800C5AF4E;
        Mon, 24 May 2021 23:40:49 +0000 (UTC)
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
Subject: [RFC 22/26] mm, slub: detach percpu partial list in unfreeze_partials() using this_cpu_cmpxchg()
Date:   Tue, 25 May 2021 01:39:42 +0200
Message-Id: <20210524233946.20352-23-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on disabled irqs for atomicity when detaching the percpu
partial list, we can use this_cpu_cmpxchg() and detach without irqs disabled.
However, unfreeze_partials() can be also called from another cpu on behalf of
a cpu that is being offlined, so we need to restructure the code accordingly:

- __unfreeze_partials() is the bulk of unfreeze_partials() that processes the
  detached percpu partial list
- unfreeze_partials() uses this_cpu_cmpxchg() to detach list from current cpu
- unfreeze_partials_cpu() is to be called for the offlined cpu so it needs no
  protection, and is called from __flush_cpu_slab()
- flush_cpu_slab() needs to call unfreeze_partial() so it can't simply call
  __flush_cpu_slab(smp_processor_id()) anymore

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 79 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 414cc621d655..92345d3840d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2301,25 +2301,15 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	}
 }
 
-/*
- * Unfreeze all the cpu partial slabs.
- *
- * This function must be called with preemption or migration
- * disabled with c local to the cpu.
- */
-static void unfreeze_partials(struct kmem_cache *s,
-		struct kmem_cache_cpu *c)
-{
 #ifdef CONFIG_SLUB_CPU_PARTIAL
+static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
+{
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
-	struct page *page, *partial_page, *discard_page = NULL;
+	struct page *page, *discard_page = NULL;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	partial_page = slub_percpu_partial(c);
-	c->partial = NULL;
-
 	while (partial_page) {
 		struct page new;
 		struct page old;
@@ -2374,10 +2364,49 @@ static void unfreeze_partials(struct kmem_cache *s,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
+}
 
-#endif	/* CONFIG_SLUB_CPU_PARTIAL */
+/*
+ * Unfreeze all the cpu partial slabs.
+ *
+ * This function must be called with preemption or migration
+ * disabled.
+ */
+static void unfreeze_partials(struct kmem_cache *s)
+{
+	struct page *partial_page;
+
+	do {
+		partial_page = this_cpu_read(s->cpu_slab->partial);
+
+	} while (partial_page &&
+		 this_cpu_cmpxchg(s->cpu_slab->partial, partial_page, NULL)
+				  != partial_page);
+
+	if (partial_page)
+		__unfreeze_partials(s, partial_page);
 }
 
+static void unfreeze_partials_cpu(struct kmem_cache *s,
+				  struct kmem_cache_cpu *c)
+{
+	struct page *partial_page;
+
+	partial_page = slub_percpu_partial(c);
+	c->partial = NULL;
+
+	if (partial_page)
+		__unfreeze_partials(s, partial_page);
+}
+
+#else	/* CONFIG_SLUB_CPU_PARTIAL */
+
+static void unfreeze_partials(struct kmem_cache *s) { }
+static void unfreeze_partials_cpu(struct kmem_cache *s,
+				  struct kmem_cache_cpu *c) { }
+
+#endif	/* CONFIG_SLUB_CPU_PARTIAL */
+
 /*
  * Put a page that was just frozen (in __slab_free|get_partial_node) into a
  * partial page slot if available.
@@ -2406,7 +2435,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
-				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
+				unfreeze_partials(s);
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
@@ -2424,7 +2453,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!= oldpage);
 	if (unlikely(!slub_cpu_partial(s)))
-		unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
+		unfreeze_partials(s);
 
 	preempt_enable();
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
@@ -2444,11 +2473,6 @@ static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 	stat(s, CPUSLAB_FLUSH);
 }
 
-/*
- * Flush cpu slab.
- *
- * Called from IPI handler with interrupts disabled.
- */
 static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
@@ -2456,14 +2480,23 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	if (c->page)
 		flush_slab(s, c);
 
-	unfreeze_partials(s, c);
+	unfreeze_partials_cpu(s, c);
 }
 
+/*
+ * Flush cpu slab.
+ *
+ * Called from IPI handler with interrupts disabled.
+ */
 static void flush_cpu_slab(void *d)
 {
 	struct kmem_cache *s = d;
+	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
 
-	__flush_cpu_slab(s, smp_processor_id());
+	if (c->page)
+		flush_slab(s, c);
+
+	unfreeze_partials(s);
 }
 
 static bool has_cpu_slab(int cpu, void *info)
-- 
2.31.1

