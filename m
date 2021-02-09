Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCA1314B40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBIJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhBIJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:12:35 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CA6C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:11:54 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id l8so5098842ybe.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGW0eA5gyXpZ0sesXw0uI788jg1NwXbAF+PLJG7HU/Q=;
        b=dvq7B69XpUjdIBGp5/yWALdVDlaScF3vUuTZz4KxHdTO7433eUDs6FFZsk3Bz0IYPq
         tyN1pCJUw3OATFD/QbUF+3UuHkGPxvY1a8vEO4mmCZHHhlLSiYgcMYj4XycSjqKNk7Zc
         hePESvLFL25CeDrpJKFhfWFypKoVlvbyc26eO1mV82G3FcBiKzdE4HPEXsQsQNTN0Mze
         FC+RYX7/Nh7nWX1MvPGwHII85ZFLcMt1rTicTzxgp+PXIawL3Jb3uzEZ7ueZudawYLtC
         n0UAfb9Ichi0xeGJU0zAvyQCX6+cfFAvPA+1vlpa66X5kbm1sIUDYjpJmrTcj9ILDvh8
         PQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGW0eA5gyXpZ0sesXw0uI788jg1NwXbAF+PLJG7HU/Q=;
        b=NybatkLlxRFAo1odoje7U/sD+Lk+p0qNzjWMFVYUS82q2pZ+WXCSbbajEkp/4zatBc
         sC73ih63ZsaeBMVDeqW+6rjeAw1qfAimDbV9eWdlF+lIa6ov8Onmvb+RYvmgbioH2V5L
         AsA4L8le4WDMxXWBVktqSwty21xpAiOdD4MG89xaOtxG+2YIcrtdiAUO00s/hKvjOPjf
         QJpzlTBx0bqg++zUzd+253SjMbU8Hs/bTDrrpdXpxcqGsqIZVBwXxdRMuZAt152perx5
         uNH5xu5Y0D8u2E8OPKED4oEeQ5xkNTwsXFiTsCfFV9/SB7uMJ1E/wR8bMAfMo82aRTbZ
         sGJA==
X-Gm-Message-State: AOAM532c3geaydrnN0uvHLrD8lZHOlatWQvSnfHLAaEWzdv7IX+GN9P3
        K6DkLp7oeobvqJCqddy5c7TZouUW9NZbeolo+++a6g==
X-Google-Smtp-Source: ABdhPJw1o0bdbZlPF4t8kt67rFZkdil5oi9cVN0Lye7DNnMsBpeiRPXBUtNIwfEz0HUWyjbOsFlLWgulWRejUtNU93g=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr28845663ybl.310.1612861913788;
 Tue, 09 Feb 2021 01:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20210128104446.164269-1-tudor.ambarus@microchip.com>
 <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com> <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
In-Reply-To: <161285731192.418021.10555916396092570051@swboyd.mtv.corp.google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 9 Feb 2021 01:11:17 -0800
Message-ID: <CAGETcx9C+sH-GKz61GfCxd9qk=E-AMueHSwPgp5Z_5QcOzXJiQ@mail.gmail.com>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        nicolas.ferre@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        mirq-linux@rere.qmqm.pl,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 11:55 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Saravana Kannan (2021-01-28 09:01:41)
> > On Thu, Jan 28, 2021 at 2:45 AM Tudor Ambarus
> > <tudor.ambarus@microchip.com> wrote:
> > >
> > > The sama5d2 requires the clock provider initialized before timers.
> > > We can't use a platform driver for the sama5d2-pmc driver, as the
> > > platform_bus_init() is called later on, after time_init().
> > >
> > > As fw_devlink considers only devices, it does not know that the
> > > pmc is ready. Hence probing of devices that depend on it fail:
> > > probe deferral - supplier f0014000.pmc not ready
> > >
> > > Fix this by setting the OF_POPULATED flag for the sama5d2_pmc
> > > device node after successful setup. This will make
> > > of_link_to_phandle() ignore the sama5d2_pmc device node as a
> > > dependency, and consumer devices will be probed again.
> > >
> > > Fixes: e590474768f1cc04 ("driver core: Set fw_devlink=on by default")
> > > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > ---
> > > I'll be out of office, will check the rest of the at91 SoCs
> > > at the begining of next week.
> > >
> > >  drivers/clk/at91/sama5d2.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> > > index 9a5cbc7cd55a..5eea2b4a63dd 100644
> > > --- a/drivers/clk/at91/sama5d2.c
> > > +++ b/drivers/clk/at91/sama5d2.c
> > > @@ -367,6 +367,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
> > >
> > >         of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama5d2_pmc);
> > >
> > > +       of_node_set_flag(np, OF_POPULATED);
> > > +
> > >         return;
> >
> > Hi Tudor,
> >
> > Thanks for looking into this.
> >
> > I already accounted for early clocks like this when I designed
> > fw_devlink. Each driver shouldn't need to set OF_POPULATED.
> > drivers/clk/clk.c already does this for you.
> >
> > I think the problem is that your driver is using
> > CLK_OF_DECLARE_DRIVER() instead of CLK_OF_DECLARE(). The comments for
> > CLK_OF_DECLARE_DRIVER() says:
> > /*
> >  * Use this macro when you have a driver that requires two initialization
> >  * routines, one at of_clk_init(), and one at platform device probe
> >  */
> >
> > In your case, you are explicitly NOT having a driver bind to this
> > clock later. So you shouldn't be using CLK_OF_DECLARE() instead.
> >
>
> I see
>
> drivers/power/reset/at91-sama5d2_shdwc.c:       { .compatible = "atmel,sama5d2-pmc" },
>
> so isn't that the driver that wants to bind to the same device node
> again? First at of_clk_init() time here and then second for the reset
> driver?

You are right. I assumed that when Tudor was setting OF_POPULATED,
they didn't want to create a struct device and they knew it was right
for their platform.

However...
$ git grep "atmel,sama5d2-pmc"
arch/arm/boot/dts/sama5d2.dtsi:                         compatible =
"atmel,sama5d2-pmc", "syscon";
arch/arm/mach-at91/pm.c:        { .compatible = "atmel,sama5d2-pmc",
.data = &pmc_infos[1] },
drivers/clk/at91/pmc.c: { .compatible = "atmel,sama5d2-pmc" },
drivers/clk/at91/sama5d2.c:CLK_OF_DECLARE_DRIVER(sama5d2_pmc,
"atmel,sama5d2-pmc", sama5d2_pmc_setup);
drivers/power/reset/at91-sama5d2_shdwc.c:       { .compatible =
"atmel,sama5d2-pmc" },

Geez! How many drivers are there for this one device. Clearly not all
of them are going to bind. But I'm not going to dig into this. You can
reject this patch. I expect this series [1] to take care of the issue
Tudor was trying to fix.

Tudor,

Want to give this series [1] a shot?

[1] - https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
-Saravana
