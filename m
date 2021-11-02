Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78634432B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhKBQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhKBQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:10:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B48C06120D;
        Tue,  2 Nov 2021 09:07:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g14so15495804edz.2;
        Tue, 02 Nov 2021 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKsi0gNsWVdKS4/vvkqr+87tJGr9HDLo2MtpySdfgw4=;
        b=V5w+8C4S55NOl48TX7gaNI/dniNqiSMhjjFZlplT4h7K4djIOoZYWF9syCSGk8dVMC
         0jq0IdlE4l1i/fbaki+j/LSJZw6xghUHq22yXCz2giqgUZALn5Va2vUS6vCf/GH34x1+
         45CX7RWunG9XyWL40856t4B9l85rTOOs+iVvH8FDUFVQ65ALHLJVdfrXTxcJ6f1JIMdJ
         EnQZ9JAKKGQy729CPLmeLSk4XQdwo6qFvNIcmAm/E5oO8deTzPkuFgyLGoyS5r2HqaC/
         VO+LmNB09eKTQiXqkYLidfjBJsJg3o7p+rp+0VlubJAU+iWmRdeG5a3GusO+NbG2bT2M
         ZPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKsi0gNsWVdKS4/vvkqr+87tJGr9HDLo2MtpySdfgw4=;
        b=GAHwapvICpHf+2K4IH9D0/1M/U+JVNB3QGO33nrWTlYlXPCE0tolcgoCtb2YpFUN+f
         hdirzaJH99OcuMVNF7FvXR/wOgCgQ/G5xtNdmqI6MdnCL790iHP7omuvVQd9VHal8I4T
         Hk/dgZLTLhBYtdtUX7xDFME+VhWFHNsSLXs/GhlTb5rClCemEZlpGTHrFTaOnNdpw1PK
         LhFY5BTmW7wLRXDnewNKhYEdYfuI0mXl2YfvSHM7OGfHFfhkh0dGrcohC54v1l+v6nC/
         VJUJF3vCWcY0jpcHJlF35jJiG34TqHcjv3AdFB5xmxyusgMVbIZ5cvVioIIYIP8Eu9K/
         mFhA==
X-Gm-Message-State: AOAM530Z/JWwsyyuKF7Kfc/AHcU5ohcRYFEuHjwMNzu/vx1H/lV6pnE1
        NsjXXkDzFxIm4+1TNJkuh0RLlLZxUG0Y27WbjSA=
X-Google-Smtp-Source: ABdhPJzzY2V4V5GKqSbsFSMReaYFNWYyWYl9vT7+SctYgPCXZiC6eVFJykWSncBbc2+TQR2pnWuY08nNwuVUbRWuFak=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr51234178edv.347.1635869233148;
 Tue, 02 Nov 2021 09:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211101222857.6940-1-tomm.merciai@gmail.com> <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
 <20211101225827.GA9208@tom-desktop> <CAHCN7xLDHCQoA41FJpP3GY+nbFm99zf=tspHSOXkeFogMF22+A@mail.gmail.com>
 <20211102115739.GA48972@tom-ThinkBook-14-G2-ARE> <CAHCN7xLoePWS33HsFANcHQB2-VgQVNG40EgDoz+-xba810XPBQ@mail.gmail.com>
 <20211102154742.GA86474@tom-ThinkBook-14-G2-ARE>
