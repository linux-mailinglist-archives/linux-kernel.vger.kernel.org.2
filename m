Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152D4365A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhDTNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:32:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17806 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhDTNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:32:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPl072JXzzBrTw;
        Tue, 20 Apr 2021 21:29:27 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Apr 2021
 21:31:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 4/4] mm/shmem: fix shmem_swapin() race with swapoff
Date:   Tue, 20 Apr 2021 09:30:48 -0400
Message-ID: <20210420133048.6773-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210420133048.6773-1-linmiaohe@huawei.com>
References: <20210420133048.6773-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was investigating the swap code, I found the below possible race
window:

CPU 1                                         CPU 2
-----                                         -----
shmem_swapin
  swap_cluster_readahead
    if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
                                              swapoff
                                                percpu_ref_kill(&p->users)
                                                synchronize_rcu()
                                                wait_for_completion
                                                ..
                                                si->swap_file = NULL;
    struct inode *inode = si->swap_file->f_mapping->host;[oops!]

Close this race window by using get/put_swap_device() to guard against
concurrent swapoff.

Fixes: 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or not")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad23..936ba5595297 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1492,15 +1492,21 @@ static void shmem_pseudo_vma_destroy(struct vm_area_struct *vma)
 static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
 			struct shmem_inode_info *info, pgoff_t index)
 {
+	struct swap_info_struct *si;
 	struct vm_area_struct pvma;
 	struct page *page;
 	struct vm_fault vmf = {
 		.vma = &pvma,
 	};
 
+	/* Prevent swapoff from happening to us. */
+	si = get_swap_device(swap);
+	if (unlikely(!si))
+		return NULL;
 	shmem_pseudo_vma_init(&pvma, info, index);
 	page = swap_cluster_readahead(swap, gfp, &vmf);
 	shmem_pseudo_vma_destroy(&pvma);
+	put_swap_device(si);
 
 	return page;
 }
-- 
2.19.1

