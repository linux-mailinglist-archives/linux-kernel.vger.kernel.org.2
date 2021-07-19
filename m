Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB53CD586
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbhGSM1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237334AbhGSM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626700075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/9sZnD939Q8TxqFBncGSL5piEwq8Hv8onEENtvU1Q4=;
        b=AlUtqY7/BTKyLN/NAF89y7KpnhN2EL9FuJaVjlVh8UcjLQ6Ajp8TOqGspph+vNOAifutM+
        At4D/HfiOSCrreoWK4OmrATYqzoMHKIPKHmiXflkEuvl1J9dfK9cuVi/NksE8mxsclhX4i
        cjRSaImVG9gqP9sMl44m67fseCQ/BXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-q84vSwdnPO23cgBdX7yOOA-1; Mon, 19 Jul 2021 09:07:53 -0400
X-MC-Unique: q84vSwdnPO23cgBdX7yOOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76FFA800FF0;
        Mon, 19 Jul 2021 13:07:52 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77BD05D6A1;
        Mon, 19 Jul 2021 13:07:49 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 09/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in PUD modifying tests
Date:   Mon, 19 Jul 2021 21:06:10 +0800
Message-Id: <20210719130613.334901-10-gshan@redhat.com>
In-Reply-To: <20210719130613.334901-1-gshan@redhat.com>
References: <20210719130613.334901-1-gshan@redhat.com>
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
---
 mm/debug_vm_pgtable.c | 130 ++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 80 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index cec3cbf99a6b..57b7ead0708b 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -338,55 +338,55 @@ static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pud_bad(pud_mkhuge(pud)));
 }
 
-static void __init pud_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pud_t *pudp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
+static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 {
+	unsigned long vaddr = (args->vaddr & HPAGE_PUD_MASK);
 	pud_t pud;
 
 	if (!has_transparent_hugepage())
 		return;
 
 	pr_debug("Validating PUD advanced\n");
-	/* Align the address wrt HPAGE_PUD_SIZE */
-	vaddr &= HPAGE_PUD_MASK;
+	if (args->pud_pfn == ULONG_MAX) {
+		pr_debug("%s: Skipped\n", __func__);
+		return;
+	}
 
-	pud = pfn_pud(pfn, prot);
-	set_pud_at(mm, vaddr, pudp, pud);
-	pudp_set_wrprotect(mm, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	pud = pfn_pud(args->pud_pfn, args->page_prot);
+	set_pud_at(args->mm, vaddr, args->pudp, pud);
+	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
+	pud = READ_ONCE(*(args->pudp));
 	WARN_ON(pud_write(pud));
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	pudp_huge_get_and_clear(mm, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	pudp_huge_get_and_clear(args->mm, vaddr, args->pudp);
+	pud = READ_ONCE(*(args->pudp));
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
+	pud = READ_ONCE(*(args->pudp));
 	WARN_ON(!(pud_write(pud) && pud_dirty(pud)));
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	pudp_huge_get_and_clear_full(mm, vaddr, pudp, 1);
-	pud = READ_ONCE(*pudp);
+	pudp_huge_get_and_clear_full(args->mm, vaddr, args->pudp, 1);
+	pud = READ_ONCE(*(args->pudp));
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
+	pud = READ_ONCE(*(args->pudp));
 	WARN_ON(pud_young(pud));
 
-	pudp_huge_get_and_clear(mm, vaddr, pudp);
+	pudp_huge_get_and_clear(args->mm, vaddr, args->pudp);
 }
 
 static void __init pud_leaf_tests(struct pgtable_debug_args *args)
@@ -406,24 +406,14 @@ static void __init pud_leaf_tests(struct pgtable_debug_args *args)
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
@@ -450,11 +440,11 @@ static void __init pmd_huge_tests(struct pgtable_debug_args *args)
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
@@ -462,15 +452,16 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 	 * X86 defined pud_set_huge() verifies that the given
 	 * PUD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*pudp, __pud(0));
-	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
-	WARN_ON(!pud_clear_huge(pudp));
-	pud = READ_ONCE(*pudp);
+	WRITE_ONCE(*(args->pudp), __pud(0));
+	WARN_ON(!pud_set_huge(args->pudp, __pfn_to_phys(args->fixed_pud_pfn),
+			      args->page_prot));
+	WARN_ON(!pud_clear_huge(args->pudp));
+	pud = READ_ONCE(*(args->pudp));
 	WARN_ON(!pud_none(pud));
 }
 #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static void __init pmd_huge_tests(struct pgtable_debug_args *args) { }
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
+static void __init pud_huge_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 static void __init p4d_basic_tests(void)
@@ -492,27 +483,26 @@ static void __init pgd_basic_tests(void)
 }
 
 #ifndef __PAGETABLE_PUD_FOLDED
-static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp)
+static void __init pud_clear_tests(struct pgtable_debug_args *args)
 {
-	pud_t pud = READ_ONCE(*pudp);
+	pud_t pud = READ_ONCE(*(args->pudp));
 
-	if (mm_pmd_folded(mm))
+	if (mm_pmd_folded(args->mm))
 		return;
 
 	pr_debug("Validating PUD clear\n");
 	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pudp, pud);
-	pud_clear(pudp);
-	pud = READ_ONCE(*pudp);
+	WRITE_ONCE(*(args->pudp), pud);
+	pud_clear(args->pudp);
+	pud = READ_ONCE(*(args->pudp));
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
@@ -520,16 +510,13 @@ static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pud_bad().
 	 */
-	pud_populate(mm, pudp, pmdp);
-	pud = READ_ONCE(*pudp);
+	pud_populate(args->mm, args->pudp, args->start_pmdp);
+	pud = READ_ONCE(*(args->pudp));
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
@@ -1152,10 +1139,7 @@ static int __init debug_vm_pgtable(void)
 	pud_t *pudp, *saved_pudp;
 	pmd_t *pmdp, *saved_pmdp, pmd;
 	pgtable_t saved_ptep;
-	pgprot_t prot;
-	phys_addr_t paddr;
 	unsigned long vaddr;
-	unsigned long pud_aligned;
 	spinlock_t *ptl = NULL;
 	int idx, ret;
 
@@ -1164,7 +1148,6 @@ static int __init debug_vm_pgtable(void)
 	if (ret)
 		return ret;
 
-	prot = vm_get_page_prot(VMFLAGS);
 	vaddr = get_random_vaddr();
 	mm = mm_alloc();
 	if (!mm) {
@@ -1178,19 +1161,6 @@ static int __init debug_vm_pgtable(void)
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
@@ -1282,11 +1252,11 @@ static int __init debug_vm_pgtable(void)
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

