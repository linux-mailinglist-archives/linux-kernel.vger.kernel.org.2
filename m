Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109273CCD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhGSFpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234520AbhGSFpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626673330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHn3ES90PqPzx3pjcflhkt+mowVhSyXgG6u7rS/p/2A=;
        b=B0VzoTB/fa4JSifrJu7FXTDhVXaeINe1t1XsfAYZskuMrGuQSPmtT2DsyHqCaunTf7Omhz
        BIOvPGgUd9FgQG4MctPRio8hhstTXF0IJatEZ1JI3QTt1usu5eQi61dZN7ySWTW9Sc0ZPd
        iaYDljIiIljh/sEuZfGcpsPZYtKzEns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-fCierSU7MIupTsv2uv6ncA-1; Mon, 19 Jul 2021 01:42:07 -0400
X-MC-Unique: fCierSU7MIupTsv2uv6ncA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCEBF19200C4;
        Mon, 19 Jul 2021 05:42:05 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49423369A;
        Mon, 19 Jul 2021 05:42:02 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v2 11/12] mm/debug_vm_pgtable: Remove unused code
Date:   Mon, 19 Jul 2021 13:41:37 +0800
Message-Id: <20210719054138.198373-12-gshan@redhat.com>
In-Reply-To: <20210719054138.198373-1-gshan@redhat.com>
References: <20210719054138.198373-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables used by old implementation isn't needed as we switched
to "struct pgtable_debug_args". Lets remove it.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 84 -------------------------------------------
 1 file changed, 84 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index ca1faff6dbe3..162a12c10aa8 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1122,17 +1122,6 @@ static int __init init_args(struct pgtable_debug_args *args)
 static int __init debug_vm_pgtable(void)
 {
 	struct pgtable_debug_args args;
-	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-	pgd_t *pgdp;
-	p4d_t *p4dp, *saved_p4dp;
-	pud_t *pudp, *saved_pudp;
-	pmd_t *pmdp, *saved_pmdp, pmd;
-	pgtable_t saved_ptep;
-	pgprot_t prot, protnone;
-	phys_addr_t paddr;
-	unsigned long vaddr, pte_aligned, pmd_aligned;
-	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
 	spinlock_t *ptl = NULL;
 	int idx, ret;
 
@@ -1141,68 +1130,6 @@ static int __init debug_vm_pgtable(void)
 	if (ret)
 		return ret;
 
-	prot = vm_get_page_prot(VMFLAGS);
-	vaddr = get_random_vaddr();
-	mm = mm_alloc();
-	if (!mm) {
-		pr_err("mm_struct allocation failed\n");
-		return 1;
-	}
-
-	/*
-	 * __P000 (or even __S000) will help create page table entries with
-	 * PROT_NONE permission as required for pxx_protnone_tests().
-	 */
-	protnone = __P000;
-
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		pr_err("vma allocation failed\n");
-		return 1;
-	}
-
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
-	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
-	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
-	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
-	p4d_aligned = (paddr & P4D_MASK) >> PAGE_SHIFT;
-	pgd_aligned = (paddr & PGDIR_MASK) >> PAGE_SHIFT;
-	WARN_ON(!pfn_valid(pte_aligned));
-
-	pgdp = pgd_offset(mm, vaddr);
-	p4dp = p4d_alloc(mm, pgdp, vaddr);
-	pudp = pud_alloc(mm, p4dp, vaddr);
-	pmdp = pmd_alloc(mm, pudp, vaddr);
-	/*
-	 * Allocate pgtable_t
-	 */
-	if (pte_alloc(mm, pmdp)) {
-		pr_err("pgtable allocation failed\n");
-		return 1;
-	}
-
-	/*
-	 * Save all the page table page addresses as the page table
-	 * entries will be used for testing with random or garbage
-	 * values. These saved addresses will be used for freeing
-	 * page table pages.
-	 */
-	pmd = READ_ONCE(*pmdp);
-	saved_p4dp = p4d_offset(pgdp, 0UL);
-	saved_pudp = pud_offset(p4dp, 0UL);
-	saved_pmdp = pmd_offset(pudp, 0UL);
-	saved_ptep = pmd_pgtable(pmd);
-
 	/*
 	 * Iterate over the protection_map[] to make sure that all
 	 * the basic page table transformation validations just hold
@@ -1284,17 +1211,6 @@ static int __init debug_vm_pgtable(void)
 	pgd_populate_tests(&args);
 	spin_unlock(&(args.mm->page_table_lock));
 
-	p4d_free(mm, saved_p4dp);
-	pud_free(mm, saved_pudp);
-	pmd_free(mm, saved_pmdp);
-	pte_free(mm, saved_ptep);
-
-	vm_area_free(vma);
-	mm_dec_nr_puds(mm);
-	mm_dec_nr_pmds(mm);
-	mm_dec_nr_ptes(mm);
-	mmdrop(mm);
-
 	destroy_args(&args);
 	return 0;
 }
-- 
2.23.0

