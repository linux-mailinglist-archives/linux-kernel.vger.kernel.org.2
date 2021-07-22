Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66C43D1E26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhGVFmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230334AbhGVFmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626934977;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/j9lDJJR//R/1rtU4Q72mkECn/lkZxHLRnO/7ICo6A=;
        b=O5FYjivGKcCPnlNTZkAQz9fqScnuCNLBopwIqn+csAZUcSMQEBp0hR7Phfq5AesfmBfHpD
        F3dlcadysupjWg7OJg/kOjw4LqaUWJlQfc5YYSymC5HLxj6XJtbyFnNdr+v1pcQd79VXvN
        jWbdSF+L/LOHYmS6FvG8jEd6or4oloU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-8vIb5JljPI6QSFF9xcnuzg-1; Thu, 22 Jul 2021 02:22:56 -0400
X-MC-Unique: 8vIb5JljPI6QSFF9xcnuzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13723107ACF5;
        Thu, 22 Jul 2021 06:22:55 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D59305B4BC;
        Thu, 22 Jul 2021 06:22:51 +0000 (UTC)
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
 <280a5740-b5dc-4b78-3a38-67e5adbb0afd@redhat.com>
 <04a4618f-9899-1518-cee1-0a48cb4df4c6@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <65078a0c-c35c-8e3f-d4d3-3090b0c3daaf@redhat.com>
Date:   Thu, 22 Jul 2021 16:23:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <04a4618f-9899-1518-cee1-0a48cb4df4c6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/22/21 2:41 PM, Anshuman Khandual wrote:
> On 7/21/21 3:50 PM, Gavin Shan wrote:
>> On 7/21/21 3:44 PM, Anshuman Khandual wrote:
>>> On 7/19/21 6:36 PM, Gavin Shan wrote:
>>>> In debug_vm_pgtable(), there are many local variables introduced to
>>>> track the needed information and they are passed to the functions for
>>>> various test cases. It'd better to introduce a struct as place holder
>>>> for these information. With it, what the functions for various test
>>>> cases need is the struct, to simplify the code. It also makes code
>>>> easier to be maintained.
>>>>
>>>> Besides, set_xxx_at() could access the data on the corresponding pages
>>>> in the page table modifying tests. So the accessed pages in the tests
>>>> should have been allocated from buddy. Otherwise, we're accessing pages
>>>> that aren't owned by us. This causes issues like page flag corruption.
>>>>
>>>> This introduces "struct pgtable_debug_args". The struct is initialized
>>>> and destroyed, but the information in the struct isn't used yet. They
>>>> will be used in subsequent patches.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    mm/debug_vm_pgtable.c | 197 +++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 196 insertions(+), 1 deletion(-)
>>>>
>>
>> I saw you've finished the review on PATCH[v3 01/12] and PATCH[v3 02/12].
>> I will wait to integrate your comments to v4 until you finish the review
>> on all patches in v3 series.
>>
>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>> index 1c922691aa61..ea153ff40d23 100644
>>>> --- a/mm/debug_vm_pgtable.c
>>>> +++ b/mm/debug_vm_pgtable.c
>>>> @@ -58,6 +58,36 @@
>>>>    #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>>>>    #define RANDOM_NZVALUE    GENMASK(7, 0)
>>>>    +struct pgtable_debug_args {
>>>> +    struct mm_struct    *mm;
>>>> +    struct vm_area_struct    *vma;
>>>> +
>>>> +    pgd_t            *pgdp;
>>>> +    p4d_t            *p4dp;
>>>> +    pud_t            *pudp;
>>>> +    pmd_t            *pmdp;
>>>> +    pte_t            *ptep;
>>>> +
>>>> +    p4d_t            *start_p4dp;
>>>> +    pud_t            *start_pudp;
>>>> +    pmd_t            *start_pmdp;
>>>> +    pgtable_t        start_ptep;
>>>> +
>>>> +    unsigned long        vaddr;
>>>> +    pgprot_t        page_prot;
>>>> +    pgprot_t        page_prot_none;
>>>> +
>>>> +    unsigned long        pud_pfn;
>>>> +    unsigned long        pmd_pfn;
>>>> +    unsigned long        pte_pfn;
>>>> +
>>>> +    unsigned long        fixed_pgd_pfn;
>>>> +    unsigned long        fixed_p4d_pfn;
>>>> +    unsigned long        fixed_pud_pfn;
>>>> +    unsigned long        fixed_pmd_pfn;
>>>> +    unsigned long        fixed_pte_pfn;
>>>> +};
>>>> +
>>>>    static void __init pte_basic_tests(unsigned long pfn, int idx)
>>>>    {
>>>>        pgprot_t prot = protection_map[idx];
>>>> @@ -955,8 +985,167 @@ static unsigned long __init get_random_vaddr(void)
>>>>        return random_vaddr;
>>>>    }
>>>>    +static void __init destroy_args(struct pgtable_debug_args *args)
>>>> +{
>>>> +    struct page *page = NULL;
>>>> +
>>>> +    /* Free (huge) page */
>>>> +    if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>>> +        IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>>>> +        has_transparent_hugepage() &&
>>>> +        args->pud_pfn != ULONG_MAX) {
>>>> +        page = pfn_to_page(args->pud_pfn);
>>>> +        __free_pages(page, HPAGE_PUD_SHIFT - PAGE_SHIFT);
>>>> +    } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>>> +           has_transparent_hugepage() &&
>>>> +           args->pmd_pfn != ULONG_MAX) {
>>>> +        page = pfn_to_page(args->pmd_pfn);
>>>> +        __free_pages(page, HPAGE_PMD_ORDER);
>>>> +    } else if (args->pte_pfn != ULONG_MAX) {
>>>> +        page = pfn_to_page(args->pte_pfn);
>>>> +        __free_pages(page, 0);
>>>> +    }
>>>> +
>>>> +    /* Free page table */
>>>> +    if (args->start_ptep) {
>>>> +        pte_free(args->mm, args->start_ptep);
>>>> +        mm_dec_nr_ptes(args->mm);
>>>> +    }
>>>> +
>>>> +    if (args->start_pmdp) {
>>>> +        pmd_free(args->mm, args->start_pmdp);
>>>> +        mm_dec_nr_pmds(args->mm);
>>>> +    }
>>>> +
>>>> +    if (args->start_pudp) {
>>>> +        pud_free(args->mm, args->start_pudp);
>>>> +        mm_dec_nr_puds(args->mm);
>>>> +    }
>>>> +
>>>> +    if (args->start_p4dp)
>>>> +        p4d_free(args->mm, args->p4dp);
>>>> +
>>>> +    /* Free vma and mm struct */
>>>> +    if (args->vma)
>>>> +        vm_area_free(args->vma);
>>>> +    if (args->mm)
>>>> +        mmdrop(args->mm);
>>>> +}
>>>> +
>>>> +static int __init init_args(struct pgtable_debug_args *args)
>>>> +{
>>>> +    struct page *page = NULL;
>>>> +    phys_addr_t phys;
>>>> +    int ret = 0;
>>>> +
>>>> +    /* Initialize the debugging data */
>>>> +    memset(args, 0, sizeof(*args));
>>>> +    args->page_prot      = vm_get_page_prot(VMFLAGS);
>>>> +    args->page_prot_none = __P000;
>>>
>>> Please preserve the existing comments before this assignment.
>>>
>>>           /*
>>>            * __P000 (or even __S000) will help create page table entries with
>>>            * PROT_NONE permission as required for pxx_protnone_tests().
>>>            */
>>>
>>
>> Sure. I will combine the comments in v4 as below:
>>
>>      /*
>>       * Initialize the debugging arguments.
>>       *
>>       * __P000 (or even __S000) will help create page table entries with
>>           * PROT_NONE permission as required for pxx_protnone_tests().
>>           */
>>
>>
>>>> +    args->pud_pfn        = ULONG_MAX;
>>>> +    args->pmd_pfn        = ULONG_MAX;
>>>> +    args->pte_pfn        = ULONG_MAX;
>>>> +    args->fixed_pgd_pfn  = ULONG_MAX;
>>>> +    args->fixed_p4d_pfn  = ULONG_MAX;
>>>> +    args->fixed_pud_pfn  = ULONG_MAX;
>>>> +    args->fixed_pmd_pfn  = ULONG_MAX;
>>>> +    args->fixed_pte_pfn  = ULONG_MAX;
>>>> +
>>>> +    /* Allocate mm and vma */
>>>> +    args->mm = mm_alloc();
>>>> +    if (!args->mm) {
>>>> +        pr_err("Failed to allocate mm struct\n");
>>>> +        ret = -ENOMEM;
>>>> +        goto error;
>>>> +    }
>>>> +
>>>> +    args->vma = vm_area_alloc(args->mm);
>>>> +    if (!args->vma) {
>>>> +        pr_err("Failed to allocate vma\n");
>>>> +        ret = -ENOMEM;
>>>> +        goto error;
>>>> +    }
>>>> +
>>>> +    /* Figure out the virtual address and allocate page table entries */
>>>> +    args->vaddr = get_random_vaddr();
>>>
>>> Please group args->vaddr's init with page_prot and page_prot_none above.
>>>
>>
>> Yes, It will make the code tidy. I'll move this line accordingly in v4,
>> but the related comments will be dropped as the code is self-explanatory.
>>
>>          /* Allocate page table entries */
>>
>>>> +    args->pgdp = pgd_offset(args->mm, args->vaddr);
>>>> +    args->p4dp = p4d_alloc(args->mm, args->pgdp, args->vaddr);
>>>> +    args->pudp = args->p4dp ?
>>>> +             pud_alloc(args->mm, args->p4dp, args->vaddr) : NULL;
>>>> +    args->pmdp = args->pudp ?
>>>> +             pmd_alloc(args->mm, args->pudp, args->vaddr) : NULL;
>>>> +    args->ptep = args->pmdp ?
>>>> +             pte_alloc_map(args->mm, args->pmdp, args->vaddr) : NULL;
>>>> +    if (!args->ptep) {
>>>> +        pr_err("Failed to allocate page table\n");
>>>> +        ret = -ENOMEM;
>>>> +        goto error;
>>>> +    }
>>>
>>> Why not just assert that all page table level pointers are allocated
>>> successfully, otherwise bail out the test completely. Something like
>>> this at each level.
>>>
>>>      if (!args->p4dp) {
>>>          pr_err("Failed to allocate page table\n");
>>>          ret = -ENOMEM;
>>>          goto error;
>>>      }
>>>
>>> Is there any value in proceeding with the test when some page table
>>> pointers have not been allocated. Also individual tests do not cross
>>> check these pointers. Also asserting successful allocations will
>>> make the freeing path simpler, as I had mentioned earlier.
>>>
>>
>> There is no tests will be carried out if we fail to allocate any level
>> of page table entries. For other questions, please refer below response.
>> In summary, this snippet needs to be combined with next snippet, as below.
>>
>>>> +
>>>> +    /*
>>>> +     * The above page table entries will be modified. Lets save the
>>>> +     * page table entries so that they can be released when the tests
>>>> +     * are completed.
>>>> +     */
>>>> +    args->start_p4dp = p4d_offset(args->pgdp, 0UL);
>>>> +    args->start_pudp = pud_offset(args->p4dp, 0UL);
>>>> +    args->start_pmdp = pmd_offset(args->pudp, 0UL);
>>>> +    args->start_ptep = pmd_pgtable(READ_ONCE(*(args->pmdp)));
>>>
>>> If the above page table pointers have been validated to be allocated
>>> successfully, we could add these here.
>>>
>>>      WARN_ON(!args->start_p4dp)
>>>      WARN_ON(!args->start_pudp)
>>>      WARN_ON(!args->start_pmdp)
>>>      WARN_ON(!args->start_ptep)
>>>
>>> Afterwards all those if (args->start_pxdp) checks in the freeing path
>>> will not be required anymore.
>>>
>>
>> The check on @args->start_pxdp is still needed in destroy_args() for
>> couple of cases: (1) destroy_args() is called on failing to allocate
>> @args->mm or @args->vma. That time, no page table entries are allocated.
>> (2) It's possible to fail allocating current level of page table entries
>> even the previous levels of page table entries are allocated successfully.
> 
> This makes sense as destroy_args() is getting called if any of these
> allocations fails during init_args(). Did not realize that earlier.
> 
>>
>> So Lets change these (above) two snippets as below in v4:
>>
>>      /*
>>       * Allocate page table entries. The allocated page table entries
>>       * will be modified in the tests. Lets save the page table entries
>>       * so that they can be released when the tests are completed.
>>       */
>>      args->pgdp = pgd_offset(args->mm, args->vaddr);
>>      args->p4dp = p4d_alloc(args->mm, args->pgdp, args->vaddr);
>>      if (!args->p4dp) {
>>          pr_err("Failed to allocate p4d entries\n");
>>          ret = -ENOMEM;
>>          goto error;
>>      }
>>
>>      args->start_p4dp = p4d_offset(args->pgdp, 0UL);
> 
> Dont bring the arg->start_pxdp assignments here. If all page table level
> pointer allocations succeed, they all get assigned together like we have
> right now. Although a sanity check afterwards like the following, might
> still be better.
> 
> WARN_ON(!args->start_p4dp)
> WARN_ON(!args->start_pudp)
> WARN_ON(!args->start_pmdp)
> WARN_ON(!args->start_ptep)
> 

We have to assign arg->start_pxdp here because destroy_args() relies
it to release the corresponding page tables in failing path. For example,
the args->start_p4dp is going to be release if we fail to populate
args->start_pudp.

Ok. I will add WARN_ON() for each level of page table entries right after
they are assigned in v4.

>>      args->pudp = pud_alloc(args->mm, args->p4dp, args->vaddr);
>>      if (!args->pudp) {
>>          pr_err("Failed to allocate pud entries\n");
>>          ret = -ENOMEM;
>>          goto error;
>>      }
>>
>>      args->pmdp = pmd_alloc(args->mm, args->pudp, args->vaddr);
>>      if (!args->pmdp) {
>>          pr_err("Failed to allocate PMD entries\n");
>>          ret = -ENOMEM;
>>          goto error;
>>      }
>>
>>      args->start_pmdp = pmd_offset(args->pudp, 0UL);
>>      args->ptep = pte_alloc_map(args->mm, args->pmdp, args->vaddr);
>>      if (!args->ptep) {
>>          pr_err("Failed to allocate page table\n");
>>          ret = -ENOMEM;
>>          goto error;
>>      }
>>
>>      args->start_ptep = pmd_pgtable(READ_ONCE(*(args->pmdp)));
>>
>>>> +
>>>> +    /*
>>>> +     * Figure out the fixed addresses, which are all around the kernel
>>>> +     * symbol (@start_kernel). The corresponding PFNs might be invalid,
>>>> +     * but it's fine as the following tests won't access the pages.
>>>> +     */
>>>> +    phys = __pa_symbol(&start_kernel);
>>>> +    args->fixed_pgd_pfn = __phys_to_pfn(phys & PGDIR_MASK);
>>>> +    args->fixed_p4d_pfn = __phys_to_pfn(phys & P4D_MASK);
>>>> +    args->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
>>>> +    args->fixed_pmd_pfn = __phys_to_pfn(phys & PMD_MASK);
>>>> +    args->fixed_pte_pfn = __phys_to_pfn(phys & PAGE_MASK);
>>>> +
>>>> +    /*
>>>> +     * Allocate (huge) pages because some of the tests need to access
>>>> +     * the data in the pages. The corresponding tests will be skipped
>>>> +     * if we fail to allocate (huge) pages.
>>>> +     */
>>>> +    if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>>> +        IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>>>> +        has_transparent_hugepage()) {
>>>> +        page = alloc_pages(GFP_KERNEL | __GFP_NOWARN,
>>>> +                   HPAGE_PUD_SHIFT - PAGE_SHIFT);
>>>
>>> Please drop __GFP_NOWARN and instead use something like alloc_contig_pages()
>>> when required allocation order exceed (MAX_ORDER - 1). Else the test might
>>> not be able to execute on platform configurations, where PUD THP is enabled.
>>>
>>
>> Yes, It's correct that alloc_contig_pages() should be used here, depending
>> on CONFIG_CONTIG_ALLOC. Otherwise, alloc_pages(...__GFP_NOWARN...) is still
>> used as we're doing. This snippet will be changed like below in v4:
> 
> First 'order > (MAX_ORDER - 1)' needs to be established before calling into
> alloc_contig_pages() without __GFP_NOWARN and set a new flag indicating that
> there is contig page allocated. But if 'order <= (MAX_ORDER - 1)', then call
> alloc_pages(..) without  __GFP_NOWARN. There is no need to add  __GFP_NOWARN
> in any case. In case CONFIG_CONTIG_ALLOC is not available, directly return a
> NULL as that would have been the case with alloc_pages(...__GFP_NOWARN...) as
> well.
> 
> Symbol alloc_contig_pages() is not available outside CONFIG_CONTIG_ALLOC. So
> IS_ENABLED() construct will not work, unless there is an empty stub added in
> the header. Otherwise #ifdef CONFIG_CONTIG_ALLOC needs to be used instead.
> 
> Regardless please do test this on a x86 platform with PUD based THP in order
> to make sure every thing works as expected.
> 

Thanks, I will change the code accordingly in v4 and test it on x86
before posting it.

>>
>>      /*
>>       * Allocate (huge) pages because some of the tests need to access
>>       * the data in the pages. The corresponding tests will be skipped
>>       * if we fail to allocate (huge) pages.
>>       */
>>      if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>          IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>>          IS_ENABLED(CONFIG_CONTIG_ALLOC)) &&
>>          has_transparent_hugepage()) {
>>          page = alloc_contig_pages((1 << (HPAGE_PUD_SHIFT - PAGE_SHIFT)),
>>                        GFP_KERNEL | __GFP_NOWARN,
>>                        first_online_node, NULL);
>>          if (page) {
>>              args->is_contiguous_pud_page = true;
>>              args->pud_pfn = page_to_pfn(page);
>>              args->pmd_pfn = args->pud_pfn;
>>              args->pte_pfn = args->pud_pfn;
>>              return 0;
>>          }
>>      }
>>
>>      if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>          IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>>          has_transparent_hugepage()) {
>>          page = alloc_pages(GFP_KERNEL | __GFP_NOWARN,
>>                     HPAGE_PUD_SHIFT - PAGE_SHIFT);
>>          if (page) {
>>              args->is_contiguous_pud_page = false;
>>              args->pud_pfn = page_to_pfn(page);
>>              args->pmd_pfn = args->pud_pfn;
>>              args->pte_pfn = args->pud_pfn;
>>              return 0;
>>          }
>>      }
>>
>>      [... The logic to allocate PMD huge page or page is kept as of being]
> 
> IIRC it is also not guaranteed that PMD_SHIFT <= (MAX_ORDER - 1). Hence
> this same scheme should be followed for PMD level allocation as well.
> 

In theory, it's possible to have PMD_SHIFT <= (MAX_ORDER - 1) with misconfigured
kernel. I will apply the similar logic to PMD huge page in v4.

>>      [... The code to release the PUD huge page needs changes based on @args->is_contiguous_pud_page]
> 
> Right, a flag would be needed to call the appropriate free function.
> 

Yes. We need two falgs for PUD and PMD huge pages separately.

Thanks,
Gavin

