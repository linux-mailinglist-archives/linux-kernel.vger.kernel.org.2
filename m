Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F73F74E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbhHYMOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240679AbhHYMOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629893629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+mWtET0VJRoDSwpOU4ZXSont0R34OAjtdYQ/JJ1WlU=;
        b=enEQ11pzhleM3Bts2nhpfsAW+ETO6Bzq/mkK+DG46w0jCfN8EkGPwA1wLEuORqy9eiffug
        7Ra3XkmfWxsfRLTSSy/k0lE4xszZrF5gsrCwiNgyOW4nFKNZcVz38b6AOS3H5MkVLqScIc
        ARLX1kSWNhI+envD+kT1lhYMLExOnNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-LCS4s7QbNNe49oVsXmzG4Q-1; Wed, 25 Aug 2021 08:13:47 -0400
X-MC-Unique: LCS4s7QbNNe49oVsXmzG4Q-1
Received: by mail-wm1-f72.google.com with SMTP id n20-20020a05600c4f9400b002e6dc6a99b9so1824243wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T+mWtET0VJRoDSwpOU4ZXSont0R34OAjtdYQ/JJ1WlU=;
        b=T7qRLl3gYrc4IRzj1v45vvhS0nAZz3Z6j/JCmbpCv+eMrKg2czVrus/rxmI1CKmM1c
         YnQuvvNwMk4Q4PDR//4ADTzFyqMiuGAGukMclaykmfP0qTfw+E+eyYlanuRWeFvbvRrQ
         YBtyIsU76GmnRUV6ONeJULmoqHgUcwrbOU8V73sv/klvstr82TZMKBgs5PHJQUzg5sT0
         IPBxELg9RFjDcBckVOeNjpX+L0o8IGGiBSf9vZ1s7yuzZUasjgztGvOo58hHs4otfsb2
         YCDg26xMowyFlxzVladc9J72PB3YDIGJpJ6kevTK92A0PRPoPjtEvVW3c5a9Y2uOQidR
         rdtQ==
X-Gm-Message-State: AOAM533DBXtfCUvc5lSsRwIoOaL7bAh0MaSI3gTW6plGwzEWxGXTd6CY
        k9MaYgFWGfUOb1amkwLQhIJGGxGx748k0zNmw3T+RlGKfvmx1+5lDEVXQojFO8Wt7Nk1HWcVjvN
        uz4l678XgghCuBjtkVFDtZnQ6
X-Received: by 2002:a7b:c316:: with SMTP id k22mr8896505wmj.56.1629893626682;
        Wed, 25 Aug 2021 05:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0KaHNPQm3HvatLTHztCmId4RLKJb1rPmJ4P0sk4rpSiu4Hwf3yk4JWqhdkOcTUQf/ieo+dg==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr8896490wmj.56.1629893626505;
        Wed, 25 Aug 2021 05:13:46 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id a77sm5408941wmd.31.2021.08.25.05.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:13:46 -0700 (PDT)
Subject: Re: [PATCH 2/4] microblaze: simplify pte_alloc_one_kernel()
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <cb695be4-1ec8-f821-0446-26d9831981e2@redhat.com>
Date:   Wed, 25 Aug 2021 14:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714123739.16493-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.21 14:37, Mike Rapoport wrote:
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
>   arch/microblaze/include/asm/pgtable.h |  2 --
>   arch/microblaze/mm/init.c             | 12 ------------
>   arch/microblaze/mm/pgtable.c          | 17 ++++++++---------
>   3 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> index 71cd547655d9..c136a01e467e 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -443,8 +443,6 @@ extern int mem_init_done;
>   
>   asmlinkage void __init mmu_init(void);
>   
> -void __init *early_get_page(void);
> -
>   #endif /* __ASSEMBLY__ */
>   #endif /* __KERNEL__ */
>   
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index ab55c70380a5..952f35b335b2 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -265,18 +265,6 @@ asmlinkage void __init mmu_init(void)
>   	dma_contiguous_reserve(memory_start + lowmem_size - 1);
>   }
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
>   void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
>   {
>   	void *p;
> diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
> index 38ccb909bc9d..c1833b159d3b 100644
> --- a/arch/microblaze/mm/pgtable.c
> +++ b/arch/microblaze/mm/pgtable.c
> @@ -33,6 +33,7 @@
>   #include <linux/init.h>
>   #include <linux/mm_types.h>
>   #include <linux/pgtable.h>
> +#include <linux/memblock.h>
>   
>   #include <asm/pgalloc.h>
>   #include <linux/io.h>
> @@ -242,15 +243,13 @@ unsigned long iopa(unsigned long addr)
>   
>   __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   {
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
>   }
>   
>   void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

