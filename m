Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28783334B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhCJWZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhCJWZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:25:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CB8E64FC3;
        Wed, 10 Mar 2021 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615415103;
        bh=5i/wQJZG2Wq2WCbDU9tA62TgE9ILBZZyMUT53KKaAiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDEOdCY5AYNreUbvB0tTaHJzJF3P0TVfBDLI2nHhRDKKJXUQnir0d0NRYZGzhY7uH
         rz7F69p4ekgqEY4DLplUKQkQT4N1LjbcZROoBuWe+/pzxGWDEpPcbp5nFq18wuPUKI
         HhubR1JYWmM8qhOgHcqL4npyV0luXMLqzI7K+Unf5pEaPjBpXgTD84RaK/XP1adpYY
         fJnwxRHPlG9CMvTTZHW5r9ipUDtfscgrz4DswYnCq3MQPNT6txr2P1kjss3gXu//gI
         7TW9SQBsNhmKgA4gb3T1mp93lKewICb6VyQCtEpqYKa4zjqeuIfpzQEkjY5h6rTdoO
         NGuVmsjNR0/6w==
Date:   Thu, 11 Mar 2021 00:24:57 +0200
From:   Abel Vesa <abelvesa@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated
 with sdout
Message-ID: <YElHOV3FghXhld8A@ryzen.lan>
References: <20210120152813.x2pbs5vprevkly23@fsr-ub1664-175>
 <20210120155001.GD19063@pengutronix.de>
 <20210120161421.h3yng57m3fetwwih@fsr-ub1664-175>
 <20210121095617.GI19063@pengutronix.de>
 <20210121102450.lisl3mzqczdsmzda@fsr-ub1664-175>
 <CAHCN7x+eMHncRya3KWm5g=stzVf0fzNojS5mFxwvGW-sVoLsYQ@mail.gmail.com>
 <CAHCN7xLc6dnkA5Fw4cC1_nDG3KrrR4AffUzy-8gG4UKLn-rhzQ@mail.gmail.com>
 <20210215130620.3la4bexamozzcvjx@fsr-ub1664-175>
 <CAHCN7xK1rWkDK6JE6MvN1UoV0b3Z5dQjeWZDNgnZHRwD1XkuZQ@mail.gmail.com>
 <20210303083119.wadme5a7j4zf7vuz@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303083119.wadme5a7j4zf7vuz@fsr-ub1664-175>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-03 10:31:19, Abel Vesa wrote:
