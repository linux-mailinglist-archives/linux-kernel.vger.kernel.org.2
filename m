Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2434431FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhKBPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhKBPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:50:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0AC061714;
        Tue,  2 Nov 2021 08:47:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m14so24291319edd.0;
        Tue, 02 Nov 2021 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=auc7OgLCpATUuyoO8qYN4YH3bnE9LQ0zTQtkgZFev+I=;
        b=dwbRfoKq4gVI6dLN+m2fblo9Cm9hxniPkmZw3Fsfm5Oy3vF5cC1VYM2boNPa8OZaKN
         RsFEqFGYOoGJU8nJTax3smVIZJ4Qn1SuAGkqcfmHuhNmCuMOizbKR8W10x1lAc3oohX6
         a/s7+qJH/jiKyqupANDIcsuNaTMypBsFt+zXtVVtDY/G9xC9l18DsgJvVBjlgXRVdeRW
         zNvafJHrdtR3z0OfaUDbEk/4NzUofNlCwzEZ+Sjca7yocO76nRXgUBikkB0Fls5EQYGX
         I5IeajNXG0Q3SOLfXmnlKm0q7Gv+Oa5TI1tuTuJ+Dqx/KK97L/F34HdaIA/aBHEDvGZ+
         UZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=auc7OgLCpATUuyoO8qYN4YH3bnE9LQ0zTQtkgZFev+I=;
        b=b2bpD9bRfpln8wv2qq6STlLoSIq/ZCOKySYttlHPaxS47xg/Gx/ISOIW/4nh0TAFXx
         lnNOX0HHYC5evga8XA3KvqWlqC1XiqsUWXDg6ilP67JbK0Gdyq1BBjjEKsPgU/Fvu6xt
         LUngmvtAKyV8gPtViztHWFvfdSn5bGE04rEbXn5qaQPFtJiCz3v6hJcDqm3ynMJPCZYe
         gRu481yfsiB8Ji5JYnILF33obGBC8JQ+Yb5tPsCpC/kZH6xaeG/NbuFXNQsGIN/udDxp
         jRLJiU0maEpHHcIGDNAgtLuZMs2giRPCAaYvJBZFIegu4zfygXK1DltZnxbhHr62CbFX
         uFkw==
X-Gm-Message-State: AOAM530038M/JLz5UXBFnjW0VwYqJjVIEMQLrz/YLspEeDYmtF1HsMku
        nmrhaRbjfp4Pc5ULE08QdzE=
X-Google-Smtp-Source: ABdhPJw6ue1bg9MQoVbz2o+REGts6UBWFADGp6/8AduIJoGC1/8Uw38E9pZNbMsY+Mt4amyJev28zg==
X-Received: by 2002:a50:e089:: with SMTP id f9mr52052884edl.290.1635868065292;
        Tue, 02 Nov 2021 08:47:45 -0700 (PDT)
Received: from tom-ThinkBook-14-G2-ARE ([89.42.6.254])
        by smtp.gmail.com with ESMTPSA id q2sm8339785eje.118.2021.11.02.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:47:44 -0700 (PDT)
Date:   Tue, 2 Nov 2021 16:47:42 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl
 module regs
Message-ID: <20211102154742.GA86474@tom-ThinkBook-14-G2-ARE>
References: <20211101222857.6940-1-tomm.merciai@gmail.com>
 <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
 <20211101225827.GA9208@tom-desktop>
 <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
 <20211102115739.GA48972@tom-ThinkBook-14-G2-ARE>
 <CAHCN7xLoePWS33HsFANcHQB2-VgQVNG40EgDoz+-xba810XPBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLoePWS33HsFANcHQB2-VgQVNG40EgDoz+-xba810XPBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 07:23:06AM -0500, Adam Ford wrote:
