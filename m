Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA43D441F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhGXARi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhGXARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:17:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA1C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mt6so4596831pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yegDLmukDQ2JB2JCLLriIkxE39W69jFwF0gijUvKoJQ=;
        b=UM9VFt1ES2LcfrgrnKsG91iO7iaf+jMeIpvH309u+n00IMhlXncu4w2+BKUHRzGuW/
         RzSjMkTF8DwnZdkjER+3lt+SVuekYLwoSP+4Byq3CzRATmIj6xWriBfpM+zltxwO5yn/
         3kQ3q96GIs+oJ7geZ4roamYniXxpo1n1aGS8CMXfPqMXlvpIrNgcpJn8rPCTESZ62olK
         p+piPu/eQsndv+hSbzdTq8M9mkopbBYfCKmZNDx1Ca8GRUduY+BKVQ4TVkXQ9YRHP1c/
         Aab968IMEOnlPTEEeEoIWBqX5hB2CZBr72IZSDLKsxWFjEvFVMHxnNzdHYLTI/HU4Q90
         uhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yegDLmukDQ2JB2JCLLriIkxE39W69jFwF0gijUvKoJQ=;
        b=p2IyS4YBT0RHd1bBEAFct0vSX3u4YauJnwjHziK7x0rhx2SU3y+/GwvoQg+vEP9HoR
         W1T5TTQqOUz0RLWZNnGGSX99vWeiegCkZ3tINJtqOc67Or/LDTU+CWJNmlzC+umga7Pt
         LcA/XtyhdCZ4SKafrdIsPmX6aelMKJPGmeFJcNRli5Hekctmly0z3JPU+YXyXf2rslkj
         rhYTuBdZngLrimAmpBg3tlI6oZjx2ooCXj8epZMQ8W+SI8D9UKFD5nO7UGd1VadGyEFj
         txeM0VnRbveirDtMLl1hybzfA8PgPs5snvhsUcnWSeJQme9v+vghG0PRMeb8Vime/8dx
         ylTQ==
X-Gm-Message-State: AOAM533aiP6UfN10OGq93vo1UxXjtpIJorLTXAO4rjl7eAopeIk94Vuo
        FJJIWCkntk7Ex2PAU4BFl9mfLw==
X-Google-Smtp-Source: ABdhPJwdm7uhTD7vpi2jUUSlUWMyAV01UNjzssdq3ewTKXSFrUrGVN6mN/1O80Z1nw8okCfncLItvA==
X-Received: by 2002:a63:443:: with SMTP id 64mr7315283pge.375.1627088289636;
        Fri, 23 Jul 2021 17:58:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f15sm31888949pgv.92.2021.07.23.17.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:58:08 -0700 (PDT)
Date:   Fri, 23 Jul 2021 17:58:08 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Jul 2021 17:32:33 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: Make sure the kernel mapping does not overlap with IS_ERR_VALUE
In-Reply-To: <20210629091349.3802690-3-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        wangkefeng.wang@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-bc552805-71aa-4a1e-afa7-dfd08cfba35b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 02:13:48 PDT (-0700), alex@ghiti.fr wrote:
> The check that is done in setup_bootmem currently only works for 32-bit
> kernel since the kernel mapping has been moved outside of the linear
> mapping for 64-bit kernel. So make sure that for 64-bit kernel, the kernel
> mapping does not overlap with the last 4K of the addressable memory.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a1a0c4afa80f..a90c41bc9485 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -156,7 +156,7 @@ static void __init setup_bootmem(void)
>  {
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>  	phys_addr_t vmlinux_start = __pa_symbol(&_start);
> -	phys_addr_t max_mapped_addr = __pa(~(ulong)0);
> +	phys_addr_t __maybe_unused max_mapped_addr;
>  	phys_addr_t dram_end;
>
>  #ifdef CONFIG_XIP_KERNEL
> @@ -179,14 +179,20 @@ static void __init setup_bootmem(void)
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>
>  	dram_end = memblock_end_of_DRAM();
> +#ifndef CONFIG_64BIT
>  	/*
>  	 * memblock allocator is not aware of the fact that last 4K bytes of
>  	 * the addressable memory can not be mapped because of IS_ERR_VALUE
>  	 * macro. Make sure that last 4k bytes are not usable by memblock
> -	 * if end of dram is equal to maximum addressable memory.
> +	 * if end of dram is equal to maximum addressable memory. For 64-bit
> +	 * kernel, this problem can't happen here as the end of the virtual
> +	 * address space is occupied by the kernel mapping then this check must
> +	 * be done in create_kernel_page_table.
>  	 */
> +	max_mapped_addr = __pa(~(ulong)0);
>  	if (max_mapped_addr == (dram_end - 1))
>  		memblock_set_current_limit(max_mapped_addr - 4096);
> +#endif
>
>  	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
>  	max_low_pfn = max_pfn = PFN_DOWN(dram_end);
> @@ -556,6 +562,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
>  	uintptr_t va, end_va;
>
>  	end_va = kernel_virt_addr + load_sz;
> +
>  	for (va = kernel_virt_addr; va < end_va; va += map_size)
>  		create_pgd_mapping(pgdir, va,
>  				   load_pa + (va - kernel_virt_addr),
> @@ -602,6 +609,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	/* Sanity check alignment and size */
>  	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
>  	BUG_ON((load_pa % map_size) != 0);
> +#ifdef CONFIG_64BIT
> +	/*
> +	 * The last 4K bytes of the addressable memory can not be mapped because
> +	 * of IS_ERR_VALUE macro.
> +	 */
> +	BUG_ON((kernel_virt_addr + load_sz) > ADDRESS_SPACE_END - SZ_4K);
> +#endif
>
>  	pt_ops.alloc_pte = alloc_pte_early;
>  	pt_ops.get_pte_virt = get_pte_virt_early;

Thanks.  These are on fixes, with some fixes tags added.  This one had 
some merge conflicts that I had to fix up, LMK if something went wrong.
