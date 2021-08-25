Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB53F7E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhHYWG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHYWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:06:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC020C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:06:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z2so2095543lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccea3fIlNm7FUfA3rNUTcHdFf0+pm8m4+EKLNy1tSUI=;
        b=IQRg/zOds6VyPkEBcga03F5+uCR+u/q1eds5g9OOk7xrmPPRTj/nk8nBlNOPovSOYJ
         78dlAEVUMZHrJH/YR2nA8JdVlQqM89g3x84xqwiLkVMlOhXiq2T3OtDSmjZnPLE8Px9J
         /U6LE9Gxxx7cHPu9E6pMtQSTIOJCYkbGdo3Bt/9pTa43tuqsYlxsuNqENZGwzOWSQiKQ
         RPXdJxCSPlVzpYSd+JZTY7M6j/jQpRK+wCjWIeOYe63oU1etO5HaOCK8gFlOxksWON60
         XgPqtpjKSNhIYfebI/YWC3IXitSFJgJNsQfTs3IyE4MijGY9ualMROmfZ5EWGz9Fq7kV
         EAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccea3fIlNm7FUfA3rNUTcHdFf0+pm8m4+EKLNy1tSUI=;
        b=rwmUARpMvpV+FhFVGgm6PBKQ7mYgTlsIdU4JJnt5/cUoxD9FdMhGo8zjZ4B6mLxw0y
         iEAH1njCE1chHP1AzNALfpusUTFK/0WvXdnJKKTkCHq16qhWvyTf9zWQfn+63E1RdfO3
         lSZ6YVZbgGW+KKpZez2sfybGGnuEJa3qXE3z5lV4znlWCQw6bF5ddbxCIcuBiuV6i1xB
         AOxiFO01WdgEz1KmBOzCXimL/qgjYr95R++7oFjc46RO71laLRgk1zBmCw4hsfocsbTr
         XHNBXOtoS7uuRc02MdL8kU/dM4vL5iN9/u44wcWBWHootQ5qDXEfJYbMihzk5bI9t+qZ
         NyxA==
X-Gm-Message-State: AOAM533ftSnuHQjUP3HQwyaoqhRKPXMXArvzq9pi6ITrRB8fZ/YdVLq7
        U83amts6W1C3lGpD5VSF6JL769x4nhCPApkxdxtFmQ==
X-Google-Smtp-Source: ABdhPJyNQ/WwmaoSwrjefYfWyWAsZKiS9gMfjES83laYfRbmcqiJjJ7AJQDbwjC7dkR4EaWwzmJgZToBkxruPl/Kvt4=
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr229922lfu.374.1629929168689;
 Wed, 25 Aug 2021 15:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-20-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-20-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 15:05:56 -0700
Message-ID: <CAKwvOdnrO+oagJEiBMmoHrhTJKSRwzb0DK=R_QdVjhiNzb34dg@mail.gmail.com>
Subject: Re: [PATCH for-next 19/25] fortify: Allow strlen() and strnlen() to
 pass compile-time known lengths
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> Under CONFIG_FORTIFY_SOURCE, it is possible for the compiler to perform
> strlen() and strnlen() at compile-time when the string size is known.
> This is required to support compile-time overflow checking in strlcpy().
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 47 ++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index a3cb1d9aacce..e232a63fd826 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -10,6 +10,18 @@ void __read_overflow(void) __compiletime_error("detected read beyond size of obj
>  void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
>  void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
>
> +#define __compiletime_strlen(p)        ({              \
> +       size_t ret = (size_t)-1;                        \
> +       size_t p_size = __builtin_object_size(p, 1);    \
> +       if (p_size != (size_t)-1) {                     \
> +               size_t p_len = p_size - 1;              \
> +               if (__builtin_constant_p(p[p_len]) &&   \
> +                   p[p_len] == '\0')                   \
> +                       ret = __builtin_strlen(p);      \
> +       }                                               \
> +       ret;                                            \
> +})

Can this be a `static inline` function that accepts a `const char *`
and returns a `size_t` rather than a statement expression?

> +
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
>  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
> @@ -60,21 +72,31 @@ extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(st
>  __FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
>  {
>         size_t p_size = __builtin_object_size(p, 1);
> -       __kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
> +       size_t p_len = __compiletime_strlen(p);
> +       size_t ret;
> +
> +       /* We can take compile-time actions when maxlen is const. */
> +       if (__builtin_constant_p(maxlen) && p_len != (size_t)-1) {
> +               /* If p is const, we can use its compile-time-known len. */
> +               if (maxlen >= p_size)
> +                       return p_len;
> +       }
>
> +       /* Do no check characters beyond the end of p. */

s/no/not/

> +       ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
>         if (p_size <= ret && maxlen != ret)
>                 fortify_panic(__func__);
>         return ret;
>  }
>
> +/* defined after fortified strnlen to reuse it. */
>  __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
>  {
>         __kernel_size_t ret;
>         size_t p_size = __builtin_object_size(p, 1);
>
> -       /* Work around gcc excess stack consumption issue */
> -       if (p_size == (size_t)-1 ||
> -               (__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
> +       /* Give up if we don't know how large p is. */
> +       if (p_size == (size_t)-1)
>                 return __underlying_strlen(p);
>         ret = strnlen(p, p_size);
>         if (p_size <= ret)
> @@ -86,24 +108,27 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
>  extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
>  __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
>  {
> -       size_t ret;
>         size_t p_size = __builtin_object_size(p, 1);
>         size_t q_size = __builtin_object_size(q, 1);
> +       size_t q_len;   /* Full count of source string length. */
> +       size_t len;     /* Count of characters going into destination. */
>
>         if (p_size == (size_t)-1 && q_size == (size_t)-1)
>                 return __real_strlcpy(p, q, size);
> -       ret = strlen(q);
> -       if (size) {
> -               size_t len = (ret >= size) ? size - 1 : ret;
> -
> -               if (__builtin_constant_p(len) && len >= p_size)
> +       q_len = strlen(q);
> +       len = (q_len >= size) ? size - 1 : q_len;
> +       if (__builtin_constant_p(size) && __builtin_constant_p(q_len) && size) {
> +               /* Write size is always larger than destintation. */

s/destintation/destination/

> +               if (len >= p_size)
>                         __write_overflow();
> +       }
> +       if (size) {
>                 if (len >= p_size)
>                         fortify_panic(__func__);
>                 __underlying_memcpy(p, q, len);
>                 p[len] = '\0';
>         }
> -       return ret;
> +       return q_len;
>  }
>
>  /* defined after fortified strnlen to reuse it */
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-20-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
