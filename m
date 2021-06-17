Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E993AA8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhFQBu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:50:56 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:42424 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhFQBuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:50:54 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 15H1mVE0008979;
        Thu, 17 Jun 2021 10:48:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 15H1mVE0008979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1623894512;
        bh=zTKiASp84iI2TEThlgNhK02xs63oG3qRksk+2dZv5WI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J3S0fh0TShrVdZRj98A94DuZvhwS+xeEq9laFGxelZozhVQLOWH+hnC4bTFUrhAXq
         t2br1u8awFlj1efXWZsoZ3K8zGT/jrmpSaHvBfGpsCRUTk1Lc+QIW+m1P6UDk/5V3Z
         5BhjVsvKs5STkQ+xbMaaF46V2Mz3D7UoRh2iOeuxRPgMMrqLEmUBCgobc7DJ/pUb68
         ceYmMLAnjEQ6LlxGNaV8qf6rOJjOjn2iapgltOEmi0VIwV5svo1b/0L9eXk/GsVway
         IjmUiCTsI6v8hjp1KWiChcRi0w2mXen/cMZa1Qwbh+PkwGaEBGYjPpp/a8cXch59SB
         SXoST7HANrvPA==
X-Nifty-SrcIP: [209.85.215.182]
Received: by mail-pg1-f182.google.com with SMTP id g22so3626735pgk.1;
        Wed, 16 Jun 2021 18:48:31 -0700 (PDT)
X-Gm-Message-State: AOAM532qZSKN9LFKunXDsUQPB/ZQkoQPnq6dsF7rBwVNsw9ZaP6cyhDg
        eC0vs9+Sv72ZBK8pvnvbzuneOzD3Wyv+L57+1cY=
X-Google-Smtp-Source: ABdhPJznevqLCd9tdnsC5ZEPkZ9HCVbq/7Tgq1jV/Vzu2I2iijtQS79wWNSU63FwDDZwgezjAwTddXQ2RmUllNl51GY=
X-Received: by 2002:a63:36c1:: with SMTP id d184mr2581388pga.47.1623894511019;
 Wed, 16 Jun 2021 18:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de> <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
