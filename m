Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDC3BC662
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGFGVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhGFGVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdLRMVXjWmvY7VZHVXP3ortBI+YRImx3WOefvtaILtw=;
        b=eqXxpbg6Z7hqn4/N7dAOrJ2v6DXbKESn8/5rSF4tmk1II+o15Sgwh9p3XQlbwFQDZ/WayX
        40vVhRyeoe0VxCDI6XtHe2ykwVzig9yNGqkRQfRjLBx/A44M30AK2VMwF8uoAIirskz2UV
        q0IFDPDktpNq2JRZrS1odPqSACveGlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-p5FZRNcqOOKPRu8GmlZnAQ-1; Tue, 06 Jul 2021 02:18:32 -0400
X-MC-Unique: p5FZRNcqOOKPRu8GmlZnAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA563100CCC2;
        Tue,  6 Jul 2021 06:18:30 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DD7260583;
        Tue,  6 Jul 2021 06:18:28 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 08/12] mm/debug_vm_pgtable: Use struct vm_pgtable_debug in PMD modifying tests
Date:   Tue,  6 Jul 2021 14:17:44 +0800
Message-Id: <20210706061748.161258-9-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct vm_pgtable_debug in PMD modifying tests. The allocated
huge page is used when set_pmd_at() is used. The corresponding tests
are skipped if the huge page doesn't exist.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 99 ++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 2b4f0738f266..c554b6c42281 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -213,54 +213,54 @@ static void __init pmd_basic_tests(struct vm_pgtable_debug *debug, int idx)
 	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
 }
 
-static void __init pmd_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pmd_t *pmdp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot, pgtable_t pgtable)
+static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
+	unsigned long vaddr = (debug->vaddr & HPAGE_PMD_MASK);
 
 	if (!has_transparent_hugepage())
 		return;
 
 	pr_debug("Validating PMD advanced\n");
-	/* Align the address wrt HPAGE_PMD_SIZE */
-	vaddr &= HPAGE_PMD_MASK;
+	if (debug->pmd_pfn == ULONG_MAX) {
+		pr_debug("%s: Skipped\n", __func__);
+		return;
+	}
 
-	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
+	pgtable_trans_huge_deposit(debug->mm, debug->pmdp, debug->start_ptep);
 
-	pmd = pfn_pmd(pfn, prot);
-	set_pmd_at(mm, vaddr, pmdp, pmd);
-	pmdp_set_wrprotect(mm, vaddr, pmdp);
-	pmd = READ_ONCE(*pmdp);
+	pmd = pfn_pmd(debug->pmd_pfn, debug->page_prot);
+	set_pmd_at(debug->mm, vaddr, debug->pmdp, pmd);
+	pmdp_set_wrprotect(debug->mm, vaddr, debug->pmdp);
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(pmd_write(pmd));
-	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
-	pmd = READ_ONCE(*pmdp);
+	pmdp_huge_get_and_clear(debug->mm, vaddr, debug->pmdp);
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(!pmd_none(pmd));
 
-	pmd = pfn_pmd(pfn, prot);
+	pmd = pfn_pmd(debug->pmd_pfn, debug->page_prot);
 	pmd = pmd_wrprotect(pmd);
 	pmd = pmd_mkclean(pmd);
-	set_pmd_at(mm, vaddr, pmdp, pmd);
+	set_pmd_at(debug->mm, vaddr, debug->pmdp, pmd);
 	pmd = pmd_mkwrite(pmd);
 	pmd = pmd_mkdirty(pmd);
-	pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
-	pmd = READ_ONCE(*pmdp);
+	pmdp_set_access_flags(debug->vma, vaddr, debug->pmdp, pmd, 1);
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
-	pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
-	pmd = READ_ONCE(*pmdp);
+	pmdp_huge_get_and_clear_full(debug->vma, vaddr, debug->pmdp, 1);
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(!pmd_none(pmd));
 
-	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
+	pmd = pmd_mkhuge(pfn_pmd(debug->pmd_pfn, debug->page_prot));
 	pmd = pmd_mkyoung(pmd);
-	set_pmd_at(mm, vaddr, pmdp, pmd);
-	pmdp_test_and_clear_young(vma, vaddr, pmdp);
-	pmd = READ_ONCE(*pmdp);
+	set_pmd_at(debug->mm, vaddr, debug->pmdp, pmd);
+	pmdp_test_and_clear_young(debug->vma, vaddr, debug->pmdp);
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(pmd_young(pmd));
 
 	/*  Clear the pte entries  */
