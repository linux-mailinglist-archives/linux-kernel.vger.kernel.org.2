Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6C43BAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhJZTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhJZTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:31:16 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006CC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:28:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m26so444222pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/pu9VbN2omlQedwABoANNiq+a4lKTveMAciuIXttxDs=;
        b=eKddtGzREu9Bqc3EM227h9mdIsL8vzdmHc7iZOGgVjWp4tc+1k5BBpp3PnUmOmapgu
         zjvbktEnHWnElTuG2q+eRWdA/dHzVJUx6pituYsEgSiv8pHLoMkal0jKYSV2ezSUWMXk
         fGlUet6sw5Zz5kqw2n7KmfF2aUWmNYdL5ZPa3SsKvkAcwy4Jgqkh/XYlymH/xfm4LDqF
         Kw2poMtqOo6RB9jLxa3ridNGBabRoVnhp7GhXAlwwRQ9cZxjtFiRNJgOvaOq+OHK+OCB
         OQ46i9YbeQoN169lHWM89MQnCwyJ+U0yKbDtWHQtMSRckxXwbNL84pLdvfBOfrrthJot
         WkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/pu9VbN2omlQedwABoANNiq+a4lKTveMAciuIXttxDs=;
        b=e0IvkYfUtWp6UH2ZcgLRDeNuAT2i7duyFKtf62CncWW+ujC55sqdYP2BJjZ6Gg3V1S
         GyOqMEloOpvURMQu+7deiy3FxMcpUl3MoDnXkqV7zhqRB13WU8Mzo382pwSlnOHmNtdK
         QxO+UnDQjF+5flkS+qFxl8juGmH4H/mhMDpQ8oC4FkjVxetq3MEAoDPQECP9oXHL7JDA
         MdX6qy6/C4FVadU0mJV6ArmS5BdvmTsCacIWwPosvX6EAFR9SpawLAopIXUiwGkrPCks
         k/gb4OlgHBlfRyTj4KSonUBv1rw6Z/CB7cu8UleT4lCG5NZtcmyBbFohEr20/wlO6nkJ
         oUEw==
X-Gm-Message-State: AOAM531DIUMFXsaHnBStggjUEgnUbED5b7zxvYn+dhJYw1nVbyFsqmM/
        2IbPCQ7WpLTHzrass34QfVs=
X-Google-Smtp-Source: ABdhPJwwGH0qYYMJKDLaPfSL6XxI27U50JDqur9eIKqKArhmUjGx6TucFUlbZtFDw4TJqkC+hbtO7A==
X-Received: by 2002:a05:6a00:1489:b0:47c:29db:a199 with SMTP id v9-20020a056a00148900b0047c29dba199mr104325pfu.33.1635276531909;
        Tue, 26 Oct 2021 12:28:51 -0700 (PDT)
Received: from localhost (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e24sm22761599pfn.8.2021.10.26.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:28:51 -0700 (PDT)
Date:   Tue, 26 Oct 2021 12:28:48 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
Message-ID: <YXhW8K7DxadyVgx3@yury-ThinkPad>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXhOEEOSG+fgEy+t@yury-ThinkPad>
 <YXhVVvG9keoVWJyK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXhVVvG9keoVWJyK@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:21:58PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 26, 2021 at 11:54:16AM -0700, Yury Norov wrote:
> > On Tue, Oct 26, 2021 at 10:41:08AM -0400, Qian Cai wrote:
> > > Since "size" is an "unsigned int", the rvalue "size - 1" will still be
> > > "unsigned int" according to the C standard (3.2.1.5 Usual arithmetic
> > > conversions). Therefore, GENMASK(size - 1, 0) will always return 0UL. Those
> > > are also caught by GCC (W=2):
> > > 
> > > ./include/linux/find.h: In function 'find_first_bit':
> > > ./include/linux/bits.h:25:22: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
> > >    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
> > >       |                      ^
> > > ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> > >    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > >       |                                                              ^
> > > ./include/linux/bits.h:25:3: note: in expansion of macro '__is_constexpr'
> > >    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
> > >       |   ^~~~~~~~~~~~~~
> > > ./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > >    38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > >       |   ^~~~~~~~~~~~~~~~~~~
> > > ./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
> > >   119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
> > >       |                               ^~~~~~~
> > > ./include/linux/bits.h:25:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
> > >    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
> > >       |                                  ^
> > > ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> > >    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > >       |                                                              ^
> > > ./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > >    38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > >       |   ^~~~~~~~~~~~~~~~~~~
> > > ./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
> > >   119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
> > >       |                               ^~~~~~~
> > > 
> > > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> > > ---
> > >  include/linux/find.h | 28 ++++++++--------------------
> > >  1 file changed, 8 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/include/linux/find.h b/include/linux/find.h
> > > index 5bb6db213bcb..5ce2b17aea42 100644
> > > --- a/include/linux/find.h
> > > +++ b/include/linux/find.h
> > > @@ -115,11 +115,8 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> > >  static inline
> > >  unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> > >  {
> > > -	if (small_const_nbits(size)) {
> > > -		unsigned long val = *addr & GENMASK(size - 1, 0);
> > > -
> > > -		return val ? __ffs(val) : size;
> > > -	}
> > > +	if (small_const_nbits(size))
> > > +		return size;
> > >  
> > >  	return _find_first_bit(addr, size);
> > >  }
> > 
> > [...]
> > 
> > Nice catch! I'm a bit concerned that small_const_nbits() will never
> > allow GENMASK() to be passed with size == 0, but the patch looks
> > good to me overall.
> 
> Can you explain to me how it is supposed to work?
> 
> For example,
> 
>     x = 0xaa55;
>     size = 5;
> 
>     printf("%lu\n", find_first_bit(&x, size));
> 
> In the resulting code we will always have 5 as the result,
> but is it correct one?

I think it would work really bad and fail to load the kernel
for many systems, especially those with NR_CPUS == 64 or less.

That's why I think Apr 1 branch is a good place  for it.
