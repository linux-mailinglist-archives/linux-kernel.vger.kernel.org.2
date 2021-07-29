Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC56E3D9D72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhG2GEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:04:20 -0400
Received: from foss.arm.com ([217.140.110.172]:41108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234093AbhG2GET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:04:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FA026D;
        Wed, 28 Jul 2021 23:04:16 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 835973F66F;
        Wed, 28 Jul 2021 23:04:12 -0700 (PDT)
Subject: Re: [PATCH v4 12/12] mm/debug_vm_pgtable: Fix corrupted page flag
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-13-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ed831069-fc24-0077-294d-256f6eae6a1f@arm.com>
Date:   Thu, 29 Jul 2021 11:35:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-13-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:44 AM, Gavin Shan wrote:
> In page table entry modifying tests, set_xxx_at() are used to populate
> the page table entries. On ARM64, PG_arch_1 (PG_dcache_clean) flag is
> set to the target page flag if execution permission is given. The logic
> exits since commit 4f04d8f00545 ("arm64: MMU definitions"). The page
> flag is kept when the page is free'd to buddy's free area list. However,
> it will trigger page checking failure when it's pulled from the buddy's
> free area list, as the following warning messages indicate.
> 
>    BUG: Bad page state in process memhog  pfn:08000
>    page:0000000015c0a628 refcount:0 mapcount:0 \
>         mapping:0000000000000000 index:0x1 pfn:0x8000
>    flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>    raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>    raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>    page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
> 
> This fixes the issue by clearing PG_arch_1 through flush_dcache_page()
> after set_xxx_at() is called. For architectures other than ARM64, the
> unexpected overhead of cache flushing is acceptable.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 55 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 162ff6329f7b..d2c2d23e542e 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -29,6 +29,8 @@
>  #include <linux/start_kernel.h>
>  #include <linux/sched/mm.h>
>  #include <linux/io.h>
> +
> +#include <asm/cacheflush.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  
> @@ -119,19 +121,28 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>  
>  static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>  {
> +	struct page *page;
>  	pte_t pte;
>  
>  	/*
>  	 * Architectures optimize set_pte_at by avoiding TLB flush.
>  	 * This requires set_pte_at to be not used to update an
>  	 * existing pte entry. Clear pte before we do set_pte_at
> +	 *
> +	 * flush_dcache_page() is called after set_pte_at() to clear
> +	 * PG_arch_1 for the page on ARM64. The page flag isn't cleared
> +	 * when it's released and page allocation check will fail when
> +	 * the page is allocated again. For architectures other than ARM64,
> +	 * the unexpected overhead of cache flushing is acceptable.
>  	 */
> -	if (args->pte_pfn == ULONG_MAX)
> +	page = (args->pte_pfn != ULONG_MAX) ? pfn_to_page(args->pte_pfn) : NULL;
> +	if (!page)
>  		return;
>  
>  	pr_debug("Validating PTE advanced\n");
>  	pte = pfn_pte(args->pte_pfn, args->page_prot);
>  	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> +	flush_dcache_page(page);
>  	ptep_set_wrprotect(args->mm, args->vaddr, args->ptep);
>  	pte = ptep_get(args->ptep);
>  	WARN_ON(pte_write(pte));
> @@ -143,6 +154,7 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>  	pte = pte_wrprotect(pte);
>  	pte = pte_mkclean(pte);
>  	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> +	flush_dcache_page(page);
>  	pte = pte_mkwrite(pte);
>  	pte = pte_mkdirty(pte);
>  	ptep_set_access_flags(args->vma, args->vaddr, args->ptep, pte, 1);
> @@ -155,6 +167,7 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>  	pte = pfn_pte(args->pte_pfn, args->page_prot);
>  	pte = pte_mkyoung(pte);
>  	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> +	flush_dcache_page(page);
>  	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
>  	pte = ptep_get(args->ptep);
>  	WARN_ON(pte_young(pte));
> @@ -213,15 +226,24 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>  
>  static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
>  {
> +	struct page *page;
>  	pmd_t pmd;
>  	unsigned long vaddr = args->vaddr;
>  
>  	if (!has_transparent_hugepage())
>  		return;
>  
> -	if (args->pmd_pfn == ULONG_MAX)
> +	page = (args->pmd_pfn != ULONG_MAX) ? pfn_to_page(args->pmd_pfn) : NULL;
> +	if (!page)
>  		return;
>  
> +	/*
> +	 * flush_dcache_page() is called after set_pmd_at() to clear
> +	 * PG_arch_1 for the page on ARM64. The page flag isn't cleared
> +	 * when it's released and page allocation check will fail when
> +	 * the page is allocated again. For architectures other than ARM64,
> +	 * the unexpected overhead of cache flushing is acceptable.
> +	 */
>  	pr_debug("Validating PMD advanced\n");
>  	/* Align the address wrt HPAGE_PMD_SIZE */
>  	vaddr &= HPAGE_PMD_MASK;
> @@ -230,6 +252,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
>  
>  	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
>  	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
> +	flush_dcache_page(page);
>  	pmdp_set_wrprotect(args->mm, vaddr, args->pmdp);
>  	pmd = READ_ONCE(*args->pmdp);
>  	WARN_ON(pmd_write(pmd));
> @@ -241,6 +264,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
>  	pmd = pmd_wrprotect(pmd);
>  	pmd = pmd_mkclean(pmd);
>  	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
> +	flush_dcache_page(page);
>  	pmd = pmd_mkwrite(pmd);
>  	pmd = pmd_mkdirty(pmd);
>  	pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
> @@ -253,6 +277,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
>  	pmd = pmd_mkhuge(pfn_pmd(args->pmd_pfn, args->page_prot));
>  	pmd = pmd_mkyoung(pmd);
>  	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
> +	flush_dcache_page(page);
>  	pmdp_test_and_clear_young(args->vma, vaddr, args->pmdp);
>  	pmd = READ_ONCE(*args->pmdp);
>  	WARN_ON(pmd_young(pmd));
> @@ -339,21 +364,31 @@ static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
>  
>  static void __init pud_advanced_tests(struct pgtable_debug_args *args)
>  {
> +	struct page *page;
>  	unsigned long vaddr = args->vaddr;
>  	pud_t pud;
>  
>  	if (!has_transparent_hugepage())
>  		return;
>  
> -	if (args->pud_pfn == ULONG_MAX)
> +	page = (args->pud_pfn != ULONG_MAX) ? pfn_to_page(args->pud_pfn) : NULL;
> +	if (!page)
>  		return;
>  
> +	/*
> +	 * flush_dcache_page() is called after set_pud_at() to clear
> +	 * PG_arch_1 for the page on ARM64. The page flag isn't cleared
> +	 * when it's released and page allocation check will fail when
> +	 * the page is allocated again. For architectures other than ARM64,
> +	 * the unexpected overhead of cache flushing is acceptable.
> +	 */
>  	pr_debug("Validating PUD advanced\n");
>  	/* Align the address wrt HPAGE_PUD_SIZE */
>  	vaddr &= HPAGE_PUD_MASK;
>  
>  	pud = pfn_pud(args->pud_pfn, args->page_prot);
>  	set_pud_at(args->mm, vaddr, args->pudp, pud);
> +	flush_dcache_page(page);
>  	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
>  	pud = READ_ONCE(*args->pudp);
>  	WARN_ON(pud_write(pud));
> @@ -367,6 +402,7 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
>  	pud = pud_wrprotect(pud);
>  	pud = pud_mkclean(pud);
>  	set_pud_at(args->mm, vaddr, args->pudp, pud);
> +	flush_dcache_page(page);
>  	pud = pud_mkwrite(pud);
>  	pud = pud_mkdirty(pud);
>  	pudp_set_access_flags(args->vma, vaddr, args->pudp, pud, 1);
> @@ -382,6 +418,7 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
>  	pud = pfn_pud(args->pud_pfn, args->page_prot);
>  	pud = pud_mkyoung(pud);
>  	set_pud_at(args->mm, vaddr, args->pudp, pud);
> +	flush_dcache_page(page);
>  	pudp_test_and_clear_young(args->vma, vaddr, args->pudp);
>  	pud = READ_ONCE(*args->pudp);
>  	WARN_ON(pud_young(pud));
> @@ -594,16 +631,26 @@ static void __init pgd_populate_tests(struct pgtable_debug_args *args) { }
>  
>  static void __init pte_clear_tests(struct pgtable_debug_args *args)
>  {
> +	struct page *page;
>  	pte_t pte = pfn_pte(args->pte_pfn, args->page_prot);
>  
> -	if (args->pte_pfn == ULONG_MAX)
> +	page = (args->pte_pfn != ULONG_MAX) ? pfn_to_page(args->pte_pfn) : NULL;
> +	if (!page)
>  		return;
>  
> +	/*
> +	 * flush_dcache_page() is called after set_pte_at() to clear
> +	 * PG_arch_1 for the page on ARM64. The page flag isn't cleared
> +	 * when it's released and page allocation check will fail when
> +	 * the page is allocated again. For architectures other than ARM64,
> +	 * the unexpected overhead of cache flushing is acceptable.
> +	 */
>  	pr_debug("Validating PTE clear\n");
>  #ifndef CONFIG_RISCV
>  	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>  #endif
>  	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> +	flush_dcache_page(page);
>  	barrier();
>  	pte_clear(args->mm, args->vaddr, args->ptep);
>  	pte = ptep_get(args->ptep);
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
