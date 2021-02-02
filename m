Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DE30C5A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhBBQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhBBQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:26:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C8C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:25:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so21151268wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Tllhc+5c0Pfht0qAuJDHzixy31AJS/JnPan2WRpzvQ=;
        b=RqAcaM9YecY2waqMIfSfA+rVg83x1vQ1KtzrriKCrCQ5wyv+51jCevVxWgtZQDjmsS
         62o9oQWsFv0nl4bk9Bg+3vvuuZ3Nk1gyWDfYZ07ycVX0mV3NzjeQOlSOFVgR94B1kJMS
         tPfQKesW7i1nQCCint25upyt3g/DuRoZGyQQ0EJFfSRFsBGJj+QbVv0MzIFdRlIECb9R
         B8hga8aSpYduc7ifoC87FFb+zSBHxyTF17elbV4jaiKMcwnibdRkoIVC4YsOw8haIApO
         yieuQkbVuSHpT2KusaKiXdqE6aB8fi1KooddGYblRVRAiQLKQchB0NGhfbocbuU0TqfF
         ulEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Tllhc+5c0Pfht0qAuJDHzixy31AJS/JnPan2WRpzvQ=;
        b=tyOf2er9Mt25jPSS2P1k7RGQkgpMkGDVW/QtPU1zt5+PMGYCDs43FBNb4NMS1kBW3Y
         sLQ4OILRy7AhEz1A+sEx2Q8OOyjCjxSdllRhvdqdMXQAf/wpPoqNQeuFLgyUFM10NsTf
         HiqqhCa830WAQ/lOWB2p4gHdjbPbEyO732e1rwGPZl31qnHbTvp4dAsh/oSNWtnkk8lS
         fzjNR1TneiY7PsDI8DLMLVepXfEvXYoU7vZcjWRHmk9M5SOzQFjkuXF2BzaTDWZosTT6
         O9QSwb4fbJOuM1VjtZf8uIfV4uhfnU9iTHe6zr1f0aFqsalJTWqAI3SEOUs1J/K2kvCZ
         8Rig==
X-Gm-Message-State: AOAM531pZd577Z+4+oY82dTdKlmDvpsIBJZsXVt5lR8mu8c0p7H4kyCC
        HTJIIrbNXKmADREQ3MByXeJALQ==
X-Google-Smtp-Source: ABdhPJzsQNwd1wsYhyDrsGvsGsruJZE1/fS2G+m3FeIFgjgiLm0coLZXm4QRGJkliuWJV4js1w1qWg==
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr24294755wrw.252.1612283153748;
        Tue, 02 Feb 2021 08:25:53 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id c20sm3790013wmb.38.2021.02.02.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:25:52 -0800 (PST)
