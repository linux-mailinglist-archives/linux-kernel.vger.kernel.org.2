Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3587330C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhCHLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhCHLWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:22:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D4C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:22:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so11058104wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 03:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jdrzG39EB3vDtExSyNYnnHyOb0pzwYrAbQOXS4G/YIk=;
        b=fXimUib1Ki2jO88koiRaev0dqaJ0It6tg5HCP3ZN0skF7qCZmeFFo/uDZrxJgH4oyQ
         UZ9vWu6xNZOtNg5hmqUNkVroXkZlLl5fWwaMFXdUmSwS6A+rHav9abrQPa5rTDzDonBU
         KkFzcImxLdkjFevnExlCcdtgC0nJEuL+K26+p5/vbMggQ3qy+alN6+5Hoj7msSAjVQ+5
         G1W2PHNWFUaehVz9Nt/vwz0+TLSttv32PZVYwsl8zgfKJurpsq2UxKPL33cNi4smR3LQ
         m6UIFM6KlsC1ORvKUhi4oixsULQOjXTadSO8CBr1sdb86d2T+ZwkW1dvw7nJSMOUrbl6
         +GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdrzG39EB3vDtExSyNYnnHyOb0pzwYrAbQOXS4G/YIk=;
        b=igzIszvbJ5ku1CMDI1+o8XHUsm43ygnUKBjypnqhq0xvy9H1FdqqWNDcgAXvCZwJO7
         Hbk4zs6XdEvAb0IlgiHwM9xAWCr2xI8ahfuozUl42BzM0IM9Q3A1KUxzBMsf204/GN7k
         s4AOI9zsbU3pQog+m1KMT781xOwCw8hNx+bFf4KPwfo29Gs22hxCC42xnk3Bmv2UzsWg
         vBYHEYuyLEUBbx/mBa/3ItymM1+CtZK3PKWPCCFieJm0XnUQBNlS+a94YaIQzZ2COMoT
         DyY41ntKEXngiTcl0h6YbsFCcMBhWyW9gbYqsMUD1dcL5nRGJsx3eDyS6tlzO+MjJzPl
         Uk8A==
X-Gm-Message-State: AOAM530wuyGRYwh5sAIzv6K6AR4Ty9CR4Ef5Kdrdp7BMWeYOz+azqPK1
        GwM+BAB9/VyvZc7+dMeIgMJ/pw==
X-Google-Smtp-Source: ABdhPJyAHOwiac02DfQVZeu4oKIh/d5exFaAdX6QWnq/RGwetm++k7rofI4cTn6OxX4UbgwL9TChcw==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr22094155wrw.328.1615202553053;
        Mon, 08 Mar 2021 03:22:33 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:9d1d:b6a0:d116:531b])
        by smtp.gmail.com with ESMTPSA id u63sm17942821wmg.24.2021.03.08.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:22:31 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:22:25 +0100
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
Subject: Re: [PATCH 1/5] arm64: kasan: allow to init memory when setting tags
Message-ID: <YEYI8Vimo90TLaRs@elver.google.com>
References: <cover.1614989433.git.andreyknvl@google.com>
 <e43afadb507f25dfb1abfcb958470a3393bfdbf9.1614989433.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43afadb507f25dfb1abfcb958470a3393bfdbf9.1614989433.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 01:15AM +0100, Andrey Konovalov wrote:
> This change adds an argument to mte_set_mem_tag_range() that allows
> to enable memory initialization when settinh the allocation tags.
> The implementation uses stzg instruction instead of stg when this
> argument indicates to initialize memory.
> 
> Combining setting allocation tags with memory initialization will
> improve HW_TAGS KASAN performance when init_on_alloc/free is enabled.
> 
> This change doesn't integrate memory initialization with KASAN,
> this is done is subsequent patches in this series.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  arch/arm64/include/asm/memory.h    |  4 ++--
>  arch/arm64/include/asm/mte-kasan.h | 20 ++++++++++++++------
>  mm/kasan/kasan.h                   |  9 +++++----
>  3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index c759faf7a1ff..f1ba48b4347d 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -248,8 +248,8 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
>  #define arch_get_random_tag()			mte_get_random_tag()
>  #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
> -#define arch_set_mem_tag_range(addr, size, tag)	\
> -			mte_set_mem_tag_range((addr), (size), (tag))
> +#define arch_set_mem_tag_range(addr, size, tag, init)	\
> +			mte_set_mem_tag_range((addr), (size), (tag), (init))
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
>  /*
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 7ab500e2ad17..35fe549f7ea4 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -53,7 +53,8 @@ static inline u8 mte_get_random_tag(void)
>   * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
>   * size must be non-zero and MTE_GRANULE_SIZE aligned.
>   */
> -static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +static inline void mte_set_mem_tag_range(void *addr, size_t size,
> +						u8 tag, bool init)
>  {
>  	u64 curr, end;
>  
> @@ -68,10 +69,16 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  		 * 'asm volatile' is required to prevent the compiler to move
>  		 * the statement outside of the loop.
>  		 */
> -		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> -			     :
> -			     : "r" (curr)
> -			     : "memory");
> +		if (init)
> +			asm volatile(__MTE_PREAMBLE "stzg %0, [%0]"
> +				     :
> +				     : "r" (curr)
> +				     : "memory");
> +		else
> +			asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> +				     :
> +				     : "r" (curr)
> +				     : "memory");
>  
>  		curr += MTE_GRANULE_SIZE;
>  	} while (curr != end);
> @@ -100,7 +107,8 @@ static inline u8 mte_get_random_tag(void)
>  	return 0xFF;
>  }
>  
> -static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +static inline void mte_set_mem_tag_range(void *addr, size_t size,
> +						u8 tag, bool init)
>  {
>  }
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8c55634d6edd..7fbb32234414 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -291,7 +291,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define arch_get_mem_tag(addr)	(0xFF)
>  #endif
>  #ifndef arch_set_mem_tag_range
> -#define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
> +#define arch_set_mem_tag_range(addr, size, tag, init) ((void *)(addr))
>  #endif
>  
>  #define hw_enable_tagging()			arch_enable_tagging()
> @@ -299,7 +299,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define hw_set_tagging_report_once(state)	arch_set_tagging_report_once(state)
>  #define hw_get_random_tag()			arch_get_random_tag()
>  #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
> -#define hw_set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
> +#define hw_set_mem_tag_range(addr, size, tag, init) \
> +			arch_set_mem_tag_range((addr), (size), (tag), (init))
>  
>  #else /* CONFIG_KASAN_HW_TAGS */
>  
> @@ -343,7 +344,7 @@ static inline void kasan_poison(const void *addr, size_t size, u8 value)
>  	if (WARN_ON(size & KASAN_GRANULE_MASK))
>  		return;
>  
> -	hw_set_mem_tag_range((void *)addr, size, value);
> +	hw_set_mem_tag_range((void *)addr, size, value, false);
>  }
>  
>  static inline void kasan_unpoison(const void *addr, size_t size)
> @@ -360,7 +361,7 @@ static inline void kasan_unpoison(const void *addr, size_t size)
>  		return;
>  	size = round_up(size, KASAN_GRANULE_SIZE);
>  
> -	hw_set_mem_tag_range((void *)addr, size, tag);
> +	hw_set_mem_tag_range((void *)addr, size, tag, false);
>  }
>  
>  static inline bool kasan_byte_accessible(const void *addr)
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 
