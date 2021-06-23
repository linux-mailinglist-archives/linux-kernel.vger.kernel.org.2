Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C890D3B21D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFWUfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:35:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:44489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWUfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624480388;
        bh=XC9yqC0G7hVpKSK30NLSeWEH9vQXo5S9DovBAfPWSrQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LXLSaap7a8oWfOuT7tGjF5BRj0Mv9sjN7mTLj1uOO0w/QGtyCsb6cs2B9RUpGdasX
         UiCs4ib30nCyn7wgETvkfDK356kP8lqXFliKZrdIbRBk6k/+JZWxkoC3I2hlq89If3
         qm29kPV5/zVLeQx4/j64NuBfwF4+HWL07ZSCCduQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.187.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1l6eXA3e9L-00u4Qy; Wed, 23
 Jun 2021 22:33:07 +0200
Date:   Wed, 23 Jun 2021 22:33:02 +0200
From:   Helge Deller <deller@gmx.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-parisc compile failure in current git
Message-ID: <YNOafsB81ZcP2r7z@ls3530>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
 <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
X-Provags-ID: V03:K1:focGMA9Ic84ZzIdGabmFlocznqGFJboV5aADmQN2KdMzX3er7eQ
 qLX1nhylImXUh/7kH31n3N7pIVVBv7rQgSbwMG49Dp16GhahteLCBs/AtLdBODOcaYZrOrg
 mxSQjCcWvffThnLTUkJonYVTrkpNl3c8nbdXLyVARlCQICYflIWxWFT2dG09on/hxaRddHQ
 z9qnpYPFaDhe4yy0rNsMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jCckaPxwecQ=:XkkDdelAYA8FtcxWNpcV8b
 BOP8xR0EZ/FD4dDpWyoXfuTSB/Qeeq2wvJVtzuP0k68pfZ0VMWd9sp++2BJWUxEr/sT/0FnOs
 K/dsLOCC5wI8jE8c5k2IpVKgh9ayHTdLXxIRBpInfjKWi7BG0YOudBzA6detoAhYn91h2dH3R
 ACsJel1pmSghPwRRJrNhAT3NMQeRCL6p6gXCRep2+flZROaL7bam5defNwjru6od7uAw30gv6
 ig9ulhWicZr4f3Kts7IXpBtHu4dyBKpVhCEqOLF6FdzkAy3MiOvSY+x3UjIR6dDECMvDkL1Jj
 q1iZZwnz5c0/GoYKszr3gt4xFwft9HphtRucu6gDc1bDlLeeFNYOK3CbEBjqyiNeKOIbm/zxr
 LP3bfVl+D7VJhT7EbjSpiVvmJ5oRGb74mVL/hjxKhbhfxiJLGfHmGdrwERLicbG/88HZNfAD6
 m6wCHM4TULsMDr1T3fUhCx/Ewn9USgtjYyzGwSEEMImNGYvzYmUqAQNGoEUrV3m5dcaJnqSWS
 fTAa/T32u33lpdLfSEZmli86T6pkXbFcqp3xMrMlU8CzpAfvGV3hKzjEcnI3Ww8rFLs7c32m9
 In4dYGZb+r4AAccCsAyaOonGTMbq5EFdb6bYv7kgupjHH6JhB7EYAKL3Siasjvwm0wCbUxLTI
 6/LFVv9iUNsM7UpewoJEd3IyZc+thGJBR8ZMRxPImJaYSksp/YMHKwRZxq5YSAu33oCJaXQY5
 IcU0UA1XSr/UgLtWT9fBjzXvq98hrP7PeausXzJDiLUim2O6r9W9o6Fk3x4SgIe0IN9elV/jB
 v59+WP8Moi3XR4/b+BZ2gV+/45wVe45cBOxiUQLii4e/DhaQRJZ3KZUj3xZDNXqCG/aDx/A2h
 J9Q4D6bzAsVzzr2PlmKij8h1RoAtZIzWCNEqO7vKst5Vy7fsJDipFgLwnW4QXiRqrVnfR218l
 0TOzNmImsTC6O521gBcxbvyXGEBerylhTeQRZPDChvT0PvOcXxwDoc2qMbI7Orhk83rPDimBp
 0h1h3KjO2UzxjXDOB8JUKiaC1tOn0cHHQGBRbjEjAbmzWqdXcjxi60UbUqxRQA5eSNCtwrhyu
 hnn0C6/s9knOwVvPokelms5btB7Dm9y4L6a
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masahiro Yamada <masahiroy@kernel.org>:
> On Thu, Jun 10, 2021 at 4:04 PM Helge Deller <deller@gmx.de> wrote:
> >
> > Hi Masahiro,
> >
> > On 6/10/21 4:03 AM, Masahiro Yamada wrote:
> > > On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
> > >>
> > >> On 6/1/21 12:21 PM, Meelis Roos wrote:
> > >>> Upstream Linux git fails to compile on gentoo hppa -  .config belo=
w.
> > >>> I have 2 gcc-s as always:
> > >>> $ gcc-config -l
> > >>>    [1] hppa2.0-unknown-linux-gnu-9.3.0
> > >>>    [2] hppa2.0-unknown-linux-gnu-10.2.0 *
> > >>>
> > >>>    [3] hppa64-unknown-linux-gnu-10.2.0 *
> > >>
> > >>
> > >> I see the same issue too, but only when compiling natively on a par=
isc machine.
> > >> Cross-compiling on a x86 box works nicely.
> > >>
> > >> First I thought it's a problem with setting the "cross_compiling" f=
lag in ./Makefile.
> > >> But that's not sufficient.
> > >>
> > >> On a x86 machine (which builds fine) I get
> > >> SRCARCH=3Dparisc SUBARCH=3Dx86 UTS_MACHINE=3Dparisc
> > >> The arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
> > >> hppa64-linux-gnu-gcc
> > >>
> > >> On a native 32bit parisc machine I have:
> > >> SRCARCH=3Dparisc SUBARCH=3Dparisc UTS_MACHINE=3Dparisc
> > >> Here the arch/parisc/kernel/asm-offsets.c file gets preprocessed vi=
a:
> > >> gcc
> > >> Instead here the native hppa64-linux-gnu-gcc (cross compiler) shoul=
d have been used too, since
> > >> we build a 64-bit hppa kernel (CONFIG_64BIT is set).
> > >> Note, on hppa we don't have an "-m64" compiler flag as on x86.
> > >
> > > I see.
> > > hppa is not a bi-arch compiler, in other words,
> > > http- and hppa64- are separate compilers.
> >
> > Yes.
> >
> > >> Mashahiro, do you maybe have an idea what gets wrong here, or which
> > >> patch has changed the behaviour how the asm-offsets.c file gets pre=
processed?
> > >
> > > Presumably, commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
> > >
> > > Prior to that commit, arch/parisc/Makefile was like this:
> > >
> > > ifneq ($(SUBARCH),$(UTS_MACHINE))
> > >          ifeq ($(CROSS_COMPILE),)
> > >                      ...
> > >
> > > Now I understand why arch/parisc/Makefile was written this way.
> > >
> > > Reverting the change in arch/parisc/Makefile will restore the origin=
al behavior.
> >
> > Sadly, reverting this change (23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3=
) does not
> > restore the original behavior.
> >
> > > But, please keep in mind that there is an issue remaining.
> > >
> > > Please see this code:
> > >
> > > ifdef CONFIG_64BIT
> > > UTS_MACHINE :=3D parisc64
> > > CHECKFLAGS +=3D -D__LP64__=3D1
> > > CC_ARCHES =3D hppa64
> > > LD_BFD :=3D elf64-hppa-linux
> > > else # 32-bit
> > > CC_ARCHES =3D hppa hppa2.0 hppa1.1
> > > LD_BFD :=3D elf32-hppa-linux
> > > endif
> > >
> > >
> > > UTS_MACHINE is determined by CONFIG_64BIT.
> > >
> > > CONFIG_64BIT is defined only after Kconfig is finished.
> > > When you are trying to configure the .config,
> > > CONFIG_64BIT is not defined yet.
> > > So UTS_MACHINE is always 'parisc'.
> >
> > Yes.
> > See above, but it worked when I had SUBARCH=3Dx86 (when running my lap=
top).
> >
> >
> > > As you know, Kconfig files now have a bunch of 'cc-option' syntax
> > > to check the compiler capability in Kconfig time.
> > > Hence, you need to provide a proper compiler in Kconfig time too.
> > >
> > > When you build a 64-bit parisc kernel on a 32-bit parisc machine,
> >
> > Please note, that we don't have a 64-bit parisc userspace yet (just ke=
rnel).
> > This means, that all builds on parisc machines are 32bit and do a
> > cross-compilation to a parisc64 kernel if requested in the .config.
> >
> > > Kconfig is passed with CC=3Dgcc since SUBARCH=3D=3DUTS_MACHINE=3D=3D=
parisc.
> > > After Kconfig, CROSS_COMPILE=3Dhppa64-* is set,
> > > and the kernel is built by CC=3Dhppa64-*-gcc.
> >
> > Right. That is the old behaviour. Based on the CONFIG_64BIT option
> > the hppa64 compiler is choosen for CROSS_COMPILE.
> >
> > > So, Kconfig evaluated a compiletely different compiler. This is poin=
tless.
> >
> > Yes, probably.
> >
> >
> > > There are some options
> > >
> > > [option 1]
> > >    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
> > >    This will restore the functionality you may want, but
> > >    as I said above, Kconfig is doing pointless things.
> >
> > as mentioned above: Doesn't solve the issue.
> >
> > > [option 2]
> > >     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
> > >     This is what many architectures including arm, arm64 do.
> > >     You need to explicitly pass CROSS_COMPILE=3Daarch64-linux-gnu- e=
tc.
> > >     if you are cross-compiling arm64.
> >
> > Might be an option, but it's not as handy as simply choosing CONFIG_64=
BIT
> > and then things are done automatically.
> >
> > > [option 3]
> > >     Introduce ARCH=3Dparisc64.
> > >
> > >     When you are building 64-bit kernel, you can pass ARCH=3Dparisc6=
4
> > >      A patch attached.  (but not tested much)
> >
> > Tried it, but doesn't work.
> > asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hppa=
20-gcc).
> >
> > Thanks for your help so far!
> > If you like I'm happy to give you an account on a hppa64 machine to re=
produce yourself.
> > I'll now try to bisect where it goes wrong. There must be something el=
se before commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.
> >
> > Helge
>
>
> Sorry for my late reply.

