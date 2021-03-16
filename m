Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B4C33D415
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCPMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:42:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13943 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhCPMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:40:59 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F0CXT311JzjLXy;
        Tue, 16 Mar 2021 20:39:21 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 20:40:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <peterx@redhat.com>, <yulei.kernel@gmail.com>, <walken@google.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <thomas_os@shipmail.org>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 3/6] mm/huge_memory.c: rework the function do_huge_pmd_numa_page() slightly
Date:   Tue, 16 Mar 2021 08:40:04 -0400
Message-ID: <20210316124007.20474-4-linmiaohe@huawei.com>
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

The current code that checks if migrating misplaced transhuge page is
needed is pretty hard to follow. Rework it and add a comment to make
its logic more clear and improve readability.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index caad9942c693..57a1b72e03c8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1462,12 +1462,6 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 */
 	page_locked = trylock_page(page);
 	target_nid = mpol_misplaced(page, vma, haddr);
-	if (target_nid == NUMA_NO_NODE) {
-		/* If the page was locked, there are no parallel migrations */
-		if (page_locked)
-			goto clear_pmdnuma;
-	}
-
 	/* Migration could have started since the pmd_trans_migrating check */
 	if (!page_locked) {
 		page_nid = NUMA_NO_NODE;
@@ -1476,6 +1470,11 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		spin_unlock(vmf->ptl);
 		put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
 		goto out;
+	} else if (target_nid == NUMA_NO_NODE) {
+		/* There are no parallel migrations and page is in the right
+		 * node. Clear the numa hinting info in this pmd.
+		 */
+		goto clear_pmdnuma;
 	}
 
 	/*
-- 
2.19.1

