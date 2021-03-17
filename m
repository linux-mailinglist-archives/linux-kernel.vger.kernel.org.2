Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0569C33EAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCQHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:55:32 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46895 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230372AbhCQHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:54:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0USESt7y_1615967693;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0USESt7y_1615967693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 15:54:53 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Christoph Lameter <cl@linux.com>, Christoph Lameter <cl@gentwo.de>,
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
Subject: [PATCH v4 1/3] mm/slub: Introduce two counters for partial objects
Date:   Wed, 17 Mar 2021 15:54:50 +0800
Message-Id: <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
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
impact is expected to be minimal except the __slab_free() path.

The only concern of introducing partial counter is that partial_free_objs
may cause cacheline contention and false sharing issues in case of same
SLUB concurrent __slab_free(), so define it to be a percpu counter and
places it carefully.

As "Vlastimil Babka" and "Christoph Lameter" both suggested that we
don't care about the accurate partial objects, and in case that somebody
might actually want accurate object statistics at the expense of peak
performance, and it would be nice to give them such option in SLUB.

Thus a new CONFIG_SLUB_DEBUG_PARTIAL is introduced to maintain accurate
partial objects, which is default off to avoid unexpected performance
degradation.

When CONFIG_SLUB_DEBUG_PARTIAL is not selected, the sysfs or proc files
related to the partial list (/proc/slabinfo, sysfs objects_partial, etc)
assume their zero usage data, e.g.,
  Value of "active_objs" and "num_objs" fields of "/proc/slabinfo" equal.
  "cat /sys/kernel/slab/<slab>/partial" displays "0".

Tested-by: James Wang <jnwang@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 init/Kconfig | 13 +++++++++++++
 mm/slab.h    |  6 ++++++
 mm/slub.c    | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 22946fe..686851b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1867,6 +1867,19 @@ config SLUB_DEBUG
 	  SLUB sysfs support. /sys/slab will not exist and there will be
 	  no support for cache validation etc.
 
+config SLUB_DEBUG_PARTIAL
+	default n
+	bool "Enable SLUB debugging for the node partial list" if EXPERT
+	depends on SLUB && SYSFS
+	help
+	  Maintain runtime counters for the node partial list debugging.
+	  When CONFIG_SLUB_DEBUG_PARTIAL is not selected, the sysfs or proc
+	  files related to the partial list assume zero data usage, e.g.,
+	  value of "active_objs" and "num_objs" of "/proc/slabinfo" equals.
+	  "cat /sys/kernel/slab/<slab>/partial" displays "0".
+
+	  It might have slight performance impact for production use.
+
 config COMPAT_BRK
 	bool "Disable heap randomization"
 	default y
diff --git a/mm/slab.h b/mm/slab.h
index 076582f..f47c811 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -546,12 +546,18 @@ struct kmem_cache_node {
 
 #ifdef CONFIG_SLUB
 	unsigned long nr_partial;
+#ifdef CONFIG_SLUB_DEBUG_PARTIAL
+	unsigned long partial_total_objs;
+#endif
 	struct list_head partial;
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
+#ifdef CONFIG_SLUB_DEBUG_PARTIAL
+	unsigned long __percpu *partial_free_objs ____cacheline_aligned_in_smp;
+#endif
 #endif
 
 };
diff --git a/mm/slub.c b/mm/slub.c
index e26c274..856aea4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1890,10 +1890,31 @@ static void discard_slab(struct kmem_cache *s, struct page *page)
 /*
  * Management of partially allocated slabs.
  */
+#ifdef CONFIG_SLUB_DEBUG_PARTIAL
+static inline void
+__update_partial_free(struct kmem_cache_node *n, long delta)
+{
+	this_cpu_add(*n->partial_free_objs, delta);
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
@@ -3514,17 +3550,25 @@ static inline int calculate_order(unsigned int size)
 	return -ENOSYS;
 }
 
-static void
+static int
 init_kmem_cache_node(struct kmem_cache_node *n)
 {
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
 	INIT_LIST_HEAD(&n->partial);
+#ifdef CONFIG_SLUB_DEBUG_PARTIAL
+	n->partial_free_objs = alloc_percpu(unsigned long);
+	if (!n->partial_free_objs)
+		return -ENOMEM;
+	n->partial_total_objs = 0;
+#endif
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_set(&n->nr_slabs, 0);
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
+
+	return 0;
 }
 
 static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
@@ -3584,7 +3628,7 @@ static void early_kmem_cache_node_alloc(int node)
 	page->inuse = 1;
 	page->frozen = 0;
 	kmem_cache_node->node[node] = n;
-	init_kmem_cache_node(n);
+	BUG_ON(init_kmem_cache_node(n) < 0);
 	inc_slabs_node(kmem_cache_node, node, page->objects);
 
 	/*
@@ -3592,6 +3636,7 @@ static void early_kmem_cache_node_alloc(int node)
 	 * initialized and there is no concurrent access.
 	 */
 	__add_partial(n, page, DEACTIVATE_TO_HEAD);
+	__update_partial_free(n, page->objects - page->inuse);
 }
 
 static void free_kmem_cache_nodes(struct kmem_cache *s)
@@ -3601,6 +3646,9 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 
 	for_each_kmem_cache_node(s, node, n) {
 		s->node[node] = NULL;
+#ifdef CONFIG_SLUB_DEBUG_PARTIAL
+		free_percpu(n->partial_free_objs);
+#endif
 		kmem_cache_free(kmem_cache_node, n);
 	}
 }
@@ -3631,7 +3679,11 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 			return 0;
 		}
 
-		init_kmem_cache_node(n);
+		if (init_kmem_cache_node(n) < 0) {
+			free_kmem_cache_nodes(s);
+			return 0;
+		}
+
 		s->node[node] = n;
 	}
 	return 1;
@@ -3922,6 +3974,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 	list_for_each_entry_safe(page, h, &n->partial, slab_list) {
 		if (!page->inuse) {
 			remove_partial(n, page);
+			__update_partial_free(n, -page->objects);
 			list_add(&page->slab_list, &discard);
 		} else {
 			list_slab_objects(s, page,
@@ -4263,6 +4316,8 @@ int __kmem_cache_shrink(struct kmem_cache *s)
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

