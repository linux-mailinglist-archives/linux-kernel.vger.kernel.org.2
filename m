Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCF3CCD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhGSFpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233421AbhGSFo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626673316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRmAGYDu2W/sAdWTUYmhpkDnhktYGR+bYXOsIlZlbAI=;
        b=hdFg3/nr/ehcXi2EsWwAsUN4Q2egOyHzCntL5i2gmVUC5UfCXxLDF1YpHKJiJoa9RtErSw
        MH86ZjkMmls+vrMAKHx59Mg3qLrEMyGSeKmRhJsFcx4aI5AXOe/F7qXMtMePPw7QRBVA6d
        0igkbTPtXDVJ9pyAcKg30I5CTJaVjHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Ud8vOFa-OGW4gVtctjaIkg-1; Mon, 19 Jul 2021 01:41:54 -0400
X-MC-Unique: Ud8vOFa-OGW4gVtctjaIkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B8A9800050;
        Mon, 19 Jul 2021 05:41:53 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5626369A;
        Mon, 19 Jul 2021 05:41:50 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 07/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in PTE modifying tests
Date:   Mon, 19 Jul 2021 13:41:33 +0800
Message-Id: <20210719054138.198373-8-gshan@redhat.com>
In-Reply-To: <20210719054138.198373-1-gshan@redhat.com>
References: <20210719054138.198373-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in PTE modifying tests. The allocated
page is used as set_pte_at() is used there. The tests are skipped if
the allocated page doesn't exist.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 71 +++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a031f2a21c58..7be2091bd0b5 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -116,10 +116,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
 }
 
-static void __init pte_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pte_t *ptep,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
+static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte;
 
@@ -130,33 +127,38 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
 	 */
 
 	pr_debug("Validating PTE advanced\n");
-	pte = pfn_pte(pfn, prot);
-	set_pte_at(mm, vaddr, ptep, pte);
-	ptep_set_wrprotect(mm, vaddr, ptep);
-	pte = ptep_get(ptep);
+	if (args->pte_pfn == ULONG_MAX) {
+		pr_debug("%s: Skipped\n", __func__);
+		return;
+	}
+
+	pte = pfn_pte(args->pte_pfn, args->page_prot);
+	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
+	ptep_set_wrprotect(args->mm, args->vaddr, args->ptep);
+	pte = ptep_get(args->ptep);
 	WARN_ON(pte_write(pte));
-	ptep_get_and_clear(mm, vaddr, ptep);
-	pte = ptep_get(ptep);
+	ptep_get_and_clear(args->mm, args->vaddr, args->ptep);
+	pte = ptep_get(args->ptep);
 	WARN_ON(!pte_none(pte));
 
-	pte = pfn_pte(pfn, prot);
+	pte = pfn_pte(args->pte_pfn, args->page_prot);
 	pte = pte_wrprotect(pte);
 	pte = pte_mkclean(pte);
-	set_pte_at(mm, vaddr, ptep, pte);
+	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
 	pte = pte_mkwrite(pte);
 	pte = pte_mkdirty(pte);
-	ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
-	pte = ptep_get(ptep);
+	ptep_set_access_flags(args->vma, args->vaddr, args->ptep, pte, 1);
+	pte = ptep_get(args->ptep);
 	WARN_ON(!(pte_write(pte) && pte_dirty(pte)));
-	ptep_get_and_clear_full(mm, vaddr, ptep, 1);
-	pte = ptep_get(ptep);
+	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
+	pte = ptep_get(args->ptep);
 	WARN_ON(!pte_none(pte));
 
-	pte = pfn_pte(pfn, prot);
+	pte = pfn_pte(args->pte_pfn, args->page_prot);
 	pte = pte_mkyoung(pte);
-	set_pte_at(mm, vaddr, ptep, pte);
-	ptep_test_and_clear_young(vma, vaddr, ptep);
-	pte = ptep_get(ptep);
+	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
+	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
+	pte = ptep_get(args->ptep);
 	WARN_ON(pte_young(pte));
 }
 
@@ -617,20 +619,24 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 }
 #endif /* PAGETABLE_P4D_FOLDED */
 
-static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
-				   unsigned long pfn, unsigned long vaddr,
-				   pgprot_t prot)
+static void __init pte_clear_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte;
 
 	pr_debug("Validating PTE clear\n");
+	if (args->pte_pfn == ULONG_MAX) {
+		pr_debug("%s: Skipped\n", __func__);
+		return;
+	}
+
+	pte = pfn_pte(args->pte_pfn, args->page_prot);
 #ifndef CONFIG_RISCV
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
 #endif
-	set_pte_at(mm, vaddr, ptep, pte);
+	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
 	barrier();
-	pte_clear(mm, vaddr, ptep);
-	pte = ptep_get(ptep);
+	pte_clear(args->mm, args->vaddr, args->ptep);
+	pte = ptep_get(args->ptep);
 	WARN_ON(!pte_none(pte));
 }
 
@@ -1149,7 +1155,6 @@ static int __init debug_vm_pgtable(void)
 	p4d_t *p4dp, *saved_p4dp;
 	pud_t *pudp, *saved_pudp;
 	pmd_t *pmdp, *saved_pmdp, pmd;
-	pte_t *ptep;
 	pgtable_t saved_ptep;
 	pgprot_t prot, protnone;
 	phys_addr_t paddr;
@@ -1279,11 +1284,11 @@ static int __init debug_vm_pgtable(void)
 	 * Page table modifying tests. They need to hold
 	 * proper page table lock.
 	 */
-
-	ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
-	pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
-	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
-	pte_unmap_unlock(ptep, ptl);
+	ptl = pte_lockptr(args.mm, args.pmdp);
+	spin_lock(ptl);
+	pte_clear_tests(&args);
+	pte_advanced_tests(&args);
+	spin_unlock(ptl);
 
 	ptl = pmd_lock(mm, pmdp);
 	pmd_clear_tests(mm, pmdp);
-- 
2.23.0

