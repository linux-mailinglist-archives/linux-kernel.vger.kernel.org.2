Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820B23DD042
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhHBGFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231958AbhHBGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627884294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a/nzxJtgCj5oX4B8PQr/kZ3AgLp9eIvZlxOaWHpZ5Ys=;
        b=UyD+BIrpJHZS0PRmFwFRhnUSejr1uXjeMesSR2g0cn3iGmdWkCiuSh4LHDn6HGkf7zNuxb
        FiD+tOGQYvOZLSiJBdvrX5aN8ckjfgsnW5uRYzcdHFhhwjaduUTErrEUg7QTIlqZcuwh7p
        8CqY/9pI9mVEyBMA7364fCKQW7jsHAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-2Ze6XumyO46Ic4tSzZh9sQ-1; Mon, 02 Aug 2021 02:04:53 -0400
X-MC-Unique: 2Ze6XumyO46Ic4tSzZh9sQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53523107ACF5;
        Mon,  2 Aug 2021 06:04:51 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56D2469323;
        Mon,  2 Aug 2021 06:04:46 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 02/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in basic tests
Date:   Mon,  2 Aug 2021 14:04:09 +0800
Message-Id: <20210802060419.1360913-3-gshan@redhat.com>
In-Reply-To: <20210802060419.1360913-1-gshan@redhat.com>
References: <20210802060419.1360913-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in the basic test functions. The
unused variables @pgd_aligned and @p4d_aligned in debug_vm_pgtable()
are dropped.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 6a825f0e7cd7..318a50ca0e25 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -89,10 +89,10 @@ struct pgtable_debug_args {
 	unsigned long		fixed_pte_pfn;
 };
 
-static void __init pte_basic_tests(unsigned long pfn, int idx)
+static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 {
 	pgprot_t prot = protection_map[idx];
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, prot);
 	unsigned long val = idx, *ptr = &val;
 
 	pr_debug("Validating PTE basic (%pGv)\n", ptr);
@@ -174,7 +174,7 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_basic_tests(unsigned long pfn, int idx)
+static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 {
 	pgprot_t prot = protection_map[idx];
 	unsigned long val = idx, *ptr = &val;
@@ -184,7 +184,7 @@ static void __init pmd_basic_tests(unsigned long pfn, int idx)
 		return;
 
 	pr_debug("Validating PMD basic (%pGv)\n", ptr);
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->fixed_pmd_pfn, prot);
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -296,7 +296,7 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx)
+static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 {
 	pgprot_t prot = protection_map[idx];
 	unsigned long val = idx, *ptr = &val;
@@ -306,7 +306,7 @@ static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int
 		return;
 
 	pr_debug("Validating PUD basic (%pGv)\n", ptr);
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(args->fixed_pud_pfn, prot);
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -327,7 +327,7 @@ static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int
 	WARN_ON(pud_dirty(pud_wrprotect(pud_mkclean(pud))));
 	WARN_ON(!pud_dirty(pud_wrprotect(pud_mkdirty(pud))));
 
-	if (mm_pmd_folded(mm))
+	if (mm_pmd_folded(args->mm))
 		return;
 
 	/*
@@ -404,7 +404,7 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pud_leaf(pud));
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
+static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pud_t *pudp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -414,8 +414,8 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
-static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
+static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
+static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
 static void __init pmd_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pmd_t *pmdp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -476,7 +476,7 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
 #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
-static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init p4d_basic_tests(struct pgtable_debug_args *args)
 {
 	p4d_t p4d;
 
@@ -485,7 +485,7 @@ static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!p4d_same(p4d, p4d));
 }
 
-static void __init pgd_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init pgd_basic_tests(struct pgtable_debug_args *args)
 {
 	pgd_t pgd;
 
@@ -890,7 +890,7 @@ static void __init swap_migration_tests(void)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 {
 	struct page *page;
 	pte_t pte;
@@ -900,21 +900,21 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
 	 * Accessing the page associated with the pfn is safe here,
 	 * as it was previously derived from a real kernel symbol.
 	 */
-	page = pfn_to_page(pfn);
-	pte = mk_huge_pte(page, prot);
+	page = pfn_to_page(args->fixed_pmd_pfn);
+	pte = mk_huge_pte(page, args->page_prot);
 
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
 	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
 	WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte))));
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-	pte = pfn_pte(pfn, prot);
+	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
 
 	WARN_ON(!pte_huge(pte_mkhuge(pte)));
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 }
 #else  /* !CONFIG_HUGETLB_PAGE */
-static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init hugetlb_basic_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -1229,7 +1229,7 @@ static int __init debug_vm_pgtable(void)
 	pgprot_t prot, protnone;
 	phys_addr_t paddr;
 	unsigned long vaddr, pte_aligned, pmd_aligned;
-	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
+	unsigned long pud_aligned;
 	spinlock_t *ptl = NULL;
 	int idx, ret;
 
@@ -1272,8 +1272,6 @@ static int __init debug_vm_pgtable(void)
 	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
 	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
 	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
-	p4d_aligned = (paddr & P4D_MASK) >> PAGE_SHIFT;
-	pgd_aligned = (paddr & PGDIR_MASK) >> PAGE_SHIFT;
 	WARN_ON(!pfn_valid(pte_aligned));
 
 	pgdp = pgd_offset(mm, vaddr);
@@ -1307,9 +1305,9 @@ static int __init debug_vm_pgtable(void)
 	 * given page table entry.
 	 */
 	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
-		pte_basic_tests(pte_aligned, idx);
-		pmd_basic_tests(pmd_aligned, idx);
-		pud_basic_tests(mm, pud_aligned, idx);
+		pte_basic_tests(&args, idx);
+		pmd_basic_tests(&args, idx);
+		pud_basic_tests(&args, idx);
 	}
 
 	/*
@@ -1319,8 +1317,8 @@ static int __init debug_vm_pgtable(void)
 	 * the above iteration for now to save some test execution
 	 * time.
 	 */
-	p4d_basic_tests(p4d_aligned, prot);
-	pgd_basic_tests(pgd_aligned, prot);
+	p4d_basic_tests(&args);
+	pgd_basic_tests(&args);
 
 	pmd_leaf_tests(pmd_aligned, prot);
 	pud_leaf_tests(pud_aligned, prot);
@@ -1349,7 +1347,7 @@ static int __init debug_vm_pgtable(void)
 	pmd_thp_tests(pmd_aligned, prot);
 	pud_thp_tests(pud_aligned, prot);
 
-	hugetlb_basic_tests(pte_aligned, prot);
+	hugetlb_basic_tests(&args);
 
 	/*
 	 * Page table modifying tests. They need to hold
-- 
2.23.0

