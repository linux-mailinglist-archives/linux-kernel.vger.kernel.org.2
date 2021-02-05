Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D150C311797
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBFAF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:05:28 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:11795 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhBENiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:38:14 -0500
Date:   Fri, 05 Feb 2021 13:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1612532238; bh=OBFEzz93Vl35M+p2va/+PXuqqyUJ0bnsvwDFk5CFKFg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=W14TcdJRrIONjTc8Qz3R/TWDExO7qFXQEdVg0vSpB5so72lAAjsmVFccACK+sTytF
         DlLJJf4HYct14at6CyTvrP1LRTdx1tCQ4j1HFF8W00VL+BzEnbUmbAhacEdyLgOUsU
         GAqfLaYhuEACSSWTOkwDIOxoCSEOutc4FTGugp8zcjMmP/KCKWwy6EPKoL16/op2cD
         ytSNpQErXNHqTJMCBxh/FnRpG1lqQWgK1tQ12OffHRkQe5cveBStxrjbjNCCTtBQpE
         Op26EdFdYgueMlRRPiaUOittnqz4lDdFS41x0lCISdAmzdqj63OV8Ka7XaDOKXK2tb
         CLzawZ3IOtkgA==
To:     Arnd Bergmann <arnd@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210205133614.8082-1-alobakin@pm.me>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 8 Jan 2021 23:55:06 +0100

