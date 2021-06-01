Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC5396CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhFAFdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:33:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:21530 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhFAFdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:33:41 -0400
IronPort-SDR: GOxffjsJWDLvOOIF4KyMKiIzfcWzHUpfyWKdKFm76+Q7YteyAvf9l/McfWU2V7aLMPphro5Ot0
 vFzz50ainjXA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183836496"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="183836496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 22:32:00 -0700
IronPort-SDR: fnblnD0+UTg3vn/P/LDqEk8ZOwct9IwAzMhJ+x1MnkosNlQ1Xgb00d+km28i8Xsim4wddIO+Kk
 KsUIZ1Xz5C7A==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="446821780"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 22:31:57 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH] mm: free idle swap cache page after COW
Date:   Tue,  1 Jun 2021 13:31:43 +0800
Message-Id: <20210601053143.1380078-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
COW, the idle swap cache page (neither the page nor the corresponding
swap entry is mapped by any process) will be left in the LRU list,
even if it's in the active list or the head of the inactive list.  So,
the page reclaimer may take quite some overhead to reclaim these
actually unused pages.

To help the page reclaiming, in this patch, after COW, the idle swap
cache page will be tried to be freed.  To avoid to introduce much
overhead to the hot COW code path,

a) there's almost zero overhead for non-swap case via checking
   PageSwapCache() firstly.

b) the page lock is acquired via trylock only.

To test the patch, we used pmbench memory accessing benchmark with
working-set larger than available memory on a 2-socket Intel server
with a NVMe SSD as swap device.  Test results shows that the pmbench
score increases up to 23.8% with the decreased size of swap cache and
swapin throughput.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org> # use free_swap_cache()
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
---
 include/linux/swap.h | 5 +++++
 mm/memory.c          | 2 ++
 mm/swap_state.c      | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 032485ee7597..bb4889369a22 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -451,6 +451,7 @@ extern void __delete_from_swap_cache(struct page *page,
 extern void delete_from_swap_cache(struct page *);
 extern void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				unsigned long end);
+extern void free_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
 extern struct page *lookup_swap_cache(swp_entry_t entry,
@@ -560,6 +561,10 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr));
 
+static inline void free_swap_cache(struct page *page)
+{
+}
+
 static inline void show_swap_cache_info(void)
 {
 }
diff --git a/mm/memory.c b/mm/memory.c
index 2b7ffcbca175..d44425820240 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3104,6 +3104,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				munlock_vma_page(old_page);
 			unlock_page(old_page);
 		}
+		if (page_copied)
+			free_swap_cache(old_page);
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b5a3dc8f47a1..95e391f46468 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -285,7 +285,7 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
  * try_to_free_swap() _with_ the lock.
  * 					- Marcelo
  */
-static inline void free_swap_cache(struct page *page)
+void free_swap_cache(struct page *page)
 {
 	if (PageSwapCache(page) && !page_mapped(page) && trylock_page(page)) {
 		try_to_free_swap(page);
-- 
2.30.2

