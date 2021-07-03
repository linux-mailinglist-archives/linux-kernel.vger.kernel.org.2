Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102FA3BA66E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 02:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhGCAdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 20:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230017AbhGCAc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 20:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625272226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=triFGY+73M5BFO3B7XEpDoQJqmQeUSvePcDF+RZJGmw=;
        b=D0rx8Uf9Lrl0ZxzKFbf/XpgVxdW04k6VlBDS2cqhxWmYVju0/5SzFykrDW7rBRiY/kna33
        +j0rvZ8zVn7FP61h3Zf/Fvswa2GygqXiEWeMEKUuSgJBLJJ+dShi87CKBZIQ/+7U+ASOzK
        kcj1m7F2AU/vktmTzWKeWoDoZvBxa/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-ERmJkii2OZ6llbfVImClqA-1; Fri, 02 Jul 2021 20:30:25 -0400
X-MC-Unique: ERmJkii2OZ6llbfVImClqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1867110C1ADC;
        Sat,  3 Jul 2021 00:30:24 +0000 (UTC)
Received: from [10.64.54.119] (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E255D6D3;
        Sat,  3 Jul 2021 00:30:21 +0000 (UTC)
Subject: Re: [PATCH] mm/debug_vm_pgtable: Fix corrupted PG_arch_1 by
 set_pmd_at()
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20210702103225.51448-1-gshan@redhat.com>
Message-ID: <0911a77c-efa6-99fe-ec1a-4b968ad925bf@redhat.com>
Date:   Sat, 3 Jul 2021 10:30:18 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210702103225.51448-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 8:32 PM, Gavin Shan wrote:
> There are two addresses selected: random virtual address and physical
> address corresponding to kernel symbol @start_kernel. During the PMD
> tests in pmd_advanced_tests(), the physical address is aligned down
> to the starting address of the huge page, whose size is 512MB on ARM64
> when we have 64KB base page size. After that, set_pmd_at() is called
> to populate the PMD entry. PG_arch_1, PG_dcache_clean on ARM64, is
> set to the page flags. Unforunately, the page, corresponding to the
> starting address of the huge page could be owned by buddy. It means
> PG_arch_1 can be unconditionally set to page owned by buddy.
> 
> Afterwards, the page with PG_arch_1 set is fetched from buddy's free
> area list, but fails the checking. It leads to the following warning
> on ARM64:
> 
>     BUG: Bad page state in process memhog  pfn:08000
>     page:0000000015c0a628 refcount:0 mapcount:0 \
>          mapping:0000000000000000 index:0x1 pfn:0x8000
>     flags: 0x7ffff8000000800(arch_1|node=0|zone=0|lastcpupid=0xfffff)
>     raw: 07ffff8000000800 dead000000000100 dead000000000122 0000000000000000
>     raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>     page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag(s) set
> 
> This fixes the issue by calling flush_dcache_page() after each call
> to set_{pud, pmd, pte}_at() because PG_arch_1 isn't needed in any case.
> 
> Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")
> Cc: stable@vger.kernel.org # v5.9+
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   mm/debug_vm_pgtable.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 92bfc37300df..7dedf6c6dd25 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -29,6 +29,8 @@
>   #include <linux/start_kernel.h>
>   #include <linux/sched/mm.h>
>   #include <linux/io.h>
> +
> +#include <asm/cacheflush.h>
>   #include <asm/pgalloc.h>
>   #include <asm/tlbflush.h>
>   
> @@ -91,6 +93,7 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>   				      unsigned long pfn, unsigned long vaddr,
>   				      pgprot_t prot)
>   {
> +	struct page *page = pfn_to_page(pfn);
>   	pte_t pte = pfn_pte(pfn, prot);
>   
>   	/*
> @@ -102,6 +105,7 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>   	pr_debug("Validating PTE advanced\n");
>   	pte = pfn_pte(pfn, prot);
>   	set_pte_at(mm, vaddr, ptep, pte);
> +	flush_dcache_page(page);
>   	ptep_set_wrprotect(mm, vaddr, ptep);
>   	pte = ptep_get(ptep);
>   	WARN_ON(pte_write(pte));
> @@ -113,6 +117,7 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>   	pte = pte_wrprotect(pte);
>   	pte = pte_mkclean(pte);
>   	set_pte_at(mm, vaddr, ptep, pte);
> +	flush_dcache_page(page);
>   	pte = pte_mkwrite(pte);
>   	pte = pte_mkdirty(pte);
>   	ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
> @@ -125,6 +130,7 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>   	pte = pfn_pte(pfn, prot);
>   	pte = pte_mkyoung(pte);
>   	set_pte_at(mm, vaddr, ptep, pte);
> +	flush_dcache_page(page);
>   	ptep_test_and_clear_young(vma, vaddr, ptep);
>   	pte = ptep_get(ptep);
>   	WARN_ON(pte_young(pte));
> @@ -186,6 +192,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>   				      unsigned long pfn, unsigned long vaddr,
>   				      pgprot_t prot, pgtable_t pgtable)
>   {
> +	struct page *page = pfn_to_page(pfn);
>   	pmd_t pmd;
>   
>   	if (!has_transparent_hugepage())
> @@ -199,6 +206,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>   
>   	pmd = pfn_pmd(pfn, prot);
>   	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	flush_dcache_page(page);
>   	pmdp_set_wrprotect(mm, vaddr, pmdp);
>   	pmd = READ_ONCE(*pmdp);
>   	WARN_ON(pmd_write(pmd));
> @@ -210,6 +218,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>   	pmd = pmd_wrprotect(pmd);
>   	pmd = pmd_mkclean(pmd);
>   	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	flush_dcache_page(page);
>   	pmd = pmd_mkwrite(pmd);
>   	pmd = pmd_mkdirty(pmd);
>   	pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
> @@ -222,6 +231,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>   	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>   	pmd = pmd_mkyoung(pmd);
>   	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	flush_dcache_page(page);
>   	pmdp_test_and_clear_young(vma, vaddr, pmdp);
>   	pmd = READ_ONCE(*pmdp);
>   	WARN_ON(pmd_young(pmd));
> @@ -334,6 +344,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>   				      unsigned long pfn, unsigned long vaddr,
>   				      pgprot_t prot)
>   {
> +	struct page *page = pfn_to_page(page);
>   	pud_t pud;
>   

Typo here. @page should be replaced by @pfn. I'm holding to post v2 until I
receive comments on v1.

>   	if (!has_transparent_hugepage())
> @@ -345,6 +356,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>   
>   	pud = pfn_pud(pfn, prot);
>   	set_pud_at(mm, vaddr, pudp, pud);
> +	flush_dcache_page(page);
>   	pudp_set_wrprotect(mm, vaddr, pudp);
>   	pud = READ_ONCE(*pudp);
>   	WARN_ON(pud_write(pud));
> @@ -358,6 +370,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>   	pud = pud_wrprotect(pud);
>   	pud = pud_mkclean(pud);
>   	set_pud_at(mm, vaddr, pudp, pud);
> +	flush_dcache_page(page);
>   	pud = pud_mkwrite(pud);
>   	pud = pud_mkdirty(pud);
>   	pudp_set_access_flags(vma, vaddr, pudp, pud, 1);
> @@ -373,6 +386,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>   	pud = pfn_pud(pfn, prot);
>   	pud = pud_mkyoung(pud);
>   	set_pud_at(mm, vaddr, pudp, pud);
> +	flush_dcache_page(page);
>   	pudp_test_and_clear_young(vma, vaddr, pudp);
>   	pud = READ_ONCE(*pudp);
>   	WARN_ON(pud_young(pud));
> @@ -604,6 +618,7 @@ static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>   				   unsigned long pfn, unsigned long vaddr,
>   				   pgprot_t prot)
>   {
> +	struct page *page = pfn_to_page(pfn);
>   	pte_t pte = pfn_pte(pfn, prot);
>   
>   	pr_debug("Validating PTE clear\n");
> @@ -611,6 +626,7 @@ static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>   	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>   #endif
>   	set_pte_at(mm, vaddr, ptep, pte);
> +	flush_dcache_page(page);
>   	barrier();
>   	pte_clear(mm, vaddr, ptep);
>   	pte = ptep_get(ptep);
> 

Thanks,
Gavin

