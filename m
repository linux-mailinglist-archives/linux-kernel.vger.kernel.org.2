Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF130E4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBCVXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhBCVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:23:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC97C061573;
        Wed,  3 Feb 2021 13:22:24 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c132so634941pga.3;
        Wed, 03 Feb 2021 13:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TFiTJoFvlaFYID17H7RoHT6hcb6k7KOcxSeH2rq/fng=;
        b=S1+9liQomwOL0dXTpJHZjK/3oCEze3UJv+GhpjQfT53/WCm+1QLAiYD6gNA9QvXLGH
         ez4lex81vs1tLNWL9qmUSHSJm0H3tU2JaAHyLyJK+N9PRQkX1qh7rEPaYys7dOmRIkFX
         p7zfiVsdxELZNyra/FGwYVWcDHmp1iMuEDlKlDmvBF36RrMN5mi66FJyDa6V85wjA56l
         P2weCJ1tTmdLehCZE2s1HG2KdhneoXqQvg6kGqHc5BEJYi7Ot1fvQtKaNTIwzriKG4bn
         7qPqyZNzhEjZQ1V146lWvx9H6Ur5fmU+w3Ow/tX7ct74iug0ArEzKOm5YxUWlL5nuBdS
         kopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TFiTJoFvlaFYID17H7RoHT6hcb6k7KOcxSeH2rq/fng=;
        b=d7PGzy/blhDQ+slZXCN/nTLP7FqOX1mVygrJiF+Vr2/A3PysK0ixN6+uGd0jpfJJjs
         NDs6SWlyU+EIf+Btu4d4RTk0aSKyrdc7Blu0zZ0fXU9/x/vKv5AdzPDEEt4Tk/4VyOQc
         tllDtmawT+6t+i7e3DfpHikwF93SOvk+AQ2WKXX2sAkLj1N4kQ6uyeTQ2WcbWPu9uGHT
         6fTCu3awxwcUFT9GjLOfWInk/Ce+1XGfigNp7N7DikqKNnhdx3irWRJBo29R7yHgQ3P0
         5rFGSFt5Xbup3FsI4ygRq5ujCCwRigc9YflWbouN6ItkSmEOBBbmGzzzyrMewrl/YQSC
         UiwA==
X-Gm-Message-State: AOAM53306wUP5JcKifSLqnINGdnSIAmCg1Q3NlL0uhsYLQtY+jwC8GBf
        eiPEYM6Px1zjNT9GrtZuk+BycFLq8u/gKtVbCQI=
X-Google-Smtp-Source: ABdhPJyjgKLsLDMiQKZhm/3dUiduA5WUTzetwtwlYpTEeR8ore5ECpNZtOPlRKLdoPELwntqIfz2g0Bok48UDCWCVGA=
X-Received: by 2002:a62:2ac3:0:b029:1bc:4287:c0b3 with SMTP id
 q186-20020a622ac30000b02901bc4287c0b3mr4790030pfq.26.1612387343663; Wed, 03
 Feb 2021 13:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20210115182909.314756-1-aford173@gmail.com> <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
 <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
 <20210120144454.f6b72lnasw4q3bde@fsr-ub1664-175> <20210120151305.GC19063@pengutronix.de>
 <20210120152813.x2pbs5vprevkly23@fsr-ub1664-175> <20210120155001.GD19063@pengutronix.de>
 <20210120161421.h3yng57m3fetwwih@fsr-ub1664-175> <20210121095617.GI19063@pengutronix.de>
 <20210121102450.lisl3mzqczdsmzda@fsr-ub1664-175>
In-Reply-To: <20210121102450.lisl3mzqczdsmzda@fsr-ub1664-175>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 3 Feb 2021 15:22:12 -0600
Message-ID: <CAHCN7x+eMHncRya3KWm5g=stzVf0fzNojS5mFxwvGW-sVoLsYQ@mail.gmail.com>
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