> On 21-03-02 13:03:04, Adam Ford wrote:
> > On Mon, Feb 15, 2021 at 7:06 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > >
> > > On 21-02-13 08:44:28, Adam Ford wrote:
> > > > On Wed, Feb 3, 2021 at 3:22 PM Adam Ford <aford173@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jan 21, 2021 at 4:24 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > > > > >
> > > > > > On 21-01-21 10:56:17, Sascha Hauer wrote:
> > > > > > > On Wed, Jan 20, 2021 at 06:14:21PM +0200, Abel Vesa wrote:
> > > > > > > > On 21-01-20 16:50:01, Sascha Hauer wrote:
> > > > > > > > > On Wed, Jan 20, 2021 at 05:28:13PM +0200, Abel Vesa wrote:
> > > > > > > > > > On 21-01-20 16:13:05, Sascha Hauer wrote:
> > > > > > > > > > > Hi Abel,
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Jan 20, 2021 at 04:44:54PM +0200, Abel Vesa wrote:
> > > > > > > > > > > > On 21-01-18 08:00:43, Adam Ford wrote:
> > > > > > > > > > > > > On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > > > > > > > > >
> > > > > > > > > > ...
> > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > TBH, I'm against the idea of having to call consumer API from a clock provider driver.
> > > > > > > > > > > > > > I'm still investigating a way of moving the uart clock control calls in drivers/serial/imx,
> > > > > > > > > > > > > > where they belong.
> > > > > > > > > > > > >
> > > > > > > > > > > > > That makes sense.
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Just a thought. The uart clock used for console remains on from u-boot,
> > > > > > > > > > > > so maybe it's enough to just add the CLK_IGNORE_UNUSED flag to all the
> > > > > > > > > > > > uart root clocks and remove the prepare/enable calls for uart clocks
> > > > > > > > > > > > for good. I don't really have a way to test it right now, but maybe
> > > > > > > > > > > > you could give it a try.
> > > > > > > > > > >
> > > > > > > > > > > That would mean that UART clocks will never be disabled, regardless of
> > > > > > > > > > > whether they are used for console or not. That doesn't sound very
> > > > > > > > > > > appealing.
> > > > > > > > > >
> > > > > > > > > > AFAIK, the only uart clock that is enabled by u-boot is the one used for
> > > > > > > > > > the console. Later on, when the serial driver probes, it will enable it itself.
> > > > > > > > > >
> > > > > > > > > > Unless I'm missing something, this is exactly what we need.
> > > > > > > > >
> > > > > > > > > It might enable it, but with CLK_IGNORE_UNUSED the clock won't be
> > > > > > > > > disabled again when a port is closed after usage
> > > > > > > >
> > > > > > > > OK, tell me what I'm getting wrong in the following scenario:
> > > > > > > >
> > > > > > > > U-boot leaves the console uart clock enabled. All the other ones are disabled.
> > > > > > > >
> > > > > > > > Kernel i.MX clk driver registers the uart clocks with flag CLK_IGNORE_UNUSED.
> > > > > > >
> > > > > > > I was wrong at that point. I originally thought the kernel will never
> > > > > > > disable these clocks, but in fact it only leaves them enabled during the
> > > > > > > clk_disable_unused call.
> > > > > > >
> > > > > > > However, when CLK_IGNORE_UNUSED becomes relevant it's too late already.
> > > > > > > I just chatted with Lucas and he told me what the original problem was
> > > > > > > that his patch solved.
> > > > > > >
> > > > > > > The problem comes when an unrelated device and the earlycon UART have
> > > > > > > the same parent clocks. The parent clock is enabled, but it's reference
> > > > > > > count is zero. Now when the unrelated device probes and toggles its
> > > > > > > clocks then the shared parent clock will be disabled due to the
> > > > > > > reference count being zero. Next time earlycon prints a character the
> > > > > > > system hangs because the UART gates are still enabled, but their parent
> > > > > > > clocks no longer are.
> > > > > > >
> > > > > >
> > > > > > Hmm, that is indeed a problem. That's why I think there should be some
> > > > > > kind of NOCACHE flag for almost all the types of clocks. For example,
> > > > > > in this case, it makes sense for the core to check the bit in the register
> > > > > > and then disable the parent based on that instead of relying on the refcount.
> > > > > > Anyway, that's something that needs to be added in the CCF.
> > > > > >
> > > > > > > Overall I think Lucas' patches are still valid and relevant and with
> > > > > > > Adams patches we even no longer have to enable all UART clocks, but
> > > > > > > only the ones which are actually needed.
> > > > > >
> > > > > > Yeah, for now, I think we can go with Adam's patches. But longterm, I would
> > > > > > like to remove the special case of the uart clocks we have right now in all
> > > > > > the i.MX clock drivers.
> > > >
> > > > I looked around at other serial drivers, and I found nothing like this
> > > > function for enabling all UART clocks.  There are generic functions
> > > > for registering consoles, earlycon etc, and the serial driver fetches
> > > > the per and igp clocks from the device tree, so I attempted to simply
> > > > remove imx_register_uart_clocks().  I booted an i.MX8M Nano from a
> > > > fully-powered off state, and my serial console came up just fine.
> > >
> > > Just because it works, doesn't mean it is safe. To put it simply, the
> > > risk of some  driver disabling a clock that is parent of the uart clock
> > > would render the earlycon broken.
> > >
> > > >
> > > > I checked the clk_summary, and the clock parents are set correctly and
> > > > the respective clock rates appear to be correct (ie, the console is
> > > > working at the desired baud rate, and Bluetooth is happy)
> > > >
> > > > Since I don't fully understand the serial driver and the clock
> > > > dependencies, I don't want to just simply remove the function without
> > > > discussing it, because I don't know the ramifications.  However, when
> > > > testing on the i.MX8M Nano, things look OK.
> > > > I also tested suspend-resume and the console UART appears to return
> > > > and the Bluetooth UART set to 4Mbps works just fine too.
> > > >
> > > > I'd like to post a V4 which just removes imx_register_uart_clocks and
> > > > the corresponding calls to it.  I don't know enough about the older
> > > > 32-bit i.MX SoC's, but I have build-tested it, and I can generate a
> > > > patch. Are there any objections and/or concerns?
> > > >
> > >
> > > Please don't remove the imx_register_uart_clocks for now. As much as I
> > > would like it gone, the way the earlycon could end up broken is
> > > so ugly that it would make it a real pain to debug it later on.
> > 
> > I won't do a V4, but where do we go from here?  I have a V3 that was
> > waiting for reviews, but there were some concerns.  We currently
> > cannot re-parent the UART's on iMX8MM or iMX8MN.  Should I resend V3,
> > or are there fixes/changes requested to V3?
> > 
> 
> The v3 is fine. No need to resend.
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> 

Please add Ahmad's suggestion and resend.

I'll pick it up then.

Thanks,
Abel

> > adam
> > >
> > > > adam
> > > > > >
> > > > >
> > > > > Is the patch I submitted good enough for someone's acked-by or
> > > > > reviewed-by, or are there changes I need to implement?
> > > > >
> > > > > adam
> > > > >
> > > > > > >
> > > > > > > Sascha
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Pengutronix e.K.                           |                             |
> > > > > > > Steuerwalder Str. 21                       | https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutronix.de%2F&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C900fb6f7dfdf49776eb208d8ddadd7b7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637503086023262296%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ulZnxvilARLN03%2BEr%2BTKmVOPxRTukN%2FDg3oPY8UJ2AU%3D&amp;reserved=0  |
> > > > > > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
