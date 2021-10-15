Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5673242FE15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhJOW2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJOW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:28:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1CC061570;
        Fri, 15 Oct 2021 15:26:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t16so43421475eds.9;
        Fri, 15 Oct 2021 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otmrc4FUJTHZ9+qzFvpj/AYrRvh2DDnhIGOmbmHwHJ4=;
        b=NC9yVlx5W+qh4n5YhiMq6JudQIezuE/8AqxTMZKyRjZRncugcnB2IMtqA2Cm9WFXkU
         7gMXgr6jNZqxyvQ6YUaIkPARlnoaaYU+BrSois1pLJgkgos+AYgUNn2RE/HmXncB1+1R
         cHNS6FPKUDOtf2BQj+vx3HejuIgosbLIt6TspqtDafGxyyncgfollSC//xwduOwKuJXX
         dERFxZN6h6xiJuVJjagQfCtHvYbJaxYFas5I4n5ITc2uzWnQZI0WtuhbanowvWLm9L2z
         VOCjXgJlQ27z1icpPVo5HRZTLGnorv33vBu8Sg/bIwY7mHoRjcwAdTvftWV+FUWhDxiX
         ZpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otmrc4FUJTHZ9+qzFvpj/AYrRvh2DDnhIGOmbmHwHJ4=;
        b=VWEZILvOgLXDnovHNdI6toNdGvMHFEb8JYBfXTaKENtBojU1V5js+KgJlk0Mk5zYxE
         WA9yVT9rTDF++Jjr4tLzEr5YATryJovzI0KwfI6DbPN+dGlErL5yUSv3AMbtJTfS9HCa
         UvB6FpNeX2D6jkEGwz9fTLs6kc1EV2iK9znbrY/9pN7lN77baqI20zUwlv3/iIuKQc6+
         UyCG0DP6MljwVFzAJXT86ChhTRGdOp/0n60mWfx2RkNXEu3MMtNFq7hyg8KAUXfJVaGa
         CX8JLBlL8fH1e2dZACYx9fuEyndxdZ3YUy5LFNOp4BV1r+myasEMexw0AkdPaG1eVzSt
         AqZA==
X-Gm-Message-State: AOAM530J50PVQDNkp7vhRefHXxV2CTJxhRloJfUXfvnI7G7ij9b4NRpM
        fDLS1SXltM9fd69qTSNFcbsUcJd0HUaNcmVya8A=
X-Google-Smtp-Source: ABdhPJxpD93GxFvhgDDyQ0BTL35Rb00Hn0C7bMo7qx+4C6LZY0rCjuuHzJVaCog377LMqNGYOCaZazp1FtF4nC6eA8Q=
X-Received: by 2002:a50:9d48:: with SMTP id j8mr21658706edk.165.1634336774580;
 Fri, 15 Oct 2021 15:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211014025234.145147-1-aford173@gmail.com> <CAHCN7xL8FOZcRkqsxGo5k88_3P7HW67tWdwcbQdeBWx4KY4ihg@mail.gmail.com>
 <YWieETWqUZt6yYln@pendragon.ideasonboard.com>
