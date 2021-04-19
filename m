Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FC2363BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbhDSGqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:46:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16477 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhDSGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:46:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FNy1p4hRqzqTq5;
        Mon, 19 Apr 2021 14:43:10 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 14:45:22 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next v3 2/2] mm/debug_vm_pgtable: Remove redundant pfn_{pmd/pte}() and fix one comment mistake
Date:   Mon, 19 Apr 2021 15:18:20 +0800
Message-ID: <20210419071820.750217-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419071820.750217-1-liushixin2@huawei.com>
References: <20210419071820.750217-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shixin Liu <liushixin2@huawei.com>

Remove redundant pfn_{pmd/pte}() in {pmd/pte}_advanced_tests()
and adjust pfn_pud() in pud_advanced_tests() to make it similar with
other two functions.
In addition, the branch condition should be CONFIG_TRANSPARENT_HUGEPAGE
instead of CONFIG_ARCH_HAS_PTE_DEVMAP.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
v2->v3:
Modified the commit message.
v1->v2:
Remove redundant pfn_pte() and fold two patch to one.

 mm/debug_vm_pgtable.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index d3cf178621d9..e2f35db8ba69 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -91,7 +91,7 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
 				      unsigned long pfn, unsigned long vaddr,
 				      pgprot_t prot)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte;
 
 	/*
 	 * Architectures optimize set_pte_at by avoiding TLB flush.
@@ -185,7 +185,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 				      unsigned long pfn, unsigned long vaddr,
 				      pgprot_t prot, pgtable_t pgtable)
 {
-	pmd_t pmd = pfn_pmd(pfn, prot);
+	pmd_t pmd;
 
 	if (!has_transparent_hugepage())
 		return;
@@ -300,7 +300,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 				      unsigned long pfn, unsigned long vaddr,
 				      pgprot_t prot)
 {
-	pud_t pud = pfn_pud(pfn, prot);
+	pud_t pud;
 
 	if (!has_transparent_hugepage())
 		return;
@@ -309,6 +309,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 	/* Align the address wrt HPAGE_PUD_SIZE */
 	vaddr = (vaddr & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE;
 
+	pud = pfn_pud(pfn, prot);
 	set_pud_at(mm, vaddr, pudp, pud);
 	pudp_set_wrprotect(mm, vaddr, pudp);
 	pud = READ_ONCE(*pudp);
@@ -742,12 +743,12 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
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

