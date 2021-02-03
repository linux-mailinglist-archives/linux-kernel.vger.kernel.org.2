Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7408730DCF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhBCOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhBCOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:35:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A22C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:35:07 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so24595406wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4K/9sxU94RKYKEloT1K6toG7ncb4LzmnvyruO4aAFU=;
        b=piNvFA2h0b/jEgsGNJfp5Ste6KGL4xIbYpBUsJrmhbuzWllOy1R1Zl1PQZm6OH7YFX
         cfBNWWpqHrsoHJxUS4kZMloAWcpgCOOdYz1f+qkKIK5b18tcvGoQcyA2V3wdy3O0nNya
         lEoEpSdIH/fjBUiy2H47dSm5LW3q3t1nL23YOvlAY5gYlhcoo4BC4VyC/cQtlGmL9jOw
         vRN7ZZKr2rMzV99lDWED5j46gLsPaPK0Cqzd/pGm3bUT1xQ+xsLX0NozxLmA7+ab9hul
         V/7VlKk8zp2ckqiLv180Y3ip1eVtpehprooIKfEK0ZopBdHF5Eh+8IWmtmuFCq+BM0MZ
         beRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4K/9sxU94RKYKEloT1K6toG7ncb4LzmnvyruO4aAFU=;
        b=lhy9U2STl2eNDsVGpFiwKkMD6tiXHiIt+xvxAB15ax43QDATKjRMQFdGS1CRygudJo
         M/QYb791vOTvu8SGjSIFfJ3QRwHXS/+mPEQzejFieYF1LU9Kp3jsPDTANEsOoT39aBZ3
         xECrqfT0+KAKKzc1RplBlzK6n3W/T1JMUFB9fv4Ws3PMx7jFNLhwutjlDIT7nwvFMVwm
         fRZ+A2TnwVoxjKIYECAOoSXXROPm/oktNQsAxIWtTx2k7b7VFfWx7gGagRmmrqLvECYV
         8+31+SuM15bts8Y814PERqEYH+YuRJa8YerP5264Fa6unwvuIdVHPyosEfjDwzINgImM
         EANg==
X-Gm-Message-State: AOAM530NtxUYHqi61v8JEwWMOamKbzbORXhQIy6dQYxS+OiffU+GV2qa
        d7/XoQfoDJEXvBqR6/bqp5JrIw==
X-Google-Smtp-Source: ABdhPJy862T62VL0M2xpW43TfDXl6YsKV5dJiXETZMsf+h43kEedM6c9mRz/qkbM2gqer3LepLyHvA==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr3763180wrw.415.1612362905963;
        Wed, 03 Feb 2021 06:35:05 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:b1de:c7d:30ce:1840])
        by smtp.gmail.com with ESMTPSA id i15sm2672462wmq.26.2021.02.03.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:35:05 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:34:59 +0100
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
Subject: Re: [PATCH 08/12] kasan, mm: optimize krealloc poisoning
Message-ID: <YBq0k2p5eudcY6bD@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <431c6cfa0ac8fb2b33d7ab561a64aa84c844d1a0.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431c6cfa0ac8fb2b33d7ab561a64aa84c844d1a0.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> Currently, krealloc() always calls ksize(), which unpoisons the whole
> object including the redzone. This is inefficient, as kasan_krealloc()
> repoisons the redzone for objects that fit into the same buffer.
> 
> This patch changes krealloc() instrumentation to use uninstrumented
> __ksize() that doesn't unpoison the memory. Instead, kasan_kreallos()
> is changed to unpoison the memory excluding the redzone.
> 
> For objects that don't fit into the old allocation, this patch disables
> KASAN accessibility checks when copying memory into a new object instead
> of unpoisoning it.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c | 12 ++++++++++--
>  mm/slab_common.c  | 20 ++++++++++++++------
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 9c64a00bbf9c..a51d6ea580b0 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -476,7 +476,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  
>  	/*
>  	 * The object has already been unpoisoned by kasan_slab_alloc() for
> -	 * kmalloc() or by ksize() for krealloc().
> +	 * kmalloc() or by kasan_krealloc() for krealloc().
>  	 */
>  
>  	/*
> @@ -526,7 +526,7 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
>  
>  	/*
>  	 * The object has already been unpoisoned by kasan_alloc_pages() for
> -	 * alloc_pages() or by ksize() for krealloc().
> +	 * alloc_pages() or by kasan_krealloc() for krealloc().
>  	 */
>  
>  	/*
> @@ -554,8 +554,16 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
>  	if (unlikely(object == ZERO_SIZE_PTR))
>  		return (void *)object;
>  
> +	/*
> +	 * Unpoison the object's data.
> +	 * Part of it might already have been unpoisoned, but it's unknown
> +	 * how big that part is.
> +	 */
> +	kasan_unpoison(object, size);
> +
>  	page = virt_to_head_page(object);
>  
> +	/* Piggy-back on kmalloc() instrumentation to poison the redzone. */
>  	if (unlikely(!PageSlab(page)))
>  		return __kasan_kmalloc_large(object, size, flags);
>  	else
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index dad70239b54c..821f657d38b5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1140,19 +1140,27 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
>  	void *ret;
>  	size_t ks;
>  
> -	if (likely(!ZERO_OR_NULL_PTR(p)) && !kasan_check_byte(p))
> -		return NULL;
> -
> -	ks = ksize(p);
> +	/* Don't use instrumented ksize to allow precise KASAN poisoning. */
> +	if (likely(!ZERO_OR_NULL_PTR(p))) {
> +		if (!kasan_check_byte(p))
> +			return NULL;
> +		ks = __ksize(p);
> +	} else
> +		ks = 0;
>  

This unfortunately broke KFENCE:
https://syzkaller.appspot.com/bug?extid=e444e1006d07feef0ef3 + various
other false positives.

We need to use ksize() here, as __ksize() is unaware of KFENCE. Or
somehow add the same check here that ksize() uses to get the real object
size.

> +	/* If the object still fits, repoison it precisely. */
>  	if (ks >= new_size) {
>  		p = kasan_krealloc((void *)p, new_size, flags);
>  		return (void *)p;
>  	}
>  
>  	ret = kmalloc_track_caller(new_size, flags);
> -	if (ret && p)
> -		memcpy(ret, p, ks);
> +	if (ret && p) {
> +		/* Disable KASAN checks as the object's redzone is accessed. */
> +		kasan_disable_current();
> +		memcpy(ret, kasan_reset_tag(p), ks);
> +		kasan_enable_current();
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.30.0.365.g02bc693789-goog
> 
