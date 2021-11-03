Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AAE44402F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhKCKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:54:09 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41870 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231383AbhKCKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:54:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UutTv9S_1635936688;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UutTv9S_1635936688)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Nov 2021 18:51:29 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] mm: compaction: Fix the migration stats in trace_mm_compaction_migratepages()
Date:   Wed,  3 Nov 2021 18:51:16 +0800
Message-Id: <6fac1a89862b6a8bda4314d1f51380862a6fa986.1635936218.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the migrate_pages() has changed to return the number of {normal page,
THP, hugetlb} instead, thus we should not use the return value to calculate
the number of pages migrated successfully. Instead we can just use the
'nr_succeeded' which indicates the number of normal pages migrated successfully
to calculate the non-migrated pages in trace_mm_compaction_migratepages().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/trace/events/compaction.h | 24 ++++--------------------
 mm/compaction.c                   |  7 ++++---
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 54e5bf0..7d48e70 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -68,10 +68,9 @@
 TRACE_EVENT(mm_compaction_migratepages,
 
 	TP_PROTO(unsigned long nr_all,
-		int migrate_rc,
-		struct list_head *migratepages),
+		unsigned int nr_succeeded),
 
-	TP_ARGS(nr_all, migrate_rc, migratepages),
+	TP_ARGS(nr_all, nr_succeeded),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, nr_migrated)
@@ -79,23 +78,8 @@
 	),
 
 	TP_fast_assign(
-		unsigned long nr_failed = 0;
-		struct list_head *page_lru;
-
-		/*
-		 * migrate_pages() returns either a non-negative number
-		 * with the number of pages that failed migration, or an
-		 * error code, in which case we need to count the remaining
-		 * pages manually
-		 */
-		if (migrate_rc >= 0)
-			nr_failed = migrate_rc;
-		else
-			list_for_each(page_lru, migratepages)
-				nr_failed++;
-
-		__entry->nr_migrated = nr_all - nr_failed;
-		__entry->nr_failed = nr_failed;
+		__entry->nr_migrated = nr_succeeded;
+		__entry->nr_failed = nr_all - nr_succeeded;
 	),
 
 	TP_printk("nr_migrated=%lu nr_failed=%lu",
diff --git a/mm/compaction.c b/mm/compaction.c
index 6e44609..b4e94cd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2280,6 +2280,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
+	unsigned int nr_succeeded = 0;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2398,10 +2399,10 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION, NULL);
+				MR_COMPACTION, &nr_succeeded);
 
-		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
-							&cc->migratepages);
+		trace_mm_compaction_migratepages(cc->nr_migratepages,
+						 nr_succeeded);
 
 		/* All pages were either migrated or will be released */
 		cc->nr_migratepages = 0;
-- 
1.8.3.1

