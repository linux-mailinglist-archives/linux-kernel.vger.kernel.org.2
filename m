Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E123F4349
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 04:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhHWCGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 22:06:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:60158 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234700AbhHWCGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 22:06:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="215174612"
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="215174612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2021 19:06:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="535162433"
Received: from yhe6-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.98])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2021 19:06:07 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Seth Jennings <sjenning@redhat.com>
Subject: [RFC] swap: call get/put_swap_device() at high level
Date:   Mon, 23 Aug 2021 10:03:55 +0800
Message-Id: <20210823020355.38635-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit eb085574a752 ("mm, swap: fix race between swapoff and some
swap operations"), we fixed a race between swapoff and some swap
operations via enclosing these swap operations with
get/put_swap_device().  So that, swapoff will not proceed to free the
data structure used during the swap operations.

Because RCU read lock is held between get/put_swap_device(), the
enclosed code needs to be kept small and quick.  We have to add
get/put_swap_device() here and there, e.g., during do_swap_page()
running, get/put_swap_device() will be called in lookup_swap_cache(),
__read_swap_cache_async(), __swap_count(), __swap_duplicate().  And
more importantly, there's not some general and simple rule about when
to call get/put_swap_device().

Then, in commit 63d8620ecf93 ("mm/swapfile: use percpu_ref to
serialize against concurrent swapoff"), to fix the race
between swapoff and some other swap operations, we reimplemented
get/put_swap_device() based on percpu_ref.  Because it's not a big
issue to delay the completion of swapoff for a while, now we can
enclose a long code path with get/put_swap_device().

So in this patch, we revise the rule to call get/put_swap_device() as
follows.

When we get a swap entry (e.g. from page table, or shmem xarray, etc),
and don't hold the necessary locks to prevent swapoff (e.g. page table
lock, or page lock, etc), we will enclose all following swap
operations with get/put_swap_device().

That is, a swap entry is a kind of reference to the swap device, and
we need to increase the reference count to the swap device when we
get the swap entry to operate on the swap device.

Then, we revise the code to follow the rule.  For example, in
do_swap_page(), we will enclose most code with get/put_swap_device(),
and remove get/put_swap_device() in most callees (lookup_swap_cache(),
__read_swap_cache_async(), __swap_count(), __swap_duplicate(), etc.).

This will make it easier to understand the code to deal with the race
between swapoff and various swap operations.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Seth Jennings <sjenning@redhat.com>
---
 mm/madvise.c    | 10 ++++++++++
 mm/memory.c     |  8 +++++++-
 mm/shmem.c      |  6 ++++++
 mm/swap_state.c | 23 ++++++++++++-----------
 mm/swapfile.c   | 36 ++++++------------------------------
 mm/zswap.c      |  5 +++++
 6 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..50099430ee61 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -199,6 +199,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		swp_entry_t entry;
 		struct page *page;
 		spinlock_t *ptl;
+		struct swap_info_struct *si;
 
 		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
@@ -209,11 +210,15 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		entry = pte_to_swp_entry(pte);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
+		si = get_swap_device(entry);
+		if (!si)
+			continue;
 
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
 							vma, index, false);
 		if (page)
 			put_page(page);
+		put_swap_device(si);
 	}
 
 	return 0;
@@ -234,6 +239,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_index) {
 		swp_entry_t swap;
+		struct swap_info_struct *si;
 
 		if (!xa_is_value(page))
 			continue;
@@ -241,10 +247,14 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 		rcu_read_unlock();
 
 		swap = radix_to_swp_entry(page);
+		si = get_swap_device(swap);
+		if (!si)
+			continue;
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
 							NULL, 0, false);
 		if (page)
 			put_page(page);
+		put_swap_device(si);
 
 		rcu_read_lock();
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 39e7a1495c3c..2e5e49470ca3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1012,6 +1012,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	int progress, ret = 0;
 	int rss[NR_MM_COUNTERS];
 	swp_entry_t entry = (swp_entry_t){0};
+	struct swap_info_struct *si;
 	struct page *prealloc = NULL;
 
 again:
