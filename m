Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4737312FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhBHK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhBHKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:49:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A462C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:48:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f16so12119437wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lgGm4PB5m4Er0st2+IAu2ADnhULDfoFDJ2Jsf0woe9E=;
        b=QhK5ZJAGnEkI3A3Z2DNmhtocdr8uInviUMncIed8Yw60g+v4JjhGra+7ogE9iuJekm
         23cf96w5JdaoDSZJtcnr3Ivr5yjGk4yPDPLTa/mCaykYOimrYCsUGpsYs7AvB8KuTzP3
         /K7jSYSJTaXywmR/kzbjN+gmJyZmHu4zrD+hD9tUBSAfNJd5TEm0PbeCDBNIdKg+P63D
         jgnXCRdJj93uJ/WNNj8MMQT7CU8pwoM6zd01N3mhkQNfpaCwWtAxyErclXw5gr6UjvlF
         h/U9EZLMThz7Ijl6rfpflzgsWxyf3rsvsE9s1oiNsyQa9AnK9iH3Sjynsw4dOHyG1NIj
         CPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lgGm4PB5m4Er0st2+IAu2ADnhULDfoFDJ2Jsf0woe9E=;
        b=TmbkwHpfHL+JjyIsOBC2P05SoLinDPLl/ffS1RGROhTrIilNcArD3f3uzg/XfxLWLp
         F8ZooCBQbmJ6ZGmoYaGQYyaIuldGRSt48w01kbu9ukXU5gIjo5o5tR2zA4V22uaPcyxj
         /7NWnATKtizh2PF2VkdZ6RV7Id+tKJMc153cDIAaTzxPw19u17iv6BTYFw4e+Q5P4bkb
         nwt8+j6m8ehF/0tO6VUsui3ZoTZgnBC7scC1OMiJsH8YdbDG1F/guhWHCuEQYGK5Axic
         mttOTRDeEHjKgOs39kzD8P8Bmid4wy164LZ+1Uw7ZXryKq1MY6oKwTlF/3fDtkjYQ0eS
         qSyQ==
X-Gm-Message-State: AOAM5312uGc75MYCpRf5IwTjPbd0j0643e5RZ/XnivKNW0HfDidRkL9Y
        p/5tJTdJVJYj4m78TRmWy/9edQ==
X-Google-Smtp-Source: ABdhPJxJ1xVrDFdzjEST4rocD/QkhguzJ9ybMCZvQBotr7Rh2p3RxFYnATJDwH4oDHDebADgcA4NLg==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr11809452wme.171.1612781287598;
        Mon, 08 Feb 2021 02:48:07 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:4037:8827:dcff:a9da])
        by smtp.gmail.com with ESMTPSA id u142sm20991623wmu.3.2021.02.08.02.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 02:48:06 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:48:01 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 mm 08/13] kasan, mm: optimize krealloc poisoning
Message-ID: <YCEW4SNDDERCWd7f@elver.google.com>
References: <cover.1612546384.git.andreyknvl@google.com>
 <9bef90327c9cb109d736c40115684fd32f49e6b0.1612546384.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bef90327c9cb109d736c40115684fd32f49e6b0.1612546384.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:34PM +0100, Andrey Konovalov wrote:
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

Reviewed-by: Marco Elver <elver@google.com>

Clarification below.

> ---
>  mm/kasan/common.c | 12 ++++++++++--
>  mm/slab_common.c  | 20 ++++++++++++++------
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 7ea643f7e69c..a8a67dca5e55 100644
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
> index dad70239b54c..60a2f49df6ce 100644
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

Just checking: Check byte returns true if the object is not tracked by KASAN, right? I.e. if it's a KFENCE object, kasan_check_byte() always returns true.

> +		ks = kfence_ksize(p) ?: __ksize(p);
> +	} else
> +		ks = 0;
>  
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
