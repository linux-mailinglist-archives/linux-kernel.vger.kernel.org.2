Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7A33D419
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhCPMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:42:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13632 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhCPMlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:41:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F0CX93gbjz19GBT;
        Tue, 16 Mar 2021 20:39:05 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 20:40:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <peterx@redhat.com>, <yulei.kernel@gmail.com>, <walken@google.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <thomas_os@shipmail.org>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 6/6] mm/huge_memory.c: use helper function migration_entry_to_page()
Date:   Tue, 16 Mar 2021 08:40:07 -0400
Message-ID: <20210316124007.20474-7-linmiaohe@huawei.com>
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

It's more recommended to use helper function migration_entry_to_page() to
get the page via migration entry. We can also enjoy the PageLocked()
check there.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ebfb0bf2e3fd..2c68123dc525 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1693,7 +1693,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
 			entry = pmd_to_swp_entry(orig_pmd);
-			page = pfn_to_page(swp_offset(entry));
+			page = migration_entry_to_page(entry);
 			flush_needed = 0;
 		} else
 			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
@@ -2101,7 +2101,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		swp_entry_t entry;
 
 		entry = pmd_to_swp_entry(old_pmd);
-		page = pfn_to_page(swp_offset(entry));
+		page = migration_entry_to_page(entry);
 		write = is_write_migration_entry(entry);
 		young = false;
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
-- 
2.19.1