@@ -1052,6 +1053,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 						  addr, rss);
 			if (ret == -EIO) {
 				entry = pte_to_swp_entry(*src_pte);
+				si = get_swap_device(entry);
 				break;
 			} else if (ret == -EBUSY) {
 				break;
@@ -1096,8 +1098,12 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	cond_resched();
 
 	if (ret == -EIO) {
+		int err;
+
 		VM_WARN_ON_ONCE(!entry.val);
-		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
+		err = add_swap_count_continuation(entry, GFP_KERNEL);
+		put_swap_device(si);
+		if (err < 0) {
 			ret = -ENOMEM;
 			goto out;
 		}
diff --git a/mm/shmem.c b/mm/shmem.c
index a5ae8266891d..9893c9a63278 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1718,6 +1718,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct page *page;
+	struct swap_info_struct *si;
 	swp_entry_t swap;
 	int error;
 
@@ -1725,6 +1726,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	swap = radix_to_swp_entry(*pagep);
 	*pagep = NULL;
 
+	si = get_swap_device(swap);
+	if (!si)
+		return -EEXIST;
 	/* Look it up and read it in.. */
 	page = lookup_swap_cache(swap, NULL, 0);
 	if (!page) {
@@ -1784,6 +1788,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	delete_from_swap_cache(page);
 	set_page_dirty(page);
 	swap_free(swap);
+	put_swap_device(si);
 
 	*pagep = page;
 	return 0;
@@ -1795,6 +1800,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 		unlock_page(page);
 		put_page(page);
 	}
+	put_swap_device(si);
 
 	return error;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..89d5f189b2c1 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -335,14 +335,8 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 			       unsigned long addr)
 {
 	struct page *page;
-	struct swap_info_struct *si;
 
-	si = get_swap_device(entry);
-	if (!si)
-		return NULL;
 	page = find_get_page(swap_address_space(entry), swp_offset(entry));
-	put_swap_device(si);
-
 	INC_CACHE_INFO(find_total);
 	if (page) {
 		bool vma_ra = swap_use_vma_readahead();
@@ -418,7 +412,6 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr,
 			bool *new_page_allocated)
 {
-	struct swap_info_struct *si;
 	struct page *page;
 	void *shadow = NULL;
 
@@ -431,12 +424,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * called after lookup_swap_cache() failed, re-calling
 		 * that would confuse statistics.
 		 */
-		si = get_swap_device(entry);
-		if (!si)
-			return NULL;
 		page = find_get_page(swap_address_space(entry),
 				     swp_offset(entry));
-		put_swap_device(si);
 		if (page)
 			return page;
 
@@ -794,10 +783,12 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	pte_t *pte, pentry;
 	swp_entry_t entry;
 	unsigned int i;
+	unsigned int type, ftype = swp_type(fentry);
 	bool page_allocated;
 	struct vma_swap_readahead ra_info = {
 		.win = 1,
 	};
+	struct swap_info_struct *si = NULL;
 
 	swap_ra_info(vmf, &ra_info);
 	if (ra_info.win == 1)
@@ -814,6 +805,14 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		entry = pte_to_swp_entry(pentry);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
+		type = swp_type(entry);
+		if (type != ftype && (!si || si->type != type)) {
+			if (si)
+				put_swap_device(si);
+			si = get_swap_device(entry);
+			if (!si)
+				continue;
+		}
 		page = __read_swap_cache_async(entry, gfp_mask, vma,
 					       vmf->address, &page_allocated);
 		if (!page)
@@ -827,6 +826,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		}
 		put_page(page);
 	}
+	if (si)
+		put_swap_device(si);
 	blk_finish_plug(&plug);
 	lru_add_drain();
 skip:
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3dcaeecc50f..d7cd7fe2eaf9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1472,14 +1472,9 @@ int __swap_count(swp_entry_t entry)
 {
 	struct swap_info_struct *si;
 	pgoff_t offset = swp_offset(entry);
-	int count = 0;
 
-	si = get_swap_device(entry);
-	if (si) {
-		count = swap_count(si->swap_map[offset]);
-		put_swap_device(si);
-	}
-	return count;
+	si = swp_swap_info(entry);
+	return swap_count(si->swap_map[offset]);
 }
 
 static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
@@ -1501,15 +1496,10 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
  */
 int __swp_swapcount(swp_entry_t entry)
 {
-	int count = 0;
 	struct swap_info_struct *si;
 
-	si = get_swap_device(entry);
-	if (si) {
-		count = swap_swapcount(si, entry);
-		put_swap_device(si);
-	}
-	return count;
+	si = swp_swap_info(entry);
+	return swap_swapcount(si, entry);
 }
 
 /*
@@ -3430,10 +3420,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	unsigned char has_cache;
 	int err;
 
-	p = get_swap_device(entry);
-	if (!p)
-		return -EINVAL;
-
+	p = swp_swap_info(entry);
 	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
 
@@ -3479,8 +3466,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
-	if (p)
-		put_swap_device(p);
 	return err;
 }
 
@@ -3581,14 +3566,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	 */
 	page = alloc_page(gfp_mask | __GFP_HIGHMEM);
 
-	si = get_swap_device(entry);
-	if (!si) {
-		/*
-		 * An acceptable race has occurred since the failing
-		 * __swap_duplicate(): the swap device may be swapoff
-		 */
-		goto outer;
-	}
+	si = swp_swap_info(entry);
 	spin_lock(&si->lock);
 
 	offset = swp_offset(entry);
@@ -3660,8 +3638,6 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 out:
 	unlock_cluster(ci);
 	spin_unlock(&si->lock);
-	put_swap_device(si);
-outer:
 	if (page)
 		__free_page(page);
 	return ret;
diff --git a/mm/zswap.c b/mm/zswap.c
index 7944e3e57e78..f707a73e35aa 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -902,9 +902,14 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
 				struct page **retpage)
 {
 	bool page_was_allocated;
+	struct swap_info_struct *si;
 
+	si = get_swap_device(entry);
+	if (!si)
+		return ZSWAP_SWAPCACHE_FAIL;
 	*retpage = __read_swap_cache_async(entry, GFP_KERNEL,
 			NULL, 0, &page_was_allocated);
+	put_swap_device(si);
 	if (page_was_allocated)
 		return ZSWAP_SWAPCACHE_NEW;
 	if (!*retpage)
-- 
2.30.2

