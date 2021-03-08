Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D233135B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCHQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:27:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA833C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:27:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1223422wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IiyDYjHRKW2wceZv/UNYcoAbgvHVesLsvlpudR7A0lk=;
        b=g4jVQNVTs5FWPseF1hKPa0IfQn9fEon7XGyisde6Vu5MMjP6+IH0XZ1qdvWSSkbSQw
         wOnEya9vBXdGzkUzi3c7RgTuqTANxW4ZieRDhUgUdIPDrsUbtHXvgjTkn/eh8Gg/BRP2
         2yNX4Gw2+qig4lqOgUV91bOLY07/q5MCls/Vd6kp+FBLudkMF/n1UAuvH4Ds6vKdDfl3
         60N//2jikbbS2XGNK77E51bKtUX0hWYkGudd4zsWNdNZJW5E+eQgioehOk56a1mmNrE3
         tJZOqqUyJnrO9ZHZ0KKs7Ax3arFPOX8GGZ/OaSQAU8SAi1dOUBtcNgAvtKhsWZUZ+N8p
         aEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IiyDYjHRKW2wceZv/UNYcoAbgvHVesLsvlpudR7A0lk=;
        b=BfFFoBIN6ExwLg4OBgEIQDM22GzHUXLJ0F1hPLAnxteAek9Sd4UoXW8DgKrq2H7rgt
         fg4Niu0c4BRkTFfZPVkRrseEI69c5KWD8jq0/9HkqW112aMAvazU1mDZBy2HJxpOQ19P
         xhKVMzEAjuB67Kjc2OOdMxj5yLjaDQ2iYQLu+di5G2BpkF34a2L+983AlOxzZLeUlSbI
         ZYWd+Px3N0Lv0nA4z5+XfTE4k9V8Y0x/xcEpgmKW7DPXLEW8ALFJI/9BrmYF+YR3y5Z8
         DBEVlW8DpFlUBX7gClKVVkOMvPmhf/xXltVCflzIiLJhiCWCe6/U6pQfCOqEjB+qZcvi
         JoHg==
X-Gm-Message-State: AOAM532A/Da3x62EQYZlSs/2RD7q5UlOX6qhqNhFcuk19FhrFt0/n9mm
        KOxaEmFN9QU81GYJ5snIY7JQeQ==
X-Google-Smtp-Source: ABdhPJwp1ErH6NyBV4/RxrA778bAOW5cuBCGayyDDhuAvxokw6ZL8OiYcgM0xp9gDIrDRpbUbViIOQ==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr23208338wmf.17.1615220841452;
        Mon, 08 Mar 2021 08:27:21 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:9d1d:b6a0:d116:531b])
        by smtp.gmail.com with ESMTPSA id 36sm21063862wrh.94.2021.03.08.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 08:27:20 -0800 (PST)
Date:   Mon, 8 Mar 2021 17:27:15 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] kasan, mm: integrate slab init_on_free with
 HW_TAGS
Message-ID: <YEZQY2knlfz2Ku8w@elver.google.com>
References: <cover.1615218180.git.andreyknvl@google.com>
 <fe28431edf155e4749cd0f0b25c957f50744914d.1615218180.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe28431edf155e4749cd0f0b25c957f50744914d.1615218180.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:55PM +0100, Andrey Konovalov wrote:
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

Reviewed-by: Marco Elver <elver@google.com>

But same as other patch, given the internal API change, let's see if
somebody else responds.

> ---
>  include/linux/kasan.h | 10 ++++++----
>  mm/kasan/common.c     | 13 +++++++------
>  mm/slab.c             | 15 +++++++++++----
>  mm/slub.c             | 43 ++++++++++++++++++++++++-------------------
>  4 files changed, 48 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 85f2a8786606..ed08c419a687 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -203,11 +203,13 @@ static __always_inline void * __must_check kasan_init_slab_obj(
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
> @@ -313,7 +315,7 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
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
> index 936dd686dec9..3adfe5bc3e2e 100644
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
> +	 * As memory initialization might be integrated into KASAN,
> +	 * kasan_slab_free and initialization memset must be
> +	 * kept together to avoid discrepancies in behavior.
> +	 */
> +	init = slab_want_init_on_free(cachep);
> +	if (init && !kasan_has_integrated_init())
>  		memset(objp, 0, cachep->object_size);
> -
> -	/* Put the object into the quarantine, don't touch it for now. */
> -	if (kasan_slab_free(cachep, objp))
> +	/* KASAN might put objp into memory quarantine, delaying its reuse. */
> +	if (kasan_slab_free(cachep, objp, init))
>  		return;
>  
>  	/* Use KCSAN to help debug racy use-after-free. */
> diff --git a/mm/slub.c b/mm/slub.c
> index f53df23760e3..37afe6251bcc 100644
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
> +	 * As memory initialization might be integrated into KASAN,
> +	 * kasan_slab_free and initialization memset's must be
> +	 * kept together to avoid discrepancies in behavior.
> +	 *
> +	 * The initialization memset's clear the object and the metadata,
> +	 * but don't touch the SLAB redzone.
> +	 */
> +	if (init) {
> +		int rsize;
> +
> +		if (!kasan_has_integrated_init())
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
