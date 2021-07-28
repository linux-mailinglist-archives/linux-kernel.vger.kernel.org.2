Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A069C3D8853
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhG1Gzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234367AbhG1Gzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:55:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A34A60C3F;
        Wed, 28 Jul 2021 06:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627455342;
        bh=BrpjduE0q48FF1J9AlPOQqsZ2bQyg70IWUXdh44zgls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yv+knPBBvFRu/v5Km3KMTVJAYMlT0IWA3muppA54knH3mGZs6mXtXExThTNkgJnPK
         uicatH/a3cBJzrDaZCscqn2ps142YCd3rVCGs7fmj7C2in4UTPkx14LEUp0qPiXmBY
         37vmyAXMyQXUCFax6u1IMQemeyrMi3elnwpKDuRjcgnmMitT49DZbhDxIrCYyaoANb
         f+FH9dygBRk8o9FxPAhW/fXJdQ+KQgQpnCPqNLdgIwiqD6l8GZkIYOsyuI9o6YBi7w
         eb03vA9Gpagp+f2IXBM5sVleDbHqIVV/7LzH58komd0XkFFaK+ei6bC9DieUMI/2fU
         0Z4T+YmLy+Fjw==
Date:   Wed, 28 Jul 2021 09:55:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kenneth Lee <nek.in.cn@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH] riscv: fix the global name pfn_base confliction error
Message-ID: <YQD/Zb0EszIWr6RJ@kernel.org>
References: <20210728064318.375747-1-nek.in.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728064318.375747-1-nek.in.cn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:43:18PM +0800, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> RISCV use a global variable pfn_base for page/pfn translation. But this
> is a common name and will be used elsewhere. In those case,
> the page-pfn macro which refer this name will refer to the local/input
> variable of those function (such as in vfio_pin_pages_remote). This make
> everything wrong.
> 
> This patch change the name from pfn_base to riscv_global_pfn_base to fix

I think global is excessive, just riscv_pfn_base should be ok for proper
namespacing.

> this problem
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> ---
>  arch/riscv/include/asm/page.h | 4 ++--
>  arch/riscv/mm/init.c          | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index cca8764aed83..8711e415f37c 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
>  #endif
>  
>  #ifdef CONFIG_MMU
> -extern unsigned long pfn_base;
> -#define ARCH_PFN_OFFSET		(pfn_base)
> +extern unsigned long riscv_global_pfn_base;
> +#define ARCH_PFN_OFFSET		(riscv_global_pfn_base)
>  #else
>  #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a14bf3910eec..2ce4e9a46ca0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
>  #define pt_ops _pt_ops
>  #endif
>  
> -unsigned long pfn_base __ro_after_init;
> -EXPORT_SYMBOL(pfn_base);
> +unsigned long riscv_global_pfn_base __ro_after_init;
> +EXPORT_SYMBOL(riscv_global_pfn_base);
>  
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> @@ -572,7 +572,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>  #endif
>  
> -	pfn_base = PFN_DOWN(kernel_map.phys_addr);
> +	riscv_global_pfn_base = PFN_DOWN(kernel_map.phys_addr);
>  
>  	/*
>  	 * Enforce boot alignment requirements of RV32 and
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
