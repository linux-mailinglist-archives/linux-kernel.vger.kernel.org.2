Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72A341E04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCSNUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhCSNUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:20:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92222AE72;
        Fri, 19 Mar 2021 13:20:20 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v6 4/5] mm: Make alloc_contig_range handle in-use hugetlb pages
Date:   Fri, 19 Mar 2021 14:20:03 +0100
Message-Id: <20210319132004.4341-5-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210319132004.4341-1-osalvador@suse.de>
References: <20210319132004.4341-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range() will fail if it finds a HugeTLB page within the range,
without a chance to handle them. Since HugeTLB pages can be migrated as any
LRU or Movable page, it does not make sense to bail out without trying.
Enable the interface to recognize in-use HugeTLB pages so we can migrate
them, and have much better chances to succeed the call.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/hugetlb.h |  5 +++--
 mm/compaction.c         | 12 +++++++++++-
 mm/hugetlb.c            | 22 ++++++++++++++++------
 mm/vmscan.c             |  5 +++--
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bcff86ca616f..a37b4ce86e58 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -583,7 +583,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
-int isolate_or_dissolve_huge_page(struct page *page);
+int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -866,7 +866,8 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
-static inline int isolate_or_dissolve_huge_page(struct page *page)
+static inline int isolate_or_dissolve_huge_page(struct page *page,
+						struct list_head *list)
 {
 	return -ENOMEM;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index 3b26c5c6c931..4143d1984a21 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -909,7 +909,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		if (PageHuge(page) && cc->alloc_contig) {
-			ret = isolate_or_dissolve_huge_page(page);
+			ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
 
 			/*
 			 * Fail isolation in case isolate_or_dissolve_huge_page
@@ -926,6 +926,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				goto isolate_fail;
 			}
 
+			if (PageHuge(page)) {
+				/*
+				 * Hugepage was successfully isolated and placed
+				 * on the cc->migratepages list.
+				 */
+				low_pfn += compound_nr(page) - 1;
+				goto isolate_success_no_list;
+			}
+
 			/*
 			 * Ok, the hugepage was dissolved. Now these pages are
 			 * Buddy and cannot be re-allocated because they are
@@ -1067,6 +1076,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
+isolate_success_no_list:
 		cc->nr_migratepages += compound_nr(page);
 		nr_isolated += compound_nr(page);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3194c1bd9e32..85e4bedbd5ac 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2257,7 +2257,8 @@ static void restore_reserve_on_error(struct hstate *h,
  * Returns 0 on success, otherwise negated error.
  */
 
-static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
+static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
+					struct list_head *list)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
@@ -2287,11 +2288,14 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
 		goto unlock;
 	} else if (page_count(old_page)) {
 		/*
-		 * Someone has grabbed the page, fail for now.
+		 * Someone has grabbed the page, try to isolate it here.
+		 * Fail with -EBUSY if not possible.
 		 */
-		ret = -EBUSY;
 		update_and_free_page(h, new_page);
-		goto unlock;
+		spin_unlock(&hugetlb_lock);
+		if (!isolate_huge_page(old_page, list))
+			ret = -EBUSY;
+		return ret;
 	} else if (!HPageFreed(old_page)) {
 		/*
 		 * Page's refcount is 0 but it has not been enqueued in the
@@ -2319,10 +2323,11 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
 	return ret;
 }
 
-int isolate_or_dissolve_huge_page(struct page *page)
+int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 {
 	struct hstate *h;
 	struct page *head;
+	int ret = -EBUSY;
 
 	/*
 	 * The page might have been dissolved from under our feet, so make sure
@@ -2347,7 +2352,12 @@ int isolate_or_dissolve_huge_page(struct page *page)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	return alloc_and_dissolve_huge_page(h, head);
+	if (page_count(head) && isolate_huge_page(head, list))
+		ret = 0;
+	else if (!page_count(head))
+		ret = alloc_and_dissolve_huge_page(h, head, list);
+
+	return ret;
 }
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cbd7a1..42aaef30633e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1507,8 +1507,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	LIST_HEAD(clean_pages);
 
 	list_for_each_entry_safe(page, next, page_list, lru) {
-		if (page_is_file_lru(page) && !PageDirty(page) &&
-		    !__PageMovable(page) && !PageUnevictable(page)) {
+		if (!PageHuge(page) && page_is_file_lru(page) &&
+		    !PageDirty(page) && !__PageMovable(page) &&
+		    !PageUnevictable(page)) {
 			ClearPageActive(page);
 			list_move(&page->lru, &clean_pages);
 		}
-- 
2.16.3

