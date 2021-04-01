Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C87351BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbhDASKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:10:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236685AbhDARzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B72015DB;
        Thu,  1 Apr 2021 08:05:06 -0700 (PDT)
Received: from [10.163.68.23] (unknown [10.163.68.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D7083F719;
        Thu,  1 Apr 2021 08:05:04 -0700 (PDT)
Subject: Re: [PATCH -next 2/3] mm/debug_vm_pgtable: Move {pmd/pud}_huge_tests
 out of CONFIG_TRANSPARENT_HUGEPAGE
To:     Shixin Liu <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210401022315.2911967-1-liushixin2@huawei.com>
 <20210401022315.2911967-2-liushixin2@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e025c6e2-d7a8-1e5b-5bd3-4695670af58e@arm.com>
Date:   Thu, 1 Apr 2021 20:35:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401022315.2911967-2-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/21 7:53 AM, Shixin Liu wrote:
> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge is not depend on THP.

s/is not depend/are not dependent/

> But now if we want to test these functions, we have to enable THP. So move
> {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE.

Please drop the second sentence here.

> 
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  mm/debug_vm_pgtable.c | 91 +++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 52 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index a5c71a94e804..c379bbe42c2a 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -242,29 +242,6 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pmd_leaf(pmd));
>  }
>  
> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
> -{
> -	pmd_t pmd;
> -
> -	if (!arch_vmap_pmd_supported(prot))
> -		return;
> -
> -	pr_debug("Validating PMD huge\n");
> -	/*
> -	 * X86 defined pmd_set_huge() verifies that the given
> -	 * PMD is not a populated non-leaf entry.
> -	 */
> -	WRITE_ONCE(*pmdp, __pmd(0));
> -	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
> -	WARN_ON(!pmd_clear_huge(pmdp));
> -	pmd = READ_ONCE(*pmdp);
> -	WARN_ON(!pmd_none(pmd));
> -}
> -#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
> -#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> -
>  static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>  {
>  	pmd_t pmd = pfn_pmd(pfn, prot);
> @@ -379,30 +356,6 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>  	pud = pud_mkhuge(pud);
>  	WARN_ON(!pud_leaf(pud));
>  }
> -
> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
> -{
> -	pud_t pud;
> -
> -	if (!arch_vmap_pud_supported(prot))
> -		return;
> -
> -	pr_debug("Validating PUD huge\n");
> -	/*
> -	 * X86 defined pud_set_huge() verifies that the given
> -	 * PUD is not a populated non-leaf entry.
> -	 */
> -	WRITE_ONCE(*pudp, __pud(0));
> -	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
> -	WARN_ON(!pud_clear_huge(pudp));
> -	pud = READ_ONCE(*pudp);
> -	WARN_ON(!pud_none(pud));
> -}
> -#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
> -#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> -
>  #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>  static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
>  static void __init pud_advanced_tests(struct mm_struct *mm,
> @@ -412,9 +365,6 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  {
>  }
>  static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
> -{
> -}
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>  static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
> @@ -433,14 +383,51 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  }
>  static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>  static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>  {
> +	pmd_t pmd;
> +
> +	if (!arch_vmap_pmd_supported(prot))
> +		return;
> +
> +	pr_debug("Validating PMD huge\n");
> +	/*
> +	 * X86 defined pmd_set_huge() verifies that the given
> +	 * PMD is not a populated non-leaf entry.
> +	 */
> +	WRITE_ONCE(*pmdp, __pmd(0));
> +	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
> +	WARN_ON(!pmd_clear_huge(pmdp));
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(!pmd_none(pmd));
>  }
> +
>  static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>  {
> +	pud_t pud;
> +
> +	if (!arch_vmap_pud_supported(prot))
> +		return;
> +
> +	pr_debug("Validating PUD huge\n");
> +	/*
> +	 * X86 defined pud_set_huge() verifies that the given
> +	 * PUD is not a populated non-leaf entry.
> +	 */
> +	WRITE_ONCE(*pudp, __pud(0));
> +	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
> +	WARN_ON(!pud_clear_huge(pudp));
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(!pud_none(pud));
>  }
> -static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
> +#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
>  static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
>  {
>

This overall does make sense. Will further look into this but later on.
