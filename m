Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348793CD553
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhGSMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236780AbhGSMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626699655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ept8ytfNgi6/RWaxwL9ykdkTv8f6hQ4XyQuZbRrCM3g=;
        b=jB3fF9X/2vca5/xDw1iAR+efp9xxD17Vw+h83vj1Su0hmVBr4Hmz6xKp1uBBoZZOnNow3l
        ntLirWn5fz3/DLHWCesIVbqInI4+bzcmWotsa1wdsuefkmsWx/GbzK2Ud8ljkTmegptT2Q
        vLkpRx4QRelCCw79qkMgjBTgX4JSpd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-4aFD9ZsAOPGKmiPjRX_EPQ-1; Mon, 19 Jul 2021 09:00:50 -0400
X-MC-Unique: 4aFD9ZsAOPGKmiPjRX_EPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B981719057A0;
        Mon, 19 Jul 2021 13:00:48 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C92860CA0;
        Mon, 19 Jul 2021 13:00:45 +0000 (UTC)
Subject: Re: [PATCH v2 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210719054138.198373-1-gshan@redhat.com>
 <20210719054138.198373-2-gshan@redhat.com>
Message-ID: <8d754894-5c21-1287-82b6-7ac3b064af3d@redhat.com>
Date:   Mon, 19 Jul 2021 23:01:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210719054138.198373-2-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 3:41 PM, Gavin Shan wrote:
> In debug_vm_pgtable(), there are many local variables introduced to
> track the needed information and they are passed to the functions for
> various test cases. It'd better to introduce a struct as place holder
> for these information. With it, what the functions for various test
> cases need is the struct, to simplify the code. It also makes code
> easier to be maintained.
> 
> Besides, set_xxx_at() could access the data on the corresponding pages
> in the page table modifying tests. So the accessed pages in the tests
> should have been allocated from buddy. Otherwise, we're accessing pages
> that aren't owned by us. This causes issues like page flag corruption.
> 
> This introduces "struct pgtable_debug_args". The struct is initialized
> and destroyed, but the information in the struct isn't used yet. They
> will be used in subsequent patches.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   mm/debug_vm_pgtable.c | 196 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 195 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 1c922691aa61..0cc44e7c166e 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -58,6 +58,36 @@
>   #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>   #define RANDOM_NZVALUE	GENMASK(7, 0)
>   
> +struct pgtable_debug_args {
> +	struct mm_struct	*mm;
> +	struct vm_area_struct	*vma;
> +
> +	pgd_t			*pgdp;
> +	p4d_t			*p4dp;
> +	pud_t			*pudp;
> +	pmd_t			*pmdp;
> +	pte_t			*ptep;
> +
> +	p4d_t			*start_p4dp;
> +	pud_t			*start_pudp;
> +	pmd_t			*start_pmdp;
> +	pgtable_t		start_ptep;
> +
> +	unsigned long		vaddr;
> +	pgprot_t		page_prot;
> +	pgprot_t		page_prot_none;
> +
> +	unsigned long		pud_pfn;
> +	unsigned long		pmd_pfn;
> +	unsigned long		pte_pfn;
> +
> +	unsigned long		fixed_pgd_pfn;
> +	unsigned long		fixed_p4d_pfn;
> +	unsigned long		fixed_pud_pfn;
> +	unsigned long		fixed_pmd_pfn;
> +	unsigned long		fixed_pte_pfn;
> +};
> +
>   static void __init pte_basic_tests(unsigned long pfn, int idx)
>   {
>   	pgprot_t prot = protection_map[idx];
> @@ -955,8 +985,166 @@ static unsigned long __init get_random_vaddr(void)
>   	return random_vaddr;
>   }
>   
> +static void __init destroy_args(struct pgtable_debug_args *args)
> +{
> +	struct page *page = NULL;
> +
> +	/* Free (huge) page */
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
> +	    has_transparent_hugepage() &&
> +	    args->pud_pfn != ULONG_MAX) {
> +		page = pfn_to_page(args->pud_pfn);
> +		__free_pages(page, HPAGE_PUD_SHIFT - PAGE_SHIFT);
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +		   has_transparent_hugepage() &&
> +		   args->pmd_pfn != ULONG_MAX) {
> +		page = pfn_to_page(args->pmd_pfn);
> +		__free_pages(page, HPAGE_PMD_ORDER);
> +	} else if (args->pte_pfn != ULONG_MAX) {
> +		page = pfn_to_page(args->pte_pfn);
> +		__free_pages(page, 0);
> +	}
> +
> +	/* Free page table */
> +	if (args->start_ptep) {
> +		pte_free(args->mm, args->start_ptep);
> +		mm_dec_nr_ptes(args->mm);
> +	}
> +
> +	if (args->start_pmdp) {
> +		pmd_free(args->mm, args->start_pmdp);
> +		mm_dec_nr_pmds(args->mm);
> +	}
> +
> +	if (args->start_pudp) {
> +		pud_free(args->mm, args->start_pudp);
> +		mm_dec_nr_puds(args->mm);
> +	}
> +
> +	if (args->start_p4dp)
> +		p4d_free(args->mm, args->p4dp);
> +
> +	/* Free vma and mm struct */
> +	if (args->vma)
> +		vm_area_free(args->vma);
> +	if (args->mm)
> +		mmdrop(args->mm);
> +}
> +
> +static int __init init_args(struct pgtable_debug_args *args)
> +{
> +	struct page *page = NULL;
> +	phys_addr_t phys;
> +	int ret = 0;
> +
> +	/* Initialize the debugging data */
> +	memset(args, 0, sizeof(*args));
> +	args->page_prot      = vm_get_page_prot(VMFLAGS);
> +	args->page_prot_none = __P000;
> +	args->pud_pfn        = ULONG_MAX;
> +	args->pmd_pfn        = ULONG_MAX;
> +	args->pte_pfn        = ULONG_MAX;
> +	args->fixed_pgd_pfn  = ULONG_MAX;
> +	args->fixed_p4d_pfn  = ULONG_MAX;
> +	args->fixed_pud_pfn  = ULONG_MAX;
> +	args->fixed_pmd_pfn  = ULONG_MAX;
> +	args->fixed_pte_pfn  = ULONG_MAX;
> +
> +	/* Allocate mm and vma */
> +	args->mm = mm_alloc();
> +	if (!args->mm) {
> +		pr_err("Failed to allocate mm struct\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	args->vma = vm_area_alloc(args->mm);
> +	if (!args->vma) {
> +		pr_err("Failed to allocate vma\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Figure out the virtual address and allocate page table entries */
> +	args->vaddr = get_random_vaddr();
> +	args->pgdp = pgd_offset(args->mm, args->vaddr);
> +	args->p4dp = p4d_alloc(args->mm, args->pgdp, args->vaddr);
> +	args->pudp = args->p4dp ?
> +		     pud_alloc(args->mm, args->p4dp, args->vaddr) : NULL;
> +	args->pmdp = args->pudp ?
> +		     pmd_alloc(args->mm, args->pudp, args->vaddr) : NULL;
> +	args->ptep = args->pmdp ?
> +		     pte_alloc_map(args->mm, args->pmdp, args->vaddr) : NULL;
> +	if (!args->ptep) {
> +		pr_err("Failed to allocate page table\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/*
> +	 * The above page table entries will be modified. Lets save the
> +	 * page table entries so that they can be released when the tests
> +	 * are completed.
> +	 */
> +	args->start_p4dp = p4d_offset(args->pgdp, 0UL);
> +	args->start_pudp = pud_offset(args->p4dp, 0UL);
> +	args->start_pmdp = pmd_offset(args->pudp, 0UL);
> +	args->start_ptep = pmd_pgtable(READ_ONCE(*(args->pmdp)));
> +
> +	/*
> +	 * Figure out the fixed addresses, which are all around the kernel
> +	 * symbol (@start_kernel). The corresponding PFNs might be invalid,
> +	 * but it's fine as the following tests won't access the pages.
> +	 */
> +	phys = __pa_symbol(&start_kernel);
> +	args->fixed_pgd_pfn = __phys_to_pfn(phys & PGDIR_MASK);
> +	args->fixed_p4d_pfn = __phys_to_pfn(phys & P4D_MASK);
> +	args->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
> +	args->fixed_pmd_pfn = __phys_to_pfn(phys & PMD_MASK);
> +	args->fixed_pte_pfn = __phys_to_pfn(phys & PAGE_MASK);
> +
> +	/*
> +	 * Allocate (huge) pages because some of the tests need to access
> +	 * the data in the pages. The corresponding tests will be skipped
> +	 * if we fail to allocate (huge) pages.
> +	 */
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
> +	    has_transparent_hugepage()) {
> +		page = alloc_pages(GFP_KERNEL, HPAGE_PUD_SHIFT - PAGE_SHIFT);
> +		if (page) {
> +			args->pud_pfn = page_to_pfn(page);
> +			args->pmd_pfn = args->pud_pfn;
> +			args->pte_pfn = args->pud_pfn;
> +			return 0;
> +		}
> +	}
> +
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +	    has_transparent_hugepage()) {
> +		page = alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
> +		if (page) {
> +			args->pmd_pfn = page_to_pfn(page);
> +			args->pte_pfn = args->pmd_pfn;
> +			return 0;
> +		}
> +	}
> +

As syzbot reported against v1 series, we could allocate pages larger than (1 << (MAX_ORDER - 1)) here.
So __GFP_NOWARN is needed here. I will fix it in v3 series.

> +	page = alloc_pages(GFP_KERNEL, 0);
> +	if (page)
> +		args->pte_pfn = page_to_pfn(page);
> +
> +	return 0;
> +
> +error:
> +	destroy_args(args);
> +	return ret;
> +}
> +
>   static int __init debug_vm_pgtable(void)
>   {
> +	struct pgtable_debug_args args;
>   	struct vm_area_struct *vma;
>   	struct mm_struct *mm;
>   	pgd_t *pgdp;
> @@ -970,9 +1158,13 @@ static int __init debug_vm_pgtable(void)
>   	unsigned long vaddr, pte_aligned, pmd_aligned;
>   	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>   	spinlock_t *ptl = NULL;
> -	int idx;
> +	int idx, ret;
>   
>   	pr_info("Validating architecture page table helpers\n");
> +	ret = init_args(&args);
> +	if (ret)
> +		return ret;
> +
>   	prot = vm_get_page_prot(VMFLAGS);
>   	vaddr = get_random_vaddr();
>   	mm = mm_alloc();
> @@ -1127,6 +1319,8 @@ static int __init debug_vm_pgtable(void)
>   	mm_dec_nr_pmds(mm);
>   	mm_dec_nr_ptes(mm);
>   	mmdrop(mm);
> +
> +	destroy_args(&args);
>   	return 0;
>   }
>   late_initcall(debug_vm_pgtable);
> 

Thanks,
Gavin

