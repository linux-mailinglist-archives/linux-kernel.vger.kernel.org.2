Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDB3D9D00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhG2FGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:06:45 -0400
Received: from foss.arm.com ([217.140.110.172]:40758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhG2FGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:06:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126096D;
        Wed, 28 Jul 2021 22:06:42 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8460A3F66F;
        Wed, 28 Jul 2021 22:06:38 -0700 (PDT)
Subject: Re: [PATCH v4 05/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in soft_dirty and swap tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-6-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <445d4b02-c221-096f-eee0-573503350e44@arm.com>
Date:   Thu, 29 Jul 2021 10:37:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-6-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in the soft_dirty and swap test
> functions.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 48 +++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 650e35656660..bc153cad9045 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -752,9 +752,9 @@ static void __init pmd_devmap_tests(struct pgtable_debug_args *args) { }
>  static void __init pud_devmap_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
>  
> -static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
>  
>  	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>  		return;
> @@ -764,9 +764,9 @@ static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
>  }
>  
> -static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
>  
>  	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>  		return;
> @@ -777,7 +777,7 @@ static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> @@ -788,12 +788,12 @@ static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PMD soft dirty\n");
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
>  	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
>  	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
>  }
>  
> -static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> @@ -805,31 +805,29 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PMD swap soft dirty\n");
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
>  	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
>  	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
>  }
>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
> -static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> -{
> -}
> +static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args) { }
> +static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pte_swap_tests(struct pgtable_debug_args *args)
>  {
>  	swp_entry_t swp;
>  	pte_t pte;
>  
>  	pr_debug("Validating PTE swap\n");
> -	pte = pfn_pte(pfn, prot);
> +	pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
>  	swp = __pte_to_swp_entry(pte);
>  	pte = __swp_entry_to_pte(swp);
> -	WARN_ON(pfn != pte_pfn(pte));
> +	WARN_ON(args->fixed_pte_pfn != pte_pfn(pte));
>  }
>  
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> -static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pmd_swap_tests(struct pgtable_debug_args *args)
>  {
>  	swp_entry_t swp;
>  	pmd_t pmd;
> @@ -838,13 +836,13 @@ static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PMD swap\n");
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
>  	swp = __pmd_to_swp_entry(pmd);
>  	pmd = __swp_entry_to_pmd(swp);
> -	WARN_ON(pfn != pmd_pfn(pmd));
> +	WARN_ON(args->fixed_pmd_pfn != pmd_pfn(pmd));
>  }
>  #else  /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
> -static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  
>  static void __init swap_migration_tests(void)
> @@ -1339,13 +1337,13 @@ static int __init debug_vm_pgtable(void)
>  	pmd_devmap_tests(&args);
>  	pud_devmap_tests(&args);
>  
> -	pte_soft_dirty_tests(pte_aligned, prot);
> -	pmd_soft_dirty_tests(pmd_aligned, prot);
> -	pte_swap_soft_dirty_tests(pte_aligned, prot);
> -	pmd_swap_soft_dirty_tests(pmd_aligned, prot);
> +	pte_soft_dirty_tests(&args);
> +	pmd_soft_dirty_tests(&args);
> +	pte_swap_soft_dirty_tests(&args);
> +	pmd_swap_soft_dirty_tests(&args);
>  
> -	pte_swap_tests(pte_aligned, prot);
> -	pmd_swap_tests(pmd_aligned, prot);
> +	pte_swap_tests(&args);
> +	pmd_swap_tests(&args);
>  
>  	swap_migration_tests();
>  
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
