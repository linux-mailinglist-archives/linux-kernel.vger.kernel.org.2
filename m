Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8D3DD04B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhHBGFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhHBGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627884337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcBuflk4F+zF2eEutItkPM+mED0trdiEGxKpExi1Qko=;
        b=MnBbPny55Yq9SWA/8fcr0L4MadTJbS0KmltC1Wz0HaUbqQawX/MU0KEabXaV9fr8Mu+mYH
        pMNrh6grjU6duSKOwakWPxbcZHPvFrOyn5ye2+D/0a6qDqLoogmu22ohbb53jEM9vE+XGp
        eeTpmFR3DkWDHvIf2BsQfOJgzA4iO2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-bjEkG6JKPeGTgad-n13Ggw-1; Mon, 02 Aug 2021 02:05:35 -0400
X-MC-Unique: bjEkG6JKPeGTgad-n13Ggw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 901BA107ACF5;
        Mon,  2 Aug 2021 06:05:33 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F14B369323;
        Mon,  2 Aug 2021 06:05:28 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 09/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in PUD modifying tests
Date:   Mon,  2 Aug 2021 14:04:16 +0800
Message-Id: <20210802060419.1360913-10-gshan@redhat.com>
In-Reply-To: <20210802060419.1360913-1-gshan@redhat.com>
References: <20210802060419.1360913-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in PUD modifying tests. The allocated
huge page is used when set_pud_at() is used. The corresponding tests
are skipped if the huge page doesn't exist. Besides, the following unused
variables in debug_vm_pgtable() are dropped: @prot, @paddr, @pud_aligned.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 126 ++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 78 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a1f2a1e27ba2..460bf0101a49 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -337,55 +337,56 @@ static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pud_bad(pud_mkhuge(pud)));
 }
 
-static void __init pud_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pud_t *pudp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
+static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 {
+	unsigned long vaddr = args->vaddr;
 	pud_t pud;
 
 	if (!has_transparent_hugepage())
 		return;
 
+	if (args->pud_pfn == ULONG_MAX)
+		return;
+
 	pr_debug("Validating PUD advanced\n");
 	/* Align the address wrt HPAGE_PUD_SIZE */
 	vaddr &= HPAGE_PUD_MASK;
 
-	pud = pfn_pud(pfn, prot);
-	set_pud_at(mm, vaddr, pudp, pud);
-	pudp_set_wrprotect(mm, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	pud = pfn_pud(args->pud_pfn, args->page_prot);
+	set_pud_at(args->mm, vaddr, args->pudp, pud);
+	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(pud_write(pud));
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	pudp_huge_get_and_clear(mm, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	pudp_huge_get_and_clear(args->mm, vaddr, args->pudp);
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(args->pud_pfn, args->page_prot);
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
-	set_pud_at(mm, vaddr, pudp, pud);
+	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	pud = pud_mkwrite(pud);
 	pud = pud_mkdirty(pud);
-	pudp_set_access_flags(vma, vaddr, pudp, pud, 1);
-	pud = READ_ONCE(*pudp);
+	pudp_set_access_flags(args->vma, vaddr, args->pudp, pud, 1);
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(!(pud_write(pud) && pud_dirty(pud)));
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	pudp_huge_get_and_clear_full(mm, vaddr, pudp, 1);
-	pud = READ_ONCE(*pudp);
+	pudp_huge_get_and_clear_full(args->mm, vaddr, args->pudp, 1);
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(args->pud_pfn, args->page_prot);
 	pud = pud_mkyoung(pud);
-	set_pud_at(mm, vaddr, pudp, pud);
-	pudp_test_and_clear_young(vma, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	set_pud_at(args->mm, vaddr, args->pudp, pud);
+	pudp_test_and_clear_young(args->vma, vaddr, args->pudp);
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(pud_young(pud));
 
-	pudp_huge_get_and_clear(mm, vaddr, pudp);
+	pudp_huge_get_and_clear(args->mm, vaddr, args->pudp);
 }
 
 static void __init pud_leaf_tests(struct pgtable_debug_args *args)
@@ -405,24 +406,14 @@ static void __init pud_leaf_tests(struct pgtable_debug_args *args)
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
-static void __init pud_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pud_t *pudp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
-{
-}
+static void __init pud_advanced_tests(struct pgtable_debug_args *args) { }
 static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
 static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
 static void __init pmd_advanced_tests(struct pgtable_debug_args *args) { }
-static void __init pud_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pud_t *pudp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
-{
-}
+static void __init pud_advanced_tests(struct pgtable_debug_args *args) { }
 static void __init pmd_leaf_tests(struct pgtable_debug_args *args) { }
 static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
 static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args) { }
@@ -448,11 +439,11 @@ static void __init pmd_huge_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pmd_none(pmd));
 }
 
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
+static void __init pud_huge_tests(struct pgtable_debug_args *args)
 {
 	pud_t pud;
 
-	if (!arch_vmap_pud_supported(prot))
+	if (!arch_vmap_pud_supported(args->page_prot))
 		return;
 
 	pr_debug("Validating PUD huge\n");
@@ -460,15 +451,15 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 	 * X86 defined pud_set_huge() verifies that the given
 	 * PUD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*pudp, __pud(0));
