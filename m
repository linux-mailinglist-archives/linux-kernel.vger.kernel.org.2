Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432BA3E1787
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbhHEPGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:06:37 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:37871 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233228AbhHEPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:06:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui3FG-Y_1628175970;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui3FG-Y_1628175970)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 23:06:10 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm: migrate: Remove redundant goto labels
Date:   Thu,  5 Aug 2021 23:06:00 +0800
Message-Id: <d359dcf73a7a868f1b126cb73368fea64aec1f25.1628174413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant goto labels to simplify the code.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0ab364f..ed74fda 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -911,9 +911,8 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		 */
 		VM_BUG_ON_PAGE(!PageIsolated(page), page);
 		if (!PageMovable(page)) {
-			rc = MIGRATEPAGE_SUCCESS;
 			__ClearPageIsolated(page);
-			goto out;
+			return MIGRATEPAGE_SUCCESS;
 		}
 
 		rc = mapping->a_ops->migratepage(mapping, newpage,
@@ -949,7 +948,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 			flush_dcache_page(newpage);
 
 	}
-out:
+
 	return rc;
 }
 
@@ -2095,11 +2094,10 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
 	newpage = alloc_pages_node(nid, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 				   HPAGE_PMD_ORDER);
 	if (!newpage)
-		goto out;
+		return NULL;
 
 	prep_transhuge_page(newpage);
 
-out:
 	return newpage;
 }
 
-- 
1.8.3.1

