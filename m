Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8483EC21F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhHNKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 06:52:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8019 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbhHNKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 06:52:03 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gmy022YL3zYnkc;
        Sat, 14 Aug 2021 18:51:14 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 14
 Aug 2021 18:51:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <sfr@canb.auug.org.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/4] mm/hwpoison: fix potential pte_unmap_unlock pte error
Date:   Sat, 14 Aug 2021 18:51:29 +0800
Message-ID: <20210814105131.48814-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210814105131.48814-1-linmiaohe@huawei.com>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the first pte is equal to poisoned_pfn, i.e. check_hwpoisoned_entry()
return 1, the wrong ptep - 1 would be passed to pte_unmap_unlock().

Fixes: ad9c59c24095 ("mm,hwpoison: send SIGBUS with error virutal address")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 052ec9ee7cf6..54f61133bf60 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -632,7 +632,7 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 {
 	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
 	int ret = 0;
-	pte_t *ptep;
+	pte_t *ptep, *mapped_pte;
 	spinlock_t *ptl;
 
 	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
@@ -645,14 +645,15 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 	if (pmd_trans_unstable(pmdp))
 		goto out;
 
-	ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp, addr, &ptl);
+	mapped_pte = ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp,
+						addr, &ptl);
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		ret = check_hwpoisoned_entry(*ptep, addr, PAGE_SHIFT,
 					     hwp->pfn, &hwp->tk);
 		if (ret == 1)
 			break;
 	}
-	pte_unmap_unlock(ptep - 1, ptl);
+	pte_unmap_unlock(mapped_pte, ptl);
 out:
 	cond_resched();
 	return ret;
-- 
2.23.0

