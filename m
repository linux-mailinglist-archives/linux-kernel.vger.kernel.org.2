Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5C327C93
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhCAKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:49:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13099 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhCAKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:48:40 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dpxkw44npz16F15;
        Mon,  1 Mar 2021 18:46:16 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Mar 2021
 18:47:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/hugetlb: remove redundant reservation check condition in alloc_huge_page()
Date:   Mon, 1 Mar 2021 05:47:26 -0500
Message-ID: <20210301104726.45159-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_resv_map(vma) checks if a reserve map is associated with the vma.  The
routine vma_needs_reservation() will check vma_resv_map(vma) and return 1
if no reserv map is present.  map_chg is set to the return value of
vma_needs_reservation().  Therefore, !vma_resv_map(vma) is redundant in the
expression:
	map_chg || avoid_reserve || !vma_resv_map(vma);
Remove the redundant check.

[Thanks Mike Kravetz for reshaping this commit message!]

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 60c67eb016f7..060005b868cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2314,7 +2314,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 
 	/* If this allocation is not consuming a reservation, charge it now.
 	 */
-	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
+	deferred_reserve = map_chg || avoid_reserve;
 	if (deferred_reserve) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
 			idx, pages_per_huge_page(h), &h_cg);
-- 
2.19.1

