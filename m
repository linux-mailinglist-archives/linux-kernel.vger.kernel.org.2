Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8145D381
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbhKYDPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344377AbhKYDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:13:30 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A2C06175B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 18:45:29 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b11-20020a17090acc0b00b001a9179dc89fso3998387pju.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 18:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0NkXycnp++WCMPOXiZqVAzZ23vC+hI+vajnAgk9bGqo=;
        b=M8vBjOdfurgGe6YilZ2Gz1FZJmcCu+dPBUkSum+oEf0+5YR7VfTY83olzQepCjBz9o
         fY+av4/+YkoANmQOFZLmkKF5R+9AuUddgedOQb5oR+aSpx5d8Rn/sFXCxAT0r0xbfvaJ
         CjBANEy40ar67q5XPeFkeo1W6QhSC7EDDWI2qvCQPK3Qo0U1gIm8f/C+ePsSf5UlY5Oz
         Y6GtzBL0X/HGTc3eHN/5rx75+vNWDY2bahJs8j3OYUTzhBZbzziQqG5WgtyiLyAujJFH
         sWNiIl1ujrNbP46VZ0Nhfx9q8SDKrcJ8J7XyA/j8VAhpUHYLgKI/zPsNdGiy+tDQG0cG
         WQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0NkXycnp++WCMPOXiZqVAzZ23vC+hI+vajnAgk9bGqo=;
        b=ycxoxEyKAwgm16G0C0wfsyPST/yCMPBvcnS4Rw2uYI8bD4x4m+8miHH7+wppwidRs6
         APL3E4qNyGuKZYlQrp37hTsgOoGwdhWQVpA9cP1vVZcyZKeoxMYb+uxkVKTKzKGo37Cu
         I5/+lVdvFhx4gIEwds4F/lJJz8R4htxvDWbipANiPUs/vUPwVvg/5z1yeJbgqxxNcbhB
         LKmvgrS36I/6GqoUdl9t0rWQHBPowKUHhhxqKeNtJHeHEzbA7mEkkWFQsAj5yTrMijO6
         qCQbyjfBH2DQ7BjdLVUQpuT7gKqQvKYixw+Rv5SyaoffsC5Q647g3ghscAlnJhrYGYl7
         vE7Q==
X-Gm-Message-State: AOAM532+Xn23lsnLU1G796+R5A9i9C6zPfZRLB9CyBNMRtdtWNQ2s2y+
        UsGFD18JaxoMl4DC0O8kNZmsRM23mUeWGQ==
X-Google-Smtp-Source: ABdhPJzB8r6yZOW/btpLT5N1CuBGniGwZ/rV09IiIr3n9kIdXY/fFiGrmoslk2VWYtn5m98qzefEXv+ayAW1yA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:f071:61d4:52ee:1801])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:3b8e:: with SMTP id
 pc14mr2617778pjb.129.1637808328631; Wed, 24 Nov 2021 18:45:28 -0800 (PST)
Date:   Wed, 24 Nov 2021 18:45:23 -0800
Message-Id: <20211125024523.2468946-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2] mm: split thp synchronously on MADV_DONTNEED and munmap
From:   Shakeel Butt <shakeelb@google.com>
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many applications do sophisticated management of their heap memory for
better performance but with low cost. We have a bunch of such
applications running on our production and examples include caching and
data storage services. These applications keep their hot data on the
THPs for better performance and release the cold data through
MADV_DONTNEED to keep the memory cost low.

The kernel defers the split and release of THPs until there is memory
pressure. This complicates the memory management of these sophisticated
applications which then needs to look into low level kernel handling of
THPs to better gauge their headroom for expansion.

More specifically these applications monitor their cgroup usage to decide
if they can expand the memory footprint or release some (unneeded/cold)
buffer. They uses madvise(MADV_DONTNEED) to release the memory which
basically puts the THP into defer list. These deferred THPs are still
charged to the cgroup which leads to bloated usage read by the application
and making wrong decisions. In addition these applications are very
latency sensitive and would prefer to not face memory reclaim due to
non-deterministic nature of reclaim.

