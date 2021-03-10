Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15A5334BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhCJWoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhCJWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:43:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9DC061574;
        Wed, 10 Mar 2021 14:43:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x7so9705346pfi.7;
        Wed, 10 Mar 2021 14:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bwrhIWvuCyPUqA19zbMYRHAdlCdbeAUuN+CsJqbOQv0=;
        b=kRDEIBh+lQkE5kmFar5i8MTsKZ2QhFKC/304ya3oVAQ2mS+G7wBLqQBMGDlg5StUl1
         ePXcmu0c3JIdGaPVTXUMZJGKMZXSvkifMYL63tQA7OP6Cb2GkzYPFsVWzOQIq7Etrtdb
         7lXpT/7Mrt7aczeMBbnC4VZBGmsYuNQ7jo81Py/rMMNDyWS9J2ohebYYKdCwlnWyH3uH
         aQ8Ho54m1/oVeQfu0CObuFyxeywl3m2i1JLA8Y36ie2Xz3kJpsaBazYgae4k/FPmRBOK
         kkcI2z0yY+iUb42MSwqR0iMBk00uT7Clv7sYJuQ7lH6mN81GcKIah580e8AOa7/ylv3l
         mJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bwrhIWvuCyPUqA19zbMYRHAdlCdbeAUuN+CsJqbOQv0=;
        b=WTbSUAJbIkCuqNDXnq1zYM0AeXLXIpenoSMmzC3UuAApW2NhatLo2n21ikEjXPkEdH
         v9UC7LfCzfYFfHZYvqKP9rMBrowjIV+sAZPVK8tEgqyKZ0j/Q1WZHH5ztxb26ycLHwJ0
         bIIfq34mo8+y60y3jpQkGKqHkIIln1Y1Iru+MpcVe8f73xVnmV0I7DeVPDfKaxSwVpPV
         YgDY5CtLr63gLROcU0+1Ka77l+A9agmcSPvRmnBNRWoPWh8XZTFCxrdgvrP7Z2zM4Ftg
         PLKaazzeFAZr6PQqxNh+huTrk17mVaFXiLjlXcYyT6OFX64rIA+UD0NWAmdIGvmeCN/I
         M3sA==
X-Gm-Message-State: AOAM532elvaLOXQzOGG90ASewlR0RF0P0RPwNW01/MbE7wuCXvNOOGOa
        jbib8ZR0Sd4koXdt/eHcpCtysF47Jf30PsZcxJw=
X-Google-Smtp-Source: ABdhPJwxcr8VOckkpTz7GvCtJag+Yb79XB2ukkd8gKDHVAO09UTwIA+EtYX+1bdWF2aSWSJ8snDzShTxv+bNccW3Ajs=
X-Received: by 2002:a05:6a00:ad1:b029:1ec:c826:55aa with SMTP id
 c17-20020a056a000ad1b02901ecc82655aamr4741276pfl.26.1615416230407; Wed, 10
 Mar 2021 14:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20210120152813.x2pbs5vprevkly23@fsr-ub1664-175>
 <20210120155001.GD19063@pengutronix.de> <20210120161421.h3yng57m3fetwwih@fsr-ub1664-175>
 <20210121095617.GI19063@pengutronix.de> <20210121102450.lisl3mzqczdsmzda@fsr-ub1664-175>
 <CAHCN7x+eMHncRya3KWm5g=stzVf0fzNojS5mFxwvGW-sVoLsYQ@mail.gmail.com>
 <CAHCN7xLc6dnkA5Fw4cC1_nDG3KrrR4AffUzy-8gG4UKLn-rhzQ@mail.gmail.com>
 <20210215130620.3la4bexamozzcvjx@fsr-ub1664-175> <CAHCN7xK1rWkDK6JE6MvN1UoV0b3Z5dQjeWZDNgnZHRwD1XkuZQ@mail.gmail.com>
 <20210303083119.wadme5a7j4zf7vuz@fsr-ub1664-175> <YElHOV3FghXhld8A@ryzen.lan>
