Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6B30DEBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhBCPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbhBCPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:52:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD18C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:51:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m13so24956101wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/vTmytfnHf8bSBtRdC4NPN+aY/KtT7liekrT8jCTRw=;
        b=opmr3FHE2TNxylL9qrL3VCPPX/vR+oTiZPV3+yNJ3oDsbprIIJqpAyXpXpxF1knDgn
         GhSrc8eVFebQUjT4pgW3MEE/vmbk+b2gQ/q2qDnCQ824F8bIfBfhWvk0DpqxabeyO5s7
         ziy/ZjiKZxTCS6Lhce5scCX2JJIhHpVuLZQga1SxEJ8tco5VkP1OQ5X3ayaRzFebVpfh
         u23awiGivr2HiDWTH2UbctnGbpPRy5EMqP5UbV3sTpI1KfdnlE9Ln6jQYGfXjMvvtgt7
         jN5OyNhhYzi4QxXtQHgd0G4ALm2BHi4MrHGUHSTAovAUWQ9hoNLX3rqZoiZnqj7cBbN5
         KxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/vTmytfnHf8bSBtRdC4NPN+aY/KtT7liekrT8jCTRw=;
        b=At6TJSsW9d9JZr8bv/4wD2n+AYnCcGPjFuHVcuzHsc9ry+tn/u9iV3hQOzBoBfyzTl
         ATA5n0LKkXloE/shyWFlHRtOdPCDB62MAgE/pc6ExQh6PQVUXaOhYDTpgwfCn6awHQ3I
         AYs2mpdwNdDE0L3JnCDvAp313sDOvPWH/+MHc5SEMzCQFVakAjF5S5wtqN8rpKqWZTYj
         AGasbS+szbNb7CNbrwMk1FrIlkTdcPy/yNY3EuAjbW84JNFCWfih7q6V46KBfGsf7JdU
         mgdD1HlWXky6Cpvu3mf92tqzs6k0+LS0KE377SDlsYx30Zr3EdQ3US0ohK0m+3s4NnA/
         OYAA==
X-Gm-Message-State: AOAM532sh72V20ReBqz9dI1zxQ9JhreOj3Qt2Iik1pudl+yCBPLPdZeO
        VutohLeOPXonlQiBbeWLzUoqIQ==
X-Google-Smtp-Source: ABdhPJzdB80SJfASSySTyybBpaCA+sAR5IcghRfo+MI3RzaziLqWjUt93++mgIC6ytnuaLUl0UBx2g==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr4193118wrv.257.1612367479798;
        Wed, 03 Feb 2021 07:51:19 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:b1de:c7d:30ce:1840])
        by smtp.gmail.com with ESMTPSA id p9sm4481682wrj.11.2021.02.03.07.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:51:18 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:51:13 +0100
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
Subject: Re: [PATCH 11/12] kasan: always inline HW_TAGS helper functions
Message-ID: <YBrGcY/DS1GnilYo@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <05a45017b4cb15344395650e880bbab0fe6ba3e4.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a45017b4cb15344395650e880bbab0fe6ba3e4.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> Mark all static functions in common.c and kasan.h that are used for
> hardware tag-based KASAN as __always_inline to avoid unnecessary
> function calls.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Does objtool complain about any of these?

I'm not sure this is unconditionally a good idea. If there isn't a
quantifiable performance bug or case where we cannot call a function,
perhaps we can just let the compiler decide?

More comments below.

> ---
>  mm/kasan/common.c | 13 +++++++------
>  mm/kasan/kasan.h  |  6 +++---
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 5691cca69397..2004ecd6e43c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -279,7 +279,8 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>   *    based on objects indexes, so that objects that are next to each other
>   *    get different tags.
>   */
> -static u8 assign_tag(struct kmem_cache *cache, const void *object, bool init)
> +static __always_inline u8 assign_tag(struct kmem_cache *cache,
> +					const void *object, bool init)

This function might be small enough that it's fine.

>  {
>  	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>  		return 0xff;
> @@ -321,8 +322,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>  	return (void *)object;
>  }
>  
> -static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> -			      unsigned long ip, bool quarantine)
> +static __always_inline bool ____kasan_slab_free(struct kmem_cache *cache,
> +				void *object, unsigned long ip, bool quarantine)
>  {

Because ____kasan_slab_free() is tail-called by __kasan_slab_free() and
__kasan_slab_free_mempool(), there should never be a call (and if there
is we need to figure out why). The additional code-bloat and I-cache
pressure might be worse vs. just a jump. I'd let the compiler decide.

>  	u8 tag;
>  	void *tagged_object;
> @@ -366,7 +367,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  	return ____kasan_slab_free(cache, object, ip, true);
>  }
>  
> -static bool ____kasan_kfree_large(void *ptr, unsigned long ip)
> +static __always_inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
>  {

This one is tail-called by __kasan_kfree_large(). The usage in
__kasan_slab_free_mempool() is in an unlikely branch.

>  	if (ptr != page_address(virt_to_head_page(ptr))) {
>  		kasan_report_invalid_free(ptr, ip);
> @@ -461,8 +462,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>  	return tagged_object;
>  }
>  
> -static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> -					size_t size, gfp_t flags)
> +static __always_inline void *____kasan_kmalloc(struct kmem_cache *cache,
> +				const void *object, size_t size, gfp_t flags)
>  {

Also only tail-called.

>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 2f7400a3412f..d5fe72747a53 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -321,7 +321,7 @@ static inline u8 kasan_random_tag(void) { return 0; }
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
>  
> -static inline void kasan_poison(const void *addr, size_t size, u8 value)
> +static __always_inline void kasan_poison(const void *addr, size_t size, u8 value)
>  {
>  	addr = kasan_reset_tag(addr);
>  
> @@ -337,7 +337,7 @@ static inline void kasan_poison(const void *addr, size_t size, u8 value)
>  	hw_set_mem_tag_range((void *)addr, size, value);
>  }
>  
> -static inline void kasan_unpoison(const void *addr, size_t size)
> +static __always_inline void kasan_unpoison(const void *addr, size_t size)
>  {

Not sure about these 2. They should be small, but it's hard to say what
is ideal on which architecture.

>  	u8 tag = get_tag(addr);
>  
> @@ -354,7 +354,7 @@ static inline void kasan_unpoison(const void *addr, size_t size)
>  	hw_set_mem_tag_range((void *)addr, size, tag);
>  }
>  
> -static inline bool kasan_byte_accessible(const void *addr)
> +static __always_inline bool kasan_byte_accessible(const void *addr)

This function feels like a macro and if the compiler uninlined it, we
could argue it's a bug. But not sure if we need the __always_inline,
unless you've seen this uninlined.

>  {
>  	u8 ptr_tag = get_tag(addr);
>  	u8 mem_tag = hw_get_mem_tag((void *)addr);
> -- 
> 2.30.0.365.g02bc693789-goog
> 