In-Reply-To: <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Jun 2021 10:47:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
Message-ID: <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
Subject: Re: linux-parisc compile failure in current git
To:     Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 4:04 PM Helge Deller <deller@gmx.de> wrote:
>
> Hi Masahiro,
>
> On 6/10/21 4:03 AM, Masahiro Yamada wrote:
> > On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
> >>
> >> On 6/1/21 12:21 PM, Meelis Roos wrote:
> >>> Upstream Linux git fails to compile on gentoo hppa -  .config below.
> >>> I have 2 gcc-s as always:
> >>> $ gcc-config -l
> >>>    [1] hppa2.0-unknown-linux-gnu-9.3.0
> >>>    [2] hppa2.0-unknown-linux-gnu-10.2.0 *
> >>>
> >>>    [3] hppa64-unknown-linux-gnu-10.2.0 *
> >>
> >>
> >> I see the same issue too, but only when compiling natively on a parisc machine.
> >> Cross-compiling on a x86 box works nicely.
> >>
> >> First I thought it's a problem with setting the "cross_compiling" flag in ./Makefile.
> >> But that's not sufficient.
> >>
> >> On a x86 machine (which builds fine) I get
> >> SRCARCH=parisc SUBARCH=x86 UTS_MACHINE=parisc
> >> The arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
> >> hppa64-linux-gnu-gcc
> >>
> >> On a native 32bit parisc machine I have:
> >> SRCARCH=parisc SUBARCH=parisc UTS_MACHINE=parisc
> >> Here the arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
> >> gcc
> >> Instead here the native hppa64-linux-gnu-gcc (cross compiler) should have been used too, since
> >> we build a 64-bit hppa kernel (CONFIG_64BIT is set).
> >> Note, on hppa we don't have an "-m64" compiler flag as on x86.
> >
> > I see.
> > hppa is not a bi-arch compiler, in other words,
> > http- and hppa64- are separate compilers.
>
> Yes.
>
> >> Mashahiro, do you maybe have an idea what gets wrong here, or which
> >> patch has changed the behaviour how the asm-offsets.c file gets preprocessed?
> >
> > Presumably, commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
> >
> > Prior to that commit, arch/parisc/Makefile was like this:
> >
> > ifneq ($(SUBARCH),$(UTS_MACHINE))
> >          ifeq ($(CROSS_COMPILE),)
> >                      ...
> >
> > Now I understand why arch/parisc/Makefile was written this way.
> >
> > Reverting the change in arch/parisc/Makefile will restore the original behavior.
>
> Sadly, reverting this change (23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3) does not
> restore the original behavior.
>
> > But, please keep in mind that there is an issue remaining.
> >
> > Please see this code:
> >
> > ifdef CONFIG_64BIT
> > UTS_MACHINE := parisc64
> > CHECKFLAGS += -D__LP64__=1
> > CC_ARCHES = hppa64
> > LD_BFD := elf64-hppa-linux
> > else # 32-bit
> > CC_ARCHES = hppa hppa2.0 hppa1.1
> > LD_BFD := elf32-hppa-linux
> > endif
> >
> >
> > UTS_MACHINE is determined by CONFIG_64BIT.
> >
> > CONFIG_64BIT is defined only after Kconfig is finished.
> > When you are trying to configure the .config,
> > CONFIG_64BIT is not defined yet.
> > So UTS_MACHINE is always 'parisc'.
>
> Yes.
> See above, but it worked when I had SUBARCH=x86 (when running my laptop).
>
>
> > As you know, Kconfig files now have a bunch of 'cc-option' syntax
> > to check the compiler capability in Kconfig time.
> > Hence, you need to provide a proper compiler in Kconfig time too.
> >
> > When you build a 64-bit parisc kernel on a 32-bit parisc machine,
>
> Please note, that we don't have a 64-bit parisc userspace yet (just kernel).
> This means, that all builds on parisc machines are 32bit and do a
> cross-compilation to a parisc64 kernel if requested in the .config.
>
> > Kconfig is passed with CC=gcc since SUBARCH==UTS_MACHINE==parisc.
> > After Kconfig, CROSS_COMPILE=hppa64-* is set,
> > and the kernel is built by CC=hppa64-*-gcc.
>
> Right. That is the old behaviour. Based on the CONFIG_64BIT option
> the hppa64 compiler is choosen for CROSS_COMPILE.
>
> > So, Kconfig evaluated a compiletely different compiler. This is pointless.
>
> Yes, probably.
>
>
> > There are some options
> >
> > [option 1]
> >    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
> >    This will restore the functionality you may want, but
> >    as I said above, Kconfig is doing pointless things.
>
> as mentioned above: Doesn't solve the issue.
>
> > [option 2]
> >     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
> >     This is what many architectures including arm, arm64 do.
> >     You need to explicitly pass CROSS_COMPILE=aarch64-linux-gnu- etc.
> >     if you are cross-compiling arm64.
>
> Might be an option, but it's not as handy as simply choosing CONFIG_64BIT
> and then things are done automatically.
>
> > [option 3]
> >     Introduce ARCH=parisc64.
> >
> >     When you are building 64-bit kernel, you can pass ARCH=parisc64
> >      A patch attached.  (but not tested much)
>
> Tried it, but doesn't work.
> asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hppa20-gcc).
>
> Thanks for your help so far!
> If you like I'm happy to give you an account on a hppa64 machine to reproduce yourself.
> I'll now try to bisect where it goes wrong. There must be something else before commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.
>
> Helge


Sorry for my late reply.

Did git-bisect find something?

If necessary, I will be happy to try it on the hppa64 machine.



-- 
Best Regards
Masahiro Yamada
