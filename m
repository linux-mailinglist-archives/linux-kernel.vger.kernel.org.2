Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB73D0CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhGUJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238987AbhGUJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626862843;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAioKgdEr3SjdlOxYxDAZsgyJphe+93rq52vN3Mi+pQ=;
        b=HBjS13795TmVq3L1ZFRSUdUMJzY/YhE374Yz3Sm3AMMKjsZxPZuK+NtJqAkFetxS0tlIqL
        Mj5bu9UyesL2Kfu3TsL1BvJ//GYgZGoTPCX33rtprU0Ot4Udt+E3fqR7K+NLLOykOEM6Ug
        UNLhibL6MIR0SYbs7Jk7RNO9Q/hI7eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-uvl46cbqPuS9ZYpMK3SqPg-1; Wed, 21 Jul 2021 06:20:41 -0400
X-MC-Unique: uvl46cbqPuS9ZYpMK3SqPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 844D7107ACF5;
        Wed, 21 Jul 2021 10:20:39 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A826A60FB8;
        Wed, 21 Jul 2021 10:20:36 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-2-gshan@redhat.com>
 <ab0f9daa-0c49-e74c-e073-6e03a3cabb07@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <280a5740-b5dc-4b78-3a38-67e5adbb0afd@redhat.com>
Date:   Wed, 21 Jul 2021 20:20:53 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ab0f9daa-0c49-e74c-e073-6e03a3cabb07@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/21/21 3:44 PM, Anshuman Khandual wrote:
> On 7/19/21 6:36 PM, Gavin Shan wrote:
>> In debug_vm_pgtable(), there are many local variables introduced to
>> track the needed information and they are passed to the functions for
>> various test cases. It'd better to introduce a struct as place holder
>> for these information. With it, what the functions for various test
>> cases need is the struct, to simplify the code. It also makes code
>> easier to be maintained.
>>
>> Besides, set_xxx_at() could access the data on the corresponding pages
>> in the page table modifying tests. So the accessed pages in the tests
>> should have been allocated from buddy. Otherwise, we're accessing pages
>> that aren't owned by us. This causes issues like page flag corruption.
>>
>> This introduces "struct pgtable_debug_args". The struct is initialized
>> and destroyed, but the information in the struct isn't used yet. They
>> will be used in subsequent patches.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/debug_vm_pgtable.c | 197 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 196 insertions(+), 1 deletion(-)
>>

I saw you've finished the review on PATCH[v3 01/12] and PATCH[v3 02/12].
I will wait to integrate your comments to v4 until you finish the review
on all patches in v3 series.

