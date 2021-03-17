Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6617433EAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhCQH4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:56:04 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:46614 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhCQHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:55:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0USEIes2_1615967694;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0USEIes2_1615967694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 15:54:54 +0800
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
Subject: [PATCH v4 3/3] mm/slub: Get rid of count_partial()
Date:   Wed, 17 Mar 2021 15:54:52 +0800
Message-Id: <1615967692-80524-4-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the partial counters are ready, let's use them to get rid
of count_partial().

The partial counters will involve in to calculate the accurate
partial usage when CONFIG_SLUB_DEBUG_PARTIAL is on, otherwise
simply assume their zero usage statistics.

Tested-by: James Wang <jnwang@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/slub.c | 64 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 856aea4..9bff669 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2533,11 +2533,6 @@ static inline int node_match(struct page *page, int node)
 }
 
 #ifdef CONFIG_SLUB_DEBUG
-static int count_free(struct page *page)
-{
-	return page->objects - page->inuse;
-}
-
 static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 {
 	return atomic_long_read(&n->total_objects);
@@ -2545,18 +2540,33 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
-static unsigned long count_partial(struct kmem_cache_node *n,
-					int (*get_count)(struct page *))
+enum partial_item { PARTIAL_FREE, PARTIAL_INUSE, PARTIAL_TOTAL, PARTIAL_SLAB };
+
+static unsigned long partial_counter(struct kmem_cache_node *n,
+		enum partial_item item)
 {
-	unsigned long flags;
-	unsigned long x = 0;
-	struct page *page;
+	unsigned long ret = 0;
 
-	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(page, &n->partial, slab_list)
-		x += get_count(page);
-	spin_unlock_irqrestore(&n->list_lock, flags);
-	return x;
+#ifdef CONFIG_SLUB_DEBUG_PARTIAL
+	if (item == PARTIAL_FREE) {
+		ret = per_cpu_sum(*n->partial_free_objs);
+		if ((long)ret < 0)
+			ret = 0;
+	} else if (item == PARTIAL_TOTAL) {
+		ret = n->partial_total_objs;
+	} else if (item == PARTIAL_INUSE) {
+		ret = per_cpu_sum(*n->partial_free_objs);
+		if ((long)ret < 0)
+			ret = 0;
+		ret = n->partial_total_objs - ret;
+		if ((long)ret < 0)
+			ret = 0;
+	} else { /* item == PARTIAL_SLAB */
+		ret = n->nr_partial;
+	}
+#endif
+
+	return ret;
 }
 #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
 
@@ -2587,7 +2597,7 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 		unsigned long nr_objs;
 		unsigned long nr_free;
 
-		nr_free  = count_partial(n, count_free);
+		nr_free  = partial_counter(n, PARTIAL_FREE);
 		nr_slabs = node_nr_slabs(n);
 		nr_objs  = node_nr_objs(n);
 
@@ -4654,18 +4664,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif
 
-#ifdef CONFIG_SYSFS
-static int count_inuse(struct page *page)
-{
-	return page->inuse;
-}
-
-static int count_total(struct page *page)
-{
-	return page->objects;
-}
-#endif
-
 #ifdef CONFIG_SLUB_DEBUG
 static void validate_slab(struct kmem_cache *s, struct page *page)
 {
@@ -5102,7 +5100,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 				x = atomic_long_read(&n->total_objects);
 			else if (flags & SO_OBJECTS)
 				x = atomic_long_read(&n->total_objects) -
-					count_partial(n, count_free);
+					partial_counter(n, PARTIAL_FREE);
 			else
 				x = atomic_long_read(&n->nr_slabs);
 			total += x;
@@ -5116,11 +5114,11 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 
 		for_each_kmem_cache_node(s, node, n) {
 			if (flags & SO_TOTAL)
-				x = count_partial(n, count_total);
+				x = partial_counter(n, PARTIAL_TOTAL);
 			else if (flags & SO_OBJECTS)
-				x = count_partial(n, count_inuse);
+				x = partial_counter(n, PARTIAL_INUSE);
 			else
-				x = n->nr_partial;
+				x = partial_counter(n, PARTIAL_SLAB);
 			total += x;
 			nodes[node] += x;
 		}
@@ -5884,7 +5882,7 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 	for_each_kmem_cache_node(s, node, n) {
 		nr_slabs += node_nr_slabs(n);
 		nr_objs += node_nr_objs(n);
-		nr_free += count_partial(n, count_free);
+		nr_free += partial_counter(n, PARTIAL_FREE);
 	}
 
 	sinfo->active_objs = nr_objs - nr_free;
-- 
1.8.3.1

