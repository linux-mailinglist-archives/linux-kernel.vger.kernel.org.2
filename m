Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3529236C711
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhD0Ndk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:33:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17046 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbhD0NdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:33:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FV2fv5tX1zPtFQ;
        Tue, 27 Apr 2021 21:29:27 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 27 Apr 2021
 21:32:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/5] mm/huge_memory.c: don't discard hugepage if other processes are mapping it
Date:   Tue, 27 Apr 2021 21:32:14 +0800
Message-ID: <20210427133214.2270207-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210427133214.2270207-1-linmiaohe@huawei.com>
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If other processes are mapping any other subpages of the hugepage, i.e. in
pte-mapped thp case, page_mapcount() will return 1 incorrectly. Then we
would discard the page while other processes are still mapping it. Fix it
by using total_mapcount() which can tell whether other processes are still
mapping it.

Fixes: b8d3c4c3009d ("mm/huge_memory.c: don't split THP page when MADV_FREE syscall is called")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f652be6ecca3..d14fecb8cd00 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1604,7 +1604,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * If other processes are mapping this page, we couldn't discard
 	 * the page unless they all do MADV_FREE so let's skip the page.
 	 */
-	if (page_mapcount(page) != 1)
+	if (total_mapcount(page) != 1)
 		goto out;
 
 	if (!trylock_page(page))
-- 
2.23.0

