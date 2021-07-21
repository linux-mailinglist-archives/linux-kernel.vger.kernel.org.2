Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A263D0874
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 07:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhGUFEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 01:04:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233187AbhGUFDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:03:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C39301FB;
        Tue, 20 Jul 2021 22:43:31 -0700 (PDT)
Received: from [10.163.64.235] (unknown [10.163.64.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 733793F66F;
        Tue, 20 Jul 2021 22:43:29 -0700 (PDT)
Subject: Re: [PATCH v3 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-2-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ab0f9daa-0c49-e74c-e073-6e03a3cabb07@arm.com>
Date:   Wed, 21 Jul 2021 11:14:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210719130613.334901-2-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 6:36 PM, Gavin Shan wrote:
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
>  mm/debug_vm_pgtable.c | 197 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 196 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 1c922691aa61..ea153ff40d23 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -58,6 +58,36 @@
>  #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>  #define RANDOM_NZVALUE	GENMASK(7, 0)
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
>  static void __init pte_basic_tests(unsigned long pfn, int idx)
>  {
>  	pgprot_t prot = protection_map[idx];
> @@ -955,8 +985,167 @@ static unsigned long __init get_random_vaddr(void)
>  	return random_vaddr;
>  }
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

Please preserve the existing comments before this assignment.

        /*
         * __P000 (or even __S000) will help create page table entries with
         * PROT_NONE permission as required for pxx_protnone_tests().
         */

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

Please group args->vaddr's init with page_prot and page_prot_none above.

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

Why not just assert that all page table level pointers are allocated
successfully, otherwise bail out the test completely. Something like
this at each level.

	if (!args->p4dp) {
		pr_err("Failed to allocate page table\n");
		ret = -ENOMEM;
		goto error;
	}

Is there any value in proceeding with the test when some page table
pointers have not been allocated. Also individual tests do not cross
check these pointers. Also asserting successful allocations will
make the freeing path simpler, as I had mentioned earlier.

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

If the above page table pointers have been validated to be allocated
successfully, we could add these here.

	WARN_ON(!args->start_p4dp)
	WARN_ON(!args->start_pudp)
	WARN_ON(!args->start_pmdp)
	WARN_ON(!args->start_ptep)

Afterwards all those if (args->start_pxdp) checks in the freeing path
will not be required anymore.

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
> +		page = alloc_pages(GFP_KERNEL | __GFP_NOWARN,
> +				   HPAGE_PUD_SHIFT - PAGE_SHIFT);

Please drop __GFP_NOWARN and instead use something like alloc_contig_pages()
when required allocation order exceed (MAX_ORDER - 1). Else the test might
not be able to execute on platform configurations, where PUD THP is enabled.

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
> +		page = alloc_pages(GFP_KERNEL | __GFP_NOWARN, HPAGE_PMD_ORDER);
> +		if (page) {
> +			args->pmd_pfn = page_to_pfn(page);
> +			args->pte_pfn = args->pmd_pfn;
> +			return 0;
> +		}
> +	}
> +
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
>  static int __init debug_vm_pgtable(void)
>  {
> +	struct pgtable_debug_args args;>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>  	pgd_t *pgdp;
> @@ -970,9 +1159,13 @@ static int __init debug_vm_pgtable(void)
>  	unsigned long vaddr, pte_aligned, pmd_aligned;
>  	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>  	spinlock_t *ptl = NULL;
> -	int idx;
> +	int idx, ret;
>  
>  	pr_info("Validating architecture page table helpers\n");
> +	ret = init_args(&args);
> +	if (ret)
> +		return ret;
> +
>  	prot = vm_get_page_prot(VMFLAGS);
>  	vaddr = get_random_vaddr();
>  	mm = mm_alloc();
> @@ -1127,6 +1320,8 @@ static int __init debug_vm_pgtable(void)
>  	mm_dec_nr_pmds(mm);
>  	mm_dec_nr_ptes(mm);
>  	mmdrop(mm);
> +
> +	destroy_args(&args);
>  	return 0;
>  }
>  late_initcall(debug_vm_pgtable);
> 
