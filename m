Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD8438B647
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhETSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhETSsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:48:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:46:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i22so25839361lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HipKiB2tPD7fxYbDsGhnXO5bWMclWGnlmd/7o3XnpBE=;
        b=ejzARBzxaJkgEw5Eujsw6FSWs5cfMOOFlxJj/S3POV1P330qTDdNgpsq6DCZsWc/hB
         jUexI5mJBVf6k5A5vEjONB0mctB1XukOkirO1T9CSAU1R1Rg1tnMKMApckTgTduKJ5Av
         Ie371nYNmK8+g7aUSKKAIz/w5iBKU7Mfo54JujyY2OquTJKtbJxoVpN1EsN478Elcwwb
         5xHtif2ViRrQ3Nzac8KNI3l6hkPWpfdX/dbjvPgJrImGJnECqwkKcXPEzlIqMSVHzSpS
         4Y/p3FW4AhkXIWIew8435erDN7IZanzyLu0oT0FT6vE4j1Scu3C/znhB21XAghlQvtjZ
         1lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HipKiB2tPD7fxYbDsGhnXO5bWMclWGnlmd/7o3XnpBE=;
        b=jbv1l0Tk8Cy+IqEDZMQF8G6eTXGw1OIbETCS5bW71V8oxUYa/zNx4QBjezxLi0xfbL
         43lFEpL2nsd+TmoOZxIfxxRcRU9RnPbqyHDaz7BIuQVnDBOUO2XM/3brzGdW56L0EaaJ
         NRVale9WSPRkrzSlEetzFXfjwYk6pjClc9wJilKVJGcBFuTdRXIkDO4tCAeWysMLeUjn
         fVqOTAdkVKSQffgbVXA8DGOpLLHWBSPvMhsL6RrrXGmEGDgLyX1UDYKqVna1d0q8Wmxl
         qxg/Jo8EQhU85lhk23Up1ebieMV+yLnitAWa/+qHQXdY0JWHbWsaQSeBoQiBzleyztMk
         QGqg==
X-Gm-Message-State: AOAM532NJbJgwr5vlK9oH/AfQhAJik+fx2ZSP1zb2XgNi3mY1YuKMGth
        V4oTj9Xev6ZXZ73QEJvmXvA=
X-Google-Smtp-Source: ABdhPJz5yr2Bj2C+vjPIA35mUREPKnRWmjA4/TtxdN/YTaHoy0MriQWkuYRGTmaOP0Xu8Rd42osQAw==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr4183197lfc.119.1621536404061;
        Thu, 20 May 2021 11:46:44 -0700 (PDT)
Received: from rikard (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id m13sm375534lfr.23.2021.05.20.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:46:43 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Thu, 20 May 2021 20:46:40 +0200
To:     Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] linux/bits.h: Fix compilation error with GENMASK
Message-ID: <YKaukFKw4KTmnOVd@rikard>
References: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
 <CAMj1kXF0rMwjgm27=i3XkrXJ=21C_x4he5Ls+7FSKUhsva970Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF0rMwjgm27=i3XkrXJ=21C_x4he5Ls+7FSKUhsva970Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 02:53:27PM +0200, Ard Biesheuvel wrote:
> (+ Arnd)
> 
> On Tue, 11 May 2021 at 22:37, Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> >
> > GENMASK() has an input check which uses __builtin_choose_expr() to enable
> > a compile time sanity check of its inputs if they are known at compile
> > time. However, it turns out that __builtin_constant_p() does not always
> > return a compile time constant [0]. It was thought this problem was fixed
> > with gcc 4.9 [1], but apparently this is not the case [2].
> >
> > Switch to use __is_constexpr() instead which always returns a compile
> > time constant, regardless of its inputs.
> >
> > [0]: https://lore.kernel.org/lkml/42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk
> > [1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> > [2]: https://lore.kernel.org/lkml/1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp
> >
> > Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> > Feedback on placing __is_constexpr() in const.h is welcome, at least the
> > name is appropriate...
> >
> >  include/linux/bits.h        |  2 +-
> >  include/linux/const.h       |  8 ++++++++
> >  include/linux/minmax.h      | 10 ++--------
> >  tools/include/linux/bits.h  |  2 +-
> >  tools/include/linux/const.h |  8 ++++++++
> >  5 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 7f475d59a097..87d112650dfb 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -22,7 +22,7 @@
> >  #include <linux/build_bug.h>
> >  #define GENMASK_INPUT_CHECK(h, l) \
> >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +               __is_constexpr((l) > (h)), (l) > (h), 0)))
> >  #else
> >  /*
> >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > diff --git a/include/linux/const.h b/include/linux/const.h
> > index 81b8aae5a855..435ddd72d2c4 100644
> > --- a/include/linux/const.h
> > +++ b/include/linux/const.h
> > @@ -3,4 +3,12 @@
> >
> >  #include <vdso/const.h>
> >
> > +/*
> > + * This returns a constant expression while determining if an argument is
> > + * a constant expression, most importantly without evaluating the argument.
> > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > + */
> > +#define __is_constexpr(x) \
> > +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> > +
> >  #endif /* _LINUX_CONST_H */
> > diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> > index c0f57b0c64d9..5433c08fcc68 100644
> > --- a/include/linux/minmax.h
> > +++ b/include/linux/minmax.h
> > @@ -2,6 +2,8 @@
> >  #ifndef _LINUX_MINMAX_H
> >  #define _LINUX_MINMAX_H
> >
> > +#include <linux/const.h>
> > +
> >  /*
> >   * min()/max()/clamp() macros must accomplish three things:
> >   *
> > @@ -17,14 +19,6 @@
> >  #define __typecheck(x, y) \
> >         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >
> > -/*
> > - * This returns a constant expression while determining if an argument is
> > - * a constant expression, most importantly without evaluating the argument.
> > - * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > - */
> > -#define __is_constexpr(x) \
> > -       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> > -
> >  #define __no_side_effects(x, y) \
> >                 (__is_constexpr(x) && __is_constexpr(y))
> >
> > diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> > index 7f475d59a097..87d112650dfb 100644
> > --- a/tools/include/linux/bits.h
> > +++ b/tools/include/linux/bits.h
> > @@ -22,7 +22,7 @@
> >  #include <linux/build_bug.h>
> >  #define GENMASK_INPUT_CHECK(h, l) \
> >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +               __is_constexpr((l) > (h)), (l) > (h), 0)))
> >  #else
> >  /*
> >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
> > index 81b8aae5a855..435ddd72d2c4 100644
> > --- a/tools/include/linux/const.h
> > +++ b/tools/include/linux/const.h
> > @@ -3,4 +3,12 @@
> >
> >  #include <vdso/const.h>
> >
> > +/*
> > + * This returns a constant expression while determining if an argument is
> > + * a constant expression, most importantly without evaluating the argument.
> > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > + */
> > +#define __is_constexpr(x) \
> > +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> > +
> >  #endif /* _LINUX_CONST_H */
> > --
> > 2.31.1
> >

Friendly ping.

Rikard
