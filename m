Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778783CCD77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhGSFmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhGSFmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626673159;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPnstGCEtTvkXZrYERnR7l4Po4Ab55F6Yj7vw5AsSQc=;
        b=cPB9mpUyUSk9C7BMkg1vt4eAzf4kMN6JBUj1UDGUA9ERK5mlvgVpQ4Kkwo3jR4veM7EyDk
        O14qCCHv1j1UUdFUjhFF21e6pp46grHm7640Kp+khdRyvyu6EH6jrCNIIMVSeSAbzuBluE
        XJxn9kbJGKQ4QIVFEvoYxCryJuBgzac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-ml1BWBk4OXSqYUDPw7A8zQ-1; Mon, 19 Jul 2021 01:39:18 -0400
X-MC-Unique: ml1BWBk4OXSqYUDPw7A8zQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96D07362FF;
        Mon, 19 Jul 2021 05:39:16 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FF9C60C82;
        Mon, 19 Jul 2021 05:39:13 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 01/12] mm/debug_vm_pgtable: Introduce struct
 vm_pgtable_debug
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
 <20210706061748.161258-2-gshan@redhat.com>
 <a74549ac-6794-25a0-7238-2591745e6810@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <65dbdc03-dd34-570c-6beb-7497855b5c8e@redhat.com>
Date:   Mon, 19 Jul 2021 15:39:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a74549ac-6794-25a0-7238-2591745e6810@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/14/21 4:24 PM, Anshuman Khandual wrote:
> On 7/6/21 11:47 AM, Gavin Shan wrote:

Thanks for your review. I will take all your suggestion if it's applicable.
Otherwise, I will explain as below. All changes will be included in v2,
which will be posted pretty soon.

>> In debug_vm_pgtable(), there are many local variables introduced
>> to track the needed information and they are passed to the functions
>> for various test cases. It'd better to introduce a struct as place
>> holder for these information. With it, what the functions for various
>> test cases need is the struct, to simplify the code. It makes the code
>> easier to be maintained.
>>
>> Besides, set_pte_at() could access the data on the corresponding pages.
> 
> s/set_pte_at()/set_pxx_at() to accommodate similar helpers in other page
> table modifying tests as well.
> 

Ok.

>> So the test cases using set_pte_at() should have the pages allocated
>> from buddy. Otherwise, we're acceessing pages that aren't owned by us.
> 
> typo here. s/acceessing/accessing/
> 

Ok.

>> This causes issues like page flag corruption. So we need the allocated
>> pages for these tests where set_pte_at() is used. The struct is introduced
>> so that the old and new implementation can coexist so that the patches
>> can be organized in a easy way.
> 
> s/a easy/an easy/
> 

Ok.

