Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27370362EF7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbhDQJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:42:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16476 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhDQJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:42:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FMp2C1LWnzyPLG;
        Sat, 17 Apr 2021 17:39:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 17 Apr 2021
 17:41:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 3/5] swap: fix do_swap_page() race with swapoff
Date:   Sat, 17 Apr 2021 05:40:37 -0400
Message-ID: <20210417094039.51711-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210417094039.51711-1-linmiaohe@huawei.com>
References: <20210417094039.51711-1-linmiaohe@huawei.com>
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
  swap_readpage(skip swap cache case)
    if (data_race(sis->flags & SWP_FS_OPS)) {
                                        	swapoff
					  	  p->flags = &= ~SWP_VALID;
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
index 993693b38109..523c2411a135 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -528,6 +528,15 @@ static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
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

