Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1867B31AC63
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 15:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBMOp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 09:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMOpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 09:45:21 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D3AC061574;
        Sat, 13 Feb 2021 06:44:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nm1so1225594pjb.3;
        Sat, 13 Feb 2021 06:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Clxbg1NQpCvPFEarfm0To7I3vKJpGaiNXI2i281I7Rw=;
        b=W+dBEZlCNadlIzeZWv/YGZQTDie+YXuykOE/f8tiy8//PRkmN87eWg+diFlAJbsPLo
         AP++b0SbrQlNMirtgKoBAb0xGfTPNSRLVrMD7wo9G7szbfObmqhdx22r28xwZ7K39vqk
         ROEkUiopqVPELhcL/3eVUfHcg0aE4ZeX3OD572QovE7YeO+8Lc9tQN3Ani+jrhnObgDR
         AzcJuQJxJ93TSEiWsErfTj9A/nqRdDB35HGO4wEZYa+lU955pw0nfCenmEktF4bOJhGQ
         vtqfXgO9uVwi9pzO9H/016J0JSROUyUY8SqIQWMtK/g0ORYWR/ECDVgrFpSWKJ9WPfGi
         deiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Clxbg1NQpCvPFEarfm0To7I3vKJpGaiNXI2i281I7Rw=;
        b=hcM8IOXliE883OkIdjbgHqi5vhXzZ9NwPIzb7giziN/wD6TTG0ocRvQtLRiodZT3Yv
         qEIcZ70tU/JL7Gx03+5PEkqJJiXCbrvPxMm8WAfhiQ7hj7kSFihg7TvystTxUZ3FHLBy
         XrLDNJq9jfCI4j38dtgg0zyvMj5YHV9Ep4TUO/KIyexHLSN6CUkpSNWp5N6vZIF9Vbm3
         mjrrLgNrrxMpsPtPKD6o2cZ0YsX9Mg9st/l31b82BTuZa8ngTtFjVySE6alRNHmFredK
         mbs7xSm8Ze+dZBReOHk891uE+8kdEO/rmkSK52aG1rMLuiKPRJD1kjv/tNUfk6FxVhV0
         9ocw==
X-Gm-Message-State: AOAM531rprX1W2pyqNsAwdGn57ot/MEvi1fWu6fFJY2w0ArSYoa/nNDN
        GrKAqaWe4gkqKGO/X9DlBACK9kkSKuWXgcZANRQ=
X-Google-Smtp-Source: ABdhPJyQflbftXv7GvNOE5gtCApEhN+4XtEadPJAB7B+KQGWan+Nt0DGjVri0hbD2Rw4pX1dzBL2Sg3Z7TBjUNm1Ru4=
X-Received: by 2002:a17:90a:9f96:: with SMTP id o22mr2524278pjp.119.1613227479289;
 Sat, 13 Feb 2021 06:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20210115182909.314756-1-aford173@gmail.com> <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
 <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
 <20210120144454.f6b72lnasw4q3bde@fsr-ub1664-175> <20210120151305.GC19063@pengutronix.de>
 <20210120152813.x2pbs5vprevkly23@fsr-ub1664-175> <20210120155001.GD19063@pengutronix.de>
 <20210120161421.h3yng57m3fetwwih@fsr-ub1664-175> <20210121095617.GI19063@pengutronix.de>
 <20210121102450.lisl3mzqczdsmzda@fsr-ub1664-175> <CAHCN7x+eMHncRya3KWm5g=stzVf0fzNojS5mFxwvGW-sVoLsYQ@mail.gmail.com>
In-Reply-To: <CAHCN7x+eMHncRya3KWm5g=stzVf0fzNojS5mFxwvGW-sVoLsYQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 13 Feb 2021 08:44:28 -0600
Message-ID: <CAHCN7xLc6dnkA5Fw4cC1_nDG3KrrR4AffUzy-8gG4UKLn-rhzQ@mail.gmail.com>
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated with sdout
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 3:22 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 4:24 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > On 21-01-21 10:56:17, Sascha Hauer wrote:
> > > On Wed, Jan 20, 2021 at 06:14:21PM +0200, Abel Vesa wrote:
> > > > On 21-01-20 16:50:01, Sascha Hauer wrote:
> > > > > On Wed, Jan 20, 2021 at 05:28:13PM +0200, Abel Vesa wrote:
> > > > > > On 21-01-20 16:13:05, Sascha Hauer wrote:
> > > > > > > Hi Abel,
> > > > > > >
> > > > > > > On Wed, Jan 20, 2021 at 04:44:54PM +0200, Abel Vesa wrote:
> > > > > > > > On 21-01-18 08:00:43, Adam Ford wrote:
> > > > > > > > > On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.=
com> wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > TBH, I'm against the idea of having to call consumer AP=
I from a clock provider driver.
> > > > > > > > > > I'm still investigating a way of moving the uart clock =
control calls in drivers/serial/imx,
> > > > > > > > > > where they belong.
> > > > > > > > >
> > > > > > > > > That makes sense.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Just a thought. The uart clock used for console remains on =
from u-boot,
> > > > > > > > so maybe it's enough to just add the CLK_IGNORE_UNUSED flag=
 to all the
