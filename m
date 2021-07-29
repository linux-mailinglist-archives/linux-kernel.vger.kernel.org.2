Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B933D9CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhG2E7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:59:39 -0400
Received: from foss.arm.com ([217.140.110.172]:40700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233607AbhG2E7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:59:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8E716D;
        Wed, 28 Jul 2021 21:59:35 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08CBD3F66F;
        Wed, 28 Jul 2021 21:59:31 -0700 (PDT)
Subject: Re: [PATCH v4 03/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in leaf and savewrite tests
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-4-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0c62a03f-ff5b-03c3-bf2d-18875ee84755@arm.com>
Date:   Thu, 29 Jul 2021 10:30:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-4-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> This uses struct pgtable_debug_args in the leaf and savewrite test
> functions.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 8498aa180ebc..0fa98083f7d5 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -161,9 +161,9 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>  	WARN_ON(pte_young(pte));
>  }
>  
> -static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot_none);
>  
>  	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
>  		return;
> @@ -262,7 +262,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>  	pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
>  }
>  
> -static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> @@ -270,7 +270,7 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PMD leaf\n");
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot);
>  
>  	/*
>  	 * PMD based THP is a leaf entry.
> @@ -279,7 +279,7 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pmd_leaf(pmd));
>  }
>  
> -static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args)
>  {
>  	pmd_t pmd;
>  
> @@ -290,7 +290,7 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PMD saved write\n");
> -	pmd = pfn_pmd(pfn, prot);
> +	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot_none);
>  	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
>  	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
>  }
> @@ -388,7 +388,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  	pudp_huge_get_and_clear(mm, vaddr, pudp);
>  }
>  
> -static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
> +static void __init pud_leaf_tests(struct pgtable_debug_args *args)
>  {
>  	pud_t pud;
>  
> @@ -396,7 +396,7 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>  		return;
>  
>  	pr_debug("Validating PUD leaf\n");
> -	pud = pfn_pud(pfn, prot);
> +	pud = pfn_pud(args->fixed_pud_pfn, args->page_prot);
>  	/*
>  	 * PUD based THP is a leaf entry.
>  	 */
> @@ -411,7 +411,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  				      pgprot_t prot)
>  {
>  }
> -static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>  static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
> @@ -428,9 +428,9 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  				      pgprot_t prot)
>  {
>  }
> -static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> -static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> -static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_leaf_tests(struct pgtable_debug_args *args) { }
> +static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
> +static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> @@ -1331,11 +1331,11 @@ static int __init debug_vm_pgtable(void)
>  	p4d_basic_tests(&args);
>  	pgd_basic_tests(&args);
>  
> -	pmd_leaf_tests(pmd_aligned, prot);
> -	pud_leaf_tests(pud_aligned, prot);
> +	pmd_leaf_tests(&args);
> +	pud_leaf_tests(&args);
>  
> -	pte_savedwrite_tests(pte_aligned, protnone);
> -	pmd_savedwrite_tests(pmd_aligned, protnone);
> +	pte_savedwrite_tests(&args);
> +	pmd_savedwrite_tests(&args);
>  
>  	pte_special_tests(pte_aligned, prot);
>  	pte_protnone_tests(pte_aligned, protnone);
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
