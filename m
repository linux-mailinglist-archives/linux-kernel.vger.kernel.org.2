Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E887033EF54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCQLNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:13:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhCQLNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:13:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8C72AE05;
        Wed, 17 Mar 2021 11:13:05 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 4/5] mm: Make alloc_contig_range handle in-use hugetlb pages
Date:   Wed, 17 Mar 2021 12:12:50 +0100
Message-Id: <20210317111251.17808-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210317111251.17808-1-osalvador@suse.de>
References: <20210317111251.17808-1-osalvador@suse.de>
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
---
 include/linux/hugetlb.h |  5 +++--
 mm/compaction.c         | 12 +++++++++++-
 mm/hugetlb.c            | 22 +++++++++++++++++++---
 mm/vmscan.c             |  5 +++--
 4 files changed, 36 insertions(+), 8 deletions(-)

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
index 9f253fc3b4f9..6e47855fd154 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -910,7 +910,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		if (PageHuge(page) && cc->alloc_contig) {
-			ret = isolate_or_dissolve_huge_page(page);
+			ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
 
 			/*
 			 * Fail isolation in case isolate_or_dissolve_huge_page
@@ -927,6 +927,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
@@ -1068,6 +1077,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
+isolate_success_no_list:
 		cc->nr_migratepages += compound_nr(page);
 		nr_isolated += compound_nr(page);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3194c1bd9e32..11e86434d8bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2287,7 +2287,9 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
 		goto unlock;
 	} else if (page_count(old_page)) {
 		/*
-		 * Someone has grabbed the page, fail for now.
+		 * Someone has grabbed the page, return -EBUSY so we give
+		 * isolate_or_dissolve_huge_page a chance to handle an in-use
+		 * page.
 		 */
 		ret = -EBUSY;
 		update_and_free_page(h, new_page);
@@ -2319,10 +2321,12 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
 	return ret;
 }
 
-int isolate_or_dissolve_huge_page(struct page *page)
+int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 {
 	struct hstate *h;
 	struct page *head;
+	bool try_again = true;
+	int ret = -EBUSY;
 
 	/*
 	 * The page might have been dissolved from under our feet, so make sure
@@ -2347,7 +2351,19 @@ int isolate_or_dissolve_huge_page(struct page *page)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	return alloc_and_dissolve_huge_page(h, head);
+retry:
+	if (page_count(head) && isolate_huge_page(head, list)) {
+		ret = 0;
+	} else if (!page_count(head)) {
+		ret = alloc_and_dissolve_huge_page(h, head);
+
+		if (ret == -EBUSY && try_again) {
+			try_again = false;
+			goto retry;
+		}
+	}
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

