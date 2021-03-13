Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BE339D90
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhCMKdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:33:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:14332 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhCMKdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:33:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DyJr21hpjz8x8c;
        Sat, 13 Mar 2021 18:31:14 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Sat, 13 Mar 2021
 18:32:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <richard.weiyang@linux.alibaba.com>, <peterx@redhat.com>,
        <anshuman.khandual@arm.com>, <thomas_os@shipmail.org>,
        <rcampbell@nvidia.com>, <aneesh.kumar@linux.ibm.com>,
        <yang.shi@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/6] mm/huge_memory.c: rework the function vma_adjust_trans_huge()
Date:   Sat, 13 Mar 2021 05:32:19 -0500
Message-ID: <20210313103225.16607-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210313103225.16607-1-linmiaohe@huawei.com>
References: <20210313103225.16607-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of vma_adjust_trans_huge() contains some
duplicated codes. Add helper function to get rid of these codes to make
it more succinct.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bff92dea5ab3..3303576489d5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2301,6 +2301,14 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 	__split_huge_pmd(vma, pmd, address, freeze, page);
 }
 
+static inline void try_to_split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address)
+{
+	if (address & ~HPAGE_PMD_MASK &&
+	    range_in_vma(vma, address & HPAGE_PMD_MASK,
+			 (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE))
+		split_huge_pmd_address(vma, address, false, NULL);
+}
+
 void vma_adjust_trans_huge(struct vm_area_struct *vma,
 			     unsigned long start,
 			     unsigned long end,
@@ -2311,20 +2319,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	 * previously contain an hugepage: check if we need to split
 	 * an huge pmd.
 	 */
-	if (start & ~HPAGE_PMD_MASK &&
-	    (start & HPAGE_PMD_MASK) >= vma->vm_start &&
-	    (start & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
-		split_huge_pmd_address(vma, start, false, NULL);
+	try_to_split_huge_pmd_address(vma, start);
 
 	/*
 	 * If the new end address isn't hpage aligned and it could
 	 * previously contain an hugepage: check if we need to split
 	 * an huge pmd.
 	 */
-	if (end & ~HPAGE_PMD_MASK &&
-	    (end & HPAGE_PMD_MASK) >= vma->vm_start &&
-	    (end & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
-		split_huge_pmd_address(vma, end, false, NULL);
+	try_to_split_huge_pmd_address(vma, end);
 
 	/*
 	 * If we're also updating the vma->vm_next->vm_start, if the new
@@ -2335,10 +2337,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long nstart = next->vm_start;
 		nstart += adjust_next;
-		if (nstart & ~HPAGE_PMD_MASK &&
-		    (nstart & HPAGE_PMD_MASK) >= next->vm_start &&
-		    (nstart & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= next->vm_end)
-			split_huge_pmd_address(next, nstart, false, NULL);
+		try_to_split_huge_pmd_address(next, nstart);
 	}
 }
 
-- 
2.19.1

