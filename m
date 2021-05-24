Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7779438E689
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEXM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhEXM1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:27:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB212C061574;
        Mon, 24 May 2021 05:26:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lz27so41493465ejb.11;
        Mon, 24 May 2021 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LZ3tdr4hqlo6y0P9hPaSNdG3YjOh64HdNvx/bx4VqGM=;
        b=kyPIdktJSSBvl5W91/m9dNH8cksVKDu03dfKYacZCX6jMPfcvJKq5ITA1I+4uqHyBi
         nupdMRxXXDUEdd/OJdrvxd7mmuDwjcEeVLwaG6yttaBdUIKUFGodcyS6Xglw+jZMPpFv
         YZiiBhwWmw7Ln9+tT+N+ofu+BSu8buyxYKSqnruBglg1im+/RB1rQTqnbLq/szLGGXJl
         zSrsii5JWFbtOqILwi37uoYCA9xMTMjFEDF4h1q4MMjVcEwP7EzkGvCS82tmBsEQDByY
         y/O4YkopJHqezBeAzVL/RS9F2A9fgRcglsdmIas+dUiW54c3CBOCzL5jD2J1V750VI+c
         bQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=LZ3tdr4hqlo6y0P9hPaSNdG3YjOh64HdNvx/bx4VqGM=;
        b=raxR0OeFw6UAxTslg48Xb4ug6bVarnEWJ3IZ7Rzk/gspItuFldZCGz7lC2u77P+BIc
         4xDUS4yiMSDc0UCvrBCu/FMprFQoQIza5VraVKM/vWNyX3ZPgEKrXJtsfXn0eG21W8Pe
         cioBIdEfhyk30vQS824CESh9CmbQx73Q+u7SWA61YoFN7Hm1K1LfKVyHGWBP8IHLEVEk
         +9bSgu6x8Wl3wlHvlCiNDB+YZQ+Hosh5CbGnCCM2o453QSq7sIyo40UNx96KNAzDYcOZ
         T1FAEojdXI18WkytgFhrvjoUZHdHxHvMajxL+otJlyZFuwT4E0ylP0ppnYI48Ijt/Xen
         WBOg==
X-Gm-Message-State: AOAM531QDYzOkCwM6KHRZ+jNbITWcaY+Qb6aL7Gfctdi1uQ8zNW/rMpy
        9pHcIPw6KhFnpu/rXoN0kac=
X-Google-Smtp-Source: ABdhPJwQmhKGvw39DCsJMnQ9r/eCsQ8BjQ+IOY4LwUOqq98MF3vqWqTuENJ8RdRjc6sh2jyfIgSmaQ==
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr23635178ejz.86.1621859163537;
        Mon, 24 May 2021 05:26:03 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id gz8sm7784841ejb.38.2021.05.24.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:26:02 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 24 May 2021 14:26:01 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Vagrant Cascadian <vagrant@reproducible-builds.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Message-ID: <YKubWX14bnR81hSW@eldamar.lan>
References: <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop>
 <YKFPGC2qBMipQPbd@eldamar.lan>
 <87o8dawhy3.fsf@yucca>
 <20210518150652.zxj56bljjeq3ogln@gilmour>
 <YKQiws6yP35QIpJd@eldamar.lan>
 <YKQm/F+JIjf/YUHm@eldamar.lan>
 <87a6opqn59.fsf@ponder>
 <YKavWaIEH/SdzT4m@eldamar.lan>
 <20210524115534.rw25uc6ao6e4yjye@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210524115534.rw25uc6ao6e4yjye@gilmour>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, May 24, 2021 at 01:55:34PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Thu, May 20, 2021 at 08:50:01PM +0200, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Thu, May 20, 2021 at 11:24:18AM -0700, Vagrant Cascadian wrote:
