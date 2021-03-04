Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73332D30F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbhCDMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:31:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12692 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbhCDMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:31:32 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Drqsh5BZLzlShH;
        Thu,  4 Mar 2021 20:28:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 20:30:40 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <riel@redhat.com>, <kirill.shutemov@linux.intel.com>,
        <ebru.akagunduz@gmail.com>, <dan.carpenter@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/5] khugepaged: reuse the smp_wmb() inside __SetPageUptodate()
Date:   Thu, 4 Mar 2021 07:30:10 -0500
Message-ID: <20210304123013.23560-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210304123013.23560-1-linmiaohe@huawei.com>
References: <20210304123013.23560-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_wmb() is needed to avoid the copy_huge_page writes to become visible
after the set_pmd_at() write here. But we can reuse the smp_wmb() inside
__SetPageUptodate() to remove this redundant one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d43812c5ce16..287e7ecf978c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1183,19 +1183,18 @@ static void collapse_huge_page(struct mm_struct *mm,
 	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl,
 			&compound_pagelist);
 	pte_unmap(pte);
+	/*
+	 * spin_lock() below is not the equivalent of smp_wmb(), but
+	 * the smp_wmb() inside __SetPageUptodate() can be reused to
+	 * avoid the copy_huge_page writes to become visible after
+	 * the set_pmd_at() write.
+	 */
 	__SetPageUptodate(new_page);
 	pgtable = pmd_pgtable(_pmd);
 
 	_pmd = mk_huge_pmd(new_page, vma->vm_page_prot);
 	_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
 
-	/*
-	 * spin_lock() below is not the equivalent of smp_wmb(), so
-	 * this is needed to avoid the copy_huge_page writes to become
-	 * visible after the set_pmd_at() write.
-	 */
-	smp_wmb();
-
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
 	page_add_new_anon_rmap(new_page, vma, address, true);
-- 
2.19.1

