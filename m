Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111AB444030
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhKCKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:54:20 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:22931 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231922AbhKCKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:54:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UutTv9L_1635936687;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UutTv9L_1635936687)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Nov 2021 18:51:28 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
Date:   Wed,  3 Nov 2021 18:51:15 +0800
Message-Id: <c07ad378b6c7e67cba8d3eef1af786613386a042.1635936218.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the migration stats for hugetlb with using compound_nr() instead
of thp_nr_pages(), meanwhile change 'nr_failed_pages' to record the
number of normal pages failed to migrate, including THP and hugetlb,
and 'nr_succeeded' will record the number of normal pages migrated
successfully.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 00b8922..00e231c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1436,7 +1436,8 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * It is caller's responsibility to call putback_movable_pages() to return pages
  * to the LRU or free list only if ret != 0.
  *
- * Returns the number of {normal page, THP} that were not migrated, or an error code.
+ * Returns the number of {normal page, THP, hugetlb} that were not migrated,
+ * or an error code.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
@@ -1476,7 +1477,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 * during migration.
 			 */
 			is_thp = PageTransHuge(page) && !PageHuge(page);
-			nr_subpages = thp_nr_pages(page);
+			nr_subpages = compound_nr(page);
 			cond_resched();
 
 			if (PageHuge(page))
@@ -1523,6 +1524,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				}
 
 				/* Hugetlb migration is unsupported */
+				nr_failed_pages++;
 				nr_failed++;
 				break;
 			case -ENOMEM:
@@ -1541,6 +1543,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed_pages += nr_subpages;
 					goto out;
 				}
+				nr_failed_pages += nr_subpages;
 				nr_failed++;
 				goto out;
 			case -EAGAIN:
@@ -1551,12 +1554,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				retry++;
 				break;
 			case MIGRATEPAGE_SUCCESS:
+				nr_succeeded += nr_subpages;
 				if (is_thp) {
 					nr_thp_succeeded++;
-					nr_succeeded += nr_subpages;
 					break;
 				}
-				nr_succeeded++;
 				break;
 			default:
 				/*
@@ -1565,9 +1567,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * removed from migration page list and not
 				 * retried in the next outer loop.
 				 */
+				nr_failed_pages += nr_subpages;
 				if (is_thp) {
 					nr_thp_failed++;
-					nr_failed_pages += nr_subpages;
 					break;
 				}
 				nr_failed++;
@@ -1576,7 +1578,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		}
 	}
 	nr_failed += retry + thp_retry;
-	nr_failed_pages += nr_failed;
 	nr_thp_failed += thp_retry;
 	rc = nr_failed + nr_thp_failed;
 out:
-- 
1.8.3.1

