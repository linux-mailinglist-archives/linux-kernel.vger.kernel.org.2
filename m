Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC07F40F245
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhIQGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhIQGZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:25:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F37260F4A;
        Fri, 17 Sep 2021 06:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631859864;
        bh=2Yf48r3eL6AsFDGAGrmnb1zCRH5QI/gs+4Dz7P0jxvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNzW5LF8aK9JS7ekdhbBuxILwkGT8IsK1tdD6XVWfaxerpka4xEbxOGQfx9TmYCbc
         cxDXJDPgxFELIdlXNagFqAUyC5vFlnalOBarNwHj2aJLgeX+Q8vbwzDAzASgT6bTpi
         Aop6e1159Fq4chjUaevnB9GrIwlAnoUtolhMnHHg=
Date:   Fri, 17 Sep 2021 08:24:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, elver@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 2/3] arm64: Support page mapping percpu first chunk
 allocator
Message-ID: <YUQ0lvldA+wGpr0G@kroah.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <20210910053354.26721-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910053354.26721-3-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 01:33:53PM +0800, Kefeng Wang wrote:
> Percpu embedded first chunk allocator is the firstly option, but it
> could fails on ARM64, eg,
>   "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
>   "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
>   "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"
> 
> then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
> even the system could not boot successfully.
> 
> Let's implement page mapping percpu first chunk allocator as a fallback
> to the embedding allocator to increase the robustness of the system.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/Kconfig       |  4 ++
>  drivers/base/arch_numa.c | 82 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 76 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 077f2ec4eeb2..04cfe1b4e98b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1042,6 +1042,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	def_bool y
>  	depends on NUMA
>  
> +config NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	def_bool y
> +	depends on NUMA

Why is this a config option at all?

> +
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SPARSEMEM_ENABLE
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 46c503486e96..995dca9f3254 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  
>  #include <asm/sections.h>
> +#include <asm/pgalloc.h>
>  
>  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
>  EXPORT_SYMBOL(node_data);
> @@ -168,22 +169,83 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
>  	memblock_free_early(__pa(ptr), size);
>  }
>  
> +#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK

Ick, no #ifdef in .c files if at all possible please.

> +static void __init pcpu_populate_pte(unsigned long addr)
> +{
> +	pgd_t *pgd = pgd_offset_k(addr);
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d)) {
> +		pud_t *new;
> +
> +		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +		if (!new)
> +			goto err_alloc;
> +		p4d_populate(&init_mm, p4d, new);
> +	}
> +
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud)) {
> +		pmd_t *new;
> +
> +		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +		if (!new)
> +			goto err_alloc;
> +		pud_populate(&init_mm, pud, new);
> +	}
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (!pmd_present(*pmd)) {
> +		pte_t *new;
> +
> +		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +		if (!new)
> +			goto err_alloc;
> +		pmd_populate_kernel(&init_mm, pmd, new);
> +	}
> +
> +	return;
> +
> +err_alloc:
> +	panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
> +	      __func__, PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);

That feels harsh, are you sure you want to crash?  There's no way to
recover from this?  If not, how can this fail in real life?

> +}
> +#endif
> +
>  void __init setup_per_cpu_areas(void)
>  {
>  	unsigned long delta;
>  	unsigned int cpu;
> -	int rc;
> +	int rc = -EINVAL;
> +
> +	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
> +		/*
> +		 * Always reserve area for module percpu variables.  That's
> +		 * what the legacy allocator did.
> +		 */
> +		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
> +					    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
> +					    pcpu_cpu_distance,
> +					    pcpu_fc_alloc, pcpu_fc_free);
> +#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
> +		if (rc < 0)
> +			pr_warn("PERCPU: %s allocator failed (%d), falling back to page size\n",
> +				   pcpu_fc_names[pcpu_chosen_fc], rc);
> +#endif

Why only print out a message for a config option?  Again, no #ifdef in
.c files if at all possible.

thanks,

greg k-h
