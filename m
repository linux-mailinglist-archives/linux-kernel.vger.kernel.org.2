Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08433260D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhBZKEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhBZKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:03:30 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAFAC061797
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:02:13 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 81so5395159iou.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OZXwVNbXZV4lI1LIGmmW/Kxp49zjuh7sF9Qwivelrog=;
        b=QF5cz/JCOKoT06JtuRjEOFMjfXPFxO2+qcBXMI5ZC8+BlRHmWqhWeLKo5KrAN3LcLh
         MIV8llWK9RXONkhFUTuvTytreTu+uC2jxadh+NVAubP2rpZGBe1ZrkBSVLG0fugh0XqO
         vuB8N5TM3AecFjyqUAEQ55gn8OlodB9K1tKnhiBVYKHP9q81v0GbKlNspKUdcUVC5bEe
         ZQXfIcurYStCR48ZCTsBKfAVkK/VpEvpKuINApyjHD2ritz2WRS0ExaxW1CsjUyQQFSg
         /4iy/RrAB9oKVsynBM0BOSfMO2ai3R2AtVeoVsV5EZn0NY4DCpWp/Cem/0BtPaaAv+tp
         BWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OZXwVNbXZV4lI1LIGmmW/Kxp49zjuh7sF9Qwivelrog=;
        b=iCtaMCm30vPvYespHekxzlydkpedMoKmt6Bw+8HneLGrA03Vq+0FgVet2XL1yVxXtm
         IAx5Glzoj24aWGYp8KJMM4ZoF6ZklExltSh+kaEizxkGsXWAe5sdsCH0K0zoKrYApBXa
         1xXAsTHtCoruMFfw5aQOuN89+GeBfBWLmFVc/zWgwx2SU4L0/ENzdlnpEIXSVJgN/iZG
         ctdtnyxOJ4tblulRGsVv91W+ok9KK6aAe81qhAqq24gT/StUb/H8eFC8IYLMHPS1Ekom
         4ezmPSoCSs8Xtms0Z5QtZ2kW6lb/tEkzwxcld7oQmfYXPZYrj2h+quh+Amm5Gw6Rt7yE
         cG9A==
X-Gm-Message-State: AOAM5325smPM7Z/VmfDAQFfEGLF5ESeVe3d20Ry0c9QhH6dHHY2PoPiG
        UbYwEqvuTVQdZBRWligJ3YSFhpFn2FE/qTiyhZ4=
X-Google-Smtp-Source: ABdhPJzAiTMpa8HnPMwu8kOSlaF1npXrnm+zwFs4ky75CzlildU3IircUIlwv58E+G3wHMSg02zdAzwjIhOHaGrstVM=
X-Received: by 2002:a5d:9c4e:: with SMTP id 14mr2066351iof.57.1614333733229;
 Fri, 26 Feb 2021 02:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <CA+icZUUDnKBxkfgOVYDdpA29GnLUTT22mqRNyxQeYmay044ejg@mail.gmail.com>
 <CAK8P3a1QmS6g3cHTR93wWPkKs8vaP6RJEb8nZbTMLX+xphLJRw@mail.gmail.com>
 <CA+icZUW9Hzm_ZZtLiJu8pVeOmYJMOaXkV4Om_u4yZKYRVWNddA@mail.gmail.com> <CAK8P3a0cyAYqdPg_OoaVVY2Gjn=vtwAyfsVPjZ5qYddiOOc-eA@mail.gmail.com>
In-Reply-To: <CAK8P3a0cyAYqdPg_OoaVVY2Gjn=vtwAyfsVPjZ5qYddiOOc-eA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 26 Feb 2021 11:02:01 +0100
Message-ID: <CA+icZUWYR0MWRmzV+6rLKzUQUS8WRjF521iNVXk4w2fJk=NVJQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:51 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Feb 26, 2021 at 10:05 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > On Fri, Feb 26, 2021 at 9:14 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > > > BTW, is CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y setable for x86 (64bit)?
> > > > ( Did not look or check for it. )
> > >
> > > No, in mainline, HAVE_LD_DEAD_CODE_DATA_ELIMINATION is currently
> > > only selected on MIPS and PowerPC. I only sent experimental patches to
> > > enable it on arm64 and m68k, but have not tried booting them. If you
> > > select the symbol on x86, you should see similar results.
> > >
> >
> > OK, i see:
> >
> > $ git grep HAVE_LD_DEAD_CODE_DATA_ELIMINATION arch/mips/
> > arch/mips/Kconfig:      select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >
> > $ git grep HAVE_LD_DEAD_CODE_DATA_ELIMINATION arch/powerpc/
> > arch/powerpc/Kconfig:   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >
> > So, I need to add this to arch/x86/Kconfig.
> >
> > You happen to know if changes to arch/x86/kernel/vmlinux.lds.S
> > (sections) are needed?
>
> No idea. I'm still debugging a possible regression on arm64, but both
> issues I found for arm64 are specific to that architecture and won't
> happen on x86. It's likely that something else breaks though.
>

My first experiences with gc were with the freetz project (mips
embedded router) and don't ask me what GCC version.

I will try with gc + trim + cfi later after my current build has finished.

> > Last question:
> > The last days I see a lot of fixes touching inlining with LLVM/Clang v13-git.
> > What git tag are you using?
> > What are your experiences?
> > Pending patches (kernel-side)?
> >
> > I use:
> > $ /opt/llvm-toolchain/bin/clang --version
> > dileks clang version 13.0.0 (https://github.com/llvm/llvm-project.git
> > c465429f286f50e52a8d2b3b39f38344f3381cce)
>
> This is what I have on the build box:
> Ubuntu clang version
> 13.0.0-++20210223104451+ebca13c66504-1~exp1~20210223095200.234
>

Distro-clang takes much longer here.
Selfmade stage1-only LLVM toolchain compiles here 10% faster.
cfi takes approx. 20% longer.
With trim + gc I suppose it will take much longer.

Let me test.
Will report later.

- Sedat -
