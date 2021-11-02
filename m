Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00BB442DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhKBMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhKBMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:25:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625DC061766;
        Tue,  2 Nov 2021 05:23:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r4so74670600edi.5;
        Tue, 02 Nov 2021 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uw/frYQYQUCQUgL4HQU5XlrPbYtIGiL96Nub35Rc/V4=;
        b=pa3SttPAHkL7VMQUFImO+wcfRVSQuzllX/L4SAR15qIGnSFMolASZZsa58kt92FZZv
         +AorJYIQK0KJxiqHG6DAL02iZoaZ3P0fhAEUPlF3zhF7bQxoWXi3hRDaEmJa6M/lSoTo
         nVMvoT0JM9f+F5YB3NUGkrc0PiRwg/XpFdPih13lET1KFOY51lLiiLSLTQE+Td48Dn2K
         kBR8bJ/LYwuhx6lmylFmcDk9TiyejhksTytZvGbU420X9WJrB4arGiCntIBN70zfM8og
         eXSDBkvgq4iiKFATVK2jiKwzBnkPXuhOrId0sciBBbjxLz6ocIN0zLwddFDle2slSTjJ
         +10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw/frYQYQUCQUgL4HQU5XlrPbYtIGiL96Nub35Rc/V4=;
        b=T6tXWd8Uj2ERgVp3RlQuzVcnpmgUiRNzzaZz63v/Ry2cLaVndTZI0+WIH9fmJITv/y
         7+Wj4SYqK17zdBebM6jxCG/DAfeJmEHFKhy0OKi2a6njrBSW+xCc2HGRVvB4KuijytMo
         uAcwSt00y3itafdgvLL4cVcC/1hOc5jqj3V7YLULpSwxTuLhId7OV02trGv+f12BhEG6
         poq21mEMtbJ7vW7JEzBmyJC9XFgimo0Smr/VIHbTU4O58lyFzcmh7BinJypdWo+p/ghD
         GlnCsJKSdl6gcKWAJxxl9sx0dmPcrSL1qJSTGlXrj7B+0ifWMv23RB2yJLiwDi+iVESM
         KzWg==
X-Gm-Message-State: AOAM5339n3MDMU/InWknyIMwYIGjVOmY6O/iss0jg5vF90+d0hmo7wgz
        0LKvsbBqoF5y2lGBz2nOlSbsWRuh2tIyGLYpQE0=
X-Google-Smtp-Source: ABdhPJzlTdrqGp/Oby3aGVQHjTGH2RAJyGz619KVR8mNWV6AzAFI8I3JzTin8sxD+I+VL2p1x2+I1FyeSk13slzhCQU=
X-Received: by 2002:a17:906:ca18:: with SMTP id jt24mr44963587ejb.325.1635855797464;
 Tue, 02 Nov 2021 05:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211101222857.6940-1-tomm.merciai@gmail.com> <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
 <20211101225827.GA9208@tom-desktop> <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
 <20211102115739.GA48972@tom-ThinkBook-14-G2-ARE>
In-Reply-To: <20211102115739.GA48972@tom-ThinkBook-14-G2-ARE>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 2 Nov 2021 07:23:06 -0500
Message-ID: <CAHCN7xLoePWS33HsFANcHQB2-VgQVNG40EgDoz+-xba810XPBQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl
 module regs
To:     Tommaso Merciai <tomm.merciai@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming 5.16 kernel will have a new blk-ctrl driver which will
work in conjunction with the GPC.  You can see it in linux-next [1],
and I would expect it to be present in 5.16-rc1 once the merge is
done.

In [1], Look for :

