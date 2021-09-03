Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF761400803
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 00:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhICWy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 18:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbhICWyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:54:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58955C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 15:53:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m4so1068154ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1UusdViFFBuetq7EEGyT5944Rjn0sdVUBMj3i15uGo=;
        b=Ztib0QRdS0bP2LnfrFdyNx6hgh7WNpI8kVdoZ4Ov6xduTcI+EtN0o1KUtBqCh16jhd
         XSy6ppmLA3eSUrpsOeaP3FQ5O+9b1tARfqIXLeUbkgZPSq+Vtfici2L7tAXB6QKOilck
         S4M5Xbnhon1Xwfh8+N7hhZrAQAVXxbOmJ0714=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1UusdViFFBuetq7EEGyT5944Rjn0sdVUBMj3i15uGo=;
        b=dTf0YmxjBYoy1nx1FJUdWZpSR6m18C7Aer9KZJ4uMTJmuNbT8P7msrPFHpDBKURczt
         RTtzkdxNVwY38p3YZqMFuuiCuZ2q3930LniqFx7kD+7EKJxIXV84snS8/urb+38wkaNX
         +WO73e3D7Ky4t5ZSsvSBx/pnKnglbKGK+Xc1XAJI2tFOgAuyRtt3a4nNnSv0ChXFOMCN
         gIUqqPYIuS64dnsRq4417CrHxIpN7GoWCPeiKeBxdu7UbHqhgexjfTP7g+Rhms+2FvLp
         BdzcU4HqIB+vi4n6EdQsobdejzHrtYSNMyhNv3WUHY9WrBT5jKK+9BAnP3Wd08LSiFj+
         THXw==
X-Gm-Message-State: AOAM531eOLGanZjGsHGS/jBE5Z9FDxVq3MW5v0C7Uj8U0W+91uogO9O3
        kW2QjNO/31ZpaXolvEsqnwRhZ5fhi8nGo7KgAQs=
X-Google-Smtp-Source: ABdhPJycVp6PP+tfja6W9Mu06zLKojlPAFOWlwjdwn3o+o1p5DzqU2cU/AJ9CY9UuVnqU81u8/ZTPA==
X-Received: by 2002:a2e:b55b:: with SMTP id a27mr913883ljn.353.1630709602409;
        Fri, 03 Sep 2021 15:53:22 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id u28sm72233lfm.162.2021.09.03.15.53.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 15:53:21 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y34so1215924lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 15:53:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3d28:: with SMTP id d40mr840792lfv.474.1630709601452;
 Fri, 03 Sep 2021 15:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQ0Q6CdXaD-dVGj_e3O3JYs_crpejWKpXHYQJYxyk-1VQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQ0Q6CdXaD-dVGj_e3O3JYs_crpejWKpXHYQJYxyk-1VQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 3 Sep 2021 15:53:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoX0pVqNMMOcrhq=nuOfoZB_3qihyHB3y1S8qo=MDs6w@mail.gmail.com>
Message-ID: <CAHk-=wgoX0pVqNMMOcrhq=nuOfoZB_3qihyHB3y1S8qo=MDs6w@mail.gmail.com>
Subject: Re: [GIT PULL v2] Kbuild updates for v5.15-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 4:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I fixed the warnings observed in the previous PR.

Ok, let's try it again.

>  - Add <linux/stdarg.h> to the kernel source instead of borrowing
>    <stdarg.h> from the compiler.

So I certainly agree with the reasoning, but this worries me a bit.

stdarg is truly intimately an internal compiler file, in ways that
stddef (to pick another example) isn't.

Yeah, yeah, offsetof() is "kind of compiler internal", and we end up
using __compiler_offsetof(), but in the absence of that we *can* just
do it by hand. So offsetof() really is one of those things where we
can just do our own version if some compiler is being difficult.

But va_start and friends absolutely *must* match the exact compiler version.

It does look like both gcc and clang have just standardized on using
__builtin_xyz for all the different stdarg things, and so I approve of
what that <linux/stdarg.h> ended up looking like.

But at the same time, it does make me go "ok, this is a big new
assumption that we've consciously avoided for a long time".

Nick is already on the cc here for other reasons, but let's add the
clang-built list and Nathan explicitly. Because this basically
codifies that

    typedef __builtin_va_list va_list;
    #define va_start(v, l)  __builtin_va_start(v, l)
    #define va_end(v)       __builtin_va_end(v)
    #define va_arg(v, T)    __builtin_va_arg(v, T)
    #define va_copy(d, s)   __builtin_va_copy(d, s)

being the way all the supported compilers work.

Did people talk to any gcc maintainers too? We don't have the same
kind of "gcc kernel people" list or contacts. The above builtins have
been the case for a long long time for gcc, so I don't think it's
wrong or likely to change, but I think it would be a good thing to
just make compiler people aware of how we're now relying on that
explicitly.

(Side note: Linux using the compiler <stdarg.h> goes so far back that
it very much predates all those nice builtins. I still have memories
of <stdarg.h> being a collection of nasty per-architecture messes back
in the bad old days. So I'm actually happy we can do this now, but
there most definitely was a time when we really really had to use the
compiler-provided stdarg.h).

                Linus
