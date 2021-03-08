Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62DD330C55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhCHL2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:28:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13141 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhCHL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:28:49 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvGJj0jFDz16HY8;
        Mon,  8 Mar 2021 19:27:01 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Mar 2021
 19:28:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/5] mm/hugetlb: simplify the code when alloc_huge_page() failed in hugetlb_no_page()
Date:   Mon, 8 Mar 2021 06:28:08 -0500
Message-ID: <20210308112809.26107-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210308112809.26107-1-linmiaohe@huawei.com>
References: <20210308112809.26107-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the error handling code when alloc_huge_page() failed to remove some
duplicated code and simplify the code slightly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 695603071f2c..69b8de866a24 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4337,13 +4337,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * sure there really is no pte entry.
 			 */
 			ptl = huge_pte_lock(h, mm, ptep);
-			if (!huge_pte_none(huge_ptep_get(ptep))) {
-				ret = 0;
-				spin_unlock(ptl);
-				goto out;
-			}
+			ret = 0;
+			if (huge_pte_none(huge_ptep_get(ptep)))
+				ret = vmf_error(PTR_ERR(page));
 			spin_unlock(ptl);
-			ret = vmf_error(PTR_ERR(page));
 			goto out;
 		}
 		clear_huge_page(page, address, pages_per_huge_page(h));
-- 
2.19.1

