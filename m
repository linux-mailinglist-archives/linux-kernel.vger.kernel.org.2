Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C174238B7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhETTqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbhETTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:46:03 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7140FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:44:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h11so16240771ili.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5EGzMVSklsVagwFMiqDNnX9HkmidH4tvnfTm5VSWBuc=;
        b=Fo1HU5BpW2WfgTGr41Gnk9WHy+jxnjI2UUO7FZhNeg0IpwNnngbWX3FO53l1ap679H
         HNmm/WNtqqzQvi31UKFzNHucePJr9krPWfbKYNv0+SLG+i4BrOKGKGSP5AHkNAuRwx/9
         M1AGXcqepkuZgXiR+eBKJtrvEAueBrrBF/8+32yRYtfl1+ctFPmptsNJ/xx6/MZznBOj
         iiaU+JO8fM04s2YVVVcV1750Ck135bHb26d2P8KWkRpAzah65Vysf/gNS652oZUbsr0I
         4p2EcUgrlCudYyqiIz5HlrjNH9j+kZt3JPwDsjr4tEOWbaGADUjep+a4RBId9kj7wCWQ
         iVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5EGzMVSklsVagwFMiqDNnX9HkmidH4tvnfTm5VSWBuc=;
        b=q0KwxpymchGSIZUqnn/HeFGG1RTj0fDdenOOPgbo7pja5Olx86m3b2GNxH402P50Yp
         u6czy/ZSxyxiRZiJo1mrPwV9EdXFU/6qRiHVFqeKbJmIII0+GXwJMQQMzpvBXjJamYGS
         QBNgJhX4gRNFW6Z8ARaL4ZGIXx+TrCKZMZ4hN2Cmiio4Tw94dBlB4w2jjJfofxku4ypD
         FfZYyIO1JNAm6ugWI4TGqAWTfhDJFmpu/KcbX5b5VvVPmmdK4P3xqMPNc4nmFSyjhQKZ
         qphX0mOvty9CNlg16JxFDEPdYd7tZQfZMk5bymooXqSml8fYUeRrv6XSZopTC1RRWkrm
         GKyw==
X-Gm-Message-State: AOAM532TmZOZOwkhnmMRVN12oXxXX/u7SeKRK06IQxC3nKKQ0SKY7XWk
        FKjRzIl+LsK8CSpeIlb9y1I=
X-Google-Smtp-Source: ABdhPJzgNFhi20re2/prh0boePa94zwZ8WaOL3u09GLrowF2lvDmXcRVQM4e7k+UdbRrihJlcBbDVw==
X-Received: by 2002:a05:6e02:190b:: with SMTP id w11mr7769492ilu.197.1621539880523;
        Thu, 20 May 2021 12:44:40 -0700 (PDT)
Received: from localhost (65-130-60-221.slkc.qwest.net. [65.130.60.221])
        by smtp.gmail.com with ESMTPSA id m17sm2013251ioc.0.2021.05.20.12.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:44:40 -0700 (PDT)
Date:   Thu, 20 May 2021 12:44:38 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] linux/bits.h: Fix compilation error with GENMASK
Message-ID: <YKa8JjT9AFOspIl5@yury-ThinkPad>
References: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
 <CAMj1kXF0rMwjgm27=i3XkrXJ=21C_x4he5Ls+7FSKUhsva970Q@mail.gmail.com>
 <YKaukFKw4KTmnOVd@rikard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKaukFKw4KTmnOVd@rikard>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 08:46:40PM +0200, Rikard Falkeborn wrote:
