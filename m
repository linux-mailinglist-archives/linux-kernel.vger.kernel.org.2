Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0393B363D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhDSHzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:55:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:39234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238009AbhDSHy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:54:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13588AE06;
        Mon, 19 Apr 2021 07:54:26 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v10 2/7] mm,compaction: Let isolate_migratepages_{range,block} return error codes
Date:   Mon, 19 Apr 2021 09:54:08 +0200
Message-Id: <20210419075413.1064-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210419075413.1064-1-osalvador@suse.de>
References: <20210419075413.1064-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, isolate_migratepages_{range,block} and their callers use
a pfn == 0 vs pfn != 0 scheme to let the caller know whether there was
any error during isolation.
This does not work as soon as we need to start reporting different error
codes and make sure we pass them down the chain, so they are properly
interpreted by functions like e.g: alloc_contig_range.

Let us rework isolate_migratepages_{range,block} so we can report error
codes.
Since isolate_migratepages_block will stop returning the next pfn to be
scanned, we reuse the cc->migrate_pfn field to keep track of that.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/compaction.c | 52 +++++++++++++++++++++++++---------------------------
 mm/internal.h   | 10 ++++++++--
 mm/page_alloc.c |  7 +++----
 3 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8c5028bfbd56..110b90d5fff5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -787,15 +787,14 @@ static bool too_many_isolated(pg_data_t *pgdat)
  *
  * Isolate all pages that can be migrated from the range specified by
  * [low_pfn, end_pfn). The range is expected to be within same pageblock.
- * Returns zero if there is a fatal signal pending, otherwise PFN of the
- * first page that was not scanned (which may be both less, equal to or more
- * than end_pfn).
+ * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
+ * or 0.
+ * cc->migrate_pfn will contain the next pfn to scan.
  *
  * The pages are isolated on cc->migratepages list (not required to be empty),
- * and cc->nr_migratepages is updated accordingly. The cc->migrate_pfn field
- * is neither read nor updated.
+ * and cc->nr_migratepages is updated accordingly.
  */
-static unsigned long
+static int
 isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			unsigned long end_pfn, isolate_mode_t isolate_mode)
 {
@@ -809,6 +808,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	bool skip_on_failure = false;
 	unsigned long next_skip_pfn = 0;
 	bool skip_updated = false;
+	int ret = 0;
+
+	cc->migrate_pfn = low_pfn;
 
 	/*
 	 * Ensure that there are not too many pages isolated from the LRU
@@ -818,16 +820,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	while (unlikely(too_many_isolated(pgdat))) {
 		/* stop isolation if there are still pages not migrated */
 		if (cc->nr_migratepages)
-			return 0;
+			return -EAGAIN;
 
 		/* async migration should just abort */
 		if (cc->mode == MIGRATE_ASYNC)
-			return 0;
+			return -EAGAIN;
 
 		congestion_wait(BLK_RW_ASYNC, HZ/10);
 
 		if (fatal_signal_pending(current))
-			return 0;
+			return -EINTR;
 	}
 
 	cond_resched();
@@ -875,8 +877,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 			if (fatal_signal_pending(current)) {
 				cc->contended = true;
+				ret = -EINTR;
 
-				low_pfn = 0;
 				goto fatal_pending;
 			}
 
@@ -1130,7 +1132,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	if (nr_isolated)
 		count_compact_events(COMPACTISOLATED, nr_isolated);
 
-	return low_pfn;
+	cc->migrate_pfn = low_pfn;
+
+	return ret;
 }
 
 /**
@@ -1139,15 +1143,14 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
  * @start_pfn: The first PFN to start isolating.
  * @end_pfn:   The one-past-last PFN.
  *
- * Returns zero if isolation fails fatally due to e.g. pending signal.
- * Otherwise, function returns one-past-the-last PFN of isolated page
- * (which may be greater than end_pfn if end fell in a middle of a THP page).
+ * Returns -EAGAIN when contented, -EINTR in case of a signal pending or 0.
  */
-unsigned long
+int
 isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 							unsigned long end_pfn)
 {
 	unsigned long pfn, block_start_pfn, block_end_pfn;
+	int ret = 0;
 
 	/* Scan block by block. First and last block may be incomplete */
 	pfn = start_pfn;
@@ -1166,17 +1169,17 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 					block_end_pfn, cc->zone))
 			continue;
 
-		pfn = isolate_migratepages_block(cc, pfn, block_end_pfn,
-							ISOLATE_UNEVICTABLE);
+		ret = isolate_migratepages_block(cc, pfn, block_end_pfn,
+						 ISOLATE_UNEVICTABLE);
 
-		if (!pfn)
+		if (ret)
 			break;
 
 		if (cc->nr_migratepages >= COMPACT_CLUSTER_MAX)
 			break;
 	}
 
-	return pfn;
+	return ret;
 }
 
 #endif /* CONFIG_COMPACTION || CONFIG_CMA */
@@ -1847,7 +1850,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	 */
 	for (; block_end_pfn <= cc->free_pfn;
 			fast_find_block = false,
-			low_pfn = block_end_pfn,
+			cc->migrate_pfn = low_pfn = block_end_pfn,
 			block_start_pfn = block_end_pfn,
 			block_end_pfn += pageblock_nr_pages) {
 
@@ -1889,10 +1892,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		}
 
 		/* Perform the isolation */
-		low_pfn = isolate_migratepages_block(cc, low_pfn,
-						block_end_pfn, isolate_mode);
-
-		if (!low_pfn)
+		if (isolate_migratepages_block(cc, low_pfn, block_end_pfn,
+						isolate_mode))
 			return ISOLATE_ABORT;
 
 		/*
@@ -1903,9 +1904,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		break;
 	}
 
-	/* Record where migration scanner will be restarted. */
-	cc->migrate_pfn = low_pfn;
-
 	return cc->nr_migratepages ? ISOLATE_SUCCESS : ISOLATE_NONE;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index f469f69309de..46eb82eaa195 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -244,7 +244,13 @@ struct compact_control {
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
 	unsigned long free_pfn;		/* isolate_freepages search base */
-	unsigned long migrate_pfn;	/* isolate_migratepages search base */
+	/*
+	 * Acts as an in/out parameter to page isolation for migration.
+	 * isolate_migratepages uses it as a search base.
+	 * isolate_migratepages_block will update the value to the next pfn
+	 * after the last isolated one.
+	 */
+	unsigned long migrate_pfn;
 	unsigned long fast_start_pfn;	/* a pfn to start linear scan from */
 	struct zone *zone;
 	unsigned long total_migrate_scanned;
@@ -280,7 +286,7 @@ struct capture_control {
 unsigned long
 isolate_freepages_range(struct compact_control *cc,
 			unsigned long start_pfn, unsigned long end_pfn);
-unsigned long
+int
 isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
 int find_suitable_fallback(struct free_area *area, unsigned int order,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 689454692de1..b5a94de3cdde 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8690,11 +8690,10 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 
 		if (list_empty(&cc->migratepages)) {
 			cc->nr_migratepages = 0;
-			pfn = isolate_migratepages_range(cc, pfn, end);
-			if (!pfn) {
-				ret = -EINTR;
+			ret = isolate_migratepages_range(cc, pfn, end);
+			if (ret && ret != -EAGAIN)
 				break;
-			}
+			pfn = cc->migrate_pfn;
 			tries = 0;
 		} else if (++tries == 5) {
 			ret = -EBUSY;
-- 
2.16.3

