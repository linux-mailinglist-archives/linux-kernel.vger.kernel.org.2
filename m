Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01330DE44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhBCPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhBCPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:32:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1576C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:32:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a1so24859535wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m3hMLAUjNEbRoV1KbnJIsefJTccBHrhGuifAQXw+Kb0=;
        b=NWGEYDLPDRWjhShRjdLmf72LluMf6MkMxvS+wVbWXaf6OsXVaZzd0wZZ+G3ceDBq7w
         ok61INFDuAUi84sYsopWinBCxNZ8qYQmDwDwmY7xHDI1vk3AxPEQJM+fpxa+A/f871yV
         NSHgCYQEOSX6tL+bmmuZE9QOpvCJ4BFu+gt9Ry5FyoshR3ZMvK5LbN4pEZ1kGW1qcF8k
         +V9UKlOmdYbB62xj9uJTO45/92LMaXuX7PPHKEjDQjtPdUKNgM43rwFqT7o92kxraAFw
         XZW3FWq2GHKPf5RlhguNGOwsZ27QZ2AUH4it9LQtCGzFD3j/mTVo0HkwcJX+CRKfHRng
         afXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m3hMLAUjNEbRoV1KbnJIsefJTccBHrhGuifAQXw+Kb0=;
        b=DOxfECpQl9VH5DRT5JNCQ/SloGNxzkZHR5nMAFnyHyDNPge/j1ZtHJXmH1ZAsAxZ1P
         sQ+IBMLWq8S3mE7Y+2HIe92xwz6xUkjMX4GfcVivJTPt2s71VdOxxpJR5HAP8m9vcNq2
         ru4kkDFAUXMRr6fJbzj5j+581BUzt5TTf1fyEPYAAxvS39Jx+KjWZrxRiHgddJQHjHDz
         3KTK59/B7W7juAi+aDhfVDGrAbpba7MSQPlpkqYgyqlcubRLWjvXzDuKKbwjdbpAT7LZ
         UAGuOaRggJVrMuUPqlb2bhfiSYTpqeMYwXlzSRTIL73cK5eCSTwP+SBeQauDZiQMjSKW
         QK/w==
X-Gm-Message-State: AOAM5324pjGtNqrjiYJA1rki6/flE8v1+6sf63B+5+pHMsDCnkcM3/Qe
        po8v236El51TLveTbx437drxtw==
