Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683EA3528D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhDBJdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:33:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16336 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhDBJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:33:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBZZ25mBJz9vtR;
        Fri,  2 Apr 2021 17:31:38 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:33:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <n-horiguchi@ah.jp.nec.com>, <hillf.zj@alibaba-inc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for hugetlb_acct_memory()
Date:   Fri, 2 Apr 2021 05:32:48 -0400
Message-ID: <20210402093249.25137-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210402093249.25137-1-linmiaohe@huawei.com>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resv_map could be NULL since this routine can be called in the evict
inode path for all hugetlbfs inodes. So we could have chg = 0 and this
would result in a negative value when chg - freed. This is unexpected for
hugepage_subpool_put_pages() and hugetlb_acct_memory().

Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b7864abded3d..bdff8d23803f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5413,6 +5413,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	long chg = 0;
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	long gbl_reserve;
+	long delta;
 
 	/*
 	 * Since this routine can be called in the evict inode path for all
@@ -5437,7 +5438,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	 * If the subpool has a minimum size, the number of global
 	 * reservations to be released may be adjusted.
 	 */
-	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
+	delta = chg > 0 ? chg - freed : freed;
+	gbl_reserve = hugepage_subpool_put_pages(spool, delta);
 	hugetlb_acct_memory(h, -gbl_reserve);
 
 	return 0;
-- 
2.19.1

