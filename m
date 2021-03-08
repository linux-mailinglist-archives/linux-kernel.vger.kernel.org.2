Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC3330CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCHLqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhCHLpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:45:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E16C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:45:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l12so11105820wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 03:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCYaodgn23RpIhtLxdUS0nQYEGZQi2gHsnzCEWxqT00=;
        b=LnjULmcfZdIhPoi+O0rkNKPVbzSSqaT/HB91JBDOs4Z4GCjdr7uiw926tDU+oHaWDZ
         JCsqzhLPLY4CNjUWgldVxKCPT+Lp+96EM6UWZFzm4wC28AT71vchFa2/1fZOJG9MLNQq
         vurZGIPsqbAPCk8xczDRm16/JQrWeS+Jinlk3smweNIqWR66/Xrl62izNPtT2KN6xJJO
         jN0/e7CXjwkYM5JsPEgqpzqctGCvXxSHoyNHYZxjvP13hQVu8gOql4uaGA3xFFcm5Ye6
         m1FGQpX2opcLsyFc5K/lGh06/w9E+n6PliOAcYVQ1ZYx9xUC/p7E8/utoByBKvejFRcI
         hmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCYaodgn23RpIhtLxdUS0nQYEGZQi2gHsnzCEWxqT00=;
        b=CELowaq6cHrhMm284XghG0LfTY64l/wyxTDvCgVmMo46GGHriLd+XU1CnSQZK+Y7iL
         /p88cjG5cN3tXJiyjrHXdY+RaIIIRsXT0QURxOnpY8vMiuiSvfWhCF2N0PPmTRgzFeL5
         BKtLiVhCks60DGu5r4FDPI9M/A2xSTTanaKQPjDcS0qyFqmqu3bfedjA+8ftFte1Kv3o
         n3WEK/PG7fBSAiFmjEUll5EKEf+6CycqJIkkjzYyicCROC4gN4Hfx+SGS71lKyDpogqA
         FDDJU5Y7jtISUF2KRVhAYM9zJ8miCBo/84byBQYqB+EngMVB417nOVTtwIebactNZBgA
         2aLg==
X-Gm-Message-State: AOAM533G6uFK7tDl20AfaWCPN2R99/gX+73EVE4hIt0ZlvBJybKUkIrK
        7S8IqCbsnlTwcuLoFp3ppWlhdw==
X-Google-Smtp-Source: ABdhPJwRSPlTzcZm0ECLRCu1KHbIaQ2MJNcKKoSiOlHJpmNR8Av1XU9V0Ii3vTqTzePs6P4gMqjaqw==
X-Received: by 2002:adf:f148:: with SMTP id y8mr21886984wro.107.1615203952103;
        Mon, 08 Mar 2021 03:45:52 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:9d1d:b6a0:d116:531b])
        by smtp.gmail.com with ESMTPSA id p16sm21167989wrt.54.2021.03.08.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:45:51 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:45:45 +0100
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
Subject: Re: [PATCH 5/5] kasan, mm: integrate slab init_on_free with HW_TAGS
Message-ID: <YEYOaR5jQXe6imp0@elver.google.com>
References: <cover.1614989433.git.andreyknvl@google.com>
 <a313f27d68ad479eda7b36a114bb2ffd56d80bbb.1614989433.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a313f27d68ad479eda7b36a114bb2ffd56d80bbb.1614989433.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 01:15AM +0100, Andrey Konovalov wrote:
