Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C233497E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCJVIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:08:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhCJVI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:08:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 375CB64FD0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615410506;
        bh=LNLeEWghXkIt/oUlWgRYrFr83oynDcgDF0s3ejym2KU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i0/QmL4ZzLLOTbEAa606xhes1blfEB6MvhnUTOqiOcI5t8ekfl2yxC0RmI0mqfAka
         W35XzGuRR8x3esIGMjtq/O8Acdu0h4tUq3vJB4ieupj8g3PCJ1oaXk8ayw9U39fd9l
         OH9QM4nI/bqCIfPOkX/8GVA51Wy4nHpC3JTQ0dgLdgAIQ682D2bhtVscS8zr/mHwqb
         l+M5WquHt0JMaVNkiaqd646FRxIA4eZ5Ku1O6PzIo4ssvTZNeZES39okLFEHiJWKbp
         gXg+c6beLMjsw6+DLJqhQd+AD7c3aRgH/VMYjxFz8MmDFawQg3s4SqIhkKSZWyXiKs
         e5wEDcrjxhY3w==
Received: by mail-oi1-f170.google.com with SMTP id o22so10969909oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:08:26 -0800 (PST)
X-Gm-Message-State: AOAM531+z8XPPDayqvs1PYIRVcPP+Vh79CderVRqBjz6wRvWJtrhH7WB
        Ow+ul7MBw3JY3zNqQcGi+Ei/ey34nu9jaM8ewkQ=
X-Google-Smtp-Source: ABdhPJyOe6GvnaoIa1FUitLLUEiVyBHLxhohQtHqH1tV+ZiQNmopWBvLUhq2zHo3i/iEK8EMue18HWyjbUA1A2wkMiI=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr3623525oib.67.1615410505313;
 Wed, 10 Mar 2021 13:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com>
 <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
 <1614559739.p25z5x88wl.astroid@bobo.none> <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
In-Reply-To: <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Mar 2021 22:08:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
Message-ID: <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 9:50 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Mon, Mar 1, 2021 at 10:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:

>
> masahiro@oscar:~/ref/linux$ echo  'void this_func_is_unused(void) {}'
> >>  kernel/cpu.c
> masahiro@oscar:~/ref/linux$ export
> CROSS_COMPILE=/home/masahiro/tools/powerpc-10.1.0/bin/powerpc-linux-
> masahiro@oscar:~/ref/linux$ make ARCH=powerpc  defconfig
> masahiro@oscar:~/ref/linux$ ./scripts/config  -e EXPERT
> masahiro@oscar:~/ref/linux$ ./scripts/config  -e LD_DEAD_CODE_DATA_ELIMINATION
> masahiro@oscar:~/ref/linux$
> ~/tools/powerpc-10.1.0/bin/powerpc-linux-nm -n  vmlinux | grep
> this_func
> c000000000170560 T .this_func_is_unused
> c000000001d8d560 D this_func_is_unused
> masahiro@oscar:~/ref/linux$ grep DEAD_CODE_ .config
> CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
>
>
> If I remember correctly,
> LD_DEAD_CODE_DATA_ELIMINATION dropped unused functions
> when I tried it last time.
>
>
> I also tried arm64 with a HAVE_LD_DEAD_CODE_DATA_ELIMINATION hack.
> The result was the same.
>
>
>
> Am I missing something?

It's possible that it only works in combination with CLANG_LTO now
because something broke. I definitely saw a reduction in kernel
size when both options are enabled, but did not try a simple test
case like you did.

Maybe some other reference gets created that prevents the function
from being garbage-collected unless that other option is removed
as well?

         Arnd
