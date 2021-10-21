Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED49435C79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhJUH4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:56:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13960 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhJUH4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:56:35 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HZfpN71XhzZcQB;
        Thu, 21 Oct 2021 15:52:28 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 15:54:15 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 15:54:14 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <shakeelb@google.com>, <urezki@gmail.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v3 1/2] mm/vmalloc: fix numa spreading for large hash tables
Date:   Thu, 21 Oct 2021 16:07:43 +0800
Message-ID: <20211021080744.874701-2-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021080744.874701-1-chenwandun@huawei.com>
References: <20211021080744.874701-1-chenwandun@huawei.com>
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmalloc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604c..e8a807c78110 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2816,6 +2816,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
+	struct page *page;
+	int i;
 
 	/*
 	 * For order-0 pages we make use of bulk allocator, if
@@ -2823,7 +2825,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * to fails, fallback to a single page allocator that is
 	 * more permissive.
 	 */
-	if (!order) {
+	if (!order && nid != NUMA_NO_NODE) {
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -2848,7 +2850,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
-	} else
+	} else if (order)
 		/*
 		 * Compound pages required for remap_vmalloc_page if
 		 * high-order pages.
@@ -2856,11 +2858,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		gfp |= __GFP_COMP;
 
 	/* High-order pages or fallback path if "bulk" fails. */
-	while (nr_allocated < nr_pages) {
-		struct page *page;
-		int i;
 
-		page = alloc_pages_node(nid, gfp, order);
+	while (nr_allocated < nr_pages) {
+		if (nid == NUMA_NO_NODE)
+			page = alloc_pages(gfp, order);
+		else
+			page = alloc_pages_node(nid, gfp, order);
 		if (unlikely(!page))
 			break;
 
-- 
2.25.1

