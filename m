Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13CE30D99E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhBCMOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhBCMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:14:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:14:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c127so4970005wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zSxY3nTKxJ1IPmcAhiUV2gxjS9POrRlqCu2+Tg/s2dQ=;
        b=jxovcCp23NxnX5Hp49LaYRb7dreVWiKfVkDKjHEssP9w0PKSQpvZzGDyuAe3Nv9vBl
         n/0Gv9uKM8/arUY5onnt0c2g3+1Rk/9E3TYsErSz2wwgOTZRi9mv5Nf+5d2RrTp6Z/6u
         DrHfChk0bxGbkDyS363tn+zSsrraNtnqAkyDNttztwQJzuGihNA52YRlvODyGcKaG4cB
         do5sX1ZQlLvTfu5Zcfl1hdmLXSHUW8KhjoR5Ue/V62RN/x6B5VmOo5T1WWldXNl1kkNV
         BH8ykIAcyRL/oDrmwJGOvu/7S2JA7QFHLanUYNTEv+l9wMkiW8P1csHIHjA0np34altC
         VRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zSxY3nTKxJ1IPmcAhiUV2gxjS9POrRlqCu2+Tg/s2dQ=;
        b=m4ZFzR/oidKKVlTmuZ/XQvk/BeYyMCoBTFDRKYmMN1pzk/mlZUCAx79FCT69x2oJAQ
         5WDRWtcW2CnSdbw0WsO+8ZtZYarm4ZthhkrmxnfcSgCzUAQRSJUy9PP41mao3sSmN4Qm
         8otYyCfP7ybhpr0kJLzcjo+xte8k77SE/gQzXWhdlJXjKEpjcG/2dbTXIL7tSonZH++0
         7epEVqD8CT2jlDBzo8DsRGPU2XRu6cBTNPsY+gOG2RbqFRsjT3sdlZNdIIUi0oAt0U7n
         E0rTXt0eJtWGNLp/ZpkpkIWl5XwVgakqFixYlpTvBH6FjJ1p7Ste/0vs8m0ySeutpePd
         +RuA==
X-Gm-Message-State: AOAM531xiJXUcMOggWt7tQEaMQexjaKai1nBIZ9bXd1unDAJ1NeC3YfW
        8BZYFP1fyGNTYLE7JUVYu7oldg==
X-Google-Smtp-Source: ABdhPJzHUcn98nIsrejDzYN9IFJdoqS9rkwCww87febSamOfAt2gIdft3snfHT97RjWrS9lEd4rMTQ==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr2512430wmk.70.1612354445997;
        Wed, 03 Feb 2021 04:14:05 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:b1de:c7d:30ce:1840])
        by smtp.gmail.com with ESMTPSA id t17sm2566202wmi.46.2021.02.03.04.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:14:05 -0800 (PST)
Date:   Wed, 3 Feb 2021 13:13:59 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] kasan: unify large kfree checks
Message-ID: <YBqThxfjUL1U9FCZ@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <dbef8131b70766f8d798d24bb1ab9ae75dadea61.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbef8131b70766f8d798d24bb1ab9ae75dadea61.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> Unify checks in kasan_kfree_large() and in kasan_slab_free_mempool()
> for large allocations as it's done for small kfree() allocations.
> 
> With this change, kasan_slab_free_mempool() starts checking that the
> first byte of the memory that's being freed is accessible.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kasan.h | 16 ++++++++--------
>  mm/kasan/common.c     | 36 ++++++++++++++++++++++++++----------
>  2 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 2d5de4092185..d53ea3c047bc 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -200,6 +200,13 @@ static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object)
>  	return false;
>  }
>  
> +void __kasan_kfree_large(void *ptr, unsigned long ip);
> +static __always_inline void kasan_kfree_large(void *ptr)
> +{
> +	if (kasan_enabled())
> +		__kasan_kfree_large(ptr, _RET_IP_);
> +}
> +
>  void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
>  static __always_inline void kasan_slab_free_mempool(void *ptr)
>  {
> @@ -247,13 +254,6 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
>  	return (void *)object;
>  }
>  
> -void __kasan_kfree_large(void *ptr, unsigned long ip);
> -static __always_inline void kasan_kfree_large(void *ptr)
> -{
> -	if (kasan_enabled())
> -		__kasan_kfree_large(ptr, _RET_IP_);
> -}
> -
>  /*
>   * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
>   * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> @@ -302,6 +302,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
>  {
>  	return false;
>  }
> +static inline void kasan_kfree_large(void *ptr) {}
>  static inline void kasan_slab_free_mempool(void *ptr) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>  				   gfp_t flags)
> @@ -322,7 +323,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>  {
>  	return (void *)object;
>  }
> -static inline void kasan_kfree_large(void *ptr) {}
>  static inline bool kasan_check_byte(const void *address)
>  {
>  	return true;
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 086bb77292b6..9c64a00bbf9c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -364,6 +364,31 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  	return ____kasan_slab_free(cache, object, ip, true);
>  }
>  
> +static bool ____kasan_kfree_large(void *ptr, unsigned long ip)
> +{
> +	if (ptr != page_address(virt_to_head_page(ptr))) {
> +		kasan_report_invalid_free(ptr, ip);
> +		return true;
> +	}
> +
> +	if (!kasan_byte_accessible(ptr)) {
> +		kasan_report_invalid_free(ptr, ip);
> +		return true;
> +	}
> +
> +	/*
> +	 * The object will be poisoned by kasan_free_pages() or
> +	 * kasan_slab_free_mempool().
> +	 */
> +
> +	return false;
> +}
> +
> +void __kasan_kfree_large(void *ptr, unsigned long ip)
> +{
> +	____kasan_kfree_large(ptr, ip);
> +}
> +
>  void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
>  {
>  	struct page *page;
> @@ -377,10 +402,8 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
>  	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
>  	 */
>  	if (unlikely(!PageSlab(page))) {
> -		if (ptr != page_address(page)) {
> -			kasan_report_invalid_free(ptr, ip);
> +		if (____kasan_kfree_large(ptr, ip))
>  			return;
> -		}
>  		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE);
>  	} else {
>  		____kasan_slab_free(page->slab_cache, ptr, ip, false);
> @@ -539,13 +562,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
>  		return ____kasan_kmalloc(page->slab_cache, object, size, flags);
>  }
>  
> -void __kasan_kfree_large(void *ptr, unsigned long ip)
> -{
> -	if (ptr != page_address(virt_to_head_page(ptr)))
> -		kasan_report_invalid_free(ptr, ip);
> -	/* The object will be poisoned by kasan_free_pages(). */
> -}
> -
>  bool __kasan_check_byte(const void *address, unsigned long ip)
>  {
>  	if (!kasan_byte_accessible(address)) {
> -- 
> 2.30.0.365.g02bc693789-goog
> 