> > > > > > > > uart root clocks and remove the prepare/enable calls for ua=
rt clocks
> > > > > > > > for good. I don't really have a way to test it right now, b=
ut maybe
> > > > > > > > you could give it a try.
> > > > > > >
> > > > > > > That would mean that UART clocks will never be disabled, rega=
rdless of
> > > > > > > whether they are used for console or not. That doesn't sound =
very
> > > > > > > appealing.
> > > > > >
> > > > > > AFAIK, the only uart clock that is enabled by u-boot is the one=
 used for
> > > > > > the console. Later on, when the serial driver probes, it will e=
nable it itself.
> > > > > >
> > > > > > Unless I'm missing something, this is exactly what we need.
> > > > >
> > > > > It might enable it, but with CLK_IGNORE_UNUSED the clock won't be
> > > > > disabled again when a port is closed after usage
> > > >
> > > > OK, tell me what I'm getting wrong in the following scenario:
> > > >
> > > > U-boot leaves the console uart clock enabled. All the other ones ar=
e disabled.
> > > >
> > > > Kernel i.MX clk driver registers the uart clocks with flag CLK_IGNO=
RE_UNUSED.
> > >
> > > I was wrong at that point. I originally thought the kernel will never
> > > disable these clocks, but in fact it only leaves them enabled during =
the
> > > clk_disable_unused call.
> > >
> > > However, when CLK_IGNORE_UNUSED becomes relevant it's too late alread=
y.
> > > I just chatted with Lucas and he told me what the original problem wa=
s
> > > that his patch solved.
> > >
> > > The problem comes when an unrelated device and the earlycon UART have
> > > the same parent clocks. The parent clock is enabled, but it's referen=
ce
> > > count is zero. Now when the unrelated device probes and toggles its
> > > clocks then the shared parent clock will be disabled due to the
> > > reference count being zero. Next time earlycon prints a character the
> > > system hangs because the UART gates are still enabled, but their pare=
nt
> > > clocks no longer are.
> > >
> >
> > Hmm, that is indeed a problem. That's why I think there should be some
> > kind of NOCACHE flag for almost all the types of clocks. For example,
> > in this case, it makes sense for the core to check the bit in the regis=
ter
> > and then disable the parent based on that instead of relying on the ref=
count.
> > Anyway, that's something that needs to be added in the CCF.
> >
> > > Overall I think Lucas' patches are still valid and relevant and with
> > > Adams patches we even no longer have to enable all UART clocks, but
> > > only the ones which are actually needed.
> >
> > Yeah, for now, I think we can go with Adam's patches. But longterm, I w=
ould
> > like to remove the special case of the uart clocks we have right now in=
 all
> > the i.MX clock drivers.

I looked around at other serial drivers, and I found nothing like this
function for enabling all UART clocks.  There are generic functions
for registering consoles, earlycon etc, and the serial driver fetches
the per and igp clocks from the device tree, so I attempted to simply
remove imx_register_uart_clocks().  I booted an i.MX8M Nano from a
fully-powered off state, and my serial console came up just fine.

I checked the clk_summary, and the clock parents are set correctly and
the respective clock rates appear to be correct (ie, the console is
working at the desired baud rate, and Bluetooth is happy)

Since I don't fully understand the serial driver and the clock
dependencies, I don't want to just simply remove the function without
discussing it, because I don't know the ramifications.  However, when
testing on the i.MX8M Nano, things look OK.
I also tested suspend-resume and the console UART appears to return
and the Bluetooth UART set to 4Mbps works just fine too.

I'd like to post a V4 which just removes imx_register_uart_clocks and
the corresponding calls to it.  I don't know enough about the older
32-bit i.MX SoC's, but I have build-tested it, and I can generate a
patch. Are there any objections and/or concerns?

adam
> >
>
> Is the patch I submitted good enough for someone's acked-by or
> reviewed-by, or are there changes I need to implement?
>
> adam
>
> > >
> > > Sascha
> > >
> > >
> > > --
> > > Pengutronix e.K.                           |                         =
    |
> > > Steuerwalder Str. 21                       | https://eur01.safelinks.=
protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pengutronix.de%2F&amp;data=
=3D04%7C01%7Cabel.vesa%40nxp.com%7Ceed68987c68f4aeaa63408d8bdf2d051%7C686ea=
1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637468197861821302%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;sdata=3DX1J8KgxFquNin80zKVz0Ao22vv1MuTMWf91BUTczh9Y%3D&amp;reserve=
d=3D0  |
> > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0=
    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5=
555 |
