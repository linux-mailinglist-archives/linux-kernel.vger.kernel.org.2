Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8480534237E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSRiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhCSRiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:38:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5557B6197A;
        Fri, 19 Mar 2021 17:38:01 +0000 (UTC)
Date:   Fri, 19 Mar 2021 17:37:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        ardb@kernel.org, andreyknvl@google.com, broonie@kernel.org,
        linux@roeck-us.net, rppt@kernel.org, tyhicks@linux.microsoft.com,
        robin.murphy@arm.com, vincenzo.frascino@arm.com,
        gustavoars@kernel.org, lecopzer@gmail.com
Subject: Re: [PATCH v3 1/5] arm64: kasan: don't populate vmalloc area for
 CONFIG_KASAN_VMALLOC
Message-ID: <20210319173758.GC6832@arm.com>
References: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
 <20210206083552.24394-2-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206083552.24394-2-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 04:35:48PM +0800, Lecopzer Chen wrote:
> Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
> 
> Like how the MODULES_VADDR does now, just not to early populate
> the VMALLOC_START between VMALLOC_END.
> 
> Before:
> 
> MODULE_VADDR: no mapping, no zoreo shadow at init
> VMALLOC_VADDR: backed with zero shadow at init
> 
> After:
> 
> MODULE_VADDR: no mapping, no zoreo shadow at init
> VMALLOC_VADDR: no mapping, no zoreo shadow at init

s/zoreo/zero/

> Thus the mapping will get allocated on demand by the core function
> of KASAN_VMALLOC.
> 
>   -----------  vmalloc_shadow_start
>  |           |
>  |           |
>  |           | <= non-mapping
>  |           |
>  |           |
>  |-----------|
>  |///////////|<- kimage shadow with page table mapping.
>  |-----------|
>  |           |
>  |           | <= non-mapping
>  |           |
>  ------------- vmalloc_shadow_end
>  |00000000000|
>  |00000000000| <= Zero shadow
>  |00000000000|
>  ------------- KASAN_SHADOW_END
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  arch/arm64/mm/kasan_init.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index d8e66c78440e..20d06008785f 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
>  {
>  	u64 kimg_shadow_start, kimg_shadow_end;
>  	u64 mod_shadow_start, mod_shadow_end;
> +	u64 vmalloc_shadow_end;
>  	phys_addr_t pa_start, pa_end;
>  	u64 i;
>  
> @@ -223,6 +224,8 @@ static void __init kasan_init_shadow(void)
>  	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
>  	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
>  
> +	vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> +
>  	/*
>  	 * We are going to perform proper setup of shadow memory.
>  	 * At first we should unmap early shadow (clear_pgds() call below).
> @@ -241,12 +244,17 @@ static void __init kasan_init_shadow(void)
>  
>  	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
>  				   (void *)mod_shadow_start);
> -	kasan_populate_early_shadow((void *)kimg_shadow_end,
> -				   (void *)KASAN_SHADOW_END);
>  
> -	if (kimg_shadow_start > mod_shadow_end)
> -		kasan_populate_early_shadow((void *)mod_shadow_end,
> -					    (void *)kimg_shadow_start);

Not something introduced by this patch but what happens if this
condition is false? It means that kimg_shadow_end < mod_shadow_start and
the above kasan_populate_early_shadow(PAGE_END, mod_shadow_start)
overlaps with the earlier kasan_map_populate(kimg_shadow_start,
kimg_shadow_end).

> +	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> +		kasan_populate_early_shadow((void *)vmalloc_shadow_end,
> +					    (void *)KASAN_SHADOW_END);
> +	else {
> +		kasan_populate_early_shadow((void *)kimg_shadow_end,
> +					    (void *)KASAN_SHADOW_END);
> +		if (kimg_shadow_start > mod_shadow_end)
> +			kasan_populate_early_shadow((void *)mod_shadow_end,
> +						    (void *)kimg_shadow_start);
> +	}
>  
>  	for_each_mem_range(i, &pa_start, &pa_end) {
>  		void *start = (void *)__phys_to_virt(pa_start);
> -- 
> 2.25.1
> 

-- 
Catalin
