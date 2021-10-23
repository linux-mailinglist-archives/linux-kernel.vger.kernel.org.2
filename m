Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38F3438494
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhJWRqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 13:46:30 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:34296 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJWRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 13:46:28 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6407D92009C; Sat, 23 Oct 2021 19:44:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 53D5F92009B;
        Sat, 23 Oct 2021 19:44:07 +0200 (CEST)
Date:   Sat, 23 Oct 2021 19:44:07 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Old platforms: bring out your dead
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2110231853170.38243@angie.orcam.me.uk>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

 Old discussion, but I lost it in the mid-Jan linux-mips.org crash and 
only got my unread mailbox from that time restored recently and got at 
wading through it now.  I think an update on a couple of platforms of 
interest to me is going to be valuable anyway.

On Fri, 8 Jan 2021, Arnd Bergmann wrote:

> These are the oldest one by architecture, and they may have reached
> their best-served-by-date:
> 
> * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
>   indications that 486 have no users either on recent kernels.

 I continue using my 486DX2 box for defxx driver maintenance, as it's my 
only EISA machine.  A few years ago it suffered from a PSU failure, but 
that has been fixed now (I now have a spare PSU too, as it's an unusual 
industrial unit needed by the box due to its form factor).  Also its 16MiB 
of RAM it came with has indeed become insufficient recently, but I now 
have a 128MiB upgrade in the post, and will add another 128MiB to max it 
out once I get at suitable modules (the system requires 72-pin parity FPM 
SIMMs with gold fingers, which are uncommon at 64MiB).

 In any case I last booted 5.11.0 on it just fine and will get back at it 
once I have installed the RAM upgrade (scheduled second half of Nov; the 
box is in my remote lab, so I need to actually get there).

 FTR I also have a dual Pentium MMX box with 512MiB of RAM now installed 
and PCIe expansion.  It feels so fast after the RAM upgrade!

 There are some corner-case issues with both systems though and I have 
been posting patches to get them gradually addressed.  Expect more to 
come.

> * Alpha 2106x: First generation that lacks some of the later features.
>   Since all Alphas are ancient by now, it's hard to tell whether these have
>   any fewer users.

 I have a pair of Alpha 21064A (EV45) boxes, one of which is ready to run;
I just need to schedule some time to get an OS installed on it.  The other 
box will require some porting to get Linux run on it.  I have both of them 
locally here, so I can fiddle with them at any time.  Both have reasonable 
amounts of RAM, but I can't remember how much offhand.  Either or both my 
end up in my remote lab eventually.

> * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
>   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
>   supports these in DECstation and Toshiba Txx9, but it appears that most
>   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
>   later are rather different and widely used.

 I have numerous boxes built around the R3000 and the R2000 CPU even.  All 
have booted recent Linux kernels just fine.  The R2000 box has its maximum 
of 24MiB of RAM installed, which has become a bit of a problem.  OTOH the 
R3000 boxes support up to 480MiB of RAM, and I reckon I have an odd amount 
of like 352MiB installed in one of them, which makes it work quite nicely 
even without swap.  There has been some outstanding work in the driver 
area for these; I know.

 NB I have some of these boxes wired in my remote lab and scheduled to run 
GCC CI for legacy MIPS support once I get the test harness sorted.  Based 
on my experience they should be fast enough for that purpose.

 FAOD I can boot and control, including any software changes, any machine 
in my remote lab at any time as it's been the whole point of the lab.  Of 
course any hardware change requires an actual visit.

 FWIW,

  Maciej