In-Reply-To: <YElHOV3FghXhld8A@ryzen.lan>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 10 Mar 2021 16:43:39 -0600
Message-ID: <CAHCN7xLQMeLO-5Wdf1sQo0oTzx83LwiogxM_g_0k_+vC=Av-=g@mail.gmail.com>
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated with sdout
To:     Abel Vesa <abelvesa@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 4:25 PM Abel Vesa <abelvesa@kernel.org> wrote:
>
> On 21-03-03 10:31:19, Abel Vesa wrote:
> > On 21-03-02 13:03:04, Adam Ford wrote:
> > > On Mon, Feb 15, 2021 at 7:06 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > > >
> > > > On 21-02-13 08:44:28, Adam Ford wrote:
> > > > > On Wed, Feb 3, 2021 at 3:22 PM Adam Ford <aford173@gmail.com> wro=
te:
> > > > > >
> > > > > > On Thu, Jan 21, 2021 at 4:24 AM Abel Vesa <abel.vesa@nxp.com> w=
rote:
> > > > > > >
> > > > > > > On 21-01-21 10:56:17, Sascha Hauer wrote:
> > > > > > > > On Wed, Jan 20, 2021 at 06:14:21PM +0200, Abel Vesa wrote:
> > > > > > > > > On 21-01-20 16:50:01, Sascha Hauer wrote:
> > > > > > > > > > On Wed, Jan 20, 2021 at 05:28:13PM +0200, Abel Vesa wro=
te:
> > > > > > > > > > > On 21-01-20 16:13:05, Sascha Hauer wrote:
> > > > > > > > > > > > Hi Abel,
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Jan 20, 2021 at 04:44:54PM +0200, Abel Vesa=
 wrote:
> > > > > > > > > > > > > On 21-01-18 08:00:43, Adam Ford wrote:
> > > > > > > > > > > > > > On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel=
.vesa@nxp.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > ...
> > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > TBH, I'm against the idea of having to call c=
onsumer API from a clock provider driver.
> > > > > > > > > > > > > > > I'm still investigating a way of moving the u=
art clock control calls in drivers/serial/imx,
> > > > > > > > > > > > > > > where they belong.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > That makes sense.
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Just a thought. The uart clock used for console r=
emains on from u-boot,
> > > > > > > > > > > > > so maybe it's enough to just add the CLK_IGNORE_U=
NUSED flag to all the
> > > > > > > > > > > > > uart root clocks and remove the prepare/enable ca=
lls for uart clocks
> > > > > > > > > > > > > for good. I don't really have a way to test it ri=
ght now, but maybe
> > > > > > > > > > > > > you could give it a try.
> > > > > > > > > > > >
> > > > > > > > > > > > That would mean that UART clocks will never be disa=
bled, regardless of
> > > > > > > > > > > > whether they are used for console or not. That does=
n't sound very
> > > > > > > > > > > > appealing.
> > > > > > > > > > >
> > > > > > > > > > > AFAIK, the only uart clock that is enabled by u-boot =
is the one used for
> > > > > > > > > > > the console. Later on, when the serial driver probes,=
 it will enable it itself.
> > > > > > > > > > >
> > > > > > > > > > > Unless I'm missing something, this is exactly what we=
 need.
> > > > > > > > > >
> > > > > > > > > > It might enable it, but with CLK_IGNORE_UNUSED the cloc=
k won't be
> > > > > > > > > > disabled again when a port is closed after usage
> > > > > > > > >
> > > > > > > > > OK, tell me what I'm getting wrong in the following scena=
rio:
> > > > > > > > >
> > > > > > > > > U-boot leaves the console uart clock enabled. All the oth=
er ones are disabled.
> > > > > > > > >
> > > > > > > > > Kernel i.MX clk driver registers the uart clocks with fla=
g CLK_IGNORE_UNUSED.
> > > > > > > >
> > > > > > > > I was wrong at that point. I originally thought the kernel =
will never
> > > > > > > > disable these clocks, but in fact it only leaves them enabl=
ed during the
> > > > > > > > clk_disable_unused call.
> > > > > > > >
> > > > > > > > However, when CLK_IGNORE_UNUSED becomes relevant it's too l=
ate already.
> > > > > > > > I just chatted with Lucas and he told me what the original =
problem was
> > > > > > > > that his patch solved.
> > > > > > > >
> > > > > > > > The problem comes when an unrelated device and the earlycon=
 UART have
> > > > > > > > the same parent clocks. The parent clock is enabled, but it=
's reference
> > > > > > > > count is zero. Now when the unrelated device probes and tog=
gles its
> > > > > > > > clocks then the shared parent clock will be disabled due to=
 the
