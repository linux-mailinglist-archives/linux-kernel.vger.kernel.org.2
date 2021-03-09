Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6B332A59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhCIPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:25:23 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:52614 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhCIPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:25:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UR8yree_1615303513;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UR8yree_1615303513)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 23:25:14 +0800
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
Subject: [PATCH v3 2/4] mm/slub: Get rid of count_partial()
Date:   Tue,  9 Mar 2021 23:25:10 +0800
Message-Id: <1615303512-35058-3-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the partial counters are ready, let's use them directly
and get rid of count_partial().

Tested-by: James Wang <jnwang@linux.alibaba.com>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/slub.c | 54 ++++++++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4d02831..3f76b57 100644
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
@@ -2545,19 +2540,26 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
-static unsigned long count_partial(struct kmem_cache_node *n,
-					int (*get_count)(struct page *))
+enum partial_item { PARTIAL_FREE, PARTIAL_INUSE, PARTIAL_TOTAL };
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
+	if (item == PARTIAL_FREE) {
+		ret = atomic_long_read(&n->partial_free_objs);
+	} else if (item == PARTIAL_TOTAL) {
+		ret = n->partial_total_objs;
+	} else if (item == PARTIAL_INUSE) {
+		ret = n->partial_total_objs - atomic_long_read(&n->partial_free_objs);
+		if ((long)ret < 0)
+			ret = 0;
+	}
+
+	return ret;
 }
+
 #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
 
 static noinline void
@@ -2587,7 +2589,7 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 		unsigned long nr_objs;
 		unsigned long nr_free;
 
-		nr_free  = count_partial(n, count_free);
+		nr_free  = partial_counter(n, PARTIAL_FREE);
 		nr_slabs = node_nr_slabs(n);
 		nr_objs  = node_nr_objs(n);
 
@@ -4643,18 +4645,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
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
@@ -5091,7 +5081,7 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 				x = atomic_long_read(&n->total_objects);
 			else if (flags & SO_OBJECTS)
 				x = atomic_long_read(&n->total_objects) -
-					count_partial(n, count_free);
+					partial_counter(n, PARTIAL_FREE);
 			else
 				x = atomic_long_read(&n->nr_slabs);
 			total += x;
@@ -5105,9 +5095,9 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 
 		for_each_kmem_cache_node(s, node, n) {
 			if (flags & SO_TOTAL)
-				x = count_partial(n, count_total);
+				x = partial_counter(n, PARTIAL_TOTAL);
 			else if (flags & SO_OBJECTS)
-				x = count_partial(n, count_inuse);
+				x = partial_counter(n, PARTIAL_INUSE);
 			else
 				x = n->nr_partial;
 			total += x;
@@ -5873,7 +5863,7 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 	for_each_kmem_cache_node(s, node, n) {
 		nr_slabs += node_nr_slabs(n);
 		nr_objs += node_nr_objs(n);
-		nr_free += count_partial(n, count_free);
+		nr_free += partial_counter(n, PARTIAL_FREE);
 	}
 
 	sinfo->active_objs = nr_objs - nr_free;
-- 
1.8.3.1

