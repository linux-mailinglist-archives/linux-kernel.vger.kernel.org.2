Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA235ABA0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhDJHZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:25:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17306 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbhDJHZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:25:03 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FHRKQ2fRDz9xRP;
        Sat, 10 Apr 2021 15:22:34 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 10 Apr 2021
 15:24:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH v2 3/5] mm/hugeltb: clarify (chg - freed) won't go negative in hugetlb_unreserve_pages()
Date:   Sat, 10 Apr 2021 03:23:46 -0400
Message-ID: <20210410072348.20437-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210410072348.20437-1-linmiaohe@huawei.com>
References: <20210410072348.20437-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resv_map could be NULL since this routine can be called in the evict
inode path for all hugetlbfs inodes and we will have chg = 0 in this case.
But (chg - freed) won't go negative as Mike pointed out:

 "If resv_map is NULL, then no hugetlb pages can be allocated/associated
  with the file.  As a result, remove_inode_hugepages will never find any
  huge pages associated with the inode and the passed value 'freed' will
  always be zero."

Add a comment clarifying this to make it clear and also avoid confusion.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9b4c05699a90..387c9a62615e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5435,6 +5435,9 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	/*
 	 * If the subpool has a minimum size, the number of global
 	 * reservations to be released may be adjusted.
+	 *
+	 * Note that !resv_map implies freed == 0. So (chg - freed)
+	 * won't go negative.
 	 */
 	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
 	hugetlb_acct_memory(h, -gbl_reserve);
-- 
2.19.1

