Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028893ECA1C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 17:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhHOP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhHOP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 11:56:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABBC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 08:55:32 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e1so8021116qvs.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/JMcYJp2wmik1V9wV+z1dUKqu6LOo28p9YJ55J49aB0=;
        b=AcvA8qxrDzlqDKh8saabWAqvFk35G8oUY/BeNUaQDHg7nE6lL2quPgX59+wzGojcHr
         RF/+4hq2cyd3mKHmS7P3hHnjJhItJpLIWN+P6ap3rh0iCcyaNhUjCsleKoHhw6Q4plJw
         cSu9IQ22CMYlUZ1KvGRWEj6O4ObZXTOXrzqOydLXL1ONk94ozUZUxNRNrpMIjI2KPkld
         NrNXH0ER9cGomhsRR1jsotCR8c+PhQfO2afmqNZzlZWMdEporYYk9kSvGO7ExKEN099+
         BQzoR8a45YK1s3WoOzMAVMQsAL6f6/LX2NSkdOSKQQtfCIIDQmvAEPZY3GJRqF8t4dXm
         4KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/JMcYJp2wmik1V9wV+z1dUKqu6LOo28p9YJ55J49aB0=;
        b=HhCb4tzj1quuxDw2/6iLBSy5rnA0UdIFhg4ALTLQ4gb3i9PWj2KGbCIPib+u5Hkf0q
         hdZU1I4QtuV5JDWKdsAG2qZkrbVSy7dFWC30WtnjwSKYCk4nFVpH6WsLRhoTegELK4RJ
         9JczKNShA1Zgx85vK34NkG4F8anZvpe+q6bg9cTPINpbV+QqFKgBUJw3Mks6GlDVCdzb
         YOeAgaXLfYmz1XuHNzz5x+YJG4pGARubs1JjhqAYEX1LsBAftI8VIer8KFs5QhXcLHCZ
         6AAPqAWcBiF4YV0EG2wuCxr5js3wcupIF/pzZNdwMsZ61LvRKpr7y/asGOHH3IT7VR0S
         DeAQ==
X-Gm-Message-State: AOAM532A+I9vVcz2MpxAApcwZ6Y8sTXIsqgLhvpQqBCEI7zXpWcWnaDT
        NInQg2sVU0VibT/56Jr99Zk=
X-Google-Smtp-Source: ABdhPJxiPwXQAiPwWYh6vtomHnxZoY1K59zNlS+VmQXw0PDw8+u0RGXKXuPYc7h1h7lK2LzN3lQ2jQ==
X-Received: by 2002:a05:6214:144e:: with SMTP id b14mr12439157qvy.8.1629042931268;
        Sun, 15 Aug 2021 08:55:31 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id 37sm3611235qtf.33.2021.08.15.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 08:55:30 -0700 (PDT)
Date:   Sun, 15 Aug 2021 08:55:25 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Barry Song <song.bao.hua@hisilicon.com>,
        kernel test robot <lkp@intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>,
        linux-xtensa@linux-xtensa.org, gcc@gcc.gnu.org,
        gcc-bugs@gcc.gnu.org
Subject: Re: [PATCH] lib: bitmap: Mute some odd section mismatch warning in
 xtensa kernel build
Message-ID: <YRk47aybKnJIMeV0@yury-ThinkPad>
References: <20210815032132.14530-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815032132.14530-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 03:21:32PM +1200, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> Constanly there are some section mismatch issues reported in test_bitmap
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
> always called in __init function in test_bitmap.c just like __bitmap_equal.
> But gcc doesn't report any issue for __bitmap_equal even when bitmap_equal
> and __bitmap_equal show in the same function such as:
> 
>   static void noinline __init test_mem_optimisations(void)
>   {
> 	...
>           for (start = 0; start < 1024; start += 8) {
>                   for (nbits = 0; nbits < 1024 - start; nbits += 8) {
>                           if (!bitmap_equal(bmap1, bmap2, 1024)) {
>                                   failed_tests++;
>                           }
>                           if (!__bitmap_equal(bmap1, bmap2, 1024)) {
>                                   failed_tests++;
>                           }
>   			...
>                   }
>           }
>   }
> 
> The different between __bitmap_equal() and bitmap_equal() is that the
> former is extern and a EXPORT_SYMBOL. So noinline, and probably in fact
> noclone. But the later is static and unfortunately not inlined at this
> time though it has a "inline" flag.
> 
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
> 		...
>         }
> }
> Looks like gcc optimized arr, bmap2 things to .init.data but it seems
> nothing is wrong in kernel since test_bitmap_arr32() is __init.
> 
> Max Filippov reported a bug to gcc but gcc people don't ack. So here
> this patch removes the involved symbols by forcing inline. It might
> not be that elegant but I don't see any harm as bitmap_equal() and
> bitmap_copy_clear_tail() are both quite small. In addition, kernel
> doc also backs this modification "We don't use the 'inline' keyword
> because it's broken": www.kernel.org/doc/local/inline.html

This is a 2006 article. Are you sure nothing has been changed over the
last 15 years?
 
> Another possible way to "fix" the warning is moving the involved
> symboms to lib/bitmap.c:

So, it's a GCC issue already reported to GCC? For me it sounds like
nothing to fix in kernel. If I was a GCC developer, I'd prefer to have
all bugs clearly reproducible. 

Let's wait for GCC and xtensa people comments. (CC xtensa and GCC
lists)

Yury

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
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Andrew Pinski <pinskia@gmail.com>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  include/linux/bitmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 37f36dad18bd..3eec9f68a0b6 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -258,7 +258,7 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
>  /*
>   * Copy bitmap and clear tail bits in last word.
>   */
> -static inline void bitmap_copy_clear_tail(unsigned long *dst,
> +static __always_inline void bitmap_copy_clear_tail(unsigned long *dst,
>  		const unsigned long *src, unsigned int nbits)
>  {
>  	bitmap_copy(dst, src, nbits);
> @@ -334,7 +334,7 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
>  #endif
>  #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
>  
> -static inline int bitmap_equal(const unsigned long *src1,
> +static __always_inline int bitmap_equal(const unsigned long *src1,
>  			const unsigned long *src2, unsigned int nbits)
>  {
>  	if (small_const_nbits(nbits))
> -- 
> 2.25.1
