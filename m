Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B749531600C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhBJH02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:26:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12163 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhBJHZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:25:16 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DbB6v2z2pzlC80;
        Wed, 10 Feb 2021 15:22:47 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Feb 2021
 15:24:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/huge_memory.c: Remove unnecessary local variable ret2
Date:   Wed, 10 Feb 2021 02:24:09 -0500
Message-ID: <20210210072409.60587-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use a new local variable ret2 to get the return value
of handle_userfault(). Use ret directly to make code more succinct.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 395c75111d33..caf552834dbb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -624,14 +624,12 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		/* Deliver the page fault to userland */
 		if (userfaultfd_missing(vma)) {
-			vm_fault_t ret2;
-
 			spin_unlock(vmf->ptl);
 			put_page(page);
 			pte_free(vma->vm_mm, pgtable);
-			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
-			VM_BUG_ON(ret2 & VM_FAULT_FALLBACK);
-			return ret2;
+			ret = handle_userfault(vmf, VM_UFFD_MISSING);
+			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
+			return ret;
 		}
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
-- 
2.19.1

