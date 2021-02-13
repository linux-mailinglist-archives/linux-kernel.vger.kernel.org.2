Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9586A31AAF5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 12:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhBMLCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 06:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhBMLCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 06:02:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F41FC64E44
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 11:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613214083;
        bh=G71u7RTd4A+rBB1I9GNDIIEuu107tc6tTr/aifGEocg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GxERvQ0VZIYnBHwi/rOGp9DB578dL+KH+k7p8P662CGeWvdboRzfuzLuCr5sfmEgv
         kWmT5MswkYSl2Ws4Xctgd6mpy4+2ilQmFBOa/qXQc0Rl2CSLsZ/Fccvyp5/Uu1+rj/
         3rFHXqglXncFU7yoMyYc2JGJvuiWjwIT19EuRqCkFUyxmlvLTdgIBUZg7VWIMLPefh
         VitmMS4egfS7kwjcsF4QMuMoxuMv9NeLnnwQMQlIqBDQyhnczuu/z/oKzFj+kT1n7/
         KqzCF1E4Wir/qJY2512e6WhkcrgPJLew/1xm+YnimDrPJbfAMwH9RDIkbzOZqhq52l
         yzv3X8rb4uo1g==
Received: by mail-ot1-f49.google.com with SMTP id y11so1720957otq.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:01:22 -0800 (PST)
X-Gm-Message-State: AOAM5317hk0LW2Uwe/gHstOtleq6CgRvDB8WkRRcOzoakBm+0xxGNTFZ
        0ilLqVeXsNN+/QthyqNKc2A2aKt4i2Zd/sLCnU8=
X-Google-Smtp-Source: ABdhPJwbPg/JYsOrKxV0akZHoER+jZQufik0pH+YRE9RS6ub2wS5g0Dx/2q5znjGky9VctmOud4xL7YUR21sYDAMGVU=
X-Received: by 2002:a05:6830:13ce:: with SMTP id e14mr4959394otq.108.1613214082190;
 Sat, 13 Feb 2021 03:01:22 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
 <20210128193422.241155-1-ndesaulniers@google.com> <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
 <CAK8P3a0CTUh=4h=U6S5A_tqHxYEyO52HTropAV9mKh2hwJvi0g@mail.gmail.com> <CAMj1kXEx-mUCgX5F6xg8-6jKtpqQ=sRosmo4u-0jhW5zu9A-fw@mail.gmail.com>
In-Reply-To: <CAMj1kXEx-mUCgX5F6xg8-6jKtpqQ=sRosmo4u-0jhW5zu9A-fw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 13 Feb 2021 12:01:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3Xiveq_ih=5yD5CUdG8r=FXGTdN+qT0Rpgsx_8qi7Hg@mail.gmail.com>
Message-ID: <CAMj1kXF3Xiveq_ih=5yD5CUdG8r=FXGTdN+qT0Rpgsx_8qi7Hg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: rewrite test-[arm|thumb].c in UAL
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 at 00:30, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 28 Jan 2021 at 23:28, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Thu, Jan 28, 2021 at 10:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Thu, 28 Jan 2021 at 20:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > @@ -468,15 +468,15 @@ void kprobe_thumb32_test_cases(void)
> > > >
> > > >         TEST_UNSUPPORTED("strexb        r0, r1, [r2]")
> > > >         TEST_UNSUPPORTED("strexh        r0, r1, [r2]")
> > > > -       TEST_UNSUPPORTED("strexd        r0, r1, [r2]")
> > > > +       TEST_UNSUPPORTED("strexd        r0, r1, r2, [r2]")
> > > >         TEST_UNSUPPORTED("ldrexb        r0, [r1]")
> > > >         TEST_UNSUPPORTED("ldrexh        r0, [r1]")
> > > > -       TEST_UNSUPPORTED("ldrexd        r0, [r1]")
> > > > +       TEST_UNSUPPORTED("ldrexd        r0, r1, [r1]")
> > > >
> > > >         TEST_GROUP("Data-processing (shifted register) and (modified immediate)")
> > > >
> > > >  #define _DATA_PROCESSING32_DNM(op,s,val)                                       \
> > > > -       TEST_RR(op s".w r0,  r",1, VAL1,", r",2, val, "")                       \
> > > > +       TEST_RR(op s"   r0,  r",1, VAL1,", r",2, val, "")                       \
> > >
> > > What is wrong with these .w suffixes? Shouldn't the assembler accept
> > > these even on instructions that only exist in a wide encoding?
> >
> > I don't know if that is a bug in the integrated assembler or
> > intentional behavior, but it may be easier to just change the
> > kernel than the compiler in this case, as it also makes it work
> > for older versions.
> >
> > FWIW, I needed a related change in a couple of other files:
> >
>
> For fully specified test cases, I suppose removing the .w is fine. But
> for the macros below, it really isn't: it depends on the actual
> register assignment whether narrow encodings exist or not, and in that
> case, we definitely want the wide one. The fact that instantiating the
> macro in a different way can only produce wide encodings in the first
> place should really not trigger an error.
>
> Things like this can break the Thumb2 build very subtly, so if the
> integrated assembler is not up to that, we should simply disable it
> for Thumb2 builds.
>

