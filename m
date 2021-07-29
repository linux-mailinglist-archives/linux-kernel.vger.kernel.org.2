Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011A53D9CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhG2FBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:01:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233759AbhG2FBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:01:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C96066D;
        Wed, 28 Jul 2021 22:01:45 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEDD23F66F;
        Wed, 28 Jul 2021 22:01:41 -0700 (PDT)
Subject: Re: [PATCH v4 04/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in protnone and devmap tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-5-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <34f40e4f-c962-d141-b991-5252045be6b1@arm.com>
Date:   Thu, 29 Jul 2021 10:32:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-5-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in protnone and devmap test
> functions. After that, the unused variable @protnone in debug_vm_pgtable()
> is dropped.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 58 +++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 0fa98083f7d5..650e35656660 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -662,9 +662,9 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
>  	WARN_ON(pmd_bad(pmd));
>  }
>  
> -static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pte_special_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
>  
>  	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL))
>  		return;
> @@ -673,9 +673,9 @@ static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pte_special(pte_mkspecial(pte)));
>  }
>  
> -static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pte_protnone_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot_none);
>  
>  	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
>  		return;
> @@ -686,7 +686,7 @@ static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> @@ -697,25 +697,25 @@ static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PMD protnone\n");
> -	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> +	pmd = pmd_mkhuge(pfn_pmd(args->fixed_pmd_pfn, args->page_prot_none));
>  	WARN_ON(!pmd_protnone(pmd));
>  	WARN_ON(!pmd_present(pmd));
>  }
>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_protnone_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> -static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pte_devmap_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
>  
>  	pr_debug("Validating PTE devmap\n");
>  	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pmd_devmap_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> @@ -723,12 +723,12 @@ static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PMD devmap\n");
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
>  	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
>  }
>  
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> -static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pud_devmap_tests(struct pgtable_debug_args *args)
>  {
>  	pud_t pud;
>  
> @@ -736,20 +736,20 @@ static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PUD devmap\n");
> -	pud = pfn_pud(pfn, prot);
> +	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
>  	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
>  }
>  #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> -static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>  #else  /* CONFIG_TRANSPARENT_HUGEPAGE */
> -static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> -static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
> +static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #else
> -static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> -static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> -static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pte_devmap_tests(struct pgtable_debug_args *args) { }
> +static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
> +static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
>  
>  static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> @@ -1237,7 +1237,7 @@ static int __init debug_vm_pgtable(void)
>  	pmd_t *pmdp, *saved_pmdp, pmd;
>  	pte_t *ptep;
>  	pgtable_t saved_ptep;
> -	pgprot_t prot, protnone;
> +	pgprot_t prot;
>  	phys_addr_t paddr;
>  	unsigned long vaddr, pte_aligned, pmd_aligned;
>  	unsigned long pud_aligned;
> @@ -1257,12 +1257,6 @@ static int __init debug_vm_pgtable(void)
>  		return 1;
>  	}
>  
> -	/*
> -	 * __P000 (or even __S000) will help create page table entries with
> -	 * PROT_NONE permission as required for pxx_protnone_tests().
> -	 */
> -	protnone = __P000;
> -
>  	vma = vm_area_alloc(mm);
>  	if (!vma) {
>  		pr_err("vma allocation failed\n");
> @@ -1337,13 +1331,13 @@ static int __init debug_vm_pgtable(void)
>  	pte_savedwrite_tests(&args);
>  	pmd_savedwrite_tests(&args);
>  
> -	pte_special_tests(pte_aligned, prot);
> -	pte_protnone_tests(pte_aligned, protnone);
> -	pmd_protnone_tests(pmd_aligned, protnone);
> +	pte_special_tests(&args);
> +	pte_protnone_tests(&args);
> +	pmd_protnone_tests(&args);
>  
> -	pte_devmap_tests(pte_aligned, prot);
> -	pmd_devmap_tests(pmd_aligned, prot);
> -	pud_devmap_tests(pud_aligned, prot);
> +	pte_devmap_tests(&args);
> +	pmd_devmap_tests(&args);
> +	pud_devmap_tests(&args);
>  
>  	pte_soft_dirty_tests(pte_aligned, prot);
>  	pmd_soft_dirty_tests(pmd_aligned, prot);
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