Date:   Tue, 2 Feb 2021 17:25:47 +0100
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
Subject: Re: [PATCH 02/12] kasan, mm: optimize kmalloc poisoning
Message-ID: <YBl9C+q84BqiFd4F@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <b3a02f4f7cda00c87af170c1bf555996a9c6788c.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a02f4f7cda00c87af170c1bf555996a9c6788c.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> For allocations from kmalloc caches, kasan_kmalloc() always follows
> kasan_slab_alloc(). Currenly, both of them unpoison the whole object,
> which is unnecessary.
> 
> This patch provides separate implementations for both annotations:
> kasan_slab_alloc() unpoisons the whole object, and kasan_kmalloc()
> only poisons the redzone.
> 
> For generic KASAN, the redzone start might not be aligned to
> KASAN_GRANULE_SIZE. Therefore, the poisoning is split in two parts:
> kasan_poison_last_granule() poisons the unaligned part, and then
> kasan_poison() poisons the rest.
> 
> This patch also clarifies alignment guarantees of each of the poisoning
> functions and drops the unnecessary round_up() call for redzone_end.
> 
> With this change, the early SLUB cache annotation needs to be changed to
> kasan_slab_alloc(), as kasan_kmalloc() doesn't unpoison objects now.
> The number of poisoned bytes for objects in this cache stays the same, as
> kmem_cache_node->object_size is equal to sizeof(struct kmem_cache_node).
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c | 93 +++++++++++++++++++++++++++++++----------------
>  mm/kasan/kasan.h  | 43 +++++++++++++++++++++-
>  mm/kasan/shadow.c | 28 +++++++-------
>  mm/slub.c         |  3 +-
>  4 files changed, 119 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 374049564ea3..128cb330ca73 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -278,21 +278,11 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>   *    based on objects indexes, so that objects that are next to each other
>   *    get different tags.
>   */
> -static u8 assign_tag(struct kmem_cache *cache, const void *object,
> -			bool init, bool keep_tag)
> +static u8 assign_tag(struct kmem_cache *cache, const void *object, bool init)
>  {
>  	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>  		return 0xff;
>  
> -	/*
> -	 * 1. When an object is kmalloc()'ed, two hooks are called:
> -	 *    kasan_slab_alloc() and kasan_kmalloc(). We assign the
> -	 *    tag only in the first one.
> -	 * 2. We reuse the same tag for krealloc'ed objects.
> -	 */
> -	if (keep_tag)
> -		return get_tag(object);
> -
>  	/*
>  	 * If the cache neither has a constructor nor has SLAB_TYPESAFE_BY_RCU
>  	 * set, assign a tag when the object is being allocated (init == false).
> @@ -325,7 +315,7 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>  	}
>  
>  	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
> -	object = set_tag(object, assign_tag(cache, object, true, false));
> +	object = set_tag(object, assign_tag(cache, object, true));
>  
>  	return (void *)object;
>  }
> @@ -413,12 +403,46 @@ static void set_alloc_info(struct kmem_cache *cache, void *object,
>  		kasan_set_track(&alloc_meta->alloc_track, flags);
>  }
>  
> +void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
> +					void *object, gfp_t flags)
> +{
> +	u8 tag;
> +	void *tagged_object;
> +
> +	if (gfpflags_allow_blocking(flags))
> +		kasan_quarantine_reduce();
> +
> +	if (unlikely(object == NULL))
> +		return NULL;
> +
> +	if (is_kfence_address(object))
> +		return (void *)object;
> +
> +	/*
> +	 * Generate and assign random tag for tag-based modes.
> +	 * Tag is ignored in set_tag() for the generic mode.
> +	 */
> +	tag = assign_tag(cache, object, false);
> +	tagged_object = set_tag(object, tag);
> +
> +	/*
> +	 * Unpoison the whole object.
> +	 * For kmalloc() allocations, kasan_kmalloc() will do precise poisoning.
> +	 */
> +	kasan_unpoison(tagged_object, cache->object_size);
> +
> +	/* Save alloc info (if possible) for non-kmalloc() allocations. */
> +	if (kasan_stack_collection_enabled())
> +		set_alloc_info(cache, (void *)object, flags, false);
> +
> +	return tagged_object;
> +}
> +
>  static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> -				size_t size, gfp_t flags, bool kmalloc)
> +					size_t size, gfp_t flags)
>  {
>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
> -	u8 tag;
>  
>  	if (gfpflags_allow_blocking(flags))
>  		kasan_quarantine_reduce();
> @@ -429,33 +453,41 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  	if (is_kfence_address(kasan_reset_tag(object)))
>  		return (void *)object;
>  
> +	/*
> +	 * The object has already been unpoisoned by kasan_slab_alloc() for
> +	 * kmalloc() or by ksize() for krealloc().
> +	 */
> +
> +	/*
> +	 * The redzone has byte-level precision for the generic mode.
> +	 * Partially poison the last object granule to cover the unaligned
> +	 * part of the redzone.
> +	 */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +		kasan_poison_last_granule((void *)object, size);
> +
> +	/* Poison the aligned part of the redzone. */
>  	redzone_start = round_up((unsigned long)(object + size),
>  				KASAN_GRANULE_SIZE);
> -	redzone_end = round_up((unsigned long)object + cache->object_size,
> -				KASAN_GRANULE_SIZE);
> -	tag = assign_tag(cache, object, false, kmalloc);
> -
> -	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
> -	kasan_unpoison(set_tag(object, tag), size);
> +	redzone_end = (unsigned long)object + cache->object_size;
>  	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
>  			   KASAN_KMALLOC_REDZONE);
>  
> +	/*
> +	 * Save alloc info (if possible) for kmalloc() allocations.
> +	 * This also rewrites the alloc info when called from kasan_krealloc().
> +	 */
>  	if (kasan_stack_collection_enabled())
> -		set_alloc_info(cache, (void *)object, flags, kmalloc);
> +		set_alloc_info(cache, (void *)object, flags, true);
>  
> -	return set_tag(object, tag);
> -}
> -
> -void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
> -					void *object, gfp_t flags)
> -{
> -	return ____kasan_kmalloc(cache, object, cache->object_size, flags, false);
> +	/* Keep the tag that was set by kasan_slab_alloc(). */
> +	return (void *)object;
>  }
>  
>  void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  					size_t size, gfp_t flags)
>  {
> -	return ____kasan_kmalloc(cache, object, size, flags, true);
> +	return ____kasan_kmalloc(cache, object, size, flags);
>  }
>  EXPORT_SYMBOL(__kasan_kmalloc);
>  
> @@ -496,8 +528,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
>  	if (unlikely(!PageSlab(page)))
>  		return __kasan_kmalloc_large(object, size, flags);
>  	else
> -		return ____kasan_kmalloc(page->slab_cache, object, size,
> -						flags, true);
> +		return ____kasan_kmalloc(page->slab_cache, object, size, flags);
>  }
>  
>  void __kasan_kfree_large(void *ptr, unsigned long ip)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index dd14e8870023..6a2882997f23 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -358,12 +358,51 @@ static inline bool kasan_byte_accessible(const void *addr)
>  
>  #else /* CONFIG_KASAN_HW_TAGS */
>  
> -void kasan_poison(const void *address, size_t size, u8 value);
> -void kasan_unpoison(const void *address, size_t size);
> +/**
> + * kasan_poison - mark the memory range as unaccessible
> + * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
> + * @size - range size
> + * @value - value that's written to metadata for the range
> + *
> + * The size gets aligned to KASAN_GRANULE_SIZE before marking the range.
> + */
> +void kasan_poison(const void *addr, size_t size, u8 value);
> +
> +/**
> + * kasan_unpoison - mark the memory range as accessible
> + * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
> + * @size - range size
> + *
> + * For the tag-based modes, the @size gets aligned to KASAN_GRANULE_SIZE before
> + * marking the range.
> + * For the generic mode, the last granule of the memory range gets partially
> + * unpoisoned based on the @size.
> + */
> +void kasan_unpoison(const void *addr, size_t size);
> +
>  bool kasan_byte_accessible(const void *addr);
>  
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
> +#ifdef CONFIG_KASAN_GENERIC
> +
> +/**
> + * kasan_poison_last_granule - mark the last granule of the memory range as
> + * unaccessible
> + * @addr - range start address, must be aligned to KASAN_GRANULE_SIZE
> + * @size - range size
> + *
> + * This function is only available for the generic mode, as it's the only mode
> + * that has partially poisoned memory granules.
> + */
> +void kasan_poison_last_granule(const void *address, size_t size);
> +
> +#else /* CONFIG_KASAN_GENERIC */
> +
> +static inline void kasan_poison_last_granule(const void *address, size_t size) { }
> +
> +#endif /* CONFIG_KASAN_GENERIC */
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 1372a2fc0ca9..1ed7817e4ee6 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -69,10 +69,6 @@ void *memcpy(void *dest, const void *src, size_t len)
>  	return __memcpy(dest, src, len);
>  }
>  
> -/*
> - * Poisons the shadow memory for 'size' bytes starting from 'addr'.
> - * Memory addresses should be aligned to KASAN_GRANULE_SIZE.
> - */
>  void kasan_poison(const void *address, size_t size, u8 value)
>  {
>  	void *shadow_start, *shadow_end;
> @@ -83,12 +79,12 @@ void kasan_poison(const void *address, size_t size, u8 value)
>  	 * addresses to this function.
>  	 */
>  	address = kasan_reset_tag(address);
> -	size = round_up(size, KASAN_GRANULE_SIZE);
>  
>  	/* Skip KFENCE memory if called explicitly outside of sl*b. */
>  	if (is_kfence_address(address))
>  		return;
>  
> +	size = round_up(size, KASAN_GRANULE_SIZE);
>  	shadow_start = kasan_mem_to_shadow(address);
>  	shadow_end = kasan_mem_to_shadow(address + size);
>  
> @@ -96,6 +92,16 @@ void kasan_poison(const void *address, size_t size, u8 value)
>  }
>  EXPORT_SYMBOL(kasan_poison);
>  
> +#ifdef CONFIG_KASAN_GENERIC
> +void kasan_poison_last_granule(const void *address, size_t size)
> +{
> +	if (size & KASAN_GRANULE_MASK) {
> +		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
> +		*shadow = size & KASAN_GRANULE_MASK;
> +	}
> +}
> +#endif