Me too.... :-(

> Did git-bisect find something?

No. But I understood, that it's not a new problem.
It existed already before.

> If necessary, I will be happy to try it on the hppa64 machine.

Yes, please.
I'll send you login details in a private mail.
Attached is my last test patch (which is based on yours).

Helge

=2D----

diff --git a/Makefile b/Makefile
index ed669b2d705d..47a972f859f5 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -399,6 +399,11 @@ ifeq ($(ARCH),sparc64)
        SRCARCH :=3D sparc
 endif

+# Additional ARCH settings for parisc
+ifeq ($(ARCH),parisc64)
+       SRCARCH :=3D parisc
+endif
+
 export cross_compiling :=3D
 ifneq ($(SRCARCH),$(SUBARCH))
 cross_compiling :=3D 1
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index aed8ea29268b..ee5890a2f62d 100644
=2D-- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -25,18 +25,21 @@ CHECKFLAGS	+=3D -D__hppa__=3D1
 ifdef CONFIG_64BIT
 UTS_MACHINE	:=3D parisc64
 CHECKFLAGS	+=3D -D__LP64__=3D1
-CC_ARCHES	=3D hppa64
 LD_BFD		:=3D elf64-hppa-linux
 else # 32-bit
-CC_ARCHES	=3D hppa hppa2.0 hppa1.1
 LD_BFD		:=3D elf32-hppa-linux
 endif

 # select defconfig based on actual architecture
-ifeq ($(shell uname -m),parisc64)
+ifeq ($(ARCH),parisc64)
 	KBUILD_DEFCONFIG :=3D generic-64bit_defconfig
+	CC_ARCHES :=3D hppa64
+else ifdef CONFIG_64BIT
+	KBUILD_DEFCONFIG :=3D generic-64bit_defconfig
+	CC_ARCHES :=3D hppa64
 else
 	KBUILD_DEFCONFIG :=3D generic-32bit_defconfig
+	CC_ARCHES :=3D hppa hppa2.0 hppa1.1
 endif

 export LD_BFD
diff --git a/scripts/subarch.include b/scripts/subarch.include
index 650682821126..776849a3c500 100644
=2D-- a/scripts/subarch.include
+++ b/scripts/subarch.include
@@ -7,7 +7,7 @@
 SUBARCH :=3D $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 				  -e s/sun4u/sparc64/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
-				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+				  -e s/s390x/s390/ \
 				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
 				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
 				  -e s/riscv.*/riscv/)
