Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8495B3C7E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 08:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhGNG0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 02:26:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237958AbhGNG03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 02:26:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 601BC6D;
        Tue, 13 Jul 2021 23:23:38 -0700 (PDT)
Received: from [10.163.65.222] (unknown [10.163.65.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E44C43F774;
        Tue, 13 Jul 2021 23:23:34 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 01/12] mm/debug_vm_pgtable: Introduce struct
 vm_pgtable_debug
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
 <20210706061748.161258-2-gshan@redhat.com>
Message-ID: <a74549ac-6794-25a0-7238-2591745e6810@arm.com>
Date:   Wed, 14 Jul 2021 11:54:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210706061748.161258-2-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/21 11:47 AM, Gavin Shan wrote:
> In debug_vm_pgtable(), there are many local variables introduced
> to track the needed information and they are passed to the functions
> for various test cases. It'd better to introduce a struct as place
> holder for these information. With it, what the functions for various
> test cases need is the struct, to simplify the code. It makes the code
> easier to be maintained.
> 
> Besides, set_pte_at() could access the data on the corresponding pages.

s/set_pte_at()/set_pxx_at() to accommodate similar helpers in other page
table modifying tests as well.

> So the test cases using set_pte_at() should have the pages allocated
> from buddy. Otherwise, we're acceessing pages that aren't owned by us.

typo here. s/acceessing/accessing/

> This causes issues like page flag corruption. So we need the allocated
> pages for these tests where set_pte_at() is used. The struct is introduced
> so that the old and new implementation can coexist so that the patches
> can be organized in a easy way.

s/a easy/an easy/

The rationale for the structure should be explained better. I am wondering
whether it would be preferable to solve the dynamic page allocation problem
first in respective test functions, before introducing this structure which
will convert all test functions.

> 
> This introduces "struct vm_pgtable_debug" for above purposes. The struct
> is initialized and destroyed, but the information in the struct isn't
> used yet. They will be used in subsequent patches.

There are two set of resources before all functions use the new structure.
Makes sense.

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 210 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 209 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 1c922691aa61..225e2ea4d72f 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -58,6 +58,36 @@
>  #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>  #define RANDOM_NZVALUE	GENMASK(7, 0)
>  
> +struct vm_pgtable_debug {

Name should contain 'args'. Probably something like pgtable_debug_args ?

> +	struct mm_struct	*mm;
> +	struct vm_area_struct	*vma;

Linked objects..

> +
> +	pgd_t			*pgdp;
> +	p4d_t			*p4dp;
> +	pud_t			*pudp;
> +	pmd_t			*pmdp;
> +	pte_t			*ptep;

pgtable pointers..

> +
> +	p4d_t			*start_p4dp;
> +	pud_t			*start_pudp;
> +	pmd_t			*start_pmdp;
> +	pgtable_t		start_ptep;

Saved pgtable pointers..

> +
> +	unsigned long		vaddr;
> +	pgprot_t		page_prot;
> +	pgprot_t		page_prot_none;

Other miscellaneous objects..

> +
> +	unsigned long		pud_pfn;
> +	unsigned long		pmd_pfn;
> +	unsigned long		pte_pfn;

Dynamically allocated objects..

> +
> +	unsigned long		fixed_pgd_pfn;
> +	unsigned long		fixed_p4d_pfn;
> +	unsigned long		fixed_pud_pfn;
> +	unsigned long		fixed_pmd_pfn;
> +	unsigned long		fixed_pte_pfn;
> +};

Derived from symbol 'start_kernel' objects..

> +
>  static void __init pte_basic_tests(unsigned long pfn, int idx)
>  {
>  	pgprot_t prot = protection_map[idx];
> @@ -955,8 +985,180 @@ static unsigned long __init get_random_vaddr(void)
>  	return random_vaddr;
>  }
>  
> +static void __init free_mem(struct vm_pgtable_debug *debug)
> +{
> +	struct page *page = NULL;
> +	int order = 0;
> +
> +	/* Free (huge) page */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD

Replace #ifdef with IS_ENABLED(). There is no symbol visibility problem
without those #ifdef here.

> +	if (has_transparent_hugepage() &&
> +	    debug->pud_pfn != ULONG_MAX) {
> +		page = pfn_to_page(debug->pud_pfn);
> +		order = HPAGE_PUD_SHIFT - PAGE_SHIFT;
> +	}
> +#endif
> +
> +	if (has_transparent_hugepage() &&
> +	    debug->pmd_pfn != ULONG_MAX && !page) {
> +		page = pfn_to_page(debug->pmd_pfn);
> +		order = HPAGE_PMD_ORDER;
> +	}
> +#endif
> +
> +	if (debug->pte_pfn != ULONG_MAX && !page) {
> +		page = pfn_to_page(debug->pte_pfn);
> +		order = 0;
> +	}

This could be further simplified.

	if (debug->pud_pfn) {
		__free_pages(page, PUD_ORDER)
		done
	}

	if (debug->pmd_pfn) {
		__free_pages(page, PMD_ORDER)
		done
	}

	if (debug->pte_pfn)
		__free_pages(page, 0)

If the debug->pxx_pfn is positive and (!= ULONG_MAX), it can be assumed
that pxx level memory was allocated successfully and is being freed up
here. Just need to start from the highest order though.

> +
> +	if (page)
> +		__free_pages(page, order);

From here...

> +
> +	/* Free page table */
> +	if (debug->start_ptep) {
> +		pte_free(debug->mm, debug->start_ptep);
> +		mm_dec_nr_ptes(debug->mm);
> +	}
> +
> +	if (debug->start_pmdp) {
> +		pmd_free(debug->mm, debug->start_pmdp);
> +		mm_dec_nr_pmds(debug->mm);
> +	}
> +
> +	if (debug->start_pudp) {
> +		pud_free(debug->mm, debug->start_pudp);
> +		mm_dec_nr_puds(debug->mm);
> +	}
> +
> +	if (debug->start_p4dp)
> +		p4d_free(debug->mm, debug->p4dp);
> +
> +	/* Free vma and mm struct */
> +	if (debug->vma)
> +		vm_area_free(debug->vma);
> +	if (debug->mm)
> +		mmdrop(debug->mm);
> +}

Till here...

I am wondering whether it is really necessary to cross check all these
elements here for being non-NULL, before freeing or rather destroying.
Except for the allocated huge memory containing pfns and pages, all
other elements should be asserted before proceeding with the test.
Hence no additional checks should be required while freeing.

> +
> +static int __init alloc_mem(struct vm_pgtable_debug *debug)
> +{
> +	struct page *page = NULL;
> +	phys_addr_t phys;
> +	int ret = 0;
> +
> +	/* Initialize the debugging data */
> +	debug->mm             = NULL;
> +	debug->vma            = NULL;
> +	debug->pgdp           = NULL;
> +	debug->p4dp           = NULL;
> +	debug->pudp           = NULL;
> +	debug->pmdp           = NULL;
> +	debug->ptep           = NULL;
> +	debug->start_p4dp     = NULL;
> +	debug->start_pudp     = NULL;
> +	debug->start_pmdp     = NULL;
> +	debug->start_ptep     = NULL;
> +	debug->vaddr          = 0UL;
> +	debug->page_prot      = vm_get_page_prot(VM_READ | VM_WRITE | VM_EXEC);

Should use VMFLAGS instead.

> +	debug->page_prot_none = __P000;
> +	debug->pud_pfn        = ULONG_MAX;
> +	debug->pmd_pfn        = ULONG_MAX;
> +	debug->pte_pfn        = ULONG_MAX;
> +	debug->fixed_pgd_pfn  = ULONG_MAX;
> +	debug->fixed_p4d_pfn  = ULONG_MAX;
> +	debug->fixed_pud_pfn  = ULONG_MAX;
> +	debug->fixed_pmd_pfn  = ULONG_MAX;
> +	debug->fixed_pte_pfn  = ULONG_MAX;

It should instead define yet another helper, which would reset all
structure elements to NULL or some unusable values before they get
initialized here. Possibly [reset/clr]_debug_pgtable_args() ?

> +
> +	/* Allocate mm and vma */
> +	debug->mm = mm_alloc();
> +	if (!debug->mm) {
> +		pr_warn("Failed to allocate mm struct\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	debug->vma = vm_area_alloc(debug->mm);
> +	if (!debug->vma) {
> +		pr_warn("Failed to allocate vma\n");

s/pr_warn/pr_err. Please dont change any warning levels here.

> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Figure out the virtual address and allocate page table entries */
> +	debug->vaddr = get_random_vaddr();
> +	debug->pgdp = pgd_offset(debug->mm, debug->vaddr);
> +	debug->p4dp = p4d_alloc(debug->mm, debug->pgdp, debug->vaddr);
> +	debug->pudp = debug->p4dp ?
> +		      pud_alloc(debug->mm, debug->p4dp, debug->vaddr) : NULL;
> +	debug->pmdp = debug->pudp ?
> +		      pmd_alloc(debug->mm, debug->pudp, debug->vaddr) : NULL;
> +	debug->ptep = debug->pmdp ?
> +		      pte_alloc_map(debug->mm, debug->pmdp, debug->vaddr) : NULL;

(PXXX ?) construct is really required here. Should not pxx_alloc()
return NULL if the previous level pointer is NULL ? Regardless it
might be better to just assert that these intermediary levels are
allocated before proceeding further. It does not make sense to go
ahead with the test if any of the allocations failed ! Similar to
mm and vma.


> +	if (!debug->ptep) {
> +		pr_warn("Failed to allocate page table\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/*
> +	 * The above page table entries will be modified. Lets save the
> +	 * page table entries so that they can be released when the tests
> +	 * are completed.
> +	 */
> +	debug->start_p4dp = p4d_offset(debug->pgdp, 0UL);
> +	debug->start_pudp = pud_offset(debug->p4dp, 0UL);
> +	debug->start_pmdp = pmd_offset(debug->pudp, 0UL);
> +	debug->start_ptep = pmd_pgtable(*(debug->pmdp));

Please keep the existing construct via tmp pointer obtained from
READ_ONCE() on (debug->pmdp) before getting used in pmd_pgtable().

> +
> +	/*
> +	 * Figure out the fixed addresses, which are all around the kernel
> +	 * symbol (@start_kernel). The corresponding PFNs might be invalid,
> +	 * but it's fine as the following tests won't access the pages.
> +	 */
> +	phys = __pa_symbol(&start_kernel);
> +	debug->fixed_pgd_pfn = __phys_to_pfn(phys & PGDIR_MASK);
> +	debug->fixed_p4d_pfn = __phys_to_pfn(phys & P4D_MASK);
> +	debug->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
> +	debug->fixed_pmd_pfn = __phys_to_pfn(phys & PMD_MASK);
> +	debug->fixed_pte_pfn = __phys_to_pfn(phys & PAGE_MASK);
> +
> +	/*
> +	 * Allocate (huge) pages because some of the tests need to access
> +	 * the data in the pages. The corresponding tests will be skipped
> +	 * if we fail to allocate (huge) pages.
> +	 */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD

There is no symbol visibility problem without this #ifdef. Hence
please use IS_ENABLED() constructs here instead.

> +	if (has_transparent_hugepage()) {
> +		page = alloc_pages(GFP_KERNEL, HPAGE_PUD_SHIFT - PAGE_SHIFT);
> +		if (page)
> +			debug->pud_pfn = page_to_pfn(page);
			debug->pmd_pfn = debug->pud_pfn;
			debug->pte_pfn = debug->pud_pfn;
			done; skip;
> +	}
> +#endif
> +
> +	if (has_transparent_hugepage()) {
> +		page = page ? page : alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
> +		if (page)
> +			debug->pmd_pfn = page_to_pfn(page);
			debug->pte_pfn = debug->pmd_pfn;
			done; skip;
> +	}
> +#endif
> +
> +	page = page ? page : alloc_pages(GFP_KERNEL, 0);
> +	if (page)
> +		debug->pte_pfn = page_to_pfn(page);

With the above mentioned changes (page ?) constructs should not be
required anymore.

> +
> +	return 0;
> +
> +error:
> +	free_mem(debug);
> +	return ret;
> +}
> +
>  static int __init debug_vm_pgtable(void)
>  {
> +	struct vm_pgtable_debug debug;

This should be renamed.

s/debug/pgtable_args ?

>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>  	pgd_t *pgdp;
> @@ -970,9 +1172,13 @@ static int __init debug_vm_pgtable(void)
>  	unsigned long vaddr, pte_aligned, pmd_aligned;
>  	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>  	spinlock_t *ptl = NULL;
> -	int idx;
> +	int idx, ret;
>  
>  	pr_info("Validating architecture page table helpers\n");
> +	ret = alloc_mem(&debug);
> +	if (ret)
> +		return ret;
> +
>  	prot = vm_get_page_prot(VMFLAGS);
>  	vaddr = get_random_vaddr();
>  	mm = mm_alloc();
> @@ -1127,6 +1333,8 @@ static int __init debug_vm_pgtable(void)
>  	mm_dec_nr_pmds(mm);
>  	mm_dec_nr_ptes(mm);
>  	mmdrop(mm);
> +
> +	free_mem(&debug);
>  	return 0;
>  }
>  late_initcall(debug_vm_pgtable);
>