> The rationale for the structure should be explained better. I am wondering
> whether it would be preferable to solve the dynamic page allocation problem
> first in respective test functions, before introducing this structure which
> will convert all test functions.
> 
>>
>> This introduces "struct vm_pgtable_debug" for above purposes. The struct
>> is initialized and destroyed, but the information in the struct isn't
>> used yet. They will be used in subsequent patches.
> 
> There are two set of resources before all functions use the new structure.
> Makes sense.
> 
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/debug_vm_pgtable.c | 210 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 209 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 1c922691aa61..225e2ea4d72f 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -58,6 +58,36 @@
>>   #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>>   #define RANDOM_NZVALUE	GENMASK(7, 0)
>>   
>> +struct vm_pgtable_debug {
> 
> Name should contain 'args'. Probably something like pgtable_debug_args ?
> 

Sure, It will be "struct pgtable_debug_args" and the parameter name
to various test functions will be "@args".

>> +	struct mm_struct	*mm;
>> +	struct vm_area_struct	*vma;
> 
> Linked objects..
> 
>> +
>> +	pgd_t			*pgdp;
>> +	p4d_t			*p4dp;
>> +	pud_t			*pudp;
>> +	pmd_t			*pmdp;
>> +	pte_t			*ptep;
> 
> pgtable pointers..
> 
>> +
>> +	p4d_t			*start_p4dp;
>> +	pud_t			*start_pudp;
>> +	pmd_t			*start_pmdp;
>> +	pgtable_t		start_ptep;
> 
> Saved pgtable pointers..
> 
>> +
>> +	unsigned long		vaddr;
>> +	pgprot_t		page_prot;
>> +	pgprot_t		page_prot_none;
> 
> Other miscellaneous objects..
> 
>> +
>> +	unsigned long		pud_pfn;
>> +	unsigned long		pmd_pfn;
>> +	unsigned long		pte_pfn;
> 
> Dynamically allocated objects..
> 
>> +
>> +	unsigned long		fixed_pgd_pfn;
>> +	unsigned long		fixed_p4d_pfn;
>> +	unsigned long		fixed_pud_pfn;
>> +	unsigned long		fixed_pmd_pfn;
>> +	unsigned long		fixed_pte_pfn;
>> +};
> 
> Derived from symbol 'start_kernel' objects..
> 
>> +
>>   static void __init pte_basic_tests(unsigned long pfn, int idx)
>>   {
>>   	pgprot_t prot = protection_map[idx];
>> @@ -955,8 +985,180 @@ static unsigned long __init get_random_vaddr(void)
>>   	return random_vaddr;
>>   }
>>   
>> +static void __init free_mem(struct vm_pgtable_debug *debug)
>> +{
>> +	struct page *page = NULL;
>> +	int order = 0;
>> +
>> +	/* Free (huge) page */
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> 
> Replace #ifdef with IS_ENABLED(). There is no symbol visibility problem
> without those #ifdef here.
> 

Sure.

>> +	if (has_transparent_hugepage() &&
>> +	    debug->pud_pfn != ULONG_MAX) {
>> +		page = pfn_to_page(debug->pud_pfn);
>> +		order = HPAGE_PUD_SHIFT - PAGE_SHIFT;
>> +	}
>> +#endif
>> +
>> +	if (has_transparent_hugepage() &&
>> +	    debug->pmd_pfn != ULONG_MAX && !page) {
>> +		page = pfn_to_page(debug->pmd_pfn);
>> +		order = HPAGE_PMD_ORDER;
>> +	}
>> +#endif
>> +
>> +	if (debug->pte_pfn != ULONG_MAX && !page) {
>> +		page = pfn_to_page(debug->pte_pfn);
>> +		order = 0;
>> +	}
> 
> This could be further simplified.
> 
> 	if (debug->pud_pfn) {
> 		__free_pages(page, PUD_ORDER)
> 		done
> 	}
> 
> 	if (debug->pmd_pfn) {
> 		__free_pages(page, PMD_ORDER)
> 		done
> 	}
> 
> 	if (debug->pte_pfn)
> 		__free_pages(page, 0)
> 
> If the debug->pxx_pfn is positive and (!= ULONG_MAX), it can be assumed
> that pxx level memory was allocated successfully and is being freed up
> here. Just need to start from the highest order though.

Yes, we can bail early for each case.

> 
>> +
>> +	if (page)
>> +		__free_pages(page, order);
> 
>>From here...
> 
>> +
>> +	/* Free page table */
>> +	if (debug->start_ptep) {
>> +		pte_free(debug->mm, debug->start_ptep);
>> +		mm_dec_nr_ptes(debug->mm);
>> +	}
>> +
>> +	if (debug->start_pmdp) {
>> +		pmd_free(debug->mm, debug->start_pmdp);
>> +		mm_dec_nr_pmds(debug->mm);
>> +	}
>> +
>> +	if (debug->start_pudp) {
>> +		pud_free(debug->mm, debug->start_pudp);
>> +		mm_dec_nr_puds(debug->mm);
>> +	}
>> +
>> +	if (debug->start_p4dp)
>> +		p4d_free(debug->mm, debug->p4dp);
>> +
>> +	/* Free vma and mm struct */
>> +	if (debug->vma)
>> +		vm_area_free(debug->vma);
>> +	if (debug->mm)
>> +		mmdrop(debug->mm);
>> +}
> 
> Till here...
> 
> I am wondering whether it is really necessary to cross check all these
> elements here for being non-NULL, before freeing or rather destroying.
> Except for the allocated huge memory containing pfns and pages, all
> other elements should be asserted before proceeding with the test.
> Hence no additional checks should be required while freeing.
> 

