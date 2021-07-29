Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575AE3D9D06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhG2FPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:15:41 -0400
Received: from foss.arm.com ([217.140.110.172]:40806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhG2FPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:15:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B9276D;
        Wed, 28 Jul 2021 22:15:37 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A79F73F66F;
        Wed, 28 Jul 2021 22:15:33 -0700 (PDT)
Subject: Re: [PATCH v4 07/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PTE modifying tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-8-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <152279a1-76db-d528-6e97-ffc90c6768b5@arm.com>
Date:   Thu, 29 Jul 2021 10:46:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-8-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in PTE modifying tests. The allocated
> page is used as set_pte_at() is used there. The tests are skipped if
> the allocated page doesn't exist. Besides, the unused variable @ptep
> and @pte_aligned in debug_vm_pgtable() are dropped.

A small nit. @ptep is not getting dropped here, it's still around and used.

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 64 +++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 9136195efde3..b5b22e666954 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -117,10 +117,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
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
> @@ -129,35 +126,37 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>  	 * This requires set_pte_at to be not used to update an
>  	 * existing pte entry. Clear pte before we do set_pte_at
>  	 */
> +	if (args->pte_pfn == ULONG_MAX)
> +		return;
>  
>  	pr_debug("Validating PTE advanced\n");
> -	pte = pfn_pte(pfn, prot);
> -	set_pte_at(mm, vaddr, ptep, pte);
> -	ptep_set_wrprotect(mm, vaddr, ptep);
> -	pte = ptep_get(ptep);
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
> @@ -618,20 +617,21 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>  }
>  #endif /* PAGETABLE_P4D_FOLDED */
>  
> -static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
> -				   unsigned long pfn, unsigned long vaddr,
> -				   pgprot_t prot)
> +static void __init pte_clear_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->pte_pfn, args->page_prot);
> +
> +	if (args->pte_pfn == ULONG_MAX)
> +		return;
>  
>  	pr_debug("Validating PTE clear\n");
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
> @@ -1237,7 +1237,7 @@ static int __init debug_vm_pgtable(void)
>  	pgtable_t saved_ptep;
>  	pgprot_t prot;
>  	phys_addr_t paddr;
> -	unsigned long vaddr, pte_aligned, pmd_aligned;
> +	unsigned long vaddr, pmd_aligned;
>  	unsigned long pud_aligned;
>  	spinlock_t *ptl = NULL;
>  	int idx, ret;
> @@ -1272,10 +1272,8 @@ static int __init debug_vm_pgtable(void)
>  	 */
>  	paddr = __pa_symbol(&start_kernel);
>  
> -	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
>  	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
>  	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
> -	WARN_ON(!pfn_valid(pte_aligned));
>  
>  	pgdp = pgd_offset(mm, vaddr);
>  	p4dp = p4d_alloc(mm, pgdp, vaddr);
> @@ -1357,9 +1355,9 @@ static int __init debug_vm_pgtable(void)
>  	 * proper page table lock.
>  	 */
>  
> -	ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
> -	pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
> -	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> +	ptep = pte_offset_map_lock(args.mm, args.pmdp, args.vaddr, &ptl);
> +	pte_clear_tests(&args);
> +	pte_advanced_tests(&args);
>  	pte_unmap_unlock(ptep, ptl);
>  
>  	ptl = pmd_lock(mm, pmdp);
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