>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 1c922691aa61..ea153ff40d23 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -58,6 +58,36 @@
>>   #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>>   #define RANDOM_NZVALUE	GENMASK(7, 0)
>>   
>> +struct pgtable_debug_args {
>> +	struct mm_struct	*mm;
>> +	struct vm_area_struct	*vma;
>> +
>> +	pgd_t			*pgdp;
>> +	p4d_t			*p4dp;
>> +	pud_t			*pudp;
>> +	pmd_t			*pmdp;
>> +	pte_t			*ptep;
>> +
>> +	p4d_t			*start_p4dp;
>> +	pud_t			*start_pudp;
>> +	pmd_t			*start_pmdp;
>> +	pgtable_t		start_ptep;
>> +
>> +	unsigned long		vaddr;
>> +	pgprot_t		page_prot;
>> +	pgprot_t		page_prot_none;
>> +
>> +	unsigned long		pud_pfn;
>> +	unsigned long		pmd_pfn;
>> +	unsigned long		pte_pfn;
>> +
>> +	unsigned long		fixed_pgd_pfn;
>> +	unsigned long		fixed_p4d_pfn;
>> +	unsigned long		fixed_pud_pfn;
>> +	unsigned long		fixed_pmd_pfn;
>> +	unsigned long		fixed_pte_pfn;
>> +};
>> +
>>   static void __init pte_basic_tests(unsigned long pfn, int idx)
>>   {
>>   	pgprot_t prot = protection_map[idx];
>> @@ -955,8 +985,167 @@ static unsigned long __init get_random_vaddr(void)
>>   	return random_vaddr;
>>   }
>>   
>> +static void __init destroy_args(struct pgtable_debug_args *args)
>> +{
>> +	struct page *page = NULL;
>> +
>> +	/* Free (huge) page */
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>> +	    has_transparent_hugepage() &&
>> +	    args->pud_pfn != ULONG_MAX) {
>> +		page = pfn_to_page(args->pud_pfn);
>> +		__free_pages(page, HPAGE_PUD_SHIFT - PAGE_SHIFT);
>> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +		   has_transparent_hugepage() &&
>> +		   args->pmd_pfn != ULONG_MAX) {
>> +		page = pfn_to_page(args->pmd_pfn);
>> +		__free_pages(page, HPAGE_PMD_ORDER);
>> +	} else if (args->pte_pfn != ULONG_MAX) {
>> +		page = pfn_to_page(args->pte_pfn);
>> +		__free_pages(page, 0);
>> +	}
>> +
>> +	/* Free page table */
>> +	if (args->start_ptep) {
>> +		pte_free(args->mm, args->start_ptep);
>> +		mm_dec_nr_ptes(args->mm);
>> +	}
>> +
>> +	if (args->start_pmdp) {
>> +		pmd_free(args->mm, args->start_pmdp);
>> +		mm_dec_nr_pmds(args->mm);
>> +	}
>> +
>> +	if (args->start_pudp) {
>> +		pud_free(args->mm, args->start_pudp);
>> +		mm_dec_nr_puds(args->mm);
>> +	}
>> +
>> +	if (args->start_p4dp)
>> +		p4d_free(args->mm, args->p4dp);
>> +
>> +	/* Free vma and mm struct */
>> +	if (args->vma)
>> +		vm_area_free(args->vma);
>> +	if (args->mm)
>> +		mmdrop(args->mm);
>> +}
>> +
>> +static int __init init_args(struct pgtable_debug_args *args)
>> +{
>> +	struct page *page = NULL;
>> +	phys_addr_t phys;
>> +	int ret = 0;
>> +
>> +	/* Initialize the debugging data */
>> +	memset(args, 0, sizeof(*args));
>> +	args->page_prot      = vm_get_page_prot(VMFLAGS);
>> +	args->page_prot_none = __P000;
> 
> Please preserve the existing comments before this assignment.
> 
>          /*
>           * __P000 (or even __S000) will help create page table entries with
>           * PROT_NONE permission as required for pxx_protnone_tests().
>           */
> 

Sure. I will combine the comments in v4 as below:

	/*
	 * Initialize the debugging arguments.
	 *
	 * __P000 (or even __S000) will help create page table entries with
          * PROT_NONE permission as required for pxx_protnone_tests().
          */


>> +	args->pud_pfn        = ULONG_MAX;
>> +	args->pmd_pfn        = ULONG_MAX;
>> +	args->pte_pfn        = ULONG_MAX;
>> +	args->fixed_pgd_pfn  = ULONG_MAX;
>> +	args->fixed_p4d_pfn  = ULONG_MAX;
>> +	args->fixed_pud_pfn  = ULONG_MAX;
>> +	args->fixed_pmd_pfn  = ULONG_MAX;
>> +	args->fixed_pte_pfn  = ULONG_MAX;
>> +
>> +	/* Allocate mm and vma */
>> +	args->mm = mm_alloc();
>> +	if (!args->mm) {
>> +		pr_err("Failed to allocate mm struct\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	args->vma = vm_area_alloc(args->mm);
>> +	if (!args->vma) {
>> +		pr_err("Failed to allocate vma\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	/* Figure out the virtual address and allocate page table entries */
>> +	args->vaddr = get_random_vaddr();
> 
> Please group args->vaddr's init with page_prot and page_prot_none above.
> 

Yes, It will make the code tidy. I'll move this line accordingly in v4,
but the related comments will be dropped as the code is self-explanatory.

         /* Allocate page table entries */

>> +	args->pgdp = pgd_offset(args->mm, args->vaddr);
>> +	args->p4dp = p4d_alloc(args->mm, args->pgdp, args->vaddr);
>> +	args->pudp = args->p4dp ?
>> +		     pud_alloc(args->mm, args->p4dp, args->vaddr) : NULL;
>> +	args->pmdp = args->pudp ?
>> +		     pmd_alloc(args->mm, args->pudp, args->vaddr) : NULL;
>> +	args->ptep = args->pmdp ?
>> +		     pte_alloc_map(args->mm, args->pmdp, args->vaddr) : NULL;
>> +	if (!args->ptep) {
>> +		pr_err("Failed to allocate page table\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
> 
> Why not just assert that all page table level pointers are allocated
> successfully, otherwise bail out the test completely. Something like
> this at each level.
> 
> 	if (!args->p4dp) {
> 		pr_err("Failed to allocate page table\n");
> 		ret = -ENOMEM;
> 		goto error;
> 	}
> 
> Is there any value in proceeding with the test when some page table
> pointers have not been allocated. Also individual tests do not cross
> check these pointers. Also asserting successful allocations will
> make the freeing path simpler, as I had mentioned earlier.
> 

There is no tests will be carried out if we fail to allocate any level
of page table entries. For other questions, please refer below response.
In summary, this snippet needs to be combined with next snippet, as below.

>> +
>> +	/*
>> +	 * The above page table entries will be modified. Lets save the
>> +	 * page table entries so that they can be released when the tests
>> +	 * are completed.
>> +	 */
>> +	args->start_p4dp = p4d_offset(args->pgdp, 0UL);
>> +	args->start_pudp = pud_offset(args->p4dp, 0UL);
>> +	args->start_pmdp = pmd_offset(args->pudp, 0UL);
>> +	args->start_ptep = pmd_pgtable(READ_ONCE(*(args->pmdp)));
> 
> If the above page table pointers have been validated to be allocated
> successfully, we could add these here.
> 
> 	WARN_ON(!args->start_p4dp)
> 	WARN_ON(!args->start_pudp)
> 	WARN_ON(!args->start_pmdp)
> 	WARN_ON(!args->start_ptep)
> 
> Afterwards all those if (args->start_pxdp) checks in the freeing path
> will not be required anymore.
> 

The check on @args->start_pxdp is still needed in destroy_args() for
couple of cases: (1) destroy_args() is called on failing to allocate
@args->mm or @args->vma. That time, no page table entries are allocated.
(2) It's possible to fail allocating current level of page table entries
even the previous levels of page table entries are allocated successfully.

So Lets change these (above) two snippets as below in v4:

	/*
	 * Allocate page table entries. The allocated page table entries
	 * will be modified in the tests. Lets save the page table entries
	 * so that they can be released when the tests are completed.
	 */
	args->pgdp = pgd_offset(args->mm, args->vaddr);
	args->p4dp = p4d_alloc(args->mm, args->pgdp, args->vaddr);
	if (!args->p4dp) {
	    pr_err("Failed to allocate p4d entries\n");
	    ret = -ENOMEM;
	    goto error;
	}

	args->start_p4dp = p4d_offset(args->pgdp, 0UL);
	args->pudp = pud_alloc(args->mm, args->p4dp, args->vaddr);
	if (!args->pudp) {
	    pr_err("Failed to allocate pud entries\n");
	    ret = -ENOMEM;
	    goto error;
	}

	args->pmdp = pmd_alloc(args->mm, args->pudp, args->vaddr);
	if (!args->pmdp) {
	    pr_err("Failed to allocate PMD entries\n");
	    ret = -ENOMEM;
	    goto error;
	}

	args->start_pmdp = pmd_offset(args->pudp, 0UL);
	args->ptep = pte_alloc_map(args->mm, args->pmdp, args->vaddr);
	if (!args->ptep) {
	    pr_err("Failed to allocate page table\n");
	    ret = -ENOMEM;
	    goto error;
	}

	args->start_ptep = pmd_pgtable(READ_ONCE(*(args->pmdp)));

>> +
>> +	/*
>> +	 * Figure out the fixed addresses, which are all around the kernel
>> +	 * symbol (@start_kernel). The corresponding PFNs might be invalid,
>> +	 * but it's fine as the following tests won't access the pages.
>> +	 */
>> +	phys = __pa_symbol(&start_kernel);
>> +	args->fixed_pgd_pfn = __phys_to_pfn(phys & PGDIR_MASK);
>> +	args->fixed_p4d_pfn = __phys_to_pfn(phys & P4D_MASK);
>> +	args->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
>> +	args->fixed_pmd_pfn = __phys_to_pfn(phys & PMD_MASK);
>> +	args->fixed_pte_pfn = __phys_to_pfn(phys & PAGE_MASK);
>> +
>> +	/*
>> +	 * Allocate (huge) pages because some of the tests need to access
>> +	 * the data in the pages. The corresponding tests will be skipped
>> +	 * if we fail to allocate (huge) pages.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>> +	    has_transparent_hugepage()) {
>> +		page = alloc_pages(GFP_KERNEL | __GFP_NOWARN,
>> +				   HPAGE_PUD_SHIFT - PAGE_SHIFT);
> 
> Please drop __GFP_NOWARN and instead use something like alloc_contig_pages()
> when required allocation order exceed (MAX_ORDER - 1). Else the test might
> not be able to execute on platform configurations, where PUD THP is enabled.
> 

Yes, It's correct that alloc_contig_pages() should be used here, depending
on CONFIG_CONTIG_ALLOC. Otherwise, alloc_pages(...__GFP_NOWARN...) is still
used as we're doing. This snippet will be changed like below in v4:

	/*
	 * Allocate (huge) pages because some of the tests need to access
	 * the data in the pages. The corresponding tests will be skipped
	 * if we fail to allocate (huge) pages.
	 */
	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
	    IS_ENABLED(CONFIG_CONTIG_ALLOC)) &&
	    has_transparent_hugepage()) {
		page = alloc_contig_pages((1 << (HPAGE_PUD_SHIFT - PAGE_SHIFT)),
					  GFP_KERNEL | __GFP_NOWARN,
					  first_online_node, NULL);
		if (page) {
			args->is_contiguous_pud_page = true;
			args->pud_pfn = page_to_pfn(page);
			args->pmd_pfn = args->pud_pfn;
			args->pte_pfn = args->pud_pfn;
			return 0;
		}
	}

	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
	    has_transparent_hugepage()) {
		page = alloc_pages(GFP_KERNEL | __GFP_NOWARN,
				   HPAGE_PUD_SHIFT - PAGE_SHIFT);
		if (page) {
			args->is_contiguous_pud_page = false;
			args->pud_pfn = page_to_pfn(page);
			args->pmd_pfn = args->pud_pfn;
			args->pte_pfn = args->pud_pfn;
			return 0;
		}
	}

	[... The logic to allocate PMD huge page or page is kept as of being]
         [... The code to release the PUD huge page needs changes based on @args->is_contiguous_pud_page]


>> +		page = alloc_pages(GFP_KERNEL | __GFP_NOWARN,
>> +				   HPAGE_PUD_SHIFT - PAGE_SHIFT);
>> +		if (page) {
>> +			args->pud_pfn = page_to_pfn(page);
>> +			args->pmd_pfn = args->pud_pfn;
>> +			args->pte_pfn = args->pud_pfn;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    has_transparent_hugepage()) {
>> +		page = alloc_pages(GFP_KERNEL | __GFP_NOWARN, HPAGE_PMD_ORDER);
>> +		if (page) {
>> +			args->pmd_pfn = page_to_pfn(page);
>> +			args->pte_pfn = args->pmd_pfn;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	page = alloc_pages(GFP_KERNEL, 0);
>> +	if (page)
>> +		args->pte_pfn = page_to_pfn(page);
>> +
>> +	return 0;
>> +
>> +error:
>> +	destroy_args(args);
>> +	return ret;
>> +}
>> +
>>   static int __init debug_vm_pgtable(void)
>>   {
>> +	struct pgtable_debug_args args;>  	struct vm_area_struct *vma;
>>   	struct mm_struct *mm;
>>   	pgd_t *pgdp;
>> @@ -970,9 +1159,13 @@ static int __init debug_vm_pgtable(void)
>>   	unsigned long vaddr, pte_aligned, pmd_aligned;
>>   	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>>   	spinlock_t *ptl = NULL;
>> -	int idx;
>> +	int idx, ret;
>>   
>>   	pr_info("Validating architecture page table helpers\n");
>> +	ret = init_args(&args);
>> +	if (ret)
>> +		return ret;
>> +
>>   	prot = vm_get_page_prot(VMFLAGS);
>>   	vaddr = get_random_vaddr();
>>   	mm = mm_alloc();
>> @@ -1127,6 +1320,8 @@ static int __init debug_vm_pgtable(void)
>>   	mm_dec_nr_pmds(mm);
>>   	mm_dec_nr_ptes(mm);
>>   	mmdrop(mm);
>> +
>> +	destroy_args(&args);
>>   	return 0;
>>   }
>>   late_initcall(debug_vm_pgtable);
>>

Thanks,
Gavin

