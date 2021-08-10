Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820C03E429E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHIJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234459AbhHIJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628501290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaYoRwKR5wEt5X2S1acN5t0iLZtiux1phcn784f/a9o=;
        b=IMAsBkqcrcDs86fTej9Y9WmX0qX+EnDeHN4ozUYOMML2/xZtc+/7Wq7jkavYDsEHFoi6sf
        A04CNyEerfClFQfzXzDUaHdiUF1tXSnoJmwLKV3pvd6zzG6COeCK+BID8ezpdr4FIJDHoT
        29VRWkIpV+6QsB8fhxD1o3b1lsD/4Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-g7sMByOcMqiAaJzieoOE2w-1; Mon, 09 Aug 2021 05:28:07 -0400
X-MC-Unique: g7sMByOcMqiAaJzieoOE2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8CE4107ACF5;
        Mon,  9 Aug 2021 09:28:05 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-155.bne.redhat.com [10.64.54.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0029D5D6A8;
        Mon,  9 Aug 2021 09:27:58 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, vgupta@synopsys.com, akpm@linux-foundation.org,
        chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v6 08/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in PMD modifying tests
Date:   Mon,  9 Aug 2021 17:26:27 +0800
Message-Id: <20210809092631.1888748-9-gshan@redhat.com>
In-Reply-To: <20210809092631.1888748-1-gshan@redhat.com>
References: <20210809092631.1888748-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in PMD modifying tests. The allocated
huge page is used when set_pmd_at() is used. The corresponding tests
are skipped if the huge page doesn't exist. Besides, the unused variable
@pmd_aligned in debug_vm_pgtable() is dropped.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 98 ++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 52 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 652f26f5ecd6..abf778f729fd 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -211,54 +211,55 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
 }
 
-static void __init pmd_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pmd_t *pmdp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot, pgtable_t pgtable)
+static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
+	unsigned long vaddr = args->vaddr;
 
 	if (!has_transparent_hugepage())
 		return;
 
+	if (args->pmd_pfn == ULONG_MAX)
+		return;
+
 	pr_debug("Validating PMD advanced\n");
 	/* Align the address wrt HPAGE_PMD_SIZE */
 	vaddr &= HPAGE_PMD_MASK;
 
-	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
+	pgtable_trans_huge_deposit(args->mm, args->pmdp, args->start_ptep);
 
-	pmd = pfn_pmd(pfn, prot);
-	set_pmd_at(mm, vaddr, pmdp, pmd);
-	pmdp_set_wrprotect(mm, vaddr, pmdp);
-	pmd = READ_ONCE(*pmdp);
+	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
+	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
+	pmdp_set_wrprotect(args->mm, vaddr, args->pmdp);
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(pmd_write(pmd));
-	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
-	pmd = READ_ONCE(*pmdp);
+	pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
 	pmd = pmd_wrprotect(pmd);
 	pmd = pmd_mkclean(pmd);
-	set_pmd_at(mm, vaddr, pmdp, pmd);
+	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
 	pmd = pmd_mkwrite(pmd);
 	pmd = pmd_mkdirty(pmd);
-	pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
-	pmd = READ_ONCE(*pmdp);
+	pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
-	pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
-	pmd = READ_ONCE(*pmdp);
+	pmdp_huge_get_and_clear_full(args->vma, vaddr, args->pmdp, 1);
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 
-	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
+	pmd = pmd_mkhuge(pfn_pmd(args->pmd_pfn, args->page_prot));
 	pmd = pmd_mkyoung(pmd);
-	set_pmd_at(mm, vaddr, pmdp, pmd);
-	pmdp_test_and_clear_young(vma, vaddr, pmdp);
-	pmd = READ_ONCE(*pmdp);
+	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
+	pmdp_test_and_clear_young(args->vma, vaddr, args->pmdp);
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(pmd_young(pmd));
 
 	/*  Clear the pte entries  */
-	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
-	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
+	pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
+	pgtable_trans_huge_withdraw(args->mm, args->pmdp);
 }
 
 static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
@@ -415,12 +416,7 @@ static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
 static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
-static void __init pmd_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pmd_t *pmdp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot, pgtable_t pgtable)
-{
-}
+static void __init pmd_advanced_tests(struct pgtable_debug_args *args) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pud_t *pudp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -433,11 +429,11 @@ static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
+static void __init pmd_huge_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
-	if (!arch_vmap_pmd_supported(prot))
+	if (!arch_vmap_pmd_supported(args->page_prot))
 		return;
 
 	pr_debug("Validating PMD huge\n");
@@ -445,10 +441,10 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 	 * X86 defined pmd_set_huge() verifies that the given
 	 * PMD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*pmdp, __pmd(0));
-	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
-	WARN_ON(!pmd_clear_huge(pmdp));
-	pmd = READ_ONCE(*pmdp);
+	WRITE_ONCE(*args->pmdp, __pmd(0));
+	WARN_ON(!pmd_set_huge(args->pmdp, __pfn_to_phys(args->fixed_pmd_pfn), args->page_prot));
+	WARN_ON(!pmd_clear_huge(args->pmdp));
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 }
 
@@ -471,7 +467,7 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pud_none(pud));
 }
 #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
-static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_huge_tests(struct pgtable_debug_args *args) { }
 static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
 #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
@@ -635,20 +631,19 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pte_none(pte));
 }
 
-static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
+static void __init pmd_clear_tests(struct pgtable_debug_args *args)
 {
-	pmd_t pmd = READ_ONCE(*pmdp);
+	pmd_t pmd = READ_ONCE(*args->pmdp);
 
 	pr_debug("Validating PMD clear\n");
 	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pmdp, pmd);
-	pmd_clear(pmdp);
-	pmd = READ_ONCE(*pmdp);
+	WRITE_ONCE(*args->pmdp, pmd);
+	pmd_clear(args->pmdp);
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 }
 
-static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
-				      pgtable_t pgtable)
+static void __init pmd_populate_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -657,8 +652,8 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pmd_bad().
 	 */
-	pmd_populate(mm, pmdp, pgtable);
-	pmd = READ_ONCE(*pmdp);
+	pmd_populate(args->mm, args->pmdp, args->start_ptep);
+	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(pmd_bad(pmd));
 }
 
@@ -1224,7 +1219,7 @@ static int __init debug_vm_pgtable(void)
 	pgtable_t saved_ptep;
 	pgprot_t prot;
 	phys_addr_t paddr;
-	unsigned long vaddr, pmd_aligned;
+	unsigned long vaddr;
 	unsigned long pud_aligned;
 	spinlock_t *ptl = NULL;
 	int idx, ret;
@@ -1259,7 +1254,6 @@ static int __init debug_vm_pgtable(void)
 	 */
 	paddr = __pa_symbol(&start_kernel);
 
-	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
 	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
 
 	pgdp = pgd_offset(mm, vaddr);
@@ -1347,11 +1341,11 @@ static int __init debug_vm_pgtable(void)
 	pte_advanced_tests(&args);
 	pte_unmap_unlock(args.ptep, ptl);
 
-	ptl = pmd_lock(mm, pmdp);
-	pmd_clear_tests(mm, pmdp);
-	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
-	pmd_huge_tests(pmdp, pmd_aligned, prot);
-	pmd_populate_tests(mm, pmdp, saved_ptep);
+	ptl = pmd_lock(args.mm, args.pmdp);
+	pmd_clear_tests(&args);
+	pmd_advanced_tests(&args);
+	pmd_huge_tests(&args);
+	pmd_populate_tests(&args);
 	spin_unlock(ptl);
 
 	ptl = pud_lock(mm, pudp);
-- 
2.23.0