Internally we added a cgroup interface to trigger the split of deferred
THPs for that cgroup but this is hacky and exposing kernel internals to
users. This patch solves this problem in a more general way for the users
by splitting the THPS synchronously on MADV_DONTNEED. This patch does
the same for munmap() too.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- Switched from task_struct based list passing to zap_details struct as
  suggested by Kirill A. Shutemov.
- Updated commit message as suggested by David Hildenbrand.
- Covers munmap() use-case as well as suggested by David Hildenbrand.
- This patch has dependency on Peter Xu's patch "mm: Don't skip swap
  entry even if zap_details specified".


 include/linux/huge_mm.h |  2 +-
 include/linux/mm.h      |  5 +++
 include/linux/mmzone.h  |  5 +++
 include/linux/rmap.h    |  1 +
 mm/huge_memory.c        | 75 ++++++++++++++++++++++++++++++++-------
 mm/madvise.c            |  2 +-
 mm/memory.c             | 78 +++++++++++++++++++++++++++++++----------
 mm/mmap.c               |  2 +-
 mm/rmap.c               | 27 ++++++++++----
 9 files changed, 158 insertions(+), 39 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f280f33ff223..9b8c6e575426 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -191,7 +191,7 @@ static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list(page, NULL);
 }
-void deferred_split_huge_page(struct page *page);
+void deferred_split_huge_page(struct page *page, struct list_head *list);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct page *page);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e7bddca64e56..f6bcbe79e754 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1831,6 +1831,7 @@ extern void user_shm_unlock(size_t, struct ucounts *);
 struct zap_details {
 	struct address_space *zap_mapping;	/* Check page->mapping if set */
 	struct page *single_page;		/* Locked page to be unmapped */
+	struct list_head *defer_list;		/* List to ret THPs to split */
 };
 
 /*
@@ -1856,8 +1857,12 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
+void zap_page_range_sync(struct vm_area_struct *vma, unsigned long address,
+			 unsigned long size);
 void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long start, unsigned long end);
+void unmap_vmas_sync(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
+		     unsigned long start, unsigned long end);
 
 struct mmu_notifier_range;
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..7fa0035128b9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -795,6 +795,11 @@ struct deferred_split {
 	struct list_head split_queue;
 	unsigned long split_queue_len;
 };
+void split_local_deferred_list(struct list_head *defer_list);
+#else
+static inline void split_local_deferred_list(struct list_head *defer_list)
+{
+}
 #endif
 
 /*
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 221c3c6438a7..e5cdefabbb2f 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -175,6 +175,7 @@ void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long, bool);
 void page_add_file_rmap(struct page *, bool);
+void page_remove_rmap_list(struct page *, bool, struct list_head *);
 void page_remove_rmap(struct page *, bool);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..0b49d46736fc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2751,7 +2751,7 @@ void free_transhuge_page(struct page *page)
 	free_compound_page(page);
 }
 
-void deferred_split_huge_page(struct page *page)
+static void add_to_defer_list(struct page *page)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(page);
 #ifdef CONFIG_MEMCG
@@ -2759,6 +2759,22 @@ void deferred_split_huge_page(struct page *page)
 #endif
 	unsigned long flags;
 
+	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	if (list_empty(page_deferred_list(page))) {
+		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
+		ds_queue->split_queue_len++;
+#ifdef CONFIG_MEMCG
+		if (memcg)
+			set_shrinker_bit(memcg, page_to_nid(page),
+					 deferred_split_shrinker.id);
+#endif
+	}
+	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+}
+
+void deferred_split_huge_page(struct page *page, struct list_head *list)
+{
 	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 
 	/*
@@ -2774,18 +2790,53 @@ void deferred_split_huge_page(struct page *page)
 	if (PageSwapCache(page))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	if (list_empty(page_deferred_list(page))) {
-		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
-		ds_queue->split_queue_len++;
-#ifdef CONFIG_MEMCG
-		if (memcg)
-			set_shrinker_bit(memcg, page_to_nid(page),
-					 deferred_split_shrinker.id);
-#endif
+	if (list && list_empty(page_deferred_list(page))) {
+		/* corresponding put in split_local_deferred_list. */
+		get_page(page);
+		list_add(page_deferred_list(page), list);
+		return;
+	}
+
+	add_to_defer_list(page);
+}
+
+void split_local_deferred_list(struct list_head *defer_list)
+{
+	LIST_HEAD(list), *pos, *next;
+	struct page *page;
+	int ret;
+
+	list_for_each_safe(pos, next, defer_list) {
+		page = list_entry((void *)pos, struct page, deferred_list);
+		page = compound_head(page);
+
+		if (!trylock_page(page))
+			continue;
+		/*
+		 * Don't let split_huge_page() mess with per-node or per-memcg
+		 * deferred list.
+		 */
+		list_del_init(page_deferred_list(page));
+
+		ret = split_huge_page(page);
+		unlock_page(page);
+
+		if (ret)
+			list_move(page_deferred_list(page), &list);
+		else
+			put_page(page);
+	}
+	list_splice_tail(&list, defer_list);
+
+	list_for_each_safe(pos, next, defer_list) {
+		page = list_entry((void *)pos, struct page, deferred_list);
+		page = compound_head(page);
+
+		list_del_init(page_deferred_list(page));
+		add_to_defer_list(page);
+		/* corresponding get in deferred_split_huge_page. */
+		put_page(page);
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
diff --git a/mm/madvise.c b/mm/madvise.c
index c63aacbbfa78..08b802597be2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -795,7 +795,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
-	zap_page_range(vma, start, end - start);
+	zap_page_range_sync(vma, start, end - start);
 	return 0;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index f2f08cbe4eee..8d1c561ed392 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1316,6 +1316,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	struct list_head *list = details ? details->defer_list : NULL;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1354,7 +1355,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
+			page_remove_rmap_list(page, false, list);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
 			if (unlikely(__tlb_remove_page(tlb, page))) {
@@ -1373,7 +1374,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			rss[mm_counter(page)]--;
 			if (is_device_private_entry(entry))
-				page_remove_rmap(page, false);
+				page_remove_rmap_list(page, false, list);
 			put_page(page);
 		} else if (is_migration_entry(entry)) {
 			page = pfn_swap_entry_to_page(entry);
@@ -1573,6 +1574,22 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 	}
 }
 
+static void unmap_vmas_details(struct mmu_gather *tlb,
+			       struct vm_area_struct *vma,
+			       unsigned long start_addr,
+			       unsigned long end_addr,
+			       struct zap_details *details)
+{
+	struct mmu_notifier_range range;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
+				start_addr, end_addr);
+	mmu_notifier_invalidate_range_start(&range);
+	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
+		unmap_single_vma(tlb, vma, start_addr, end_addr, details);
+	mmu_notifier_invalidate_range_end(&range);
+}
+
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlb: address of the caller's struct mmu_gather
@@ -1594,15 +1611,39 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 void unmap_vmas(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr)
+{
+	unmap_vmas_details(tlb, vma, start_addr, end_addr, NULL);
+}
+
+/* Same as unmap_vmas() but also splits THPs synchronously. */
+void unmap_vmas_sync(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start_addr, unsigned long end_addr)
+{
+	LIST_HEAD(list);
+	struct zap_details details = {
+		.defer_list = &list,
+	};
+
+	unmap_vmas_details(tlb, vma, start_addr, end_addr, &details);
+	split_local_deferred_list(&list);
+}
+
+static void zap_page_range_details(struct vm_area_struct *vma, unsigned long start,
+		unsigned long size, struct zap_details *details)
 {
 	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
 
-	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
-				start_addr, end_addr);
+	lru_add_drain();
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
+				start, start + size);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
+	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
-		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
+		unmap_single_vma(&tlb, vma, start, range.end, details);
 	mmu_notifier_invalidate_range_end(&range);
