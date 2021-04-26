Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE236B322
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhDZMek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:34:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17062 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhDZMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:34:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FTPQQ3xtBz19MZL;
        Mon, 26 Apr 2021 20:31:26 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 26 Apr 2021
 20:33:42 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v6 2/4] swap: fix do_swap_page() race with swapoff
Date:   Mon, 26 Apr 2021 20:33:14 +0800
Message-ID: <20210426123316.806267-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210426123316.806267-1-linmiaohe@huawei.com>
References: <20210426123316.806267-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I was investigating the swap code, I found the below possible race
window:

CPU 1                                   	CPU 2
-----                                   	-----
do_swap_page
  if (data_race(si->flags & SWP_SYNCHRONOUS_IO)
  swap_readpage
    if (data_race(sis->flags & SWP_FS_OPS)) {
                                        	swapoff
					  	  ..
					  	  p->swap_file = NULL;
					  	  ..
    struct file *swap_file = sis->swap_file;
    struct address_space *mapping = swap_file->f_mapping;[oops!]

Note that for the pages that are swapped in through swap cache, this isn't
an issue. Because the page is locked, and the swap entry will be marked
with SWAP_HAS_CACHE, so swapoff() can not proceed until the page has been
unlocked.

Fix this race by using get/put_swap_device() to guard against concurrent
swapoff.

Fixes: 0bcac06f27d7 ("mm,swap: skip swapcache for swapin of synchronous device")
Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h |  9 +++++++++
 mm/memory.c          | 11 +++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index c9e7fea10b83..46d51d058d05 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -527,6 +527,15 @@ static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 	return NULL;
 }
 
+static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
+{
+	return NULL;
+}
+
+static inline void put_swap_device(struct swap_info_struct *si)
+{
+}
+
 #define swap_address_space(entry)		(NULL)
 #define get_nr_swap_pages()			0L
 #define total_swap_pages			0L
diff --git a/mm/memory.c b/mm/memory.c
index 27014c3bde9f..39c910678387 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3311,6 +3311,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL, *swapcache;
+	struct swap_info_struct *si = NULL;
 	swp_entry_t entry;
 	pte_t pte;
 	int locked;
@@ -3338,14 +3339,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 	}
 
+	/* Prevent swapoff from happening to us. */
+	si = get_swap_device(entry);
+	if (unlikely(!si))
+		goto out;
 
 	delayacct_set_flag(current, DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry, vma, vmf->address);
 	swapcache = page;
 
 	if (!page) {
-		struct swap_info_struct *si = swp_swap_info(entry);
-
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
@@ -3514,6 +3517,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
+	if (si)
+		put_swap_device(si);
 	return ret;
 out_nomap:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3525,6 +3530,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		unlock_page(swapcache);
 		put_page(swapcache);
 	}
+	if (si)
+		put_swap_device(si);
 	return ret;
 }
 
-- 
2.23.0

