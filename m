Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F5E330C84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCHLgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCHLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:35:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACCFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:35:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l11so7673722wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n76nfuOBIjU7qAbRDmCDHWm6PPfYsZij7NB352EcUzw=;
        b=HBtYHyjx3R8sAh1g0JTXqYEhfSBQGh+QOYfBM17TQ4AfCH0UvMyGAPSsVD5l5WTXoP
         TVch0Z9onV0dEC4voOzOA880zZI5Y2zzegC9+xea4M+S0VwAdVOzmCBXmcbAtUdl5ww7
         m7XlNz3uDCOyBRGWdU1qNOZbwhgjWQZ0yzGZGIanX1naV0pCneI7wTBPbrmfchwqe/Cr
         PC+W/CYgkx3pnmycF2Z8GmruPtLiGCdXVhe32D1EQGSLo3QLqoInsA5mw/AiS5p9GlF2
         BdXk4UV2puDSYZGPD1VsRzFXLMhAcDdiNXfQM4YejLEP4uCR7CVjkJ3/1xwV3omktFpk
         v+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n76nfuOBIjU7qAbRDmCDHWm6PPfYsZij7NB352EcUzw=;
        b=PXSxXcXXUjT+aPGdUdRmjrKiLm5QQnloniChetm5eAmwlPfJxWSDpEbq3ZZnNws27G
         5mGNbzHZlvHvZq7WJs9gEhj33zDEhhQa5WIBaH7j6JivuyTSVNN9ZuGzcOcMvOYyNXfj
         U10CT2jObJiYK8VcLyFaegn4qMOg2cZxp0a8jpWwv70dOWnuMPpIFa+5ZU8GSAIg4Bzq
         J2voyU6r/y0SsGdJxHMIWRPR6BRxLbmDAHQud9pnsEgf3SEdwTSPry6euSSZ5Mu4x4wR
         IwErXPnO7r0XAfYgtHwHbONoVEtL/H/ld4zDAkV/18/GT5lKj7nTS8OmKvB1oFwKGt1U
         qg6g==
X-Gm-Message-State: AOAM532FzL3X+1n+Cc3wRdfPjqfUHAYOZ4jPRTMz/0h5+TiyDI3G6izl
        AfyeAVlv64tgk9ZNur6InTAEtg==
X-Google-Smtp-Source: ABdhPJxMfAr4eyqNvBmo+DXLzoDkFVP/cs32MpO8fNMX87DCcc85Czkwdr48UugDnKbAS9PjF5Fy/A==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr22136031wrx.403.1615203349305;
        Mon, 08 Mar 2021 03:35:49 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:9d1d:b6a0:d116:531b])
        by smtp.gmail.com with ESMTPSA id o7sm18219797wrs.16.2021.03.08.03.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:35:48 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:35:42 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] kasan, mm: integrate page_alloc init with HW_TAGS
Message-ID: <YEYMDn/9zQI8g+3o@elver.google.com>
References: <cover.1614989433.git.andreyknvl@google.com>
 <a7f1d687b0550182c7f5b4a47c277a61425af65f.1614989433.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f1d687b0550182c7f5b4a47c277a61425af65f.1614989433.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 01:15AM +0100, Andrey Konovalov wrote:
