Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F407D3D1DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 07:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhGVFPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:15:30 -0400
Received: from foss.arm.com ([217.140.110.172]:44456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhGVFP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:15:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FD4AD6E;
        Wed, 21 Jul 2021 22:56:05 -0700 (PDT)
Received: from [10.163.65.134] (unknown [10.163.65.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6333F66F;
        Wed, 21 Jul 2021 22:56:02 -0700 (PDT)
Subject: Re: [PATCH v3 07/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PTE modifying tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-8-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bfa07f56-f58c-f2c3-64e1-1cdb09dbf366@arm.com>
Date:   Thu, 22 Jul 2021 11:26:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210719130613.334901-8-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 6:36 PM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in PTE modifying tests. The allocated
> page is used as set_pte_at() is used there. The tests are skipped if
> the allocated page doesn't exist. Besides, the unused variable @ptep
> and @pte_aligned in debug_vm_pgtable() are dropped.

Please dont drop @ptep and @pte_aligned just yet.

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 75 ++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index d32e55a95c55..eb6dda88e0d9 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -116,10 +116,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>  }
>  
> -static void __init pte_advanced_tests(struct mm_struct *mm,
> -				      struct vm_area_struct *vma, pte_t *ptep,
> -				      unsigned long pfn, unsigned long vaddr,
> -				      pgprot_t prot)
> +static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>  {
>  	pte_t pte;
>  
> @@ -130,33 +127,38 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>  	 */
>  
>  	pr_debug("Validating PTE advanced\n");
> -	pte = pfn_pte(pfn, prot);
> -	set_pte_at(mm, vaddr, ptep, pte);
> -	ptep_set_wrprotect(mm, vaddr, ptep);
> -	pte = ptep_get(ptep);
> +	if (args->pte_pfn == ULONG_MAX) {
> +		pr_debug("%s: Skipped\n", __func__);
> +		return;
> +	}

Just return. Please dont call out "Skipped". Also this check should be
performed before printing pr_debug("Validating PTE advanced\n"). The
print indicates that the test has started.

> +
> +	pte = pfn_pte(args->pte_pfn, args->page_prot);
> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> +	ptep_set_wrprotect(args->mm, args->vaddr, args->ptep);
> +	pte = ptep_get(args->ptep);
>  	WARN_ON(pte_write(pte));
> -	ptep_get_and_clear(mm, vaddr, ptep);
> -	pte = ptep_get(ptep);
> +	ptep_get_and_clear(args->mm, args->vaddr, args->ptep);
> +	pte = ptep_get(args->ptep);
>  	WARN_ON(!pte_none(pte));
>  
> -	pte = pfn_pte(pfn, prot);
> +	pte = pfn_pte(args->pte_pfn, args->page_prot);
>  	pte = pte_wrprotect(pte);
>  	pte = pte_mkclean(pte);
> -	set_pte_at(mm, vaddr, ptep, pte);
> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>  	pte = pte_mkwrite(pte);
>  	pte = pte_mkdirty(pte);
> -	ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
> -	pte = ptep_get(ptep);
> +	ptep_set_access_flags(args->vma, args->vaddr, args->ptep, pte, 1);
> +	pte = ptep_get(args->ptep);
>  	WARN_ON(!(pte_write(pte) && pte_dirty(pte)));
> -	ptep_get_and_clear_full(mm, vaddr, ptep, 1);
> -	pte = ptep_get(ptep);
> +	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
> +	pte = ptep_get(args->ptep);
>  	WARN_ON(!pte_none(pte));
>  
> -	pte = pfn_pte(pfn, prot);
> +	pte = pfn_pte(args->pte_pfn, args->page_prot);
>  	pte = pte_mkyoung(pte);
> -	set_pte_at(mm, vaddr, ptep, pte);
> -	ptep_test_and_clear_young(vma, vaddr, ptep);
> -	pte = ptep_get(ptep);
> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> +	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
> +	pte = ptep_get(args->ptep);
>  	WARN_ON(pte_young(pte));
>  }
>  
> @@ -617,20 +619,24 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>  }
>  #endif /* PAGETABLE_P4D_FOLDED */
>  
> -static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
> -				   unsigned long pfn, unsigned long vaddr,
> -				   pgprot_t prot)
> +static void __init pte_clear_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte;
>  
>  	pr_debug("Validating PTE clear\n");
> +	if (args->pte_pfn == ULONG_MAX) {
> +		pr_debug("%s: Skipped\n", __func__);
> +		return;
> +	}

Just return. Please dont call out "Skipped". Also this check should be
performed before printing pr_debug("Validating PTE clear\n"). The print
indicates that the test has started.

> +
> +	pte = pfn_pte(args->pte_pfn, args->page_prot);

Please keep this unchanged and move to its original position.

>  #ifndef CONFIG_RISCV
>  	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>  #endif
> -	set_pte_at(mm, vaddr, ptep, pte);
> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>  	barrier();
> -	pte_clear(mm, vaddr, ptep);
> -	pte = ptep_get(ptep);
> +	pte_clear(args->mm, args->vaddr, args->ptep);
> +	pte = ptep_get(args->ptep);
>  	WARN_ON(!pte_none(pte));
>  }
>  
> @@ -1150,11 +1156,10 @@ static int __init debug_vm_pgtable(void)
>  	p4d_t *p4dp, *saved_p4dp;
>  	pud_t *pudp, *saved_pudp;
>  	pmd_t *pmdp, *saved_pmdp, pmd;
> -	pte_t *ptep;
>  	pgtable_t saved_ptep;
>  	pgprot_t prot;
>  	phys_addr_t paddr;
> -	unsigned long vaddr, pte_aligned, pmd_aligned;
> +	unsigned long vaddr, pmd_aligned;
>  	unsigned long pud_aligned;
>  	spinlock_t *ptl = NULL;
>  	int idx, ret;
> @@ -1189,10 +1194,8 @@ static int __init debug_vm_pgtable(void)
>  	 */
>  	paddr = __pa_symbol(&start_kernel);
>  
> -	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;

Please dont drop pte_aligned just yet.

>  	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
>  	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
> -	WARN_ON(!pfn_valid(pte_aligned));

This should go into init_args() at the right place as the following,
after evaluating it from 'start_kernel' symbol - just to be sure.

WARN_ON(!pfn_valid(args->fixed_pte_pfn))

>  
>  	pgdp = pgd_offset(mm, vaddr);
>  	p4dp = p4d_alloc(mm, pgdp, vaddr);
> @@ -1272,11 +1275,11 @@ static int __init debug_vm_pgtable(void)
>  	 * Page table modifying tests. They need to hold
>  	 * proper page table lock.
>  	 */
> -
> -	ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
> -	pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
> -	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> -	pte_unmap_unlock(ptep, ptl);
> +	ptl = pte_lockptr(args.mm, args.pmdp);
> +	spin_lock(ptl);
> +	pte_clear_tests(&args);
> +	pte_advanced_tests(&args);
> +	spin_unlock(ptl);

Why pte_offset_map_lock()/pte_unmap_unlock() has been dropped and
spin_lock()/spin_unlock() sequence has been added ? Please dont
change the tests in these patches.

>  
>  	ptl = pmd_lock(mm, pmdp);
>  	pmd_clear_tests(mm, pmdp);
>
