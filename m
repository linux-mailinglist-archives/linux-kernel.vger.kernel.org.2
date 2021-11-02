Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C544E442D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhKBMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKBMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:02:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3BFC061764;
        Tue,  2 Nov 2021 04:59:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f4so16838692edx.12;
        Tue, 02 Nov 2021 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1MA3mUQUD45yT94qOFRtxfboeojPu7769q+5n2e95U=;
        b=eaeodNiCdFu6kygSOBwFyjgtxQZ8UKZRVasgID9j3Py2ph64D/wlQ7sqpAjhDEzDGr
         dY5ejbrzGI+n3xG5nMBmdEixxbDbSfaeawjLjGcUe7j3/yr5PyXWLjChtd/2XfQGLV0a
         izF5nwwUG+XeSO4WvUTglMMP+mikcxbPSQudxWpx72vjda0/KiTm3R4TY+uMINSDVYDT
         KuV5lrP2XezyET23RjT81J+QphdIDOtUvvTsAd/s5bJfaFQx53J7a34C+JQuCA58b7LJ
         AaAmaoY82wfoWqhOj9Ohy4EiHOU5OSIBx1UmAfYlUARls8SZYoLORM3pfHOSZ01Lbxz5
         wXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1MA3mUQUD45yT94qOFRtxfboeojPu7769q+5n2e95U=;
        b=DwByY3GT32SIoVSp6HUUaYMTQ1N6BQl+b1/NBMdzT84oNguAMpw0D4GDMIyrpwdcIu
         4ZSMtCb0PmfIRgaMeyCtQz2RyDQf3ZqWnKqUYm+3VMmijcz8VTsArGtVmCJ1MxJJavEn
         zXXxldkCkVykzv87ChXtAn34CKO+5doxZ238kHsWWNuIAUKjsGpWJoz8DwWLUwpwSYeM
         nNvD8bk1PxgBBDJsSNclzNvFYChoq3ohI3GHweCtKbh8ujNmIJrVaPts6vsCD5U7jjcp
         POfaQ5IfVimn2oLTeMwOsIqGRkTvrjL+PZYrZgDpVftMP2JkUazqUAgWZNZ3jtK6Oe8O
         QZmg==
X-Gm-Message-State: AOAM531LmBmSlCSNWQ9r1LR+3ZhIvXCBAQpxgtsGas8qFXXO9llYQX5T
        aOPiVjHMMYNutWEctSW/U1B1o8l5wgQ=
X-Google-Smtp-Source: ABdhPJxuohi01BIE2bXm36DfyLcn+CCVbR5gWWWzD7H1HjrsXv9utlYwI7cKekCpP4A4gMLbcyhOzw==
X-Received: by 2002:a17:906:1382:: with SMTP id f2mr45516613ejc.144.1635854387951;
        Tue, 02 Nov 2021 04:59:47 -0700 (PDT)
Received: from tom-ThinkBook-14-G2-ARE ([89.42.6.254])
        by smtp.gmail.com with ESMTPSA id m15sm11430016edd.5.2021.11.02.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:59:47 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:59:21 +0100
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
Message-ID: <20211102115739.GA48972@tom-ThinkBook-14-G2-ARE>
References: <20211101222857.6940-1-tomm.merciai@gmail.com>
 <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
 <20211101225827.GA9208@tom-desktop>
 <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 11:22:21PM -0500, Adam Ford wrote:
> On Mon, Nov 1, 2021 at 5:58 PM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> >
> > On Mon, Nov 01, 2021 at 11:35:49PM +0100, Ahmad Fatoum wrote:
> > > Hello Tommaso,
> > >
> > > On 01.11.21 23:28, Tommaso Merciai wrote:
> > > > Add system controller node for registers of module Display Block Control
> > > > (DISPLAY_BLK_CTRL, base address: 0x32e28000).
> > > > The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
> > > > which control varied features of the associated peripherals.
> > > > Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > index 2f632e8ca388..3e496b457e1a 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > @@ -961,6 +961,11 @@ aips4: bus@32c00000 {
> > > >                     #size-cells = <1>;
> > > >                     ranges = <0x32c00000 0x32c00000 0x400000>;
> > > >
> > > > +                   dispmix_gpr: display-gpr@32e28000 {
> > > > +                           compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";
> > >
> > > Please read vendor patches before submitting them. The space
> > > is out-of-place in the compatible and the compatible is wrong:
> > > This doesn't look like a i.MX8MM pin controller.
> > >
> > > Cheers,
> > > Ahmad
> >
> >   Hi Ahmad,
> >   Thanks for your review. Do you think this is correct?
> >
> >   compatible = "fsl,imx8mm-dispmix-gpr", "syscon";
> >
> >   Let me know.
> 
> There was already a driver created for the blk-ctrl stuff and it has a
> device tree binding at 32e28000.  It's tied into the power-domain
> system, so if you want to enable the csi, dsi, or lcd, etc. you can
> just reference the blt-ctrl power domain index, and it enables the
> device's gpc power domain and takes the corresponding device out of
> reset.

  Hi Adam,
  You mean using the gpcv2.c driver?
  
  drivers/soc/imx/gpcv2.c

  With the following node, to put out of reset eLCDIF and mipi_dsi:

  gpc: gpc@303a0000 {
	compatible = "fsl,imx8mm-gpc";
	reg = <0x303a0000 0x10000>;
	interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-parent = <&gic>;
	interrupt-controller;
	#interrupt-cells = <3>;

	pgc {

	 #address-cells = <1>;
	 #size-cells = <0>;
	 pgc_mipi: power-domain@0 {
					#power-domain-cells = <0>;
					reg = <IMX8M_POWER_DOMAIN_MIPI>;
 				  };

	pgc_disp: power-domain@7 {
					#power-domain-cells = <0>;
					reg = <IMX8M_POWER_DOMAIN_DISP>;
 				 };
   };
  };

  Let me know.

  Thanks,
  Tommaso

> 
> adam
> >
> >   Thanks,
> >   Tommaso
> >
> > >
> > > > +                           reg = <0x32e28000 0x100>;
> > > > +                   };
> > > > +
> > > >                     usbotg1: usb@32e40000 {
> > > >                             compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> > > >                             reg = <0x32e40000 0x200>;
> > > >
> > >
> > >
> > > --
> > > Pengutronix e.K.                           |                             |
> > > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