> This change uses the previously added memory initialization feature
> of HW_TAGS KASAN routines for page_alloc memory when init_on_alloc/free
> is enabled.
> 
> With this change, kernel_init_free_pages() is no longer called when
> both HW_TAGS KASAN and init_on_alloc/free are enabled. Instead, memory
> is initialized in KASAN runtime.
> 
> To avoid discrepancies with which memory gets initialized that can be
> caused by future changes, both KASAN and kernel_init_free_pages() hooks
> are put together and a warning comment is added.
> 
> This patch changes the order in which memory initialization and page
> poisoning hooks are called. This doesn't lead to any side-effects, as
> whenever page poisoning is enabled, memory initialization gets disabled.
> 
> Combining setting allocation tags with memory initialization improves
> HW_TAGS KASAN performance when init_on_alloc/free is enabled.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/kasan.h | 16 ++++++++--------
>  mm/kasan/common.c     |  8 ++++----
>  mm/mempool.c          |  4 ++--
>  mm/page_alloc.c       | 37 ++++++++++++++++++++++++++-----------
>  4 files changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 1d89b8175027..4c0f414a893b 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -120,20 +120,20 @@ static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
>  		__kasan_unpoison_range(addr, size);
>  }
>  
> -void __kasan_alloc_pages(struct page *page, unsigned int order);
> +void __kasan_alloc_pages(struct page *page, unsigned int order, bool init);
>  static __always_inline void kasan_alloc_pages(struct page *page,
> -						unsigned int order)
> +						unsigned int order, bool init)
>  {
>  	if (kasan_enabled())
> -		__kasan_alloc_pages(page, order);
> +		__kasan_alloc_pages(page, order, init);
>  }
>  
> -void __kasan_free_pages(struct page *page, unsigned int order);
> +void __kasan_free_pages(struct page *page, unsigned int order, bool init);
>  static __always_inline void kasan_free_pages(struct page *page,
> -						unsigned int order)
> +						unsigned int order, bool init)
>  {
>  	if (kasan_enabled())
> -		__kasan_free_pages(page, order);
> +		__kasan_free_pages(page, order, init);
>  }
>  
>  void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> @@ -282,8 +282,8 @@ static inline slab_flags_t kasan_never_merge(void)
>  	return 0;
>  }
>  static inline void kasan_unpoison_range(const void *address, size_t size) {}
> -static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
> -static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> +static inline void kasan_alloc_pages(struct page *page, unsigned int order, bool init) {}
> +static inline void kasan_free_pages(struct page *page, unsigned int order, bool init) {}
>  static inline void kasan_cache_create(struct kmem_cache *cache,
>  				      unsigned int *size,
>  				      slab_flags_t *flags) {}
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 316f7f8cd8e6..6107c795611f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -97,7 +97,7 @@ slab_flags_t __kasan_never_merge(void)
>  	return 0;
>  }
>  
> -void __kasan_alloc_pages(struct page *page, unsigned int order)
> +void __kasan_alloc_pages(struct page *page, unsigned int order, bool init)
>  {
>  	u8 tag;
>  	unsigned long i;
> @@ -108,14 +108,14 @@ void __kasan_alloc_pages(struct page *page, unsigned int order)
>  	tag = kasan_random_tag();
>  	for (i = 0; i < (1 << order); i++)
>  		page_kasan_tag_set(page + i, tag);
> -	kasan_unpoison(page_address(page), PAGE_SIZE << order, false);
> +	kasan_unpoison(page_address(page), PAGE_SIZE << order, init);
>  }
>  
> -void __kasan_free_pages(struct page *page, unsigned int order)
> +void __kasan_free_pages(struct page *page, unsigned int order, bool init)
>  {
>  	if (likely(!PageHighMem(page)))
>  		kasan_poison(page_address(page), PAGE_SIZE << order,
> -			     KASAN_FREE_PAGE, false);
> +			     KASAN_FREE_PAGE, init);
>  }
>  
>  /*
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 79959fac27d7..fe19d290a301 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -106,7 +106,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
>  		kasan_slab_free_mempool(element);
>  	else if (pool->alloc == mempool_alloc_pages)
> -		kasan_free_pages(element, (unsigned long)pool->pool_data);
> +		kasan_free_pages(element, (unsigned long)pool->pool_data, false);
>  }
>  
>  static void kasan_unpoison_element(mempool_t *pool, void *element)
> @@ -114,7 +114,7 @@ static void kasan_unpoison_element(mempool_t *pool, void *element)
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
>  		kasan_unpoison_range(element, __ksize(element));
>  	else if (pool->alloc == mempool_alloc_pages)
> -		kasan_alloc_pages(element, (unsigned long)pool->pool_data);
> +		kasan_alloc_pages(element, (unsigned long)pool->pool_data, false);
>  }
>  
>  static __always_inline void add_element(mempool_t *pool, void *element)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0efb07b5907c..175bdb36d113 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -396,14 +396,14 @@ static DEFINE_STATIC_KEY_TRUE(deferred_pages);
>   * initialization is done, but this is not likely to happen.
>   */
>  static inline void kasan_free_nondeferred_pages(struct page *page, int order,
> -							fpi_t fpi_flags)
> +						bool init, fpi_t fpi_flags)
>  {
>  	if (static_branch_unlikely(&deferred_pages))
>  		return;
>  	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
>  			(fpi_flags & FPI_SKIP_KASAN_POISON))
>  		return;
> -	kasan_free_pages(page, order);
> +	kasan_free_pages(page, order, init);
>  }
>  
>  /* Returns true if the struct page for the pfn is uninitialised */
> @@ -455,12 +455,12 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  }
>  #else
>  static inline void kasan_free_nondeferred_pages(struct page *page, int order,
> -							fpi_t fpi_flags)
> +						bool init, fpi_t fpi_flags)
>  {
>  	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
>  			(fpi_flags & FPI_SKIP_KASAN_POISON))
>  		return;
> -	kasan_free_pages(page, order);
> +	kasan_free_pages(page, order, init);
>  }
>  
>  static inline bool early_page_uninitialised(unsigned long pfn)
> @@ -1242,6 +1242,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  			unsigned int order, bool check_free, fpi_t fpi_flags)
>  {
>  	int bad = 0;
> +	bool init;
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
> @@ -1299,16 +1300,21 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		debug_check_no_obj_freed(page_address(page),
>  					   PAGE_SIZE << order);
>  	}
> -	if (want_init_on_free())
> -		kernel_init_free_pages(page, 1 << order);
>  
>  	kernel_poison_pages(page, 1 << order);
>  
>  	/*
> +	 * As memory initialization is integrated with hardware tag-based
> +	 * KASAN, kasan_free_pages and kernel_init_free_pages must be
> +	 * kept together to avoid discrepancies in behavior.
> +	 *
>  	 * With hardware tag-based KASAN, memory tags must be set before the
>  	 * page becomes unavailable via debug_pagealloc or arch_free_page.
>  	 */
> -	kasan_free_nondeferred_pages(page, order, fpi_flags);
> +	init = want_init_on_free();
> +	if (init && !IS_ENABLED(CONFIG_KASAN_HW_TAGS))

Doing the !IS_ENABLED(CONFIG_KASAN_HW_TAGS) check is awkward, and
assumes internal knowledge of the KASAN implementation and how all
current and future architectures that support HW_TAGS work.

Could we instead add a static inline helper to <linux/kasan.h>, e.g.
kasan_supports_init() or so?

That way, these checks won't grow uncontrollable if a future
architecture implements HW_TAGS but not init.

Thanks,
-- Marco