> > > On 2021-05-18, Salvatore Bonaccorso wrote:
> > > > On Tue, May 18, 2021 at 10:25:40PM +0200, Salvatore Bonaccorso wrote:
> > > >> On Tue, May 18, 2021 at 05:06:52PM +0200, Maxime Ripard wrote:
> > > >> > On Sun, May 16, 2021 at 01:18:44PM -0700, Vagrant Cascadian wrote:
> > > >> > > On 2021-05-16, Salvatore Bonaccorso wrote:
> > > >> > > > On Sat, Feb 13, 2021 at 09:51:17AM +0100, Jernej Škrabec wrote:
> > > >> > > >> Let me first explain that it was oversight on my side not noticing initials in 
> > > >> > > >> your SoB tag. But since the issue was raised by Maxime, I didn't follow up.
> > > >> > > >> 
> > > >> > > >> Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
> > > >> > > >> > On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> > > >> > > >> > > Unfortunately we can't take this patch as is, this needs to be your real
> > > >> > > >> > > name, see:
> > > >> > > >> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de
> > > >> > > >> > > veloper-s-certificate-of-origin-1-1
> > > >> > > >> > Dear Maxime,
> > > >> > > >> > 
> > > >> > > >> > Thank you very much for considering my contribution and for all your
> > > >> > > >> > work on supporting sunxi-based hardware; I appreciate it.
> > > >> > > >> > 
> > > >> > > >> > Thank you for referring me to the Developer's Certificate of Origin, but
> > > >> > > >> > I had already read it before submitting (I had to do so in order to know
> > > >> > > >> > what I was saying by "Signed-off-by:") and I do certify what it says.
> > > >> > > >> > 
> > > >> > > >> > Looking through recent entries in the commit log of the mainline kernel,
> > > >> > > >> > I see several patches from authors such as:
> > > >> > > >> > 
> > > >> > > >> >   H.J. Lu <hjl.tools@gmail.com>
> > > >> > > >> >   B K Karthik <karthik.bk2000@live.com>
> > > >> > > >> >   JC Kuo <jckuo@nvidia.com>
> > > >> > > >> >   EJ Hsu <ejh@nvidia.com>
> > > >> > > >> >   LH Lin <lh.lin@mediatek.com>
> > > >> > > >> >   KP Singh <kpsingh@kernel.org>
> > > >> > > >> >   Karthik B S <karthik.b.s@intel.com>
> > > >> > > >> >   Shreyas NC <shreyas.nc@intel.com>
> > > >> > > >> >   Vandana BN <bnvandana@gmail.com>
> > > >> > > >> > 
> > > >> > > >> > so I believe names of this form are in fact acceptable, even if the
> > > >> > > >> > style might seem a little old-fashioned to some.
> > > >> > > >> 
> > > >> > > >> Speaking generally, not only for this case, prior art arguments rarely hold, 
> > > >> > > >> because:
> > > >> > > >> - it might be oversight,
> > > >> > > >> - it might be a bad practice, which should not be followed in new 
> > > >> > > >> contributions,
> > > >> > > >> - different maintainers have different point of view on same thing,
> > > >> > > >> - maintainer wants to adapt new practice or steer subsystem in new direction
> > > >> > > >> 
> > > >> > > >> > 
> > > >> > > >> > I would like to add that I have met many people with names such as C.J.,
> > > >> > > >> > A A, TC, MG, etc. That is what everybody calls them and it would be
> > > >> > > >> > natural for them to sign themselves that way. Some of them might want to
> > > >> > > >> > contribute to Linux some day, and I think it would be a great shame and
> > > >> > > >> > a loss to all of us if they were discouraged from doing so by reading
> > > >> > > >> > our conversation in the archives and concluding that any contribution
> > > >> > > >> > from them, however small, would be summarily refused simply because of
> > > >> > > >> > their name. Please could you ensure that does not happen?
> > > >> > > >> 
> > > >> > > >> The link you posted says following:
> > > >> > > >> "using your real name (sorry, no pseudonyms or anonymous contributions.)"
> > > >> > > >> 
> > > >> > > >> I believe that real name means no initials, no matter what people are 
> > > >> > > >> accustomed to. From my point of view, CJ is pseudonym derived from real name.
> > > >> > > >> 
> > > >> > > >> This is not the first time that fix of SoB tag was requested, you can find such 
> > > >> > > >> requests in ML archives.
> > > >> > > 
> > > >> > > I'm sure this isn't the first time this sort of thing has been brought
> > > >> > > up on this subject, but I feel obliged to mention:
> > > >> > > 
> > > >> > >   https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
> > > >> > > 
> > > >> > > This seems to be blocked on culturally dependent perception of what
> > > >> > > looks like a "real name" as opposed to any technical grounds.
> > > >> > > 
> > > >> > > What is the goal of the "real name" in Signed-off-by actually trying to
> > > >> > > achieve?
> > > >> > 
> > > >> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> > > >> > 
> > > >> > I'm not the one making the rules, sorry
> > > >> 
> > > >> Would it be technically possible to do the following: Based on the
> > > >> downstream report we receved in Debian in
> > > >> https://bugs.debian.org/988574 wrap up the same patch (I guess I will
> > > >> need to use another commit message wording) and resubmit with my own
> > > >> SoB with my downstream hat on and say a Tested-by from Vagrant? So we
> > > >> are not blocked on the SoB issue from this original post of the change
> > > >> to apply to arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts ?
> > > >
> > > > Here is an attempt to do that and coming from
> > > > https://bugs.debian.org/988574 for the change change submission.
> > > >
> > > > Regards,
> > > > Salvatore
> > > >
> > > > From 93c335c997d6386fc5cb7b9c5621b9b9725de20e Mon Sep 17 00:00:00 2001
> > > > From: Salvatore Bonaccorso <carnil@debian.org>
> > > > Date: Tue, 18 May 2021 22:33:49 +0200
> > > > Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
> > > >
> > > > Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> > > > config") sets the RX/TX delay according to the phy-mode property in the
> > > > device tree. For the Orange Pi Plus board this is "rgmii", which is the
> > > > wrong setting.
> > > >
> > > > Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> > > > Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> > > > the Ethernet working again on this board.
> > > >
> > > > Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> > > > Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> > > > Link: https://bugs.debian.org/988574
> > > > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > > 
> > > Seems worth crediting the original reporter "B.R. Oake"
> > > <broake@mailfence.com> with a Reported-by as well?
> > 
> > Right, very good point, attached a revisited patch.
> > 
> > Regards,
> > Salvatore
> > 
> > From 886f1e5cf477f5e2b5a88718b47d11a9d78325d2 Mon Sep 17 00:00:00 2001
> > From: Salvatore Bonaccorso <carnil@debian.org>
> > Date: Tue, 18 May 2021 22:33:49 +0200
> > Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
> > 
> > Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> > config") sets the RX/TX delay according to the phy-mode property in the
> > device tree. For the Orange Pi Plus board this is "rgmii", which is the
> > wrong setting.
> > 
> > Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
> > Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
> > the Ethernet working again on this board.
> > 
> > Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> > Reported-by: "B.R. Oake" <broake@mailfence.com>
> > Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> > Link: https://bugs.debian.org/988574
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > ---
> > 
> > v2:
> >  - Add a Reported-by for "B.R. Oake" <broake@mailfence.com>
> 
> It looks good to me, can  you resend it using git send-email?

Thanks! Yes sure, just resent[1] it with git send-email.

 [1]:  <https://lore.kernel.org/lkml/20210524122111.416885-1-carnil@debian.org/T/#u>

Regards,
Salvatore