+	tlb_finish_mmu(&tlb);
 }
 
 /**
@@ -1616,19 +1657,20 @@ void unmap_vmas(struct mmu_gather *tlb,
 void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 		unsigned long size)
 {
-	struct mmu_notifier_range range;
-	struct mmu_gather tlb;
+	zap_page_range_details(vma, start, size, NULL);
+}
 
-	lru_add_drain();
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
-				start, start + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm);
-	update_hiwater_rss(vma->vm_mm);
-	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
-		unmap_single_vma(&tlb, vma, start, range.end, NULL);
-	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb);
+/* Same as zap_page_range() but also splits THPs synchronously. */
+void zap_page_range_sync(struct vm_area_struct *vma, unsigned long start,
+		unsigned long size)
+{
+	LIST_HEAD(list);
+	struct zap_details details = {
+		.defer_list = &list,
+	};
+
+	zap_page_range_details(vma, start, size, &details);
+	split_local_deferred_list(&list);
 }
 
 /**
diff --git a/mm/mmap.c b/mm/mmap.c
index 85edb0011453..089eb7242b96 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2652,7 +2652,7 @@ static void unmap_region(struct mm_struct *mm,
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
+	unmap_vmas_sync(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
diff --git a/mm/rmap.c b/mm/rmap.c
index 2908d637bcad..b8a0fc077e83 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1292,7 +1292,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		clear_page_mlock(page);
 }
 
-static void page_remove_anon_compound_rmap(struct page *page)
+static void page_remove_anon_compound_rmap(struct page *page,
+					   struct list_head *list)
 {
 	int i, nr;
 
@@ -1324,7 +1325,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		 * small page is still mapped.
 		 */
 		if (nr && nr < thp_nr_pages(page))
