Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F670332A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhCIPZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:25:24 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46209 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhCIPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:25:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UR93h0F_1615303513;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UR93h0F_1615303513)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 23:25:13 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH v3 1/4] mm/slub: Introduce two counters for partial objects
Date:   Tue,  9 Mar 2021 23:25:09 +0800
Message-Id: <1615303512-35058-2-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node list_lock in count_partial() spends long time iterating
in case of large amount of partial page lists, which can cause
thunder herd effect to the list_lock contention.

We have HSF RT(High-speed Service Framework Response-Time) monitors,
the RT figures fluctuated randomly, then we deployed a tool detecting
"irq off" and "preempt off" to dump the culprit's calltrace, capturing
the list_lock cost nearly 100ms with irq off issued by "ss", this also
caused network timeouts.

This patch introduces two counters to maintain the actual number
of partial objects dynamically instead of iterating the partial
page lists with list_lock held.

New counters of kmem_cache_node: partial_free_objs, partial_total_objs.
The main operations are under list_lock in slow path, its performance
impact should be minimal except the __slab_free() path which will be
addressed later.

Tested-by: James Wang <jnwang@linux.alibaba.com>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/slab.h |  4 ++++
 mm/slub.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 076582f..817bfa0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -547,6 +547,10 @@ struct kmem_cache_node {
 #ifdef CONFIG_SLUB
 	unsigned long nr_partial;
 	struct list_head partial;
+#if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
+	atomic_long_t partial_free_objs;
+	unsigned long partial_total_objs;
+#endif
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
diff --git a/mm/slub.c b/mm/slub.c
index e26c274..4d02831 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1890,10 +1890,31 @@ static void discard_slab(struct kmem_cache *s, struct page *page)
 /*
  * Management of partially allocated slabs.
  */
+#if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
+static inline void
+__update_partial_free(struct kmem_cache_node *n, long delta)
+{
+	atomic_long_add(delta, &n->partial_free_objs);
+}
+
+static inline void
+__update_partial_total(struct kmem_cache_node *n, long delta)
+{
+	n->partial_total_objs += delta;
+}
+#else
+static inline void
+__update_partial_free(struct kmem_cache_node *n, long delta) { }
+
+static inline void
+__update_partial_total(struct kmem_cache_node *n, long delta) { }
+#endif
+
 static inline void
 __add_partial(struct kmem_cache_node *n, struct page *page, int tail)
 {
 	n->nr_partial++;
+	__update_partial_total(n, page->objects);
 	if (tail == DEACTIVATE_TO_TAIL)
 		list_add_tail(&page->slab_list, &n->partial);
 	else
@@ -1913,6 +1934,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
 	lockdep_assert_held(&n->list_lock);
 	list_del(&page->slab_list);
 	n->nr_partial--;
+	__update_partial_total(n, -page->objects);
 }
 
 /*
@@ -1957,6 +1979,7 @@ static inline void *acquire_slab(struct kmem_cache *s,
 		return NULL;
 
 	remove_partial(n, page);
+	__update_partial_free(n, -*objects);
 	WARN_ON(!freelist);
 	return freelist;
 }
@@ -2286,8 +2309,11 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 				"unfreezing slab"))
 		goto redo;
 
-	if (lock)
+	if (lock) {
+		if (m == M_PARTIAL)
+			__update_partial_free(n, new.objects - new.inuse);
 		spin_unlock(&n->list_lock);
+	}
 
 	if (m == M_PARTIAL)
 		stat(s, tail);
@@ -2353,6 +2379,7 @@ static void unfreeze_partials(struct kmem_cache *s,
 			discard_page = page;
 		} else {
 			add_partial(n, page, DEACTIVATE_TO_TAIL);
+			__update_partial_free(n, new.objects - new.inuse);
 			stat(s, FREE_ADD_PARTIAL);
 		}
 	}
@@ -3039,6 +3066,13 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 		head, new.counters,
 		"__slab_free"));
 
+	if (!was_frozen && prior) {
+		if (n)
+			__update_partial_free(n, cnt);
+		else
+			__update_partial_free(get_node(s, page_to_nid(page)), cnt);
+	}
+
 	if (likely(!n)) {
 
 		if (likely(was_frozen)) {
@@ -3069,6 +3103,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
 		remove_full(s, n, page);
 		add_partial(n, page, DEACTIVATE_TO_TAIL);
+		__update_partial_free(n, cnt);
 		stat(s, FREE_ADD_PARTIAL);
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
@@ -3080,6 +3115,7 @@ static void __slab_free(struct kmem_cache *s, struct page *page,
 		 * Slab on the partial list.
 		 */
 		remove_partial(n, page);
+		__update_partial_free(n, -page->objects);
 		stat(s, FREE_REMOVE_PARTIAL);
 	} else {
 		/* Slab must be on the full list */
@@ -3520,6 +3556,10 @@ static inline int calculate_order(unsigned int size)
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
 	INIT_LIST_HEAD(&n->partial);
+#if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
+	atomic_long_set(&n->partial_free_objs, 0);
+	n->partial_total_objs = 0;
+#endif
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_set(&n->nr_slabs, 0);
 	atomic_long_set(&n->total_objects, 0);
@@ -3592,6 +3632,7 @@ static void early_kmem_cache_node_alloc(int node)
 	 * initialized and there is no concurrent access.
 	 */
 	__add_partial(n, page, DEACTIVATE_TO_HEAD);
+	__update_partial_free(n, page->objects - page->inuse);
 }
 
 static void free_kmem_cache_nodes(struct kmem_cache *s)
@@ -3922,6 +3963,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 	list_for_each_entry_safe(page, h, &n->partial, slab_list) {
 		if (!page->inuse) {
 			remove_partial(n, page);
+			__update_partial_free(n, -page->objects);
 			list_add(&page->slab_list, &discard);
 		} else {
 			list_slab_objects(s, page,
@@ -4263,6 +4305,8 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 			if (free == page->objects) {
 				list_move(&page->slab_list, &discard);
 				n->nr_partial--;
+				__update_partial_free(n, -free);
+				__update_partial_total(n, -free);
 			} else if (free <= SHRINK_PROMOTE_MAX)
 				list_move(&page->slab_list, promote + free - 1);
 		}
-- 
1.8.3.1

