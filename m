Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0644723E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhKGJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 04:00:25 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34662 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235268AbhKGJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 04:00:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UvOEkA._1636275457;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UvOEkA._1636275457)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Nov 2021 16:57:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
Date:   Sun,  7 Nov 2021 16:57:25 +0800
Message-Id: <6486fabc3e8c66ff613e150af25e89b3147977a6.1636275127.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Zi Yan pointed out, the syscall move_pages() can return a non-migrated
number larger than the number of pages the users tried to migrate, when a
THP page is failed to migrate. This is confusing for users.

Since other migration scenarios do not care about the actual non-migrated
number of pages except the memory compaction migration which will fix in
following patch. Thus we can change the return value to return the number
of {normal page, THP, hugetlb} instead to avoid this issue, and the number
of THP splits will be considered as the number of non-migrated THP, no matter
how many subpages of the THP are migrated successfully. Meanwhile we should
still keep the migration counters using the number of normal pages.

Co-developed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a11e948..9aafdab 100644
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
@@ -1436,7 +1436,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * It is caller's responsibility to call putback_movable_pages() to return pages
  * to the LRU or free list only if ret != 0.
  *
- * Returns the number of pages that were not migrated, or an error code.
+ * Returns the number of {normal page, THP} that were not migrated, or an error code.
+ * The number of THP splits will be considered as the number of non-migrated THP,
+ * no matter how many subpages of the THP are migrated successfully.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
@@ -1445,6 +1447,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
+	int nr_failed_pages = 0;
 	int nr_succeeded = 0;
 	int nr_thp_succeeded = 0;
 	int nr_thp_failed = 0;
@@ -1456,13 +1459,16 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int swapwrite = current->flags & PF_SWAPWRITE;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
+	LIST_HEAD(thp_split_pages);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
+	bool no_subpage_counting = false;
 
 	trace_mm_migrate_pages_start(mode, reason);
 
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
 
+thp_subpage_migration:
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
 		thp_retry = 0;
@@ -1511,18 +1517,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			case -ENOSYS:
 				/* THP migration is unsupported */
 				if (is_thp) {
-					if (!try_split_thp(page, &page2, from)) {
+					nr_thp_failed++;
+					if (!try_split_thp(page, &page2, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
 
-					nr_thp_failed++;
-					nr_failed += nr_subpages;
+					nr_failed_pages += nr_subpages;
 					break;
 				}
 
 				/* Hugetlb migration is unsupported */
-				nr_failed++;
+				if (!no_subpage_counting)
+					nr_failed++;
+				nr_failed_pages++;
 				break;
 			case -ENOMEM:
 				/*
@@ -1531,16 +1539,19 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * THP NUMA faulting doesn't split THP to retry.
 				 */
 				if (is_thp && !nosplit) {
-					if (!try_split_thp(page, &page2, from)) {
+					nr_thp_failed++;
+					if (!try_split_thp(page, &page2, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
 
-					nr_thp_failed++;
-					nr_failed += nr_subpages;
+					nr_failed_pages += nr_subpages;
 					goto out;
 				}
-				nr_failed++;
+
+				if (!no_subpage_counting)
+					nr_failed++;
+				nr_failed_pages++;
 				goto out;
 			case -EAGAIN:
 				if (is_thp) {
@@ -1566,17 +1577,37 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_thp) {
 					nr_thp_failed++;
-					nr_failed += nr_subpages;
+					nr_failed_pages += nr_subpages;
 					break;
 				}
-				nr_failed++;
+
+				if (!no_subpage_counting)
+					nr_failed++;
+				nr_failed_pages++;
 				break;
 			}
 		}
 	}
-	nr_failed += retry + thp_retry;
+	nr_failed += retry;
 	nr_thp_failed += thp_retry;
-	rc = nr_failed;
+	/*
+	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
+	 * counting in this round, since all subpages of a THP is counted
+	 * as 1 failure in the first round.
+	 */
+	if (!list_empty(&thp_split_pages)) {
+		/*
+		 * Move non-migrated pages (after 10 retries) to ret_pages
+		 * to avoid migrating them again.
+		 */
+		list_splice_init(from, &ret_pages);
+		list_splice_init(&thp_split_pages, from);
+		no_subpage_counting = true;
+		retry = 1;
+		goto thp_subpage_migration;
+	}
+
+	rc = nr_failed + nr_thp_failed;
 out:
 	/*
 	 * Put the permanent failure page back to migration list, they
@@ -1585,11 +1616,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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

