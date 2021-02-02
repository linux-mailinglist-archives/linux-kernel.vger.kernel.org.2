Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB430C6D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhBBRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhBBQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:58:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5BC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:57:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j11so2312753wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lO7tj/Femn1+wEijzb4UKh0PnLxDA74JJSIXBjPCjcg=;
        b=emCtWBCSzNAR6zo9nqaF4fGZuOL3zOc2tIGPwlEafqDM3dv1vp5Ci1ONSFtdfh3++T
         mzX+vg6fhgdyhumEFT5SWWhOvljxP1Bso9nBLgTeZqdVWmcNTc9sNZ9za02+nsTsRahB
         E5Mi8/UGFb5X81E7RWyvc7gIrqqxwKHv9VcvGIxlOoQXSzl1hscp6gOeSXfkKFzfjMrv
         KSykYRzZvKF3sMMPyx0lkR1DypEcoQUnqiSk9cINQyKT9/3wwuibqVSr5JsWON+pGP1+
         a1V1YgNJXJxrhczcOkiPxxx6wZcWXNkQ94120eEID0uRyslqRsYcrYZt3Mzl0uAkDKIH
         5G/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lO7tj/Femn1+wEijzb4UKh0PnLxDA74JJSIXBjPCjcg=;
        b=nq5xPUklGRQxjrNN5/fttMaFXLYiFpTCpmgJfikSvpTy69Gtrd55W3JjnM6yTK6s38
         oUAqc05/LYFJKS+0+ZoLGdi/76+LNy1E/1pJ3SEbanpxRWdlHOd0CN/uISthhL0UzslH
         /cYZ80N96/ojVorF3ndy5YGPeOgLtWm/sqzZNymgn5JnVfMNI3+jTRiD0kP3/mBB5hee
         i1VciD+4ntFmWhje4J+e5eEnyoO75nwJC2XNqsJUxaxwxLRdzxunsHMGGWWxEu6nWvgt
         I4KMrjo9bEyBEW0qSK0R7NdRYBlbjpZ4I3wrMfPNm96UaFg/pYtX2co9UkzSR9N2ydbX
         3SEQ==
X-Gm-Message-State: AOAM530QrKCywp48MTogwBcHllmvbbfzboNWy6eUEG6ygQh/v7iq1baU
        l5e8S27iA7+xygU2s21BlLBFQA==
X-Google-Smtp-Source: ABdhPJzKnlEb49Qzq1C7WH6rqxehd7nnWuFwXqi876IGzxU89iMEg3PBoEY8CsMHZqoxchz2OXRvFA==
X-Received: by 2002:a1c:5608:: with SMTP id k8mr4448012wmb.91.1612285052531;
        Tue, 02 Feb 2021 08:57:32 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id j4sm32514546wru.20.2021.02.02.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:57:31 -0800 (PST)
Date:   Tue, 2 Feb 2021 17:57:25 +0100
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
Subject: Re: [PATCH 03/12] kasan: optimize large kmalloc poisoning
Message-ID: <YBmEdf4T5/0tpalT@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <8fdbf86842f4eaf2458ecd23d0844058dbc2c7a2.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fdbf86842f4eaf2458ecd23d0844058dbc2c7a2.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> Similarly to kasan_kmalloc(), kasan_kmalloc_large() doesn't need
> to unpoison the object as it as already unpoisoned by alloc_pages()
> (or by ksize() for krealloc()).
> 
> This patch changes kasan_kmalloc_large() to only poison the redzone.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/common.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 128cb330ca73..a7eb553c8e91 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -494,7 +494,6 @@ EXPORT_SYMBOL(__kasan_kmalloc);
>  void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
>  						gfp_t flags)
>  {
> -	struct page *page;
>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
>  
> @@ -504,12 +503,23 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
>  	if (unlikely(ptr == NULL))
>  		return NULL;
>  
> -	page = virt_to_page(ptr);
> +	/*
> +	 * The object has already been unpoisoned by kasan_alloc_pages() for
> +	 * alloc_pages() or by ksize() for krealloc().
> +	 */
> +
> +	/*
> +	 * The redzone has byte-level precision for the generic mode.
> +	 * Partially poison the last object granule to cover the unaligned
> +	 * part of the redzone.
> +	 */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +		kasan_poison_last_granule(ptr, size);
> +
> +	/* Poison the aligned part of the redzone. */
>  	redzone_start = round_up((unsigned long)(ptr + size),
>  				KASAN_GRANULE_SIZE);
> -	redzone_end = (unsigned long)ptr + page_size(page);
> -
> -	kasan_unpoison(ptr, size);
> +	redzone_end = (unsigned long)ptr + page_size(virt_to_page(ptr));
>  	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
>  		     KASAN_PAGE_REDZONE);
>  
> -- 
> 2.30.0.365.g02bc693789-goog
> 
