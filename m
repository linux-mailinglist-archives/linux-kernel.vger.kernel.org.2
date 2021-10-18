Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69443287F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhJRUg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRUg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:36:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE1C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:34:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o26so1990770ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmZE9aF4Ee2V9RKx7L1BSLdmyNjcvmYBt17tD4vGRiQ=;
        b=fW/4xiFTZMVJcLXLME4J2ssqGuKqgTsuct3PZ1LjKrR/EaUnJjUrsKBG0UZoip93Sw
         8oH4wS9BAjsT/sBQDXuWEt1vD36eO3cqd5rEY3zOFrh0ICjEya9BXpqqR4jTLkXzV8s9
         kiDDTlh9ab3rNYrHnpvZxxYPpPoS4Tgp3ejkzUqN7hkdOSJC2O2uEgG6zKcVfkuGWCqW
         DTpgKB82oYu2s6YMSN5OJnIXPY0lkIJyNGL9FYc2kdwHoOND8DBdcyuyGC8Mp5Nh2zwF
         R4F+pN2AONWm6RwzeHEFP9nJhPaGbZVhdmFsdsdphAyxihqC+BQoB5/c8485tCVb7Io4
         ElCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmZE9aF4Ee2V9RKx7L1BSLdmyNjcvmYBt17tD4vGRiQ=;
        b=3wQQcPeqeppqEcgSeSkHU9wBhBr4xTT0OkIWOtsC6xJEmkAZJbdRlJhbj+ey4F5Gkr
         TX+BK8k88b3vEbyjhQ9RuVq5ERzN87L7nEquklwlcNe8RhQkwaNsE0PVJFIq8MUu67X0
         UnG7DPpbXE+OrVMuO+Y9qP6W91bEMICpe9j0xP2AulEgr+It7xHyyLPpR9g3NjNCJuK5
         gEPBm3uuO8puSq3cLeqvEU59kr0pTnxTttnd84KZDTHL3VUHHkamJOv7wmGxBsDkKT9w
         Tj8yCoyXv8KMXC0Mu77JfrJTWB9UcaMsLDTPCjADZWAANWgXuaV9xwboM0Mn0FxfJfY3
         AXIw==
X-Gm-Message-State: AOAM530mLht5ft/oXY90JRlLOns1uxKaeWqkOIo3l+84zjaDOBaCVkIg
        RqEZZYDxaM+jAxQb88hgLTgTFL3/zv6WJSlzAWdu9g==
X-Google-Smtp-Source: ABdhPJzGxoYb5C5LikKfBwzZ0PFeu0xlG+ZDDqi5/MVPAZGL4zV1l9n6lniwRP+2Vi1GwewWVa6Y/SHkzJsgOXO59TM=
X-Received: by 2002:a2e:750e:: with SMTP id q14mr2124757ljc.338.1634589282793;
 Mon, 18 Oct 2021 13:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211012234606.91717-1-ndesaulniers@google.com>
 <20211012234606.91717-3-ndesaulniers@google.com> <CAK7LNASGRQqL4Qu7ZVOcrW8-oXm7xvB-m7yoMJHnCDR5-_jrDQ@mail.gmail.com>
 <CAKwvOd=gDxwvBdtDrJmqo4yb2DoswHtcK6f2M+z4s-b1RK5DyQ@mail.gmail.com> <CAK7LNASwuz_i7hzNzmT8JVQTMbwt3JARSqh4PB_URcEfzzOq3g@mail.gmail.com>
