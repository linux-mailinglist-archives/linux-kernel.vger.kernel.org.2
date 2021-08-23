Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F733F4BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhHWNwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:52:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98147C061575;
        Mon, 23 Aug 2021 06:51:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e129so10257429yba.5;
        Mon, 23 Aug 2021 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZhYHB4tMEpT9nyCy2lajgzuO2mjD/4shd9z7TFVbm0=;
        b=ZcFUmc3krThb/6+EZprLAxDJPxfSuCJuDHRqbaab5n2HQ50E48YSWYz/EFcz1Apmur
         N82y2uo+LA1R98xD/OFsoO/QBCDNLNrc9H1X+GR+UfeXxW4VLqKjFA1XDaNB5ECymcLJ
         R0Is/oNQiaBl6Lw9hk/GhE5TQE5AEo8rNw3UnnYA8cDZBaLFPP3jf3L3ba5O+D4/BJMC
         wv1zE3JRmTxBbeA9akqFWE4oG/y3wa5h53LtWRrU/pRDMhkNmGI5SR0VakktpidNZ9SK
         NuFNO6c7Ub/KF63S13lyXz5ou0yYhHkgl+RlWx28+/4sOr0P3WHazEJ1ICsGFAqwiXEU
         hmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZhYHB4tMEpT9nyCy2lajgzuO2mjD/4shd9z7TFVbm0=;
        b=fU+J2sftKT104oc8V7tttdVQqNhzzhn6knkuJrNGuo27/hm5cUkf8hxyUKHCv65oVl
         k6HUOeqJILOYoifX4WPBmMn7hhJ/Vp5+W+ujkcaNhv4vuilhcvVI9B6PuLx0WzAFjgEJ
         EoPXtj4A8VBEdRfqlGMJ2Sl4fuSOyMGypVuaN3Fhl52jUlqegDXIkzOuK/k7I/7ee7pC
         ZK6z1czQlfdN8VXWkdbFLH9Tq8Y1dJk/jcf/d8evQLcWSVC2xqP3//fdr6ZlfPNfJMAa
         1+RR9V6sWEzHLaybEJ9KL7GwMCFhTJGIQ9uPzWQDFZTE9rbNJPDYzRSLA8CnxRbqcH4a
         Nsgw==
X-Gm-Message-State: AOAM5304vV6AcUxz+aQJOr3B4d+oX9Xc4xfQJpnG0RkaOR1ZZL7VSV+c
        WwHAyLSyTcUZgQEDM4zurDWgucm4jI/5OiPH8GA=
X-Google-Smtp-Source: ABdhPJwbzYAlgqaeXjpyad5IkypuCMCkEkvHVUknY0I2lNuGumSfPJXTFYPPvxOUHgEGc9R2DeEcqMk808EK5AJYsNU=
X-Received: by 2002:a25:1f46:: with SMTP id f67mr44609679ybf.259.1629726704890;
 Mon, 23 Aug 2021 06:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123911.12095-1-michael.riesch@wolfvision.net>
 <20210823123911.12095-2-michael.riesch@wolfvision.net> <CAMdYzYr4ZTXvfJaeMejuRHBkBAVKcEUseskhEVqLMSYR+Dv4uw@mail.gmail.com>
 <426f77fb-f0ca-9431-45e4-66b885516c76@wolfvision.net>
In-Reply-To: <426f77fb-f0ca-9431-45e4-66b885516c76@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 23 Aug 2021 09:51:33 -0400
Message-ID: <CAMdYzYpSHkW3NDztmw=CUbYbqQFP+qYdavr6AQZfxwmWJ4eYAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: add missing rockchip,grf
 property to rk356x
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 9:39 AM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Peter,
>
> On 8/23/21 3:12 PM, Peter Geis wrote:
> > On Mon, Aug 23, 2021 at 8:39 AM Michael Riesch
> > <michael.riesch@wolfvision.net> wrote:
> >>
> >> This commit fixes the error messages
> >>
> >>   rockchip_clk_register_muxgrf: regmap not available
> >>   rockchip_clk_register_branches: failed to register clock clk_ddr1x: -524
> >>
> >> during boot by providing the missing rockchip,grf property.
> >
> > Good Morning,
> >
> > This was fixed by commit: 6fffe52fb336 clk: rockchip: drop GRF
> > dependency for rk3328/rk3036 pll types
> > which was merged in -next. I don't believe it's going to be backported
> > to 5.14 due to 5.14 not being able to fully boot.
>
> Unfortunately not, I am afraid. I am working on Heiko's current -next
> and the commit you mentioned is present. Nevertheless I got these error
> messages.
>
> They can be traced down to "rockchip_clk_register_muxgrf", which fails
> as the passed argument regmap is invalid due to the missing device tree
> property. The clock "clk_ddr1x" is added in clk-rk3568.c as "MUXGRF",
> which leads me to believe that the grf property is actually required.

Ah, yes it seems you are correct.
I had inadvertently fixed this a while ago in my own tree.
Confirmed without the GRF ddr1x clk doesn't register.

Tested-by: Peter Geis <pgwipeout@gmail.com>

On a related note, are you planning on working on the DVFS driver,
since it will be the only consumer of this clock?

>
> Best regards,
> Michael
>
> >
> > Very Respectfully,
> > Peter Geis
> >
> >>
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> index 23949e79d8ce..0a1d07c96b2e 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> >> @@ -233,6 +233,7 @@
> >>                 #reset-cells = <1>;
> >>                 assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>;
> >>                 assigned-clock-rates = <1200000000>, <200000000>;
> >> +               rockchip,grf = <&grf>;
> >>         };
> >>
> >>         i2c0: i2c@fdd40000 {
> >> --
> >> 2.17.1
> >>
