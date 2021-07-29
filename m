Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABA83D9CED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhG2ExO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:53:14 -0400
Received: from foss.arm.com ([217.140.110.172]:40676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233607AbhG2ExN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:53:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94F36D;
        Wed, 28 Jul 2021 21:53:10 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52C63F66F;
        Wed, 28 Jul 2021 21:53:06 -0700 (PDT)
Subject: Re: [PATCH v4 02/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in basic tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-3-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7f2cbb0d-cde7-3ebd-2a82-4ba697b54e07@arm.com>
Date:   Thu, 29 Jul 2021 10:23:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-3-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in the basic test functions. The
> unused variables @pgd_aligned and @p4d_aligned in debug_vm_pgtable()
> are dropped.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 50 +++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 8c7361643166..8498aa180ebc 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -89,10 +89,10 @@ struct pgtable_debug_args {
>  	unsigned long		fixed_pte_pfn;
>  };
>  
> -static void __init pte_basic_tests(unsigned long pfn, int idx)
> +static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>  {
>  	pgprot_t prot = protection_map[idx];
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, prot);
>  	unsigned long val = idx, *ptr = &val;
>  
>  	pr_debug("Validating PTE basic (%pGv)\n", ptr);
> @@ -174,7 +174,7 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static void __init pmd_basic_tests(unsigned long pfn, int idx)
> +static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>  {
>  	pgprot_t prot = protection_map[idx];
>  	unsigned long val = idx, *ptr = &val;
> @@ -184,7 +184,7 @@ static void __init pmd_basic_tests(unsigned long pfn, int idx)
>  		return;
>  
>  	pr_debug("Validating PMD basic (%pGv)\n", ptr);
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->fixed_pmd_pfn, prot);
>  
>  	/*
>  	 * This test needs to be executed after the given page table entry
> @@ -296,7 +296,7 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>  }
>  
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> -static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx)
> +static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
>  {
>  	pgprot_t prot = protection_map[idx];
>  	unsigned long val = idx, *ptr = &val;
> @@ -306,7 +306,7 @@ static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int
>  		return;
>  
>  	pr_debug("Validating PUD basic (%pGv)\n", ptr);
> -	pud = pfn_pud(pfn, prot);
> +	pud = pfn_pud(args->fixed_pud_pfn, prot);
>  
>  	/*
>  	 * This test needs to be executed after the given page table entry
> @@ -327,7 +327,7 @@ static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int
>  	WARN_ON(pud_dirty(pud_wrprotect(pud_mkclean(pud))));
>  	WARN_ON(!pud_dirty(pud_wrprotect(pud_mkdirty(pud))));
>  
> -	if (mm_pmd_folded(mm))
> +	if (mm_pmd_folded(args->mm))
>  		return;
>  
>  	/*
> @@ -404,7 +404,7 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pud_leaf(pud));
>  }
>  #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> -static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
> +static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
>  static void __init pud_advanced_tests(struct mm_struct *mm,
>  				      struct vm_area_struct *vma, pud_t *pudp,
>  				      unsigned long pfn, unsigned long vaddr,
> @@ -414,8 +414,8 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
> -static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
> +static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
> +static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
>  static void __init pmd_advanced_tests(struct mm_struct *mm,
>  				      struct vm_area_struct *vma, pmd_t *pmdp,
>  				      unsigned long pfn, unsigned long vaddr,
> @@ -476,7 +476,7 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>  static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
>  #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
> -static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
> +static void __init p4d_basic_tests(struct pgtable_debug_args *args)
>  {
>  	p4d_t p4d;
>  
> @@ -485,7 +485,7 @@ static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!p4d_same(p4d, p4d));
>  }
>  
> -static void __init pgd_basic_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pgd_basic_tests(struct pgtable_debug_args *args)
>  {
>  	pgd_t pgd;
>  
> @@ -890,7 +890,7 @@ static void __init swap_migration_tests(void)
>  }
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> -static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
> +static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
>  {
>  	struct page *page;
>  	pte_t pte;
> @@ -900,21 +900,21 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
>  	 * Accessing the page associated with the pfn is safe here,
>  	 * as it was previously derived from a real kernel symbol.
>  	 */
> -	page = pfn_to_page(pfn);
> -	pte = mk_huge_pte(page, prot);
> +	page = pfn_to_page(args->fixed_pmd_pfn);
> +	pte = mk_huge_pte(page, args->page_prot);
>  
>  	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
>  	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
>  	WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte))));
>  
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> -	pte = pfn_pte(pfn, prot);
> +	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
>  
>  	WARN_ON(!pte_huge(pte_mkhuge(pte)));
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>  }
>  #else  /* !CONFIG_HUGETLB_PAGE */
> -static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init hugetlb_basic_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -1240,7 +1240,7 @@ static int __init debug_vm_pgtable(void)
>  	pgprot_t prot, protnone;
>  	phys_addr_t paddr;
>  	unsigned long vaddr, pte_aligned, pmd_aligned;
> -	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
> +	unsigned long pud_aligned;
>  	spinlock_t *ptl = NULL;
>  	int idx, ret;
>  
> @@ -1283,8 +1283,6 @@ static int __init debug_vm_pgtable(void)
>  	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
>  	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
>  	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
> -	p4d_aligned = (paddr & P4D_MASK) >> PAGE_SHIFT;
> -	pgd_aligned = (paddr & PGDIR_MASK) >> PAGE_SHIFT;
>  	WARN_ON(!pfn_valid(pte_aligned));
>  
>  	pgdp = pgd_offset(mm, vaddr);
> @@ -1318,9 +1316,9 @@ static int __init debug_vm_pgtable(void)
>  	 * given page table entry.
>  	 */
>  	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
> -		pte_basic_tests(pte_aligned, idx);
> -		pmd_basic_tests(pmd_aligned, idx);
> -		pud_basic_tests(mm, pud_aligned, idx);
> +		pte_basic_tests(&args, idx);
> +		pmd_basic_tests(&args, idx);
> +		pud_basic_tests(&args, idx);
>  	}
>  
>  	/*
> @@ -1330,8 +1328,8 @@ static int __init debug_vm_pgtable(void)
>  	 * the above iteration for now to save some test execution
>  	 * time.
>  	 */
> -	p4d_basic_tests(p4d_aligned, prot);
> -	pgd_basic_tests(pgd_aligned, prot);
> +	p4d_basic_tests(&args);
> +	pgd_basic_tests(&args);
>  
>  	pmd_leaf_tests(pmd_aligned, prot);
>  	pud_leaf_tests(pud_aligned, prot);
> @@ -1360,7 +1358,7 @@ static int __init debug_vm_pgtable(void)
>  	pmd_thp_tests(pmd_aligned, prot);
>  	pud_thp_tests(pud_aligned, prot);
>  
> -	hugetlb_basic_tests(pte_aligned, prot);
> +	hugetlb_basic_tests(&args);
>  
>  	/*
>  	 * Page table modifying tests. They need to hold
> 


Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
