Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF544474F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhKCRjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKCRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:39:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20747C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:37:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gn3so1773718pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=spfompkpCAA4ZvxYsMg1S2VVdCBK1SqXXwLI1Ib9KrU=;
        b=hlz3m+CK+SemRWO2vwaxRQ/o+lHXUyuzVN3Z4PPAiugN1OaW8esD9UPh11aLr6lbsT
         AGMc+Hyplk7RRgLwlZNVAaXnKphUQQXUVg0huFqmKcbEG7/PCxc/9TJmfAr0eNo4UgvO
         c5HqNf88tX9BTdRsyesHtiqxza6pA9zBisbOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spfompkpCAA4ZvxYsMg1S2VVdCBK1SqXXwLI1Ib9KrU=;
        b=CTx/Wp+YGBJUsuwz5hs8hYIxCDbxH+IZAHUTwBJCaZ8B8c/kUbm0N8phazibbRxN4S
         eIBTcjN8iZqWgo1BNQmHi/4OnCqfehjSMkRCZtJ018WQBkd2YEx+3HPVBqrylBAKXs8H
         nqxPg5Elix/S//la3dlgEQ9FeWSV05NUMqB/nagKDIm+IVVGlq6Uqgrya9SmKEE9diA/
         X+pORip+IIf8EwlQfICB5YDyrQCHowDBmAbF2JKFRf+ywOVbGk5rsBJDWCm3Lqrmx01N
         0H94bts3++DchWtjaX3MUQfjxZdZQcM8Y7EeOBdCb9dUbngVd2ohhm6CBstQG/xdVhGN
         tyGg==
X-Gm-Message-State: AOAM533SBNkoZKbEuFDCZapNSF2Nurkol5PkBNYaGkLyHc0E0bZt8b/R
        fQEWt67NtrmNo8m48LNFLHyXFqbtyEbLbQ==
X-Google-Smtp-Source: ABdhPJypYHxW4Nn5IdvGHSLtAcuovLbpOwH02ELrH3//+spnyoa61JajTQXrEnFp//MwG9uPrY3Q7Q==
X-Received: by 2002:a17:90a:1b2a:: with SMTP id q39mr16365056pjq.219.1635961031632;
        Wed, 03 Nov 2021 10:37:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j5sm2371553pjs.2.2021.11.03.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:37:11 -0700 (PDT)
Date:   Wed, 3 Nov 2021 10:37:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RESEND PATCH v2] string: uninline memcpy_and_pad
Message-ID: <202111031011.D0F16D78@keescook>
References: <20211102142518.3723655-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102142518.3723655-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 07:25:18AM -0700, Guenter Roeck wrote:
> When building m68k:allmodconfig, recent versions of gcc generate the
> following error if the length of UTS_RELEASE is less than 8 bytes.
> 
> In function 'memcpy_and_pad',
>     inlined from 'nvmet_execute_disc_identify' at
>     	drivers/nvme/target/discovery.c:268:2:
> arch/m68k/include/asm/string.h:72:25: error:
> 	'__builtin_memcpy' reading 8 bytes from a region of size 7

What things are size 8 and 7? "5.15.0\0" is 7 bytes -- is strlen()
returning _8_?? It should return 6 here.

> Discussions around the problem suggest that this only happens if an
> architecture does not provide strlen(), if -ffreestanding is provided as
> compiler option, and if CONFIG_FORTIFY_SOURCE=n. All of this is the case
> for m68k. The exact reasons are unknown, but seem to be related to the
> ability of the compiler to evaluate the return value of strlen() and
> the resulting execution flow in memcpy_and_pad(). It would be possible
> to work around the problem by using sizeof(UTS_RELEASE) instead of
> strlen(UTS_RELEASE), but that would only postpone the problem until the
> function is called in a similar way. Uninline memcpy_and_pad() instead
> to solve the problem for good.

Ew, no, this doesn't solve the problem -- it just makes the buffer sizes
invisible to the compiler. This will hide legitimate problems. Please
leave this inlined.

struct nvme_id_ctrl {
	...
        char                    fr[8];
...

        memcpy_and_pad(id->fr, sizeof(id->fr),
                       UTS_RELEASE, strlen(UTS_RELEASE), ' ');

	memcpy_and_pad(id->fr, 8, UTS_RELEASE, 6, ' ')


static inline void memcpy_and_pad(void *dest, size_t dest_len,
				  const void *src, size_t count, int pad)
	if (dest_len > count) {
		memcpy(dest, src, count);
		memset(dest + count, pad,  dest_len - count);
	} else {
		memcpy(dest, src, dest_len);
	}

->

	if (8 > 6) {
		memcpy(id->fr, UTS_RELEASE, 6);
		memset(fd->fr + 6, ' ', 2);
	}

Ah, I've found the earlier thread now:
https://lore.kernel.org/all/CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com/

This looks like a compiler bug in that it isn't collapsing the strlen()
into a compile-time constant. "sizeof(UTS_RELEASE) - 1" seems a
reasonable work-around?

I'd suggest reporting this to GCC. I see two bugs:

- strlen() not getting replace with a constant expression
- warning being generated across a runtime check

it seems like GCC *thinks* it knows strlen will be a CE, but then
instead it keeps both branches anyway, triggering a warning.

-Kees

> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Moved to lib/string_helpers.c
>     Balanced { } in if/else statement to make checkpatch happy
>     Added Reviewed-by: /Acked-by: tags
> 
>  include/linux/string.h | 19 ++-----------------
>  lib/string_helpers.c   | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 5a36608144a9..b6572aeca2f5 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -253,23 +253,8 @@ static inline const char *kbasename(const char *path)
>  #include <linux/fortify-string.h>
>  #endif
>  
> -/**
> - * memcpy_and_pad - Copy one buffer to another with padding
> - * @dest: Where to copy to
> - * @dest_len: The destination buffer size
> - * @src: Where to copy from
> - * @count: The number of bytes to copy
> - * @pad: Character to use for padding if space is left in destination.
> - */
> -static inline void memcpy_and_pad(void *dest, size_t dest_len,
> -				  const void *src, size_t count, int pad)
> -{
> -	if (dest_len > count) {
> -		memcpy(dest, src, count);
> -		memset(dest + count, pad,  dest_len - count);
> -	} else
> -		memcpy(dest, src, dest_len);
> -}
> +void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> +		    int pad);
>  
>  /**
>   * memset_after - Set a value after a struct member to the end of a struct
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index faa9d8e4e2c5..d5d008f5b1d9 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -883,6 +883,26 @@ char *strreplace(char *s, char old, char new)
>  }
>  EXPORT_SYMBOL(strreplace);
>  
> +/**
> + * memcpy_and_pad - Copy one buffer to another with padding
> + * @dest: Where to copy to
> + * @dest_len: The destination buffer size
> + * @src: Where to copy from
> + * @count: The number of bytes to copy
> + * @pad: Character to use for padding if space is left in destination.
> + */
> +void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> +		    int pad)
> +{
> +	if (dest_len > count) {
> +		memcpy(dest, src, count);
> +		memset(dest + count, pad,  dest_len - count);
> +	} else {
> +		memcpy(dest, src, dest_len);
> +	}
> +}
> +EXPORT_SYMBOL(memcpy_and_pad);
> +
>  #ifdef CONFIG_FORTIFY_SOURCE
>  void fortify_panic(const char *name)
>  {
> -- 
> 2.33.0
> 

-- 
Kees Cook
