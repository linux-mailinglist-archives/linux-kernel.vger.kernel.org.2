Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72B43BA04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhJZS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhJZS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:56:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CAC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:54:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o133so343173pfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=98AuoV5EOm7w9afvzWFd/lBCk8d+YMD1OZyUExE9f8o=;
        b=WbB115zh3Pc4McLFM1UKNsYNGwgnt1gxCcSxE3/YZYxBybxiP0vkd8DbNsaRNcfII2
         ykEVJ4qfMngvkn6nZtsrPyjiRRT9dyMbg3EBvXdGlApl++fpN2gS7J/sBMnj+AwT6YDZ
         NN8qTddXiPre52pjAH9FFeU7HPc8ckatGlyXHMEMz2Uo3I+eUdN0lkULZaMLy4MZDuez
         1ApabZ6QTkYXvv+hfHDdmEy1JXKfu9Au5FkaQUQoHmOd+GzMngHs91CzPgE31chDSuvQ
         qbcElUa1JV3mBNAjwxvh3NQhVyXRGxGieNH4N5fJrW0GtAanzzYb7xnSjHoq7dXSmTg5
         7ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=98AuoV5EOm7w9afvzWFd/lBCk8d+YMD1OZyUExE9f8o=;
        b=zNWJZUKa8jonqbYhiEt+SVUHUXIVIfw+uKPJq3+4RkeenYEL3Y3cMBiQrGkVOveA1P
         DVezX4OKMbbPMvRdf+b46KmTXp0jPR+WLZtRAdb5o88FniEK6fjD9HQ3nJcaEJaWEcKK
         cwMysC7gU1RKQto6i+tI+hCIXEBhmQ5G9kTdWwro04zwe7fks1X04ZrR+wCh9KMaaI/a
         Ynec1N+qhlJ/woZhPYf8oDUeIY/MaLiuyKnmkdTP4lwLEYeFn7BaZWDyivCDb3iizROn
         Pt6guKWzIOgikJPN3T8A3My5P6Z0figrSgxzya15YuHoehcuTeSzsWz+sbMr16kEb6Mr
         ss+w==
X-Gm-Message-State: AOAM531taO0/+4Ui70pAT45peJXxYL5pHDylKWBenvLePcgBNfDx6RdF
        Q5OGUYUTnP5ySFOoOEDNwZI=
X-Google-Smtp-Source: ABdhPJzNfB+dh4mvUY+7Txk+tr61n9by1tEsPBh6XNPLZ5lZVrAtRUZuxbETb9VZpDNc7jqdD16tJw==
X-Received: by 2002:a63:370c:: with SMTP id e12mr20425350pga.359.1635274459154;
        Tue, 26 Oct 2021 11:54:19 -0700 (PDT)
Received: from localhost (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j5sm1616737pjs.2.2021.10.26.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:54:18 -0700 (PDT)
Date:   Tue, 26 Oct 2021 11:54:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
Message-ID: <YXhOEEOSG+fgEy+t@yury-ThinkPad>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026144108.35373-1-quic_qiancai@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:41:08AM -0400, Qian Cai wrote:
> Since "size" is an "unsigned int", the rvalue "size - 1" will still be
> "unsigned int" according to the C standard (3.2.1.5 Usual arithmetic
> conversions). Therefore, GENMASK(size - 1, 0) will always return 0UL. Those
> are also caught by GCC (W=2):
> 
> ./include/linux/find.h: In function 'find_first_bit':
> ./include/linux/bits.h:25:22: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
>    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
>       |                      ^
> ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>       |                                                              ^
> ./include/linux/bits.h:25:3: note: in expansion of macro '__is_constexpr'
>    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
>       |   ^~~~~~~~~~~~~~
> ./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>    38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>       |   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
>   119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
>       |                               ^~~~~~~
> ./include/linux/bits.h:25:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
>    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
>       |                                  ^
> ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>       |                                                              ^
> ./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
>    38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>       |   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
>   119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
>       |                               ^~~~~~~
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---
>  include/linux/find.h | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 5bb6db213bcb..5ce2b17aea42 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -115,11 +115,8 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>  static inline
>  unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
>  {
> -	if (small_const_nbits(size)) {
> -		unsigned long val = *addr & GENMASK(size - 1, 0);
> -
> -		return val ? __ffs(val) : size;
> -	}
> +	if (small_const_nbits(size))
> +		return size;
>  
>  	return _find_first_bit(addr, size);
>  }

[...]

Nice catch! I'm a bit concerned that small_const_nbits() will never
allow GENMASK() to be passed with size == 0, but the patch looks
good to me overall.

It's too late to merge it in 5.15, so I will add it in a spring merge
window - most probably in a bitmap branch for 5.17 or 5.18:

https://github.com/norov/linux/tree/bitmap-2022-Apr-01

Thanks,
Yury
