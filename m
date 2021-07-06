Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B93BC65B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhGFGUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhGFGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625552290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpwSgpFLoDsdkUovQ9z2uwcbJjcZlIAZZdxuaSnsMUg=;
        b=byZKcKmEpf0pQ9iXKwU7QcfwhNf1SXTtKrW7tty7Zc7rjOwVSwahTw5qV8LuPRLc3euD9p
        81y5vNJ+RAIU9k4rOxqKQHPSPPc/39S14+jMB9uyH0k42xGOFZ5t1vIdNjCFdfqxf8AGQD
        m40f5i2VAo793KsTJ3qnW+hA0PAfsj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-DwZIVDjnPJOxW-kURgutTA-1; Tue, 06 Jul 2021 02:18:07 -0400
X-MC-Unique: DwZIVDjnPJOxW-kURgutTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 747C11800D41;
        Tue,  6 Jul 2021 06:18:06 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA77C60583;
        Tue,  6 Jul 2021 06:18:00 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com, chuhu@redhat.com
Subject: [PATCH 01/12] mm/debug_vm_pgtable: Introduce struct vm_pgtable_debug
Date:   Tue,  6 Jul 2021 14:17:37 +0800
Message-Id: <20210706061748.161258-2-gshan@redhat.com>
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
References: <20210706061748.161258-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In debug_vm_pgtable(), there are many local variables introduced
to track the needed information and they are passed to the functions
for various test cases. It'd better to introduce a struct as place
holder for these information. With it, what the functions for various
test cases need is the struct, to simplify the code. It makes the code
easier to be maintained.

Besides, set_pte_at() could access the data on the corresponding pages.
So the test cases using set_pte_at() should have the pages allocated
from buddy. Otherwise, we're acceessing pages that aren't owned by us.
This causes issues like page flag corruption. So we need the allocated
pages for these tests where set_pte_at() is used. The struct is introduced
so that the old and new implementation can coexist so that the patches
can be organized in a easy way.

This introduces "struct vm_pgtable_debug" for above purposes. The struct
is initialized and destroyed, but the information in the struct isn't
used yet. They will be used in subsequent patches.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug_vm_pgtable.c | 210 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 1c922691aa61..225e2ea4d72f 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -58,6 +58,36 @@
 #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
 #define RANDOM_NZVALUE	GENMASK(7, 0)
 
+struct vm_pgtable_debug {
+	struct mm_struct	*mm;
+	struct vm_area_struct	*vma;
+
+	pgd_t			*pgdp;
+	p4d_t			*p4dp;
+	pud_t			*pudp;
+	pmd_t			*pmdp;
+	pte_t			*ptep;
+
+	p4d_t			*start_p4dp;
+	pud_t			*start_pudp;
+	pmd_t			*start_pmdp;
+	pgtable_t		start_ptep;
+
+	unsigned long		vaddr;
+	pgprot_t		page_prot;
+	pgprot_t		page_prot_none;
+
+	unsigned long		pud_pfn;
+	unsigned long		pmd_pfn;
+	unsigned long		pte_pfn;
+
+	unsigned long		fixed_pgd_pfn;
+	unsigned long		fixed_p4d_pfn;
+	unsigned long		fixed_pud_pfn;
+	unsigned long		fixed_pmd_pfn;
+	unsigned long		fixed_pte_pfn;
+};
+
 static void __init pte_basic_tests(unsigned long pfn, int idx)
 {
 	pgprot_t prot = protection_map[idx];
@@ -955,8 +985,180 @@ static unsigned long __init get_random_vaddr(void)
 	return random_vaddr;
 }
 
