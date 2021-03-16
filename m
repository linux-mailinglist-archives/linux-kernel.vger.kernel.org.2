Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6B33D411
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhCPMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:41:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13967 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhCPMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:40:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0CX43vrLzrXCS;
        Tue, 16 Mar 2021 20:39:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 20:40:45 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <peterx@redhat.com>, <yulei.kernel@gmail.com>, <walken@google.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <thomas_os@shipmail.org>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 1/6] mm/huge_memory.c: rework the function vma_adjust_trans_huge()
Date:   Tue, 16 Mar 2021 08:40:02 -0400
Message-ID: <20210316124007.20474-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210316124007.20474-1-linmiaohe@huawei.com>
References: <20210316124007.20474-1-linmiaohe@huawei.com>
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
 mm/huge_memory.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bff92dea5ab3..e943ccbdc9dd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2301,44 +2301,38 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 	__split_huge_pmd(vma, pmd, address, freeze, page);
 }
 
+static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
+{
+	/*
+	 * If the new address isn't hpage aligned and it could previously
+	 * contain an hugepage: check if we need to split an huge pmd.
+	 */
+	if (address & ~HPAGE_PMD_MASK &&
+	    range_in_vma(vma, address & HPAGE_PMD_MASK,
+			 (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE))
+		split_huge_pmd_address(vma, address, false, NULL);
+}
+
 void vma_adjust_trans_huge(struct vm_area_struct *vma,
 			     unsigned long start,
 			     unsigned long end,
 			     long adjust_next)
 {
-	/*
-	 * If the new start address isn't hpage aligned and it could
-	 * previously contain an hugepage: check if we need to split
-	 * an huge pmd.
-	 */
-	if (start & ~HPAGE_PMD_MASK &&
-	    (start & HPAGE_PMD_MASK) >= vma->vm_start &&
-	    (start & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
-		split_huge_pmd_address(vma, start, false, NULL);
+	/* Check if we need to split start first. */
+	split_huge_pmd_if_needed(vma, start);
 
-	/*
-	 * If the new end address isn't hpage aligned and it could
-	 * previously contain an hugepage: check if we need to split
-	 * an huge pmd.
-	 */
-	if (end & ~HPAGE_PMD_MASK &&
-	    (end & HPAGE_PMD_MASK) >= vma->vm_start &&
-	    (end & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= vma->vm_end)
-		split_huge_pmd_address(vma, end, false, NULL);
+	/* Check if we need to split end next. */
+	split_huge_pmd_if_needed(vma, end);
 
 	/*
-	 * If we're also updating the vma->vm_next->vm_start, if the new
-	 * vm_next->vm_start isn't hpage aligned and it could previously
-	 * contain an hugepage: check if we need to split an huge pmd.
+	 * If we're also updating the vma->vm_next->vm_start,
+	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long nstart = next->vm_start;
 		nstart += adjust_next;
-		if (nstart & ~HPAGE_PMD_MASK &&
-		    (nstart & HPAGE_PMD_MASK) >= next->vm_start &&
-		    (nstart & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= next->vm_end)
-			split_huge_pmd_address(next, nstart, false, NULL);
+		split_huge_pmd_if_needed(next, nstart);
 	}
 }
 
-- 
2.19.1

