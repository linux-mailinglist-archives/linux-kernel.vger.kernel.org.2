Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34522350CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhDACXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:23:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14981 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhDACXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:23:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9n4J4VvvzyNmd;
        Thu,  1 Apr 2021 10:21:36 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 10:23:33 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next 2/3] mm/debug_vm_pgtable: Move {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE
Date:   Thu, 1 Apr 2021 10:23:14 +0800
Message-ID: <20210401022315.2911967-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401022315.2911967-1-liushixin2@huawei.com>
References: <20210401022315.2911967-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge is not depend on THP.
But now if we want to test these functions, we have to enable THP. So move
{pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE.

Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 mm/debug_vm_pgtable.c | 91 +++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 52 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a5c71a94e804..c379bbe42c2a 100644
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