In-Reply-To: <20211102154742.GA86474@tom-ThinkBook-14-G2-ARE>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 2 Nov 2021 11:07:01 -0500
Message-ID: <CAHCN7xJtDtBNJ-rFcveya8TGr8+jA-HrDBxPYfZx=fiv7w5UPA@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 10:47 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
>
> On Tue, Nov 02, 2021 at 07:23:06AM -0500, Adam Ford wrote:
> > The upcoming 5.16 kernel will have a new blk-ctrl driver which will
> > work in conjunction with the GPC.  You can see it in linux-next [1],
> > and I would expect it to be present in 5.16-rc1 once the merge is
> > done.
> >
> > In [1], Look for :
> >
> > disp_blk_ctrl: blk-ctrl@32e28000 {
> >     compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
> >
> > It creates a bunch of virtual power domains which are effectively the
> > resets for the VPU, CSI, DSI, and LCDIF [2].
> >
> > Basically, to pull the respective device out of reset, you'd reference
> > them using power-domains.  I have an RFC patch for the CSI located [3]
> > which should bring the GPC power domain up, then take the CSI bridge
> > and MIPI_CSI out of reset using the blk-ctrl.  A few of us are still
> > investigating the CSI bridge and mipi_csi drivers to determine what's
> > going wrong, but  inside that patch, you'll see that we reference
> > "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;" and
> > "power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;" which
> > are part of the new blk-ctrl driver @32e2800.  Other peripherals like
> > LCD, DSI, and the VPU's should be able to reference their respective
> > power domains to activate the corresponding resets after enabling the
> > proper GPC power domain.
>
>   Hi Adam,
>   Then is all done right. Using this this new driver/dts node eLCDIF/mipi_dsi
>   module are out of reset. Thanks for the tips. I'm trying to get eLCDIF/mipi_dsi
>   work on mainline. I try to get work
>
>   - eLCDIF using: mxsfb_drv.c
>   - mipi_dsi using: nwl-dsi.c
>
>   What do you think about? You think that can be a good way ( taking
>   imx8mq as reference )?

The DSI controller for the 8MM and 8MN is not the same as the DSI
controller on the 8MQ, but the LCDIF controller should be compatible.

There have been several attempts to support the 8MM DSI, but none of
them have been accepted for various reasons.

The latest was found here [1], but others [2]  and [3] , when used
together, do something similar.

If memory serves, the main issue has to do with the fact that the DSIM
controller in the 8MM and 8MN is also present in one of the Samsung
processors, and the goal is to rework those drivers so we'll have one
driver that supports both Samsung progressors and NXP instead of
having two duplicate drivers doing the same thing. When whatever
driver is chosen is ready, it'll be likely that the LCDIF will use
power-domains = <&disp_blk_ctrl MX8MM_DISPBLK_PD_LCDIF> and the DSI
node will use power-domains = <&disp_blk_ctrl
IMX8MM_DISPBLK_PD_MIPI_DSI> to pull their respective devices out of
reset and enable the gpc.


[1] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=510489&archive=both&state=*
[2] - https://patchwork.kernel.org/project/dri-devel/list/?series=347439&archive=both&state=*
[3] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=359775&archive=both&state=*
>
>   Let me know.
>   Thanks,
>
>   Tommaso
> >
> >
> > [1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi?h=next-20211102
> > [2] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/power/imx8mm-power.h?h=next-20211102
> > [3] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211023203457.1217821-2-aford173@gmail.com/
> >
> > On Tue, Nov 2, 2021 at 6:59 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> > >
> > > On Mon, Nov 01, 2021 at 11:22:21PM -0500, Adam Ford wrote:
> > > > On Mon, Nov 1, 2021 at 5:58 PM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 01, 2021 at 11:35:49PM +0100, Ahmad Fatoum wrote:
> > > > > > Hello Tommaso,
> > > > > >
> > > > > > On 01.11.21 23:28, Tommaso Merciai wrote:
> > > > > > > Add system controller node for registers of module Display Block Control
> > > > > > > (DISPLAY_BLK_CTRL, base address: 0x32e28000).
> > > > > > > The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
> > > > > > > which control varied features of the associated peripherals.
> > > > > > > Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > > index 2f632e8ca388..3e496b457e1a 100644
> > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > > > > > @@ -961,6 +961,11 @@ aips4: bus@32c00000 {
> > > > > > >                     #size-cells = <1>;
> > > > > > >                     ranges = <0x32c00000 0x32c00000 0x400000>;
> > > > > > >
> > > > > > > +                   dispmix_gpr: display-gpr@32e28000 {
> > > > > > > +                           compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";
> > > > > >
> > > > > > Please read vendor patches before submitting them. The space
> > > > > > is out-of-place in the compatible and the compatible is wrong:
> > > > > > This doesn't look like a i.MX8MM pin controller.
> > > > > >
> > > > > > Cheers,
> > > > > > Ahmad
> > > > >
> > > > >   Hi Ahmad,
> > > > >   Thanks for your review. Do you think this is correct?
> > > > >
> > > > >   compatible = "fsl,imx8mm-dispmix-gpr", "syscon";
> > > > >
> > > > >   Let me know.
> > > >
> > > > There was already a driver created for the blk-ctrl stuff and it has a
> > > > device tree binding at 32e28000.  It's tied into the power-domain
> > > > system, so if you want to enable the csi, dsi, or lcd, etc. you can
> > > > just reference the blt-ctrl power domain index, and it enables the
> > > > device's gpc power domain and takes the corresponding device out of
> > > > reset.
> > >
> > >   Hi Adam,
> > >   You mean using the gpcv2.c driver?
> > >
> > >   drivers/soc/imx/gpcv2.c
> > >
> > >   With the following node, to put out of reset eLCDIF and mipi_dsi:
> > >
> > >   gpc: gpc@303a0000 {
> > >         compatible = "fsl,imx8mm-gpc";
> > >         reg = <0x303a0000 0x10000>;
> > >         interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> > >         interrupt-parent = <&gic>;
> > >         interrupt-controller;
> > >         #interrupt-cells = <3>;
> > >
> > >         pgc {
> > >
> > >          #address-cells = <1>;
> > >          #size-cells = <0>;
> > >          pgc_mipi: power-domain@0 {
> > >                                         #power-domain-cells = <0>;
> > >                                         reg = <IMX8M_POWER_DOMAIN_MIPI>;
> > >                                   };
> > >
> > >         pgc_disp: power-domain@7 {
> > >                                         #power-domain-cells = <0>;
> > >                                         reg = <IMX8M_POWER_DOMAIN_DISP>;
> > >                                  };
> > >    };
> > >   };
> > >
> > >   Let me know.
> > >
> > >   Thanks,
> > >   Tommaso
> > >
> > > >
> > > > adam
> > > > >
> > > > >   Thanks,
> > > > >   Tommaso
> > > > >
> > > > > >
> > > > > > > +                           reg = <0x32e28000 0x100>;
> > > > > > > +                   };
> > > > > > > +
> > > > > > >                     usbotg1: usb@32e40000 {
> > > > > > >                             compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
> > > > > > >                             reg = <0x32e40000 0x200>;
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Pengutronix e.K.                           |                             |
> > > > > > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > > > > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