It's possible that "struct pgtable_debug_args" isn't fully populated
by alloc_mem() when free_mem() is called. So the check is needed.
Besides, I will rename these two functions into {init, destroy}_args().

>> +
>> +static int __init alloc_mem(struct vm_pgtable_debug *debug)
>> +{
>> +	struct page *page = NULL;
>> +	phys_addr_t phys;
>> +	int ret = 0;
>> +
>> +	/* Initialize the debugging data */
>> +	debug->mm             = NULL;
>> +	debug->vma            = NULL;
>> +	debug->pgdp           = NULL;
>> +	debug->p4dp           = NULL;
>> +	debug->pudp           = NULL;
>> +	debug->pmdp           = NULL;
>> +	debug->ptep           = NULL;
>> +	debug->start_p4dp     = NULL;
>> +	debug->start_pudp     = NULL;
>> +	debug->start_pmdp     = NULL;
>> +	debug->start_ptep     = NULL;
>> +	debug->vaddr          = 0UL;
>> +	debug->page_prot      = vm_get_page_prot(VM_READ | VM_WRITE | VM_EXEC);
> 
> Should use VMFLAGS instead.
> 

Yes, VMFLAGS will be used in v2.

>> +	debug->page_prot_none = __P000;
>> +	debug->pud_pfn        = ULONG_MAX;
>> +	debug->pmd_pfn        = ULONG_MAX;
>> +	debug->pte_pfn        = ULONG_MAX;
>> +	debug->fixed_pgd_pfn  = ULONG_MAX;
>> +	debug->fixed_p4d_pfn  = ULONG_MAX;
>> +	debug->fixed_pud_pfn  = ULONG_MAX;
>> +	debug->fixed_pmd_pfn  = ULONG_MAX;
>> +	debug->fixed_pte_pfn  = ULONG_MAX;
> 
> It should instead define yet another helper, which would reset all
> structure elements to NULL or some unusable values before they get
> initialized here. Possibly [reset/clr]_debug_pgtable_args() ?
> 

I will use memset(args, 0, sizeof(*args)) in v2.

>> +
>> +	/* Allocate mm and vma */
>> +	debug->mm = mm_alloc();
>> +	if (!debug->mm) {
>> +		pr_warn("Failed to allocate mm struct\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	debug->vma = vm_area_alloc(debug->mm);
>> +	if (!debug->vma) {
>> +		pr_warn("Failed to allocate vma\n");
> 
> s/pr_warn/pr_err. Please dont change any warning levels here.
> 

Yes.

>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	/* Figure out the virtual address and allocate page table entries */
>> +	debug->vaddr = get_random_vaddr();
>> +	debug->pgdp = pgd_offset(debug->mm, debug->vaddr);
>> +	debug->p4dp = p4d_alloc(debug->mm, debug->pgdp, debug->vaddr);
>> +	debug->pudp = debug->p4dp ?
>> +		      pud_alloc(debug->mm, debug->p4dp, debug->vaddr) : NULL;
>> +	debug->pmdp = debug->pudp ?
>> +		      pmd_alloc(debug->mm, debug->pudp, debug->vaddr) : NULL;
>> +	debug->ptep = debug->pmdp ?
>> +		      pte_alloc_map(debug->mm, debug->pmdp, debug->vaddr) : NULL;
> 
> (PXXX ?) construct is really required here. Should not pxx_alloc()
> return NULL if the previous level pointer is NULL ? Regardless it
> might be better to just assert that these intermediary levels are
> allocated before proceeding further. It does not make sense to go
> ahead with the test if any of the allocations failed ! Similar to
> mm and vma.
> 

"debug->ptep" will be NULL if it fails to allocate any level of
page table. The following check for this case. We don't have to
check errors after allocating page table for every level.

> 
>> +	if (!debug->ptep) {
>> +		pr_warn("Failed to allocate page table\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	/*
>> +	 * The above page table entries will be modified. Lets save the
>> +	 * page table entries so that they can be released when the tests
>> +	 * are completed.
>> +	 */
>> +	debug->start_p4dp = p4d_offset(debug->pgdp, 0UL);
>> +	debug->start_pudp = pud_offset(debug->p4dp, 0UL);
>> +	debug->start_pmdp = pmd_offset(debug->pudp, 0UL);
>> +	debug->start_ptep = pmd_pgtable(*(debug->pmdp));
> 
> Please keep the existing construct via tmp pointer obtained from
> READ_ONCE() on (debug->pmdp) before getting used in pmd_pgtable().
> 

Yes.

>> +
>> +	/*
>> +	 * Figure out the fixed addresses, which are all around the kernel
>> +	 * symbol (@start_kernel). The corresponding PFNs might be invalid,
>> +	 * but it's fine as the following tests won't access the pages.
>> +	 */
>> +	phys = __pa_symbol(&start_kernel);
>> +	debug->fixed_pgd_pfn = __phys_to_pfn(phys & PGDIR_MASK);
>> +	debug->fixed_p4d_pfn = __phys_to_pfn(phys & P4D_MASK);
>> +	debug->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
>> +	debug->fixed_pmd_pfn = __phys_to_pfn(phys & PMD_MASK);
>> +	debug->fixed_pte_pfn = __phys_to_pfn(phys & PAGE_MASK);
>> +
>> +	/*
>> +	 * Allocate (huge) pages because some of the tests need to access
>> +	 * the data in the pages. The corresponding tests will be skipped
>> +	 * if we fail to allocate (huge) pages.
>> +	 */
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> 
> There is no symbol visibility problem without this #ifdef. Hence
> please use IS_ENABLED() constructs here instead.
> 
>> +	if (has_transparent_hugepage()) {
>> +		page = alloc_pages(GFP_KERNEL, HPAGE_PUD_SHIFT - PAGE_SHIFT);
>> +		if (page)
>> +			debug->pud_pfn = page_to_pfn(page);
> 			debug->pmd_pfn = debug->pud_pfn;
> 			debug->pte_pfn = debug->pud_pfn;
> 			done; skip;
>> +	}
>> +#endif
>> +
>> +	if (has_transparent_hugepage()) {
>> +		page = page ? page : alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
>> +		if (page)
>> +			debug->pmd_pfn = page_to_pfn(page);
> 			debug->pte_pfn = debug->pmd_pfn;
> 			done; skip;
>> +	}
>> +#endif
>> +
>> +	page = page ? page : alloc_pages(GFP_KERNEL, 0);
>> +	if (page)
>> +		debug->pte_pfn = page_to_pfn(page);
> 
> With the above mentioned changes (page ?) constructs should not be
> required anymore.
>

Yes, I will use IS_ENABLED(). @page might be still needed in order
to keep the code tidy.

  
>> +
>> +	return 0;
>> +
>> +error:
>> +	free_mem(debug);
>> +	return ret;
>> +}
>> +
>>   static int __init debug_vm_pgtable(void)
>>   {
>> +	struct vm_pgtable_debug debug;
> 
> This should be renamed.
> 
> s/debug/pgtable_args ?
> 

I will just have "struct pgtable_debug_args args" in v2.

>>   	struct vm_area_struct *vma;
>>   	struct mm_struct *mm;
>>   	pgd_t *pgdp;
>> @@ -970,9 +1172,13 @@ static int __init debug_vm_pgtable(void)
>>   	unsigned long vaddr, pte_aligned, pmd_aligned;
>>   	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>>   	spinlock_t *ptl = NULL;
>> -	int idx;
>> +	int idx, ret;
>>   
>>   	pr_info("Validating architecture page table helpers\n");
>> +	ret = alloc_mem(&debug);
>> +	if (ret)
>> +		return ret;
>> +
>>   	prot = vm_get_page_prot(VMFLAGS);
>>   	vaddr = get_random_vaddr();
>>   	mm = mm_alloc();
>> @@ -1127,6 +1333,8 @@ static int __init debug_vm_pgtable(void)
>>   	mm_dec_nr_pmds(mm);
>>   	mm_dec_nr_ptes(mm);
>>   	mmdrop(mm);
>> +
>> +	free_mem(&debug);
>>   	return 0;
>>   }
>>   late_initcall(debug_vm_pgtable);
>>

Thanks,
Gavin

