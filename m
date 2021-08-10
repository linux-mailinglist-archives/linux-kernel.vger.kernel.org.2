Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339353E5E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbhHJO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242207AbhHJO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628607496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUy18vQWFqEpKaLHVXakl3mPB08V6UfeF611fK9Gam0=;
        b=bifnNryp1TouLYrG4husThleOnSc0egRFjjv803qWHPFitNwoB/so03fTjySEqzMSCAUW9
        JF5j+T4iWxkl8Ld0/AK2RXamcBFg7Otj7ZU2YB7gU2wEJ6qlCXjlujH4CpBb32m+7+SkdK
        tLL0qAcmwNVcR3XDdLx99akkOWmmlxg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-cZsVH3IsMaeFxRDaXkUCpA-1; Tue, 10 Aug 2021 10:58:09 -0400
X-MC-Unique: cZsVH3IsMaeFxRDaXkUCpA-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so4969099wmj.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUy18vQWFqEpKaLHVXakl3mPB08V6UfeF611fK9Gam0=;
        b=o8kYk9jiUZTwBqARdtGTGakrg58uOiwCXsl8bRvapJk4jUzGBMSp7LjN3BNBURRBIC
         AYwmpm63SxCK+MY56ToTbAc8ifW3cSgbYba+XFQxt3paLqXX5NEpkUbZyF6iNVemaoe8
         +ucvnRywjEcFJWMhA2DI2VOhSOn52zjq5NNO0Qh/Ld1g0JH1lFLhW5Yo2YUPunorBnuc
         YGPq4LpYRCs+byBUjz2Gp1QGELJXFp5UsXWzKZqDl6ax1CuDrGU6/p9Qd7I8lT8+llFz
         /xGhV9typh8DJGLY+IvSXlBImz0lBWYJoipLermnMvfiZ3oFRdVEhEbP8g91/L3IhBSk
         r5Sw==
X-Gm-Message-State: AOAM533YSbjywZgnlsmGD/U5CCVoWvmvh7jaamRj+kq9P0mhfoCnmWf4
        enubLYbvqE4419R0QjXFqbISE3p7FIoFOYqGGNJR0v6DYuuZTSNZtoiv+/7FDGoNezFO7mBWZ0q
        E44a6orCfWHoru6UB/bJS7XMs
X-Received: by 2002:a5d:6146:: with SMTP id y6mr30881249wrt.278.1628607488022;
        Tue, 10 Aug 2021 07:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxevabhjt95IKMjXAm2nrxG7HgOUYrBPOJkvsPqoKg1v208UM0XWcPZ+fLqKciWDPkHANY1qw==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr30881232wrt.278.1628607487862;
        Tue, 10 Aug 2021 07:58:07 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id g5sm2883361wmh.31.2021.08.10.07.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 07:58:07 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, alexander.duyck@gmail.com,
        linux@armlinux.org.uk, mw@semihalf.com, linuxarm@openeuler.org,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        thomas.petazzoni@bootlin.com, hawk@kernel.org,
        ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, will@kernel.org, willy@infradead.org,
        vbabka@suse.cz, fenghua.yu@intel.com, guro@fb.com,
        peterx@redhat.com, feng.tang@intel.com, jgg@ziepe.ca,
        mcroce@microsoft.com, hughd@google.com, jonathan.lemon@gmail.com,
        alobakin@pm.me, willemb@google.com, wenxu@ucloud.cn,
        cong.wang@bytedance.com, haokexin@gmail.com, nogikh@google.com,
        elver@google.com, yhs@fb.com, kpsingh@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, chenhao288@hisilicon.com,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH net-next v2 2/4] page_pool: add interface to manipulate
 frag count in page pool
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
References: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
 <1628217982-53533-3-git-send-email-linyunsheng@huawei.com>
