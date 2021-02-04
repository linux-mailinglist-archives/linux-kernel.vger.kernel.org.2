Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977A730F369
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhBDMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235605AbhBDMrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:47:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCA6B64F53;
        Thu,  4 Feb 2021 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612442825;
        bh=o9UP0+59H1eDhBF0AV66BdlEfMuDGDBZkB2njTKjhzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYztO1KE9eobHskzdV7EQAKlPDArW88rIfKrHy865y2k+CRvNisKS477rTxnbOszw
         DUaxHWy2KkuwQ/E/TPVjPrl7/5lx6Zkfx6SgCTqoFTQLvd+EIYVRmB3gR9UwUiXAGc
         5f6h4flGgSiFj/mAOkYs7Zf+uVpXWyygM70A2/JUNh7az+qI/ik9e2ywxONyMwpclC
         3yvlhQDLR+udPUh+EP2GGpuow9LMt7x7ybFapG+lbQvUdPGl53+TUxNUONhZ2U03Ej
         UeOvkghJ926T/YLloCmxo9fe+im7ZTOpVoHTVOXh/m7ogvEWbKWr+f5cSlN4MAHr4/
         7QgNewPXyj1ww==
Date:   Thu, 4 Feb 2021 12:46:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        catalin.marinas@arm.com, ardb@kernel.org, andreyknvl@google.com,
        broonie@kernel.org, linux@roeck-us.net, rppt@kernel.org,
        tyhicks@linux.microsoft.com, robin.murphy@arm.com,
        vincenzo.frascino@arm.com, gustavoars@kernel.org,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH v2 2/4] arm64: kasan: abstract _text and _end to
 KERNEL_START/END
Message-ID: <20210204124658.GB20468@willie-the-truck>
References: <20210109103252.812517-1-lecopzer@gmail.com>
 <20210109103252.812517-3-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109103252.812517-3-lecopzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 06:32:50PM +0800, Lecopzer Chen wrote:
> Arm64 provide defined macro for KERNEL_START and KERNEL_END,
> thus replace them by the abstration instead of using _text and _end.
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  arch/arm64/mm/kasan_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 39b218a64279..fa8d7ece895d 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -218,8 +218,8 @@ static void __init kasan_init_shadow(void)
>  	phys_addr_t pa_start, pa_end;
>  	u64 i;
>  
> -	kimg_shadow_start = (u64)kasan_mem_to_shadow(_text) & PAGE_MASK;
> -	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(_end));
> +	kimg_shadow_start = (u64)kasan_mem_to_shadow(KERNEL_START) & PAGE_MASK;
> +	kimg_shadow_end = PAGE_ALIGN((u64)kasan_mem_to_shadow(KERNEL_END));
>  
>  	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
>  	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
> @@ -241,7 +241,7 @@ static void __init kasan_init_shadow(void)
>  	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
>  
>  	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
> -			   early_pfn_to_nid(virt_to_pfn(lm_alias(_text))));
> +			   early_pfn_to_nid(virt_to_pfn(lm_alias(KERNEL_START))));

To be honest, I think this whole line is pointless. We should be able to
pass NUMA_NO_NODE now that we're not abusing the vmemmap() allocator to
populate the shadow.

Will
