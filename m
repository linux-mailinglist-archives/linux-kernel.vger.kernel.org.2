Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5CB3A70B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhFNUwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:52:47 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:33594 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhFNUwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:52:45 -0400
Received: by mail-lf1-f44.google.com with SMTP id bp38so23308246lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8yZyD8Qxeaf9TxEOG5j+rcsyw3CCIJC6f3Y8GUzKlI=;
        b=FwsY9dIC3IaG2Ak8rp0lm7uluQN8dbgehHV2TIVQyx98A+obaK1k4e2raRoeYlnfKU
         1Mqe08vQex+QNkn+2ZHVa6wan1Cwx/lX8eYch/6jucnH21Q+8JaBKiF4RQmUCXHtN4Ql
         0NNJi7Ti6hCKtulSglwykq2lBRq3m/lg+TZskSPYR3r7DonLl+Ft1xlc6vunbF62NYEu
         l4oHURk707CoxCGWPfKXXKfeCdaYb2b/G4OdpK4pwerASPRmQoG83cXVtPDyNWw/ZqK5
         Vv3nDV3z1F4haStaGLxHeYZ3SI1OjiVBnT6LNl4mAhtQ9wcmvX1So8gC1sjAaVKKve0k
         XuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8yZyD8Qxeaf9TxEOG5j+rcsyw3CCIJC6f3Y8GUzKlI=;
        b=K9dkTrM9gqe2g+MFKSeJi4y6AxcBAxml+ooCZCra3gVCoSPMvKBaaUnrT3z8i0corr
         pFMpDu6ks/L+zNCOgucx9dR2NoqaKofy+zdyFghoUdVtK9n+0x+mRyobSf2Yf+aGSoo2
         P2gEpu6573JIUq1ntjD9wvaG+GOYBZlt3MIPPlbG4q5BbHghS2bOm9Vz3U9QBzBXuYf1
         fGWbiuhM4K46Q5eIyLoc3tlqFj+M/M9G2y5zOzcq6BhAgBniGWdVeRuyPsbP8mAMxua1
         dcer/ODLCieyKBvpjmLdamUgddMvy/CLmFxqkuDZM35py3LpPDR9GLwUfy6VzRb9m2HA
         BE7Q==
X-Gm-Message-State: AOAM532GBQhJBIQ8MTqME8phgwFW4P9NoXaL1CRSzCWKbNifADF2Fx2L
        dzNIzIm70M47NY0DEjleWBAPC0+ww1F0UF/5kR1c1Q==
X-Google-Smtp-Source: ABdhPJwEyfMEBTymX7iJX4uhK2ViDEmCDThTv4U+RoZC2hiqVBRU5+NheHfIWcc38hpYP76juY/W0FF4SfuBlmgs+y8=
X-Received: by 2002:a19:4843:: with SMTP id v64mr13899409lfa.374.1623703781370;
 Mon, 14 Jun 2021 13:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <YMT5xZsZMX0PpDKQ@hirez.programming.kicks-ass.net>
 <CAGG=3QVHkkJ236mCJ8Jt_6JtgYtWHV9b4aVXnoj6ypc7GOnc0A@mail.gmail.com>
 <20210612202505.GG68208@worktop.programming.kicks-ass.net>
 <CAGG=3QUZ9tXGNLhbOr+AFDTJABDujZuaG1mYaLKdTcJZguEDWw@mail.gmail.com>
 <YMca2aa+t+3VrpN9@hirez.programming.kicks-ass.net> <CAGG=3QVPCuAx9UMTOzQp+8MJk8KVyOfaYeV0yehpVwbCaYMVpg@mail.gmail.com>
 <YMczJGPsxSWNgJMG@hirez.programming.kicks-ass.net> <CANpmjNNnZv7DHYaJBL7knn9P+50F+SOCvis==Utaf-avENnVsw@mail.gmail.com>
 <202106140817.F584D2F@keescook> <20210614153545.GA68749@worktop.programming.kicks-ass.net>
 <202106140921.5E591BD@keescook> <CAKwvOdkiQCuWB7VrQ4T-OCdoNfqKhpLx_jtBQ_uyjVVwHSOc=A@mail.gmail.com>
In-Reply-To: <CAKwvOdkiQCuWB7VrQ4T-OCdoNfqKhpLx_jtBQ_uyjVVwHSOc=A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Jun 2021 13:49:29 -0700
Message-ID: <CAKwvOdmqLh_9WkBmMYGZ9ztX+eJ95aTQsyUB+qXYPZHun8+nMg@mail.gmail.com>
Subject: Re: [PATCH v9] pgo: add clang's Profile Guided Optimization infrastructure
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Marco Elver <elver@google.com>, Bill Wendling <morbo@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        oberpar@linux.vnet.ibm.com, linux-toolchains@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:07 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 14, 2021 at 9:23 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 14, 2021 at 05:35:45PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 14, 2021 at 08:26:01AM -0700, Kees Cook wrote:
> > > > So, AFAICT, the original blocking issue ("PGO does not respect noinstr")
> > > > is not actually an issue (noinstr contains notrace, which IS respected
> > > > by PGO[2]), I think this is fine to move forward.
> > >
> > > It is *NOT*: https://godbolt.org/z/9c7xdvGd9
> > >
> > > Look at how both compilers generate instrumentation in the no_instr()
> > > function.
> >
> > Well that's disappointing. I'll put this on hold until Clang can grow an
> > appropriate attribute (or similar work-around). Thanks for catching
> > that.
>
> Cross referencing since these two threads are related.
> https://lore.kernel.org/lkml/CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com/

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80223 looked appropriate
to me, so I commented on it.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80223#c6

Patches for:
PGO: https://reviews.llvm.org/D104253
GCOV: https://reviews.llvm.org/D104257
--
Thanks,
~Nick Desaulniers