-	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
-	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
+	pmdp_huge_get_and_clear(debug->mm, vaddr, debug->pmdp);
+	pgtable_trans_huge_withdraw(debug->mm, debug->pmdp);
 }
 
 static void __init pmd_leaf_tests(struct vm_pgtable_debug *debug)
@@ -417,12 +417,7 @@ static void __init pud_leaf_tests(struct vm_pgtable_debug *debug) { }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
 static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
-static void __init pmd_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pmd_t *pmdp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot, pgtable_t pgtable)
-{
-}
+static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug) { }
 static void __init pud_advanced_tests(struct mm_struct *mm,
 				      struct vm_area_struct *vma, pud_t *pudp,
 				      unsigned long pfn, unsigned long vaddr,
@@ -435,11 +430,11 @@ static void __init pmd_savedwrite_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
+static void __init pmd_huge_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
 
-	if (!arch_vmap_pmd_supported(prot))
+	if (!arch_vmap_pmd_supported(debug->page_prot))
 		return;
 
 	pr_debug("Validating PMD huge\n");
@@ -447,10 +442,11 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 	 * X86 defined pmd_set_huge() verifies that the given
 	 * PMD is not a populated non-leaf entry.
 	 */
-	WRITE_ONCE(*pmdp, __pmd(0));
-	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
-	WARN_ON(!pmd_clear_huge(pmdp));
-	pmd = READ_ONCE(*pmdp);
+	WRITE_ONCE(*(debug->pmdp), __pmd(0));
+	WARN_ON(!pmd_set_huge(debug->pmdp, __pfn_to_phys(debug->fixed_pmd_pfn),
+			      debug->page_prot));
+	WARN_ON(!pmd_clear_huge(debug->pmdp));
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(!pmd_none(pmd));
 }
 
@@ -473,7 +469,7 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 	WARN_ON(!pud_none(pud));
 }
 #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
-static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_huge_tests(struct vm_pgtable_debug *debug) { }
 static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
 #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
@@ -640,20 +636,19 @@ static void __init pte_clear_tests(struct vm_pgtable_debug *debug)
 	WARN_ON(!pte_none(pte));
 }
 
-static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
+static void __init pmd_clear_tests(struct vm_pgtable_debug *debug)
 {
-	pmd_t pmd = READ_ONCE(*pmdp);
+	pmd_t pmd = READ_ONCE(*(debug->pmdp));
 
 	pr_debug("Validating PMD clear\n");
 	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pmdp, pmd);
-	pmd_clear(pmdp);
-	pmd = READ_ONCE(*pmdp);
+	WRITE_ONCE(*(debug->pmdp), pmd);
+	pmd_clear(debug->pmdp);
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(!pmd_none(pmd));
 }
 
-static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
-				      pgtable_t pgtable)
+static void __init pmd_populate_tests(struct vm_pgtable_debug *debug)
 {
 	pmd_t pmd;
 
@@ -662,8 +657,8 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pmd_bad().
 	 */
-	pmd_populate(mm, pmdp, pgtable);
-	pmd = READ_ONCE(*pmdp);
+	pmd_populate(debug->mm, debug->pmdp, debug->start_ptep);
+	pmd = READ_ONCE(*(debug->pmdp));
 	WARN_ON(pmd_bad(pmd));
 }
 
@@ -1304,11 +1299,11 @@ static int __init debug_vm_pgtable(void)
 	pte_advanced_tests(&debug);
 	spin_unlock(ptl);
 
-	ptl = pmd_lock(mm, pmdp);
-	pmd_clear_tests(mm, pmdp);
-	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
-	pmd_huge_tests(pmdp, pmd_aligned, prot);
-	pmd_populate_tests(mm, pmdp, saved_ptep);
+	ptl = pmd_lock(debug.mm, debug.pmdp);
+	pmd_clear_tests(&debug);
+	pmd_advanced_tests(&debug);
+	pmd_huge_tests(&debug);
+	pmd_populate_tests(&debug);
 	spin_unlock(ptl);
 
 	ptl = pud_lock(mm, pudp);
-- 
2.23.0

