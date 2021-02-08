Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2143A312F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBHKtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:49:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:57590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhBHKi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:38:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A85BBB039;
        Mon,  8 Feb 2021 10:38:15 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 1/2] mm,page_alloc: Make alloc_contig_range handle in-use hugetlb pages
Date:   Mon,  8 Feb 2021 11:38:11 +0100
Message-Id: <20210208103812.32056-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210208103812.32056-1-osalvador@suse.de>
References: <20210208103812.32056-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range is not prepared to handle hugetlb pages and will
fail if it ever sees one, but since they can be migrated as any other
page (LRU and Movable), it makes sense to also handle them.

For now, do it only when coming from alloc_contig_range.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/compaction.c | 17 +++++++++++++++++
 mm/vmscan.c     |  5 +++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e5acb9714436..89cd2e60da29 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -940,6 +940,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			goto isolate_fail;
 		}
 
+		/*
+		 * Handle hugetlb pages only when coming from alloc_contig
+		 */
+		if (PageHuge(page) && cc->alloc_contig) {
+			if (page_count(page)) {
+				/*
+				 * Hugetlb page in-use. Isolate and migrate.
+				 */
+				if (isolate_huge_page(page, &cc->migratepages)) {
+					low_pfn += compound_nr(page) - 1;
+					goto isolate_success_no_list;
+				}
+			}
+			goto isolate_fail;
+		}
+
 		/*
 		 * Check may be lockless but that's ok as we recheck later.
 		 * It's possible to migrate LRU and non-lru movable pages.
@@ -1041,6 +1057,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
+isolate_success_no_list:
 		cc->nr_migratepages += compound_nr(page);
 		nr_isolated += compound_nr(page);
 
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

