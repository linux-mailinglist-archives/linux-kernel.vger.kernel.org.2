Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8153885E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhESEN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:13:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231893AbhESEN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:13:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93AF3101E;
        Tue, 18 May 2021 21:12:37 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4828D3F719;
        Tue, 18 May 2021 21:12:35 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/debug_vm_pgtable: Ensure THP availability via has_transparent_hugepage()
Date:   Wed, 19 May 2021 09:43:08 +0530
Message-Id: <1621397588-19211-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On certain platforms, THP support could not just be validated via the build
option CONFIG_TRANSPARENT_HUGEPAGE. Instead has_transparent_hugepage() also
needs to be called upon to verify THP runtime support. Otherwise the debug
test will just run into unusable THP helpers like in the case of a 4K hash
config on powerpc platform [1]. This just moves all pfn_pmd() and pfn_pud()
after THP runtime validation with has_transparent_hugepage() which prevents
the mentioned problem.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=213069

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Fixes: 787d563b8642 ("mm/debug_vm_pgtable: fix kernel crash by checking for THP support")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc2.

Changes in V2:

- Updated [pmd|pud]_advanced_tests() per Christophe
- Added "Fixes: " tag per Christophe

Changes in V1:

https://lore.kernel.org/linux-mm/1621325590-18199-1-git-send-email-anshuman.khandual@arm.com/

 mm/debug_vm_pgtable.c | 63 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 05efe98a9ac2..b3c7e7b04cb9 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -146,13 +146,14 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 static void __init pmd_basic_tests(unsigned long pfn, int idx)
 {
 	pgprot_t prot = protection_map[idx];
-	pmd_t pmd = pfn_pmd(pfn, prot);
 	unsigned long val = idx, *ptr = &val;
+	pmd_t pmd;
 
 	if (!has_transparent_hugepage())
 		return;
 
 	pr_debug("Validating PMD basic (%pGv)\n", ptr);
+	pmd = pfn_pmd(pfn, prot);
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -185,7 +186,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 				      unsigned long pfn, unsigned long vaddr,
 				      pgprot_t prot, pgtable_t pgtable)
 {
-	pmd_t pmd = pfn_pmd(pfn, prot);
+	pmd_t pmd;
 
 	if (!has_transparent_hugepage())
 		return;
@@ -232,9 +233,14 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 
 static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
 {
-	pmd_t pmd = pfn_pmd(pfn, prot);
+	pmd_t pmd;
+
+	if (!has_transparent_hugepage())
+		return;
 
 	pr_debug("Validating PMD leaf\n");
+	pmd = pfn_pmd(pfn, prot);
+
 	/*
 	 * PMD based THP is a leaf entry.
 	 */
@@ -267,12 +273,16 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 
 static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
-	pmd_t pmd = pfn_pmd(pfn, prot);
+	pmd_t pmd;
 
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
 
+	if (!has_transparent_hugepage())
+		return;
+
 	pr_debug("Validating PMD saved write\n");
+	pmd = pfn_pmd(pfn, prot);
 	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
 	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
 }
@@ -281,13 +291,14 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx)
 {
 	pgprot_t prot = protection_map[idx];
-	pud_t pud = pfn_pud(pfn, prot);
 	unsigned long val = idx, *ptr = &val;
+	pud_t pud;
 
 	if (!has_transparent_hugepage())
 		return;
 
 	pr_debug("Validating PUD basic (%pGv)\n", ptr);
+	pud = pfn_pud(pfn, prot);
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -323,7 +334,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 				      unsigned long pfn, unsigned long vaddr,
 				      pgprot_t prot)
 {
-	pud_t pud = pfn_pud(pfn, prot);
+	pud_t pud;
 
 	if (!has_transparent_hugepage())
 		return;
@@ -332,6 +343,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 	/* Align the address wrt HPAGE_PUD_SIZE */
 	vaddr = (vaddr & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE;
 
+	pud = pfn_pud(pfn, prot);
 	set_pud_at(mm, vaddr, pudp, pud);
 	pudp_set_wrprotect(mm, vaddr, pudp);
 	pud = READ_ONCE(*pudp);
@@ -370,9 +382,13 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 
 static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
 {
-	pud_t pud = pfn_pud(pfn, prot);
+	pud_t pud;
+
+	if (!has_transparent_hugepage())
+		return;
 
 	pr_debug("Validating PUD leaf\n");
+	pud = pfn_pud(pfn, prot);
 	/*
 	 * PUD based THP is a leaf entry.
 	 */
@@ -654,12 +670,16 @@ static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
 {
-	pmd_t pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
+	pmd_t pmd;
 
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
 
+	if (!has_transparent_hugepage())
+		return;
+
 	pr_debug("Validating PMD protnone\n");
+	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
 	WARN_ON(!pmd_protnone(pmd));
 	WARN_ON(!pmd_present(pmd));
 }
@@ -679,18 +699,26 @@ static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
 {
-	pmd_t pmd = pfn_pmd(pfn, prot);
+	pmd_t pmd;
+
+	if (!has_transparent_hugepage())
+		return;
 
 	pr_debug("Validating PMD devmap\n");
+	pmd = pfn_pmd(pfn, prot);
 	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
 {
-	pud_t pud = pfn_pud(pfn, prot);
+	pud_t pud;
+
+	if (!has_transparent_hugepage())
+		return;
 
 	pr_debug("Validating PUD devmap\n");
+	pud = pfn_pud(pfn, prot);
 	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
@@ -733,25 +761,33 @@ static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 {
-	pmd_t pmd = pfn_pmd(pfn, prot);
+	pmd_t pmd;
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
+	if (!has_transparent_hugepage())
+		return;
+
 	pr_debug("Validating PMD soft dirty\n");
+	pmd = pfn_pmd(pfn, prot);
 	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
 	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
 }
 
 static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 {
-	pmd_t pmd = pfn_pmd(pfn, prot);
+	pmd_t pmd;
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) ||
 		!IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
 		return;
 
+	if (!has_transparent_hugepage())
+		return;
+
 	pr_debug("Validating PMD swap soft dirty\n");
+	pmd = pfn_pmd(pfn, prot);
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
@@ -780,6 +816,9 @@ static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
 	swp_entry_t swp;
 	pmd_t pmd;
 
+	if (!has_transparent_hugepage())
+		return;
+
 	pr_debug("Validating PMD swap\n");
 	pmd = pfn_pmd(pfn, prot);
 	swp = __pmd_to_swp_entry(pmd);
-- 
2.20.1

