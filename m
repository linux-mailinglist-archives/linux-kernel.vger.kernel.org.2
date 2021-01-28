Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093893081F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 00:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhA1Xdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 18:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhA1Xbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:31:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5BA264DFC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611876662;
        bh=a/cMMnXPcsFfWRH4ryA6nFzHSiiHCZHsMnVY+j8TpNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XPW2F5CgDSmxwT+iNeeFzJG4ExgB3HxUxmFIueio5D1h3LU6xuRRjZoKjrpL2czMv
         nR6DQxXCzD3sMAX5HtdgCOxNiTx+1l5Lw8llD9oW7R2EQTdD+i4mlXo7fGAHNZ37ly
         wPHw/jhm0pwdJivwOAmGJS1SvaOBmCnB7m3zjWguvZUKCprItprd3F/FvNvJm8Dk7K
         l9D3Czn4BBNf2nctfdRho6AJoiFzsglkVK9ZYmJ6yfWq4H+SGu3benls/r+bliRgAU
         cu4adoCEMEOKYL7Wj/H2phXsxn48ooT+Wry66266ccKTh7NYprZYZqfj5tJJInduGP
         WgoN/tRxXz5SQ==
Received: by mail-ot1-f44.google.com with SMTP id f6so6934026ots.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 15:31:02 -0800 (PST)
X-Gm-Message-State: AOAM531P7UKzi2otP4XkM2f31NruCa4c3fe5XvHEbQhY/8/gzLNCxRCC
        e5z7kPwxe0SKy/Yvp6izVM1/VnAekGWKlmbbSq0=
X-Google-Smtp-Source: ABdhPJzMqChs1UsbWimh9zi6kegNqbnttrllJ6lkUF6YMJe6YOAehd+7J9gJL7tMQ92JiUY9FjGysoCfRjmLL3RoleU=
X-Received: by 2002:a05:6830:1158:: with SMTP id x24mr1209516otq.108.1611876661885;
 Thu, 28 Jan 2021 15:31:01 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
 <20210128193422.241155-1-ndesaulniers@google.com> <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
 <CAK8P3a0CTUh=4h=U6S5A_tqHxYEyO52HTropAV9mKh2hwJvi0g@mail.gmail.com>
In-Reply-To: <CAK8P3a0CTUh=4h=U6S5A_tqHxYEyO52HTropAV9mKh2hwJvi0g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 29 Jan 2021 00:30:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEx-mUCgX5F6xg8-6jKtpqQ=sRosmo4u-0jhW5zu9A-fw@mail.gmail.com>
Message-ID: <CAMj1kXEx-mUCgX5F6xg8-6jKtpqQ=sRosmo4u-0jhW5zu9A-fw@mail.gmail.com>
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

On Thu, 28 Jan 2021 at 23:28, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Jan 28, 2021 at 10:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 28 Jan 2021 at 20:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > @@ -468,15 +468,15 @@ void kprobe_thumb32_test_cases(void)
> > >
> > >         TEST_UNSUPPORTED("strexb        r0, r1, [r2]")
> > >         TEST_UNSUPPORTED("strexh        r0, r1, [r2]")
> > > -       TEST_UNSUPPORTED("strexd        r0, r1, [r2]")
> > > +       TEST_UNSUPPORTED("strexd        r0, r1, r2, [r2]")
> > >         TEST_UNSUPPORTED("ldrexb        r0, [r1]")
> > >         TEST_UNSUPPORTED("ldrexh        r0, [r1]")
> > > -       TEST_UNSUPPORTED("ldrexd        r0, [r1]")
> > > +       TEST_UNSUPPORTED("ldrexd        r0, r1, [r1]")
> > >
> > >         TEST_GROUP("Data-processing (shifted register) and (modified immediate)")
> > >
> > >  #define _DATA_PROCESSING32_DNM(op,s,val)                                       \
> > > -       TEST_RR(op s".w r0,  r",1, VAL1,", r",2, val, "")                       \
> > > +       TEST_RR(op s"   r0,  r",1, VAL1,", r",2, val, "")                       \
> >
> > What is wrong with these .w suffixes? Shouldn't the assembler accept
> > these even on instructions that only exist in a wide encoding?
>
> I don't know if that is a bug in the integrated assembler or
> intentional behavior, but it may be easier to just change the
> kernel than the compiler in this case, as it also makes it work
> for older versions.
>
> FWIW, I needed a related change in a couple of other files:
>