X-Google-Smtp-Source: ABdhPJwq0DqLE250OUgOrPtpNgjrck9kELfDUILO3Az2ckr/7OkWfBxEcKvi0nYPXy2sVvcHMJG+VA==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr4284888wrr.114.1612366321734;
        Wed, 03 Feb 2021 07:32:01 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:b1de:c7d:30ce:1840])
        by smtp.gmail.com with ESMTPSA id h14sm3084106wmq.45.2021.02.03.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:32:00 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:31:54 +0100
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
Subject: Re: [PATCH 09/12] kasan: ensure poisoning size alignment
Message-ID: <YBrB6g9e+636CyFh@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <fee7c8c751dbf871e957935c347fcf7f1ca49beb.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee7c8c751dbf871e957935c347fcf7f1ca49beb.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> A previous changes d99f6a10c161 ("kasan: don't round_up too much")
> attempted to simplify the code by adding a round_up(size) call into
> kasan_poison(). While this allows to have less round_up() calls around
> the code, this results in round_up() being called multiple times.
> 
> This patch removes round_up() of size from kasan_poison() and ensures
> that all callers round_up() the size explicitly. This patch also adds
> WARN_ON() alignment checks for address and size to kasan_poison() and
> kasan_unpoison().
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/common.c |  9 ++++++---
>  mm/kasan/kasan.h  | 33 ++++++++++++++++++++-------------
>  mm/kasan/shadow.c | 37 ++++++++++++++++++++++---------------
>  3 files changed, 48 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a51d6ea580b0..5691cca69397 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -261,7 +261,8 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  
>  void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
> -	kasan_poison(object, cache->object_size, KASAN_KMALLOC_REDZONE);
> +	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
> +			KASAN_KMALLOC_REDZONE);
>  }
>  
>  /*
> @@ -348,7 +349,8 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  		return true;
>  	}
>  
> -	kasan_poison(object, cache->object_size, KASAN_KMALLOC_FREE);
> +	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
> +			KASAN_KMALLOC_FREE);
>  
>  	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
>  		return false;
> @@ -490,7 +492,8 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  	/* Poison the aligned part of the redzone. */
>  	redzone_start = round_up((unsigned long)(object + size),
>  				KASAN_GRANULE_SIZE);
> -	redzone_end = (unsigned long)object + cache->object_size;
> +	redzone_end = round_up((unsigned long)(object + cache->object_size),
> +				KASAN_GRANULE_SIZE);
>  	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
>  			   KASAN_KMALLOC_REDZONE);
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 6a2882997f23..2f7400a3412f 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -321,30 +321,37 @@ static inline u8 kasan_random_tag(void) { return 0; }
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
>  
> -static inline void kasan_poison(const void *address, size_t size, u8 value)
> +static inline void kasan_poison(const void *addr, size_t size, u8 value)
>  {
> -	address = kasan_reset_tag(address);
> +	addr = kasan_reset_tag(addr);
>  
>  	/* Skip KFENCE memory if called explicitly outside of sl*b. */
> -	if (is_kfence_address(address))
> +	if (is_kfence_address(addr))
>  		return;
>  
> -	hw_set_mem_tag_range((void *)address,
> -			round_up(size, KASAN_GRANULE_SIZE), value);
> +	if (WARN_ON((u64)addr & KASAN_GRANULE_MASK))
> +		return;
> +	if (WARN_ON(size & KASAN_GRANULE_MASK))
> +		return;
> +
> +	hw_set_mem_tag_range((void *)addr, size, value);
>  }
>  
> -static inline void kasan_unpoison(const void *address, size_t size)
> +static inline void kasan_unpoison(const void *addr, size_t size)
>  {
> -	u8 tag = get_tag(address);
> +	u8 tag = get_tag(addr);
>  
> -	address = kasan_reset_tag(address);
> +	addr = kasan_reset_tag(addr);
>  
>  	/* Skip KFENCE memory if called explicitly outside of sl*b. */
> -	if (is_kfence_address(address))
> +	if (is_kfence_address(addr))
>  		return;
>  
> -	hw_set_mem_tag_range((void *)address,
> -			round_up(size, KASAN_GRANULE_SIZE), tag);
> +	if (WARN_ON((u64)addr & KASAN_GRANULE_MASK))
> +		return;
> +	size = round_up(size, KASAN_GRANULE_SIZE);
> +
> +	hw_set_mem_tag_range((void *)addr, size, tag);
>  }
>  
>  static inline bool kasan_byte_accessible(const void *addr)
> @@ -361,7 +368,7 @@ static inline bool kasan_byte_accessible(const void *addr)
>  /**
>   * kasan_poison - mark the memory range as unaccessible
>   * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
> - * @size - range size
> + * @size - range size, must be aligned to KASAN_GRANULE_SIZE
>   * @value - value that's written to metadata for the range
>   *
>   * The size gets aligned to KASAN_GRANULE_SIZE before marking the range.
> @@ -371,7 +378,7 @@ void kasan_poison(const void *addr, size_t size, u8 value);
>  /**
>   * kasan_unpoison - mark the memory range as accessible
>   * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
> - * @size - range size
> + * @size - range size, can be unaligned
>   *
>   * For the tag-based modes, the @size gets aligned to KASAN_GRANULE_SIZE before
>   * marking the range.
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 1ed7817e4ee6..c97f51c557ea 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -69,7 +69,7 @@ void *memcpy(void *dest, const void *src, size_t len)
>  	return __memcpy(dest, src, len);
>  }
>  
> -void kasan_poison(const void *address, size_t size, u8 value)
> +void kasan_poison(const void *addr, size_t size, u8 value)
>  {
>  	void *shadow_start, *shadow_end;
>  
> @@ -78,55 +78,62 @@ void kasan_poison(const void *address, size_t size, u8 value)
>  	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
>  	 * addresses to this function.
>  	 */
> -	address = kasan_reset_tag(address);
> +	addr = kasan_reset_tag(addr);
>  
>  	/* Skip KFENCE memory if called explicitly outside of sl*b. */
> -	if (is_kfence_address(address))
> +	if (is_kfence_address(addr))
>  		return;
>  
> -	size = round_up(size, KASAN_GRANULE_SIZE);
> -	shadow_start = kasan_mem_to_shadow(address);
> -	shadow_end = kasan_mem_to_shadow(address + size);
> +	if (WARN_ON((u64)addr & KASAN_GRANULE_MASK))
> +		return;
> +	if (WARN_ON(size & KASAN_GRANULE_MASK))
> +		return;
> +
> +	shadow_start = kasan_mem_to_shadow(addr);
> +	shadow_end = kasan_mem_to_shadow(addr + size);
>  
>  	__memset(shadow_start, value, shadow_end - shadow_start);
>  }
>  EXPORT_SYMBOL(kasan_poison);
>  
>  #ifdef CONFIG_KASAN_GENERIC
> -void kasan_poison_last_granule(const void *address, size_t size)
> +void kasan_poison_last_granule(const void *addr, size_t size)
>  {
>  	if (size & KASAN_GRANULE_MASK) {
> -		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
> +		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
>  		*shadow = size & KASAN_GRANULE_MASK;
>  	}
>  }
>  #endif
>  
> -void kasan_unpoison(const void *address, size_t size)
> +void kasan_unpoison(const void *addr, size_t size)
>  {
> -	u8 tag = get_tag(address);
> +	u8 tag = get_tag(addr);
>  
>  	/*
>  	 * Perform shadow offset calculation based on untagged address, as
>  	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
>  	 * addresses to this function.
>  	 */
> -	address = kasan_reset_tag(address);
> +	addr = kasan_reset_tag(addr);
>  
>  	/*
>  	 * Skip KFENCE memory if called explicitly outside of sl*b. Also note
>  	 * that calls to ksize(), where size is not a multiple of machine-word
>  	 * size, would otherwise poison the invalid portion of the word.
>  	 */
> -	if (is_kfence_address(address))
> +	if (is_kfence_address(addr))
> +		return;
> +
> +	if (WARN_ON((u64)addr & KASAN_GRANULE_MASK))
>  		return;
>  
> -	/* Unpoison round_up(size, KASAN_GRANULE_SIZE) bytes. */
> -	kasan_poison(address, size, tag);
> +	/* Unpoison all granules that cover the object. */
> +	kasan_poison(addr, round_up(size, KASAN_GRANULE_SIZE), tag);
>  
>  	/* Partially poison the last granule for the generic mode. */
>  	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> -		kasan_poison_last_granule(address, size);
> +		kasan_poison_last_granule(addr, size);
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -- 
> 2.30.0.365.g02bc693789-goog
> 
