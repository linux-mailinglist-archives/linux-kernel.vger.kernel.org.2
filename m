Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0640392A19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhE0IyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:54:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:40482 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235324AbhE0IyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:54:08 -0400
IronPort-SDR: A0m3bos1XQz3Trby/BiAJFJ4wj+uvu8l+ppVCQk+yIQC5V84+k5VUxaMUK9DwP7BpYprmGMNr8
 WSEbO4nMM1kQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189804382"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="189804382"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:52:34 -0700
IronPort-SDR: viuXd7nw6RVd/O04Pry4t3XGhAzdVILcfCz7UW10oTCpkQqd3vORrQ+UFRcwwQhMKqCRc6bx7s
 6nmojhLVh8+w==
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="444567270"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:52:31 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -V2] mm: move idle swap cache pages to the tail of LRU after COW
Date:   Thu, 27 May 2021 16:49:53 +0800
Message-Id: <20210527084953.573788-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
COW, the idle swap cache (neither the page nor the corresponding swap
entry is mapped by any process) will be left at the original position
in the LRU list.  While it may be in the active list or the head of
the inactive list, so that vmscan may take more overhead or time to
reclaim these actually unused pages.

To help the page reclaiming, in this patch, after COW, the idle swap
cache will be tried to be moved to the tail of the inactive LRU list.
To avoid to introduce much overhead to the hot COW code path, all
locks are acquired with try locking.

To test the patch, we used pmbench memory accessing benchmark with
working-set larger than available memory on a 2-socket Intel server
with a NVMe SSD as swap device.  Test results shows that the pmbench
score increases up to 21.8% with the decreased size of swap cache and
swapin throughput.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>

V2:

- Move trylock_page() to try_to_free_idle_swapcache() per Rik and
  Linus' comments.
- Fix PageLRU() checking.
- Fix THP processing.
- Rename the function.
---
 include/linux/memcontrol.h | 10 ++++++++++
 include/linux/swap.h       |  3 +++
 mm/memcontrol.c            | 12 ++++++++++++
 mm/memory.c                |  2 ++
 mm/swapfile.c              | 39 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3cc18c2176e7..d6c6ff69b586 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -760,6 +760,7 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
 struct lruvec *lock_page_lruvec(struct page *page);
 struct lruvec *lock_page_lruvec_irq(struct page *page);
+struct lruvec *trylock_page_lruvec_irq(struct page *page);
 struct lruvec *lock_page_lruvec_irqsave(struct page *page,
 						unsigned long *flags);
 
@@ -1250,6 +1251,15 @@ static inline struct lruvec *lock_page_lruvec_irq(struct page *page)
 	return &pgdat->__lruvec;
 }
 
+static inline struct lruvec *trylock_page_lruvec_irq(struct page *page)
+{
+	struct pglist_data *pgdat = page_pgdat(page);
+
+	if (spin_trylock_irq(&pgdat->__lruvec.lru_lock))
+		return &pgdat->__lruvec;
+	return NULL;
+}
+
 static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
 		unsigned long *flagsp)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 032485ee7597..dbef99233736 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -509,6 +509,7 @@ extern struct swap_info_struct *page_swap_info(struct page *);
 extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
 extern bool reuse_swap_page(struct page *, int *);
 extern int try_to_free_swap(struct page *);
+extern void deactivate_idle_swapcache(struct page *page);
 struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
@@ -677,6 +678,8 @@ static inline int try_to_free_swap(struct page *page)
 	return 0;
 }
 
+static inline void deactivate_idle_swapcache(struct page *page) {}
+
 static inline swp_entry_t get_swap_page(struct page *page)
 {
 	swp_entry_t entry;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb864f87b01d..a192476fc55c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1213,6 +1213,18 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	return lruvec;
 }
 
+struct lruvec *trylock_page_lruvec_irq(struct page *page)
+{
+	struct lruvec *lruvec;
+
+	lruvec = mem_cgroup_page_lruvec(page);
+	if (spin_trylock_irq(&lruvec->lru_lock)) {
+		lruvec_memcg_debug(lruvec, page);
+		return lruvec;
+	}
+	return NULL;
+}
+
 struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 {
 	struct lruvec *lruvec;
diff --git a/mm/memory.c b/mm/memory.c
index 2b7ffcbca175..8a4b1ccd6879 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3104,6 +3104,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				munlock_vma_page(old_page);
 			unlock_page(old_page);
 		}
+		if (page_copied && PageSwapCache(old_page) && !page_mapped(old_page))
+			deactivate_idle_swapcache(old_page);
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cbb4c0795284..0b390b14c5ae 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -40,6 +40,7 @@
 #include <linux/swap_slots.h>
 #include <linux/sort.h>
 #include <linux/completion.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -1748,6 +1749,44 @@ int try_to_free_swap(struct page *page)
 	return 1;
 }
 
+static inline void locked_deactivate_idle_swapcache(struct page *page)
+{
+	struct lruvec *lruvec;
+
+	page = compound_head(page);
+	if (!PageSwapCache(page))
+		return;
+	if (PageWriteback(page))
+		return;
+	if (page_mapped(page))
+		return;
+	if (!PageLRU(page))
+		return;
+	if (page_swapped(page))
+		return;
+	lruvec = trylock_page_lruvec_irq(page);
+	if (!lruvec)
+		return;
+
+	if (TestClearPageLRU(page)) {
+		del_page_from_lru_list(page, lruvec);
+		ClearPageActive(page);
+		ClearPageReferenced(page);
+		add_page_to_lru_list_tail(page, lruvec);
+		SetPageLRU(page);
+	}
+
+	unlock_page_lruvec_irq(lruvec);
+}
+
+void deactivate_idle_swapcache(struct page *page)
+{
+	if (trylock_page(page)) {
+		locked_deactivate_idle_swapcache(page);
+		unlock_page(page);
+	}
+}
+
 /*
  * Free the swap entry like above, but also try to
  * free the page cache entry if it is the last user.
-- 
2.30.2

