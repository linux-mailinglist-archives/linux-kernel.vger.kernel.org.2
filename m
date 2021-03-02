Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB832ADE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360135AbhCBWRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:17:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:38065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1837050AbhCBUab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614716906;
        bh=0b2ozrvWE2ODbJt4BrXRkzCLBj9klBSlK2uW8UBziig=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Wcti6LHgdEeYmuvGF/BoegeUPZMgv618qFLaVj2yIX2PmyaG4toj0hK+7v6A7S0kD
         GV4PdKg38p9WrLiSWrgo3x9HHg6XBMble/Wm39emiXGPSUmezkYQpL0yj2vhPehfgc
         L+o2T8gqHcviirx8mBb0ExwP5Zc1xHxfvc60/uSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.180.203]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1l56ne2nQi-00CC0v; Tue, 02
 Mar 2021 21:28:26 +0100
Date:   Tue, 2 Mar 2021 21:28:09 +0100
From:   Helge Deller <deller@gmx.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: hppa64-linux-ld: kernel/sched/core.o(.init.text+0x90): cannot
 reach printk
Message-ID: <YD6f2WqmYdJiNyQX@ls3530>
References: <202103021826.7KKJWxQ2-lkp@intel.com>
 <CAKwvOdnCq7S68chEwSjFBPv5vsKDuzumOX19peOFDCSBCUm0jg@mail.gmail.com>
 <2e40a84f-15c6-2764-dcfd-9f5aa368b400@gmx.de>
 <CAKwvOdkXUAfYv415U9aE+ycLKT1rzujrBFfFHmvX47V5xHz1sA@mail.gmail.com>
 <fc099004-dbb4-b9b3-b377-ad459219c7c5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc099004-dbb4-b9b3-b377-ad459219c7c5@gmx.de>
X-Provags-ID: V03:K1:oPqHMApBLPbZr0xLnn2DXNEMs6RABJUgiS2y6TDrNjwXVqUxZ2m
 bLq1mNRNqlM3ZlzoGoNFfU3eiXasVYV8zgezYCEFfMyjm7reGZiWdchx22n7QX75s4emq8k
 uAYAuRSNmPu/K+WwmN6ldJpOGPrk/qxb/qiUN8csNrBlTRQm8f1FOzmaTUhDf5HEhORC0Qf
 7tzNy3jhCejYTsXdB/PDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/RQlrobO7iY=:lEdZJ2M1x+geuPqHSc64E6
 1//x9OXQ2l2J63nqmvrbz+J94nVPjY+TUXqMkG8KvwkJ4W4DRC2tzlJ3tTAk58ur8X1lcNKAA
 4RkudH6MAYBsLJyz5HFydltIc6Al+h1v3g0PDhXYyYIezd4sxreBRcomSWOx0R39cJyrlrTVA
 o6t458Xh8GIwbkngFRD6m2vUti3PtvDNEh6a+1eHXXe7Srl0fUWgK29ZM5CG9egd76Ti5VYuo
 +m1PkEeIM8+9lhxwCPwYbVWtGCi0DulHittVmhW7dsRseivThDpefQNF4tv6OPgbg7G0bF5Bx
 Oz6PxJexBZuOAYsYvKkCQeh/hHaE7BBNx7uvZ3DiWDElI/0Ae+D9uqi5l0phJB/w7sM0CcC+n
 URJyTKmjPD4e7QU4In2gQ5tvMNO2vBxftCHj4Roz/L/q+mWRj8ZvsuMVE7r9nIq0EfL1ybC7I
 +2MgQGHXwPlIw6w48gX25cyj05pwQ2GSpmEcLGXVM4no2BT1oLBLQGG69RkXUJfHjb4pv7gEu
 xFDgdxrC1upiiPqXBNspczqv/b551j/1tJx/lRVju3Edn0ofIP0iGEyt4MQT0drJaFO5HKWHi
 6nDj2kuGRE1pDOF40+QJtqju5pEllXx91ZkwlbBywNnCRQE+co4yF0LT/DDvVS8L7E/sXdL/k
 b6LAAzRpU0ct2DFL+x/hAh83tLY18d+0aTUBUwMXPc+QpRxBrWpBh0AzscW32IQ2U4huuTZDA
 5ciX27ouN/beGOCBlcgP8FMTGf0BYQb1jmNdQfmguzljN6gzDrBIO+rQynllmSP/SNs50B+mZ
 hP9JUHYhLiMc16OJuBIpCFtbb+sIqfBIIdJ3z3P+2KCFt22NIwNt5YacYXO93pnHeVn0Jaebl
 3g6g83D2wFKTzPmu459Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Helge Deller <deller@gmx.de>:
