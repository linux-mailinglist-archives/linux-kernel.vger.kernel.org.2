Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19D34318FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJRMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:25:15 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25164 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhJRMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:25:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HXwvw4WG4z1DHjC;
        Mon, 18 Oct 2021 20:21:16 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 20:23:00 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 20:22:59 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <shakeelb@google.com>, <urezki@gmail.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2 2/2] mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to accelerate memory allocation
Date:   Mon, 18 Oct 2021 20:37:10 +0800
Message-ID: <20211018123710.1540996-3-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018123710.1540996-1-chenwandun@huawei.com>
References: <20211018123710.1540996-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will cause significant performance regressions in some situations
as Andrew mentioned in [1]. The main situation is vmalloc, vmalloc
will allocate pages with NUMA_NO_NODE by default, that will result
in alloc page one by one;

In order to solve this, __alloc_pages_bulk and mempolicy should be
considered at the same time.

1) If node is specified in memory allocation request, it will alloc
all pages by __alloc_pages_bulk.

2) If interleaving allocate memory, it will cauculate how many pages
should be allocated in each node, and use __alloc_pages_bulk to alloc
pages in each node.

[1]: https://lore.kernel.org/lkml/CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com/t/#m750c8e3231206134293b089feaa090590afa0f60

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 include/linux/gfp.h |  4 +++
 mm/mempolicy.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c        | 20 ++++++++---
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 55b2ec1f965a..cd98c858fc74 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -535,6 +535,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				struct list_head *page_list,
 				struct page **page_array);
 
+unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
+				unsigned long nr_pages,
+				struct page **page_array);
+
 /* Bulk allocate order-0 pages */
 static inline unsigned long
 alloc_pages_bulk_list(gfp_t gfp, unsigned long nr_pages, struct list_head *list)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1592b081c58e..56bb1fe4d179 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2202,6 +2202,88 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 }
 EXPORT_SYMBOL(alloc_pages);
 
+unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
+		struct mempolicy *pol, unsigned long nr_pages,
+		struct page **page_array)
+{
+	int nodes;
+	unsigned long nr_pages_per_node;
+	int delta;
+	int i;
+	unsigned long nr_allocated;
+	unsigned long total_allocated = 0;
+
+	nodes = nodes_weight(pol->nodes);
+	nr_pages_per_node = nr_pages / nodes;
+	delta = nr_pages - nodes * nr_pages_per_node;
+
+	for (i = 0; i < nodes; i++) {
+		if (delta) {
+			nr_allocated = __alloc_pages_bulk(gfp,
+					interleave_nodes(pol), NULL,
+					nr_pages_per_node + 1, NULL,
+					page_array);
+			delta--;
+		} else {
+			nr_allocated = __alloc_pages_bulk(gfp,
+					interleave_nodes(pol), NULL,
+					nr_pages_per_node, NULL, page_array);
+		}
+
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+	}
+
+	return total_allocated;
+}
+
+unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
+		struct mempolicy *pol, unsigned long nr_pages,
+		struct page **page_array)
+{
+	gfp_t preferred_gfp;
+	unsigned long nr_allocated = 0;
+
+	preferred_gfp = gfp | __GFP_NOWARN;
+	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
+
+	nr_allocated  = __alloc_pages_bulk(preferred_gfp, nid, &pol->nodes,
+					   nr_pages, NULL, page_array);
+
+	if (nr_allocated < nr_pages)
+		nr_allocated += __alloc_pages_bulk(gfp, numa_node_id(), NULL,
+				nr_pages - nr_allocated, NULL,
+				page_array + nr_allocated);
+	return nr_allocated;
+}
+
+/* alloc pages bulk and mempolicy should be considered at the
+ * same time in some situation such as vmalloc.
+ *
+ * It can accelerate memory allocation especially interleaving
+ * allocate memory.
+ */
+unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
+		unsigned long nr_pages, struct page **page_array)
+{
+	struct mempolicy *pol = &default_policy;
+
+	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
+		pol = get_task_policy(current);
+
+	if (pol->mode == MPOL_INTERLEAVE)
+		return alloc_pages_bulk_array_interleave(gfp, pol,
+							 nr_pages, page_array);
+
+	if (pol->mode == MPOL_PREFERRED_MANY)
+		return alloc_pages_bulk_array_preferred_many(gfp,
+				numa_node_id(), pol, nr_pages, page_array);
+
+	return __alloc_pages_bulk(gfp, policy_node(gfp, pol, numa_node_id()),
+				  policy_nodemask(gfp, pol), nr_pages, NULL,
+				  page_array);
+}
+
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
 	struct mempolicy *pol = mpol_dup(vma_policy(src));
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 87552a4018aa..19b34c266fac 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2825,7 +2825,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * to fails, fallback to a single page allocator that is
 	 * more permissive.
 	 */
-	if (!order && nid != NUMA_NO_NODE) {
+	if (!order) {
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -2837,8 +2837,20 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 */
 			nr_pages_request = min(100U, nr_pages - nr_allocated);
 
-			nr = alloc_pages_bulk_array_node(gfp, nid,
-				nr_pages_request, pages + nr_allocated);
+			/* memory allocation should consider mempolicy, we cant
+			 * wrongly use nearest node when nid == NUMA_NO_NODE,
+			 * otherwise memory may be allocated in only one node,
+			 * but mempolcy want to alloc memory by interleaving.
+			 */
+			if (nid == NUMA_NO_NODE)
+				nr = alloc_pages_bulk_array_mempolicy(gfp,
+							nr_pages_request,
+							pages + nr_allocated);
+
+			else
+				nr = alloc_pages_bulk_array_node(gfp, nid,
+							nr_pages_request,
+							pages + nr_allocated);
 
 			nr_allocated += nr;
 			cond_resched();
@@ -2850,7 +2862,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
-	} else if (order)
+	} else
 		/*
 		 * Compound pages required for remap_vmalloc_page if
 		 * high-order pages.
-- 
2.25.1

