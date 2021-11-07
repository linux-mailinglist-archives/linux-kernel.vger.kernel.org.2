Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CC044723F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhKGJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 04:00:26 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56104 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235267AbhKGJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 04:00:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UvO3j9d_1636275458;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UvO3j9d_1636275458)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Nov 2021 16:57:38 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
Date:   Sun,  7 Nov 2021 16:57:26 +0800
Message-Id: <71a4b6c22f208728fe8c78ad26375436c4ff9704.1636275127.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the migration stats for hugetlb with using compound_nr() instead
of thp_nr_pages(), meanwhile change 'nr_failed_pages' to record the
number of normal pages failed to migrate, including THP and hugetlb,
and 'nr_succeeded' will record the number of normal pages migrated
successfully.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 9aafdab..756190b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1436,9 +1436,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * It is caller's responsibility to call putback_movable_pages() to return pages
  * to the LRU or free list only if ret != 0.
  *
- * Returns the number of {normal page, THP} that were not migrated, or an error code.
- * The number of THP splits will be considered as the number of non-migrated THP,
- * no matter how many subpages of the THP are migrated successfully.
+ * Returns the number of {normal page, THP, hugetlb} that were not migrated, or
+ * an error code. The number of THP splits will be considered as the number of
+ * non-migrated THP, no matter how many subpages of the THP are migrated successfully.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
@@ -1481,7 +1481,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 * during migration.
 			 */
 			is_thp = PageTransHuge(page) && !PageHuge(page);
-			nr_subpages = thp_nr_pages(page);
+			nr_subpages = compound_nr(page);
 			cond_resched();
 
 			if (PageHuge(page))
@@ -1530,7 +1530,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/* Hugetlb migration is unsupported */
 				if (!no_subpage_counting)
 					nr_failed++;
-				nr_failed_pages++;
+				nr_failed_pages += nr_subpages;
 				break;
 			case -ENOMEM:
 				/*
@@ -1551,7 +1551,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 				if (!no_subpage_counting)
 					nr_failed++;
-				nr_failed_pages++;
+				nr_failed_pages += nr_subpages;
 				goto out;
 			case -EAGAIN:
 				if (is_thp) {
@@ -1561,12 +1561,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
@@ -1583,7 +1582,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 				if (!no_subpage_counting)
 					nr_failed++;
-				nr_failed_pages++;
+				nr_failed_pages += nr_subpages;
 				break;
 			}
 		}
-- 
1.8.3.1

