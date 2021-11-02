Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A202744305C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKBO27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:28:58 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4178DC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:26:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id t7-20020a4aadc7000000b002b8733ab498so7466489oon.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UeZwNQiTJwwoyCKDWPTZochRq0rwCifL3TkR2yEDKvk=;
        b=jFBgxZP7PwsU4IHpTYLinzbZCTMvWdK6Oojd+t9uYWZK2kzWwWYFohAHSdZa7PrUse
         pymYfdC9RcC2wmT0nhGEh6XLmMC4pyxraNEnmQsO92yMqsgP+CtU1TdexPcek5eppSmb
         G9+q8e3kx89tZDMu1uoIbcZw4Glz1SxIUL76FP7+LPAkz+LtBFYQRObs81J/yM5mSbeT
         6r7z8WeV+e4+CXvUOxweZnB86VR52y1d8XxfRk85Cpu4Et5VRSj4bafhE/k/OWTz/iAt
         q2sRpIxzorXZ/3Ryj6vArWKhqa+zWLtMAemxq1N+xJkb0Yy8UeU94cXQ+MGhdIbUaP7U
         7Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UeZwNQiTJwwoyCKDWPTZochRq0rwCifL3TkR2yEDKvk=;
        b=lx8rmQIJrtHf4Bq/3imQ4fliNjmYoM4UsJ1NEUH2WQobu7Ay/q3UC8/NmLUctJDdhR
         DOqZ+MKS9N1CNx9Aba0yzXBHHi4LqUZeemf40N07gQ+skoAjI0rL4/jhqPf2vXaMrH/8
         JaSB7FzFG/Yp9fyq0qr6NRnQW+ocZNPRML4ZFw5fnfjjBZm/N8xtEJl7+VT0+5s6V23y
         iQuFp6g7yOrf14RTEYDGpJ/NSJL3tuP8YBuNtgd6bmOzBAXaRgJkgSdGdPEJ308df+Ta
         k2bRFluCUD2UN6M8mQHEFGe/A2OVRNCcPOmNp72Xnk2ZL6yd+xtneO4eLj6AqjktVZlc
         Rjzw==
X-Gm-Message-State: AOAM532ECGP4o658v9GpQInHl5x4xH0PwXkorUqAr/FpZ4/N+0+G+Tw4
        BYjjt0SBjHY+2VpYpGJJXWU=
X-Google-Smtp-Source: ABdhPJziKB7dQqEQTFMa5za0CsYSPGj4LU5AAxX8H89JZ4qiIGXcWq/zJHExEvafsDkbWs7b74y9nA==
X-Received: by 2002:a05:6820:1622:: with SMTP id bb34mr13074589oob.93.1635863182660;
        Tue, 02 Nov 2021 07:26:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1sm1853576oiw.17.2021.11.02.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:26:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 2 Nov 2021 07:26:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] string: uninline memcpy_and_pad
Message-ID: <20211102142620.GA3723668@roeck-us.net>
References: <20211102142420.3723616-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102142420.3723616-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scratch this one. Forgot v2 in subject. Resending, and sorry for the noise.

Guenter

On Tue, Nov 02, 2021 at 07:24:20AM -0700, Guenter Roeck wrote:
> When building m68k:allmodconfig, recent versions of gcc generate the
> following error if the length of UTS_RELEASE is less than 8 bytes.
> 
> In function 'memcpy_and_pad',
>     inlined from 'nvmet_execute_disc_identify' at
>     	drivers/nvme/target/discovery.c:268:2:
> arch/m68k/include/asm/string.h:72:25: error:
> 	'__builtin_memcpy' reading 8 bytes from a region of size 7
> 
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