The function declaration still needs to exist in the dead branch if
!IS_ENABLED(CONFIG_KASAN_GENERIC). It appears in that case it's declared
(in kasan.h), but not defined.  We shouldn't get linker errors because
the optimizer should remove the dead branch. Nevertheless, is this code
generally acceptable?

>  void kasan_unpoison(const void *address, size_t size)
>  {
>  	u8 tag = get_tag(address);
> @@ -115,16 +121,12 @@ void kasan_unpoison(const void *address, size_t size)
>  	if (is_kfence_address(address))
>  		return;
>  
> +	/* Unpoison round_up(size, KASAN_GRANULE_SIZE) bytes. */
>  	kasan_poison(address, size, tag);
>  
> -	if (size & KASAN_GRANULE_MASK) {
> -		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
> -
> -		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> -			*shadow = tag;
> -		else /* CONFIG_KASAN_GENERIC */
> -			*shadow = size & KASAN_GRANULE_MASK;
> -	}
> +	/* Partially poison the last granule for the generic mode. */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +		kasan_poison_last_granule(address, size);
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> diff --git a/mm/slub.c b/mm/slub.c
> index 176b1cb0d006..e564008c2329 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3565,8 +3565,7 @@ static void early_kmem_cache_node_alloc(int node)
>  	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
>  	init_tracking(kmem_cache_node, n);
>  #endif
> -	n = kasan_kmalloc(kmem_cache_node, n, sizeof(struct kmem_cache_node),
> -		      GFP_KERNEL);
> +	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL);
>  	page->freelist = get_freepointer(kmem_cache_node, n);
>  	page->inuse = 1;
>  	page->frozen = 0;
> -- 
> 2.30.0.365.g02bc693789-goog
> 
