Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F5C41AE63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhI1MEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:04:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:26944 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhI1MEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:04:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HJdLX4bX1zbmpv;
        Tue, 28 Sep 2021 19:58:12 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 20:02:29 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 20:02:28 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
Date:   Tue, 28 Sep 2021 20:10:40 +0800
Message-ID: <20210928121040.2547407-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet reported a strange numa spreading info in [1], and found
commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
this issue [2].

Dig into the difference before and after this patch, page allocation has
some difference:

before:
alloc_large_system_hash
    __vmalloc
        __vmalloc_node(..., NUMA_NO_NODE, ...)
            __vmalloc_node_range
                __vmalloc_area_node
                    alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
                        alloc_pages_current
                            alloc_page_interleave /* can be proved by print policy mode */

after:
alloc_large_system_hash
    __vmalloc
        __vmalloc_node(..., NUMA_NO_NODE, ...)
            __vmalloc_node_range
                __vmalloc_area_node
                    alloc_pages_node /* choose nid by nuam_mem_id() */
                        __alloc_pages_node(nid, ....)

So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
it will allocate memory in current node instead of interleaving allocate
memory.

[1]
https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/

[2]
https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/

Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f884706c5280..48e717626e94 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
+	struct page *page;
+	int i;
 
 	/*
 	 * For order-0 pages we make use of bulk allocator, if
@@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	if (!order) {
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
+			page = NULL;
 
 			/*
 			 * A maximum allowed request is hard-coded and is 100
@@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 */
 			nr_pages_request = min(100U, nr_pages - nr_allocated);
 
-			nr = alloc_pages_bulk_array_node(gfp, nid,
-				nr_pages_request, pages + nr_allocated);
-
+			if (nid == NUMA_NO_NODE) {
+				for (i = 0; i < nr_pages_request; i++) {
+					page = alloc_page(gfp);
+					if (page)
+						pages[nr_allocated + i] = page;
+					else {
+						nr = i;
+						break;
+					}
+				}
+				if (i >= nr_pages_request)
+					nr = nr_pages_request;
+			} else {
+				nr = alloc_pages_bulk_array_node(gfp, nid,
+							nr_pages_request,
+							pages + nr_allocated);
+			}
 			nr_allocated += nr;
 			cond_resched();
 
@@ -2863,11 +2880,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		gfp |= __GFP_COMP;
 
 	/* High-order pages or fallback path if "bulk" fails. */
-	while (nr_allocated < nr_pages) {
-		struct page *page;
-		int i;
 
-		page = alloc_pages_node(nid, gfp, order);
+	page = NULL;
+	while (nr_allocated < nr_pages) {
+		if (nid == NUMA_NO_NODE)
+			page = alloc_pages(gfp, order);
+		else
+			page = alloc_pages_node(nid, gfp, order);
 		if (unlikely(!page))
 			break;
 
-- 
2.25.1

