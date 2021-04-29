Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51636EB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhD2N15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:27:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17051 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbhD2N14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:27:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FWGRf6xKCzPvcD;
        Thu, 29 Apr 2021 21:23:58 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Apr 2021
 21:26:58 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 4/5] mm/huge_memory.c: remove unnecessary tlb_remove_page_size() for huge zero pmd
Date:   Thu, 29 Apr 2021 21:26:47 +0800
Message-ID: <20210429132648.305447-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210429132648.305447-1-linmiaohe@huawei.com>
References: <20210429132648.305447-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aa88b68c3b1d ("thp: keep huge zero page pinned until tlb flush")
introduced tlb_remove_page() for huge zero page to keep it pinned until
flush is complete and prevents the page from being split under us. But
huge zero page is kept pinned until all relevant mm_users reach zero since
the commit 6fcb52a56ff6 ("thp: reduce usage of huge zero page's atomic
counter"). So tlb_remove_page_size() for huge zero pmd is unnecessary now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e24a96de2e37..af30338ac49c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1680,12 +1680,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
-		if (is_huge_zero_pmd(orig_pmd))
-			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
-		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else {
 		struct page *page = NULL;
 		int flush_needed = 1;
-- 
2.23.0

