Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8242E304
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhJNVBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhJNVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:01:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05520C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 13:59:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so32481909lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fy57D187X48Fx9bxjnyOKm0PBOatPcD5XyLLGaScZCs=;
        b=Xv43Nnn8wKY7HqJ/aaTgZcLyLVXJTIgRqKiWGdpe/DtNHjAokUzkObHf/XPqjzbkwa
         tSAfHanBeDadiwCnOXbi7PnZ9yuFj3BODLOSTci05KvAy4RnxAhuqo8LUaS0w24Oe8KP
         Vq53ebcADealKHOaZWv90un+/ajhEjR2OeRvlqOzeEtj2pgoulBiTmUYTtrJLIQ+M+XL
         wMBM9H7X3WPquujBXNBFMNadJjiGW1KMqahcgiPQUCxxmjr/gObAlyrKUsF0NCRbQfFz
         uaos0Auyw4+iEWHiphp3uNGAT7jVWsVEfj0ebtH3hW/bP0mhONG6TU1purtxK4jm7Eqh
         410A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fy57D187X48Fx9bxjnyOKm0PBOatPcD5XyLLGaScZCs=;
        b=7et0k+nicNuc7y325zgKB4zCTWqCF5ulMptcz266t+3ksXPiclj6FcmG7zePvGM/Wk
         l/0SqYGB+uc6n72YrxG9I6KutFMIx5b3Y9vnaX2h7lx5HWLjwC4G8sDepC+Apsr8GktY
         gPyXBQOvz4FlzGHjVDOS457RerSWTS9Wh6tzv9cOWNpPZ8MRkFQ6HGEt6Jsg073tUsz8
         Dw88yp4NQnfqjvg27wmtC1yQBqEK6EwB9UND3k9IehOmmEOE3mWn1lWr+Vd8NVkhH1By
         fAwyc/9eu3YlqjpIAn5yZkc2TLSP0mEjGylvgTnDYVx1wvVssQ5uD2EMtWr43OXq8wgu
         qzMA==
X-Gm-Message-State: AOAM530LeC4GkfVHsSueoJAP/tS53TrqDermWdBzuH2mT9/r9fjcMsyO
        7E/CHlh3YgBKnwdE29PpzPrzMVXX+ue1Jiz4JrIFpQ==
X-Google-Smtp-Source: ABdhPJzzKGiBF1D64Hax8tX66VfFGq10IwE/nI6+rZ1cLuP1Kp6XAZTT3Qu5LOGcXX96mGsBoumqmODqrc3qKQLn4es=
X-Received: by 2002:a05:6512:3ba3:: with SMTP id g35mr7442920lfv.651.1634245164162;
 Thu, 14 Oct 2021 13:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211012234606.91717-1-ndesaulniers@google.com>
 <20211012234606.91717-3-ndesaulniers@google.com> <CAK7LNASGRQqL4Qu7ZVOcrW8-oXm7xvB-m7yoMJHnCDR5-_jrDQ@mail.gmail.com>
In-Reply-To: <CAK7LNASGRQqL4Qu7ZVOcrW8-oXm7xvB-m7yoMJHnCDR5-_jrDQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 13:59:12 -0700
Message-ID: <CAKwvOd=gDxwvBdtDrJmqo4yb2DoswHtcK6f2M+z4s-b1RK5DyQ@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 8:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Oct 13, 2021 at 8:46 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > When running the following command without arm-linux-gnueabi-gcc in
> > one's $PATH, the following warning is observed:
> >
> > $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 mrproper
> > make[1]: arm-linux-gnueabi-gcc: No such file or directory
> >
> > This is because KCONFIG is not run for mrproper, so CONFIG_CC_IS_CLANG
> > is not set, and we end up eagerly evaluating various variables that try
> > to invoke CC_COMPAT.
> >
> > This is a similar problem to what was observed in
> > commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux")
> >
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Reported-by: Lucas Henneman <henneman@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
>
> There are two ways to fix it:
>
>   [1]: sink the error message to /dev/null
>         (as in commit dc960bfeedb01cf832c5632ed1f3daed4416b142)
>   [2]: use a recursively-expanded variable as you did.
>
>
> "Simple variable (:=) vs recursive variable (=)" is a trade-off.
>
> Please be careful about the cost when you try the [2] approach.
>
>
>
> Simple variables are immediately expanded while parsing Makefile.
> There are 7 call-sites for cc32-option, hence
> the compiler is invoked 7 times for building vdso32,
> 0 times for cleaning.
> (Since 57fd251c789647552d32d2fc51bedd4f90d70f9f,
> try-run is no-op for 'make clean').
>
>
>
>
> Recursive variables are expanded every time they are used.
>
> IIUC, if_changed expands the command line 3 times.
> There are 2 objects (note.o and vgettimeofday.o)
> There are 7 call-sites for cc32-option.
>
> So, the compiler is invoked 42 (3 * 2 * 7) times
> for building vdso32.

With this patch applied:
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
clean defconfig
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
clang | wc -l
55
$ find arch/arm64/kernel/vdso32/ -name \*.o | xargs rm
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
clang | wc -l
2

Prior to this series:
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
clean defconfig
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
clang | wc -l
55
$ find arch/arm64/kernel/vdso32/ -name \*.o | xargs rm
$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72
arch/arm64/kernel/vdso32/ V=1 | tr -s ' ' | cut -d ' ' -f 2 | grep
clang | wc -l
2

With patch 3 applied, we can drop CROSS_COMPILE_COMPAT, and we now get:
$ ARCH=arm64 make LLVM=1 -j72 clean defconfig
ARCH=arm64 make LLVM=1 -j72 arch/arm64/kernel/vdso32/ V=1 | tr -s ' '
| cut -d ' ' -f 2 | grep clang | wc -l
44
$ find arch/arm64/kernel/vdso32/ -name \*.o | xargs rm
$ ARCH=arm64 make LLVM=1 -j72 arch/arm64/kernel/vdso32/ V=1 | tr -s '
' | cut -d ' ' -f 2 | grep clang | wc -l
2

Please confirm; perhaps my pipeline missed some invocations? Or was
there a different target you were referring to?

--
Thanks,
~Nick Desaulniers
