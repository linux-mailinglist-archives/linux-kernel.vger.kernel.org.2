Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD2387489
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347635AbhERJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:02:49 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36963 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242541AbhERJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:02:47 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fkqk01r05z9sbL;
        Tue, 18 May 2021 11:01:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LEGm9-PSOJWb; Tue, 18 May 2021 11:01:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fkqjv3lNPz9sbT;
        Tue, 18 May 2021 11:01:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C4A58B819;
        Tue, 18 May 2021 11:01:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vKD_Uu4orUkb; Tue, 18 May 2021 11:01:22 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 476D58B826;
        Tue, 18 May 2021 10:50:46 +0200 (CEST)
Subject: Re: [PATCH] mm/debug_vm_pgtable: Ensure THP availability via
 has_transparent_hugepage()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <1621325590-18199-1-git-send-email-anshuman.khandual@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8b9cb771-8fa1-4fc2-bb45-20673240edd8@csgroup.eu>
Date:   Tue, 18 May 2021 10:50:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1621325590-18199-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/05/2021 à 10:13, Anshuman Khandual a écrit :
> On certain platforms, THP support could not just be validated via the build
> option CONFIG_TRANSPARENT_HUGEPAGE. Instead has_transparent_hugepage() also
> needs to be called upon to verify THP runtime support. Otherwise the debug
> test might just run into unusable THP helpers like in the case of a 4K hash

s/might/will/

> config on powerpc platform [1]. This just moves all pfn_pmd() and pfn_pud()
> after THP runtime validation with has_transparent_hugepage() which prevents
> the mentioned problem.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=213069
> 
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

There should be a Fixes:  tag

> ---
> This applies on v5.13-rc2 after the following patches.
> 
> [1] https://lore.kernel.org/linux-mm/20210419071820.750217-1-liushixin2@huawei.com/
> [2] https://lore.kernel.org/linux-mm/20210419071820.750217-2-liushixin2@huawei.com/

I can't see any fixes: tag in those patches, and their subject line even targets them to -next. Are 
they meant to go to 5.13 and stable ?

If not, how do you coordinate between your patch that must go in 5.13 and in stable, and those two 
patches ? Shouldn't your patch go first and those other patches be rebased on top ?

> 
>   mm/debug_vm_pgtable.c | 58 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index e2f35db8ba69..6ff92c8b0a00 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -146,13 +146,14 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>   static void __init pmd_basic_tests(unsigned long pfn, int idx)
>   {
>   	pgprot_t prot = protection_map[idx];
> -	pmd_t pmd = pfn_pmd(pfn, prot);
>   	unsigned long val = idx, *ptr = &val;
> +	pmd_t pmd;
>   
>   	if (!has_transparent_hugepage())
>   		return;
>   
>   	pr_debug("Validating PMD basic (%pGv)\n", ptr);
> +	pmd = pfn_pmd(pfn, prot);
>   
>   	/*
>   	 * This test needs to be executed after the given page table entry
> @@ -232,9 +233,14 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>   
>   static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pmd_t pmd = pfn_pmd(pfn, prot);
> +	pmd_t pmd;
> +
> +	if (!has_transparent_hugepage())
> +		return;
>   
>   	pr_debug("Validating PMD leaf\n");
> +	pmd = pfn_pmd(pfn, prot);
> +
>   	/*
>   	 * PMD based THP is a leaf entry.
>   	 */
> @@ -244,12 +250,16 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>   
>   static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pmd_t pmd = pfn_pmd(pfn, prot);
> +	pmd_t pmd;
>   
>   	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
>   		return;
>   
> +	if (!has_transparent_hugepage())
> +		return;
> +
>   	pr_debug("Validating PMD saved write\n");
> +	pmd = pfn_pmd(pfn, prot);
>   	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
>   	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
>   }
> @@ -258,13 +268,14 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>   static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx)
>   {
>   	pgprot_t prot = protection_map[idx];
> -	pud_t pud = pfn_pud(pfn, prot);
>   	unsigned long val = idx, *ptr = &val;
> +	pud_t pud;
>   
>   	if (!has_transparent_hugepage())
>   		return;
>   
>   	pr_debug("Validating PUD basic (%pGv)\n", ptr);
> +	pud = pfn_pud(pfn, prot);
>   
>   	/*
>   	 * This test needs to be executed after the given page table entry
> @@ -348,9 +359,13 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>   
>   static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pud_t pud = pfn_pud(pfn, prot);
> +	pud_t pud;
> +
> +	if (!has_transparent_hugepage())
> +		return;
>   
>   	pr_debug("Validating PUD leaf\n");
> +	pud = pfn_pud(pfn, prot);
>   	/*
>   	 * PUD based THP is a leaf entry.
>   	 */
> @@ -642,12 +657,16 @@ static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pmd_t pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> +	pmd_t pmd;
>   
>   	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
>   		return;
>   
> +	if (!has_transparent_hugepage())
> +		return;
> +
>   	pr_debug("Validating PMD protnone\n");
> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>   	WARN_ON(!pmd_protnone(pmd));
>   	WARN_ON(!pmd_present(pmd));
>   }
> @@ -667,18 +686,26 @@ static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pmd_t pmd = pfn_pmd(pfn, prot);
> +	pmd_t pmd;
> +
> +	if (!has_transparent_hugepage())
> +		return;
>   
>   	pr_debug("Validating PMD devmap\n");
> +	pmd = pfn_pmd(pfn, prot);
>   	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
>   }
>   
>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>   static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pud_t pud = pfn_pud(pfn, prot);
> +	pud_t pud;
> +
> +	if (!has_transparent_hugepage())
> +		return;
>   
>   	pr_debug("Validating PUD devmap\n");
> +	pud = pfn_pud(pfn, prot);
>   	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
>   }
>   #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> @@ -721,25 +748,33 @@ static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pmd_t pmd = pfn_pmd(pfn, prot);
> +	pmd_t pmd;
>   
>   	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>   		return;
>   
> +	if (!has_transparent_hugepage())
> +		return;
> +
>   	pr_debug("Validating PMD soft dirty\n");
> +	pmd = pfn_pmd(pfn, prot);
>   	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
>   	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
>   }
>   
>   static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>   {
> -	pmd_t pmd = pfn_pmd(pfn, prot);
> +	pmd_t pmd;
>   
>   	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) ||
>   		!IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
>   		return;
>   
> +	if (!has_transparent_hugepage())
> +		return;
> +
>   	pr_debug("Validating PMD swap soft dirty\n");
> +	pmd = pfn_pmd(pfn, prot);
>   	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
>   	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
>   }
> @@ -768,6 +803,9 @@ static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
>   	swp_entry_t swp;
>   	pmd_t pmd;
>   
> +	if (!has_transparent_hugepage())
> +		return;
> +
>   	pr_debug("Validating PMD swap\n");
>   	pmd = pfn_pmd(pfn, prot);
>   	swp = __pmd_to_swp_entry(pmd);
> 
