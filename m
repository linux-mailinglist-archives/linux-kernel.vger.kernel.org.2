Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7BD363D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhDSHzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:55:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:39234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238059AbhDSHy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:54:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 516A7AF1A;
        Mon, 19 Apr 2021 07:54:28 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 5/7] mm: Make alloc_contig_range handle free hugetlb pages
Date:   Mon, 19 Apr 2021 09:54:11 +0200
Message-Id: <20210419075413.1064-6-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210419075413.1064-1-osalvador@suse.de>
References: <20210419075413.1064-1-osalvador@suse.de>
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
users of hugetlb will notice the change.
To allocate the new huge page, we use alloc_buddy_huge_page(), so we
do not have to deal with any counters, and prep_new_huge_page() is not
called. This is valulable because in case we need to free the new page,
we only need to call __free_pages().

Once we know that the page to be replaced is a genuine 0-refcounted
huge page, we remove the old page from the freelist by remove_hugetlb_page().
Then, we can call __prep_new_huge_page() and __prep_account_new_huge_page()
for the new huge page to properly initialize it and increment the
hstate->nr_huge_pages counter (previously decremented by
remove_hugetlb_page()).
Once done, the page is enqueued by enqueue_huge_page() and it is ready
to be used.

There is one tricky case when
page's refcount is 0 because it is in the process of being released.
A missing PageHugeFreed bit will tell us that freeing is in flight so
we retry after dropping the hugetlb_lock. The race window should be
small and the next retry should make a forward progress.

E.g:

CPU0				CPU1
free_huge_page()		isolate_or_dissolve_huge_page
				  PageHuge() == T
				  alloc_and_dissolve_huge_page
				    alloc_buddy_huge_page()
				    spin_lock_irq(hugetlb_lock)
				    // PageHuge() && !PageHugeFreed &&
				    // !PageCount()
				    spin_unlock_irq(hugetlb_lock)
  spin_lock_irq(hugetlb_lock)
  1) update_and_free_page
       PageHuge() == F
       __free_pages()
  2) enqueue_huge_page
       SetPageHugeFreed()
  spin_unlock_irq(&hugetlb_lock)
				  spin_lock_irq(hugetlb_lock)
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
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |   6 +++
 mm/compaction.c         |  33 ++++++++++++--
 mm/hugetlb.c            | 116 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 09f1fd12a6fa..b2d2118bfd1a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -595,6 +595,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
+int isolate_or_dissolve_huge_page(struct page *page);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -877,6 +878,11 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
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
index 110b90d5fff5..af2e8e194e50 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -788,7 +788,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
  * Isolate all pages that can be migrated from the range specified by
  * [low_pfn, end_pfn). The range is expected to be within same pageblock.
  * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
- * or 0.
+ * -ENOMEM in case we could not allocate a page, or 0.
  * cc->migrate_pfn will contain the next pfn to scan.
  *
  * The pages are isolated on cc->migratepages list (not required to be empty),
@@ -906,6 +906,29 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			valid_page = page;
 		}
 
+		if (PageHuge(page) && cc->alloc_contig) {
+			ret = isolate_or_dissolve_huge_page(page);
+
+			/*
+			 * Fail isolation in case isolate_or_dissolve_huge_page()
+			 * reports an error. In case of -ENOMEM, abort right away.
+			 */
+			if (ret < 0) {
+				 /* Do not report -EBUSY down the chain */
+				if (ret == -EBUSY)
+					ret = 0;
+				low_pfn += (1UL << compound_order(page)) - 1;
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
@@ -1065,7 +1088,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		put_page(page);
 
 isolate_fail:
-		if (!skip_on_failure)
+		if (!skip_on_failure && ret != -ENOMEM)
 			continue;
 
 		/*
@@ -1091,6 +1114,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 */
 			next_skip_pfn += 1UL << cc->order;
 		}
+
+		if (ret == -ENOMEM)
+			break;
 	}
 
 	/*
@@ -1143,7 +1169,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
  * @start_pfn: The first PFN to start isolating.
  * @end_pfn:   The one-past-last PFN.
  *
- * Returns -EAGAIN when contented, -EINTR in case of a signal pending or 0.
+ * Returns -EAGAIN when contented, -EINTR in case of a signal pending, -ENOMEM
+ * in case we could not allocate a page, or 0.
  */
 int
 isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6f39ec79face..cc2463953fab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2266,6 +2266,122 @@ static void restore_reserve_on_error(struct hstate *h,
 	}
 }
 
+/*
+ * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
+ * @h: struct hstate old page belongs to
+ * @old_page: Old page to dissolve
+ * Returns 0 on success, otherwise negated error.
+ */
+static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
+{
+	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nid = page_to_nid(old_page);
+	struct page *new_page;
+	int ret = 0;
+
+	/*
+	 * Before dissolving the page, we need to allocate a new one for the
+	 * pool to remain stable. Using alloc_buddy_huge_page() allows us to
+	 * not having to deal with prep_new_huge_page() and avoids dealing of any
+	 * counters. This simplifies and let us do the whole thing under the
+	 * lock.
+	 */
+	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
+	if (!new_page)
+		return -ENOMEM;
+
+retry:
+	spin_lock_irq(&hugetlb_lock);
+	if (!PageHuge(old_page)) {
+		/*
+		 * Freed from under us. Drop new_page too.
+		 */
+		goto free_new;
+	} else if (page_count(old_page)) {
+		/*
+		 * Someone has grabbed the page, fail for now.
+		 */
+		ret = -EBUSY;
+		goto free_new;
+	} else if (!HPageFreed(old_page)) {
+		/*
+		 * Page's refcount is 0 but it has not been enqueued in the
+		 * freelist yet. Race window is small, so we can succeed here if
+		 * we retry.
+		 */
+		spin_unlock_irq(&hugetlb_lock);
+		cond_resched();
+		goto retry;
+	} else {
+		/*
+		 * Ok, old_page is still a genuine free hugepage. Remove it from
+		 * the freelist and decrease the counters. These will be
+		 * incremented again when calling __prep_account_new_huge_page()
+		 * and enqueue_huge_page() for new_page. The counters will remain
+		 * stable since this happens under the lock.
+		 */
+		remove_hugetlb_page(h, old_page, false);
+
+		/*
+		 * new_page needs to be initialized with the standard hugetlb
+		 * state. This is normally done by prep_new_huge_page() but
+		 * that takes hugetlb_lock which is already held so we need to
+		 * open code it here.
+		 * Reference count trick is needed because allocator gives us
+		 * referenced page but the pool requires pages with 0 refcount.
+		 */
+		__prep_new_huge_page(new_page);
+		__prep_account_new_huge_page(h, nid);
+		page_ref_dec(new_page);
+		enqueue_huge_page(h, new_page);
+
+		/*
+		 * Pages have been replaced, we can safely free the old one.
+		 */
+		spin_unlock_irq(&hugetlb_lock);
+		update_and_free_page(h, old_page);
+	}
+
+	return ret;
+
+free_new:
+	spin_unlock_irq(&hugetlb_lock);
+	__free_pages(new_page, huge_page_order(h));
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
+	spin_lock_irq(&hugetlb_lock);
+	if (PageHuge(page)) {
+		head = compound_head(page);
+		h = page_hstate(head);
+	} else {
+		spin_unlock_irq(&hugetlb_lock);
+		return 0;
+	}
+	spin_unlock_irq(&hugetlb_lock);
+
+	/*
+	 * Fence off gigantic pages as there is a cyclic dependency between
+	 * alloc_contig_range and them. Return -ENOMEM as this has the effect
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