In-Reply-To: <CAK7LNASwuz_i7hzNzmT8JVQTMbwt3JARSqh4PB_URcEfzzOq3g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Oct 2021 13:34:31 -0700
Message-ID: <CAKwvOdmmOuNW4u_iuh6DSVo4gfyXeZMF8Z=i6yFPJ3wOUZMLvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: vdso32: lazily invoke COMPAT_CC
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Lucas Henneman <henneman@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 7:20 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Oct 15, 2021 at 5:59 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 8:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Wed, Oct 13, 2021 at 8:46 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > When running the following command without arm-linux-gnueabi-gcc in
> > > > one's $PATH, the following warning is observed:
> > > >
> > > > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 mrproper
> > > > make[1]: arm-linux-gnueabi-gcc: No such file or directory
> > > >
> > > > This is because KCONFIG is not run for mrproper, so CONFIG_CC_IS_CLANG
> > > > is not set, and we end up eagerly evaluating various variables that try
> > > > to invoke CC_COMPAT.
> > > >
> > > > This is a similar problem to what was observed in
> > > > commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux")
> > > >
> > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > Reported-by: Lucas Henneman <henneman@google.com>
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > >
> > > There are two ways to fix it:
> > >
> > >   [1]: sink the error message to /dev/null
> > >         (as in commit dc960bfeedb01cf832c5632ed1f3daed4416b142)
> > >   [2]: use a recursively-expanded variable as you did.
> > >
> > >
> > > "Simple variable (:=) vs recursive variable (=)" is a trade-off.
> > >
> > > Please be careful about the cost when you try the [2] approach.
> > >
> > >
> > >
> > > Simple variables are immediately expanded while parsing Makefile.
> > > There are 7 call-sites for cc32-option, hence
> > > the compiler is invoked 7 times for building vdso32,
> > > 0 times for cleaning.
> > > (Since 57fd251c789647552d32d2fc51bedd4f90d70f9f,
> > > try-run is no-op for 'make clean').
> > >
> > >
> > >
> > >
> > > Recursive variables are expanded every time they are used.
> > >
> > > IIUC, if_changed expands the command line 3 times.
> > > There are 2 objects (note.o and vgettimeofday.o)
> > > There are 7 call-sites for cc32-option.
> > >
> > > So, the compiler is invoked 42 (3 * 2 * 7) times
> > > for building vdso32.
> >
> > With this patch applied:
> > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
> > clean defconfig
> > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
> > arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
> > clang | wc -l
> > 55
> > $ find arch/arm64/kernel/vdso32/ -name \*.o | xargs rm
> > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
> > arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
> > clang | wc -l
> > 2
> >
> > Prior to this series:
> > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
> > clean defconfig
> > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
> > arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
> > clang | wc -l
> > 55
> > $ find arch/arm64/kernel/vdso32/ -name \*.o | xargs rm
> > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
> > arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
> > clang | wc -l
> > 2
> >
> > With patch 3 applied, we can drop CROSS_COMPILE_COMPAT, and we now get:
> > $ ARCH=arm64 make LLVM=1 -j72 clean defconfig
> > ARCH=arm64 make LLVM=1 -j72 arch/arm64/kernel/vdso32/ V=1 | tr -s ' '
> > | cut -d ' ' -f 2 | grep clang | wc -l
> > 44
> > $ find arch/arm64/kernel/vdso32/ -name \*.o | xargs rm
> > $ ARCH=arm64 make LLVM=1 -j72 arch/arm64/kernel/vdso32/ V=1 | tr -s '
> > ' | cut -d ' ' -f 2 | grep clang | wc -l
> > 2
> >
> > Please confirm; perhaps my pipeline missed some invocations? Or was
> > there a different target you were referring to?
>
>
>
>
>
>
> It is pointless to check the build commands.
>
> I am talking about how many times $(call cc32-option, ) is evaluated.

Of course V=1 doesn't print the cc-option invocations! /s

>
>
> How about adding the following debug code?
>
> (Everytime cc32-option is evaluated, a file "dummy-cc32-option-<PID>"
> is created)
>
>
>
> diff --git a/arch/arm64/kernel/vdso32/Makefile
> b/arch/arm64/kernel/vdso32/Makefile
> index 89299a26638b..e40365f5bc38 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -26,9 +26,9 @@ LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)ld
>  endif
>
>  cc32-option = $(call try-run,\
> -        $(CC_COMPAT) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
> +        $(CC_COMPAT) $(1) -c -x c /dev/null -o "$$TMP"; touch
> dummy-cc32-option-$$$$,$(1),$(2))
>  cc32-disable-warning = $(call try-run,\
> -       $(CC_COMPAT) -W$(strip $(1)) -c -x c /dev/null -o
> "$$TMP",-Wno-$(strip $(1)))
> +       $(CC_COMPAT) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP";
> touch dummy-cc32-option-$$$$,-Wno-$(strip $(1)))

