Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087863349CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhCJVZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhCJVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:24:46 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDEAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:24:46 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h18so17004289ils.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=x9/KVHsZmsTxm4DmBJPx7KZ95KUta5lJt2VQVkp5nXQ=;
        b=J4/FovK5/IFzdNwT6SDP+/56qzSzoZU8CGgsbbDExEStmADA5YhBfmx9a5ShnyP8H/
         Za59jSREIff9LUTkgxgcfk8b4oXG+3mi5kK5xNL2j5bDyGHTPAlcqYk4FiksRBLD4Yem
         UJjDLJsn1Qm+0abv+DWcBDDdcdo3/wnDqWJlf7foX+49GrBh+mh2/hivz3c6utdUSFJK
         JHBxT3fR+QCot2AiBnugMs/swZsKyAiHeEUoSSBzq2BogDSmibF8LBCaYpc5PHkOJSqM
         kl0xV2W1/fdQIz6/KWU5Nd+2QqlF7C2CiI95u9qy7nWEtZF4wt/yRDBQ3N7vdoRB24G+
         AveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=x9/KVHsZmsTxm4DmBJPx7KZ95KUta5lJt2VQVkp5nXQ=;
        b=sArCO2UzEpbQtjln+XRvAw9AWmb4XgAAQWuo7VVB1pSPVw0nJysO0NXg/F4TcH1PDq
         oR1lK3WFlCrL4fSRUjP2t4Ro2kRVLqKDS/l05mYdrJRbVI5lDRau2jTbVM1dUXGPj6MA
         QFYCvpdDe684vJjRCGKLtnveYFrqDWZWbaryW4c5lsS+Dw/3x2Akckjvr8/mrGx/0M4k
         HEMLxe9mjaFIDXzJUp4Bjq4Q6Vutt24tTR1rKPidANl7G2QdZK77rahtupjrUUVz/dC9
         PWhBVqaZrJcfRO6CklKD6cnOvi3AlP//sd4lBcvgRdJxH2gXn9nrilzS1cbKxOgolzrC
         iIwg==
X-Gm-Message-State: AOAM530JbkpP2OPnLhZax0QcK3VP4aaArwnbYE99z1/gGHXrGcoAuiVp
        DcdMQHzopG8z8DzrKQmU0mw8BjFZJH+jfIfFj0o=
X-Google-Smtp-Source: ABdhPJy633aCpve8a5kvlspgo54swQ+mQuOfSQDMRzcn9Ieihnos1FFhWVmMsGMT0QazyTbNUiIaCRH5xVe7vaLLVB8=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr4293277ilk.209.1615411484772;
 Wed, 10 Mar 2021 13:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com>
 <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
 <1614559739.p25z5x88wl.astroid@bobo.none> <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
 <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
In-Reply-To: <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Mar 2021 22:24:07 +0100
Message-ID: <CA+icZUWk-9i8BSf70qE_9f=mekscQ063q+aUKzSNBymNLAbcTA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
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

On Wed, Mar 10, 2021 at 10:08 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 9:50 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > On Mon, Mar 1, 2021 at 10:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
>
> >
> > masahiro@oscar:~/ref/linux$ echo  'void this_func_is_unused(void) {}'
> > >>  kernel/cpu.c
> > masahiro@oscar:~/ref/linux$ export
> > CROSS_COMPILE=/home/masahiro/tools/powerpc-10.1.0/bin/powerpc-linux-
> > masahiro@oscar:~/ref/linux$ make ARCH=powerpc  defconfig
> > masahiro@oscar:~/ref/linux$ ./scripts/config  -e EXPERT
> > masahiro@oscar:~/ref/linux$ ./scripts/config  -e LD_DEAD_CODE_DATA_ELIMINATION
> > masahiro@oscar:~/ref/linux$
> > ~/tools/powerpc-10.1.0/bin/powerpc-linux-nm -n  vmlinux | grep
> > this_func
> > c000000000170560 T .this_func_is_unused
> > c000000001d8d560 D this_func_is_unused
> > masahiro@oscar:~/ref/linux$ grep DEAD_CODE_ .config
> > CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
> >
> >
> > If I remember correctly,
> > LD_DEAD_CODE_DATA_ELIMINATION dropped unused functions
> > when I tried it last time.
> >
> >
> > I also tried arm64 with a HAVE_LD_DEAD_CODE_DATA_ELIMINATION hack.
> > The result was the same.
> >
> >
> >
> > Am I missing something?
>
> It's possible that it only works in combination with CLANG_LTO now
> because something broke. I definitely saw a reduction in kernel
> size when both options are enabled, but did not try a simple test
> case like you did.
>
> Maybe some other reference gets created that prevents the function
> from being garbage-collected unless that other option is removed
> as well?
>

The best results on size-reduction of vmlinux I got with Clang-CFI on x86-64.

Clang-LTO and Clang-CFI:
I was able to build with CONFIG_TRIM_UNUSED_KSYMS=y which needs to add
a whitelist file or add a whitelist to scripts/gen_autoksyms.sh.
And boot on bare metal.
Furthermore, I was able to compile
CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y with and without
CONFIG_TRIM_UNUSED_KSYMS=y.
Every kernel I had CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y does not boot.
Yes, there is a size reduction with both enabled but not that good as
with Clang-CFI.
All testings with several iterations of LLVM/Clang v13-git.
With CONFIG_TRIM_UNUSED_KSYMS=y I see a 3x-loops of building .version
and folowing steps - got no answer if this is intended.
Means longer build-time.
I did not follow this anymore as both Kconfigs with Clang-LTO consume
more build-time and the resulting vmlinux is some MiB bigger than with
Clang-CFI.

If someone is interested in x86-64 I can provide the whitelist files
and or (alternatively) changes to scripts/gen_autoksyms.sh.
AFAICS I had open a thread for this - damn digital dementia.

- Sedat -
