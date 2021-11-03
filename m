Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397D544402E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhKCKyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:54:07 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44035 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhKCKyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:54:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UutTv9C_1635936687;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UutTv9C_1635936687)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Nov 2021 18:51:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
Date:   Wed,  3 Nov 2021 18:51:14 +0800
Message-Id: <c838c56f12cd3e6c693c0b124a167fdc07f59fb6.1635936218.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Zi Yan pointed out, the syscall move_pages() can return a non-migrated
number larger than the number of pages the users tried to migrate, when a
THP page is failed to migrate. This is confusing for users.

Since other migration scenarios do not care about the actual non-migrated
number of pages except the memory compaction migration which will fix in
following patch. Thus we can change the return value to return the number
of {normal page, THP, hugetlb} instead to avoid this issue, meanwhile we
should still keep the migration counters using the number of normal pages.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a11e948..00b8922 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1428,7 +1428,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * @mode:		The migration mode that specifies the constraints for
  *			page migration, if any.
  * @reason:		The reason for page migration.
- * @ret_succeeded:	Set to the number of pages migrated successfully if
+ * @ret_succeeded:	Set to the number of normal pages migrated successfully if
  *			the caller passes a non-NULL pointer.
  *
  * The function returns after 10 attempts or if no pages are movable any more
@@ -1436,7 +1436,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * It is caller's responsibility to call putback_movable_pages() to return pages
  * to the LRU or free list only if ret != 0.
  *
- * Returns the number of pages that were not migrated, or an error code.
+ * Returns the number of {normal page, THP} that were not migrated, or an error code.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
@@ -1445,6 +1445,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
+	int nr_failed_pages = 0;
 	int nr_succeeded = 0;
 	int nr_thp_succeeded = 0;
 	int nr_thp_failed = 0;
@@ -1517,7 +1518,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					}
 
 					nr_thp_failed++;
-					nr_failed += nr_subpages;
+					nr_failed_pages += nr_subpages;
 					break;
 				}
 
@@ -1537,7 +1538,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					}
 
 					nr_thp_failed++;
-					nr_failed += nr_subpages;
+					nr_failed_pages += nr_subpages;
 					goto out;
 				}
 				nr_failed++;
@@ -1566,7 +1567,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_thp) {
 					nr_thp_failed++;
-					nr_failed += nr_subpages;
+					nr_failed_pages += nr_subpages;
 					break;
 				}
 				nr_failed++;
@@ -1575,8 +1576,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		}
 	}
 	nr_failed += retry + thp_retry;
+	nr_failed_pages += nr_failed;
 	nr_thp_failed += thp_retry;
-	rc = nr_failed;
+	rc = nr_failed + nr_thp_failed;
 out:
 	/*
 	 * Put the permanent failure page back to migration list, they
@@ -1585,11 +1587,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	list_splice(&ret_pages, from);
 
 	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
-	count_vm_events(PGMIGRATE_FAIL, nr_failed);
+	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
 	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
 	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
 	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
+	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
 			       nr_thp_failed, nr_thp_split, mode, reason);
 
 	if (!swapwrite)
-- 
1.8.3.1

