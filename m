Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24FC444B92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 00:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhKCXYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 19:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhKCXYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 19:24:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70783C061714;
        Wed,  3 Nov 2021 16:21:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j21so14816684edt.11;
        Wed, 03 Nov 2021 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akanCsjDqti5swM9KT7N/3w80cS+3tLiufyeZ8hTPGo=;
        b=ZJtqdPlx6U1wB73I0eWyS9NF1kDO7y8DPiwyJF5b0kvzEk2DtRndcB6EXlyvJN5nui
         8ddF/WOaCvaw88N86p1JrIgepfeRX2HuFZf5xpwjaxNajVRIvBS7suLF1i1zjxUSq+Nt
         wR6e0UBdWQBIDkxCOc9gDjPooPDH3luCbF2S34Iv56oG9g/poaUUamaTES/jkqIIjeID
         SWT/8PglqhECLOUPZ+2ulPXIoqxgovHMFWQQEWnGDJhJXxaASxT0mCnGhXglrCmg/8M1
         0NGKZlS5UxIfcILVZqmh3B++9MbIcLteefONZIib/Npi/ItbbR2AG5fUDitB5uJ+kn1o
         VNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akanCsjDqti5swM9KT7N/3w80cS+3tLiufyeZ8hTPGo=;
        b=M/6rAQmVf2aHhH4unOZ9FgWaEqVuP1tjXvQ/ZX03VjYG9Omqc8awJSku/lzzapRwv0
         86FgtnVHtpaT11G42atY8NXbNag6LOAh5zlavhBzLwAAbqZ4I2aeEHItKF/vfby072wH
         I/EQvmgngkxQuBXdDUPsygE64NoIWLbnQCv4+eYXlUJkZHtMqBGboTxsSTD1+vdJPZIb
         vZM94ZyFTRw9y7xcwiRWsbrMPhaxJu1a3lh0PgyLQApnWARHOqIjymUkB1nF/1zFGQes
         BVw0gzE/Co0NJ4uwOZLelt4ywBeLwHevou8M6+SKHIMQyKnXIRLeUEYe4XlVeBTHUPit
         ct/Q==
X-Gm-Message-State: AOAM5338LSg00jKVY02A/MT0fZUyKJTIVPf1WYbvXXboJrj4ZyXMNU4w
        HyrOuGVBAtV/wX5MNhyT8AM/kHZUMCW26QQoK8Qbzrkb2iUxHg==
X-Google-Smtp-Source: ABdhPJzysdPvoN8N7Wjje8s/WYaqXeSDPGrEiuGLXDJRoG4ZXll55kRHSXqk51W9P2eFk80O8b+003ftCSgxIwxeUaU=
X-Received: by 2002:aa7:cd99:: with SMTP id x25mr19484527edv.249.1635981710813;
 Wed, 03 Nov 2021 16:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211103135313.6428-1-tomm.merciai@gmail.com> <CAHCN7xLOkvahKSzuUAe5d4sBMoMs51PHDt3G5PB+jEtDkRf30Q@mail.gmail.com>
 <20211103230806.GB34552@tom-ThinkPad-T470p>
In-Reply-To: <20211103230806.GB34552@tom-ThinkPad-T470p>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 3 Nov 2021 18:21:39 -0500
Message-ID: <CAHCN7x+zs6=Mdnt2k3b_SeEkX96q++rOWJTLS0BscnCG8Xayyg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Add NOC node
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 6:08 PM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
>
> On Wed, Nov 03, 2021 at 01:55:54PM -0500, Adam Ford wrote:
> > On Wed, Nov 3, 2021 at 8:53 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> > >
> > > Add support for dynamic frequency scaling of the main NOC configuration
> > > on imx8mm.
> > >
> > > References:
> > >  - i.MX 8M Mini Applications Processor RM, Rev. 3, 11/2020
> > >  - f18e6d573b80 arm64: dts: imx8mq: Add NOC node
> > >  - 912b9dacf3f0 arm64: dts: imx8mq: increase NOC clock to 800 MHz
> > >  - https://source.codeaurora.org/external/imx/linux-imx/tree/arch/ \
> > >    arm64/boot/dts/freescale/imx8mm.dtsi?h=lf-5.10.y
> > >
> >
> > You're missing the signed-off-by tag.
>
>   Yes, sorry.
> >
> > From what I can tell, the default NOC clock is 750MHz.  With this
> > patch enabled, i can manually change the NOC clock to 150, 375 or 750,
> > but it's not clear to me what this impacts.  In the 8MQ, there are a
> > couple peripherals that are linked to the NOC, but we don't have those
> > same peripherals enabled in the 8mm.  The
> > dt-bindings/interconnect/imx8mq.h list more NOC references than are
> > used in the device tree, so it's unclear to me if and what we need to
> > reference anything in the 8MM based on
> > dt-bindings/interconnect/imx8mm.h
> >
> > adam
>

+ Abel

>  Hi Adam,
>  Yes you are right, you mean that NOC is using default frequencies than
>  this this node at the moment is only a duplicate. But on the other
>  side, maybe in the future someone will need to modify default table and
>  use it. What do you think about? Let me know.

There is some discussion with Abel at [1].  I would defer to him to
see what he wants to do.  At a minimum, I would resubmit the patch
with the s-o-b tag enabled, but I'd wait to see if there is any
objection.

[1] - https://lkml.org/lkml/2021/10/25/259

adam
>
>  Thanks,
>  Tommaso
> >
> > > ---
> > > Changes since v1:
> > >  - Fix noc_opp_table frequencies taking NXP bsp as reference
> > >  - Add reference link to nxp imx8mm dtsi on commit body
> > >
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 25 +++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index c2f3f118f82e..1bcc5e361ca3 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -719,6 +719,31 @@ pgc_mipi: power-domain@11 {
> > >                         };
> > >                 };
> > >
> > > +               noc: interconnect@32700000 {
> > > +                       compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> > > +                       reg = <0x32700000 0x100000>;
> > > +                       clocks = <&clk IMX8MM_CLK_NOC>;
> > > +                       fsl,ddrc = <&ddrc>;
> > > +                       #interconnect-cells = <1>;
> > > +                       operating-points-v2 = <&noc_opp_table>;
> > > +
> > > +                       noc_opp_table: opp-table {
> > > +                               compatible = "operating-points-v2";
> > > +
> > > +                               opp-150M {
> > > +                                       opp-hz = /bits/ 64 <150000000>;
> > > +                               };
> > > +
> > > +                               opp-375M {
> > > +                                       opp-hz = /bits/ 64 <375000000>;
> > > +                               };
> > > +
> > > +                               opp-750M {
> > > +                                       opp-hz = /bits/ 64 <750000000>;
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > >                 aips2: bus@30400000 {
> > >                         compatible = "fsl,aips-bus", "simple-bus";
> > >                         reg = <0x30400000 0x400000>;
> > > --
> > > 2.25.1
> > >
