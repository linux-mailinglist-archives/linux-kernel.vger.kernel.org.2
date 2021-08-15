Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1908C3EC8B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhHOL0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhHOL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 07:26:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D356C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 04:25:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bq25so16591052ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XDJOtYqs3HqQfM6YXjLOfgdRWk7GtognCyKYYKdXAmU=;
        b=onviHfUjgS17zKR6ZzjMaOc/UY5+ANGceMEDXMBUjJHMOEfttJlz+XBKUIqfChe05v
         AuMqK+0+Cb2JG4IIobVp4qAhqfng8n4unlR2nUGMzSJMAiWGZv3x4FqI1W8Xk8LSCxfl
         k4SxXE15pwxbozluZudph2pWMh8zpdhyyi4xY9vEZynbTjtkOPYsKhEK2ubOFdrUYrQ/
         Xx/ex07UBhG+sD36G69FA0HPSs77EmoV5tCnjv7cIC2OLpkk4Dwkep5UMI4XEvlh09PJ
         lgAC1gE0GK2vRCtN7HQ8/znV4g0r6CwlYEaqoWvU13iYaWadGyHA8dlE6V7hJZxmIZ9b
         Gv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XDJOtYqs3HqQfM6YXjLOfgdRWk7GtognCyKYYKdXAmU=;
        b=cC9Z8Q7Bzzy5ZeUEKdeq38GQQMaWAyWGnfJ+2Ha23t4gKvGBB7mQGZoDtrhmtSVgnk
         lrGZGHC7Zta+uoj8a8WFj1rLXTtbsjHkT4wM1o3/wKozfOr1arrg+0wPQREWztlIRUPN
         5PKCcoZVGcV+8fbgWkNgL7urw4vj6rbiwILC8u3MS+jOblVlDPm0wEI7wB+f/IOivTGs
         7Dw5BPn0Q6B+1fzA1pD2qS3EZjvUF+nteIy4jzZMuZUI8NP07zX9JN/nQKTCtNnqMnz5
         CU6rL3xDItYoX57zaHxcEq0Z+XMXF7BpwB7n4LFM3EsndQfuJ68nydZad8N/nfqJdppU
         728w==
X-Gm-Message-State: AOAM532YQ6diFahWeJH6Z8oLQKw0TUy20TxlM5qo910xFjMz9ouypVeh
        js/flCdNL6nA0n3qRZ+2kJs7c6PDQCz6/4lVaCs=
X-Google-Smtp-Source: ABdhPJwxlA/sZtjCNX6gnhrcSXZzwzeX36eYq2VYX96S9JZaZMgy4d7A0xPSv0mearacBsUZj+KTmezzu5IwTnAOYq8=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr6645903ejg.36.1629026735781;
 Sun, 15 Aug 2021 04:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6400:4211:0:0:0:0 with HTTP; Sun, 15 Aug 2021 04:25:35
 -0700 (PDT)
