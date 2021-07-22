Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD03D1DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhGVFDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:03:50 -0400
Received: from foss.arm.com ([217.140.110.172]:44262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhGVFDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:03:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB2EFD6E;
        Wed, 21 Jul 2021 22:44:20 -0700 (PDT)
Received: from [10.163.65.134] (unknown [10.163.65.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A805E3F66F;
        Wed, 21 Jul 2021 22:44:18 -0700 (PDT)
Subject: Re: [PATCH v3 08/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PMD modifying tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-9-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <52a61d4a-f93d-af9e-4a34-d8ea7c476838@arm.com>
Date:   Thu, 22 Jul 2021 11:15:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210719130613.334901-9-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 6:36 PM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in PMD modifying tests. The allocated
> huge page is used when set_pmd_at() is used. The corresponding tests
> are skipped if the huge page doesn't exist. Besides, the unused variable
> @pmd_aligned in debug_vm_pgtable() is dropped.

Please dont drop @pmd_aligned just yet.

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 102 ++++++++++++++++++++----------------------
>  1 file changed, 48 insertions(+), 54 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index eb6dda88e0d9..cec3cbf99a6b 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -213,54 +213,54 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
>  }
>  
> -static void __init pmd_advanced_tests(struct mm_struct *mm,
> -				      struct vm_area_struct *vma, pmd_t *pmdp,
> -				      unsigned long pfn, unsigned long vaddr,
> -				      pgprot_t prot, pgtable_t pgtable)
> +static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
> +	unsigned long vaddr = (args->vaddr & HPAGE_PMD_MASK);
>  
>  	if (!has_transparent_hugepage())
>  		return;
>  
>  	pr_debug("Validating PMD advanced\n");
> -	/* Align the address wrt HPAGE_PMD_SIZE */
> -	vaddr &= HPAGE_PMD_MASK;

Please just leave these unchanged. If has_transparent_hugepage() evaluates
negative, it skips the masking operation. As mentioned earlier please avoid
changing the test in any manner during these transition patches.

> +	if (args->pmd_pfn == ULONG_MAX) {
> +		pr_debug("%s: Skipped\n", __func__);
> +		return;
> +	}

Just return. Please dont call out "Skipped".

>  
> -	pgtable_trans_huge_deposit(mm, pmdp, pgtable);
> +	pgtable_trans_huge_deposit(args->mm, args->pmdp, args->start_ptep);
>  
> -	pmd = pfn_pmd(pfn, prot);
> -	set_pmd_at(mm, vaddr, pmdp, pmd);
> -	pmdp_set_wrprotect(mm, vaddr, pmdp);
> -	pmd = READ_ONCE(*pmdp);
> +	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
> +	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
> +	pmdp_set_wrprotect(args->mm, vaddr, args->pmdp);
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(pmd_write(pmd));
> -	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
> -	pmd = READ_ONCE(*pmdp);
> +	pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(!pmd_none(pmd));
>  
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
>  	pmd = pmd_wrprotect(pmd);
>  	pmd = pmd_mkclean(pmd);
> -	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
>  	pmd = pmd_mkwrite(pmd);
>  	pmd = pmd_mkdirty(pmd);
> -	pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
> -	pmd = READ_ONCE(*pmdp);
> +	pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
> -	pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
> -	pmd = READ_ONCE(*pmdp);
> +	pmdp_huge_get_and_clear_full(args->vma, vaddr, args->pmdp, 1);
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(!pmd_none(pmd));
>  
> -	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> +	pmd = pmd_mkhuge(pfn_pmd(args->pmd_pfn, args->page_prot));
>  	pmd = pmd_mkyoung(pmd);
> -	set_pmd_at(mm, vaddr, pmdp, pmd);
> -	pmdp_test_and_clear_young(vma, vaddr, pmdp);
> -	pmd = READ_ONCE(*pmdp);
> +	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
> +	pmdp_test_and_clear_young(args->vma, vaddr, args->pmdp);
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(pmd_young(pmd));
>  
>  	/*  Clear the pte entries  */
> -	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
> -	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
> +	pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
> +	pgtable_trans_huge_withdraw(args->mm, args->pmdp);
>  }
>  
>  static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
> @@ -417,12 +417,7 @@ static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>  static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
>  static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
> -static void __init pmd_advanced_tests(struct mm_struct *mm,
> -				      struct vm_area_struct *vma, pmd_t *pmdp,
> -				      unsigned long pfn, unsigned long vaddr,
> -				      pgprot_t prot, pgtable_t pgtable)
> -{
> -}
> +static void __init pmd_advanced_tests(struct pgtable_debug_args *args) { }
>  static void __init pud_advanced_tests(struct mm_struct *mm,
>  				      struct vm_area_struct *vma, pud_t *pudp,
>  				      unsigned long pfn, unsigned long vaddr,
> @@ -435,11 +430,11 @@ static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
> +static void __init pmd_huge_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> -	if (!arch_vmap_pmd_supported(prot))
> +	if (!arch_vmap_pmd_supported(args->page_prot))
>  		return;
>  
>  	pr_debug("Validating PMD huge\n");
> @@ -447,10 +442,11 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>  	 * X86 defined pmd_set_huge() verifies that the given
>  	 * PMD is not a populated non-leaf entry.
>  	 */
> -	WRITE_ONCE(*pmdp, __pmd(0));
> -	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
> -	WARN_ON(!pmd_clear_huge(pmdp));
> -	pmd = READ_ONCE(*pmdp);
> +	WRITE_ONCE(*(args->pmdp), __pmd(0));

Possible extra braces.

> +	WARN_ON(!pmd_set_huge(args->pmdp, __pfn_to_phys(args->fixed_pmd_pfn),
> +			      args->page_prot));

Dont break the line.

> +	WARN_ON(!pmd_clear_huge(args->pmdp));
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(!pmd_none(pmd));
>  }
>  
> @@ -473,7 +469,7 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pud_none(pud));
>  }
>  #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_huge_tests(struct pgtable_debug_args *args) { }
>  static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
>  #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
> @@ -640,20 +636,19 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
>  	WARN_ON(!pte_none(pte));
>  }
>  
> -static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
> +static void __init pmd_clear_tests(struct pgtable_debug_args *args)
>  {
> -	pmd_t pmd = READ_ONCE(*pmdp);
> +	pmd_t pmd = READ_ONCE(*(args->pmdp));
>  
>  	pr_debug("Validating PMD clear\n");
>  	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
> -	WRITE_ONCE(*pmdp, pmd);
> -	pmd_clear(pmdp);
> -	pmd = READ_ONCE(*pmdp);
> +	WRITE_ONCE(*(args->pmdp), pmd);
> +	pmd_clear(args->pmdp);
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(!pmd_none(pmd));
>  }
>  
> -static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
> -				      pgtable_t pgtable)
> +static void __init pmd_populate_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> @@ -662,8 +657,8 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
>  	 * This entry points to next level page table page.
>  	 * Hence this must not qualify as pmd_bad().
>  	 */
> -	pmd_populate(mm, pmdp, pgtable);
> -	pmd = READ_ONCE(*pmdp);
> +	pmd_populate(args->mm, args->pmdp, args->start_ptep);
> +	pmd = READ_ONCE(*(args->pmdp));
>  	WARN_ON(pmd_bad(pmd));
>  }
>  
> @@ -1159,7 +1154,7 @@ static int __init debug_vm_pgtable(void)
>  	pgtable_t saved_ptep;
>  	pgprot_t prot;
>  	phys_addr_t paddr;
> -	unsigned long vaddr, pmd_aligned;
> +	unsigned long vaddr;
>  	unsigned long pud_aligned;
>  	spinlock_t *ptl = NULL;
>  	int idx, ret;
> @@ -1194,7 +1189,6 @@ static int __init debug_vm_pgtable(void)
>  	 */
>  	paddr = __pa_symbol(&start_kernel);
>  
> -	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;

Please dont drop these just yet and wait until [PATCH 11/12].

>  	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
>  
>  	pgdp = pgd_offset(mm, vaddr);
> @@ -1281,11 +1275,11 @@ static int __init debug_vm_pgtable(void)
>  	pte_advanced_tests(&args);
>  	spin_unlock(ptl);
>  
> -	ptl = pmd_lock(mm, pmdp);
> -	pmd_clear_tests(mm, pmdp);
> -	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot, saved_ptep);
> -	pmd_huge_tests(pmdp, pmd_aligned, prot);
> -	pmd_populate_tests(mm, pmdp, saved_ptep);
> +	ptl = pmd_lock(args.mm, args.pmdp);
> +	pmd_clear_tests(&args);
> +	pmd_advanced_tests(&args);
> +	pmd_huge_tests(&args);
> +	pmd_populate_tests(&args);
>  	spin_unlock(ptl);
>  
>  	ptl = pud_lock(mm, pudp);
> 