For fully specified test cases, I suppose removing the .w is fine. But
for the macros below, it really isn't: it depends on the actual
register assignment whether narrow encodings exist or not, and in that
case, we definitely want the wide one. The fact that instantiating the
macro in a different way can only produce wide encodings in the first
place should really not trigger an error.

Things like this can break the Thumb2 build very subtly, so if the
integrated assembler is not up to that, we should simply disable it
for Thumb2 builds.

> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 6acdfde56849..3ced01d9afe4 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -60,7 +60,7 @@
>  #define LDR1W_SHIFT 0
>
>   .macro ldr1w ptr reg abort
> - USERL(\abort, W(ldr) \reg, [\ptr], #4)
> + USERL(\abort, ldr \reg, [\ptr], #4)
>   .endm
>
>   .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
> @@ -80,7 +80,7 @@
>  #define STR1W_SHIFT 0
>
>   .macro str1w ptr reg abort
> - W(str) \reg, [\ptr], #4
> + str \reg, [\ptr], #4
>   .endm
>
>   .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> index 485fa3cffdbe..a6a96f814720 100644
> --- a/arch/arm/lib/copy_to_user.S
> +++ b/arch/arm/lib/copy_to_user.S
> @@ -34,7 +34,7 @@
>  #define LDR1W_SHIFT 0
>
>   .macro ldr1w ptr reg abort
> - W(ldr) \reg, [\ptr], #4
> + ldr \reg, [\ptr], #4
>   .endm
>
>   .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
> @@ -77,7 +77,7 @@
>  #define STR1W_SHIFT 0
>
>   .macro str1w ptr reg abort
> - USERL(\abort, W(str) \reg, [\ptr], #4)
> + USERL(\abort, str \reg, [\ptr], #4)
>   .endm
>
>   .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
> index e4caf48c089f..7b980a1a4227 100644
> --- a/arch/arm/lib/memcpy.S
> +++ b/arch/arm/lib/memcpy.S
> @@ -15,7 +15,7 @@
>  #define STR1W_SHIFT 0
>
>   .macro ldr1w ptr reg abort
> - W(ldr) \reg, [\ptr], #4
> + ldr \reg, [\ptr], #4
>   .endm
>
>   .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
> @@ -31,7 +31,7 @@
>   .endm
>
>   .macro str1w ptr reg abort
> - W(str) \reg, [\ptr], #4
> + str \reg, [\ptr], #4
>   .endm
>
>   .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
> diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
> index 6fecc12a1f51..35c5c06b7588 100644
> --- a/arch/arm/lib/memmove.S
> +++ b/arch/arm/lib/memmove.S
> @@ -84,24 +84,24 @@ WEAK(memmove)
>   addne pc, pc, ip @ C is always clear here
>   b 7f
>  6: W(nop)
> - W(ldr) r3, [r1, #-4]!
> - W(ldr) r4, [r1, #-4]!
> - W(ldr) r5, [r1, #-4]!
> - W(ldr) r6, [r1, #-4]!
> - W(ldr) r7, [r1, #-4]!
> - W(ldr) r8, [r1, #-4]!
> - W(ldr) lr, [r1, #-4]!
> + ldr r3, [r1, #-4]!
> + ldr r4, [r1, #-4]!
> + ldr r5, [r1, #-4]!
> + ldr r6, [r1, #-4]!
> + ldr r7, [r1, #-4]!
> + ldr r8, [r1, #-4]!
> + ldr lr, [r1, #-4]!
>
>   add pc, pc, ip
>   nop
>   W(nop)
> - W(str) r3, [r0, #-4]!
> - W(str) r4, [r0, #-4]!
> - W(str) r5, [r0, #-4]!
> - W(str) r6, [r0, #-4]!
> - W(str) r7, [r0, #-4]!
> - W(str) r8, [r0, #-4]!
> - W(str) lr, [r0, #-4]!
> + str r3, [r0, #-4]!
> + str r4, [r0, #-4]!
> + str r5, [r0, #-4]!
> + str r6, [r0, #-4]!
> + str r7, [r0, #-4]!
> + str r8, [r0, #-4]!
> + str lr, [r0, #-4]!
>
>   CALGN( bcs 2b )
