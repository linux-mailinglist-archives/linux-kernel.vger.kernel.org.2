Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD90E305714
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhA0Jh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:37:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11450 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhA0Je7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:34:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DQdgm38CqzjCYH;
        Wed, 27 Jan 2021 17:33:08 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Wed, 27 Jan 2021
 17:33:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shakeelb@google.com>,
        <hannes@cmpxchg.org>, <vbabka@suse.cz>, <walken@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/rmap: Fix potential pte_unmap on an not mapped pte
Date:   Wed, 27 Jan 2021 04:33:49 -0500
Message-ID: <20210127093349.39081-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PMD-mapped page (usually THP), pvmw->pte is NULL. For PTE-mapped THP,
pvmw->pte is mapped. But for HugeTLB pages, pvmw->pte is not mapped and set
to the relevant page table entry. So in page_vma_mapped_walk_done(), we may
do pte_unmap() for HugeTLB pte which is not mapped. Fix this by checking
pvmw->page against PageHuge before trying to do pte_unmap().

Fixes: commit ("ace71a19cec5 mm: introduce page_vma_mapped_walk()")
Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/rmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 70085ca1a3fc..def5c62c93b3 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -213,7 +213,8 @@ struct page_vma_mapped_walk {
 
 static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 {
-	if (pvmw->pte)
+	/* HugeTLB pte is set to the relevant page table entry without pte_mapped. */
+	if (pvmw->pte && !PageHuge(pvmw->page))
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
-- 
2.19.1

