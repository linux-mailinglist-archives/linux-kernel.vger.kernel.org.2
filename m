Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE2350CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhDACXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:23:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14979 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhDACXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:23:43 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9n4J4JMWzyNmb;
        Thu,  1 Apr 2021 10:21:36 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 10:23:32 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 1/3] mm/debug_vm_pgtable: Fix one comment mistake
Date:   Thu, 1 Apr 2021 10:23:13 +0800
Message-ID: <20210401022315.2911967-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The branch condition should be CONFIG_TRANSPARENT_HUGEPAGE instead of
CONFIG_ARCH_HAS_PTE_DEVMAP.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 mm/debug_vm_pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 05efe98a9ac2..a5c71a94e804 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -755,12 +755,12 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
-#else  /* !CONFIG_ARCH_HAS_PTE_DEVMAP */
+#else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
 static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 {
 }
-#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
 {
-- 
2.25.1