> This change uses the previously added memory initialization feature
> of HW_TAGS KASAN routines for slab memory when init_on_free is enabled.
> 
> With this change, memory initialization memset() is no longer called
> when both HW_TAGS KASAN and init_on_free are enabled. Instead, memory
> is initialized in KASAN runtime.
> 
> For SLUB, the memory initialization memset() is moved into
> slab_free_hook() that currently directly follows the initialization loop.
> A new argument is added to slab_free_hook() that indicates whether to
> initialize the memory or not.
> 
> To avoid discrepancies with which memory gets initialized that can be
> caused by future changes, both KASAN hook and initialization memset()
> are put together and a warning comment is added.
> 
> Combining setting allocation tags with memory initialization improves
> HW_TAGS KASAN performance when init_on_free is enabled.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  include/linux/kasan.h | 10 ++++++----
>  mm/kasan/common.c     | 13 +++++++------
>  mm/slab.c             | 15 +++++++++++----
>  mm/slub.c             | 43 ++++++++++++++++++++++++-------------------
>  4 files changed, 48 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bb756f6c73b5..1df0f7f0b493 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -193,11 +193,13 @@ static __always_inline void * __must_check kasan_init_slab_obj(
>  	return (void *)object;
>  }
>  
> -bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> -static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object)
> +bool __kasan_slab_free(struct kmem_cache *s, void *object,
> +			unsigned long ip, bool init);
> +static __always_inline bool kasan_slab_free(struct kmem_cache *s,
> +						void *object, bool init)
>  {
>  	if (kasan_enabled())
> -		return __kasan_slab_free(s, object, _RET_IP_);
> +		return __kasan_slab_free(s, object, _RET_IP_, init);
>  	return false;
>  }
>  
> @@ -299,7 +301,7 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
>  {
>  	return (void *)object;
>  }
> -static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
> +static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init)
>  {
>  	return false;
>  }
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 7ea747b18c26..623cf94288a2 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -322,8 +322,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>  	return (void *)object;
>  }
>  
> -static inline bool ____kasan_slab_free(struct kmem_cache *cache,
> -				void *object, unsigned long ip, bool quarantine)
> +static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> +				unsigned long ip, bool quarantine, bool init)
>  {
>  	u8 tag;
>  	void *tagged_object;
> @@ -351,7 +351,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache,
>  	}
>  
>  	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
> -			KASAN_KMALLOC_FREE, false);
> +			KASAN_KMALLOC_FREE, init);
>  
>  	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
>  		return false;
> @@ -362,9 +362,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache,
>  	return kasan_quarantine_put(cache, object);
>  }
>  
> -bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
> +bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> +				unsigned long ip, bool init)
>  {
> -	return ____kasan_slab_free(cache, object, ip, true);
> +	return ____kasan_slab_free(cache, object, ip, true, init);
>  }
>  
>  static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
> @@ -409,7 +410,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
>  			return;
>  		kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE, false);
>  	} else {
> -		____kasan_slab_free(page->slab_cache, ptr, ip, false);
> +		____kasan_slab_free(page->slab_cache, ptr, ip, false, false);
>  	}
>  }
>  
> diff --git a/mm/slab.c b/mm/slab.c
> index 936dd686dec9..d12ce9e5c3ed 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3425,17 +3425,24 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
>  					 unsigned long caller)
>  {
> +	bool init;
> +
>  	if (is_kfence_address(objp)) {
>  		kmemleak_free_recursive(objp, cachep->flags);
>  		__kfence_free(objp);
>  		return;
>  	}
>  
> -	if (unlikely(slab_want_init_on_free(cachep)))
> +	/*
> +	 * As memory initialization is integrated with hardware tag-based

This may no longer be true if the HW-tags architecture doesn't support
init (although currently it is certainly true). 

Perhaps: "As memory initialization may be accelerated by some KASAN
implementations (such as some HW_TAGS architectures) ..."

or whatever else is appropriate.

> +	 * KASAN, kasan_slab_free and initialization memset must be
> +	 * kept together to avoid discrepancies in behavior.
> +	 */
> +	init = slab_want_init_on_free(cachep);
> +	if (init && !IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>  		memset(objp, 0, cachep->object_size);

Same as the other patch, it seems awkward to have
!IS_ENABLED(CONFIG_KASAN_HW_TAGS) rather than a kasan_*() helper that
returns this information.

> -
> -	/* Put the object into the quarantine, don't touch it for now. */
> -	if (kasan_slab_free(cachep, objp))
> +	/* KASAN might put objp into memory quarantine, delaying its reuse. */
> +	if (kasan_slab_free(cachep, objp, init))
>  		return;
>  
>  	/* Use KCSAN to help debug racy use-after-free. */
> diff --git a/mm/slub.c b/mm/slub.c
> index f53df23760e3..c2755670d6bd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1532,7 +1532,8 @@ static __always_inline void kfree_hook(void *x)
>  	kasan_kfree_large(x);
>  }
>  
> -static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
> +static __always_inline bool slab_free_hook(struct kmem_cache *s,
> +						void *x, bool init)
>  {
>  	kmemleak_free_recursive(x, s->flags);
>  
> @@ -1558,8 +1559,25 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
>  		__kcsan_check_access(x, s->object_size,
>  				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
>  
> -	/* KASAN might put x into memory quarantine, delaying its reuse */
> -	return kasan_slab_free(s, x);
> +	/*
> +	 * As memory initialization is integrated with hardware tag-based
> +	 * KASAN, kasan_slab_free and initialization memset's must be
> +	 * kept together to avoid discrepancies in behavior.
> +	 *
> +	 * The initialization memset's clear the object and the metadata,
> +	 * but don't touch the SLAB redzone.
> +	 */
> +	if (init) {
> +		int rsize;
> +
> +		if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> +			memset(kasan_reset_tag(x), 0, s->object_size);
> +		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
> +		memset((char *)kasan_reset_tag(x) + s->inuse, 0,
> +		       s->size - s->inuse - rsize);
> +	}
> +	/* KASAN might put x into memory quarantine, delaying its reuse. */
> +	return kasan_slab_free(s, x, init);
>  }
>  
>  static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> @@ -1569,10 +1587,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  	void *object;
>  	void *next = *head;
>  	void *old_tail = *tail ? *tail : *head;
> -	int rsize;
>  
>  	if (is_kfence_address(next)) {
> -		slab_free_hook(s, next);
> +		slab_free_hook(s, next, false);
>  		return true;
>  	}
>  
> @@ -1584,20 +1601,8 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  		object = next;
>  		next = get_freepointer(s, object);
>  
> -		if (slab_want_init_on_free(s)) {
> -			/*
> -			 * Clear the object and the metadata, but don't touch
> -			 * the redzone.
> -			 */
> -			memset(kasan_reset_tag(object), 0, s->object_size);
> -			rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad
> -							   : 0;
> -			memset((char *)kasan_reset_tag(object) + s->inuse, 0,
> -			       s->size - s->inuse - rsize);
> -
> -		}
>  		/* If object's reuse doesn't have to be delayed */
> -		if (!slab_free_hook(s, object)) {
> +		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
>  			/* Move object to the new freelist */
>  			set_freepointer(s, object, *head);
>  			*head = object;
> @@ -3235,7 +3240,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
>  	}
>  
>  	if (is_kfence_address(object)) {
> -		slab_free_hook(df->s, object);
> +		slab_free_hook(df->s, object, false);
>  		__kfence_free(object);
>  		p[size] = NULL; /* mark object processed */
>  		return size;
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 
