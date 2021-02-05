Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D5310687
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBEIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:20:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12130 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhBEIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:20:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX7bp2JsFz164kW;
        Fri,  5 Feb 2021 16:18:46 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 16:19:58 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jeremy@goop.org>, <mingo@elte.hu>, <ian.pratt@xensource.com>,
        <chrisw@sous-sol.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/memory.c: fix potential pte_unmap_unlock pte error
Date:   Fri, 5 Feb 2021 03:19:25 -0500
Message-ID: <20210205081925.59809-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all pte entry is none in 'non-create' case, we would break the loop with
pte unchanged.  Then the wrong pte - 1 would be passed to pte_unmap_unlock.
This is a theoretical issue which may not be a real bug. So it's not worth
cc stable.

Fixes: aee16b3cee27 ("Add apply_to_page_range() which applies a function to a pte range")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9d68a2340589..b2d6a0a6088b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2394,18 +2394,18 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 				     pte_fn_t fn, void *data, bool create,
 				     pgtbl_mod_mask *mask)
 {
-	pte_t *pte;
+	pte_t *pte, *mapped_pte;
 	int err = 0;
 	spinlock_t *ptl;
 
 	if (create) {
-		pte = (mm == &init_mm) ?
+		mapped_pte = pte = (mm == &init_mm) ?
 			pte_alloc_kernel_track(pmd, addr, mask) :
 			pte_alloc_map_lock(mm, pmd, addr, &ptl);
 		if (!pte)
 			return -ENOMEM;
 	} else {
-		pte = (mm == &init_mm) ?
+		mapped_pte = pte = (mm == &init_mm) ?
 			pte_offset_kernel(pmd, addr) :
 			pte_offset_map_lock(mm, pmd, addr, &ptl);
 	}
@@ -2428,7 +2428,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	arch_leave_lazy_mmu_mode();
 
 	if (mm != &init_mm)
-		pte_unmap_unlock(pte-1, ptl);
+		pte_unmap_unlock(mapped_pte, ptl);
 	return err;
 }
 
-- 
2.19.1

