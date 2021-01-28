Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF93A30749F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhA1LV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:21:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12039 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhA1LVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:21:24 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DRHzd472wzMQvV;
        Thu, 28 Jan 2021 19:19:09 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 28 Jan 2021
 19:20:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hugetlb: Fix some comment typos
Date:   Thu, 28 Jan 2021 06:20:28 -0500
Message-ID: <20210128112028.64831-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos sasitfy to satisfy, reservtion to reservation, hugegpage to
hugepage and uniprocesor to uniprocessor in comments.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/hugetlb.h | 2 +-
 mm/hugetlb.c            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ef5b144b8aac..95a5a239c8f2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -37,7 +37,7 @@ struct hugepage_subpool {
 	struct hstate *hstate;
 	long min_hpages;	/* Minimum huge pages or -1 if no minimum. */
 	long rsv_hpages;	/* Pages reserved against global pool to */
-				/* sasitfy minimum size. */
+				/* satisfy minimum size. */
 };
 
 struct resv_map {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 53ea65d1c5ab..c42c61c2653e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1444,7 +1444,7 @@ static void __free_huge_page(struct page *page)
 	 * reservation.  If the page was associated with a subpool, there
 	 * would have been a page reserved in the subpool before allocation
 	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
-	 * reservtion, do not call hugepage_subpool_put_pages() as this will
+	 * reservation, do not call hugepage_subpool_put_pages() as this will
 	 * remove the reserved page from the subpool.
 	 */
 	if (!restore_reserve) {
@@ -3715,7 +3715,7 @@ static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
- * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
+ * hugepage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
  * this far.
  */
 static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
@@ -4513,7 +4513,7 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 }
 #else
 /*
- * For uniprocesor systems we always use a single mutex, so just
+ * For uniprocessor systems we always use a single mutex, so just
  * return 0 and avoid the hashing overhead.
  */
 u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
-- 
2.19.1

