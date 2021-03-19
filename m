Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CC0341E02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCSNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:20:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:49504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhCSNUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:20:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB9EFAE57;
        Fri, 19 Mar 2021 13:20:19 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v6 3/5] mm: Make alloc_contig_range handle free hugetlb pages
Date:   Fri, 19 Mar 2021 14:20:02 +0100
Message-Id: <20210319132004.4341-4-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210319132004.4341-1-osalvador@suse.de>
References: <20210319132004.4341-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The free page replacement is done under hugetlb_lock, so no external
user of hugetlb will notice the change. There is one tricky case when
page's refcount is 0 because it is in the process of being released.
A missing PageHugeFreed bit will tell us that freeing is in flight so
we retry after dropping the hugetlb_lock. The race window should be
small and the next retry should make a forward progress.

E.g:

CPU0				CPU1
__free_huge_page()		isolate_or_dissolve_huge_page
				  PageHuge() == T
				  alloc_and_dissolve_huge_page
				    alloc_fresh_huge_page()
				    spin_lock(hugetlb_lock)
				    // PageHuge() && !PageHugeFreed &&
				    // !PageCount()
				    spin_unlock(hugetlb_lock)
  spin_lock(hugetlb_lock)
  1) update_and_free_page
       PageHuge() == F
       __free_pages()
  2) enqueue_huge_page
       SetPageHugeFreed()
  spin_unlock(&hugetlb_lock)
				  spin_lock(hugetlb_lock)
                                   1) PageHuge() == F (freed by case#1 from CPU0)
				   2) PageHuge() == T
                                       PageHugeFreed() == T
                                       - proceed with replacing the page

In the case above we retry as the window race is quite small and we have high
chances to succeed next time.

With regard to the allocation, we restrict it to the node the page belongs
to with __GFP_THISNODE, meaning we do not fallback on other node's zones.

Note that gigantic hugetlb pages are fenced off since there is a cyclic
dependency between them and alloc_contig_range.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/hugetlb.h |   6 +++
 mm/compaction.c         |  37 ++++++++++++++--
 mm/hugetlb.c            | 109 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cccd1aab69dd..bcff86ca616f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -583,6 +583,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
+int isolate_or_dissolve_huge_page(struct page *page);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -865,6 +866,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline int isolate_or_dissolve_huge_page(struct page *page)
+{
+	return -ENOMEM;
+}
+
 static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/compaction.c b/mm/compaction.c
index cd090a675321..3b26c5c6c931 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -788,7 +788,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
  * Isolate all pages that can be migrated from the range specified by
  * [low_pfn, end_pfn). The range is expected to be within same pageblock.
  * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
- * or 0.
+ * -ENOMEM in case we could not allocate a page, or 0.
  * cc->migrate_pfn will contain the next pfn to scan (which may be both less,
  * equal to or more that end_pfn).
  *
@@ -809,6 +809,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	bool skip_on_failure = false;
 	unsigned long next_skip_pfn = 0;
 	bool skip_updated = false;
+	bool fatal_error = false;
+	int ret = 0;
 
 	cc->migrate_pfn = low_pfn;
 
@@ -906,6 +908,32 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			valid_page = page;
 		}
 
+		if (PageHuge(page) && cc->alloc_contig) {
+			ret = isolate_or_dissolve_huge_page(page);
+
+			/*
+			 * Fail isolation in case isolate_or_dissolve_huge_page
+			 * reports an error. In case of -ENOMEM, abort right away.
+			 */
+			if (ret < 0) {
+				/*
+				 * Do not report -EBUSY down the chain.
+				 */
+				if (ret == -ENOMEM)
+					fatal_error = true;
+				else
+					ret = 0;
+				goto isolate_fail;
+			}
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
@@ -1091,6 +1119,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 */
 			next_skip_pfn += 1UL << cc->order;
 		}
+
+		if (fatal_error)
+			break;
 	}
 
 	/*
@@ -1134,7 +1165,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	cc->migrate_pfn = low_pfn;
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1144,7 +1175,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
  * @end_pfn:   The one-past-last PFN.
  *
  * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
- * or 0.
+ * -ENOMEM in case we could not allocate a page, or 0.
  */
 int
 isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5b1ab1f427c5..3194c1bd9e32 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1035,13 +1035,18 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
+static void __enqueue_huge_page(struct list_head *list, struct page *page)
+{
+	list_move(&page->lru, list);
+	SetHPageFreed(page);
+}
+
 static void enqueue_huge_page(struct hstate *h, struct page *page)
 {
 	int nid = page_to_nid(page);
-	list_move(&page->lru, &h->hugepage_freelists[nid]);
+	__enqueue_huge_page(&h->hugepage_freelists[nid], page);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
-	SetHPageFreed(page);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -2245,6 +2250,106 @@ static void restore_reserve_on_error(struct hstate *h,
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
+	} else if (!HPageFreed(old_page)) {
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
+int isolate_or_dissolve_huge_page(struct page *page)
+{
+	struct hstate *h;
+	struct page *head;
+
+	/*
+	 * The page might have been dissolved from under our feet, so make sure
+	 * to carefully check the state under the lock.
+	 * Return success when racing as if we dissolved the page ourselves.
+	 */
+	spin_lock(&hugetlb_lock);
+	if (PageHuge(page)) {
+		head = compound_head(page);
+		h = page_hstate(head);
+	} else {
+		spin_unlock(&hugetlb_lock);
+		return 0;
+	}
+	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * Fence off gigantic pages as there is a cyclic dependency between
+	 * alloc_contig_range and them. Return -ENOME as this has the effect
+	 * of bailing out right away without further retrying.
+	 */
+	if (hstate_is_gigantic(h))
+		return -ENOMEM;
+
+	return alloc_and_dissolve_huge_page(h, head);
+}
+
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
-- 
2.16.3

