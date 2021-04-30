Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7514236F324
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhD3AUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhD3AUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 20:20:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65478C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 17:20:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x2so1596028lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 17:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZbEDaYJJ2ZU3PyMfxqDqMhy1JQaRV75XScMf9TkTpI=;
        b=mb4lanW0jhWBaqYrtk2S8vca3liucD2kMNdAj/rxy8o6NiUXdGD9E6eS1GP0n4/Pf+
         HLsjZe6K6VMgM6yzZP/PWqtEnO0f+ql2Myf2jxLZimExdYpLjai2U6ardJu0U7UfiRb7
         iDjEIKkZZOSaemlbIgjKnxd3OjaOczHYuh/PEtZgSPyrb2THPezxLjPCLmHsiyzOgEQF
         rro7OiGFgn4RTlUl8yBOtjQT/1MtTOvnmWwW7rqSrFnav1l+RnTWi4rj3v3wpshCDu2T
         NzdYPLWLRpSmhW19p/BBC2Ct2c0i/CFoj3HTe+YOPBV5f3Xn5QojSM4N5TVmtRR9izc4
         2YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZbEDaYJJ2ZU3PyMfxqDqMhy1JQaRV75XScMf9TkTpI=;
        b=A8wIXPDV6UWb00kr/eCRuwbT8le3/ANGbDaKnNvXjUWvL7s9kNT8e3TWQu5BE0ex8V
         eCfRA1X/pmMQR4XCHOKln5bf9YlYIhnZUH6ZZuaqnrgzLEZVWyIps4VX6r79JQqOhBdW
         Yn9qNcn/b3vaRffJ4PvjH+vySmQK+PDq0uZkZ1y+H6LxSWiNoegScEhwWO67a9ftQPPS
         tC0t4g1shl5y89kWwjXzFnojE8xkKKLxOkctpmPHnwgbpc/FUgbrQdNj6UZiqtmvCaIF
         y5B+eC6tGk5WBg8zD/Vhx3w5GNVvzdQsuYPSc483jyi2rshWURZfr05uRw6uU3sfAGZv
         LtnQ==
X-Gm-Message-State: AOAM5304Q7m/Am+gQmIlL0Ole+rUb8UNcc143ZPvAac/NVTrNf3Xm30l
        OxNBptuwNRzO89+JBtxPpgKrPvtichlXAlzphGzy1Q==
X-Google-Smtp-Source: ABdhPJzIz0m70x0xFUNVWBpwMHESwJQV4le2k3tDiCXMVPKg1AioYXGI6FMZ/8jMKAOAe7UGSN5ne5/dLALy/3MHTpg=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr1384378lft.368.1619741998508;
 Thu, 29 Apr 2021 17:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Apr 2021 17:19:47 -0700
Message-ID: <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 2:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I haven't looked into why this is so slow with clang, but it really is
> painfully slow:
>
>    time make CC=clang allmodconfig
>    real 0m2.667s
>
> vs the gcc case:
>
>     time make CC=gcc allmodconfig
>     real 0m0.903s

Hmmm...I seem to only be able to reproduce such a drastic difference
between the two if I:
1. make clean
2. time make CC=<either> allmodconfig
3. time make CC=<the other> allmodconfig

without doing another `make clean` in between 2 and 3; and regardless
which toolchain I use first vs second.  Otherwise I pretty
consistently get 1.49-1.62s for clang, 1.28-1.4s for gcc; that's a
build of clang with assertions enabled, too.

Can you confirm your observations with `make clean` between runs? Can
you provide info about your clang build such as the version string,
and whether this was built locally perhaps?

>
> Yeah, yeah, three seconds may sound like "not a lot of time, but
> considering that the subsequent full build (which for me is often
> empty) doesn't take all that much longer, that config time clang waste
> is actually quite noticeable.
>
> I actually don't do allmodconfig builds with clang, but I do my
> default kernel builds with it:

:)

>
>     time make oldconfig
>     real 0m2.748s
>
>     time sh -c "make -j128 > ../makes"
>     real 0m3.546s
>
> so that "make oldconfig" really is almost as slow as the whole
> "confirm build is done" thing. Its' quite noticeable in my workflow.
>
> The gcc config isn't super-fast either, but there's a big 3x
> difference, so the clang case really is doing something extra wrong.
>
> I've not actually looked into _why_. Except I do see that "clang" gets
> invoked with small (empty?) test files several times, probably to
> check for command line flags being valid.

There's probably more we can be doing to speed up the flag checking
case; Nathan had a good idea about using -fsyntax-only to stop the
compilation pipeline after flags have been validated.  I think we
should run some testing on that to see if it makes a measurable
impact; I'd imagine that being beneficial to both compilers.

>
> Sending this to relevant parties in the hope that somebody goes "Yeah,
> that's silly" and fixes it.
>
> This is on my F34 machine:
>
>      clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)
>
> in case it matters (but I don't see why it should).
>
> Many many moons ago the promise for clang was faster build speeds.
> That didn't turn out to be true, but can we please at least try to
> make them not painfully much slower?

Ack. Forwarded that request directly up the chain of command. ;)

In the interest of build speed, have you tried LLD yet? `make LLVM=1
...` or `make LD=ld.lld ...` should do it; you'll find it's much
faster than the competition, especially when there's a large number of
cores on the host. Not going to help with the allmodconfig
configuration, but would definitely help incremental rebuilds.
-- 
Thanks,
~Nick Desaulniers