-	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
-	WARN_ON(!pud_clear_huge(pudp));
-	pud = READ_ONCE(*pudp);
+	WRITE_ONCE(*args->pudp, __pud(0));
+	WARN_ON(!pud_set_huge(args->pudp, __pfn_to_phys(args->fixed_pud_pfn), args->page_prot));
+	WARN_ON(!pud_clear_huge(args->pudp));
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(!pud_none(pud));
 }
 #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static void __init pmd_huge_tests(struct pgtable_debug_args *args) { }
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
+static void __init pud_huge_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 static void __init p4d_basic_tests(struct pgtable_debug_args *args)
@@ -490,27 +481,26 @@ static void __init pgd_basic_tests(struct pgtable_debug_args *args)
 }
 
 #ifndef __PAGETABLE_PUD_FOLDED
-static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp)
+static void __init pud_clear_tests(struct pgtable_debug_args *args)
 {
-	pud_t pud = READ_ONCE(*pudp);
+	pud_t pud = READ_ONCE(*args->pudp);
 
-	if (mm_pmd_folded(mm))
+	if (mm_pmd_folded(args->mm))
 		return;
 
 	pr_debug("Validating PUD clear\n");
 	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pudp, pud);
-	pud_clear(pudp);
-	pud = READ_ONCE(*pudp);
+	WRITE_ONCE(*args->pudp, pud);
+	pud_clear(args->pudp);
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(!pud_none(pud));
 }
 
-static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
-				      pmd_t *pmdp)
+static void __init pud_populate_tests(struct pgtable_debug_args *args)
 {
 	pud_t pud;
 
-	if (mm_pmd_folded(mm))
+	if (mm_pmd_folded(args->mm))
 		return;
 
 	pr_debug("Validating PUD populate\n");
@@ -518,16 +508,13 @@ static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pud_bad().
 	 */
-	pud_populate(mm, pudp, pmdp);
-	pud = READ_ONCE(*pudp);
+	pud_populate(args->mm, args->pudp, args->start_pmdp);
+	pud = READ_ONCE(*args->pudp);
 	WARN_ON(pud_bad(pud));
 }
 #else  /* !__PAGETABLE_PUD_FOLDED */
-static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp) { }
-static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
-				      pmd_t *pmdp)
-{
-}
+static void __init pud_clear_tests(struct pgtable_debug_args *args) { }
+static void __init pud_populate_tests(struct pgtable_debug_args *args) { }
 #endif /* PAGETABLE_PUD_FOLDED */
 
 #ifndef __PAGETABLE_P4D_FOLDED
@@ -1217,10 +1204,7 @@ static int __init debug_vm_pgtable(void)
 	pmd_t *pmdp, *saved_pmdp, pmd;
 	pte_t *ptep;
 	pgtable_t saved_ptep;
-	pgprot_t prot;
-	phys_addr_t paddr;
 	unsigned long vaddr;
-	unsigned long pud_aligned;
 	spinlock_t *ptl = NULL;
 	int idx, ret;
 
@@ -1229,7 +1213,6 @@ static int __init debug_vm_pgtable(void)
 	if (ret)
 		return ret;
 
-	prot = vm_get_page_prot(VMFLAGS);
 	vaddr = get_random_vaddr();
 	mm = mm_alloc();
 	if (!mm) {
@@ -1243,19 +1226,6 @@ static int __init debug_vm_pgtable(void)
 		return 1;
 	}
 
-	/*
-	 * PFN for mapping at PTE level is determined from a standard kernel
-	 * text symbol. But pfns for higher page table levels are derived by
-	 * masking lower bits of this real pfn. These derived pfns might not
-	 * exist on the platform but that does not really matter as pfn_pxx()
-	 * helpers will still create appropriate entries for the test. This
-	 * helps avoid large memory block allocations to be used for mapping
-	 * at higher page table levels.
-	 */
-	paddr = __pa_symbol(&start_kernel);
-
-	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
-
 	pgdp = pgd_offset(mm, vaddr);
 	p4dp = p4d_alloc(mm, pgdp, vaddr);
 	pudp = pud_alloc(mm, p4dp, vaddr);
@@ -1348,11 +1318,11 @@ static int __init debug_vm_pgtable(void)
 	pmd_populate_tests(&args);
 	spin_unlock(ptl);
 
-	ptl = pud_lock(mm, pudp);
-	pud_clear_tests(mm, pudp);
-	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
-	pud_huge_tests(pudp, pud_aligned, prot);
-	pud_populate_tests(mm, pudp, saved_pmdp);
+	ptl = pud_lock(args.mm, args.pudp);
+	pud_clear_tests(&args);
+	pud_advanced_tests(&args);
+	pud_huge_tests(&args);
+	pud_populate_tests(&args);
 	spin_unlock(ptl);
 
 	spin_lock(&mm->page_table_lock);
-- 
2.23.0

