Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4830C504
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhBBQJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbhBBQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:07:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F885C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:06:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m13so21053131wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BQvmEctZ12mZ6s6zRO2SwQ7wsNfTEyJ3Wk+6Hh+PUyE=;
        b=noluI+hT0u0n3K4AFtItJigL4o/90YIkaNnIglJUvNgxxsY0XoGQyVxNEm/C8BqAcq
         QRo4AQocK9cNZkgHdW8EBYo9zYKfBgKeH3jnpt42RMmqowjFpSGy1VFSR0dzGOF984qM
         8eldQYUpXQBXfsKzoJDitMCkTL7R3O/jTbhvlbbIiEn+2yrGI9zEafnO2TpqWOs+FNSa
         i8BwgkJHeNwr4u4AHQWj2ukmOHeqphjjVm9CB5tQUduhipxYxYOR5wNvlHMHdIW/MmIg
         tVlKmcgXdxlbbhPoRtdafAy7oEHZAqIuGGtAvLIthKwLomDLNUf25nRcAkpx0g5GTOBM
         er4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BQvmEctZ12mZ6s6zRO2SwQ7wsNfTEyJ3Wk+6Hh+PUyE=;
        b=ptnyu5fSCdqRkTyjcIu6hVZulACc15DmUigARfQdd/Aphe+BwzzSSI/DttxoUXOC7C
         0OnUprYeorvLKzloK2OMsnY7dA8oSIM4tunTqtw1gsDr/TpVYL6/4PZZSvv2b6Y0OHDU
         RXVERfcF4tILMGb61UAUsYUBZG0Jb+uyOBEdbh5q5XogP7xDNhYo7Q6rpcy16VLD5Rh0
         wrD6p3hIopM5ArnnPlLnrhw0E/b5i950qWE/msK/N0xw5/t41w2X3xmylxh0gvZIJ/1J
         cGN+ILF7CIucstkAI50wvc5GyrRMoRl6DQiWnzARya96OaH7bAYmBqWtqKTD4z+z7h/N
         j4mg==
X-Gm-Message-State: AOAM5325CQ8JGqDNwfL5uUGX7fKqB7iqx0I8RwKJzyxdEVGjpawGaSDT
        NbEBnVLLr/diNjMbdDdHh5gWng==
X-Google-Smtp-Source: ABdhPJyU9xOEDmKsmdBb4P0kwHP8WK5HF/VnQ4yz1n8mCk8RiRnLQ33Q6NttZR6rsQODP7o4j5rm8Q==
X-Received: by 2002:a5d:47a2:: with SMTP id 2mr24388073wrb.393.1612281989503;
        Tue, 02 Feb 2021 08:06:29 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id i64sm2377327wmi.19.2021.02.02.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:06:28 -0800 (PST)
Date:   Tue, 2 Feb 2021 17:06:21 +0100
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
Subject: Re: [PATCH 01/12] kasan, mm: don't save alloc stacks twice
Message-ID: <YBl4fY54BN4PaLVG@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <c153f78b173df7537c9be6f2f3a888ddf0b42a3b.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c153f78b173df7537c9be6f2f3a888ddf0b42a3b.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> Currently KASAN saves allocation stacks in both kasan_slab_alloc() and
> kasan_kmalloc() annotations. This patch changes KASAN to save allocation
> stacks for slab objects from kmalloc caches in kasan_kmalloc() only,
> and stacks for other slab objects in kasan_slab_alloc() only.
> 
> This change requires ____kasan_kmalloc() knowing whether the object
> belongs to a kmalloc cache. This is implemented by adding a flag field
> to the kasan_info structure. That flag is only set for kmalloc caches
> via a new kasan_cache_create_kmalloc() annotation.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kasan.h |  9 +++++++++
>  mm/kasan/common.c     | 18 ++++++++++++++----
>  mm/slab_common.c      |  1 +
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 6d8f3227c264..2d5de4092185 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -83,6 +83,7 @@ static inline void kasan_disable_current(void) {}
>  struct kasan_cache {
>  	int alloc_meta_offset;
>  	int free_meta_offset;
> +	bool is_kmalloc;
>  };
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
> @@ -143,6 +144,13 @@ static __always_inline void kasan_cache_create(struct kmem_cache *cache,
>  		__kasan_cache_create(cache, size, flags);
>  }
>  
> +void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
> +static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
> +{
> +	if (kasan_enabled())
> +		__kasan_cache_create_kmalloc(cache);
> +}
> +
>  size_t __kasan_metadata_size(struct kmem_cache *cache);
>  static __always_inline size_t kasan_metadata_size(struct kmem_cache *cache)
>  {
> @@ -278,6 +286,7 @@ static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_cache_create(struct kmem_cache *cache,
>  				      unsigned int *size,
>  				      slab_flags_t *flags) {}
> +static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  static inline void kasan_poison_slab(struct page *page) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index fe852f3cfa42..374049564ea3 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -210,6 +210,11 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  		*size = optimal_size;
>  }
>  
> +void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
> +{
> +	cache->kasan_info.is_kmalloc = true;
> +}
> +
>  size_t __kasan_metadata_size(struct kmem_cache *cache)
>  {
>  	if (!kasan_stack_collection_enabled())
> @@ -394,17 +399,22 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
>  	}
>  }
>  
> -static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> +static void set_alloc_info(struct kmem_cache *cache, void *object,
> +				gfp_t flags, bool kmalloc)
>  {
>  	struct kasan_alloc_meta *alloc_meta;
>  
> +	/* Don't save alloc info for kmalloc caches in kasan_slab_alloc(). */
> +	if (cache->kasan_info.is_kmalloc && !kmalloc)
> +		return;
> +
>  	alloc_meta = kasan_get_alloc_meta(cache, object);
>  	if (alloc_meta)
>  		kasan_set_track(&alloc_meta->alloc_track, flags);
>  }
>  
>  static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> -				size_t size, gfp_t flags, bool keep_tag)
> +				size_t size, gfp_t flags, bool kmalloc)
>  {
>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
> @@ -423,7 +433,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  				KASAN_GRANULE_SIZE);
>  	redzone_end = round_up((unsigned long)object + cache->object_size,
>  				KASAN_GRANULE_SIZE);
> -	tag = assign_tag(cache, object, false, keep_tag);
> +	tag = assign_tag(cache, object, false, kmalloc);
>  
>  	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
>  	kasan_unpoison(set_tag(object, tag), size);
> @@ -431,7 +441,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  			   KASAN_KMALLOC_REDZONE);
>  
>  	if (kasan_stack_collection_enabled())
> -		set_alloc_info(cache, (void *)object, flags);
> +		set_alloc_info(cache, (void *)object, flags, kmalloc);

It doesn't bother me too much, but: 'bool kmalloc' shadows function
'kmalloc' so this is technically fine, but using 'kmalloc' as the
variable name here might be confusing and there is a small chance it
might cause problems in a future refactor.

>  	return set_tag(object, tag);
>  }
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9aa3d2fe4c55..39d1a8ff9bb8 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -647,6 +647,7 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
>  		panic("Out of memory when creating slab %s\n", name);
>  
>  	create_boot_cache(s, name, size, flags, useroffset, usersize);
> +	kasan_cache_create_kmalloc(s);
>  	list_add(&s->list, &slab_caches);
>  	s->refcount = 1;
>  	return s;
> -- 
> 2.30.0.365.g02bc693789-goog
> 
