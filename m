Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79070388472
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhESBe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:34:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:58850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhESBe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:34:56 -0400
IronPort-SDR: HHshT0gCdbdAeH060g/xjFnjOEpC3t2NKu2tj/1qOBMmB36X7DOCZ4hCWxU5syu16eq8kdTYuv
 qYEhQMltK8JA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200925570"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200925570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 18:33:37 -0700
IronPort-SDR: hx8bMtbsi2KwAQEa4SOelQFC+WYV5Z4cfZX195eaMLLryloBWqo/GsTVMIHq2yfUYoBpF5y8Ln
 /e2WoNTUQFOQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473240948"
Received: from yhuang6-desk1.sh.intel.com ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 18:33:32 -0700
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
Subject: [PATCH] mm: move idle swap cache pages to the tail of LRU after COW
Date:   Wed, 19 May 2021 09:33:13 +0800
Message-Id: <20210519013313.1274454-1-ying.huang@intel.com>
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
---
 include/linux/memcontrol.h | 10 ++++++++++
 include/linux/swap.h       |  3 +++
 mm/memcontrol.c            | 12 ++++++++++++
 mm/memory.c                |  5 +++++
 mm/swapfile.c              | 29 +++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ce97eff79e2..68956db13772 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -761,6 +761,7 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
 struct lruvec *lock_page_lruvec(struct page *page);
 struct lruvec *lock_page_lruvec_irq(struct page *page);
+struct lruvec *trylock_page_lruvec_irq(struct page *page);
 struct lruvec *lock_page_lruvec_irqsave(struct page *page,
 						unsigned long *flags);
 
@@ -1251,6 +1252,15 @@ static inline struct lruvec *lock_page_lruvec_irq(struct page *page)
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
index 46d51d058d05..d344b0fa7925 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -504,6 +504,7 @@ extern struct swap_info_struct *page_swap_info(struct page *);
 extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
 extern bool reuse_swap_page(struct page *, int *);
 extern int try_to_free_swap(struct page *);
+extern void try_to_free_idle_swapcache(struct page *page);
 struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
@@ -668,6 +669,8 @@ static inline int try_to_free_swap(struct page *page)
 	return 0;
 }
 
+static inline void try_to_free_idle_swapcache(struct page *page) {}
+
 static inline swp_entry_t get_swap_page(struct page *page)
 {
 	swp_entry_t entry;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index db29b96f7311..e3e813bfebe2 100644
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
index b83f734c4e1d..2b6847f4c03e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				munlock_vma_page(old_page);
 			unlock_page(old_page);
 		}
+		if (page_copied && PageSwapCache(old_page) &&
+		    !page_mapped(old_page) && trylock_page(old_page)) {
+			try_to_free_idle_swapcache(old_page);
+			unlock_page(old_page);
+		}
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2aad85751991..e0dd8937de4e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -40,6 +40,7 @@
 #include <linux/swap_slots.h>
 #include <linux/sort.h>
 #include <linux/completion.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -1788,6 +1789,34 @@ int try_to_free_swap(struct page *page)
 	return 1;
 }
 
+void try_to_free_idle_swapcache(struct page *page)
+{
+	struct lruvec *lruvec;
+	swp_entry_t entry;
+
+	if (!PageSwapCache(page))
+		return;
+	if (PageWriteback(page))
+		return;
+	if (!PageLRU(page))
+		return;
+	if (page_mapped(page))
+		return;
+	entry.val = page_private(page);
+	if (__swap_count(entry))
+		return;
+
+	lruvec = trylock_page_lruvec_irq(page);
+	if (!lruvec)
+		return;
+
+	del_page_from_lru_list(page, lruvec);
+	ClearPageActive(page);
+	ClearPageReferenced(page);
+	add_page_to_lru_list_tail(page, lruvec);
+
+	unlock_page_lruvec_irq(lruvec);
+}
 /*
  * Free the swap entry like above, but also try to
  * free the page cache entry if it is the last user.
-- 
2.30.2