On Thu, Jan 21, 2021 at 4:24 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On 21-01-21 10:56:17, Sascha Hauer wrote:
> > On Wed, Jan 20, 2021 at 06:14:21PM +0200, Abel Vesa wrote:
> > > On 21-01-20 16:50:01, Sascha Hauer wrote:
> > > > On Wed, Jan 20, 2021 at 05:28:13PM +0200, Abel Vesa wrote:
> > > > > On 21-01-20 16:13:05, Sascha Hauer wrote:
> > > > > > Hi Abel,
> > > > > >
> > > > > > On Wed, Jan 20, 2021 at 04:44:54PM +0200, Abel Vesa wrote:
> > > > > > > On 21-01-18 08:00:43, Adam Ford wrote:
> > > > > > > > On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.co=
m> wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > TBH, I'm against the idea of having to call consumer API =
from a clock provider driver.
> > > > > > > > > I'm still investigating a way of moving the uart clock co=
ntrol calls in drivers/serial/imx,
> > > > > > > > > where they belong.
> > > > > > > >
> > > > > > > > That makes sense.
> > > > > > > >
> > > > > > >
> > > > > > > Just a thought. The uart clock used for console remains on fr=
om u-boot,
> > > > > > > so maybe it's enough to just add the CLK_IGNORE_UNUSED flag t=
o all the
> > > > > > > uart root clocks and remove the prepare/enable calls for uart=
 clocks
> > > > > > > for good. I don't really have a way to test it right now, but=
 maybe
> > > > > > > you could give it a try.
> > > > > >
> > > > > > That would mean that UART clocks will never be disabled, regard=
less of
> > > > > > whether they are used for console or not. That doesn't sound ve=
ry
> > > > > > appealing.
> > > > >
> > > > > AFAIK, the only uart clock that is enabled by u-boot is the one u=
sed for
> > > > > the console. Later on, when the serial driver probes, it will ena=
ble it itself.
> > > > >
> > > > > Unless I'm missing something, this is exactly what we need.
> > > >
> > > > It might enable it, but with CLK_IGNORE_UNUSED the clock won't be
> > > > disabled again when a port is closed after usage
> > >
> > > OK, tell me what I'm getting wrong in the following scenario:
> > >
> > > U-boot leaves the console uart clock enabled. All the other ones are =
disabled.
> > >
> > > Kernel i.MX clk driver registers the uart clocks with flag CLK_IGNORE=
_UNUSED.
> >
> > I was wrong at that point. I originally thought the kernel will never
> > disable these clocks, but in fact it only leaves them enabled during th=
e
> > clk_disable_unused call.
> >
> > However, when CLK_IGNORE_UNUSED becomes relevant it's too late already.
> > I just chatted with Lucas and he told me what the original problem was
> > that his patch solved.
> >
> > The problem comes when an unrelated device and the earlycon UART have
> > the same parent clocks. The parent clock is enabled, but it's reference
> > count is zero. Now when the unrelated device probes and toggles its
> > clocks then the shared parent clock will be disabled due to the
> > reference count being zero. Next time earlycon prints a character the
> > system hangs because the UART gates are still enabled, but their parent
> > clocks no longer are.
> >
>
> Hmm, that is indeed a problem. That's why I think there should be some
> kind of NOCACHE flag for almost all the types of clocks. For example,
> in this case, it makes sense for the core to check the bit in the registe=
r
> and then disable the parent based on that instead of relying on the refco=
unt.
> Anyway, that's something that needs to be added in the CCF.
>
> > Overall I think Lucas' patches are still valid and relevant and with
> > Adams patches we even no longer have to enable all UART clocks, but
> > only the ones which are actually needed.
>
> Yeah, for now, I think we can go with Adam's patches. But longterm, I wou=
ld
> like to remove the special case of the uart clocks we have right now in a=
ll
> the i.MX clock drivers.
>

Is the patch I submitted good enough for someone's acked-by or
reviewed-by, or are there changes I need to implement?

adam

> >
> > Sascha
> >
> >
> > --
> > Pengutronix e.K.                           |                           =
  |
> > Steuerwalder Str. 21                       | https://eur01.safelinks.pr=
otection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pengutronix.de%2F&amp;data=3D0=
4%7C01%7Cabel.vesa%40nxp.com%7Ceed68987c68f4aeaa63408d8bdf2d051%7C686ea1d3b=
c2b4c6fa92cd99c5c301635%7C0%7C0%7C637468197861821302%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;sdata=3DX1J8KgxFquNin80zKVz0Ao22vv1MuTMWf91BUTczh9Y%3D&amp;reserved=3D=
0  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
