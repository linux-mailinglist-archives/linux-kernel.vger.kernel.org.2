Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D641FA3C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 09:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhJBHVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhJBHVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 03:21:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B0C0613E8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 00:20:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so13015944wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S4WTRvyYeldW8QekSycFwQ5FlF4CTjAutou4WtcIjj4=;
        b=L2jFQQk+Tr+KJxp5/VepfSxRQM5j9SwxtvlskuE0PJ+mmKMbcDDEV/fo2GgvjP5M4s
         wKsIi5T5KWAvUzXqS6nC/+rlnhJ/L47nqetcXFAXc3sj5gdPa/lqQge4DdQF3kv+pr2F
         PH9rtLeiU4bfhZeCOvsTivmEt0H3BnhFUjLZWgzKknFt6x7SOdrIxV2HhZQV19MvGSZ9
         otzCoQHE+H+kKpRSzC7vl7DOI/ReCYIyFfJ3g52qkEOp/+2VBqqglqfp56jES4t4yDKy
         X13CCy/6PsNQ1Tel2VG7YHhu/DAOgHzyhY6ocGZho3GQpE92dGWwCGxxNUy5L/s650Vi
         9O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S4WTRvyYeldW8QekSycFwQ5FlF4CTjAutou4WtcIjj4=;
        b=fq07kaMMiUytoLzG4Qje4H8+30/nCLQA7opiXZWS1cwlrpjfXRV+1PhI7QhFRmI+P2
         GdMr94ZMKXti5mXTqx/JAsL61liQtk1gIANdA1uLA1ftp0jMMQ3DIQS3RW69AwYnUNLn
         Es+gX/v0VxuL0qCgSI/a/l+LZP10VXLr/cRgVFhbyBFllx1qH5d79x05nrvK4Ao5s+xT
         T8yAfzjvmzeKKjk0nlk7bUtDpPde7ktvlRaepWmTlxB4agOEO1/KLKApDMwbsHqslkao
         uybm7rFjdhBohJMOudcm6sndgEg9c9SQt76uHNZsUS6NtioTIHn0O1kA74ng5eFFMGrv
         VyQg==
X-Gm-Message-State: AOAM5307ybHt4wB39/wieaKlKWgbFXI1kdwv6OuaKqZ7gKa/XXfOvnpG
        gXgp+A23iGfTLQ0FUk3NoozmVO6AxWlEP+djvPAI1A==
X-Google-Smtp-Source: ABdhPJydhaV371BMrf3l2dtZKS3QQFptiUMmQudz9NU/tAQyTV8xfoRc+SLGKM91m6bf/0EUuX5c3SAUJaiVWnpqu/I=
X-Received: by 2002:a05:600c:1c1d:: with SMTP id j29mr8166189wms.49.1633159207545;
 Sat, 02 Oct 2021 00:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br> <20210926223322.848641-2-isabellabdoamaral@usp.br>
In-Reply-To: <20210926223322.848641-2-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 15:19:56 +0800
Message-ID: <CABVgOS=Ux00jm9Qiy-u0zhhHUBpmXQCsnFdr=sEU-1q1XBWM7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hash.h: remove unused define directive
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, ferreiraenzoa@gmail.com,
        augusto.duraes33@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> w=
rote:
>
> Currently, there exist hash_32() and __hash_32() functions, which were
> introduced in a patch [1] targeting architecture specific optimizations.
> These functions can be overridden on a per-architecture basis to achieve
> such optimizations. They must set their corresponding define directive
> (HAVE_ARCH_HASH_32 and HAVE_ARCH__HASH_32, respectively) so that header
> files can deal with these overrides properly.
>
> As the supported 32-bit architectures that have their own hash function
> implementation (i.e. m68k, Microblaze, H8/300, pa-risc) have only been
> making use of the (more general) __hash_32() function (which only lacks
> a right shift operation when compared to the hash_32() function),
> remove the define directive corresponding to the arch-specific hash_32()
> implementation.
>
> [1] https://lore.kernel.org/lkml/20160525073311.5600.qmail@ns.sciencehori=
zons.net/
>
> Changes since v1:
> - As suggested by David Gow:
>   1. Reword commit message.

Maybe move this changelog to below the "---", so it doesn't show up in
the final commit message?

>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Signed-off-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---

This looks sensible enough to me. Since no-one seems to be speaking up
in architecture-specific hash_32()'s defence, let's get rid of it.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/linux/hash.h       |  5 +----
>  lib/test_hash.c            | 24 +-----------------------
>  tools/include/linux/hash.h |  5 +----
>  3 files changed, 3 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/hash.h b/include/linux/hash.h
> index ad6fa21d977b..38edaa08f862 100644
> --- a/include/linux/hash.h
> +++ b/include/linux/hash.h
> @@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
>         return val * GOLDEN_RATIO_32;
>  }
>
> -#ifndef HAVE_ARCH_HASH_32
> -#define hash_32 hash_32_generic
> -#endif
> -static inline u32 hash_32_generic(u32 val, unsigned int bits)
> +static inline u32 hash_32(u32 val, unsigned int bits)
>  {
>         /* High bits are more random, so use them. */
>         return __hash_32(val) >> (32 - bits);
> diff --git a/lib/test_hash.c b/lib/test_hash.c
> index 0ee40b4a56dd..d4b0cfdb0377 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -94,22 +94,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][3=
3])
>                         pr_err("hash_32(%#x, %d) =3D %#x > %#x", h0, k, h=
1, m);
>                         return false;
>                 }
> -#ifdef HAVE_ARCH_HASH_32
> -               h2 =3D hash_32_generic(h0, k);
> -#if HAVE_ARCH_HASH_32 =3D=3D 1
> -               if (h1 !=3D h2) {
> -                       pr_err("hash_32(%#x, %d) =3D %#x !=3D hash_32_gen=
eric() "
> -                               " =3D %#x", h0, k, h1, h2);
> -                       return false;
> -               }
> -#else
> -               if (h2 > m) {
> -                       pr_err("hash_32_generic(%#x, %d) =3D %#x > %#x",
> -                               h0, k, h1, m);
> -                       return false;
> -               }
> -#endif
> -#endif
> +
>                 /* Test hash_64 */
>                 hash_or[1][k] |=3D h1 =3D hash_64(h64, k);
>                 if (h1 > m) {
> @@ -227,13 +212,6 @@ test_hash_init(void)
>  #else
>         pr_info("__hash_32() has no arch implementation to test.");
>  #endif
> -#ifdef HAVE_ARCH_HASH_32
> -#if HAVE_ARCH_HASH_32 !=3D 1
> -       pr_info("hash_32() is arch-specific; not compared to generic.");
> -#endif
> -#else
> -       pr_info("hash_32() has no arch implementation to test.");
> -#endif
>  #ifdef HAVE_ARCH_HASH_64
>  #if HAVE_ARCH_HASH_64 !=3D 1
>         pr_info("hash_64() is arch-specific; not compared to generic.");
> diff --git a/tools/include/linux/hash.h b/tools/include/linux/hash.h
> index ad6fa21d977b..38edaa08f862 100644
> --- a/tools/include/linux/hash.h
> +++ b/tools/include/linux/hash.h
> @@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
>         return val * GOLDEN_RATIO_32;
>  }
>
> -#ifndef HAVE_ARCH_HASH_32
> -#define hash_32 hash_32_generic
> -#endif
> -static inline u32 hash_32_generic(u32 val, unsigned int bits)
> +static inline u32 hash_32(u32 val, unsigned int bits)
>  {
>         /* High bits are more random, so use them. */
>         return __hash_32(val) >> (32 - bits);
> --
> 2.33.0
>