disp_blk_ctrl: blk-ctrl@32e28000 {
    compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";

It creates a bunch of virtual power domains which are effectively the
resets for the VPU, CSI, DSI, and LCDIF [2].

Basically, to pull the respective device out of reset, you'd reference
them using power-domains.  I have an RFC patch for the CSI located [3]
which should bring the GPC power domain up, then take the CSI bridge
and MIPI_CSI out of reset using the blk-ctrl.  A few of us are still
investigating the CSI bridge and mipi_csi drivers to determine what's
going wrong, but  inside that patch, you'll see that we reference
"power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;" and
"power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;" which
are part of the new blk-ctrl driver @32e2800.  Other peripherals like
LCD, DSI, and the VPU's should be able to reference their respective
power domains to activate the corresponding resets after enabling the
proper GPC power domain.


[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi?h=next-20211102
[2] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/power/imx8mm-power.h?h=next-20211102
[3] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211023203457.1217821-2-aford173@gmail.com/

On Tue, Nov 2, 2021 at 6:59 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
>
> On Mon, Nov 01, 2021 at 11:22:21PM -0500, Adam Ford wrote:
> > On Mon, Nov 1, 2021 at 5:58 PM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> > >
> > > On Mon, Nov 01, 2021 at 11:35:49PM +0100, Ahmad Fatoum wrote:
> > > > Hello Tommaso,
> > > >
> > > > On 01.11.21 23:28, Tommaso Merciai wrote:
> > > > > Add system controller node for registers of module Display Block Control
> > > > > (DISPLAY_BLK_CTRL, base address: 0x32e28000).
> > > > > The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
> > > > > which control varied features of the associated peripherals.
> > > > > Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
> > > > > ---
> > > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > index 2f632e8ca388..3e496b457e1a 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > @@ -961,6 +961,11 @@ aips4: bus@32c00000 {
> > > > >                     #size-cells = <1>;
> > > > >                     ranges = <0x32c00000 0x32c00000 0x400000>;
> > > > >
> > > > > +                   dispmix_gpr: display-gpr@32e28000 {
> > > > > +                           compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";
> > > >
> > > > Please read vendor patches before submitting them. The space
> > > > is out-of-place in the compatible and the compatible is wrong:
> > > > This doesn't look like a i.MX8MM pin controller.
> > > >
> > > > Cheers,
> > > > Ahmad
> > >
> > >   Hi Ahmad,
> > >   Thanks for your review. Do you think this is correct?
> > >
> > >   compatible = "fsl,imx8mm-dispmix-gpr", "syscon";
> > >
> > >   Let me know.
> >
> > There was already a driver created for the blk-ctrl stuff and it has a
> > device tree binding at 32e28000.  It's tied into the power-domain
> > system, so if you want to enable the csi, dsi, or lcd, etc. you can
> > just reference the blt-ctrl power domain index, and it enables the
> > device's gpc power domain and takes the corresponding device out of
> > reset.
>
>   Hi Adam,
>   You mean using the gpcv2.c driver?
>
>   drivers/soc/imx/gpcv2.c
>
>   With the following node, to put out of reset eLCDIF and mipi_dsi:
>
>   gpc: gpc@303a0000 {
>         compatible = "fsl,imx8mm-gpc";
>         reg = <0x303a0000 0x10000>;
>         interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-parent = <&gic>;
>         interrupt-controller;
>         #interrupt-cells = <3>;
>
>         pgc {
>
>          #address-cells = <1>;
>          #size-cells = <0>;
>          pgc_mipi: power-domain@0 {
>                                         #power-domain-cells = <0>;
>                                         reg = <IMX8M_POWER_DOMAIN_MIPI>;
>                                   };
>
>         pgc_disp: power-domain@7 {
>                                         #power-domain-cells = <0>;
>                                         reg = <IMX8M_POWER_DOMAIN_DISP>;
>                                  };
>    };
>   };
>
>   Let me know.
>
>   Thanks,
>   Tommaso
>
> >
> > adam
> > >
> > >   Thanks,
> > >   Tommaso
> > >
> > > >
> > > > > +                           reg = <0x32e28000 0x100>;
> > > > > +                   };
> > > > > +
> > > > >                     usbotg1: usb@32e40000 {
> > > > >                             compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> > > > >                             reg = <0x32e40000 0x200>;
> > > > >
> > > >
> > > >
> > > > --
> > > > Pengutronix e.K.                           |                             |
> > > > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