In-Reply-To: <CAHp75VcFeDy9V3cJoS2V+bAsEKd03PoBVanX1bBb_-scNGdsdQ@mail.gmail.com>
References: <20210815032132.14530-1-21cnbao@gmail.com> <CAHp75VcFeDy9V3cJoS2V+bAsEKd03PoBVanX1bBb_-scNGdsdQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 15 Aug 2021 23:25:35 +1200
Message-ID: <CAGsJ_4zSp0M9Mrbxs31FyGvm1pFH44MStEcuThju4u+DPf7Khw@mail.gmail.com>
Subject: Re: [PATCH] lib: bitmap: Mute some odd section mismatch warning in
 xtensa kernel build
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        kernel test robot <lkp@intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Aug 15, 2021 at 6:23 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > From: Barry Song <song.bao.hua@hisilicon.com>
> >
> > Constanly there are some section mismatch issues reported in test_bitmap
>
> Constantly
>
> > for xtensa platform such as:
> >
> >   Section mismatch in reference from the function bitmap_equal() to the
> >   variable .init.data:initcall_level_names
> >   The function bitmap_equal() references the variable __initconst
> >   __setup_str_initcall_blacklist. This is often because bitmap_equal
> >   lacks a __initconst annotation or the annotation of
> >   __setup_str_initcall_blacklist is wrong.
> >
> >   Section mismatch in reference from the function
> bitmap_copy_clear_tail()
> >   to the variable .init.rodata:__setup_str_initcall_blacklist
> >   The function bitmap_copy_clear_tail() references the variable
> __initconst
> >   __setup_str_initcall_blacklist.
> >   This is often because bitmap_copy_clear_tail lacks a __initconst
> >   annotation or the annotation of __setup_str_initcall_blacklist is
> wrong.
> >
> > To be honest, hardly to believe kernel code is wrong since bitmap_equal
> is
>
> bitmap_equal()
>
> > always called in __init function in test_bitmap.c just like
> __bitmap_equal.
>
> __bitmap_equal()
>
> > But gcc doesn't report any issue for __bitmap_equal even when
> bitmap_equal
> > and __bitmap_equal show in the same function such as:
>
> Ditto as above in both lines.
>
> >   static void noinline __init test_mem_optimisations(void)
> >   {
> >         ...
> >           for (start = 0; start < 1024; start += 8) {
> >                   for (nbits = 0; nbits < 1024 - start; nbits += 8) {
> >                           if (!bitmap_equal(bmap1, bmap2, 1024)) {
> >                                   failed_tests++;
> >                           }
> >                           if (!__bitmap_equal(bmap1, bmap2, 1024)) {
> >                                   failed_tests++;
> >                           }
> >                         ...
> >                   }
> >           }
> >   }
> >
> > The different between __bitmap_equal() and bitmap_equal() is that the
> > former is extern and a EXPORT_SYMBOL. So noinline, and probably in fact
>
> and an EXPORT_SYMBOL
>
> > noclone. But the later is static and unfortunately not inlined at this
>
> latter
>
> > time though it has a "inline" flag.
>
> has an "inline"
>
> > bitmap_copy_clear_tail(), on the other hand, seems more innocent as it is
> > accessing stack only by its wrapper bitmap_from_arr32() in function
> > test_bitmap_arr32():
> > static void __init test_bitmap_arr32(void)
> > {
> >         unsigned int nbits, next_bit;
> >         u32 arr[EXP1_IN_BITS / 32];
> >         DECLARE_BITMAP(bmap2, EXP1_IN_BITS);
> >
> >         memset(arr, 0xa5, sizeof(arr));
> >
> >         for (nbits = 0; nbits < EXP1_IN_BITS; ++nbits) {
> >                 bitmap_to_arr32(arr, exp1, nbits);
> >                 bitmap_from_arr32(bmap2, arr, nbits);
> >                 expect_eq_bitmap(bmap2, exp1, nbits);
> >                 ...
> >         }
> > }
> > Looks like gcc optimized arr, bmap2 things to .init.data but it seems
> > nothing is wrong in kernel since test_bitmap_arr32() is __init.
>
> in the kernel
>
> > Max Filippov reported a bug to gcc but gcc people don't ack. So here
> > this patch removes the involved symbols by forcing inline. It might
> > not be that elegant but I don't see any harm as bitmap_equal() and
> > bitmap_copy_clear_tail() are both quite small. In addition, kernel
> > doc also backs this modification "We don't use the 'inline' keyword
> > because it's broken": www.kernel.org/doc/local/inline.html
> >
> > Another possible way to "fix" the warning is moving the involved
> > symboms to lib/bitmap.c:
>
> symbols
>
> >
> >   +int bitmap_equal(const unsigned long *src1,
> >   +                       const unsigned long *src2, unsigned int nbits)
> >   +{
> >   +       if (small_const_nbits(nbits))
> >   +               return !((*src1 ^ *src2) &
> BITMAP_LAST_WORD_MASK(nbits));
> >   +       if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
> >   +           IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
> >   +               return !memcmp(src1, src2, nbits / 8);
> >   +       return __bitmap_equal(src1, src2, nbits);
> >   +}
> >   +EXPORT_SYMBOL(bitmap_equal);
> >
> > This is harmful to the performance.
>
> I'm afraid it's a bit of a slippery road. These two are currently
> being used in tests, what if somebody extends tests with something
> else similar? Will we need to __always_inline more symbols because of
> that? What about non-bitmap APIs?
>

you are right. Andy,  we will have to mark those functions one by one
if gcc doesn't want to change. actually i am seeing the same issue in
lib/find_bit_benchmark.c whose __init functions are also calling
static inline bitmap api.
not quite issue if it is specific to xentas. i'd welcome a global gcc
option to disable this kind of clone for xentas or i would be happy to
see gcc people ack this is a gcc issue.


> --
> With Best Regards,
> Andy Shevchenko
>

Thanks
Barry
