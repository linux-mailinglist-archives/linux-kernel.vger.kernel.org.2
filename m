Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD0324B82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhBYHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:49:15 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:9101 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhBYHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:49:07 -0500
X-Originating-IP: 81.185.161.35
Received: from [192.168.43.237] (35.161.185.81.rev.sfr.net [81.185.161.35])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5F65A24000A;
        Thu, 25 Feb 2021 07:48:14 +0000 (UTC)
Subject: Re: [PATCH] riscv: Add KASAN_VMALLOC support
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nylon Chen <nylon7@andestech.com>,
        Nick Hu <nickhu@andestech.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
References: <20210225074227.3176-1-alex@ghiti.fr>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <bdef5309-03dd-6c0b-7d0c-9dd036ceae95@ghiti.fr>
Date:   Thu, 25 Feb 2021 02:48:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225074227.3176-1-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2/25/21 à 2:42 AM, Alexandre Ghiti a écrit :
> Populate the top-level of the kernel page table to implement KASAN_VMALLOC,
> lower levels are filled dynamically upon memory allocation at runtime.
> 
> Co-developed-by: Nylon Chen <nylon7@andestech.com>
> Signed-off-by: Nylon Chen <nylon7@andestech.com>
> Co-developed-by: Nick Hu <nickhu@andestech.com>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/riscv/Kconfig         |  1 +
>   arch/riscv/mm/kasan_init.c | 35 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8eadd1cbd524..3832a537c5d6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -57,6 +57,7 @@ config RISCV
>   	select HAVE_ARCH_JUMP_LABEL
>   	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>   	select HAVE_ARCH_KASAN if MMU && 64BIT
> +	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>   	select HAVE_ARCH_KGDB
>   	select HAVE_ARCH_KGDB_QXFER_PKT
>   	select HAVE_ARCH_MMAP_RND_BITS if MMU
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 719b6e4d6075..171569df4334 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -142,6 +142,31 @@ static void __init kasan_populate(void *start, void *end)
>   	memset(start, KASAN_SHADOW_INIT, end - start);
>   }
>   
> +void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
> +{
> +	unsigned long next;
> +	void *p;
> +	pgd_t *pgd_k = pgd_offset_k(vaddr);
> +
> +	do {
> +		next = pgd_addr_end(vaddr, end);
> +		if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
> +			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
> +		}
> +	} while (pgd_k++, vaddr = next, vaddr != end);
> +}
> +
> +void __init kasan_shallow_populate(void *start, void *end)
> +{
> +	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> +	unsigned long vend = PAGE_ALIGN((unsigned long)end);
> +
> +	kasan_shallow_populate_pgd(vaddr, vend);
> +
> +	local_flush_tlb_all();
> +}
> +
>   void __init kasan_init(void)
>   {
>   	phys_addr_t _start, _end;
> @@ -149,7 +174,15 @@ void __init kasan_init(void)
>   
>   	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
>   				    (void *)kasan_mem_to_shadow((void *)
> -								VMALLOC_END));
> +								VMEMMAP_END));
> +	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> +		kasan_shallow_populate(
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
> +	else
> +		kasan_populate_early_shadow(
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>   
>   	for_each_mem_range(i, &_start, &_end) {
>   		void *start = (void *)_start;
> 

Palmer, this commit should replace (if everyone agrees) Nylon and Nick's 
Commit e178d670f251 ("riscv/kasan: add KASAN_VMALLOC support") that is 
already in for-next.

Thanks,

Alex
