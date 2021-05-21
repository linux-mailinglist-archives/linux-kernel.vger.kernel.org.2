Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D278C38C470
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhEUKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhEUKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:16:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47161C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 03:15:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so7087544pjt.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1UKW5UlxzKbk0NJW2nQB3WP1Q3DywulUf5siHzqJFU=;
        b=HOUswS10DhLNpIZyKBkwrrTE1O4RGf+SieRNOyQOmS/VgbVUX9d4CgfdoQx4Yf/9SV
         rqk24EDQ6AkSKnYpkkXH8seVIld5Tg3IJ9xm/G8jWSjkItjtjlktbBRz8bdPckQidBrm
         2YO053sy1hquSKocZB0y0h+nOsWmY5iaCj5Fn5o0xAhisi8NWgMN2U/ZyBWEjWhDKuaL
         RsW9gh3t82U7jYjYcBLZaEM5tUR+maCUr+/22JHu76v8U5uaIAhF0rTCyzw5BhVJQKxW
         QRUWBxP8kY5HHlYsxVJU7GtIaHVQqLaWbDEkT3JzgXBJmWogy2sywieZ3vWx6bOFYizp
         X24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1UKW5UlxzKbk0NJW2nQB3WP1Q3DywulUf5siHzqJFU=;
        b=MFOKN+OXSSccKnJqwa/pCkQFNAfccfG/UA/3IIKXXd6h3ZdzlUt2YYV1vPekcSyGMH
         qnr/YySkUtXgGbXc1vgyGFT/VqIDt2sH4HM8tbfJpjMpc8XnKgIJhXBQ2XGFJ80Jqair
         LRF0sUkq7BE9mxfU+zhF1W3867R8ZUC4yTrdIQfOTsihUxyxi2uB4yNx4piyJhdZNLD4
         HkhRqtyEbJzKybIFuNCBhtbeKkDtI7+ylgn0FQEAlpKRpiPUXgOMLlAstuqx+pnhRW1c
         PHR8UWhTokMtJ0LXlPQZTCruM/bgL+pg7z/6iMs2kUkRoGKqMsOSPSfHrhbTKLpzPtSO
         BI/w==
X-Gm-Message-State: AOAM532Mh1F8LKKoTTsGffNXPMAE1Fae6aOqGBwutJm00V36FzVzuAq+
        ahaILXZ6f46QmqmOj7f6SE5eUCq33MLVkYtho+U=
X-Google-Smtp-Source: ABdhPJxEq2HGN4A/zooK2iIxAxNgAMg0hC3KyE32B+t4tuu3PoY1myv+/tLVr+xtw18jx6Y3P5mBWEhkZbHjzGSpGdw=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr10403326pja.181.1621592132531;
 Fri, 21 May 2021 03:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 May 2021 13:15:16 +0300
Message-ID: <CAHp75Vd+YL2uhn5aHiWbvNu3DeT9OSa7wc+iY8uDnRjdTPc_uA@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Fix compilation error with GENMASK
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:41 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> GENMASK() has an input check which uses __builtin_choose_expr() to enable
> a compile time sanity check of its inputs if they are known at compile
> time. However, it turns out that __builtin_constant_p() does not always
> return a compile time constant [0]. It was thought this problem was fixed
> with gcc 4.9 [1], but apparently this is not the case [2].
>
> Switch to use __is_constexpr() instead which always returns a compile
> time constant, regardless of its inputs.
>
> [0]: https://lore.kernel.org/lkml/42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk
> [1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> [2]: https://lore.kernel.org/lkml/1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp

Thanks for fixing this issue!
Since there is a consensus about the place, I have no objection either.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Feedback on placing __is_constexpr() in const.h is welcome, at least the
> name is appropriate...
>
>  include/linux/bits.h        |  2 +-
>  include/linux/const.h       |  8 ++++++++
>  include/linux/minmax.h      | 10 ++--------
>  tools/include/linux/bits.h  |  2 +-
>  tools/include/linux/const.h |  8 ++++++++
>  5 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 7f475d59a097..87d112650dfb 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -22,7 +22,7 @@
>  #include <linux/build_bug.h>
>  #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +               __is_constexpr((l) > (h)), (l) > (h), 0)))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> diff --git a/include/linux/const.h b/include/linux/const.h
> index 81b8aae5a855..435ddd72d2c4 100644
> --- a/include/linux/const.h
> +++ b/include/linux/const.h
> @@ -3,4 +3,12 @@
>
>  #include <vdso/const.h>
>
> +/*
> + * This returns a constant expression while determining if an argument is
> + * a constant expression, most importantly without evaluating the argument.
> + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + */
> +#define __is_constexpr(x) \
> +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> +
>  #endif /* _LINUX_CONST_H */
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index c0f57b0c64d9..5433c08fcc68 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_MINMAX_H
>  #define _LINUX_MINMAX_H
>
> +#include <linux/const.h>
> +
>  /*
>   * min()/max()/clamp() macros must accomplish three things:
>   *
> @@ -17,14 +19,6 @@
>  #define __typecheck(x, y) \
>         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>
> -/*
> - * This returns a constant expression while determining if an argument is
> - * a constant expression, most importantly without evaluating the argument.
> - * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> - */
> -#define __is_constexpr(x) \
> -       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> -
>  #define __no_side_effects(x, y) \
>                 (__is_constexpr(x) && __is_constexpr(y))
>
> diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> index 7f475d59a097..87d112650dfb 100644
> --- a/tools/include/linux/bits.h
> +++ b/tools/include/linux/bits.h
> @@ -22,7 +22,7 @@
>  #include <linux/build_bug.h>
>  #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +               __is_constexpr((l) > (h)), (l) > (h), 0)))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
> index 81b8aae5a855..435ddd72d2c4 100644
> --- a/tools/include/linux/const.h
> +++ b/tools/include/linux/const.h
> @@ -3,4 +3,12 @@
>
>  #include <vdso/const.h>
>
> +/*
> + * This returns a constant expression while determining if an argument is
> + * a constant expression, most importantly without evaluating the argument.
> + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + */
> +#define __is_constexpr(x) \
> +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> +
>  #endif /* _LINUX_CONST_H */
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