In-Reply-To: <YWieETWqUZt6yYln@pendragon.ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 15 Oct 2021 17:26:03 -0500
Message-ID: <CAHCN7xLpFcXzP40KiciQ+m=kA5U3A_VVEboHAsKRnaLgVBL91w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add CSI nodes
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 4:16 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Adam,
>
> On Thu, Oct 14, 2021 at 03:32:33PM -0500, Adam Ford wrote:
> > On Wed, Oct 13, 2021 at 9:52 PM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > There is a csi bridge and csis interface that tie together
> > > to allow csi2 capture.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > Laurent,
> >
> > Since you did some work to make the csis functional on the imx8mm, I
> > was hoping you might have some insights.  Please see below:
> >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index c2f3f118f82e..8a8a5d0a4a1e 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -1068,6 +1068,22 @@ aips4: bus@32c00000 {
> > >                         #size-cells = <1>;
> > >                         ranges = <0x32c00000 0x32c00000 0x400000>;
> > >
> > > +                       csi: csi@32e20000 {
> > > +                               compatible = "fsl,imx7-csi";
>
> This should be
>
>         compatible = "fsl,imx8mm-csi", "fsl,imx7-csi";;
>
> > > +                               reg = <0x32e20000 0x1000>;
> > > +                               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               clocks = <&clk IMX8MM_CLK_CSI1_ROOT>;
> > > +                               clock-names = "mclk";
> > > +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;
> > > +                               status = "disabled";
> > > +
> > > +                               port {
> > > +                                       csi_in: endpoint {
> > > +                                               remote-endpoint = <&imx8mm_mipi_csi_out>;
> > > +                                       };
> > > +                               };
> > > +                       };
> > > +
> > >                         disp_blk_ctrl: blk-ctrl@32e28000 {
> > >                                 compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
> > >                                 reg = <0x32e28000 0x100>;
> > > @@ -1095,6 +1111,41 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> > >                                 #power-domain-cells = <1>;
> > >                         };
> > >
> > > +                       mipi_csi2: mipi-csi@32e30000 {
> > > +                               compatible = "fsl,imx8mm-mipi-csi2";
> > > +                               reg = <0x32e30000 0x1000>;
> > > +                               interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > +                               clock-frequency = <333000000>;
> > > +                               clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
> > > +                                        <&clk IMX8MM_CLK_CSI1_ROOT>,
> > > +                                        <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> > > +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>;
> >
> > When comparing clock parents and the clock rates to one of NXP's
> > kernels, it appears we need assigned-clocks and assigned-clock-parents
> > to allow the CSI1 clocks to run fast enough.
> >
> > assigned-clocks = <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> >   <&clk IMX8MM_CLK_CSI1_CORE>,
> >   <&clk IMX8MM_CLK_CSI1_ROOT>,
> >   <&clk IMX8MM_CLK_CSI1_ESC>;
> > assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
> >   <&clk IMX8MM_SYS_PLL2_1000M>,
> >   <&clk IMX8MM_CLK_CSI1_CORE>,
> >   <&clk IMX8MM_SYS_PLL1_800M>;
> >
> > However, even with this, I am attempting to capture.  While I can get
> > the pipeline enabled, when I try to capture a file, I get no data.  i
> > can use control-c to exit gstreamer, so I know the kernel didn't hang.
> > I don't get errors, but I don't get data either.
> >
> > Any ideas if what/if any other clock entries might be missing?
>
> Have you tried looking at the error interrupt counters to see if the
> CSI-2 bus side operates as expected ? I'd start there before blaming the
> clocks. Note that the issue could also be in the CSI bridge.

I am not seeing interrupts on either the CSI, mipi-csi, or err:

 54:          0          0          0          0     GICv3  48 Level     csi
 55:          0          0          0          0     GICv3  49 Level
  32e30000.mipi-csi
Err:          0


>
> I've had issues capturing from one particular sensor on an i.MX8MM
> board, where I would get images, but with heavy corruption. The problem
> was solved by chance when trying a different SPL binary. I need to

I wonder if the issue was related to different versions of ATF, and
depending on the power domain controls used, it could have been using
ATF to set the power domains.
I've had issues in the past too, but I have tried a couple different
binaries, and I am not seeing a change in behavior.

> investigate the differences there, and possibly update the driver
> accordingly. It may or may not be related to your issue.
>
> Apart from the compatible string issue mentioned above, the bindings
> match what I am using, so, with the compatible string fixed,
>

Out of curiosity, I noticed the default csi clock parents point to a
24MHz clock, but the csi-2 interface wants to set the clock to 333MHz.
Any chance you could share your clk_summary?

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for the review
>
> > > +                               clock-names = "pclk", "wrap", "phy", "axi";
> > > +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;
> > > +                               status = "disabled";
> > > +
> > > +                               ports {
> > > +                                       #address-cells = <1>;
> > > +                                       #size-cells = <0>;
> > > +
> > > +                                       port@0 {
> > > +                                               reg = <0>;
> > > +
> > > +                                               imx8mm_mipi_csi_in: endpoint {
> > > +                                               };
> > > +                                       };
> > > +
> > > +                                       port@1 {
> > > +                                               reg = <1>;
> > > +
> > > +                                               imx8mm_mipi_csi_out: endpoint {
> > > +                                                       remote-endpoint = <&csi_in>;
> > > +                                               };
> > > +                                       };
> > > +                               };
> > > +                       };
> > > +
> > > +
> > >                         usbotg1: usb@32e40000 {
> > >                                 compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> > >                                 reg = <0x32e40000 0x200>;
>
> --
> Regards,
>
> Laurent Pinchart
