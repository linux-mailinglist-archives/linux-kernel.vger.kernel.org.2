Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B242E325
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhJNVSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:18:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35804 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhJNVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:18:24 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 142712F3;
        Thu, 14 Oct 2021 23:16:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1634246177;
        bh=aeRKpDM4jtBWwxA2dAlfFhFy3ibg8DiRePAOtDOClHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEQ5wIi/VmSu0JyJrtXo/x8H4cj5xwVLt42ihxSxExn4r2tcnelnas46RNOJb8AGe
         Qy1muX0rIR7AuosHRu69hp5vy5ejQExfpp+a81QeMQUHNOpQLAE2fLfw/QUfAKEG57
         1nkmz1Q4+7t+pLc/mHkK8XD0iHrfYNzTWXvSo7vQ=
Date:   Fri, 15 Oct 2021 00:16:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add CSI nodes
Message-ID: <YWieETWqUZt6yYln@pendragon.ideasonboard.com>
References: <20211014025234.145147-1-aford173@gmail.com>
 <CAHCN7xL8FOZcRkqsxGo5k88_3P7HW67tWdwcbQdeBWx4KY4ihg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xL8FOZcRkqsxGo5k88_3P7HW67tWdwcbQdeBWx4KY4ihg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Thu, Oct 14, 2021 at 03:32:33PM -0500, Adam Ford wrote:
> On Wed, Oct 13, 2021 at 9:52 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > There is a csi bridge and csis interface that tie together
> > to allow csi2 capture.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> Laurent,
> 
> Since you did some work to make the csis functional on the imx8mm, I
> was hoping you might have some insights.  Please see below:
> 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index c2f3f118f82e..8a8a5d0a4a1e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -1068,6 +1068,22 @@ aips4: bus@32c00000 {
> >                         #size-cells = <1>;
> >                         ranges = <0x32c00000 0x32c00000 0x400000>;
> >
> > +                       csi: csi@32e20000 {
> > +                               compatible = "fsl,imx7-csi";

This should be

	compatible = "fsl,imx8mm-csi", "fsl,imx7-csi";;

> > +                               reg = <0x32e20000 0x1000>;
> > +                               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&clk IMX8MM_CLK_CSI1_ROOT>;
> > +                               clock-names = "mclk";
> > +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;
> > +                               status = "disabled";
> > +
> > +                               port {
> > +                                       csi_in: endpoint {
> > +                                               remote-endpoint = <&imx8mm_mipi_csi_out>;
> > +                                       };
> > +                               };
> > +                       };
> > +
> >                         disp_blk_ctrl: blk-ctrl@32e28000 {
> >                                 compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
> >                                 reg = <0x32e28000 0x100>;
> > @@ -1095,6 +1111,41 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> >                                 #power-domain-cells = <1>;
> >                         };
> >
> > +                       mipi_csi2: mipi-csi@32e30000 {
> > +                               compatible = "fsl,imx8mm-mipi-csi2";
> > +                               reg = <0x32e30000 0x1000>;
> > +                               interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clock-frequency = <333000000>;
> > +                               clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
> > +                                        <&clk IMX8MM_CLK_CSI1_ROOT>,
> > +                                        <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> > +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>;
> 
> When comparing clock parents and the clock rates to one of NXP's
> kernels, it appears we need assigned-clocks and assigned-clock-parents
> to allow the CSI1 clocks to run fast enough.
> 
> assigned-clocks = <&clk IMX8MM_CLK_CSI1_PHY_REF>,
>   <&clk IMX8MM_CLK_CSI1_CORE>,
>   <&clk IMX8MM_CLK_CSI1_ROOT>,
>   <&clk IMX8MM_CLK_CSI1_ESC>;
> assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
>   <&clk IMX8MM_SYS_PLL2_1000M>,
>   <&clk IMX8MM_CLK_CSI1_CORE>,
>   <&clk IMX8MM_SYS_PLL1_800M>;
> 
> However, even with this, I am attempting to capture.  While I can get
> the pipeline enabled, when I try to capture a file, I get no data.  i
> can use control-c to exit gstreamer, so I know the kernel didn't hang.
> I don't get errors, but I don't get data either.
> 
> Any ideas if what/if any other clock entries might be missing?

Have you tried looking at the error interrupt counters to see if the
CSI-2 bus side operates as expected ? I'd start there before blaming the
clocks. Note that the issue could also be in the CSI bridge.

I've had issues capturing from one particular sensor on an i.MX8MM
board, where I would get images, but with heavy corruption. The problem
was solved by chance when trying a different SPL binary. I need to
investigate the differences there, and possibly update the driver
accordingly. It may or may not be related to your issue.

Apart from the compatible string issue mentioned above, the bindings
match what I am using, so, with the compatible string fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > +                               clock-names = "pclk", "wrap", "phy", "axi";
> > +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;
> > +                               status = "disabled";
> > +
> > +                               ports {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +
> > +                                       port@0 {
> > +                                               reg = <0>;
> > +
> > +                                               imx8mm_mipi_csi_in: endpoint {
> > +                                               };
> > +                                       };
> > +
> > +                                       port@1 {
> > +                                               reg = <1>;
> > +
> > +                                               imx8mm_mipi_csi_out: endpoint {
> > +                                                       remote-endpoint = <&csi_in>;
> > +                                               };
> > +                                       };
> > +                               };
> > +                       };
> > +
> > +
> >                         usbotg1: usb@32e40000 {
> >                                 compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> >                                 reg = <0x32e40000 0x200>;

-- 
Regards,

Laurent Pinchart