> After v5.10 was officially declared an LTS kernel, I had a look around
> the Arm platforms that look like they have not seen any patches from
> their maintainers or users that are actually running the hardware for
> at least five years (2015 or earlier). I made some statistics and lists
> for my lwn.net article last year [1], so I'd thought I'd share a summary
> here for discussion about what we should remove. As I found three
> years ago when I removed several CPU architectures, it makes sense
> to do this in bulk, to simplify a scripted search for device drivers, hea=
der
> files and Kconfig options that become unused in the process.
>=20
> This is probably a mix of platforms that are completely unused and
> those that just work, but I have no good way of knowing which one
> it is. Without hearing back about these, I'd propose removing all of
> these:
>=20
> * asm9260 -- added in 2014, no notable changes after 2015
> * axxia -- added in 2014, no notable changes after 2015
> * bcm/kona -- added in 2013, no notable changes after 2014
> * digicolor -- added in 2014, no notable changes after 2015
> * dove -- added in 2009, obsoleted by mach-mvebu in 2015
> * efm32 -- added in 2011, first Cortex-M, no notable changes after 2013
> * nspire -- added in 2013, no notable changes after 2015
> * picoxcell -- added in 2011, already queued for removal
> * prima2 -- added in 20111, no notable changes since 2015
> * spear -- added in 2010, no notable changes since 2015
> * tango -- added in 2015, sporadic changes until 2017, but abandoned
> * u300 -- added in 2009, no notable changes since 2013
> * vt8500 -- added in 2010, no notable changes since 2014
> * zx --added in 2015 for both 32, 2017 for 64 bit, no notable changes
>=20
> If any of the above are not dead yet[2], please let me know,
> and we'll keep them.
>=20
> Then there are ARM platforms that are old but have still seen some work
> in the past years. If I hear nothing, these will all stay, but if maintai=
ners
> may want to drop them anyway, I can help with that:
>=20
> * clps711x -- prehistoric, converted to multiplatform+DT in 2016, no
> changes since
> * cns3xxx -- added in 2010, last fixed in 2019, probably no users left
> * ep93xx -- added in 2006, LinusW still working on it, any users left?
> * footbridge -- added in prehistory, stable since ~2013, rmk and LinusW h=
ave one
> * gemini -- added in 2009, LinusW still working on it
> * hisi (hip01/hip05) -- servers added in 2013, replaced with arm64 in 201=
6
> * highbank -- added in 2011, no changes after 2015, but Andre still uses =
it
> * iop32x -- added in 2006, no notable changes other than my cleanup, but
>   I think there are still users
> * ixp4xx -- prehistoric, but LinusW and I are still working on it
> * lpc18xx -- added in 2015, new dts in 2018, but few other changes
> * lpc32xx -- added in 2010, multiplatform 2019, hardware is EOL
> * mmp -- added in 2009, DT support is active, but board files might go
> * moxart -- added in 2013, last Tested-by in 2017
> * mv78xx0 -- added in 2008, mostly stale but still users
>   (https://github.com/1000001101000/Debian_on_Buffalo)
> * nomadik -- added in 2009, LinusW keeps fixing it, probably no other use=
rs
> * oxnas -- added in 2016, but already old then, few changes later
> * pxa -- prehistoric, but a few boards may still have users
> * rpc -- prehistoric, but I think Russell still uses his machine
> * sa1100 -- prehistoric, but rmk and LinusW sporadically working in it
>=20
> I also looked at non-ARM platforms while preparing for my article. Some o=
f
> these look like they are no longer actively maintained or used, but I'm n=
ot
> doing anything about those unless the maintainers would like me to:
>=20
> * h8300: Steven Rostedt has repeatedly asked about it to be removed
>    or fixed in 2020 with no reply. This was killed before in 2013, added =
back
>    in 2015 but has been mostly stale again since 2016
> * c6x: Added in 2011, this has seen very few updates since, but
>     Mark still Acks patches when they come. Like most other DSP platforms=
,
>     the model of running Linux on a DSP appears to have been obsoleted
>     by using Linux on ARM with on-chip DSP cores running bare-metal code.
> * sparc/sun4m: A patch for removing 32-bit Sun sparc support (not LEON)
>    is currently under review
> * powerpc/cell: I'm the maintainer and I promised to send a patch to remo=
ve it.
>    it's in my backlog but I will get to it. This is separate from PS3,
> which is actively
>    maintained and used; spufs will move to ps3
> * powerpc/chrp (32-bit rs6000, pegasos2): last updated in 2009
> * powerpc/amigaone: last updated in 2009
> * powerpc/maple: last updated in 2011
> * m68k/{apollo,hp300,sun3,q40} these are all presumably dead and have not
>    seen updates in many years (atari/amiga/mac and coldfire are very much
>    alive)
> * mips/jazz: last updated in 2007
> * mips/cobalt: last updated in 2010
>=20
> There might be some value in dropping old CPU support on architectures
> and platforms that are almost exclusively used with more modern CPUs.
> If there are only few users, those can still keep using v5.10 or v5.4 sta=
ble
> kernels for a few more years. Again, I'm not doing anything about them,
> except mention them since I did the research.
> These are the oldest one by architecture, and they may have reached
> their best-served-by-date:
>=20
> * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
>   indications that 486 have no users either on recent kernels.
>   There is still the Vortex86 family of SoCs, and the oldest of those wer=
e
>   486SX-class, but all the modern ones are 586-class.
> * Alpha 2106x: First generation that lacks some of the later features.
>   Since all Alphas are ancient by now, it's hard to tell whether these ha=
ve
>   any fewer users.
> * IA64 Merced: first generation Itanium (2001) was quickly replaced by
>   Itanium II in 2002.
> * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
>   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
>   supports these in DECstation and Toshiba Txx9, but it appears that most
>   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
>   later are rather different and widely used.

I still have some devboards with a 32-bit R3000-like CPU :S
v5.11-rc6 works well on them.

> * PowerPC 601 (from 1992) just got removed, later 60x, 4xx, 8xx etc
>   are apparently all still used.
> * SuperH SH-2: We discussed removing SH-2 (not J2 or SH-4)
>   support in the past, I don't think there were any objections, but
>   nobody submitted a patch.
> * 68000/68328 (Dragonball): these are less capable than the
>   68020+ or the Coldfire MCF5xxx line and similar to the 68360
>   that was removed in 2016.
>=20
>         Arnd
>=20
> [1] https://lwn.net/Articles/838807/
> [2] https://www.youtube.com/watch?v=3DJdf5EXo6I68

Thanks,
Al

