Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8334545E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhKQLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235513AbhKQLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637149708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXfUNSShjqrOA5sFM+cPOF/5WanWiLYTnJjk+TI27xQ=;
        b=N3QIICV0wVNtybdKvbk4B9+2aXi2DP32eWqhyHfsoD6iOWZxFiM4q+Fx2L+9CYXfEvqEVA
        bAjLKNUIHxuY0m8pL+peJGazOAEUptFMfaijttlvg7tfQkb3MzwS+kocEwHf98cUrwIdZ7
        iBdZSGHpr+/y4JcZXiAp2+ajZoPauhk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-1F0Y32PEMGeI_omveqcBBw-1; Wed, 17 Nov 2021 06:48:27 -0500
X-MC-Unique: 1F0Y32PEMGeI_omveqcBBw-1
Received: by mail-ed1-f71.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso1889416edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=iXfUNSShjqrOA5sFM+cPOF/5WanWiLYTnJjk+TI27xQ=;
        b=w5Mt/JiWNQVIhHNhx55D/IZQm7apvxQ9rraV4zyoNcrJ3Kvw8/yfarWJwf73csKm35
         qpiItDFGaKSgSyonhtvw1K7TY1HtRjmEmujeWa47j2iS+xzPqBurdcgdriGFVKOyt9Cz
         AyrKNksfGWKh1vzFoI0D6M5w55VboazUB6ZJoj0nENmULJpxpOQ3ksULZCzpCRb1fbCE
         LH2q5extQ1LLGcJJ4hSTstDs4GgCE5gCV5GAhIhygg0O0vOy93kLkE1bR+GCZ83RViE3
         3otPKhG740ZNLNMMd3NAws6XsSJlez6BSOhnDhzeJ8KTTp9R3Xu1lCRD+++6Ds6EB2Q3
         RNvg==
X-Gm-Message-State: AOAM532gcrZUmgjg9I19BETZkLVwuLMqta3VYz3O3LNzNsnPIWKg/ZiI
        4YiRreC+phT81gcAUYQrtzxVmrmHDaGtK7GAh0WbIY+Br45FD2jwidxm23Lh3FYzP4xXgwAiMXE
        bZzi4pyM82E9265N2HH0adNP7
X-Received: by 2002:a05:6402:f:: with SMTP id d15mr20189716edu.331.1637149705855;
        Wed, 17 Nov 2021 03:48:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUXbRpsBwacbhC5r9gwH3TbtqimZxKl4AHr1KbPCKpjs1keI//W8jCBdq29CWmoEM8k5iNFQ==
X-Received: by 2002:a05:6402:f:: with SMTP id d15mr20189668edu.331.1637149705640;
        Wed, 17 Nov 2021 03:48:25 -0800 (PST)
Received: from [192.168.2.13] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id gz26sm2422534ejc.100.2021.11.17.03.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 03:48:25 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b7476c7a-3fd2-b774-9123-929969d00b28@redhat.com>
Date:   Wed, 17 Nov 2021 12:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        hawk@kernel.org, ilias.apalodimas@linaro.org,
        akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
        willy@infradead.org, will@kernel.org, feng.tang@intel.com,
        jgg@ziepe.ca, ebiederm@xmission.com, aarcange@redhat.com,
        guillaume.tucker@collabora.com, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH net] page_pool: Revert "page_pool: disable dma mapping
 support..."
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
References: <20211117075652.58299-1-linyunsheng@huawei.com>
In-Reply-To: <20211117075652.58299-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added CC: linux-mm@kvack.org

On 17/11/2021 08.56, Yunsheng Lin wrote:
> This reverts commit d00e60ee54b12de945b8493cf18c1ada9e422514.
> 
> As reported by Guillaume in [1]:
> Enabling LPAE always enables CONFIG_ARCH_DMA_ADDR_T_64BIT
> in 32-bit systems, which breaks the bootup proceess when a
> ethernet driver is using page pool with PP_FLAG_DMA_MAP flag.
> As we were hoping we had no active consumers for such system
> when we removed the dma mapping support, and LPAE seems like
> a common feature for 32 bits system, so revert it.
> 
> 1. https://www.spinics.net/lists/netdev/msg779890.html
> 
> Fixes: d00e60ee54b1 ("page_pool: disable dma mapping support for 32-bit arch with 64-bit DMA")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   include/linux/mm_types.h | 13 ++++++++++++-
>   include/net/page_pool.h  | 12 +++++++++++-
>   net/core/page_pool.c     | 10 ++++------
>   3 files changed, 27 insertions(+), 8 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Too bad that we have to keep this code-uglyness in struct page, and 
handling in page_pool.


> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index bb8c6f5f19bc..c3a6e6209600 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -105,7 +105,18 @@ struct page {
>   			struct page_pool *pp;
>   			unsigned long _pp_mapping_pad;
>   			unsigned long dma_addr;
> -			atomic_long_t pp_frag_count;
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
> index 3855f069627f..a4082406a003 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -216,14 +216,24 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>   	page_pool_put_full_page(pool, page, true);
>   }
>   
> +#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
> +		(sizeof(dma_addr_t) > sizeof(unsigned long))
> +
>   static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>   {
> -	return page->dma_addr;
> +	dma_addr_t ret = page->dma_addr;
> +
> +	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> +		ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> +
> +	return ret;
>   }
>   
>   static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>   {
>   	page->dma_addr = addr;
> +	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> +		page->dma_addr_upper = upper_32_bits(addr);
>   }
>   
>   static inline void page_pool_set_frag_count(struct page *page, long nr)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 9b60e4301a44..1a6978427d6c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -49,12 +49,6 @@ static int page_pool_init(struct page_pool *pool,
>   	 * which is the XDP_TX use-case.
>   	 */
>   	if (pool->p.flags & PP_FLAG_DMA_MAP) {
> -		/* DMA-mapping is not supported on 32-bit systems with
> -		 * 64-bit DMA mapping.
> -		 */
> -		if (sizeof(dma_addr_t) > sizeof(unsigned long))
> -			return -EOPNOTSUPP;
> -
>   		if ((pool->p.dma_dir != DMA_FROM_DEVICE) &&
>   		    (pool->p.dma_dir != DMA_BIDIRECTIONAL))
>   			return -EINVAL;
> @@ -75,6 +69,10 @@ static int page_pool_init(struct page_pool *pool,
>   		 */
>   	}
>   
> +	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> +	    pool->p.flags & PP_FLAG_PAGE_FRAG)
> +		return -EINVAL;
> +
>   	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0)
>   		return -ENOMEM;
>   
> 

