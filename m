Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F93D6EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhG0GPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235770AbhG0GPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627366501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0RHL/Ntti27fnEKXp/RSCDk01A20WAVdHDsksy3fkVY=;
        b=E+bUI1DB0GzS1X/VPgy/4SKB2eWakZHwJV7q5a9moKswj/KGK/tjFquCeHXWq8eLz3JAh3
        aamfRBStcaMEurEFena5Bi4THEWlT1v4niTOqgz/gOCaic8VETZTYhNpCXMuheeyjVxCol
        ZQSJ2xFDpp0kZUN1+y0T29+40RmT4CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-xc_h2i3pPBGzU9q6ip15IA-1; Tue, 27 Jul 2021 02:14:59 -0400
X-MC-Unique: xc_h2i3pPBGzU9q6ip15IA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA2BD760C1;
        Tue, 27 Jul 2021 06:14:57 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F07EE9C8C3;
        Tue, 27 Jul 2021 06:14:50 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        gerald.schaefer@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        christophe.leroy@csgroup.eu, cai@lca.pw, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v4 07/12] mm/debug_vm_pgtable: Use struct pgtable_debug_args in PTE modifying tests
Date:   Tue, 27 Jul 2021 14:13:56 +0800
Message-Id: <20210727061401.592616-8-gshan@redhat.com>
In-Reply-To: <20210727061401.592616-1-gshan@redhat.com>
References: <20210727061401.592616-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses struct pgtable_debug_args in PTE modifying tests. The allocated
page is used as set_pte_at() is used there. The tests are skipped if
the allocated page doesn't exist. Besides, the unused variable @ptep
and @pte_aligned in debug_vm_pgtable() are dropped.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 64 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 9136195efde3..b5b22e666954 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -117,10 +117,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
 }
 
-static void __init pte_advanced_tests(struct mm_struct *mm,
-				      struct vm_area_struct *vma, pte_t *ptep,
-				      unsigned long pfn, unsigned long vaddr,
-				      pgprot_t prot)
+static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte;
 
@@ -129,35 +126,37 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
 	 * This requires set_pte_at to be not used to update an
 	 * existing pte entry. Clear pte before we do set_pte_at
 	 */
+	if (args->pte_pfn == ULONG_MAX)
+		return;
 
 	pr_debug("Validating PTE advanced\n");
-	pte = pfn_pte(pfn, prot);
-	set_pte_at(mm, vaddr, ptep, pte);
-	ptep_set_wrprotect(mm, vaddr, ptep);
-	pte = ptep_get(ptep);
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
 
@@ -618,20 +617,21 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 }
 #endif /* PAGETABLE_P4D_FOLDED */
 
-static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
-				   unsigned long pfn, unsigned long vaddr,
-				   pgprot_t prot)
+static void __init pte_clear_tests(struct pgtable_debug_args *args)
 {
-	pte_t pte = pfn_pte(pfn, prot);
+	pte_t pte = pfn_pte(args->pte_pfn, args->page_prot);
+
+	if (args->pte_pfn == ULONG_MAX)
+		return;
 
 	pr_debug("Validating PTE clear\n");
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
 
@@ -1237,7 +1237,7 @@ static int __init debug_vm_pgtable(void)
 	pgtable_t saved_ptep;
 	pgprot_t prot;
 	phys_addr_t paddr;
-	unsigned long vaddr, pte_aligned, pmd_aligned;
+	unsigned long vaddr, pmd_aligned;
 	unsigned long pud_aligned;
 	spinlock_t *ptl = NULL;
 	int idx, ret;
@@ -1272,10 +1272,8 @@ static int __init debug_vm_pgtable(void)
 	 */
 	paddr = __pa_symbol(&start_kernel);
 
-	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
 	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
 	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
-	WARN_ON(!pfn_valid(pte_aligned));
 
 	pgdp = pgd_offset(mm, vaddr);
 	p4dp = p4d_alloc(mm, pgdp, vaddr);
@@ -1357,9 +1355,9 @@ static int __init debug_vm_pgtable(void)
 	 * proper page table lock.
 	 */
 
-	ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
-	pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
-	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
+	ptep = pte_offset_map_lock(args.mm, args.pmdp, args.vaddr, &ptl);
+	pte_clear_tests(&args);
+	pte_advanced_tests(&args);
 	pte_unmap_unlock(ptep, ptl);
 
 	ptl = pmd_lock(mm, pmdp);
-- 
2.23.0

