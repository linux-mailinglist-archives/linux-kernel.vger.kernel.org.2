Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8632431305B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhBHLNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbhBHLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:04:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938C3C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 03:04:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so268634wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pufLM1lgk30Z0xNUrr/sKibBHabmfyHL7QD1WY1Y8VI=;
        b=iniQAbHQgxYyxXrODcz5H25no50robM+BRmtay9TDQp3GkR61GWi+tMIeRE+l+BwlF
         htSJGAWcO4ZhGi6H1KpZalqoHbgu5gAGQq3qBOVFj6ypipvAtSIdeGz+dGj/WkvMZR/z
         RKJP/FCxsrt1uxui0UJE5ztr8C4ajgkvawLkrsOMZh7qChLKx6SANqyWJLT135jItsVz
         ketpYksjvR1NBhuFuJqgrPfEBK//yDMhN8H9ieg3Aol/Q5zo0xGwRWypit1E7FR8ak33
         W9/Oyz5zbfACKhHz/qYEkII58OB/MGQBH/fhhsax7nl0HD4e0yDXcZX0qmEq9f1uVwHE
         Ex/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pufLM1lgk30Z0xNUrr/sKibBHabmfyHL7QD1WY1Y8VI=;
        b=S/ewhsNo4WPEzBqdJiXbqL9KEsGMV2SvSDlKHH/1bdTCp6Ehbn/T7zT4RgnI7V2APv
         NhqAHLcOf8g2rlVwSzNJ5+Xfi/akREbSq7aHvunuFn6qg+4sVO/KzHzkRux7cPO8zvcY
         Nro81kP7kZKy7kCvKJrSoexOD4RYBNJha7vdBXTND/Bo4QO9xlrI1ujWJpWdKqa05TVZ
         IfpyRD7dt7izBVQJTdNgkzQdM4MnYCCU0Lh1LbonYTlBd3mMTHTpIebDsR6HKPLp+3x8
         HXqlNY/NuenyXWnYeJvO3xGeIxBHAg1ZZjRkSP2WN/vmfodrGqITNyJIlWJyrEy5zZaO
         aZAQ==
X-Gm-Message-State: AOAM530jlY7KxTDSN/MSrPbci+z3i41I8ywwvD1XCx/IvcmhGPnf+CFD
        h7PBt7ocDPJh3ZncGfbbht/5bw==
X-Google-Smtp-Source: ABdhPJxsmyLQVX4sWX2FYBfjZz5gROTDQRFioLFhFldnjYhL3QwGKQjxhinXI80+MX13RPN0toHgaQ==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr19149327wrx.69.1612782249203;
        Mon, 08 Feb 2021 03:04:09 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:497f:76ef:2e62:d028])
        by smtp.gmail.com with ESMTPSA id x82sm14752706wmg.31.2021.02.08.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:04:08 -0800 (PST)
Date:   Mon, 8 Feb 2021 12:04:02 +0100
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
Subject: Re: [PATCH v3 mm 11/13] kasan: inline HW_TAGS helper functions
Message-ID: <YCEaohDsfF8MCl0N@elver.google.com>
References: <cover.1612546384.git.andreyknvl@google.com>
 <2c94a2af0657f2b95b9337232339ff5ffa643ab5.1612546384.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c94a2af0657f2b95b9337232339ff5ffa643ab5.1612546384.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:34PM +0100, Andrey Konovalov wrote:
> Mark all static functions in common.c and kasan.h that are used for
> hardware tag-based KASAN as inline to avoid unnecessary function calls.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 7ffb1e6de2ef..7b53291dafa1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -279,7 +279,8 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>   *    based on objects indexes, so that objects that are next to each other
>   *    get different tags.
>   */
> -static u8 assign_tag(struct kmem_cache *cache, const void *object, bool init)
> +static inline u8 assign_tag(struct kmem_cache *cache,
> +					const void *object, bool init)
>  {
>  	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>  		return 0xff;
> @@ -321,8 +322,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>  	return (void *)object;
>  }
>  
> -static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> -			      unsigned long ip, bool quarantine)
> +static inline bool ____kasan_slab_free(struct kmem_cache *cache,
> +				void *object, unsigned long ip, bool quarantine)
>  {
>  	u8 tag;
>  	void *tagged_object;
> @@ -366,7 +367,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  	return ____kasan_slab_free(cache, object, ip, true);
>  }
>  
> -static bool ____kasan_kfree_large(void *ptr, unsigned long ip)
> +static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>  	if (ptr != page_address(virt_to_head_page(ptr))) {
>  		kasan_report_invalid_free(ptr, ip);
> @@ -461,8 +462,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>  	return tagged_object;
>  }
>  
> -static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> -					size_t size, gfp_t flags)
> +static inline void *____kasan_kmalloc(struct kmem_cache *cache,
> +				const void *object, size_t size, gfp_t flags)
>  {
>  	unsigned long redzone_start;
>  	unsigned long redzone_end;
> -- 
> 2.30.0.365.g02bc693789-goog
> 
