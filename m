Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37A334E089
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhC3FGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC3FGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:06:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:06:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so8825678pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vUHPJZsD1HsjvzEusIUyaB/CqNpQTfUUNzEFAb1GBPs=;
        b=vm+D9PSKU8aQKBqxe6YQ141KlvTTIjr63Fd9alM3Q9w1/2LKhteHaw24l18heIURO2
         EN6yJsgNvqtpfv7EygPqr09vmWhyQbyouVynYEg5UvO+SAA2du4Oh2ya/SP1gXJYcIzL
         qdYzhA/iBdbFsqAI/n0FUDaq4Rdx2EpP/12rkR13CC85fEaA+B/cZ7jHsxeoWNnUm656
         e4vVpeKLGRPpOSqZMa1e/4wpNNzmD+AAlOHhxOA22s+suq+WQaEGsu138/rXFwbsQr1T
         sxJQLgLhVK2OlU+YAxNxG/A65TqcuqMwDCfVnSluJEgGJ8TEftG6W+/Ve2Ev0ojcFbrF
         oFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vUHPJZsD1HsjvzEusIUyaB/CqNpQTfUUNzEFAb1GBPs=;
        b=diFd9blDkp+a6RS10ljZnN01ttzboD3hlwZHKDWQLyvL6APahjPg4/4cLEhtSYluXj
         XdqYokK4SdBOWaRbqnpViLioLdncyd48anZuyOHhZzdUdzCAEsgYGjR2whUatJ1pWAF0
         OGMNpVjxkUi8V3b3wzlx8EjW4kbOqtDAsZxJ1nAtccswpxPIbszgj3a7AORshcsbSPnJ
         5T7VpKC6QkLf6GtgsdOEFuQr9uAQ/uxLwpeGmaEVuc4UyuM1KA+QV9uk/2dzlscdRn9j
         zva3hr13hs3w15v/u3HCOBJMjtH/Ps8DH90yeNhURGTfeJnLeVcGKFx+09VAxt/6K0JV
         41ww==
X-Gm-Message-State: AOAM531ReFkof9APV4e5tzjXsqOHfXvXkVyirP0/Rn94imTxosEkl/Dm
        y5Ul2uj3K/rtoyLaQoW/z9wXlA==
X-Google-Smtp-Source: ABdhPJzYxXi/P5lX8ODVPPjDHxBhKCBze39ZjqDO/zk+5AE3E8Znqti+eW8cxjlge5xZhIYdsu/5Ig==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr2671264pjb.46.1617080790431;
        Mon, 29 Mar 2021 22:06:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i14sm1341926pjh.17.2021.03.29.22.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 22:06:30 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:06:30 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Mar 2021 21:47:37 PDT (-0700)
Subject:     Re: [PATCH v3 2/2] riscv: Cleanup KASAN_VMALLOC support
In-Reply-To: <20210313084505.16132-3-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        nylon7@andestech.com, nickhu@andestech.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-1a492a0c-049e-495e-8258-7513a4fa967a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2021 00:45:05 PST (-0800), alex@ghiti.fr wrote:
> When KASAN vmalloc region is populated, there is no userspace process and
> the page table in use is swapper_pg_dir, so there is no need to read
> SATP. Then we can use the same scheme used by kasan_populate_p*d
> functions to go through the page table, which harmonizes the code.
>
> In addition, make use of set_pgd that goes through all unused page table
> levels, contrary to p*d_populate functions, which makes this function work
> whatever the number of page table levels.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/mm/kasan_init.c | 59 ++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 41 deletions(-)
>
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 57bf4ae09361..c16178918239 100644
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
> @@ -155,38 +143,27 @@ static void __init kasan_populate(void *start, void *end)
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
>
>  	local_flush_tlb_all();
>  }

Thanks, this is on for-next.
