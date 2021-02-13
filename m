Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51231AA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 09:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBMIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 03:52:07 -0500
Received: from mailoutvs48.siol.net ([185.57.226.239]:33970 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229475AbhBMIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 03:52:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C8BCA52134F;
        Sat, 13 Feb 2021 09:51:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sbJZ5JLDUEdE; Sat, 13 Feb 2021 09:51:18 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 70AFA5214FE;
        Sat, 13 Feb 2021 09:51:18 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 1573352134F;
        Sat, 13 Feb 2021 09:51:17 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>,
        "B.R. Oake" <broake@mailfence.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@kernel.org>, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Date:   Sat, 13 Feb 2021 09:51:17 +0100
Message-ID: <6612268.HtAl026vyE@jernej-laptop>
In-Reply-To: <1719200956.433094.1613199092092@ichabod.co-bxl>
References: <1243888060.510560.1612783497400@ichabod.co-bxl> <20210210150118.ly252i37eykayrcb@gilmour> <1719200956.433094.1613199092092@ichabod.co-bxl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Let me first explain that it was oversight on my side not noticing initials in 
your SoB tag. But since the issue was raised by Maxime, I didn't follow up.

Dne sobota, 13. februar 2021 ob 07:51:32 CET je B.R. Oake napisal(a):
> On Wed Feb 10 at 16:01:18 CET 2021, Maxime Ripard wrote:
> > Unfortunately we can't take this patch as is, this needs to be your real
> > name, see:
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de
> > veloper-s-certificate-of-origin-1-1
> Dear Maxime,
> 
> Thank you very much for considering my contribution and for all your
> work on supporting sunxi-based hardware; I appreciate it.
> 
> Thank you for referring me to the Developer's Certificate of Origin, but
> I had already read it before submitting (I had to do so in order to know
> what I was saying by "Signed-off-by:") and I do certify what it says.
> 
> Looking through recent entries in the commit log of the mainline kernel,
> I see several patches from authors such as:
> 
>   H.J. Lu <hjl.tools@gmail.com>
>   B K Karthik <karthik.bk2000@live.com>
>   JC Kuo <jckuo@nvidia.com>
>   EJ Hsu <ejh@nvidia.com>
>   LH Lin <lh.lin@mediatek.com>
>   KP Singh <kpsingh@kernel.org>
>   Karthik B S <karthik.b.s@intel.com>
>   Shreyas NC <shreyas.nc@intel.com>
>   Vandana BN <bnvandana@gmail.com>
> 
> so I believe names of this form are in fact acceptable, even if the
> style might seem a little old-fashioned to some.

Speaking generally, not only for this case, prior art arguments rarely hold, 
because:
- it might be oversight,
- it might be a bad practice, which should not be followed in new 
contributions,
- different maintainers have different point of view on same thing,
- maintainer wants to adapt new practice or steer subsystem in new direction

> 
> I would like to add that I have met many people with names such as C.J.,
> A A, TC, MG, etc. That is what everybody calls them and it would be
> natural for them to sign themselves that way. Some of them might want to
> contribute to Linux some day, and I think it would be a great shame and
> a loss to all of us if they were discouraged from doing so by reading
> our conversation in the archives and concluding that any contribution
> from them, however small, would be summarily refused simply because of
> their name. Please could you ensure that does not happen?

The link you posted says following:
"using your real name (sorry, no pseudonyms or anonymous contributions.)"

I believe that real name means no initials, no matter what people are 
accustomed to. From my point of view, CJ is pseudonym derived from real name.

This is not the first time that fix of SoB tag was requested, you can find such 
requests in ML archives.

Best regards,
Jernej

> 
> Thank you again for your consideration.
> 
> Yours sincerely,
> B.R. Oake.




