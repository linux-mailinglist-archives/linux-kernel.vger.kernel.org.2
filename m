Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFB363BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhDSGqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:46:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16478 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhDSGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:46:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FNy1p4wfwzqTqH;
        Mon, 19 Apr 2021 14:43:10 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 14:45:21 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next v3 1/2] mm/debug_vm_pgtable: Move {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE
Date:   Mon, 19 Apr 2021 15:18:19 +0800
Message-ID: <20210419071820.750217-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shixin Liu <liushixin2@huawei.com>

The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge are not dependent
on THP. Hence move {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
v2->v3:
Modified the commit message and fix a checkpatch warning.
v1->v2:
Modified the commit message.

 mm/debug_vm_pgtable.c | 91 +++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 52 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 05efe98a9ac2..d3cf178621d9 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -242,29 +242,6 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pmd_leaf(pmd));
 }
 
-#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
-{
-	pmd_t pmd;
-
-	if (!arch_vmap_pmd_supported(prot))
-		return;
-
-	pr_debug("Validating PMD huge\n");
-	/*
-	 * X86 defined pmd_set_huge() verifies that the given
-	 * PMD is not a populated non-leaf entry.
-	 */
-	WRITE_ONCE(*pmdp, __pmd(0));
-	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
-	WARN_ON(!pmd_clear_huge(pmdp));
-	pmd = READ_ONCE(*pmdp);
-	WARN_ON(!pmd_none(pmd));
-}
-#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
-static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
-#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
-
 static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
 	pmd_t pmd = pfn_pmd(pfn, prot);
@@ -379,30 +356,6 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
 	pud = pud_mkhuge(pud);
 	WARN_ON(!pud_leaf(pud));
 }
-
-#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
-{
-	pud_t pud;
-
-	if (!arch_vmap_pud_supported(prot))
-		return;
-
-	pr_debug("Validating PUD huge\n");
-	/*
-	 * X86 defined pud_set_huge() verifies that the given
-	 * PUD is not a populated non-leaf entry.
-	 */
-	WRITE_ONCE(*pudp, __pud(0));
-	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
-	WARN_ON(!pud_clear_huge(pudp));
-	pud = READ_ONCE(*pudp);
-	WARN_ON(!pud_none(pud));
-}
-#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
-#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
-
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
@@ -412,9 +365,6 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 {
 }
 static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
-{
-}
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
@@ -433,14 +383,51 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 }
 static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) { }
 static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 {
+	pmd_t pmd;
+
+	if (!arch_vmap_pmd_supported(prot))
+		return;
+
+	pr_debug("Validating PMD huge\n");
+	/*
+	 * X86 defined pmd_set_huge() verifies that the given
+	 * PMD is not a populated non-leaf entry.
+	 */
+	WRITE_ONCE(*pmdp, __pmd(0));
+	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
+	WARN_ON(!pmd_clear_huge(pmdp));
+	pmd = READ_ONCE(*pmdp);
+	WARN_ON(!pmd_none(pmd));
 }
+
 static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 {
+	pud_t pud;
+
+	if (!arch_vmap_pud_supported(prot))
+		return;
+
+	pr_debug("Validating PUD huge\n");
+	/*
+	 * X86 defined pud_set_huge() verifies that the given
+	 * PUD is not a populated non-leaf entry.
+	 */
+	WRITE_ONCE(*pudp, __pud(0));
+	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
+	WARN_ON(!pud_clear_huge(pudp));
+	pud = READ_ONCE(*pudp);
+	WARN_ON(!pud_none(pud));
 }
-static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
+static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
+static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
+#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
 {
-- 
2.25.1

