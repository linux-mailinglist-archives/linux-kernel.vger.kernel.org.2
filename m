Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF403528D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhDBJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:33:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16337 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhDBJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:33:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBZZ263Nsz9vvQ;
        Fri,  2 Apr 2021 17:31:38 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:33:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <n-horiguchi@ah.jp.nec.com>, <hillf.zj@alibaba-inc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/4] mm/hugeltb: handle the error case in hugetlb_fix_reserve_counts()
Date:   Fri, 2 Apr 2021 05:32:49 -0400
Message-ID: <20210402093249.25137-5-linmiaohe@huawei.com>
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

A rare out of memory error would prevent removal of the reserve map region
for a page. hugetlb_fix_reserve_counts() handles this rare case to avoid
dangling with incorrect counts. Unfortunately, hugepage_subpool_get_pages
and hugetlb_acct_memory could possibly fail too. We should correctly handle
these cases.

Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bdff8d23803f..ca5464ed04b7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -745,13 +745,20 @@ void hugetlb_fix_reserve_counts(struct inode *inode)
 {
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	long rsv_adjust;
+	bool reserved = false;
 
 	rsv_adjust = hugepage_subpool_get_pages(spool, 1);
-	if (rsv_adjust) {
+	if (rsv_adjust > 0) {
 		struct hstate *h = hstate_inode(inode);
 
-		hugetlb_acct_memory(h, 1);
+		if (!hugetlb_acct_memory(h, 1))
+			reserved = true;
+	} else if (!rsv_adjust) {
+		reserved = true;
 	}
+
+	if (!reserved)
+		pr_warn("hugetlb: fix reserve count failed\n");
 }
 
 /*
-- 
2.19.1

