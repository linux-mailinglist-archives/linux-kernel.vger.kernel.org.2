Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21139358436
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDHNJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:09:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16416 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhDHNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:09:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGM4K6dVwzkjbq;
        Thu,  8 Apr 2021 21:07:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:09:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <ying.huang@intel.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
Date:   Thu, 8 Apr 2021 09:08:17 -0400
Message-ID: <20210408130820.48233-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210408130820.48233-1-linmiaohe@huawei.com>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
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

CPU 1					CPU 2
-----					-----
do_swap_page
  synchronous swap_readpage
    alloc_page_vma
					swapoff
					  release swap_file, bdev, or ...
      swap_readpage
	check sis->flags is ok
	  access swap_file, bdev...[oops!]
					    si->flags = 0

Using current get/put_swap_device() to guard against concurrent swapoff for
swap_readpage() looks terrible because swap_readpage() may take really long
time. And this race may not be really pernicious because swapoff is usually
done when system shutdown only. To reduce the performance overhead on the
hot-path as much as possible, it appears we can use the percpu_ref to close
this race window(as suggested by Huang, Ying).

Fixes: 235b62176712 ("mm/swap: add cluster lock")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h |  2 +-
 mm/memory.c          | 10 ++++++++++
 mm/swapfile.c        | 28 +++++++++++-----------------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 849ba5265c11..9066addb57fd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -513,7 +513,7 @@ sector_t swap_page_sector(struct page *page);
 
 static inline void put_swap_device(struct swap_info_struct *si)
 {
-	rcu_read_unlock();
+	percpu_ref_put(&si->users);
 }
 
 #else /* CONFIG_SWAP */
diff --git a/mm/memory.c b/mm/memory.c
index cc71a445c76c..8543c47b955c 100644
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
@@ -3339,6 +3340,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 
+	si = get_swap_device(entry);
+	/* In case we raced with swapoff. */
+	if (unlikely(!si))
+		goto out;
+
 	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry, vma, vmf->address);
 	swapcache = page;
@@ -3514,6 +3520,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
+	if (si)
+		put_swap_device(si);
 	return ret;
 out_nomap:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3525,6 +3533,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		unlock_page(swapcache);
 		put_page(swapcache);
 	}
+	if (si)
+		put_swap_device(si);
 	return ret;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 724173cd7d0c..01032c72ceae 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1280,18 +1280,12 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  * via preventing the swap device from being swapoff, until
  * put_swap_device() is called.  Otherwise return NULL.
  *
- * The entirety of the RCU read critical section must come before the
- * return from or after the call to synchronize_rcu() in
- * enable_swap_info() or swapoff().  So if "si->flags & SWP_VALID" is
- * true, the si->map, si->cluster_info, etc. must be valid in the
- * critical section.
- *
  * Notice that swapoff or swapoff+swapon can still happen before the
- * rcu_read_lock() in get_swap_device() or after the rcu_read_unlock()
- * in put_swap_device() if there isn't any other way to prevent
- * swapoff, such as page lock, page table lock, etc.  The caller must
- * be prepared for that.  For example, the following situation is
- * possible.
+ * percpu_ref_tryget_live() in get_swap_device() or after the
+ * percpu_ref_put() in put_swap_device() if there isn't any other way
+ * to prevent swapoff, such as page lock, page table lock, etc.  The
+ * caller must be prepared for that.  For example, the following
+ * situation is possible.
  *
  *   CPU1				CPU2
  *   do_swap_page()
@@ -1319,21 +1313,21 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	si = swp_swap_info(entry);
 	if (!si)
 		goto bad_nofile;
-
-	rcu_read_lock();
 	if (data_race(!(si->flags & SWP_VALID)))
-		goto unlock_out;
+		goto out;
+	if (!percpu_ref_tryget_live(&si->users))
+		goto out;
 	offset = swp_offset(entry);
 	if (offset >= si->max)
-		goto unlock_out;
+		goto put_out;
 
 	return si;
 bad_nofile:
 	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
 out:
 	return NULL;
-unlock_out:
-	rcu_read_unlock();
+put_out:
+	percpu_ref_put(&si->users);
 	return NULL;
 }
 
-- 
2.19.1

