Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA331EA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhBRNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:54:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:58972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231837AbhBRMBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:01:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4576CAEBE;
        Thu, 18 Feb 2021 12:00:40 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/2] mm: Make alloc_contig_range handle in-use hugetlb pages
Date:   Thu, 18 Feb 2021 13:00:28 +0100
Message-Id: <20210218120028.6499-3-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210218120028.6499-1-osalvador@suse.de>
References: <20210218120028.6499-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range() will fail miserably if it finds a HugeTLB page
within the range, without a chance to handle them. Since HugeTLB pages
can be migrated as any other page (LRU and Movable), it does not make
sense to bail out without trying.
Enable the interface to recognize in-use HugeTLB pages so we can migrate
them, and have much better chances to succeed the call.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |  5 +++--
 mm/compaction.c         | 12 +++++++++++-
 mm/hugetlb.c            |  6 ++++--
 mm/vmscan.c             |  5 +++--
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 72352d718829..8c17d0dbc87c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -505,7 +505,7 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
-bool isolate_or_dissolve_huge_page(struct page *page);
+bool isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
@@ -776,7 +776,8 @@ void set_page_huge_active(struct page *page);
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
-static inline bool isolate_or_dissolve_huge_page(struct page *page)
+static inline bool isolate_or_dissolve_huge_page(struct page *page,
+						 struct list_head *list)
 {
 	return false;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index d52506ed9db7..3394ab385915 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -906,9 +906,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		if (PageHuge(page) && cc->alloc_contig) {
-			if (!isolate_or_dissolve_huge_page(page))
+			if (!isolate_or_dissolve_huge_page(page, &cc->migratepages))
 				goto isolate_fail;
 
+			if (PageHuge(page)) {
+				/*
+				 * Hugepage was succesfully isolated and placed
+				 * on the cc->migratepages list.
+				 */
+				low_pfn += compound_nr(page) - 1;
+				goto isolate_success_no_list;
+			}
+
 			/*
 			 * Ok, the hugepage was dissolved. Now these pages are
 			 * Buddy and cannot be re-allocated because they are
@@ -1053,6 +1062,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
+isolate_success_no_list:
 		cc->nr_migratepages += compound_nr(page);
 		nr_isolated += compound_nr(page);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a4fbbe924a55..1208b5f278b0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2336,7 +2336,7 @@ static bool alloc_and_dissolve_huge_page(struct hstate *h, struct page *page)
 	return ret;
 }
 
-bool isolate_or_dissolve_huge_page(struct page *page)
+bool isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 {
 	struct hstate *h = NULL;
 	struct page *head;
@@ -2363,7 +2363,9 @@ bool isolate_or_dissolve_huge_page(struct page *page)
 	if (hstate_is_gigantic(h))
 		return ret;
 
-	if(!page_count(head) && alloc_and_dissolve_huge_page(h, head))
+	if (page_count(head) && isolate_huge_page(head, list))
+		ret = true;
+	else if(!page_count(head) && alloc_and_dissolve_huge_page(h, head))
 		ret = true;
 
 	return ret;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b1b574ad199d..0803adca4469 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1506,8 +1506,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
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