> The upcoming 5.16 kernel will have a new blk-ctrl driver which will
> work in conjunction with the GPC.  You can see it in linux-next [1],
> and I would expect it to be present in 5.16-rc1 once the merge is
> done.
> 
> In [1], Look for :
> 
> disp_blk_ctrl: blk-ctrl@32e28000 {
>     compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
> 
> It creates a bunch of virtual power domains which are effectively the
> resets for the VPU, CSI, DSI, and LCDIF [2].
> 
> Basically, to pull the respective device out of reset, you'd reference
> them using power-domains.  I have an RFC patch for the CSI located [3]
> which should bring the GPC power domain up, then take the CSI bridge
> and MIPI_CSI out of reset using the blk-ctrl.  A few of us are still
> investigating the CSI bridge and mipi_csi drivers to determine what's
> going wrong, but  inside that patch, you'll see that we reference
> "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;" and
> "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;" which
> are part of the new blk-ctrl driver @32e2800.  Other peripherals like
> LCD, DSI, and the VPU's should be able to reference their respective
> power domains to activate the corresponding resets after enabling the
> proper GPC power domain.

  Hi Adam,
  Then is all done right. Using this this new driver/dts node eLCDIF/mipi_dsi 
  module are out of reset. Thanks for the tips. I'm trying to get eLCDIF/mipi_dsi 
  work on mainline. I try to get work 

  - eLCDIF using: mxsfb_drv.c
  - mipi_dsi using: nwl-dsi.c

  What do you think about? You think that can be a good way ( taking
  imx8mq as reference )?

  Let me know.
  Thanks,

  Tommaso
> 
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi?h=next-20211102
> [2] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/power/imx8mm-power.h?h=next-20211102
> [3] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211023203457.1217821-2-aford173@gmail.com/
> 
> On Tue, Nov 2, 2021 at 6:59 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> >
> > On Mon, Nov 01, 2021 at 11:22:21PM -0500, Adam Ford wrote:
> > > On Mon, Nov 1, 2021 at 5:58 PM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 01, 2021 at 11:35:49PM +0100, Ahmad Fatoum wrote:
> > > > > Hello Tommaso,
> > > > >
> > > > > On 01.11.21 23:28, Tommaso Merciai wrote:
> > > > > > Add system controller node for registers of module Display Block Control
> > > > > > (DISPLAY_BLK_CTRL, base address: 0x32e28000).
> > > > > > The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
> > > > > > which control varied features of the associated peripherals.
> > > > > > Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > index 2f632e8ca388..3e496b457e1a 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > @@ -961,6 +961,11 @@ aips4: bus@32c00000 {
> > > > > >                     #size-cells = <1>;
> > > > > >                     ranges = <0x32c00000 0x32c00000 0x400000>;
> > > > > >
> > > > > > +                   dispmix_gpr: display-gpr@32e28000 {
> > > > > > +                           compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";
> > > > >
> > > > > Please read vendor patches before submitting them. The space
> > > > > is out-of-place in the compatible and the compatible is wrong:
> > > > > This doesn't look like a i.MX8MM pin controller.
> > > > >
> > > > > Cheers,
> > > > > Ahmad
> > > >
> > > >   Hi Ahmad,
> > > >   Thanks for your review. Do you think this is correct?
> > > >
> > > >   compatible = "fsl,imx8mm-dispmix-gpr", "syscon";
> > > >
> > > >   Let me know.
> > >
> > > There was already a driver created for the blk-ctrl stuff and it has a
> > > device tree binding at 32e28000.  It's tied into the power-domain
> > > system, so if you want to enable the csi, dsi, or lcd, etc. you can
> > > just reference the blt-ctrl power domain index, and it enables the
> > > device's gpc power domain and takes the corresponding device out of
> > > reset.
> >
> >   Hi Adam,
> >   You mean using the gpcv2.c driver?
> >
> >   drivers/soc/imx/gpcv2.c
> >
> >   With the following node, to put out of reset eLCDIF and mipi_dsi:
> >
> >   gpc: gpc@303a0000 {
> >         compatible = "fsl,imx8mm-gpc";
> >         reg = <0x303a0000 0x10000>;
> >         interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> >         interrupt-parent = <&gic>;
> >         interrupt-controller;
> >         #interrupt-cells = <3>;
> >
> >         pgc {
> >
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >          pgc_mipi: power-domain@0 {
> >                                         #power-domain-cells = <0>;
> >                                         reg = <IMX8M_POWER_DOMAIN_MIPI>;
> >                                   };
> >
> >         pgc_disp: power-domain@7 {
> >                                         #power-domain-cells = <0>;
> >                                         reg = <IMX8M_POWER_DOMAIN_DISP>;
> >                                  };
> >    };
> >   };
> >
> >   Let me know.
> >
> >   Thanks,
> >   Tommaso
> >
> > >
> > > adam
> > > >
> > > >   Thanks,
> > > >   Tommaso
> > > >
> > > > >
> > > > > > +                           reg = <0x32e28000 0x100>;
> > > > > > +                   };
> > > > > > +
> > > > > >                     usbotg1: usb@32e40000 {
> > > > > >                             compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> > > > > >                             reg = <0x32e40000 0x200>;
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Pengutronix e.K.                           |                             |
> > > > > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > > > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
