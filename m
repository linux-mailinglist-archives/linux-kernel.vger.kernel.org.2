Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42A03149C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBIH4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBIHzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:55:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BBFE64E6F;
        Tue,  9 Feb 2021 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612857313;
        bh=H95e5VIxFGRYJjLg6UbSArCbHJ9oIF5vqaL9Q5bAX8Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NFgHngv8ebO5+5WphQUJHSGcLMS+MhhJk+zP0WmdOPzHL9e7ClTidmEUnYBkm9c4M
         0TQjn1RgtDxUPTgL23Xqmac7j3Qa2EIuhqWKRLcd56+zy9uafozNaCzFCqgEyE/Jhm
         S6q4Y0soN9jBxyyeb4etK+L0+CDQ8cuvbC2pUdAO+fy06vqQH/UW6T3rxaxWTQa9V3
         FNnpfGTuNNg5ydoWS81iOICL0seauXBLCmYhOrzZf2ZpH38P2HM6vOepZkrvp2WxbL
         c+TJrHwVp0ic2nM1lT0IhbMuaT7aY49msaJrpJzAuC2AeuK/tRXIJz8boDEuIR/2zK
         x8InH4C6/+2wQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
References: <20210128104446.164269-1-tudor.ambarus@microchip.com> <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, claudiu.beznea@microchip.com,
        mirq-linux@rere.qmqm.pl,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Saravana Kannan <saravanak@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Date:   Mon, 08 Feb 2021 23:55:11 -0800
Message-ID: <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2021-01-28 09:01:41)
> On Thu, Jan 28, 2021 at 2:45 AM Tudor Ambarus
> <tudor.ambarus@microchip.com> wrote:
> >
> > The sama5d2 requires the clock provider initialized before timers.
> > We can't use a platform driver for the sama5d2-pmc driver, as the
> > platform_bus_init() is called later on, after time_init().
> >
> > As fw_devlink considers only devices, it does not know that the
> > pmc is ready. Hence probing of devices that depend on it fail:
> > probe deferral - supplier f0014000.pmc not ready
> >
> > Fix this by setting the OF_POPULATED flag for the sama5d2_pmc
> > device node after successful setup. This will make
> > of_link_to_phandle() ignore the sama5d2_pmc device node as a
> > dependency, and consumer devices will be probed again.
> >
> > Fixes: e590474768f1cc04 ("driver core: Set fw_devlink=3Don by default")
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---
> > I'll be out of office, will check the rest of the at91 SoCs
> > at the begining of next week.
> >
> >  drivers/clk/at91/sama5d2.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> > index 9a5cbc7cd55a..5eea2b4a63dd 100644
> > --- a/drivers/clk/at91/sama5d2.c
> > +++ b/drivers/clk/at91/sama5d2.c
> > @@ -367,6 +367,8 @@ static void __init sama5d2_pmc_setup(struct device_=
node *np)
> >
> >         of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama5d2_pmc);
> >
> > +       of_node_set_flag(np, OF_POPULATED);
> > +
> >         return;
>=20
> Hi Tudor,
>=20
> Thanks for looking into this.
>=20
> I already accounted for early clocks like this when I designed
> fw_devlink. Each driver shouldn't need to set OF_POPULATED.
> drivers/clk/clk.c already does this for you.
>=20
> I think the problem is that your driver is using
> CLK_OF_DECLARE_DRIVER() instead of CLK_OF_DECLARE(). The comments for
> CLK_OF_DECLARE_DRIVER() says:
> /*
>  * Use this macro when you have a driver that requires two initialization
>  * routines, one at of_clk_init(), and one at platform device probe
>  */
>=20
> In your case, you are explicitly NOT having a driver bind to this
> clock later. So you shouldn't be using CLK_OF_DECLARE() instead.
>=20

I see=20

drivers/power/reset/at91-sama5d2_shdwc.c:       { .compatible =3D "atmel,sa=
ma5d2-pmc" },

so isn't that the driver that wants to bind to the same device node
again? First at of_clk_init() time here and then second for the reset
driver?
