Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3F358433
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhDHNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:09:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16414 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhDHNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:09:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGM4L1CWSzkjgG;
        Thu,  8 Apr 2021 21:07:30 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:09:10 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <ying.huang@intel.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/5] mm/swap_state: fix potential faulted in race in swap_ra_info()
Date:   Thu, 8 Apr 2021 09:08:19 -0400
Message-ID: <20210408130820.48233-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210408130820.48233-1-linmiaohe@huawei.com>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we released the pte lock, somebody else might faulted in this pte.
So we should check whether it's swap pte first to guard against such race
or swp_type would be unexpected. And we can also avoid some unnecessary
readahead cpu cycles possibly.

Fixes: ec560175c0b6 ("mm, swap: VMA based swap readahead")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 709c260d644a..3bf0d0c297bc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -724,10 +724,10 @@ static void swap_ra_info(struct vm_fault *vmf,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long ra_val;
-	swp_entry_t entry;
+	swp_entry_t swap_entry;
 	unsigned long faddr, pfn, fpfn;
 	unsigned long start, end;
-	pte_t *pte, *orig_pte;
+	pte_t *pte, *orig_pte, entry;
 	unsigned int max_win, hits, prev_win, win, left;
 #ifndef CONFIG_64BIT
 	pte_t *tpte;
@@ -742,8 +742,13 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 	faddr = vmf->address;
 	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
-	entry = pte_to_swp_entry(*pte);
-	if ((unlikely(non_swap_entry(entry)))) {
+	entry = *pte;
+	if (unlikely(!is_swap_pte(entry))) {
+		pte_unmap(orig_pte);
+		return;
+	}
+	swap_entry = pte_to_swp_entry(entry);
+	if ((unlikely(non_swap_entry(swap_entry)))) {
 		pte_unmap(orig_pte);
 		return;
 	}
-- 
2.19.1