As mentioned in issue #1271, my observation here is not entirely accurate.

In the general case, macros that take register names as inputs can
produce narrow or wide opcodes depending on which exact registers are
being used (narrow opcodes mostly only support registers r0-r7)

However, in this particular case, all the ldr/str instructions are
either the pre-indexed or the post-indexed variants, for which only a
wide encoding exists, and so omitting the .w suffix is safe here.

However, if we apply the change below, can we please document this in
a comment, i.e., that encoding T4 is used for LDR/STR, and so the
result is guaranteed to be wide in spite of the missing suffix?



> > diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> > index 6acdfde56849..3ced01d9afe4 100644
> > --- a/arch/arm/lib/copy_from_user.S
> > +++ b/arch/arm/lib/copy_from_user.S
> > @@ -60,7 +60,7 @@
> >  #define LDR1W_SHIFT 0
> >
> >   .macro ldr1w ptr reg abort
> > - USERL(\abort, W(ldr) \reg, [\ptr], #4)
> > + USERL(\abort, ldr \reg, [\ptr], #4)
> >   .endm
> >
> >   .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
> > @@ -80,7 +80,7 @@
> >  #define STR1W_SHIFT 0
> >
> >   .macro str1w ptr reg abort
> > - W(str) \reg, [\ptr], #4
> > + str \reg, [\ptr], #4
> >   .endm
> >
> >   .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> > diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> > index 485fa3cffdbe..a6a96f814720 100644
> > --- a/arch/arm/lib/copy_to_user.S
> > +++ b/arch/arm/lib/copy_to_user.S
> > @@ -34,7 +34,7 @@
> >  #define LDR1W_SHIFT 0
> >
> >   .macro ldr1w ptr reg abort
> > - W(ldr) \reg, [\ptr], #4
> > + ldr \reg, [\ptr], #4
> >   .endm
> >
> >   .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
> > @@ -77,7 +77,7 @@
> >  #define STR1W_SHIFT 0
> >
> >   .macro str1w ptr reg abort
> > - USERL(\abort, W(str) \reg, [\ptr], #4)
> > + USERL(\abort, str \reg, [\ptr], #4)
> >   .endm
> >
> >   .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> > diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
> > index e4caf48c089f..7b980a1a4227 100644
> > --- a/arch/arm/lib/memcpy.S
> > +++ b/arch/arm/lib/memcpy.S
> > @@ -15,7 +15,7 @@
> >  #define STR1W_SHIFT 0
> >
> >   .macro ldr1w ptr reg abort
> > - W(ldr) \reg, [\ptr], #4
> > + ldr \reg, [\ptr], #4
> >   .endm
> >
> >   .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
> > @@ -31,7 +31,7 @@
> >   .endm
> >
> >   .macro str1w ptr reg abort
> > - W(str) \reg, [\ptr], #4
> > + str \reg, [\ptr], #4
> >   .endm
> >
> >   .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> > diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
> > index 6fecc12a1f51..35c5c06b7588 100644
> > --- a/arch/arm/lib/memmove.S
> > +++ b/arch/arm/lib/memmove.S
> > @@ -84,24 +84,24 @@ WEAK(memmove)
> >   addne pc, pc, ip @ C is always clear here
> >   b 7f
> >  6: W(nop)
> > - W(ldr) r3, [r1, #-4]!
> > - W(ldr) r4, [r1, #-4]!
> > - W(ldr) r5, [r1, #-4]!
> > - W(ldr) r6, [r1, #-4]!
> > - W(ldr) r7, [r1, #-4]!
> > - W(ldr) r8, [r1, #-4]!
> > - W(ldr) lr, [r1, #-4]!
> > + ldr r3, [r1, #-4]!
> > + ldr r4, [r1, #-4]!
> > + ldr r5, [r1, #-4]!
> > + ldr r6, [r1, #-4]!
> > + ldr r7, [r1, #-4]!
> > + ldr r8, [r1, #-4]!
> > + ldr lr, [r1, #-4]!
> >
> >   add pc, pc, ip
> >   nop
> >   W(nop)
> > - W(str) r3, [r0, #-4]!
> > - W(str) r4, [r0, #-4]!
> > - W(str) r5, [r0, #-4]!
> > - W(str) r6, [r0, #-4]!
> > - W(str) r7, [r0, #-4]!
> > - W(str) r8, [r0, #-4]!
> > - W(str) lr, [r0, #-4]!
> > + str r3, [r0, #-4]!
> > + str r4, [r0, #-4]!
> > + str r5, [r0, #-4]!
> > + str r6, [r0, #-4]!
> > + str r7, [r0, #-4]!
> > + str r8, [r0, #-4]!
> > + str lr, [r0, #-4]!
> >
> >   CALGN( bcs 2b )