-			deferred_split_huge_page(page);
+			deferred_split_huge_page(page, list);
 	} else {
 		nr = thp_nr_pages(page);
 	}
@@ -1337,13 +1338,15 @@ static void page_remove_anon_compound_rmap(struct page *page)
 }
 
 /**
- * page_remove_rmap - take down pte mapping from a page
+ * page_remove_rmap_list - take down pte mapping from a page
  * @page:	page to remove mapping from
  * @compound:	uncharge the page as compound or small page
+ * @list:	list to return THPs to split
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page, bool compound)
+void page_remove_rmap_list(struct page *page, bool compound,
+			   struct list_head *list)
 {
 	lock_page_memcg(page);
 
@@ -1353,7 +1356,7 @@ void page_remove_rmap(struct page *page, bool compound)
 	}
 
 	if (compound) {
-		page_remove_anon_compound_rmap(page);
+		page_remove_anon_compound_rmap(page, list);
 		goto out;
 	}
 
@@ -1372,7 +1375,7 @@ void page_remove_rmap(struct page *page, bool compound)
 		clear_page_mlock(page);
 
 	if (PageTransCompound(page))
-		deferred_split_huge_page(compound_head(page));
+		deferred_split_huge_page(compound_head(page), list);
 
 	/*
 	 * It would be tidy to reset the PageAnon mapping here,
@@ -1387,6 +1390,18 @@ void page_remove_rmap(struct page *page, bool compound)
 	unlock_page_memcg(page);
 }
 
+/**
+ * page_remove_rmap - take down pte mapping from a page
+ * @page:	page to remove mapping from
+ * @compound:	uncharge the page as compound or small page
+ *
+ * The caller needs to hold the pte lock.
+ */
+void page_remove_rmap(struct page *page, bool compound)
+{
+	page_remove_rmap_list(page, compound, NULL);
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
-- 
2.34.0.rc2.393.gf8c9666880-goog

