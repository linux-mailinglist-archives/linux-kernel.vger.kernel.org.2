Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA480350641
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhCaSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhCaSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:23:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7FC061574;
        Wed, 31 Mar 2021 11:23:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ap14so18349862ejc.0;
        Wed, 31 Mar 2021 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ug3SVXcNR37BgCnfiRtWS4In3Xxjb/i1hF4FtZIIqDg=;
        b=Fy/05X7da9xwNzXZyOi1EQk5CUX9uvv7Q5uSd03F2RhOcT+xPIH3TaZsN38mRFFsUB
         ahEnirckKFpkFxvD+zywBg61S42Q9ASlgCyqVg7/bxRXlmBwviqAA6YbZbAKyIvNdaRw
         flav0WBeiJ4q06e3IzsaU2GIvPSuJOjTce35YbIbMLGrghumQ2D1a57BkVPQWXPV/Y20
         QO+xvhMqbvSyEyZlZDynscSURicMTrbcIQRoEiTt5EiIpjJXRcMqxIOMTkjfrJbXydOj
         53xSqify+sc50/viWs4/pNTbOdTDPp0AilFcOOdzFP/FWtY2+SZdSw28s/5ZvCu8GkCt
         e2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ug3SVXcNR37BgCnfiRtWS4In3Xxjb/i1hF4FtZIIqDg=;
        b=oA4xMvJNQNLHDeLvtv3tIKgLMCKo9qXz1UhkJkYQiUSYfUn8JsKwIH16emawLEwsPb
         wfM3h6QRl2geSnY/m5dQss9RShwfEWKjpIApkUpfSfNsL9TGMiRYySF/b4eU2ULIiO0m
         cSW7zrrLB5nRaq1cTFG9BI3+O8NYPHhSm+HlnflCFmxVvoGtp6y/ySDq2SQ8720Ijjmp
         Nx9ZAssonfhlLbDESbowBZudNuifCbxLTvorZl9mwNZlxUW6c2HPAdBT/uuk3B2EJqSp
         PpWI1f6U890po+VLaXmWHSkLmTLlSESplynCkDGnEXFBGfUzGHk6oEaPc9jgGpdbZHYU
         UKmw==
X-Gm-Message-State: AOAM530YcBfq36YykfjM9BT7mrQJIYmByCIKYJnE/GQyAGe0cQNPDBDm
        AMPVXJv9REzLv6EIX1FEcL44GJjAnXkCfZDd2aI=
X-Google-Smtp-Source: ABdhPJxWEfsAxdSEx9wERk5njzb6Yej5KPKyf1ByFPUuX/f17/Z9AW9TgzvutBu549+Co1GowckYEEyJhVlCpu/A0p4=
X-Received: by 2002:a17:906:ae8d:: with SMTP id md13mr5042030ejb.275.1617215036034;
 Wed, 31 Mar 2021 11:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
 <1609243245-9671-3-git-send-email-peng.fan@nxp.com> <CAHCN7x+=ebLn8vrrT=fyByQDydDNfkESFZHjdUrw=OHBz_E0hw@mail.gmail.com>
 <20201229161220.GA17229@kozik-lap> <DB6PR0402MB2760BBFAAA6C5CE0373EDEFE88D70@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760BBFAAA6C5CE0373EDEFE88D70@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 31 Mar 2021 13:23:44 -0500
Message-ID: <CAHCN7xJ0tvuBYpmP9qZsi2cxsiQshi+ZBFC=WshCgxMZgS9h3w@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 8:34 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
> >
> > On Tue, Dec 29, 2020 at 06:26:41AM -0600, Adam Ford wrote:
> > > On Tue, Dec 29, 2020 at 6:15 AM <peng.fan@nxp.com> wrote:
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > According to RM, there is a spba bus inside aips3 and aips1, add it.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 362
> > > > +++++++++++-----------
> > > >  1 file changed, 189 insertions(+), 173 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > index c824f2615fe8..91f85b8cee9a 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > @@ -269,117 +269,125 @@ aips1: bus@30000000 {
> > > >                         #size-cells = <1>;
> > > >                         ranges = <0x30000000 0x30000000
> > 0x400000>;
> > > >
> > > > -                       sai1: sai@30010000 {
> > > > -                               #sound-dai-cells = <0>;
> > > > -                               compatible = "fsl,imx8mm-sai",
> > "fsl,imx8mq-sai";
> > > > -                               reg = <0x30010000 0x10000>;
> > > > -                               interrupts = <GIC_SPI 95
> > IRQ_TYPE_LEVEL_HIGH>;
> > > > -                               clocks = <&clk
> > IMX8MM_CLK_SAI1_IPG>,
> > > > -                                        <&clk
> > IMX8MM_CLK_SAI1_ROOT>,
> > > > -                                        <&clk
> > IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> > > > -                               clock-names = "bus", "mclk1",
> > "mclk2", "mclk3";
> > > > -                               dmas = <&sdma2 0 2 0>, <&sdma2
> > 1 2 0>;
> > > > -                               dma-names = "rx", "tx";
> > > > -                               status = "disabled";
> > > > -                       };
> > > > +                       bus@30000000 {
> > >
> > > There is already a bus@30000000 (aips1), and I think the system
> > > doesn't like it when there are multiple busses with the same name.
> > >
> > > There was some discussion on fixing the 8mn [1], but it doesn't look
> > > like it went anywhere.
> > >
> > > I am guessing the Mini will need something similar to the nano.
> > >
> > > [1] -
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > >
> > hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F1607324004-1
> > 29
> > >
> > 60-1-git-send-email-shengjiu.wang%40nxp.com%2F&amp;data=04%7C01%7
> > Cpeng
> > > .fan%40nxp.com%7C970d320f3ef7413296ed08d8ac1486f9%7C686ea1d3bc
> > 2b4c6fa9
> > >
> > 2cd99c5c301635%7C0%7C0%7C637448551481206715%7CUnknown%7CTW
> > FpbGZsb3d8ey
> > >
> > JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > %7C200
> > >
> > 0&amp;sdata=xKgYHCDyitbUyTPKVuwQV%2FCoJvepCbdBJ1MD9vP%2B6MY
> > %3D&amp;res
> > > erved=0
> >
> > Several replies from S.j. Wang are missing from LKML (and maybe
> > patchwork?) but we reached a conclusion:
>
> Thanks for the pointing, I'll give a look. If S.J take it, I'll leave it to S.J.

Peng or S.J,

I don't see this was ever finished.  On the Nano, there is an spba-bus
under the aips1 bus, but I am not seeing anything on aips3 yet.   It
appears to have been abandoned.  The NXP kernel doesn't show either
spba-bus on the imx8m Mini either, but the documentation for the Mini
makes it look like it should work.  Do you want me to submit a patch
for any of this?

adam
>
> Thanks,
> Peng.
>
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ke
> > rnel.org%2Flinux-arm-kernel%2F20201208090601.GA8347%40kozik-lap%2F&
> > amp;data=04%7C01%7Cpeng.fan%40nxp.com%7C970d320f3ef7413296ed08
> > d8ac1486f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63744
> > 8551481206715%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> > CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=nk
> > t0J5RtzA%2B29nK4aPnd434FNQV8MUZ%2F8Aq64o6hl6I%3D&amp;reserved
> > =0
> >
> > Either you do some remapping of address space or just rename the "bus"
> > nodes (e.g. generic bus-1 or a specific spba-bus).
> >
> > Best regards,
> > Krzysztof
