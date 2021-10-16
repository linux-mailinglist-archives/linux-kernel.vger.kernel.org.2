Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C42430321
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhJPO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhJPO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 10:59:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FCAC061570;
        Sat, 16 Oct 2021 07:56:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y30so32749023edi.0;
        Sat, 16 Oct 2021 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YtXJmCs9AU52K7Q0shmrzv7Ck197gy4BAeyEr5know=;
        b=EY8GuQdogoJvQKRPUbOmUa/0ginMPzB1hUxlaU3A7hUt38EK0fvWIkhPvOmzST5EgU
         9cw9/HQYSjXukSnrwL/ZYC0V4B7qCK+bRNw4T7Y+e3IcRzTSZQ1XyhlTZUIRUl3Rq1YY
         c/xupg5RkJjTKqhk/HIjeFEuU3VMFv2IVn4A4iWvgCr6FlGLVHPe1bbz4ecl/4aUT6e2
         aeon+pLOI/9pvSwyAb1keAosHBR9DeKRGQcqVB7hLTpjqA0eAa53hlLgY3JOl1S33h6P
         P0LS6FYYTx25+6PrTOwXBGgfrgxkuVi9eIXfBgkib6MMb41ZBvdmvZV3gvLnaZP99pqm
         WgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YtXJmCs9AU52K7Q0shmrzv7Ck197gy4BAeyEr5know=;
        b=amCCrwlVEfwFOotIdRW8Fp4kaoF7zpgA1TSyQ8xJTRSbQAwXpbw0KtOI4U1GdN+gm9
         9sFRf1LzgzbKo9HGz7yd5SiiR+WO1w0ah4i0Bn6z7BjjgRxxrUWY1bE1Lq/6+3D9gQNO
         VFNtI3Qr1yuIAHVBtVwCt8+XJhtXGu1iWo1SIX19kUgFaZRzILdqjiwBFRwpzk/91zqA
         06KmhvoyLK/nTbGSOi8TYwdEC5db+QMEr4bP0RgMEUcOL86q2RJXwOAhx2adaHkgcbTq
         0qtaTV9tROclZDg4MGKAe9UNFJL9OEDPOlKmNNeZmFtkQQpSgAB5GrCqXq8EIsBPJEPf
         FA7Q==
X-Gm-Message-State: AOAM530uKl1f2a7yJNaRcD3Ozf6UEWKBxAlPdcdrKWC+OJwgoIZhLTLY
        Z3u/m9IXVFd5bDtmT14yUh/BhAe491Ej2IMOZ4o=
X-Google-Smtp-Source: ABdhPJxSxdcwTLXhFDILMQrvIK47MrpPg1GW+UOtzpTKLACsLanflQmtMKyQSyUMo2N1tdeYzdI1TkUMB95dWU3eYeg=
X-Received: by 2002:a05:6402:3586:: with SMTP id y6mr27197250edc.292.1634396213566;
 Sat, 16 Oct 2021 07:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211014025234.145147-1-aford173@gmail.com> <CAHCN7xL8FOZcRkqsxGo5k88_3P7HW67tWdwcbQdeBWx4KY4ihg@mail.gmail.com>
 <YWieETWqUZt6yYln@pendragon.ideasonboard.com> <CAHCN7xLpFcXzP40KiciQ+m=kA5U3A_VVEboHAsKRnaLgVBL91w@mail.gmail.com>
 <YWoDLp+gYxn7IkU5@pendragon.ideasonboard.com> <CAHCN7xLe_Li7JVD+HR25RuXFgjDqbF9VRko+x5e1jmLMCPdUww@mail.gmail.com>
 <CAHCN7xLX5h1-tJUvvpt44Nkjo1Rz3rWaGTEL8SDnkmK1PnCg-g@mail.gmail.com>
In-Reply-To: <CAHCN7xLX5h1-tJUvvpt44Nkjo1Rz3rWaGTEL8SDnkmK1PnCg-g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 16 Oct 2021 09:56:42 -0500
Message-ID: <CAHCN7xLdSF3qRAoKK_1TS9xG7sudR7AzjtFPTjgKVGABF5yavQ@mail.gmail.com>
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

