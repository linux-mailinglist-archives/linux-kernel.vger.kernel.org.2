Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7398D423743
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 06:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJFEyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 00:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJFEym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 00:54:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625EBC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 21:52:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r19so4944289lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KNLEP17J4fGFGePafL9e/em5qLyI4/H75ODeeqFPy4=;
        b=CaOWAOrwZbSOE5dR3MqwfrmPYlqUVOLLG6p1aODud/NwXWJQiRS5FhtR2EQZX8kY5m
         7Ecehb4y6Skh2dqABZH6BcO1ivS01STlLtgU6rYr4X8l9ZdhQsrxdzKCZYqiQxsX04n4
         RQx6CMFvAj8EzVHPEuI2uPckqFLkFZg5NV4y7hbH0ArIIQ6UZKmh/wBXA1CUlF6ZmWKw
         CeSu9cAiBP0WlSrHFkrisOU97HOwvbdx6OnjCEX6rSrIQVDmZn5LXFYvwtopuDuJlJTR
         3OB1sBumZXVU1owfxavZ008gv6hlsiHPcCMfRiGz3S15Jnf+obS6yrzmoiLKvZCwB/TM
         xhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KNLEP17J4fGFGePafL9e/em5qLyI4/H75ODeeqFPy4=;
        b=ouZjsO0mZ7iiQQFNE58ZsC4wyIh33nT8xrp/9kcA8enS8wxXtu7Em1h5qWjUxpnxy4
         G48kadUCgvxg3kerxIE3EpQCZdN+xNvQaI7DZSMfjzVfbOohQ7ZoGK2CKeFu1krpxpij
         cqdTfRPWjsI1idq7Et+GWF99IEPCX4jk+G6b7ppA5gho2lVNJ6YUnXwVROEP9sUOQHgk
         BtU0aIsl9wdEi5EV7n8RFbEA/z8QkxWmGGyC5XzCH6oobWyqRL7P6KK3L3I3beRYp8r8
         aPWj59unH8u/lIg/8Bgc8LAuL7VBri0NPVG/ijQhlKddhnL6VkhIIrRyMCzg/G3tdzrq
         8jWQ==
X-Gm-Message-State: AOAM5325DQGRbTbRWcAcYD2cwbhASDFnofdjK/nBkN6oQtOLoK67QpQV
        h9l9qhQqxLnSMxrAQxthI8YMov53zSYIlXuc6+NUcQ==
X-Google-Smtp-Source: ABdhPJxpUZzFJ/6ioAhBGcD9vzEImJPunmpEp6cj/Rk2Cc1xOWjoRZ7tWmMKzDF3Pm9+uwpJa5b8o2ZEyoA6j2g2vus=
X-Received: by 2002:ac2:4f01:: with SMTP id k1mr7561021lfr.157.1633495968423;
 Tue, 05 Oct 2021 21:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222704.2631604-1-keescook@chromium.org>
 <20210930222704.2631604-5-keescook@chromium.org> <20211005184717.65c6d8eb39350395e387b71f@linux-foundation.org>
 <202110052002.34E998B@keescook> <CAG48ez19raco+s+UF8eiXqTvaDEoMAo6_qmW2KdO24QDpmZpFQ@mail.gmail.com>
 <202110052056.F09CD8A@keescook>
In-Reply-To: <202110052056.F09CD8A@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 6 Oct 2021 06:52:21 +0200
Message-ID: <CAG48ez30MS2sNQX1Sb-MDF7SbLEbD8p0ncOvQteyj38fygG8bQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] slab: Add __alloc_size attributes for better
 bounds checking
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 5:56 AM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Oct 06, 2021 at 05:22:06AM +0200, Jann Horn wrote:
> > On Wed, Oct 6, 2021 at 5:06 AM Kees Cook <keescook@chromium.org> wrote:
> > > On Tue, Oct 05, 2021 at 06:47:17PM -0700, Andrew Morton wrote:
> > > > On Thu, 30 Sep 2021 15:27:00 -0700 Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > > As already done in GrapheneOS, add the __alloc_size attribute for regular
> > > > > kmalloc interfaces, to provide additional hinting for better bounds
> > > > > checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
> > > > > optimizations.
> > > >
> > > > x86_64 allmodconfig:
> > >
> > > What compiler and version?
> > >
> > > >
> > > > In file included from ./arch/x86/include/asm/preempt.h:7,
> > > >                  from ./include/linux/preempt.h:78,
> > > >                  from ./include/linux/spinlock.h:55,
> > > >                  from ./include/linux/mmzone.h:8,
> > > >                  from ./include/linux/gfp.h:6,
> > > >                  from ./include/linux/mm.h:10,
> > > >                  from ./include/linux/mman.h:5,
> > > >                  from lib/test_kasan_module.c:10:
> > > > In function 'check_copy_size',
> > > >     inlined from 'copy_user_test' at ./include/linux/uaccess.h:191:6:
> > > > ./include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> > > >   213 |    __bad_copy_to();
> > > >       |    ^~~~~~~~~~~~~~~
> > > > In function 'check_copy_size',
> > > >     inlined from 'copy_user_test' at ./include/linux/uaccess.h:199:6:
> > > > ./include/linux/thread_info.h:211:4: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small
> > > >   211 |    __bad_copy_from();
> > > >       |    ^~~~~~~~~~~~~~~~~
> > > > make[1]: *** [lib/test_kasan_module.o] Error 1
> > > > make: *** [lib] Error 2
> > >
> > > Hah, yes, it caught an intentionally bad copy. This may bypass the
> > > check, as I've had to do in LKDTM before. I will test...
> > >
> > > diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> > > index 7ebf433edef3..9fb2fb2937da 100644
> > > --- a/lib/test_kasan_module.c
> > > +++ b/lib/test_kasan_module.c
> > > @@ -19,7 +19,12 @@ static noinline void __init copy_user_test(void)
> > >  {
> > >         char *kmem;
> > >         char __user *usermem;
> > > -       size_t size = 128 - KASAN_GRANULE_SIZE;
> > > +       /*
> > > +        * This is marked volatile to avoid __alloc_size()
> > > +        * noticing the intentionally out-of-bounds copys
> > > +        * being done on the allocation.
> > > +        */
> > > +       volatile size_t size = 128 - KASAN_GRANULE_SIZE;
> >
> > Maybe OPTIMIZER_HIDE_VAR()? The normal version of that abuses an empty
> > asm statement to hide the value from the compiler.
>
> Oh! I hadn't seen that before. Is that better than volatile in this
> case?

It forces the compiler to assume an arbitrary modification of the
value, but doesn't force allocation of a stack slot like "volatile"
does, so it probably generates nicer code? Not that it really matters here...

It also has the difference that you can explicitly specify where the
compiler's analysis should cut off, instead of just doing it on every
access to a variable. But I guess maybe in this case, that's an
argument in favor of "volatile"? I don't know... I guess maybe
"volatile" does make sense here.
