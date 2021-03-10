Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7034B333337
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCJCiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhCJChz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:37:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 18:37:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so6384494pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 18:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UzABH8OfIDY+zUaaqIGMBSk5x3QjktoUn2udOPEAyJA=;
        b=S7p9K2Sy1JxHl14DlBQp08dPZfGedwIVcjfnsSdw6cX2LLEgqbJehT2sj8P2+Vu6h4
         OH4t3QtZMqqc8s2ld63L/KZhdp75/hnq9nuZW95Lq2npqwKVZFoUN9mt3vqKmrLAcbbD
         vRvrWvXtEvTzUAy7/l8z/Ftek6NZIivu7APlEaJ/JaVPAeqyYYsVsF9ZkYW2w8b0bQ/9
         xntuxhijdbCm4s+I/92WE2ob+0w7v9unuJZyPE5kNVt/FrsqI8tcVngntTMsG8TnnePE
         glkHCO1Chq0OvX3IpZnQ2u2W6wfAJXhWhBzeVw8vJYSbXtVBtuRFIqNXOsU2HollS4D1
         REzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UzABH8OfIDY+zUaaqIGMBSk5x3QjktoUn2udOPEAyJA=;
        b=qb2p/GLi3X3E60SyIhTW5jLcGgixDzUEwmDHEohzJhuN56d9YahZjNy8EjgUg9VBoB
         hpT4c+/ot0bU3W+kliuJ4ceJuF6vUEv9LOcmTm+TM3rmiWXf5osXQZhO1LjRvxHJE3V4
         i6uwYWQax3e6zUHWtYjweGX1rNqTkZBjdmLwlF8w074NKyeuSsDkp+SwnyPn6O+MHI5P
         4orYZaMQtTGPNIZ1QTBhMVUq/I+QMX5Sz7+78P/KdJDDJE0+8rEzqz7Ukfwff0g7I8HZ
         fghVp2z9ePQjIKG0gF816I7HaXs/AjZOxdbMySYtRSA5Wc8nbUKRU+7CyvCDuyMSoZqX
         1nCg==
X-Gm-Message-State: AOAM532sZIs/QdjtPc2f0prSydzetMugExjvOQIDSTlcCVphVKvb9TYj
        NjL1JK305c6kXQq9JmlJPhybSg==
X-Google-Smtp-Source: ABdhPJxuo7XbxYy02Dmd4tSy6hXdRwotPNq7rhbVP4gZ7CcP78+gYq8feEuqDD8nOpRdsuTnU06P0A==
X-Received: by 2002:a17:902:9001:b029:e6:2e56:8b0d with SMTP id a1-20020a1709029001b02900e62e568b0dmr1038347plp.31.1615343863808;
        Tue, 09 Mar 2021 18:37:43 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s194sm14383714pfs.57.2021.03.09.18.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:37:43 -0800 (PST)
Date:   Tue, 09 Mar 2021 18:37:43 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 18:37:24 PST (-0800)
Subject:     Re: [PATCH v2] riscv: Improve KASAN_VMALLOC support
In-Reply-To: <20210226180154.31533-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        nylon7@andestech.com, nickhu@andestech.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-a1ab9e7a-d992-4432-badc-02cc788b1ace@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 10:01:54 PST (-0800), alex@ghiti.fr wrote:
> When KASAN vmalloc region is populated, there is no userspace process and
> the page table in use is swapper_pg_dir, so there is no need to read
> SATP. Then we can use the same scheme used by kasan_populate_p*d
> functions to go through the page table, which harmonizes the code.
>
> In addition, make use of set_pgd that goes through all unused page table
> levels, contrary to p*d_populate functions, which makes this function work
> whatever the number of page table levels.
>
> And finally, make sure the writes to swapper_pg_dir are visible using
> an sfence.vma.

So I think this is actually a bug: without the fence we could get a 
kasan-related fault at any point (as the mappings might not be visible yet), 
and if we get one when inside do_page_fault() (or while holding a lock it 
wants) we'll end up deadlocking against ourselves.  That'll probably never 
happen in practice, but it'd still be good to get the fence onto fixes.  The 
rest are cleanups, they're for for-next (and should probably be part of your 
sv48 series, if you need to re-spin it -- I'll look at that next).

LMK if you want to split this up, or if you want me to do it.  Either way,

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>
> Changes in v2:
> - Quiet kernel test robot warnings about missing prototypes by declaring
>   the introduced functions as static.
>
>  arch/riscv/mm/kasan_init.c | 61 +++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 41 deletions(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index e3d91f334b57..aaa3bdc0ffc0 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -11,18 +11,6 @@
>  #include <asm/fixmap.h>
>  #include <asm/pgalloc.h>
>
> -static __init void *early_alloc(size_t size, int node)
> -{
> -	void *ptr = memblock_alloc_try_nid(size, size,
> -		__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
> -
> -	if (!ptr)
> -		panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d from=%llx\n",
> -			__func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
> -
> -	return ptr;
> -}
> -
>  extern pgd_t early_pg_dir[PTRS_PER_PGD];
>  asmlinkage void __init kasan_early_init(void)
>  {
> @@ -155,38 +143,29 @@ static void __init kasan_populate(void *start, void *end)
>  	memset(start, KASAN_SHADOW_INIT, end - start);
>  }
>
> -void __init kasan_shallow_populate(void *start, void *end)
> +static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
>  {
> -	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> -	unsigned long vend = PAGE_ALIGN((unsigned long)end);
> -	unsigned long pfn;
> -	int index;
> +	unsigned long next;
>  	void *p;
> -	pud_t *pud_dir, *pud_k;
> -	pgd_t *pgd_dir, *pgd_k;
> -	p4d_t *p4d_dir, *p4d_k;
> -
> -	while (vaddr < vend) {
> -		index = pgd_index(vaddr);
> -		pfn = csr_read(CSR_SATP) & SATP_PPN;
> -		pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
> -		pgd_k = init_mm.pgd + index;
> -		pgd_dir = pgd_offset_k(vaddr);
> -		set_pgd(pgd_dir, *pgd_k);
> -
> -		p4d_dir = p4d_offset(pgd_dir, vaddr);
> -		p4d_k  = p4d_offset(pgd_k, vaddr);
> -
> -		vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
> -		pud_dir = pud_offset(p4d_dir, vaddr);
> -		pud_k = pud_offset(p4d_k, vaddr);
> -
> -		if (pud_present(*pud_dir)) {
> -			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> -			pud_populate(&init_mm, pud_dir, p);
> +	pgd_t *pgd_k = pgd_offset_k(vaddr);
> +
> +	do {
> +		next = pgd_addr_end(vaddr, end);
> +		if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
> +			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
>  		}
> -		vaddr += PAGE_SIZE;
> -	}
> +	} while (pgd_k++, vaddr = next, vaddr != end);
> +}
> +
> +static void __init kasan_shallow_populate(void *start, void *end)
> +{
> +	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> +	unsigned long vend = PAGE_ALIGN((unsigned long)end);
> +
> +	kasan_shallow_populate_pgd(vaddr, vend);
> +
> +	local_flush_tlb_all();
>  }
>
>  void __init kasan_init(void)