heh, I usually add `($info $$VAR is [${VAR}]); \` debugging statements
to these. Touching files is another neat trick.

>
>  # We cannot use the global flags to compile the vDSO files, the main reason
>  # being that the 32-bit compiler may be older than the main (64-bit) compiler
>
>
>
>
>
> Without this patch:
>
> masahiro@grover:~/ref/linux$ rm dummy-cc32-*
> masahiro@grover:~/ref/linux$ make -s LLVM=1 ARCH=arm64
> CROSS_COMPILE_COMPAT=arm-linux-gnueabi- defconfig clean
> arch/arm64/kernel/vdso32/ -j8
> masahiro@grover:~/ref/linux$ ls -1 dummy-cc32-*
> dummy-cc32-disable-warning-765530
> dummy-cc32-option-765495
> dummy-cc32-option-765500
> dummy-cc32-option-765505
> dummy-cc32-option-765510
> dummy-cc32-option-765515
> dummy-cc32-option-765520
> dummy-cc32-option-765525
>
>
>
>
> With this patch:
>
>
>
> masahiro@grover:~/ref/linux$ rm dummy-cc32-*
> masahiro@grover:~/ref/linux$ make -s LLVM=1 ARCH=arm64
> CROSS_COMPILE_COMPAT=arm-linux-gnueabi- defconfig clean
> arch/arm64/kernel/vdso32/ -j8
> masahiro@grover:~/ref/linux$ ls -1 dummy-cc32-*
> dummy-cc32-disable-warning-768908
> dummy-cc32-disable-warning-768949
> dummy-cc32-disable-warning-768990
> dummy-cc32-disable-warning-769035
> dummy-cc32-disable-warning-769076
> dummy-cc32-disable-warning-769117
> dummy-cc32-option-768871
> dummy-cc32-option-768878
> dummy-cc32-option-768883
> dummy-cc32-option-768888
> dummy-cc32-option-768893
> dummy-cc32-option-768898
> dummy-cc32-option-768903
> dummy-cc32-option-768914
> dummy-cc32-option-768919
> dummy-cc32-option-768924
> dummy-cc32-option-768929
> dummy-cc32-option-768934
> dummy-cc32-option-768939
> dummy-cc32-option-768944
> dummy-cc32-option-768955
> dummy-cc32-option-768960
> dummy-cc32-option-768965
> dummy-cc32-option-768970
> dummy-cc32-option-768975
> dummy-cc32-option-768980
> dummy-cc32-option-768985
> dummy-cc32-option-768998
> dummy-cc32-option-769005
> dummy-cc32-option-769010
> dummy-cc32-option-769015
> dummy-cc32-option-769020
> dummy-cc32-option-769025
> dummy-cc32-option-769030
> dummy-cc32-option-769041
> dummy-cc32-option-769046
> dummy-cc32-option-769051
> dummy-cc32-option-769056
> dummy-cc32-option-769061
> dummy-cc32-option-769066
> dummy-cc32-option-769071
> dummy-cc32-option-769082
> dummy-cc32-option-769087
> dummy-cc32-option-769092
> dummy-cc32-option-769097
> dummy-cc32-option-769102
> dummy-cc32-option-769107
> dummy-cc32-option-769112
>
>
>
>
>
>
> The diff of  the number of expansions:
>
> cc32-option                        7    ->   42
> cc32-disable-warning         1   ->    6

Indeed, thanks for confirming.  An unfortunate dichotomy.  Surely
there's another way to avoid cc-option+cc-disable-warning calls for
the `clean` target?  I'll change to just redirecting errors to
/dev/null with your Suggested-by tag, but this seems a bit of an
unfortunate situation.
-- 
Thanks,
~Nick Desaulniers
