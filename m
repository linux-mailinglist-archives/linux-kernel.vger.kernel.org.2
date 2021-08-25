Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448593F7E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhHYV4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHYV4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:56:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:55:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s12so1298925ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxSZH2j2eaq7YbJpNkogw+OvVkZIag0gCuTap1CAdjw=;
        b=kPYP3C82a/M7SugtamQJkWGW6tsr0GCoZasJjWGPGWn/2mFy0X292UYyt2jDo6E1HW
         SXiuK2kkURpEO3A4GKL/UNLg2p2nKC3s35L36EfI9HTEp9JqipvY2CbrnkSXWAgpvyJD
         byjSrQCBb+63UpNYs2OaAM0Qax3/FIjsbcHrEZhU3eHFhxlF48LMEH8wD0EikY1S86+n
         5Ob8nqqP5DQ9N8GGMObnSVbNyOpphaxEYMAdt02FxxFuTTObWvVAQ/6lfCJUQrwH4wvh
         Qkxo3dv0IGM9C18cW1YXfYjbsM6X5U8mp7ejd+iDiF+/U7vb83w1+0C7qiguX6TQ+eIU
         a6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxSZH2j2eaq7YbJpNkogw+OvVkZIag0gCuTap1CAdjw=;
        b=aKhTSKHm8PUBZM7HYeGT/Qi1/hA374a7qkNv5vjk80SMV3jf18j96fYFyF1uCFISJT
         NyzRFlvCSX4wki75gcN1X15fMW3UZIVMt0XHtB2oDBBgMYAZXLrq9at5frxLfZePjIXE
         KkQ7eW0bONx7Bwx2E0alBuqcsfu3K11lm+3EK84mRFQ0olRxhKIxDLPZQEaFYBvjKzC9
         BVcxIlZaSg1E1tZp62UiUo7Uo3bBfNZW5ybzIbmU+1c8j0cQ1eZA8NLlfD74Dv+L7Q1I
         llTUjWSvujHzv9W1o0oky0MocQJgBaFOx3BgKP6M1AexlpYEfZqXxphvXb2X0P1rUzx3
         8xZw==
X-Gm-Message-State: AOAM530T8Fd/V7q8VDH/cXvOhPzcA+QLojnhIizQ5rkDce16NALTyMjD
        ZU1h7BN6cqFzFXXDNpIykIUYrKKBKzwW6m5s977IdA==
X-Google-Smtp-Source: ABdhPJxaGr9ffS+ETTZWl7jSA9yzFobVViTrobQlYBli7DBKBt0Qu750YeW7cWfUe4RwlxfOeeNAhe7MJaSJIgKZ/7g=
X-Received: by 2002:a2e:a788:: with SMTP id c8mr321743ljf.116.1629928529265;
 Wed, 25 Aug 2021 14:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-18-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-18-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 14:55:18 -0700
Message-ID: <CAKwvOdnjaBZiPOD35hxb3SLVpV59mYcDBs=YZBz0KrTisULi9Q@mail.gmail.com>
Subject: Re: [PATCH for-next 17/25] fortify: Fix dropped strcpy() compile-time
 write overflow check
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
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
> The implementation for intra-object overflow in str*-family functions
> accidentally dropped compile-time write overflow checking in strcpy(),
> leaving it entirely to run-time. Add back the intended check.
>
> Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Francis Laniel <laniel_francis@privacyrequired.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/fortify-string.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 7e67d02764db..68bc5978d916 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -287,7 +287,10 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
>         if (p_size == (size_t)-1 && q_size == (size_t)-1)
>                 return __underlying_strcpy(p, q);
>         size = strlen(q) + 1;
> -       /* test here to use the more stringent object size */
> +       /* Compile-time check for const size overflow. */
> +       if (__builtin_constant_p(size) && p_size < size)
> +               __write_overflow();
> +       /* Run-time check for dynamic size overflow. */
>         if (p_size < size)
>                 fortify_panic(__func__);
>         memcpy(p, q, size);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-18-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