> > > > > > > > reference count being zero. Next time earlycon prints a cha=
racter the
> > > > > > > > system hangs because the UART gates are still enabled, but =
their parent
> > > > > > > > clocks no longer are.
> > > > > > > >
> > > > > > >
> > > > > > > Hmm, that is indeed a problem. That's why I think there shoul=
d be some
> > > > > > > kind of NOCACHE flag for almost all the types of clocks. For =
example,
> > > > > > > in this case, it makes sense for the core to check the bit in=
 the register
> > > > > > > and then disable the parent based on that instead of relying =
on the refcount.
> > > > > > > Anyway, that's something that needs to be added in the CCF.
> > > > > > >
> > > > > > > > Overall I think Lucas' patches are still valid and relevant=
 and with
> > > > > > > > Adams patches we even no longer have to enable all UART clo=
cks, but
> > > > > > > > only the ones which are actually needed.
> > > > > > >
> > > > > > > Yeah, for now, I think we can go with Adam's patches. But lon=
gterm, I would
> > > > > > > like to remove the special case of the uart clocks we have ri=
ght now in all
> > > > > > > the i.MX clock drivers.
> > > > >
> > > > > I looked around at other serial drivers, and I found nothing like=
 this
> > > > > function for enabling all UART clocks.  There are generic functio=
ns
> > > > > for registering consoles, earlycon etc, and the serial driver fet=
ches
> > > > > the per and igp clocks from the device tree, so I attempted to si=
mply
> > > > > remove imx_register_uart_clocks().  I booted an i.MX8M Nano from =
a
> > > > > fully-powered off state, and my serial console came up just fine.
> > > >
> > > > Just because it works, doesn't mean it is safe. To put it simply, t=
he
> > > > risk of some  driver disabling a clock that is parent of the uart c=
lock
> > > > would render the earlycon broken.
> > > >
> > > > >
> > > > > I checked the clk_summary, and the clock parents are set correctl=
y and
> > > > > the respective clock rates appear to be correct (ie, the console =
is
> > > > > working at the desired baud rate, and Bluetooth is happy)
> > > > >
> > > > > Since I don't fully understand the serial driver and the clock
> > > > > dependencies, I don't want to just simply remove the function wit=
hout
> > > > > discussing it, because I don't know the ramifications.  However, =
when
> > > > > testing on the i.MX8M Nano, things look OK.
> > > > > I also tested suspend-resume and the console UART appears to retu=
rn
> > > > > and the Bluetooth UART set to 4Mbps works just fine too.
> > > > >
> > > > > I'd like to post a V4 which just removes imx_register_uart_clocks=
 and
> > > > > the corresponding calls to it.  I don't know enough about the old=
er
> > > > > 32-bit i.MX SoC's, but I have build-tested it, and I can generate=
 a
> > > > > patch. Are there any objections and/or concerns?
> > > > >
> > > >
> > > > Please don't remove the imx_register_uart_clocks for now. As much a=
s I
> > > > would like it gone, the way the earlycon could end up broken is
> > > > so ugly that it would make it a real pain to debug it later on.
> > >
> > > I won't do a V4, but where do we go from here?  I have a V3 that was
> > > waiting for reviews, but there were some concerns.  We currently
> > > cannot re-parent the UART's on iMX8MM or iMX8MN.  Should I resend V3,
> > > or are there fixes/changes requested to V3?
> > >
> >
> > The v3 is fine. No need to resend.
> >
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> >
>
> Please add Ahmad's suggestion and resend.

Sorry, I have a backlog. I am hoping to get to it this week.  Thanks
for the reminder.

adam
>
> I'll pick it up then.
>
> Thanks,
> Abel
>
> > > adam
> > > >
> > > > > adam
> > > > > > >
> > > > > >
> > > > > > Is the patch I submitted good enough for someone's acked-by or
> > > > > > reviewed-by, or are there changes I need to implement?
> > > > > >
> > > > > > adam
> > > > > >
> > > > > > > >
> > > > > > > > Sascha
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Pengutronix e.K.                           |               =
              |
> > > > > > > > Steuerwalder Str. 21                       | https://eur01.=
safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pengutronix.de%2F&=
amp;data=3D04%7C01%7Cabel.vesa%40nxp.com%7C900fb6f7dfdf49776eb208d8ddadd7b7=
%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637503086023262296%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;sdata=3DulZnxvilARLN03%2BEr%2BTKmVOPxRTukN%2FDg3oPY8UJ2AU%=
3D&amp;reserved=3D0  |
> > > > > > > > 31137 Hildesheim, Germany                  | Phone: +49-512=
1-206917-0    |
> > > > > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-512=
1-206917-5555 |
