Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7935932F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhDIDkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:40:51 -0400
Received: from foss.arm.com ([217.140.110.172]:40478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhDIDkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:40:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7192BD6E;
        Thu,  8 Apr 2021 20:40:36 -0700 (PDT)
Received: from [10.163.71.121] (unknown [10.163.71.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E883F792;
        Thu,  8 Apr 2021 20:40:34 -0700 (PDT)
Subject: Re: [PATCH -next v2 2/2] mm/debug_vm_pgtable: Remove redundant
 pfn_{pmd/pte}() and fix one comment mistake
To:     Shixin Liu <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210406044900.2178705-1-liushixin2@huawei.com>
 <20210406044900.2178705-2-liushixin2@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <530ba8dc-c35d-7b64-91c5-041d2bac661d@arm.com>
Date:   Fri, 9 Apr 2021 09:11:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406044900.2178705-2-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/21 10:19 AM, Shixin Liu wrote:
> v1->v2:
> Remove redundant pfn_pte() and fold two patch to one.

Change log should always be after the '---' below the SOB statement for git
am to ignore them. Please avoid adding them in the commit messages.

> 
> Remove redundant pfn_{pmd/pte}() and fix one comment mistake.
> 
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  mm/debug_vm_pgtable.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index d3cf178621d9..e2f35db8ba69 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -91,7 +91,7 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>  				      unsigned long pfn, unsigned long vaddr,
>  				      pgprot_t prot)
>  {
> -	pte_t pte = pfn_pte(pfn, prot);
> +	pte_t pte;
>  

Right.

>  	/*
>  	 * Architectures optimize set_pte_at by avoiding TLB flush.
> @@ -185,7 +185,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>  				      unsigned long pfn, unsigned long vaddr,
>  				      pgprot_t prot, pgtable_t pgtable)
>  {
> -	pmd_t pmd = pfn_pmd(pfn, prot);
> +	pmd_t pmd;


Right.

>  
>  	if (!has_transparent_hugepage())
>  		return;
> @@ -300,7 +300,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  				      unsigned long pfn, unsigned long vaddr,
>  				      pgprot_t prot)
>  {
> -	pud_t pud = pfn_pud(pfn, prot);
> +	pud_t pud;
>  
>  	if (!has_transparent_hugepage())
>  		return;
> @@ -309,6 +309,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>  	/* Align the address wrt HPAGE_PUD_SIZE */
>  	vaddr = (vaddr & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE;
>  
> +	pud = pfn_pud(pfn, prot);

Is this change intended to make pud_advanced_tests() similar other
advanced tests ? Please update the commit message as well.

>  	set_pud_at(mm, vaddr, pudp, pud);
>  	pudp_set_wrprotect(mm, vaddr, pudp);
>  	pud = READ_ONCE(*pudp);
> @@ -742,12 +743,12 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
>  	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
>  }
> -#else  /* !CONFIG_ARCH_HAS_PTE_DEVMAP */
> +#else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>  static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
>  static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>  {
>  }
> -#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
>  {
> 
With changes to the commit message as suggested earlier.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
