Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B793BC65C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhGFGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhGFGUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxpKf50j3O10GJyNjIQZVgEWk6Jo+0mI+zNXP97fMs8=;
        b=govQaD7HeYr1u163IzOuSyZN1Oz6m3myKlsloX0+jOMTOdufthQTk64Wrf3B4XILXYnH7H
        4M0DQfA09kmbgb4dvoGsmZG2OaDcFCwEYBNoEdsmKNZe7DGvJG55xum5GFrF7rQrOn2a1E
        Hk6OeAUtYw7eBzGP4bPrgNSIzOYzQEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-ljQffE8xNmaRCPxNR6JMuA-1; Tue, 06 Jul 2021 02:18:13 -0400
X-MC-Unique: ljQffE8xNmaRCPxNR6JMuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B42710C1ADC;
        Tue,  6 Jul 2021 06:18:12 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26AD22C00F;
        Tue,  6 Jul 2021 06:18:06 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 02/12] mm/debug_vm_pgtable: Use struct vm_pgtable_debug in basic tests
Date:   Tue,  6 Jul 2021 14:17:38 +0800
Message-Id: <20210706061748.161258-3-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct vm_pgtable_debug in the basic test functions. There
are more cleanups applied:

   * Move hugetlb_basic_tests() so that the basic tests are treated
     as a bundle.

   * Drop parameters to {pgd, p4d}_basic_tests() as they're never
     used.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 47 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 225e2ea4d72f..759f27e1046e 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -88,10 +88,10 @@ struct vm_pgtable_debug {
 	unsigned long		fixed_pte_pfn;
 };
 
-static void __init pte_basic_tests(unsigned long pfn, int idx)
+static void __init pte_basic_tests(struct vm_pgtable_debug *debug, int idx)
 {
 	pgprot_t prot = protection_map[idx];
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(debug->fixed_pte_pfn, prot);
 	unsigned long val = idx, *ptr = &val;
 
 	pr_debug("Validating PTE basic (%pGv)\n", ptr);
@@ -173,7 +173,7 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static void __init pmd_basic_tests(unsigned long pfn, int idx)
+static void __init pmd_basic_tests(struct vm_pgtable_debug *debug, int idx)
 {
 	pgprot_t prot = protection_map[idx];
 	unsigned long val = idx, *ptr = &val;
@@ -183,7 +183,7 @@ static void __init pmd_basic_tests(unsigned long pfn, int idx)
 		return;
 
 	pr_debug("Validating PMD basic (%pGv)\n", ptr);
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(debug->fixed_pmd_pfn, prot);
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -295,7 +295,7 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx)
+static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx)
 {
 	pgprot_t prot = protection_map[idx];
 	unsigned long val = idx, *ptr = &val;
@@ -305,7 +305,7 @@ static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int
 		return;
 
 	pr_debug("Validating PUD basic (%pGv)\n", ptr);
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(debug->fixed_pud_pfn, prot);
 
 	/*
 	 * This test needs to be executed after the given page table entry
@@ -326,7 +326,7 @@ static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int
 	WARN_ON(pud_dirty(pud_wrprotect(pud_mkclean(pud))));
 	WARN_ON(!pud_dirty(pud_wrprotect(pud_mkdirty(pud))));
 
-	if (mm_pmd_folded(mm))
+	if (mm_pmd_folded(debug->mm))
 		return;
 
 	/*
@@ -403,7 +403,7 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pud_leaf(pud));
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
+static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pud_t *pudp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -413,8 +413,8 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
-static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
+static void __init pmd_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
+static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
 static void __init pmd_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pmd_t *pmdp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -475,7 +475,7 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
 #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
-static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init p4d_basic_tests(void)
 {
 	p4d_t p4d;
 
@@ -484,7 +484,7 @@ static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
 	WARN_ON(!p4d_same(p4d, p4d));
 }
 
-static void __init pgd_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init pgd_basic_tests(void)
 {
 	pgd_t pgd;
 
@@ -889,7 +889,7 @@ static void __init swap_migration_tests(void)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
+static void __init hugetlb_basic_tests(struct vm_pgtable_debug *debug)
 {
 	struct page *page;
 	pte_t pte;
@@ -899,21 +899,21 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
 	 * Accessing the page associated with the pfn is safe here,
 	 * as it was previously derived from a real kernel symbol.
 	 */
-	page = pfn_to_page(pfn);
-	pte = mk_huge_pte(page, prot);
+	page = pfn_to_page(debug->fixed_pmd_pfn);
+	pte = mk_huge_pte(page, debug->page_prot);
 
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
 	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
 	WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte))));
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-	pte = pfn_pte(pfn, prot);
+	pte = pfn_pte(debug->fixed_pmd_pfn, debug->page_prot);
 
 	WARN_ON(!pte_huge(pte_mkhuge(pte)));
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 }
 #else  /* !CONFIG_HUGETLB_PAGE */
-static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init hugetlb_basic_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -1248,9 +1248,9 @@ static int __init debug_vm_pgtable(void)
 	 * given page table entry.
 	 */
 	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
-		pte_basic_tests(pte_aligned, idx);
-		pmd_basic_tests(pmd_aligned, idx);
-		pud_basic_tests(mm, pud_aligned, idx);
+		pte_basic_tests(&debug, idx);
+		pmd_basic_tests(&debug, idx);
+		pud_basic_tests(&debug, idx);
 	}
 
 	/*
@@ -1260,8 +1260,9 @@ static int __init debug_vm_pgtable(void)
 	 * the above iteration for now to save some test execution
 	 * time.
 	 */
-	p4d_basic_tests(p4d_aligned, prot);
-	pgd_basic_tests(pgd_aligned, prot);
+	p4d_basic_tests();
+	pgd_basic_tests();
+	hugetlb_basic_tests(&debug);
 
 	pmd_leaf_tests(pmd_aligned, prot);
 	pud_leaf_tests(pud_aligned, prot);
@@ -1290,8 +1291,6 @@ static int __init debug_vm_pgtable(void)
 	pmd_thp_tests(pmd_aligned, prot);
 	pud_thp_tests(pud_aligned, prot);
 
-	hugetlb_basic_tests(pte_aligned, prot);
-
 	/*
 	 * Page table modifying tests. They need to hold
 	 * proper page table lock.
-- 
2.23.0