> On Wed, May 12, 2021 at 02:53:27PM +0200, Ard Biesheuvel wrote:
> > (+ Arnd)
> > 
> > On Tue, 11 May 2021 at 22:37, Rikard Falkeborn
> > <rikard.falkeborn@gmail.com> wrote:
> > >
> > > GENMASK() has an input check which uses __builtin_choose_expr() to enable
> > > a compile time sanity check of its inputs if they are known at compile
> > > time. However, it turns out that __builtin_constant_p() does not always
> > > return a compile time constant [0]. It was thought this problem was fixed
> > > with gcc 4.9 [1], but apparently this is not the case [2].
> > >
> > > Switch to use __is_constexpr() instead which always returns a compile
> > > time constant, regardless of its inputs.
> > >
> > > [0]: https://lore.kernel.org/lkml/42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk
> > > [1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
> > > [2]: https://lore.kernel.org/lkml/1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp
> > >
> > > Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > ---
> > > Feedback on placing __is_constexpr() in const.h is welcome, at least the
> > > name is appropriate...
> > >
> > >  include/linux/bits.h        |  2 +-
> > >  include/linux/const.h       |  8 ++++++++
> > >  include/linux/minmax.h      | 10 ++--------
> > >  tools/include/linux/bits.h  |  2 +-
> > >  tools/include/linux/const.h |  8 ++++++++
> > >  5 files changed, 20 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > > index 7f475d59a097..87d112650dfb 100644
> > > --- a/include/linux/bits.h
> > > +++ b/include/linux/bits.h
> > > @@ -22,7 +22,7 @@
> > >  #include <linux/build_bug.h>
> > >  #define GENMASK_INPUT_CHECK(h, l) \
> > >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > > +               __is_constexpr((l) > (h)), (l) > (h), 0)))
> > >  #else
> > >  /*
> > >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > > diff --git a/include/linux/const.h b/include/linux/const.h
> > > index 81b8aae5a855..435ddd72d2c4 100644
> > > --- a/include/linux/const.h
> > > +++ b/include/linux/const.h
> > > @@ -3,4 +3,12 @@
> > >
> > >  #include <vdso/const.h>
> > >
> > > +/*
> > > + * This returns a constant expression while determining if an argument is
> > > + * a constant expression, most importantly without evaluating the argument.
> > > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > > + */
> > > +#define __is_constexpr(x) \
> > > +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> > > +
> > >  #endif /* _LINUX_CONST_H */
> > > diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> > > index c0f57b0c64d9..5433c08fcc68 100644
> > > --- a/include/linux/minmax.h
> > > +++ b/include/linux/minmax.h
> > > @@ -2,6 +2,8 @@
> > >  #ifndef _LINUX_MINMAX_H
> > >  #define _LINUX_MINMAX_H
> > >
> > > +#include <linux/const.h>
> > > +
> > >  /*
> > >   * min()/max()/clamp() macros must accomplish three things:
> > >   *
> > > @@ -17,14 +19,6 @@
> > >  #define __typecheck(x, y) \
> > >         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> > >
> > > -/*
> > > - * This returns a constant expression while determining if an argument is
> > > - * a constant expression, most importantly without evaluating the argument.
> > > - * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > > - */
> > > -#define __is_constexpr(x) \
> > > -       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> > > -
> > >  #define __no_side_effects(x, y) \
> > >                 (__is_constexpr(x) && __is_constexpr(y))
> > >
> > > diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> > > index 7f475d59a097..87d112650dfb 100644
> > > --- a/tools/include/linux/bits.h
> > > +++ b/tools/include/linux/bits.h
> > > @@ -22,7 +22,7 @@
> > >  #include <linux/build_bug.h>
> > >  #define GENMASK_INPUT_CHECK(h, l) \
> > >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > > +               __is_constexpr((l) > (h)), (l) > (h), 0)))
> > >  #else
> > >  /*
> > >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > > diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
> > > index 81b8aae5a855..435ddd72d2c4 100644
> > > --- a/tools/include/linux/const.h
> > > +++ b/tools/include/linux/const.h
> > > @@ -3,4 +3,12 @@
> > >
> > >  #include <vdso/const.h>
> > >
> > > +/*
> > > + * This returns a constant expression while determining if an argument is
> > > + * a constant expression, most importantly without evaluating the argument.
> > > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > > + */
> > > +#define __is_constexpr(x) \
> > > +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> > > +
> > >  #endif /* _LINUX_CONST_H */
> > > --
> > > 2.31.1
> > >
> 
> Friendly ping.

I added this patch in my Bitmap tree, but since it's actually a build
bug fix, I think it's worth to move it faster with Arnd's or Andrew's
trees?
