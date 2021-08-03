Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE473DF112
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhHCPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:09:03 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41124 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234206AbhHCPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:09:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uht0IwF_1628003329;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uht0IwF_1628003329)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Aug 2021 23:08:50 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/swap: Remove the unused get_kernel_page()
Date:   Tue,  3 Aug 2021 23:07:04 +0800
Message-Id: <a6137b871658cdbd0cde9fbeecf2168bc8ec87e9.1628002955.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there are no users of the get_kernel_page() function,
thus remove it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mm.h |  1 -
 mm/swap.c          | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7bc883c..dbfee57 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1953,7 +1953,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 struct kvec;
 int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
 			struct page **pages);
-int get_kernel_page(unsigned long start, int write, struct page **pages);
 struct page *get_dump_page(unsigned long addr);
 
 extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
diff --git a/mm/swap.c b/mm/swap.c
index 6f382ab..645b733 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -180,28 +180,6 @@ int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
 }
 EXPORT_SYMBOL_GPL(get_kernel_pages);
 
-/*
- * get_kernel_page() - pin a kernel page in memory
- * @start:	starting kernel address
- * @write:	pinning for read/write, currently ignored
- * @pages:	array that receives pointer to the page pinned.
- *		Must be at least nr_segs long.
- *
- * Returns 1 if page is pinned. If the page was not pinned, returns
- * -errno. The page returned must be released with a put_page() call
- * when it is finished with.
- */
-int get_kernel_page(unsigned long start, int write, struct page **pages)
-{
-	const struct kvec kiov = {
-		.iov_base = (void *)start,
-		.iov_len = PAGE_SIZE
-	};
-
-	return get_kernel_pages(&kiov, 1, write, pages);
-}
-EXPORT_SYMBOL_GPL(get_kernel_page);
-
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec))
 {
-- 
1.8.3.1

