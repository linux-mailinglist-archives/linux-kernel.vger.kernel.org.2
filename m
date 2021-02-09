Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891E831461E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhBICTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:19:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12530 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBICTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:19:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DZRN85CyLzMWSj;
        Tue,  9 Feb 2021 10:16:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Feb 2021
 10:18:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/hugetlb: use helper huge_page_size() to get hugepage size
Date:   Mon, 8 Feb 2021 21:18:03 -0500
Message-ID: <20210209021803.49211-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use helper huge_page_size() to get the hugepage size directly to
simplify the code slightly.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v1 -> v2
	change huge_page_size(h) >> 10 to huge_page_size(h) / SZ_1K
	collect Reviewed-by tag
---
 mm/hugetlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 18628f8dbfb0..06719fdf9fd6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3199,7 +3199,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
 	h->order = order;
-	h->mask = ~((1ULL << (order + PAGE_SHIFT)) - 1);
+	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
 	INIT_LIST_HEAD(&h->hugepage_activelist);
@@ -3474,7 +3474,7 @@ void hugetlb_report_meminfo(struct seq_file *m)
 	for_each_hstate(h) {
 		unsigned long count = h->nr_huge_pages;
 
-		total += (PAGE_SIZE << huge_page_order(h)) * count;
+		total += huge_page_size(h) * count;
 
 		if (h == &default_hstate)
 			seq_printf(m,
@@ -3487,10 +3487,10 @@ void hugetlb_report_meminfo(struct seq_file *m)
 				   h->free_huge_pages,
 				   h->resv_huge_pages,
 				   h->surplus_huge_pages,
-				   (PAGE_SIZE << huge_page_order(h)) / 1024);
+				   huge_page_size(h) / SZ_1K);
 	}
 
-	seq_printf(m, "Hugetlb:        %8lu kB\n", total / 1024);
+	seq_printf(m, "Hugetlb:        %8lu kB\n", total / SZ_1K);
 }
 
 int hugetlb_report_node_meminfo(char *buf, int len, int nid)
@@ -3524,7 +3524,7 @@ void hugetlb_show_meminfo(void)
 				h->nr_huge_pages_node[nid],
 				h->free_huge_pages_node[nid],
 				h->surplus_huge_pages_node[nid],
-				1UL << (huge_page_order(h) + PAGE_SHIFT - 10));
+				huge_page_size(h) / SZ_1K);
 }
 
 void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
@@ -3647,9 +3647,7 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 
 static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
 {
-	struct hstate *hstate = hstate_vma(vma);
-
-	return 1UL << huge_page_shift(hstate);
+	return huge_page_size(hstate_vma(vma));
 }
 
 /*
-- 
2.19.1

