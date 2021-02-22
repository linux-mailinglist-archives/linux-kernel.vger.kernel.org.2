Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77209321A13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhBVOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:18:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:45966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231867AbhBVNwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:52:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5F96AD5C;
        Mon, 22 Feb 2021 13:51:41 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Date:   Mon, 22 Feb 2021 14:51:36 +0100
Message-Id: <20210222135137.25717-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210222135137.25717-1-osalvador@suse.de>
References: <20210222135137.25717-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range will fail if it ever sees a HugeTLB page within the
range we are trying to allocate, even when that page is free and can be
easily reallocated.
This has proved to be problematic for some users of alloc_contic_range,
e.g: CMA and virtio-mem, where those would fail the call even when those
pages lay in ZONE_MOVABLE and are free.

We can do better by trying to replace such page.

Free hugepages are tricky to handle so as to no userspace application
notices disruption, we need to replace the current free hugepage with
a new one.

In order to do that, a new function called alloc_and_dissolve_huge_page
is introduced.
This function will first try to get a new fresh hugepage, and if it
succeeds, it will replace the old one in the free hugepage pool.

All operations are being handled under hugetlb_lock, so no races are
possible. The only exception is when page's refcount is 0, but it still
has not been flagged as PageHugeFreed.
In this case we retry as the window race is quite small and we have high
chances to succeed next time.

With regard to the allocation, we restrict it to the node the page belongs
to with __GFP_THISNODE, meaning we do not fallback on other node's zones.

Note that gigantic hugetlb pages are fenced off since there is a cyclic
dependency between them and alloc_contig_range.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |   6 +++
 mm/compaction.c         |  12 ++++++
 mm/hugetlb.c            | 111 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b5807f23caf8..72352d718829 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -505,6 +505,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
+bool isolate_or_dissolve_huge_page(struct page *page);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -775,6 +776,11 @@ void set_page_huge_active(struct page *page);
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline bool isolate_or_dissolve_huge_page(struct page *page)
+{
+	return false;
+}
+
 static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/compaction.c b/mm/compaction.c
index 190ccdaa6c19..d52506ed9db7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -905,6 +905,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			valid_page = page;
 		}
 
+		if (PageHuge(page) && cc->alloc_contig) {
+			if (!isolate_or_dissolve_huge_page(page))
+				goto isolate_fail;
+
+			/*
+			 * Ok, the hugepage was dissolved. Now these pages are
+			 * Buddy and cannot be re-allocated because they are
+			 * isolated. Fall-through as the check below handles
+			 * Buddy pages.
+			 */
+		}
+
 		/*
 		 * Skip if free. We read page order here without zone lock
 		 * which is generally unsafe, but the race window is small and
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58ab14cb..56eba64a1d33 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1037,13 +1037,18 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
+static void __enqueue_huge_page(struct list_head *list, struct page *page)
+{
+	list_move(&page->lru, list);
+	SetPageHugeFreed(page);
+}
+
 static void enqueue_huge_page(struct hstate *h, struct page *page)
 {
 	int nid = page_to_nid(page);
-	list_move(&page->lru, &h->hugepage_freelists[nid]);
+	__enqueue_huge_page(&h->hugepage_freelists[nid], page);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
-	SetPageHugeFreed(page);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -2294,6 +2299,108 @@ static void restore_reserve_on_error(struct hstate *h,
 	}
 }
 
+/*
+ * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
+ * @h: struct hstate old page belongs to
+ * @old_page: Old page to dissolve
+ * Returns 0 on success, otherwise negated error.
+ */
+
+static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
+{
+	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nid = page_to_nid(old_page);
+	struct page *new_page;
+	int ret = 0;
+
+	/*
+	 * Before dissolving the page, we need to allocate a new one,
+	 * so the pool remains stable.
+	 */
+	new_page = alloc_fresh_huge_page(h, gfp_mask, nid, NULL, NULL);
+	if (!new_page)
+		return -ENOMEM;
+
+	/*
+	 * Pages got from Buddy are self-refcounted, but free hugepages
+	 * need to have a refcount of 0.
+	 */
+	page_ref_dec(new_page);
+retry:
+	spin_lock(&hugetlb_lock);
+	if (!PageHuge(old_page)) {
+		/*
+		 * Freed from under us. Drop new_page too.
+		 */
+		update_and_free_page(h, new_page);
+		goto unlock;
+	} else if (page_count(old_page)) {
+		/*
+		 * Someone has grabbed the page, fail for now.
+		 */
+		ret = -EBUSY;
+		update_and_free_page(h, new_page);
+		goto unlock;
+	} else if (!PageHugeFreed(old_page)) {
+		/*
+		 * Page's refcount is 0 but it has not been enqueued in the
+		 * freelist yet. Race window is small, so we can succed here if
+		 * we retry.
+		 */
+		spin_unlock(&hugetlb_lock);
+		cond_resched();
+		goto retry;
+	} else {
+		/*
+		 * Ok, old_page is still a genuine free hugepage. Replace it
+		 * with the new one.
+		 */
+		list_del(&old_page->lru);
+		update_and_free_page(h, old_page);
+		/*
+		 * h->free_huge_pages{_node} counters do not need to be updated.
+		 */
+		__enqueue_huge_page(&h->hugepage_freelists[nid], new_page);
+	}
+unlock:
+	spin_unlock(&hugetlb_lock);
+
+	return ret;
+}
+
+bool isolate_or_dissolve_huge_page(struct page *page)
+{
+	struct hstate *h = NULL;
+	struct page *head;
+	bool ret = false;
+
+	spin_lock(&hugetlb_lock);
+	if (PageHuge(page)) {
+		head = compound_head(page);
+		h = page_hstate(head);
+	}
+	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * The page might have been dissolved from under our feet.
+	 * If that is the case, return success as if we dissolved it ourselves.
+	 */
+	if (!h)
+		return true;
+
+	/*
+	 * Fence off gigantic pages as there is a cyclic dependency
+	 * between alloc_contig_range and them.
+	 */
+	if (hstate_is_gigantic(h))
+		return ret;
+
+	if (!page_count(head) && alloc_and_dissolve_huge_page(h, head))
+		ret = true;
+
+	return ret;
+}
+
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
-- 
2.16.3

