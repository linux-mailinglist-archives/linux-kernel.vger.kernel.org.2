Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71345365A28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhDTNcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:32:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17805 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhDTNcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:32:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPl022kKBzBrVQ;
        Tue, 20 Apr 2021 21:29:22 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Apr 2021
 21:31:38 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 2/4] swap: fix do_swap_page() race with swapoff
Date:   Tue, 20 Apr 2021 09:30:46 -0400
Message-ID: <20210420133048.6773-3-linmiaohe@huawei.com>
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

CPU 1                                   	CPU 2
-----                                   	-----
do_swap_page
  if (data_race(si->flags & SWP_SYNCHRONOUS_IO)
  swap_readpage
    if (data_race(sis->flags & SWP_FS_OPS)) {
                                        	swapoff
					  	  p->flags &= ~SWP_VALID;
					  	  ..
					  	  synchronize_rcu();
					  	  ..
					  	  p->swap_file = NULL;
    struct file *swap_file = sis->swap_file;
    struct address_space *mapping = swap_file->f_mapping;[oops!]

Note that for the pages that are swapped in through swap cache, this isn't
an issue. Because the page is locked, and the swap entry will be marked
with SWAP_HAS_CACHE, so swapoff() can not proceed until the page has been
unlocked.

Using current get/put_swap_device() to guard against concurrent swapoff for
swap_readpage() looks terrible because swap_readpage() may take really long
time. And this race may not be really pernicious because swapoff is usually
done when system shutdown only. To reduce the performance overhead on the
hot-path as much as possible, it appears we can use the percpu_ref to close
this race window(as suggested by Huang, Ying).

Fixes: 0bcac06f27d7 ("mm,swap: skip swapcache for swapin of synchronous device")
Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h | 9 +++++++++
 mm/memory.c          | 9 +++++++++
 2 files changed, 18 insertions(+)

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
index 27014c3bde9f..7a2fe12cf641 100644
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
@@ -3338,6 +3339,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 	}
 
+	/* Prevent swapoff from happening to us. */
+	si = get_swap_device(entry);
+	if (unlikely(!si))
+		goto out;
 
 	delayacct_set_flag(current, DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry, vma, vmf->address);
@@ -3514,6 +3519,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
+	if (si)
+		put_swap_device(si);
 	return ret;
 out_nomap:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3525,6 +3532,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		unlock_page(swapcache);
 		put_page(swapcache);
 	}
+	if (si)
+		put_swap_device(si);
 	return ret;
 }
 
-- 
2.19.1

