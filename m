Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C294315FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhBJGzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:55:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12162 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBJGzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:55:11 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Db9Rs6T2czlJ82;
        Wed, 10 Feb 2021 14:52:25 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Feb 2021
 14:54:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: use some helper functions to cleanup code
Date:   Wed, 10 Feb 2021 01:53:46 -0500
Message-ID: <20210210065346.21958-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could use pages_per_huge_page to get the number of pages per hugepage,
use get_hstate_idx to calculate hstate index, and use hstate_is_gigantic
to check if a hstate is gigantic to make code more succinct.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 mm/hugetlb.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 701c82c36138..c262566f7c5d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1435,7 +1435,7 @@ static int get_hstate_idx(int page_size_log)
 
 	if (!h)
 		return -1;
-	return h - hstates;
+	return hstate_index(h);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8f6c98096476..da347047ea10 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1271,7 +1271,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
 static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask)
 {
-	unsigned long nr_pages = 1UL << huge_page_order(h);
+	unsigned long nr_pages = pages_per_huge_page(h);
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
@@ -3262,10 +3262,10 @@ static int __init hugepages_setup(char *s)
 
 	/*
 	 * Global state is always initialized later in hugetlb_init.
-	 * But we need to allocate >= MAX_ORDER hstates here early to still
+	 * But we need to allocate gigantic hstates here early to still
 	 * use the bootmem allocator.
 	 */
-	if (hugetlb_max_hstate && parsed_hstate->order >= MAX_ORDER)
+	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
 		hugetlb_hstate_alloc_pages(parsed_hstate);
 
 	last_mhp = mhp;
-- 
2.19.1

