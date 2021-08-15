Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5B3EC894
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbhHOKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbhHOKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 06:31:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50114C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 03:30:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a5so17488812plh.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eo/F6qN9TtCJ6MxQgeYM1IkT7CqtZYPPjAfNyw/Whq8=;
        b=Z1tuPNryzyCvO0WDJNzMZjwQ9Kvy2C8QWgdIr5nq1YjDWmaOQsTLvQp8gAkZV7x6eq
         6taByiZcdI/1KlwOCCL+/0R4CTErKYniWnG/etVZjtHXtIBR3PiGnMNUmvv9jtetm/q9
         V7gQQuhDrqMOSlB5ifdtNkZMR9YFDzIyYLQi8adm35nh4XfBklioo43fpu9aM1CM4kjU
         Xb/YtivX+3LvNS72GkdVejB48iCjlrQboWmxbH/4PI4+Q6IoJ6U5pRbjY7R85TLoRshL
         DnL5rOi3sGlHgdKL1fau9Wuzr9yWHurbvHkHEd5nS+4ha1Op2QnXYhB2EIbAi/PCVz+j
         wb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eo/F6qN9TtCJ6MxQgeYM1IkT7CqtZYPPjAfNyw/Whq8=;
        b=H7xEYvLgRHA3+KxCr6sDuwPAZQKAJCs9WolZBPGV8CTLLF4DrNUoLZ0OUkR1RQzN2U
         cgDq5czE9/rE4oNXsNMRykMgYxr4+UQm1gVPGAmygCzfNjrmkTn60DCXhy9E4Xpy0wto
         vVFVuiD2MZ9V+KDsbtwkgP08t4Ky74HUGHYQLSwlV/czKjnnxh/F1RtL1BWbhTlBDyUI
         tOxlWKzP+SgNczi7YAfxNgJ+mGVaiz0OdIFzeUxZEJ3jJg6OJ9gWJCOQxViYg35sR/nv
         //uJi0kmXMOgmRelHmUj96DpcvjyGRi7I4OmZp9Ixfw7HlYppu6i/dnRJyh7Us/02/Y7
         /z0w==
X-Gm-Message-State: AOAM5321dTiN4B3AoEE4nMdFTdTQ/Fy/bKUa/sz4B5cHlIkyERWU9vZ2
        uXU+YQ+qzw/H+KfBxh7PNZy0Cd61aPL0VCZ6lbo=
X-Google-Smtp-Source: ABdhPJy3hg7R0MjzHm+dmTWyCVm5xU09hLQ/GnC23bG13G60TTeD5ImynbvAM/y3j2iRd5WV96vn/SgcErqiigORxH0=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr11501901pjb.129.1629023448801;
 Sun, 15 Aug 2021 03:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210815032132.14530-1-21cnbao@gmail.com>
In-Reply-To: <20210815032132.14530-1-21cnbao@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 15 Aug 2021 13:30:12 +0300
Message-ID: <CAHp75VcFeDy9V3cJoS2V+bAsEKd03PoBVanX1bBb_-scNGdsdQ@mail.gmail.com>
Subject: Re: [PATCH] lib: bitmap: Mute some odd section mismatch warning in
 xtensa kernel build
To:     Barry Song <21cnbao@gmail.com>
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

On Sun, Aug 15, 2021 at 6:23 AM Barry Song <21cnbao@gmail.com> wrote:
>
> From: Barry Song <song.bao.hua@hisilicon.com>
>
> Constanly there are some section mismatch issues reported in test_bitmap

Constantly

> for xtensa platform such as:
>
>   Section mismatch in reference from the function bitmap_equal() to the
>   variable .init.data:initcall_level_names
>   The function bitmap_equal() references the variable __initconst
>   __setup_str_initcall_blacklist. This is often because bitmap_equal
>   lacks a __initconst annotation or the annotation of
>   __setup_str_initcall_blacklist is wrong.
>
>   Section mismatch in reference from the function bitmap_copy_clear_tail()
>   to the variable .init.rodata:__setup_str_initcall_blacklist
>   The function bitmap_copy_clear_tail() references the variable __initconst
>   __setup_str_initcall_blacklist.
>   This is often because bitmap_copy_clear_tail lacks a __initconst
>   annotation or the annotation of __setup_str_initcall_blacklist is wrong.
>
> To be honest, hardly to believe kernel code is wrong since bitmap_equal is

bitmap_equal()

> always called in __init function in test_bitmap.c just like __bitmap_equal.

__bitmap_equal()

> But gcc doesn't report any issue for __bitmap_equal even when bitmap_equal
> and __bitmap_equal show in the same function such as:

Ditto as above in both lines.

>   static void noinline __init test_mem_optimisations(void)
>   {
>         ...
>           for (start = 0; start < 1024; start += 8) {
>                   for (nbits = 0; nbits < 1024 - start; nbits += 8) {
>                           if (!bitmap_equal(bmap1, bmap2, 1024)) {
>                                   failed_tests++;
>                           }
>                           if (!__bitmap_equal(bmap1, bmap2, 1024)) {
>                                   failed_tests++;
>                           }
>                         ...
>                   }
>           }
>   }
>
> The different between __bitmap_equal() and bitmap_equal() is that the
> former is extern and a EXPORT_SYMBOL. So noinline, and probably in fact

and an EXPORT_SYMBOL

> noclone. But the later is static and unfortunately not inlined at this

latter

> time though it has a "inline" flag.

has an "inline"

> bitmap_copy_clear_tail(), on the other hand, seems more innocent as it is
> accessing stack only by its wrapper bitmap_from_arr32() in function
> test_bitmap_arr32():
> static void __init test_bitmap_arr32(void)
> {
>         unsigned int nbits, next_bit;
>         u32 arr[EXP1_IN_BITS / 32];
>         DECLARE_BITMAP(bmap2, EXP1_IN_BITS);
>
>         memset(arr, 0xa5, sizeof(arr));
>
>         for (nbits = 0; nbits < EXP1_IN_BITS; ++nbits) {
>                 bitmap_to_arr32(arr, exp1, nbits);
>                 bitmap_from_arr32(bmap2, arr, nbits);
>                 expect_eq_bitmap(bmap2, exp1, nbits);
>                 ...
>         }
> }
> Looks like gcc optimized arr, bmap2 things to .init.data but it seems
> nothing is wrong in kernel since test_bitmap_arr32() is __init.

in the kernel

> Max Filippov reported a bug to gcc but gcc people don't ack. So here
> this patch removes the involved symbols by forcing inline. It might
> not be that elegant but I don't see any harm as bitmap_equal() and
> bitmap_copy_clear_tail() are both quite small. In addition, kernel
> doc also backs this modification "We don't use the 'inline' keyword
> because it's broken": www.kernel.org/doc/local/inline.html
>
> Another possible way to "fix" the warning is moving the involved
> symboms to lib/bitmap.c:

symbols

>
>   +int bitmap_equal(const unsigned long *src1,
>   +                       const unsigned long *src2, unsigned int nbits)
>   +{
>   +       if (small_const_nbits(nbits))
>   +               return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
>   +       if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
>   +           IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
>   +               return !memcmp(src1, src2, nbits / 8);
>   +       return __bitmap_equal(src1, src2, nbits);
>   +}
>   +EXPORT_SYMBOL(bitmap_equal);
>
> This is harmful to the performance.

I'm afraid it's a bit of a slippery road. These two are currently
being used in tests, what if somebody extends tests with something
else similar? Will we need to __always_inline more symbols because of
that? What about non-bitmap APIs?

-- 
With Best Regards,
Andy Shevchenko