+static void __init free_mem(struct vm_pgtable_debug *debug)
+{
+	struct page *page = NULL;
+	int order = 0;
+
+	/* Free (huge) page */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	if (has_transparent_hugepage() &&
+	    debug->pud_pfn != ULONG_MAX) {
+		page = pfn_to_page(debug->pud_pfn);
+		order = HPAGE_PUD_SHIFT - PAGE_SHIFT;
+	}
+#endif
+
+	if (has_transparent_hugepage() &&
+	    debug->pmd_pfn != ULONG_MAX && !page) {
+		page = pfn_to_page(debug->pmd_pfn);
+		order = HPAGE_PMD_ORDER;
+	}
+#endif
+
+	if (debug->pte_pfn != ULONG_MAX && !page) {
+		page = pfn_to_page(debug->pte_pfn);
+		order = 0;
+	}
+
+	if (page)
+		__free_pages(page, order);
+
+	/* Free page table */
+	if (debug->start_ptep) {
+		pte_free(debug->mm, debug->start_ptep);
+		mm_dec_nr_ptes(debug->mm);
+	}
+
+	if (debug->start_pmdp) {
+		pmd_free(debug->mm, debug->start_pmdp);
+		mm_dec_nr_pmds(debug->mm);
+	}
+
+	if (debug->start_pudp) {
+		pud_free(debug->mm, debug->start_pudp);
+		mm_dec_nr_puds(debug->mm);
+	}
+
+	if (debug->start_p4dp)
+		p4d_free(debug->mm, debug->p4dp);
+
+	/* Free vma and mm struct */
+	if (debug->vma)
+		vm_area_free(debug->vma);
+	if (debug->mm)
+		mmdrop(debug->mm);
+}
+
+static int __init alloc_mem(struct vm_pgtable_debug *debug)
+{
+	struct page *page = NULL;
+	phys_addr_t phys;
+	int ret = 0;
+
+	/* Initialize the debugging data */
+	debug->mm             = NULL;
+	debug->vma            = NULL;
+	debug->pgdp           = NULL;
+	debug->p4dp           = NULL;
+	debug->pudp           = NULL;
+	debug->pmdp           = NULL;
+	debug->ptep           = NULL;
+	debug->start_p4dp     = NULL;
+	debug->start_pudp     = NULL;
+	debug->start_pmdp     = NULL;
+	debug->start_ptep     = NULL;
+	debug->vaddr          = 0UL;
+	debug->page_prot      = vm_get_page_prot(VM_READ | VM_WRITE | VM_EXEC);
+	debug->page_prot_none = __P000;
+	debug->pud_pfn        = ULONG_MAX;
+	debug->pmd_pfn        = ULONG_MAX;
+	debug->pte_pfn        = ULONG_MAX;
+	debug->fixed_pgd_pfn  = ULONG_MAX;
+	debug->fixed_p4d_pfn  = ULONG_MAX;
+	debug->fixed_pud_pfn  = ULONG_MAX;
+	debug->fixed_pmd_pfn  = ULONG_MAX;
+	debug->fixed_pte_pfn  = ULONG_MAX;
+
+	/* Allocate mm and vma */
+	debug->mm = mm_alloc();
+	if (!debug->mm) {
+		pr_warn("Failed to allocate mm struct\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	debug->vma = vm_area_alloc(debug->mm);
+	if (!debug->vma) {
+		pr_warn("Failed to allocate vma\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Figure out the virtual address and allocate page table entries */
+	debug->vaddr = get_random_vaddr();
+	debug->pgdp = pgd_offset(debug->mm, debug->vaddr);
+	debug->p4dp = p4d_alloc(debug->mm, debug->pgdp, debug->vaddr);
+	debug->pudp = debug->p4dp ?
+		      pud_alloc(debug->mm, debug->p4dp, debug->vaddr) : NULL;
+	debug->pmdp = debug->pudp ?
+		      pmd_alloc(debug->mm, debug->pudp, debug->vaddr) : NULL;
+	debug->ptep = debug->pmdp ?
+		      pte_alloc_map(debug->mm, debug->pmdp, debug->vaddr) : NULL;
+	if (!debug->ptep) {
+		pr_warn("Failed to allocate page table\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/*
+	 * The above page table entries will be modified. Lets save the
+	 * page table entries so that they can be released when the tests
+	 * are completed.
+	 */
+	debug->start_p4dp = p4d_offset(debug->pgdp, 0UL);
+	debug->start_pudp = pud_offset(debug->p4dp, 0UL);
+	debug->start_pmdp = pmd_offset(debug->pudp, 0UL);
+	debug->start_ptep = pmd_pgtable(*(debug->pmdp));
+
+	/*
+	 * Figure out the fixed addresses, which are all around the kernel
+	 * symbol (@start_kernel). The corresponding PFNs might be invalid,
+	 * but it's fine as the following tests won't access the pages.
+	 */
+	phys = __pa_symbol(&start_kernel);
+	debug->fixed_pgd_pfn = __phys_to_pfn(phys & PGDIR_MASK);
+	debug->fixed_p4d_pfn = __phys_to_pfn(phys & P4D_MASK);
+	debug->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
+	debug->fixed_pmd_pfn = __phys_to_pfn(phys & PMD_MASK);
+	debug->fixed_pte_pfn = __phys_to_pfn(phys & PAGE_MASK);
+
+	/*
+	 * Allocate (huge) pages because some of the tests need to access
+	 * the data in the pages. The corresponding tests will be skipped
+	 * if we fail to allocate (huge) pages.
+	 */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	if (has_transparent_hugepage()) {
+		page = alloc_pages(GFP_KERNEL, HPAGE_PUD_SHIFT - PAGE_SHIFT);
+		if (page)
+			debug->pud_pfn = page_to_pfn(page);
+	}
+#endif
+
+	if (has_transparent_hugepage()) {
+		page = page ? page : alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
+		if (page)
+			debug->pmd_pfn = page_to_pfn(page);
+	}
+#endif
+
+	page = page ? page : alloc_pages(GFP_KERNEL, 0);
+	if (page)
+		debug->pte_pfn = page_to_pfn(page);
+
+	return 0;
+
+error:
+	free_mem(debug);
+	return ret;
+}
+
 static int __init debug_vm_pgtable(void)
 {
+	struct vm_pgtable_debug debug;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	pgd_t *pgdp;
@@ -970,9 +1172,13 @@ static int __init debug_vm_pgtable(void)
 	unsigned long vaddr, pte_aligned, pmd_aligned;
 	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
 	spinlock_t *ptl = NULL;
-	int idx;
+	int idx, ret;
 
 	pr_info("Validating architecture page table helpers\n");
+	ret = alloc_mem(&debug);
+	if (ret)
+		return ret;
+
 	prot = vm_get_page_prot(VMFLAGS);
 	vaddr = get_random_vaddr();
 	mm = mm_alloc();
@@ -1127,6 +1333,8 @@ static int __init debug_vm_pgtable(void)
 	mm_dec_nr_pmds(mm);
 	mm_dec_nr_ptes(mm);
 	mmdrop(mm);
+
+	free_mem(&debug);
 	return 0;
 }
 late_initcall(debug_vm_pgtable);
-- 
2.23.0

