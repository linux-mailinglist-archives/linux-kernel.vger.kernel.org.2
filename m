Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49A362EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhDQJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:42:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16475 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbhDQJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:42:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FMp2C0yb9zyPGg;
        Sat, 17 Apr 2021 17:39:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 17 Apr 2021
 17:41:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 4/5] mm/swap: remove confusing checking for non_swap_entry() in swap_ra_info()
Date:   Sat, 17 Apr 2021 05:40:38 -0400
Message-ID: <20210417094039.51711-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210417094039.51711-1-linmiaohe@huawei.com>
References: <20210417094039.51711-1-linmiaohe@huawei.com>
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
or swp_type would be unexpected. But the swap_entry isn't used in this
function and we will have enough checking when we really operate the PTE
entries later. So checking for non_swap_entry() is not really needed here
and should be removed to avoid confusion.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 272ea2108c9d..df5405384520 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -721,7 +721,6 @@ static void swap_ra_info(struct vm_fault *vmf,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long ra_val;
-	swp_entry_t entry;
 	unsigned long faddr, pfn, fpfn;
 	unsigned long start, end;
 	pte_t *pte, *orig_pte;
@@ -739,11 +738,6 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 	faddr = vmf->address;
 	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
-	entry = pte_to_swp_entry(*pte);
-	if ((unlikely(non_swap_entry(entry)))) {
-		pte_unmap(orig_pte);
-		return;
-	}
 
 	fpfn = PFN_DOWN(faddr);
 	ra_val = GET_SWAP_RA_VAL(vma);
-- 
2.19.1

