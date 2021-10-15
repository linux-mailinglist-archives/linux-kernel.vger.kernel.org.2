Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0142FA54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhJORgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhJORgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:36:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F0C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:34:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g36so28005014lfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2hjBOvKy6xDlDiNJhW19TOyI4tkya8JrKkq1DPtskBE=;
        b=PPJ8oC+NOgUO7AJaZAU9oaPGEWQNCKG3btar0K7YPO0GLkb4Y/SjZRsJ7zDMW2BWGU
         B87xeGg/6pJ6rrBZ9M75M8g+pwchnTq/6F4kYdyFUUtuWucmxUcZ9AGfx/6CESgxxR6Y
         5x8Js7R7ncgxcI+p7vpRgAf6kvR9uaqsZuandFHA5hbgRjK7L1+Pck5W+DmsrbeApVV5
         mV38sv8gUESwYZLvIF96VLlUFTna8AhqHN14pHatVsYLgZGe7L4RXIfoQCpJuCI8pwSz
         YJE+rFYCx41SXhGCNu9DL8yI5BIO/mIw9bKeQ2noejlY9AKeoJzFPJ9xM0Z8JJu/krFv
         OdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2hjBOvKy6xDlDiNJhW19TOyI4tkya8JrKkq1DPtskBE=;
        b=XhnmEOw2eH1cUlyW7irHbQr3/32aPwdnI+ck6K8b400HA7PXwGvUt6HzR1x4iMK6/f
         6/uDb9BWA8YTia3+dw8mBowbWqpb1rGib1s08NJZiZe3b6OmavN3s4Ih12pulvKcR5KJ
         7zkRmgoyBvdinjkWLb7XMWsTBEJUxba39SAVVdeb9clxbxswYI8bE2nJoPoll+sxrwP1
         nhO5jzrxxagmnB9HJdFotGGLqKBGCxP/Tx/o4FnuGQTbkcum+OLjHMMPf7c51cL6LwcZ
         1SQ4Wk3QeYkRqmuchOAh62yo22S+BCFZR5VGDTz/gmDUWOaC8SSPyz35zut8HwBtedVX
         pcEA==
X-Gm-Message-State: AOAM531VWuFbmLn4KRvD9iMOwY77zm6fyZzSPTNLwLsmTkv8HFeTZosL
        g5YIrNjo6E+G1HO6NM89YB2PlTHCUtXhSU1J39Pvuw==
X-Google-Smtp-Source: ABdhPJz48bR/OErLjmNqJCUhE0bJJVmOXek8a9WZdzJ4XHEU0r3HXuJx7PPoFlRocyJR9vCWVmRHh8+4ebz4+oiFL6I=
X-Received: by 2002:a05:6512:b0a:: with SMTP id w10mr4483529lfu.240.1634319242989;
 Fri, 15 Oct 2021 10:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211015090530.2774079-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20211015090530.2774079-1-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Oct 2021 10:33:50 -0700
Message-ID: <CAKwvOdm6LUFBC=as-9fTxYM=H2U=JuzquanFYwasn2Vu3TgsxA@mail.gmail.com>
Subject: Re: [PATCH] linux/container_of.h: switch to static_assert
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 2:05 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> _Static_assert() is evaluated already in the compiler's frontend, and
> gives a somehat more to-the-point error, compared to the BUILD_BUG_ON
> macro, which only fires after the optimizer has had a chance to
> eliminate calls to functions marked with
> __attribute__((error)). In theory, this might make builds a tiny bit
> faster.
>
> There's also a little less gunk in the error message emitted:
>
> lib/sort.c: In function =E2=80=98foo=E2=80=99:
> ./include/linux/build_bug.h:78:41: error: static assertion failed: "point=
er type mismatch in container_of()"
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>
> compared to
>
> lib/sort.c: In function =E2=80=98foo=E2=80=99:
> ././include/linux/compiler_types.h:322:38: error: call to =E2=80=98__comp=
iletime_assert_2=E2=80=99 declared with attribute error: pointer type misma=
tch in container_of()
>   322 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
>
> While at it, fix the copy-pasto in container_of_safe().
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> akpm: This is obviously on top of Andy's kernel.h splitup series, so
> should go along with those if acked.
>
>  include/linux/container_of.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index dd56019838c6..2f4944b791b8 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -16,9 +16,9 @@
>   */
>  #define container_of(ptr, type, member) ({                             \
>         void *__mptr =3D (void *)(ptr);                                  =
 \
> -       BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
> -                        !__same_type(*(ptr), void),                    \
> -                        "pointer type mismatch in container_of()");    \
> +       static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
> +                     __same_type(*(ptr), void),                        \
> +                     "pointer type mismatch in container_of()");       \
>         ((type *)(__mptr - offsetof(type, member))); })
>
>  /**
> @@ -31,9 +31,9 @@
>   */
>  #define container_of_safe(ptr, type, member) ({                         =
       \
>         void *__mptr =3D (void *)(ptr);                                  =
 \
> -       BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
> -                        !__same_type(*(ptr), void),                    \
> -                        "pointer type mismatch in container_of()");    \
> +       static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
> +                     __same_type(*(ptr), void),                        \
> +                     "pointer type mismatch in container_of_safe()");  \
>         IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :                     \
>                 ((type *)(__mptr - offsetof(type, member))); })
>
> --
> 2.31.1
>


--=20
Thanks,
~Nick Desaulniers
