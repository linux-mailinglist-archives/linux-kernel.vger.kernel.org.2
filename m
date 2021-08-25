Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123D03F7E11
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhHYWA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhHYWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:00:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34596C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:59:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o10so1933085lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEQgN0abaaOBlYJk9+kTEjTwkKHPtenNKxBXd/YeuFg=;
        b=Rwvd09BGu0W8Bf09NgU+o2Bhog1Y+Zu32OYjoMlTXlKtJOJpBecMKuNcLFx0s5W7zz
         FWDa7ok2PVOhFdJAD1DyBQubxC14BThq1k8VSvpEHgQcajP6D2JWi2VR/S6f1tC5qCaP
         zp2FbvuX7BaGvNggZvh7H9eqq/vJlBv1KhDDwKYnxaLfZGqewEdyShnaUE2zN5DLrMqX
         CYqN9boBMs/RWWLoTUz5GhkIf2NOetMelzo7SGFamyxqU5ur8ttDinQeYkLMEY7WCT2E
         Gp5uljdWnrSP6kH0alI2rMOOUthWb0yeZjebCxQ5rOiJxlNCH+6UYHoxeOqRrdNacdS4
         gqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEQgN0abaaOBlYJk9+kTEjTwkKHPtenNKxBXd/YeuFg=;
        b=r6uV1o2a6dg8uLzqPZwu23DOtSPjybl3Yz628Ds3urXul7db/H2cIsPIhDn4j5X9Zo
         e6Epn2w7+k45eV124yPClncK56wUsiEglHOwOSyYlwxcLcs0uo9WNfpInyxb0OGXo5JJ
         S4JmJv7wLpplKcKJ6BWCjNeu+3gl2AdpJXg7gu9AhUZhxT5LUBw97hkHfVf2MWLZK6Xr
         2RV3Tn8ph5x7kUOd7eno9k081R47LjybVYy6OL7YE8Vogo6ng4lQ30Tgaq7LAcv+nyq/
         Hw8ywXicuhbYeWf8NUigjrwh2rRdJ0YsSJWvRLFocChXqUMyE6zzcV1JHehNi4SN7bPH
         0WLg==
X-Gm-Message-State: AOAM533PGs0Fwwbl/ttGSIr6VSlmDhwaN/iu3BFRR9SKyb4TkSDlrvrQ
        l1YVvE4710Ewq3O4em5x/jeJL4GP4MSM2BlQteHtGw==
X-Google-Smtp-Source: ABdhPJz9BCwQUFjJgLdRD5l3u4YQ8EIUW07UxVlm6mESNVvXmANgn+AFntEG3u0Htqnn0D3wdFdwXNLGy5zAGtGhUvo=
X-Received: by 2002:a05:6512:3a84:: with SMTP id q4mr182701lfu.543.1629928776388;
 Wed, 25 Aug 2021 14:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-16-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-16-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 14:59:24 -0700
Message-ID: <CAKwvOdk0TC_D3ZOQF38=hqH3JRJ608HfzcnczmDunEF5_t0Buw@mail.gmail.com>
Subject: Re: [PATCH for-next 15/25] fortify: Move remaining fortify helpers
 into fortify-string.h
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> When commit a28a6e860c6c ("string.h: move fortified functions definitions
> in a dedicated header.") moved the fortify-specific code, some helpers
> were left behind. Move the remaining fortify-specific helpers into
> fortify-string.h so they're together where they're used. This requires
> that any FORTIFY helper function prototypes be conditionally built to
> avoid "no prototype" warnings. Additionally removes unused helpers.
>
> Acked-by: Francis Laniel <laniel_francis@privacyrequired.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/fortify-string.h | 7 +++++++
>  include/linux/string.h         | 9 ---------
>  lib/string_helpers.c           | 2 ++
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index c1be37437e77..7e67d02764db 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,6 +2,13 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>
> +#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> +#define __RENAME(x) __asm__(#x)
> +
> +void fortify_panic(const char *name) __noreturn __cold;
> +void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
> +void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
> +void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b48d2d28e0b1..9473f81b9db2 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -249,15 +249,6 @@ static inline const char *kbasename(const char *path)
>         return tail ? tail + 1 : path;
>  }
>
> -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> -#define __RENAME(x) __asm__(#x)
> -
> -void fortify_panic(const char *name) __noreturn __cold;
> -void __read_overflow(void) __compiletime_error("detected read beyond size of object passed as 1st parameter");
> -void __read_overflow2(void) __compiletime_error("detected read beyond size of object passed as 2nd parameter");
> -void __read_overflow3(void) __compiletime_error("detected read beyond size of object passed as 3rd parameter");
> -void __write_overflow(void) __compiletime_error("detected write beyond size of object passed as 1st parameter");
> -
>  #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
>  #include <linux/fortify-string.h>
>  #endif
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index e9433caab217..1274f45ffaf4 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -879,9 +879,11 @@ char *strreplace(char *s, char old, char new)
>  }
>  EXPORT_SYMBOL(strreplace);
>
> +#ifdef CONFIG_FORTIFY_SOURCE
>  void fortify_panic(const char *name)
>  {
>         pr_emerg("detected buffer overflow in %s\n", name);
>         BUG();
>  }
>  EXPORT_SYMBOL(fortify_panic);
> +#endif /* CONFIG_FORTIFY_SOURCE */
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-16-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