On Fri, Oct 15, 2021 at 6:48 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Fri, Oct 15, 2021 at 6:05 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Fri, Oct 15, 2021 at 5:39 PM Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Fri, Oct 15, 2021 at 05:26:03PM -0500, Adam Ford wrote:
> > > > On Thu, Oct 14, 2021 at 4:16 PM Laurent Pinchart wrote:
> > > > > On Thu, Oct 14, 2021 at 03:32:33PM -0500, Adam Ford wrote:
> > > > > > On Wed, Oct 13, 2021 at 9:52 PM Adam Ford wrote:
> > > > > > >
> > > > > > > There is a csi bridge and csis interface that tie together
> > > > > > > to allow csi2 capture.
> > > > > > >
> > > > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > >
> > > > > > Laurent,
> > > > > >
> > > > > > Since you did some work to make the csis functional on the imx8mm, I
> > > > > > was hoping you might have some insights.  Please see below:
> > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > > index c2f3f118f82e..8a8a5d0a4a1e 100644
> > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > > @@ -1068,6 +1068,22 @@ aips4: bus@32c00000 {
> > > > > > >                         #size-cells = <1>;
> > > > > > >                         ranges = <0x32c00000 0x32c00000 0x400000>;
> > > > > > >
> > > > > > > +                       csi: csi@32e20000 {
> > > > > > > +                               compatible = "fsl,imx7-csi";
> > > > >
> > > > > This should be
> > > > >
> > > > >         compatible = "fsl,imx8mm-csi", "fsl,imx7-csi";;
> > > > >
> > > > > > > +                               reg = <0x32e20000 0x1000>;
> > > > > > > +                               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > +                               clocks = <&clk IMX8MM_CLK_CSI1_ROOT>;
> > > > > > > +                               clock-names = "mclk";
> > > > > > > +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;
> > > > > > > +                               status = "disabled";
> > > > > > > +
> > > > > > > +                               port {
> > > > > > > +                                       csi_in: endpoint {
> > > > > > > +                                               remote-endpoint = <&imx8mm_mipi_csi_out>;
> > > > > > > +                                       };
> > > > > > > +                               };
> > > > > > > +                       };
> > > > > > > +
> > > > > > >                         disp_blk_ctrl: blk-ctrl@32e28000 {
> > > > > > >                                 compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
> > > > > > >                                 reg = <0x32e28000 0x100>;
> > > > > > > @@ -1095,6 +1111,41 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> > > > > > >                                 #power-domain-cells = <1>;
> > > > > > >                         };
> > > > > > >
> > > > > > > +                       mipi_csi2: mipi-csi@32e30000 {
> > > > > > > +                               compatible = "fsl,imx8mm-mipi-csi2";
> > > > > > > +                               reg = <0x32e30000 0x1000>;
> > > > > > > +                               interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > +                               clock-frequency = <333000000>;
> > > > > > > +                               clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
> > > > > > > +                                        <&clk IMX8MM_CLK_CSI1_ROOT>,
> > > > > > > +                                        <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> > > > > > > +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>;
> > > > > >
> > > > > > When comparing clock parents and the clock rates to one of NXP's
> > > > > > kernels, it appears we need assigned-clocks and assigned-clock-parents
> > > > > > to allow the CSI1 clocks to run fast enough.
> > > > > >
> > > > > > assigned-clocks = <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> > > > > >   <&clk IMX8MM_CLK_CSI1_CORE>,
> > > > > >   <&clk IMX8MM_CLK_CSI1_ROOT>,
> > > > > >   <&clk IMX8MM_CLK_CSI1_ESC>;
> > > > > > assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
> > > > > >   <&clk IMX8MM_SYS_PLL2_1000M>,
> > > > > >   <&clk IMX8MM_CLK_CSI1_CORE>,
> > > > > >   <&clk IMX8MM_SYS_PLL1_800M>;
> > > > > >
> > > > > > However, even with this, I am attempting to capture.  While I can get
> > > > > > the pipeline enabled, when I try to capture a file, I get no data.  i
> > > > > > can use control-c to exit gstreamer, so I know the kernel didn't hang.
> > > > > > I don't get errors, but I don't get data either.
> > > > > >
> > > > > > Any ideas if what/if any other clock entries might be missing?
> > > > >
> > > > > Have you tried looking at the error interrupt counters to see if the
> > > > > CSI-2 bus side operates as expected ? I'd start there before blaming the
> > > > > clocks. Note that the issue could also be in the CSI bridge.
> > > >
> > > > I am not seeing interrupts on either the CSI, mipi-csi, or err:
> > > >
> > > >  54:          0          0          0          0     GICv3  48 Level     csi
> > > >  55:          0          0          0          0     GICv3  49 Level
> > > >   32e30000.mipi-csi
> > > > Err:          0
> > > >
> > > > > I've had issues capturing from one particular sensor on an i.MX8MM
> > > > > board, where I would get images, but with heavy corruption. The problem
> > > > > was solved by chance when trying a different SPL binary. I need to
> > > >
> > > > I wonder if the issue was related to different versions of ATF, and
> > > > depending on the power domain controls used, it could have been using
> > > > ATF to set the power domains.
> > > > I've had issues in the past too, but I have tried a couple different
> > > > binaries, and I am not seeing a change in behavior.
> > >
> > > We've just finished the investigation, and it turned out to be related
> > > to the clock frequencies. Here's the DT changes we had to make to get it
> > > working:
> > >
> > >         assigned-clocks = <&clk IMX8MM_CLK_DISP_AXI>,
> > >                 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> > >                 <&clk IMX8MM_CLK_DISP_APB>,
> > >                 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> > >         assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
> > >                 <&clk IMX8MM_CLK_DISP_AXI>,
> > >                 <&clk IMX8MM_SYS_PLL1_800M>,
> > >                 <&clk IMX8MM_CLK_DISP_APB>;
> > >         assigned-clock-rates = <500000000>, <500000000>, <200000000>, <200000000>;
> > >
> > > This results in the following clock configuration:
> > >
> > > sys_pll2_1000m 1000000000
> > >  disp_axi 500000000
> > >   disp_axi_root_clk 500000000
> > >
> > > sys_pll1_800m 800000000
> > >  disp_apb 200000000
> > >   disp_apb_root_clk 200000000
> > >
> > > I'll check which clock is the culprit, and see if we could program the
> > > clocks in the driver directly.
> >
> > I am using Shawn Guo's "for-next" branch, and by default the disp_axi
> > and disp_apb clocks appear to already have these parents and clock
> > rates.  They appear to be defined in the pgc_dispmix node.
> >
> >           disp_axi                    1        1        0   500000000
> >         0     0  50000         Y
> >              disp_axi_root_clk        2        2        0   500000000
> >         0     0  50000         Y
> >           disp_apb                    1        1        0   200000000
> >         0     0  50000         Y
> >              disp_apb_root_clk        2        2        0   200000000
> >         0     0  50000         Y
> >
> > Can you tell me which branch you're using?  I wonder if I should
> > switch branches.
> >
>
> I started investigating the power domain, and I did a dump of the
> disp-blk-ctl dump, and it appears the csi power domain is remaining
> off:
>
> cat /sys/kernel/debug/regmap/32e28000.blk-ctrl/registers
> 00: 00000047
> 04: 0000103f
>
> I compared it with pm_genpd_summary, and found the dispblk-mipi-csi
> appears to be off:
>
>    dispblk-csi-bridge              on
>        /devices/platform/soc@0/32c00000.bus/32e20000.csi
>    dispblk-mipi-csi                off-0
>                0
>         /devices/platform/soc@0/32c00000.bus/32e30000.mipi-csi
> suspended                  0
>
> Do you have any idea why the dispblk-mipi-csi power domain might turn
> off while the dispblk-csi-bridge is on?
>
> I added some debug code, and it looks like we're intentionally turning
> it off, but it's not clear as to why.

Upon further investigation, it looks like the streaming start/stop
enabled/disables the power-domain, and I can see the disp-blk bits are
correct when we're attempting to stream.
I think we need the assign-clock-parents in CSI node because they're
set by default in the NXP kernel, and we're setting the clock rate of
the wrap clock (IMX8MM_CLK_CSI1_ROOT) to 333MHz and when I set the
clock parents, the clock rate of IMX8MM_CLK_CSI1_ROOT shows 333333334.

I have an OV5640 camera connected, and the xclk on the OV5640 is being
driven by IMX8MM_CLK_CLKO1 which has its parent set to IMX8MM_CLK_24M.

When streaming, the CSI clocks look like:
         csi1_phy_ref                2        2        0  1000000000
       0     0  50000         Y
          csi1_core                   1        1        0   333333334
        0     0  50000         Y
             csi1_root_clk            3        3        0   333333334
        0     0  50000         Y
          csi1_esc                    0        0        0   800000000
        0     0  50000         N

And the IMX8MM_CLK_CLKO1 looks like:
     clko1                             1        1        0    24000000
         0     0  50000         Y

From what I can tell, all the clocks, except csi1_esc are enabled and
running at the frequencies that I would expect when compared to the
NXP custom kernel which  works just fine for me.  The NXP kernel
assigns the csi1_esc, but it never seems to get enabled.  Looking at
the TRM, I don't see a patch for csi1_esc, so I am not sure we need to
enable that one.

I'm going to re-submit the patch with the CSI enabled with the
compatible entry fixed, and with the assigned-parents added, then I'll
add a second patch to enable the CSI and CSIS drivers as modules.  The
third patch will be an RFC with the beacon-imx8mm board adding the
stuff for the OV5640 since I still cannot get data to stream.  No
interrupts on CSI and no error interrupts appear in the
/proc/interrupts.

I don't have a scope at home, so I can't tell if the 24MHz is clocking
the OV5640, but I'll check that when time permits.

adam
>
> > adam
> > >
> > > > > investigate the differences there, and possibly update the driver
> > > > > accordingly. It may or may not be related to your issue.
> > > > >
> > > > > Apart from the compatible string issue mentioned above, the bindings
> > > > > match what I am using, so, with the compatible string fixed,
> > > >
> > > > Out of curiosity, I noticed the default csi clock parents point to a
> > > > 24MHz clock, but the csi-2 interface wants to set the clock to 333MHz.
> > > > Any chance you could share your clk_summary?
> > >
> > > Is the above information what you need ?
> > >
> > > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > >
> > > > Thanks for the review
> > > >
> > > > > > > +                               clock-names = "pclk", "wrap", "phy", "axi";
> > > > > > > +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;
> > > > > > > +                               status = "disabled";
> > > > > > > +
> > > > > > > +                               ports {
> > > > > > > +                                       #address-cells = <1>;
> > > > > > > +                                       #size-cells = <0>;
> > > > > > > +
> > > > > > > +                                       port@0 {
> > > > > > > +                                               reg = <0>;
> > > > > > > +
> > > > > > > +                                               imx8mm_mipi_csi_in: endpoint {
> > > > > > > +                                               };
> > > > > > > +                                       };
> > > > > > > +
> > > > > > > +                                       port@1 {
> > > > > > > +                                               reg = <1>;
> > > > > > > +
> > > > > > > +                                               imx8mm_mipi_csi_out: endpoint {
> > > > > > > +                                                       remote-endpoint = <&csi_in>;
> > > > > > > +                                               };
> > > > > > > +                                       };
> > > > > > > +                               };
> > > > > > > +                       };
> > > > > > > +
> > > > > > > +
> > > > > > >                         usbotg1: usb@32e40000 {
> > > > > > >                                 compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> > > > > > >                                 reg = <0x32e40000 0x200>;
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart
