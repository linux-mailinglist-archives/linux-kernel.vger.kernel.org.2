Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088843DA074
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhG2Jka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235940AbhG2Jk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627551625;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dyXZxyIZRUyuEWhxyE3m3xVfikMr6V5djn89fuLl0I=;
        b=ejWIUkTmtfnux1hCUmPiX5/I+Mzfxcs4mG2T/VuSx+IxMzu2SepRXp7iq54WtyDRqrMefQ
        Na87Evq8oJ/bl2bi7yDlXy/TZ63xxZ2Ou9GEX7qd/GaY88tNW31zknxZmidcNy6VOkWdhJ
        GRvB8ZA7l/pjU3OZe42FIfSyGH7X6/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-UR6Jy0cuNxia3Wl9Pw13Kw-1; Thu, 29 Jul 2021 05:40:24 -0400
X-MC-Unique: UR6Jy0cuNxia3Wl9Pw13Kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69EC9800FF3;
        Thu, 29 Jul 2021 09:40:21 +0000 (UTC)
Received: from [10.64.54.184] (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 721C05D9C6;
        Thu, 29 Jul 2021 09:40:16 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-2-gshan@redhat.com>
 <33626f62-0650-67ef-14be-0e79e69365f4@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <2f714383-eccb-9e48-85e6-c22157f37fdd@redhat.com>
Date:   Thu, 29 Jul 2021 19:40:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <33626f62-0650-67ef-14be-0e79e69365f4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/29/21 2:45 PM, Anshuman Khandual wrote:
> On 7/27/21 11:43 AM, Gavin Shan wrote:
>> In debug_vm_pgtable(), there are many local variables introduced to
>> track the needed information and they are passed to the functions for
>> various test cases. It'd better to introduce a struct as place holder
>> for these information. With it, what the tests functions need is the
>> struct. In this way, the code is simplified and easier to be maintained.
>>
>> Besides, set_xxx_at() could access the data on the corresponding pages
>> in the page table modifying tests. So the accessed pages in the tests
>> should have been allocated from buddy. Otherwise, we're accessing pages
>> that aren't owned by us. This causes issues like page flag corruption
>> or kernel crash on accessing unmapped page when CONFIG_DEBUG_PAGEALLOC
>> is enabled.
>>
>> This introduces "struct pgtable_debug_args". The struct is initialized
>> and destroyed, but the information in the struct isn't used yet. It will
>> be used in subsequent patches.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/debug_vm_pgtable.c | 280 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 279 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 1c922691aa61..8c7361643166 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -58,6 +58,37 @@
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
>> +	bool			is_contiguous_page;
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
>> @@ -955,8 +986,249 @@ static unsigned long __init get_random_vaddr(void)
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
>> +		if (args->is_contiguous_page) {
>> +			free_contig_range(args->pud_pfn,
>> +					  (1 << (HPAGE_PUD_SHIFT - PAGE_SHIFT)));
>> +		} else {
>> +			page = pfn_to_page(args->pud_pfn);
>> +			__free_pages(page, HPAGE_PUD_SHIFT - PAGE_SHIFT);
>> +		}
>> +
>> +		args->pud_pfn = ULONG_MAX;
>> +		args->pmd_pfn = ULONG_MAX;
>> +		args->pte_pfn = ULONG_MAX;
>> +	}
>> +
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    has_transparent_hugepage() &&
>> +	    args->pmd_pfn != ULONG_MAX) {
>> +		if (args->is_contiguous_page) {
>> +			free_contig_range(args->pmd_pfn, (1 << HPAGE_PMD_ORDER));
>> +		} else {
>> +			page = pfn_to_page(args->pmd_pfn);
>> +			__free_pages(page, HPAGE_PMD_ORDER);
>> +		}
>> +
>> +		args->pmd_pfn = ULONG_MAX;
>> +		args->pte_pfn = ULONG_MAX;
>> +	}
>> +
>> +	if (args->pte_pfn != ULONG_MAX) {
>> +		page = pfn_to_page(args->pte_pfn);
>> +		__free_pages(page, 0);
>> +	}
>> +
>> +	/* Free page table entries */
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
> 
> Small nit, needs an extra line here.
> 

Yes.

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
>> +	/*
>> +	 * Initialize the debugging data.
>> +	 *
>> +	 * __P000 (or even __S000) will help create page table entries with
>> +	 * PROT_NONE permission as required for pxx_protnone_tests().
>> +	 */
>> +	memset(args, 0, sizeof(*args));
>> +	args->vaddr              = get_random_vaddr();
>> +	args->page_prot          = vm_get_page_prot(VMFLAGS);
>> +	args->page_prot_none     = __P000;
>> +	args->is_contiguous_page = false;
>> +	args->pud_pfn            = ULONG_MAX;
>> +	args->pmd_pfn            = ULONG_MAX;
>> +	args->pte_pfn            = ULONG_MAX;
>> +	args->fixed_pgd_pfn      = ULONG_MAX;
>> +	args->fixed_p4d_pfn      = ULONG_MAX;
>> +	args->fixed_pud_pfn      = ULONG_MAX;
>> +	args->fixed_pmd_pfn      = ULONG_MAX;
>> +	args->fixed_pte_pfn      = ULONG_MAX;
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
>> +	/*
>> +	 * Allocate page table entries. They will be modified in the tests.
>> +	 * Lets save the page table entries so that they can be released
>> +	 * when the tests are completed.
>> +	 */
>> +	args->pgdp = pgd_offset(args->mm, args->vaddr);
>> +	args->p4dp = p4d_alloc(args->mm, args->pgdp, args->vaddr);
>> +	if (!args->p4dp) {
>> +		pr_err("Failed to allocate p4d entries\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	args->start_p4dp = p4d_offset(args->pgdp, 0UL);
>> +	WARN_ON(!args->start_p4dp);
> 
> Please move these two lines up to the previous block as args->start_p4dp
> is primarily derived from args->pgdp. Also please do the same for all
> others blocks down here.
> 

Good point. I will do in v5.

>> +	args->pudp = pud_alloc(args->mm, args->p4dp, args->vaddr);
>> +	if (!args->pudp) {
>> +		pr_err("Failed to allocate pud entries\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	args->start_pudp = pud_offset(args->p4dp, 0UL);
>> +	WARN_ON(!args->start_pudp);
>> +	args->pmdp = pmd_alloc(args->mm, args->pudp, args->vaddr);
>> +	if (!args->pmdp) {
>> +		pr_err("Failed to allocate pmd entries\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	args->start_pmdp = pmd_offset(args->pudp, 0UL);
>> +	WARN_ON(!args->start_pmdp);
>> +	args->ptep = pte_alloc_map(args->mm, args->pmdp, args->vaddr);
>> +	if (!args->ptep) {
>> +		pr_err("Failed to allocate pte entries\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	args->start_ptep = pmd_pgtable(READ_ONCE(*args->pmdp));
>> +	WARN_ON(!args->start_ptep);
>> +
>> +	/*
>> +	 * PFN for mapping at PTE level is determined from a standard kernel
>> +	 * text symbol. But pfns for higher page table levels are derived by
>> +	 * masking lower bits of this real pfn. These derived pfns might not
>> +	 * exist on the platform but that does not really matter as pfn_pxx()
>> +	 * helpers will still create appropriate entries for the test. This
>> +	 * helps avoid large memory block allocations to be used for mapping
>> +	 * at higher page table levels in some of the tests.
>> +	 */
>> +	phys = __pa_symbol(&start_kernel);
>> +	args->fixed_pgd_pfn = __phys_to_pfn(phys & PGDIR_MASK);
>> +	args->fixed_p4d_pfn = __phys_to_pfn(phys & P4D_MASK);
>> +	args->fixed_pud_pfn = __phys_to_pfn(phys & PUD_MASK);
>> +	args->fixed_pmd_pfn = __phys_to_pfn(phys & PMD_MASK);
>> +	args->fixed_pte_pfn = __phys_to_pfn(phys & PAGE_MASK);
>> +	WARN_ON(!pfn_valid(args->fixed_pte_pfn));
>> +
>> +	/*
>> +	 * Allocate (huge) pages because some of the tests need to access
>> +	 * the data in the pages. The corresponding tests will be skipped
>> +	 * if we fail to allocate (huge) pages.
>> +	 */
>> +#ifdef CONFIG_CONTIG_ALLOC
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>> +	    has_transparent_hugepage() &&
>> +	    (HPAGE_PUD_SHIFT - PAGE_SHIFT) >= MAX_ORDER) {
>> +		page = alloc_contig_pages((1 << (HPAGE_PUD_SHIFT - PAGE_SHIFT)),
>> +					  GFP_KERNEL, first_online_node, NULL);
>> +		if (page) {
>> +			args->is_contiguous_page = true;
>> +			args->pud_pfn = page_to_pfn(page);
>> +			args->pmd_pfn = args->pud_pfn;
>> +			args->pte_pfn = args->pud_pfn;
>> +			return 0;
>> +		}
>> +	}
>> +#endif
>> +
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>> +	    has_transparent_hugepage() &&
>> +	    (HPAGE_PUD_SHIFT - PAGE_SHIFT) < MAX_ORDER) {
>> +		page = alloc_pages(GFP_KERNEL, HPAGE_PUD_SHIFT - PAGE_SHIFT);
>> +		if (page) {
>> +			args->pud_pfn = page_to_pfn(page);
>> +			args->pmd_pfn = args->pud_pfn;
>> +			args->pte_pfn = args->pud_pfn;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +#ifdef CONFIG_CONTIG_ALLOC
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    has_transparent_hugepage() &&
>> +	    HPAGE_PMD_ORDER >= MAX_ORDER) {
>> +		page = alloc_contig_pages((1 << HPAGE_PMD_ORDER), GFP_KERNEL,
>> +					  first_online_node, NULL);
>> +		if (page) {
>> +			args->is_contiguous_page = true;
>> +			args->pmd_pfn = page_to_pfn(page);
>> +			args->pte_pfn = args->pmd_pfn;
>> +			return 0;
>> +		}
>> +	}
>> +#endif
>> +
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    has_transparent_hugepage() &&
>> +	    HPAGE_PMD_ORDER < MAX_ORDER) {
>> +		page = alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
>> +		if (page) {
>> +			args->pmd_pfn = page_to_pfn(page);
>> +			args->pte_pfn = args->pmd_pfn;
>> +			return 0;
>> +		}
>> +	}
> 
> This can be simplified further. Could you please define a helper alloc_huge_page()
> which compares the order against MAX_ORDER and calls either alloc_contig_pages()
> when CONFIG_CONTIG_ALLOC or alloc_pages(). This will result in reduced code and
> CONFIG_CONTIG_ALLOC will move into the helper as well.
> 

Yes, I will introduce a helper for this, but the function name will be
debug_vm_pgtable_alloc_huge_page() because alloc_huge_page() has been
declared in include/linux/hugetlb.h

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
>> +	struct pgtable_debug_args args;
>>   	struct vm_area_struct *vma;
>>   	struct mm_struct *mm;
>>   	pgd_t *pgdp;
>> @@ -970,9 +1242,13 @@ static int __init debug_vm_pgtable(void)
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
>> @@ -1127,6 +1403,8 @@ static int __init debug_vm_pgtable(void)
>>   	mm_dec_nr_pmds(mm);
>>   	mm_dec_nr_ptes(mm);
>>   	mmdrop(mm);
>> +
>> +	destroy_args(&args);
>>   	return 0;
>>   }
>>   late_initcall(debug_vm_pgtable);
>>
> 
> Otherwise LGTM.
> 

I will treat this as r-b in v5.

Thanks,
Gavin


