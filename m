Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A23BC663
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhGFGVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhGFGVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBk1oz7ojY+fvkBs8xNxVAkbEhj914dQYyR+sCAdK5U=;
        b=P2E6g0x6Mpipafkai/IbyTX2SBg4JAD1zzjPjpNM20SIwRrSuz3jbUNsVyw1eJmGdZkvbb
        nesoQa8jI70bpF86+LBErRjk1KOpsuKPWDgGyiyMZ8w6Y6q/tSznaDdPefVjaQrabZ+vwl
        kSL7oNJKE0FmKfKZhoQu594ul1XIDkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-D1d1i8S3OT2xryhkLkOxWA-1; Tue, 06 Jul 2021 02:18:35 -0400
X-MC-Unique: D1d1i8S3OT2xryhkLkOxWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47E47800D62;
        Tue,  6 Jul 2021 06:18:34 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB6769CB4;
        Tue,  6 Jul 2021 06:18:31 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 09/12] mm/vm_debug_pgtable: Use struct vm_pgtable_debug in PUD modifying tests
Date:   Tue,  6 Jul 2021 14:17:45 +0800
Message-Id: <20210706061748.161258-10-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct vm_pgtable_debug in PUD modifying tests. The allocated
huge page is used when set_pud_at() is used. The corresponding tests
are skipped if the huge page doesn't exist.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 113 +++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 63 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index c554b6c42281..59fd9440ab12 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -338,55 +338,55 @@ static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx)
 	WARN_ON(!pud_bad(pud_mkhuge(pud)));
 }
 
-static void __init pud_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pud_t *pudp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
+static void __init pud_advanced_tests(struct vm_pgtable_debug *debug)
 {
+	unsigned long vaddr = (debug->vaddr & HPAGE_PUD_MASK);
 	pud_t pud;
 
 	if (!has_transparent_hugepage())
 		return;
 
 	pr_debug("Validating PUD advanced\n");
-	/* Align the address wrt HPAGE_PUD_SIZE */
-	vaddr &= HPAGE_PUD_MASK;
+	if (debug->pud_pfn == ULONG_MAX) {
+		pr_debug("%s: Skipped\n", __func__);
+		return;
+	}
 
-	pud = pfn_pud(pfn, prot);
-	set_pud_at(mm, vaddr, pudp, pud);
-	pudp_set_wrprotect(mm, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	pud = pfn_pud(debug->pud_pfn, debug->page_prot);
+	set_pud_at(debug->mm, vaddr, debug->pudp, pud);
+	pudp_set_wrprotect(debug->mm, vaddr, debug->pudp);
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(pud_write(pud));
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	pudp_huge_get_and_clear(mm, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	pudp_huge_get_and_clear(debug->mm, vaddr, debug->pudp);
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(debug->pud_pfn, debug->page_prot);
 	pud = pud_wrprotect(pud);
 	pud = pud_mkclean(pud);
-	set_pud_at(mm, vaddr, pudp, pud);
+	set_pud_at(debug->mm, vaddr, debug->pudp, pud);
 	pud = pud_mkwrite(pud);
 	pud = pud_mkdirty(pud);
-	pudp_set_access_flags(vma, vaddr, pudp, pud, 1);
-	pud = READ_ONCE(*pudp);
+	pudp_set_access_flags(debug->vma, vaddr, debug->pudp, pud, 1);
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(!(pud_write(pud) && pud_dirty(pud)));
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	pudp_huge_get_and_clear_full(mm, vaddr, pudp, 1);
-	pud = READ_ONCE(*pudp);
+	pudp_huge_get_and_clear_full(debug->mm, vaddr, debug->pudp, 1);
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-	pud = pfn_pud(pfn, prot);
+	pud = pfn_pud(debug->pud_pfn, debug->page_prot);
 	pud = pud_mkyoung(pud);
-	set_pud_at(mm, vaddr, pudp, pud);
-	pudp_test_and_clear_young(vma, vaddr, pudp);
-	pud = READ_ONCE(*pudp);
+	set_pud_at(debug->mm, vaddr, debug->pudp, pud);
+	pudp_test_and_clear_young(debug->vma, vaddr, debug->pudp);
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(pud_young(pud));
 
-	pudp_huge_get_and_clear(mm, vaddr, pudp);
+	pudp_huge_get_and_clear(debug->mm, vaddr, debug->pudp);
 }
 
 static void __init pud_leaf_tests(struct vm_pgtable_debug *debug)
@@ -406,24 +406,14 @@ static void __init pud_leaf_tests(struct vm_pgtable_debug *debug)
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
-static void __init pud_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pud_t *pudp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
-{
-}
+static void __init pud_advanced_tests(struct vm_pgtable_debug *debug) { }
 static void __init pud_leaf_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
 static void __init pud_basic_tests(struct vm_pgtable_debug *debug, int idx) { }
 static void __init pmd_advanced_tests(struct vm_pgtable_debug *debug) { }
-static void __init pud_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pud_t *pudp,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
-{
-}
+static void __init pud_advanced_tests(struct vm_pgtable_debug *debug) { }
 static void __init pmd_leaf_tests(struct vm_pgtable_debug *debug) { }
 static void __init pud_leaf_tests(struct vm_pgtable_debug *debug) { }
 static void __init pmd_savedwrite_tests(struct vm_pgtable_debug *debug) { }
@@ -450,11 +440,11 @@ static void __init pmd_huge_tests(struct vm_pgtable_debug *debug)
 	WARN_ON(!pmd_none(pmd));
 }
 
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
+static void __init pud_huge_tests(struct vm_pgtable_debug *debug)
 {
 	pud_t pud;
 
-	if (!arch_vmap_pud_supported(prot))
+	if (!arch_vmap_pud_supported(debug->page_prot))
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
+	WRITE_ONCE(*(debug->pudp), __pud(0));
+	WARN_ON(!pud_set_huge(debug->pudp, __pfn_to_phys(debug->fixed_pud_pfn),
+			      debug->page_prot));
+	WARN_ON(!pud_clear_huge(debug->pudp));
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(!pud_none(pud));
 }
 #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static void __init pmd_huge_tests(struct vm_pgtable_debug *debug) { }
-static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
+static void __init pud_huge_tests(struct vm_pgtable_debug *debug) { }
 #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 static void __init p4d_basic_tests(void)
@@ -492,27 +483,26 @@ static void __init pgd_basic_tests(void)
 }
 
 #ifndef __PAGETABLE_PUD_FOLDED
