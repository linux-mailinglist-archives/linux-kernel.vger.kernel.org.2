Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9A136A436
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 04:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhDYCjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 22:39:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17053 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhDYCjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 22:39:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FSXFv2qxDz17Rm8;
        Sun, 25 Apr 2021 10:36:03 +0800 (CST)
Received: from huawei.com (10.175.104.174) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Sun, 25 Apr 2021
 10:38:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 4/4] mm/shmem: fix shmem_swapin() race with swapoff
Date:   Sun, 25 Apr 2021 10:38:06 +0800
Message-ID: <20210425023806.3537283-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210425023806.3537283-1-linmiaohe@huawei.com>
References: <20210425023806.3537283-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.174]
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
                                                ..
                                                si->swap_file = NULL;
                                                ..
    struct inode *inode = si->swap_file->f_mapping->host;[oops!]

Close this race window by using get/put_swap_device() to guard against
concurrent swapoff.

Fixes: 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or not")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 26c76b13ad23..be388d0cf8b5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
+	struct swap_info_struct *si;
 	struct page *page;
 	swp_entry_t swap;
 	int error;
@@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	swap = radix_to_swp_entry(*pagep);
 	*pagep = NULL;
 
+	/* Prevent swapoff from happening to us. */
+	si = get_swap_device(swap);
+	if (unlikely(!si)) {
+		error = EINVAL;
+		goto failed;
+	}
 	/* Look it up and read it in.. */
 	page = lookup_swap_cache(swap, NULL, 0);
 	if (!page) {
@@ -1720,6 +1727,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 			goto failed;
 		}
 	}
+	put_swap_device(si);
 
 	/* We have to do this with page locked to prevent races */
 	lock_page(page);
@@ -1775,6 +1783,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 		put_page(page);
 	}
 
+	if (si)
+		put_swap_device(si);
+
 	return error;
 }
 
-- 
2.19.1