Message-ID: <a3999ff2-2385-41a6-c3f5-ccd6cf67badf@redhat.com>
Date:   Tue, 10 Aug 2021 16:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1628217982-53533-3-git-send-email-linyunsheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2021 04.46, Yunsheng Lin wrote:
> For 32 bit systems with 64 bit dma, dma_addr[1] is used to
> store the upper 32 bit dma addr, those system should be rare
> those days.
> 
> For normal system, the dma_addr[1] in 'struct page' is not
> used, so we can reuse dma_addr[1] for storing frag count,
> which means how many frags this page might be splited to.
> 
> In order to simplify the page frag support in the page pool,
> the PAGE_POOL_DMA_USE_PP_FRAG_COUNT macro is added to indicate
> the 32 bit systems with 64 bit dma, and the page frag support
> in page pool is disabled for such system.
> 
> The newly added page_pool_set_frag_count() is called to reserve
> the maximum frag count before any page frag is passed to the
> user. The page_pool_atomic_sub_frag_count_return() is called
> when user is done with the page frag.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   include/linux/mm_types.h | 18 +++++++++++++-----
>   include/net/page_pool.h  | 46 +++++++++++++++++++++++++++++++++++++++-------
>   net/core/page_pool.c     |  4 ++++
>   3 files changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 52bbd2b..7f8ee09 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -103,11 +103,19 @@ struct page {
>   			unsigned long pp_magic;
>   			struct page_pool *pp;
>   			unsigned long _pp_mapping_pad;
> -			/**
> -			 * @dma_addr: might require a 64-bit value on
> -			 * 32-bit architectures.
> -			 */
> -			unsigned long dma_addr[2];
> +			unsigned long dma_addr;
> +			union {
> +				/**
> +				 * dma_addr_upper: might require a 64-bit
> +				 * value on 32-bit architectures.
> +				 */
> +				unsigned long dma_addr_upper;
> +				/**
> +				 * For frag page support, not supported in
> +				 * 32-bit architectures with 64-bit DMA.
> +				 */
> +				atomic_long_t pp_frag_count;
> +			};
>   		};
>   		struct {	/* slab, slob and slub */
>   			union {
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 8d7744d..42e6997 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -45,7 +45,10 @@
>   					* Please note DMA-sync-for-CPU is still
>   					* device driver responsibility
>   					*/
> -#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
> +#define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
> +#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
> +				 PP_FLAG_DMA_SYNC_DEV |\
> +				 PP_FLAG_PAGE_FRAG)
>   
>   /*
>    * Fast allocation side cache array/stack
> @@ -198,19 +201,48 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>   	page_pool_put_full_page(pool, page, true);
>   }
>   
> +#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
> +		(sizeof(dma_addr_t) > sizeof(unsigned long))
> +
>   static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>   {
> -	dma_addr_t ret = page->dma_addr[0];
> -	if (sizeof(dma_addr_t) > sizeof(unsigned long))
> -		ret |= (dma_addr_t)page->dma_addr[1] << 16 << 16;
> +	dma_addr_t ret = page->dma_addr;
> +
> +	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> +		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;

I find the macro name confusing.

I think it would be easier to read the code, if it was called:
  PAGE_POOL_DMA_CANNOT_USE_PP_FRAG_COUNT

> +
>   	return ret;
>   }
>   
>   static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>   {
> -	page->dma_addr[0] = addr;
> -	if (sizeof(dma_addr_t) > sizeof(unsigned long))
> -		page->dma_addr[1] = upper_32_bits(addr);
> +	page->dma_addr = addr;
> +	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> +		page->dma_addr_upper = upper_32_bits(addr);
> +}
> +
> +static inline void page_pool_set_frag_count(struct page *page, long nr)
> +{
> +	atomic_long_set(&page->pp_frag_count, nr);
> +}
> +
> +static inline long page_pool_atomic_sub_frag_count_return(struct page *page,
> +							  long nr)
> +{
> +	long ret;
> +
> +	/* As suggested by Alexander, atomic_long_read() may cover up the
> +	 * reference count errors, so avoid calling atomic_long_read() in
> +	 * the cases of freeing or draining the page_frags, where we would
> +	 * not expect it to match or that are slowpath anyway.
> +	 */
> +	if (__builtin_constant_p(nr) &&
> +	    atomic_long_read(&page->pp_frag_count) == nr)
> +		return 0;
> +
> +	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
> +	WARN_ON(ret < 0);
> +	return ret;
>   }
>   
>   static inline bool is_page_pool_compiled_in(void)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 78838c6..68fab94 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -67,6 +67,10 @@ static int page_pool_init(struct page_pool *pool,
>   		 */
>   	}
>   
> +	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> +	    pool->p.flags & PP_FLAG_PAGE_FRAG)
> +		return -EINVAL;

I read this as: if the page_pool use pp_frag_count and have flag set, 
then it is invalid/no-allowed, which seems wrong.

I find this code more intuitive to read:

  +	if (PAGE_POOL_DMA_CANNOT_USE_PP_FRAG_COUNT &&
  +	    pool->p.flags & PP_FLAG_PAGE_FRAG)
  +		return -EINVAL;

--Jesper