> On 3/2/21 7:07 PM, Nick Desaulniers wrote:
> > + Arnd
> >
> > On Tue, Mar 2, 2021 at 10:03 AM Helge Deller <deller@gmx.de> wrote:
> > >
> > > On 3/2/21 6:29 PM, Nick Desaulniers wrote:
> > > > + pa-risc folks
> > >
> > > Thanks for looking into this, Nick!
> > >
> > > > On Tue, Mar 2, 2021 at 2:59 AM kernel test robot <lkp@intel.com> w=
rote:
> > > > >
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git master
> > > > > head:   7a7fd0de4a9804299793e564a555a49c1fc924cb
> > > > > commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: =
Add PGO and AutoFDO input sections
> > > >
> > > > This commit added sections explicitly to the kernel's linker scrip=
t.
> > >
> > > Yes, but even when reverting this patch it does not prevent
> > > the linking problems.
> > >
> > >
> > > > > date:   6 months ago
> > > > > config: parisc-randconfig-s031-20210228 (attached as .config)
> > > >
> > > > ^ randconfig (always find something curious)
> > >
> > > Yes :-)
> > >
> > >
> > > > > compiler: hppa64-linux-gcc (GCC) 9.3.0
> > > > > reproduce:
> > > > >           wget https://raw.githubusercontent.com/intel/lkp-tests=
/master/sbin/make.cross -O ~/bin/make.cross
> > > > >           chmod +x ~/bin/make.cross
> > > > >           # apt-get install sparse
> > > > >           # sparse version: v0.6.3-241-geaceeafa-dirty
> > > > >           # https://git.kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux.git/commit/?id=3Deff8728fe69880d3f7983bec3fb6cea4c306261f
> > > > >           git remote add linus https://git.kernel.org/pub/scm/li=
nux/kernel/git/torvalds/linux.git
> > > > >           git fetch --no-tags linus master
> > > > >           git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
> > > > >           # save the attached .config to linux build tree
> > > > >           COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.=
0 make.cross C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dpa=
risc
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > All errors (new ones prefixed by >>):
> > > > >
> > > > >      hppa64-linux-ld: init/main.o(.init.text+0x294): cannot reac=
h printk
> > > > >      init/main.o: in function `do_early_param':
> > > > >      (.init.text+0x294): relocation truncated to fit: R_PARISC_P=
CREL22F against symbol `printk' defined in .text.unlikely section in kerne=
l/printk/printk.o
> > > >
> > > > ^ so we can't encode a jump to printk from do_early_param.
> > >
> > > Right.
> > >
> > > > If the linker is warning that printk is in the .text.unlikely
> > > > section, I'm curious why printk is marked cold?
> > >
> > > printk is always marked cold, see include/linux/printk.h:
> > > asmlinkage __printf(1, 2) __cold
> > > int printk(const char *fmt, ...);
> > >
> > > > Likely the randconfig produces a large TEXT_MAIN;
> > >
> > > Yes.
> > >
> > > > I'm guessing that .init.text is on one side of TEXT_MAIN, and
> > > > .text.unlikely is on the other.  Though there are many different
> > > > instances below.
> > > Yes. But even the large TEXT_MAIN by itself can become a problem.
> > >
> > > > I'm more familiar with ARM; it's common for the linker to insert
> > > > trampolines/thunks to bridge jumps too large to encode in a given
> > > > instruction.  I don't know if BFD has arch agnostic machinery for
> > > > that, but might be seeing if there's anything reuseable there.
> > >
> > > Dave mentioned in another mail, that long branch stub support is
> > > still missing in the 64-bit parisc linker.
> > >
> > > My question still remains:
> > > Is there any possibility to detect that we build/configure a
> > > 0-day kernel? If so, auto-enabling CONFIG_MLONGCALLS kernel option
> > > would solve it (temporarily).
> >
> > Arnd, is this kind of case what CONFIG_COMPILE_TEST is usually used fo=
r?
>
> Yes, I think that's the right knob!
> CONFIG_COMPILE_TEST is enabled on all parisc configs for which 0-day
> reported issues.
> I've wired it up in Kconfig and it now works around the issue.

I've committed the patch below to the parisc for-next tree, which allows
to monitor if this fixes the linkage problems...

Helge



From: Helge Deller <deller@gmx.de>
Date: Tue, 2 Mar 2021 21:07:07 +0100
Subject: [PATCH] parisc: Enable -mlong-calls gcc option with
 CONFIG_COMPILE_TEST

The kernel test robot reported multiple linkage problems like this:

    hppa64-linux-ld: init/main.o(.init.text+0x56c): cannot reach printk
    init/main.o: in function `unknown_bootoption':
    (.init.text+0x56c): relocation truncated to fit: R_PARISC_PCREL22F aga=
inst
	symbol `printk' defined in .text.unlikely section in kernel/printk/printk=
.o

There are two ways to solve it:
a) Enable the -mlong-call compiler option (CONFIG_MLONGCALLS),
b) Add long branch stub support in 64-bit linker.

While b) is the long-term solution, this patch works around the issue by
automatically enabling the CONFIG_MLONGCALLS option when
CONFIG_COMPILE_TEST is set, which indicates that a non-production kernel
(e.g. 0-day kernel) is built.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 00e35f2b0e8a ("parisc: Enable -mlong-calls gcc option by default wh=
en !CONFIG_MODULES")
Cc: stable@vger.kernel.org # v5.6+

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 4e53ac46e857..afc3b8d03572 100644
=2D-- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -203,9 +203,12 @@ config PREFETCH
 	def_bool y
 	depends on PA8X00 || PA7200

+config PARISC_HUGE_KERNEL
+	def_bool y if !MODULES || UBSAN || FTRACE || COMPILE_TEST
+
 config MLONGCALLS
-	def_bool y if !MODULES || UBSAN || FTRACE
-	bool "Enable the -mlong-calls compiler option for big kernels" if MODULE=
S && !UBSAN && !FTRACE
+	def_bool y if PARISC_HUGE_KERNEL
+	bool "Enable the -mlong-calls compiler option for big kernels" if !PARIS=
C_HUGE_KERNEL
 	depends on PA8X00
 	help
 	  If you configure the kernel to include many drivers built-in instead
