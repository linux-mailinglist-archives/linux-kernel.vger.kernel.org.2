Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8B43F7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhJ2HpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:45:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40440 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhJ2HpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:45:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uu6r.YH_1635493368;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uu6r.YH_1635493368)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 15:42:48 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate: Correct the hugetlb migration stats
Date:   Fri, 29 Oct 2021 15:42:37 +0800
Message-Id: <b35e54802a9a82d03d24845b463e9d9a68f7fd6b.1635491660.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now hugetlb migration is also available for some scenarios, such as
soft offling or memory compaction. So we should correct the migration
stats for hugetlb with using compound_nr() instead of thp_nr_pages()
to get the number of pages.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a11e948..2b45a29 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1475,7 +1475,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			 * during migration.
 			 */
 			is_thp = PageTransHuge(page) && !PageHuge(page);
-			nr_subpages = thp_nr_pages(page);
+			nr_subpages = compound_nr(page);
 			cond_resched();
 
 			if (PageHuge(page))
@@ -1540,7 +1540,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed += nr_subpages;
 					goto out;
 				}
-				nr_failed++;
+				nr_failed += nr_subpages;
 				goto out;
 			case -EAGAIN:
 				if (is_thp) {
@@ -1550,14 +1550,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
+				nr_failed += nr_subpages;
 				/*
 				 * Permanent failure (-EBUSY, etc.):
 				 * unlike -EAGAIN case, the failed page is
@@ -1566,10 +1566,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_thp) {
 					nr_thp_failed++;
-					nr_failed += nr_subpages;
 					break;
 				}
-				nr_failed++;
 				break;
 			}
 		}
-- 
1.8.3.1

