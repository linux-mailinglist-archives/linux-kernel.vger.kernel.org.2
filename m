Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74F734B98A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 22:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhC0Vch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 17:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhC0VcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:32:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C979EC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 14:32:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a11so6822771qto.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nPWRwHmfq4Zmt4hFa5K1RVgUhvjMzzjWoxdOmetcAXo=;
        b=oKPxVtLPVsWlsJDJZLq/AseVaCNlMKAeoltozt96jOfHYQvpQoUpMr4cnfJXhUC0kZ
         IdhFhLi9oND6KR6IcTMwuAGZ+66yROV+sTf3x0QJLu9aNbkkhJIXn93kTl85LEpWFfgq
         VloeA8qJ0cE6qFFXH+FNDddPLySb+h9+C0P6A7eA31sjAZnupztzYhunaYh6+UW88pCs
         4Zn1r7ztKdKMO6ZixmaJ14oGS4QSgiQudAF2Ine9XKl6Gxty6y53nRIx9a1u+Uit32oX
         pcwUFDtLay0fNtDlXT1RUnDPA7JFCcoS3abjoGoxuzIw8gEPWaTn6S8ZZNzXmO0Bz4Uq
         ydVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPWRwHmfq4Zmt4hFa5K1RVgUhvjMzzjWoxdOmetcAXo=;
        b=QF+XcidnPMosH3XuJTWXldlh8nl6MBKp+U3fWRwQYZOihF7aYi12PnSSAQPvr3hwh2
         CS2ri0VQy2c6p38WOCxSgDaffFjiYagtteU94KbxLyKC5j8tzKfgdvhH0tjWcxaRwuHN
         q+uAe44nxv2yOtQ7F0UQbwD14+nFYdHRVhkS8NOn617jaTaYZdNrz7fwWMhoApkvkBh1
         O1NCAFkdVbVqi4HlLEdi3GZiUKyMGwy3olDhJH4/t6jVrocgnO7RVT1/CaX+whwDRS0p
         typxfbj3Iqj1C83SMvDy+OhBm8cl4rK3Ji6MJi5Vlkf4qow93YBVTHqINeoA3rrkwNhV
         42LA==
X-Gm-Message-State: AOAM532Vn+cs1sokxwUo1b4Eef3hRkSWz7Y2pOnRx0xAgUbH2UpiZM2q
        fARJx2zghcuFIaPL2evikQOQ+gG+yXo=
X-Google-Smtp-Source: ABdhPJy4tIaEhN6e4udyP2yKQGq9HQmjFEnbzeijIyNp6y9lvRcFIb/ZFguPlxs8JiBRwwXc/2K9lQ==
X-Received: by 2002:ac8:6606:: with SMTP id c6mr17950071qtp.76.1616880735831;
        Sat, 27 Mar 2021 14:32:15 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id u21sm7524687qtq.11.2021.03.27.14.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 14:32:15 -0700 (PDT)
Date:   Sat, 27 Mar 2021 14:32:14 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] kernel.h: Drop inclusion in bitmap.h
Message-ID: <20210327213214.GA133098@yury-ThinkPad>
References: <20210326170347.37441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326170347.37441-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 07:03:47PM +0200, Andy Shevchenko wrote:
> The bitmap.h header is used in a lot of code around the kernel.
> Besides that it includes kernel.h which sometimes makes a loop.
> 
> Break the loop by introducing align.h, including it in kernel.h
> and bitmap.h followed by replacing kernel.h with limits.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Can you give an example of such dependency?

Nevertheless,

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/align.h  | 15 +++++++++++++++
>  include/linux/bitmap.h |  3 ++-
>  include/linux/kernel.h |  9 +--------
>  3 files changed, 18 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/align.h
> 
> diff --git a/include/linux/align.h b/include/linux/align.h
> new file mode 100644
> index 000000000000..2b4acec7b95a
> --- /dev/null
> +++ b/include/linux/align.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ALIGN_H
> +#define _LINUX_ALIGN_H
> +
> +#include <linux/const.h>
> +
> +/* @a is a power of 2 value */
> +#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
> +#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
> +#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
> +#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
> +#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
> +#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
> +
> +#endif	/* _LINUX_ALIGN_H */
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 70a932470b2d..6cbcd9d9edd2 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -4,10 +4,11 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/align.h>
>  #include <linux/types.h>
>  #include <linux/bitops.h>
> +#include <linux/limits.h>
>  #include <linux/string.h>
> -#include <linux/kernel.h>
>  
>  /*
>   * bitmaps provide bit arrays that consume one or more unsigned
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 5b7ed6dc99ac..09035ac67d4b 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_KERNEL_H
>  
>  #include <stdarg.h>
> +#include <linux/align.h>
>  #include <linux/limits.h>
>  #include <linux/linkage.h>
>  #include <linux/stddef.h>
> @@ -30,14 +31,6 @@
>   */
>  #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
>  
> -/* @a is a power of 2 value */
> -#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
> -#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
> -#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
> -#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
> -#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
> -#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
> -
>  /* generic data direction definitions */
>  #define READ			0
>  #define WRITE			1
> -- 
> 2.30.2