-static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp)
+static void __init pud_clear_tests(struct vm_pgtable_debug *debug)
 {
-	pud_t pud = READ_ONCE(*pudp);
+	pud_t pud = READ_ONCE(*(debug->pudp));
 
-	if (mm_pmd_folded(mm))
+	if (mm_pmd_folded(debug->mm))
 		return;
 
 	pr_debug("Validating PUD clear\n");
 	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
-	WRITE_ONCE(*pudp, pud);
-	pud_clear(pudp);
-	pud = READ_ONCE(*pudp);
+	WRITE_ONCE(*(debug->pudp), pud);
+	pud_clear(debug->pudp);
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(!pud_none(pud));
 }
 
-static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
-				      pmd_t *pmdp)
+static void __init pud_populate_tests(struct vm_pgtable_debug *debug)
 {
 	pud_t pud;
 
-	if (mm_pmd_folded(mm))
+	if (mm_pmd_folded(debug->mm))
 		return;
 
 	pr_debug("Validating PUD populate\n");
@@ -520,16 +510,13 @@ static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pud_bad().
 	 */
-	pud_populate(mm, pudp, pmdp);
-	pud = READ_ONCE(*pudp);
+	pud_populate(debug->mm, debug->pudp, debug->start_pmdp);
+	pud = READ_ONCE(*(debug->pudp));
 	WARN_ON(pud_bad(pud));
 }
 #else  /* !__PAGETABLE_PUD_FOLDED */
-static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp) { }
-static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
-				      pmd_t *pmdp)
-{
-}
+static void __init pud_clear_tests(struct vm_pgtable_debug *debug) { }
+static void __init pud_populate_tests(struct vm_pgtable_debug *debug) { }
 #endif /* PAGETABLE_PUD_FOLDED */
 
 #ifndef __PAGETABLE_P4D_FOLDED
@@ -1306,11 +1293,11 @@ static int __init debug_vm_pgtable(void)
 	pmd_populate_tests(&debug);
 	spin_unlock(ptl);
 
-	ptl = pud_lock(mm, pudp);
-	pud_clear_tests(mm, pudp);
-	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
-	pud_huge_tests(pudp, pud_aligned, prot);
-	pud_populate_tests(mm, pudp, saved_pmdp);
+	ptl = pud_lock(debug.mm, debug.pudp);
+	pud_clear_tests(&debug);
+	pud_advanced_tests(&debug);
+	pud_huge_tests(&debug);
+	pud_populate_tests(&debug);
 	spin_unlock(ptl);
 
 	spin_lock(&mm->page_table_lock);
-- 
2.23.0

