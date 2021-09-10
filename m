Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32430407205
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhIJTbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhIJTbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:31:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E5C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:29:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w4so4861685ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4106171iyruquc6tsn3sJ73L23Envq9y9gb7Tkr3Js8=;
        b=Sbx9cYlMH6RNCNfgWQKJU9uLVzoUJlaFno4UiRW9KsKlNEW8ZAN0RdHh2NgMZq6C9o
         e3mehRNuX5LtPaKxPMXeqlcBmfm8sURx7khjg8ErV4fm9RlO+HkXVobI5CV42u11X3B+
         zS4RgMtkz4dPickrPQ7/qBfhFtG7ji38o08kDaVFK6SAzR4CLPiY6ixiJWcHwH63xYUU
         Yrk/FAGyq4sy4LcNzRZqfZTb4C7tetxBGB5M/FkUAmAvqGCPpdMbkSR2ioWHivR5uK2c
         hND30wzAJuKaKv2Mjr4gGSXaF5CIPn8VX5QeXlJU4pZjfay3MOek6SanZ0GV7XRc3HF/
         XeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4106171iyruquc6tsn3sJ73L23Envq9y9gb7Tkr3Js8=;
        b=hH4v17UwGBaVZO0gI1EnLvlj8e9ZUwRcvaZB2RfLsmnUVN9DJb1n93Gm7CDvuqQRge
         5AYOVE8tE0kwxyNmWaY9zCwJ4dp0oONXSReOG2/WrDuOIRR0KGGmruq5+kvkxYuvNjwJ
         XOWn8pzAjZQ9V7zKAuRlG2zVJ/uPLCixpR/VjOif8x8DzhMKxY3tIAbMHh/xUVIvaCQR
         GroZNqvwZgT4pHwmb3L9HwfeNy//hf0OJNhjRImm8nMKDDrd/P9C+fxc5TNs3bkGlz39
         ZWEN3bE6EbugrzW4NbSSGzzVKwoiHDmBEkJDKmnrf618IslymQhb6nMQqSzIsSBQlDIR
         OhsA==
X-Gm-Message-State: AOAM533iMXnlthYQNE3LmABv/Iqcz+J6CDmscUsHa9M03pJOa8wst4ob
        HAObkK9It0JySmaKLQXaLw04cu4RalDs4QjkKmH1rw==
X-Google-Smtp-Source: ABdhPJw7204XMnLRYaCCb5ZZ2RHlO4S8cc7Z3nMU7nKKuC8uEYefhxLX8FFJ42oRPfYCPgFA+mERHc/+dmy+Gs1E7O8=
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr5310763lja.198.1631302158776;
 Fri, 10 Sep 2021 12:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210910113345.62bda9e6@canb.auug.org.au>
In-Reply-To: <20210910113345.62bda9e6@canb.auug.org.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Sep 2021 12:29:08 -0700
Message-ID: <CAKwvOd=JQZXPstMsJOirXxRb8iFOCnpNW4SdmmGu1WOpZ5JS2Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kspp tree with the
 compiler-attributes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 6:33 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the kspp tree got conflicts in:
>
>   include/linux/compiler-gcc.h
>   include/linux/compiler_types.h
>
> between commit:
>
>   b83a908498d6 ("compiler_attributes.h: move __compiletime_{error|warning}")
>
> from the compiler-attributes tree and commit:
>
>   122b05c65c5d ("compiler_types.h: Remove __compiletime_object_size()")
>
> from the kspp tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen,
Kees, Miguel just sent the patch from his tree to Linus in a PR:
https://lore.kernel.org/lkml/20210910191734.GA8688@kernel.org/T/#u

>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc include/linux/compiler-gcc.h
> index 21c36b69eb06,01985821944b..000000000000
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@@ -41,8 -41,9 +41,6 @@@
>
>   #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>
> - #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>  -#define __compiletime_warning(message) __attribute__((__warning__(message)))
>  -#define __compiletime_error(message) __attribute__((__error__(message)))
> --
>   #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
>   #define __latent_entropy __attribute__((latent_entropy))
>   #endif
> diff --cc include/linux/compiler_types.h
> index b6ff83a714ca,c43308b0a9a9..000000000000
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@@ -290,11 -290,13 +290,6 @@@ struct ftrace_likely_data
>         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
>          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>
> - /* Compile time object size, -1 for unknown */
> - #ifndef __compiletime_object_size
> - # define __compiletime_object_size(obj) -1
>  -#ifndef __compiletime_warning
>  -# define __compiletime_warning(message)
>  -#endif
>  -#ifndef __compiletime_error
>  -# define __compiletime_error(message)
> --#endif
> --
>   #ifdef __OPTIMIZE__
>   # define __compiletime_assert(condition, msg, prefix, suffix)         \
>         do {                                                            \



-- 
Thanks,
~Nick Desaulniers
