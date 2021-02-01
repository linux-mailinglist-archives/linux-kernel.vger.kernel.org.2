Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5F30A469
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBAJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:34:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11664 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhBAJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:34:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTjPm0PZqzlDlc;
        Mon,  1 Feb 2021 17:31:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 17:33:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/huge_memory.c: use helper range_in_vma() in __split_huge_p[u|m]d_locked()
Date:   Mon, 1 Feb 2021 04:32:59 -0500
Message-ID: <20210201093259.52798-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper range_in_vma() is introduced via commit 017b1660df89 ("mm:
migration: fix migration of huge PMD shared pages"). But we forgot to
use it in __split_huge_pud_locked() and __split_huge_pmd_locked().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 987cf5e4cf90..33353a4f95fb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1959,8 +1959,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
-	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
-	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
+	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PUD_SIZE), vma);
 	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
@@ -2039,8 +2038,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	int i;
 
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
-	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
+	VM_BUG_ON_VMA(!range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE), vma);
 	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
 				&& !pmd_devmap(*pmd));
 
-- 
2.19.1

