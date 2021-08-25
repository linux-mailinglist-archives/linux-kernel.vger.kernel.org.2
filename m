Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A23F72AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhHYKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhHYKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:09:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09288C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i21so9141271ejd.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gm/7T3DPPaEUAIQ4BZFY1GxdtYYv7S8x+8TSo/3yiV8=;
        b=Q6uBBCg2JR9FfJgv/mAMTDC2NIteNz82noKcyzDkKM1BeehCq5hQDrUrHxAOXKReYA
         +Oe5LJnLxItPz2MAdGPERGKdk5An1LqnGKnk24Mz3Di53LdmzX30w+jf1D3x4RtQ3EWt
         N44yBZJ5MjJG7nGjptI1q63YUkxyBXD3Y+KqJHOksB21v0foBmNoNTe/lv3zYkMJaNtr
         BzDQH2r6ItdxOlD718xGyUgnVdjEotkD1Ja0Tr/4yGIvsf0nPzGppwkmjoAYj4w4w+MA
         HtYQuF6ut0zta0AW4IpAeMIxXgIXd7W0C8l8o3khpxLuCp5lnOz4YkygDxa1LxaJoeZE
         6hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gm/7T3DPPaEUAIQ4BZFY1GxdtYYv7S8x+8TSo/3yiV8=;
        b=qZ9L5sR9HDeiDbu01qdZtllKtIbHBm7UO+bU9Lx0vXBrw6BLWkboz7hDVRy4lRNgnD
         nbnDpY8qbKeFkc+TQk30eBhCe4ge8MsGreoB824/xpU/0tma2zwsuU2wAolX429qeM89
         dZFusQcR/aaaQ08i9N/1ZQFtaQxU4n9/whmNBDcE/hPYJEioz5qG2K7dDVWP6Md6IqQy
         sMUxE1SkFqWX9QjqXhpFT+RCZ+K1j8lAQIOu61C+34PsRK+swURBcu0OkBVtN9tGL0e9
         jEq9/46WMflHCZtd3juLOQDYUcP9AdQKDDKvQTNVBJjVT9LcQGB2vHIVnQoqW8kNXXPX
         F9yA==
X-Gm-Message-State: AOAM531nVRQ1uwNn+VZQU1MYO7wTIT9jw+9A3FxgnTbyrjcLGLawxDg6
        iW1AlfUC1C8n5vUp5KuuxYD6bw==
X-Google-Smtp-Source: ABdhPJxBjm4UXGqykbN84zJa2RTllcDyQSlDDCxd3R3rYhZnZZ/dJ7SafWbQ8JPnEOCLMwkVRlOPYg==
X-Received: by 2002:a17:906:a044:: with SMTP id bg4mr45626743ejb.312.1629886150645;
        Wed, 25 Aug 2021 03:09:10 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id v12sm10773425ejq.36.2021.08.25.03.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 03:09:10 -0700 (PDT)
Subject: Re: [PATCH 2/4] microblaze: simplify pte_alloc_one_kernel()
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-3-rppt@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <30ca98c1-25ff-a18a-ea03-afa7a4b35ad5@monstr.eu>
Date:   Wed, 25 Aug 2021 12:09:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210714123739.16493-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/21 2:37 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The microblaze's implementation of pte_alloc_one_kernel() used
> memblock_alloc_try_nid_raw() along with clear_page() to allocated a zeroed
> page during early setup.
> 
> Replace calls of these functions with a call to memblock_alloc_try_nid()
> that already returns zeroed page and respects the same allocation limits as
> memblock_alloc_try_nid_raw().
> 
> While on it drop early_get_page() wrapper that was only used in
> pte_alloc_one_kernel().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/microblaze/include/asm/pgtable.h |  2 --
>  arch/microblaze/mm/init.c             | 12 ------------
>  arch/microblaze/mm/pgtable.c          | 17 ++++++++---------
>  3 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> index 71cd547655d9..c136a01e467e 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -443,8 +443,6 @@ extern int mem_init_done;
>  
>  asmlinkage void __init mmu_init(void);
>  
> -void __init *early_get_page(void);
> -
>  #endif /* __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>  
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index ab55c70380a5..952f35b335b2 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -265,18 +265,6 @@ asmlinkage void __init mmu_init(void)
>  	dma_contiguous_reserve(memory_start + lowmem_size - 1);
>  }
>  
> -/* This is only called until mem_init is done. */
> -void __init *early_get_page(void)
> -{
> -	/*
> -	 * Mem start + kernel_tlb -> here is limit
> -	 * because of mem mapping from head.S
> -	 */
> -	return memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
> -				MEMBLOCK_LOW_LIMIT, memory_start + kernel_tlb,
> -				NUMA_NO_NODE);
> -}
> -
>  void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
>  {
>  	void *p;
> diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
> index 38ccb909bc9d..c1833b159d3b 100644
> --- a/arch/microblaze/mm/pgtable.c
> +++ b/arch/microblaze/mm/pgtable.c
> @@ -33,6 +33,7 @@
>  #include <linux/init.h>
>  #include <linux/mm_types.h>
>  #include <linux/pgtable.h>
> +#include <linux/memblock.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/io.h>
> @@ -242,15 +243,13 @@ unsigned long iopa(unsigned long addr)
>  
>  __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	pte_t *pte;
> -	if (mem_init_done) {
> -		pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -	} else {
> -		pte = (pte_t *)early_get_page();
> -		if (pte)
> -			clear_page(pte);
> -	}
> -	return pte;
> +	if (mem_init_done)
> +		return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	else
> +		return memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
> +					      MEMBLOCK_LOW_LIMIT,
> +					      memory_start + kernel_tlb,
> +					      NUMA_NO_NODE);
>  }
>  
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
> 

I have tested 1/4 with/without the fix from Guenter
and also 2/4 and I can't see any issue on real HW.

That's why feel free to add my
Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


