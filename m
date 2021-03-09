Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91D6332A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhCIPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:25:28 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49153 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231963AbhCIPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:25:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UR9HgFS_1615303514;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UR9HgFS_1615303514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 23:25:15 +0800
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
Subject: [PATCH v3 4/4] mm/slub: Use percpu partial free counter
Date:   Tue,  9 Mar 2021 23:25:12 +0800
Message-Id: <1615303512-35058-5-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only concern of introducing partial counter is that,
partial_free_objs may cause cache and atomic operation
contention in case of same SLUB concurrent __slab_free().

This patch changes it to be a percpu counter, also replace
the counter variables to avoid cacheline issues.

Tested-by: James Wang <jnwang@linux.alibaba.com>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/slab.h |  6 ++++--
 mm/slub.c | 30 +++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 817bfa0..c819597 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -546,16 +546,18 @@ struct kmem_cache_node {
 
 #ifdef CONFIG_SLUB
 	unsigned long nr_partial;
-	struct list_head partial;
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
-	atomic_long_t partial_free_objs;
 	unsigned long partial_total_objs;
 #endif
+	struct list_head partial;
 #ifdef CONFIG_SLUB_DEBUG
 	atomic_long_t nr_slabs;
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
+#if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
+	unsigned long __percpu *partial_free_objs;
+#endif
 #endif
 
 };
diff --git a/mm/slub.c b/mm/slub.c
index 3f76b57..b6ec065 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1894,7 +1894,7 @@ static void discard_slab(struct kmem_cache *s, struct page *page)
 static inline void
 __update_partial_free(struct kmem_cache_node *n, long delta)
 {
-	atomic_long_add(delta, &n->partial_free_objs);
+	this_cpu_add(*n->partial_free_objs, delta);
 }
 
 static inline void
@@ -2548,11 +2548,16 @@ static unsigned long partial_counter(struct kmem_cache_node *n,
 	unsigned long ret = 0;
 
 	if (item == PARTIAL_FREE) {
-		ret = atomic_long_read(&n->partial_free_objs);
+		ret = per_cpu_sum(*n->partial_free_objs);
+		if ((long)ret < 0)
+			ret = 0;
 	} else if (item == PARTIAL_TOTAL) {
 		ret = n->partial_total_objs;
 	} else if (item == PARTIAL_INUSE) {
-		ret = n->partial_total_objs - atomic_long_read(&n->partial_free_objs);
+		ret = per_cpu_sum(*n->partial_free_objs);
+		if ((long)ret < 0)
+			ret = 0;
+		ret = n->partial_total_objs - ret;
 		if ((long)ret < 0)
 			ret = 0;
 	}
@@ -3552,14 +3557,16 @@ static inline int calculate_order(unsigned int size)
 	return -ENOSYS;
 }
 
-static void
+static int
 init_kmem_cache_node(struct kmem_cache_node *n)
 {
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
 	INIT_LIST_HEAD(&n->partial);
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
-	atomic_long_set(&n->partial_free_objs, 0);
+	n->partial_free_objs = alloc_percpu(unsigned long);
+	if (!n->partial_free_objs)
+		return -ENOMEM;
 	n->partial_total_objs = 0;
 #endif
 #ifdef CONFIG_SLUB_DEBUG
@@ -3567,6 +3574,8 @@ static inline int calculate_order(unsigned int size)
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
+
+	return 0;
 }
 
 static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
@@ -3626,7 +3635,7 @@ static void early_kmem_cache_node_alloc(int node)
 	page->inuse = 1;
 	page->frozen = 0;
 	kmem_cache_node->node[node] = n;
-	init_kmem_cache_node(n);
+	BUG_ON(init_kmem_cache_node(n) < 0);
 	inc_slabs_node(kmem_cache_node, node, page->objects);
 
 	/*
@@ -3644,6 +3653,9 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 
 	for_each_kmem_cache_node(s, node, n) {
 		s->node[node] = NULL;
+#if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
+		free_percpu(n->partial_free_objs);
+#endif
 		kmem_cache_free(kmem_cache_node, n);
 	}
 }
@@ -3674,7 +3686,11 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
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
-- 
1.8.3.1

