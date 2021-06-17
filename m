Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063123AB382
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhFQM2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhFQM2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:28:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA88C061574;
        Thu, 17 Jun 2021 05:26:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id di5so3332324ejc.9;
        Thu, 17 Jun 2021 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3TVRDhr4luopUweKfr85DBxbwwXK8Sy+b1ey7mzQeY=;
        b=YhZPQwDy0E8jpQThgvwN57N3hpE8XeRlZ6TNx5SIDTSHMIeWOB8so+JAGdd19UMtBK
         D20igznA+WIj0hOzWj+md44eVTsaBFqAZ5iZ1T1QpGg0F1Kkwj1/hELbaWDVzink2p4C
         9NARUZuVXOINg42uPUXVkDZPIBaBXOiE8mKEJFyE12mcE/8WFkGFuQUoKXmNxUF24yFy
         EOw9net7I5i7XwekV/nK/AdboMoQHf8vfP/N0AKc7fWMAHqbFWVWoh3T5/rPI/+AFyUM
         6O5hUIPSp7I3XDfviupqxmDGSS/F7OzS/UTUbFZ1+u64fgJEXyQd7NZGPiHaFonXryVh
         Vytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3TVRDhr4luopUweKfr85DBxbwwXK8Sy+b1ey7mzQeY=;
        b=GnJ4qD1jJp+PDS2h6L+sSvFLkA9wZ6AMI+8bqn78w5qWOMIxWhv5+GZQF9bUjQ8Svr
         UqAqk3DaL0ZjTqr7Iul/R5e3ytR+9Ed9neq7uWspxgDfwV8vkercI6PKUXU/tIViQS9l
         SXvZ9vxflVr71PoCJlbaB1eNRYhwh1sSf2Cbm+17mO4SWga21b8Qgn5CO9t0+oVE0HLI
         ARl11cIJqni6zknlE+0+zqBfmzOrNWwkCdP9G5jEzD7xFlGCr4IFX7Dyn6OU6ZUZhBgh
         FIBe19kqr/z3LdKElpBGwGv7wTiC1K47Lc18feQ1ozDFwa1btBEBGv6mXjz8Ac0E7ZR2
         HPew==
X-Gm-Message-State: AOAM532f2xxyd99LEufWgEA9iwiwSHUbxm56dQgz42oYOy4XQWcri2Ot
        RlhRQaqLOrc0HlvjzxKjeuOnf813897ok5w9SWI=
X-Google-Smtp-Source: ABdhPJyDAY/Iqx/8tko+9HxeiXE+1lqE5Oec0+Op5lvrKDtbuC2yszisOVUGLe4LIYgIkqVhUt9UqMGlgVdsolzuBP8=
X-Received: by 2002:a17:907:70d3:: with SMTP id yk19mr4915750ejb.450.1623932758405;
 Thu, 17 Jun 2021 05:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210612133134.2738-1-peng.fan@oss.nxp.com> <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
 <CAHCN7xK86pdcx_BouriGTchnBdamNN1Cjjh-UuF-Oy=abq7rrw@mail.gmail.com>
 <7683ab0b-f905-dff1-aa4f-76ad638da568@oss.nxp.com> <CAHCN7xLZZSwbjrUTb6uBOqWYWJdS_+nSr+iPDnh+dNLFSQOuLQ@mail.gmail.com>
 <AM5PR0402MB2756584781B774A75378D28F880E9@AM5PR0402MB2756.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0402MB2756584781B774A75378D28F880E9@AM5PR0402MB2756.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Jun 2021 07:25:47 -0500
Message-ID: <CAHCN7xL3CtNN9qY_gCt-pZhqjNf1YMhwTqRBQOWXuj_D2no9cg@mail.gmail.com>
Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:14 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> > Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
> >
> > On Tue, Jun 15, 2021 at 6:05 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > >
> > > On 2021/6/15 3:29, Adam Ford wrote:
> > > > On Mon, Jun 14, 2021 at 1:07 PM Adam Ford <aford173@gmail.com>
> > wrote:
> > > >>
> > > >> On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > > >>>
> > > >>> From: Peng Fan <peng.fan@nxp.com>
> > > >>>
> > > >>> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we
> > add
> > > >>> that support in this driver.
> > > >>>
> > > >>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > > >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > >>
> > > >> Maybe my TF-A is too old, but I am not able to wake the device from
> > > >> suspend-to-ram with this series.  I used the device tree from [1]
> > > >> to enable both the GPCv2 and the blk-ctl stuff.
> > > >>
> > > >> [1] -
> > > >> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fp
> > > >>
> > atchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20210604
> > > >>
> > 111005.6804-1-peng.fan%40oss.nxp.com%2F&amp;data=04%7C01%7Cpeng.
> > fan
> > > >> %40nxp.com%7C29fe5fa2af704121c2d508d930b25126%7C686ea1d3bc
> > 2b4c6fa92
> > > >>
> > cd99c5c301635%7C0%7C0%7C637594364693096718%7CUnknown%7CTWF
> > pbGZsb3d8
> > > >>
> > eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%
> > > >>
> > 7C1000&amp;sdata=owV810qvJWHnaoav%2BZDlpd%2FmjALiZkk0uWM44gqj
> > jQ8%3D
> > > >> &amp;reserved=0
> > > >>
> > > >> I based both off Shawn's for-next branch.
> > > >
> > > > I tried to enable USB with the GPCv2 stuff pulled into Shawn's
> > > > for-next branch, and my board hangs when USB is loaded, but USB
> > > > doesn't use blk-ctl, it just uses GPCv2.
> > > >
> > > > I looked at some of the changes with GPCv2, and I noticed a comment
> > > > in the GPCv2 function called imx_pgc_power_up.  The comment reads:
> > > >
> > > > /*
> > > > * ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
> > reg_val,
> > > > *   (reg_val & domain->bits.hskack), 0,
> > > > *   USEC_PER_MSEC);
> > > > * Technically we need the commented code to wait handshake. But that
> > > > needs
> > > > * the BLK-CTL module BUS clk-en bit being set.
> > > > *
> > > > * There is a separate BLK-CTL module and we will have such a driver
> > > > for it,
> > > > * that driver will set the BUS clk-en bit and handshake will be
> > > > triggered
> > > > * automatically there. Just add a delay and suppose the handshake
> > > > finish
> > > > * after that.
> > > > */
> > > >
> > > > I didn't see a delay here despite the comment saying we should add one.
> > > >
> > > > With the blk-ctl enabled, I attempted to uncomment the above line of
> > > > code without much success in preventing the board from hanging.
> > > >
> > > > If BUS clk-en bit needs to be set in order for the handshake to
> > > > work, should all these power domains reference it to bring it up?
> > > > If we decide against using the BUS clk-en bit, what should this delay be?
> > >
> > > It is only for power domain has mix and need delay for the handshake.
> > > USB no need that handshake.
> >
> > Don't the OTG domains depend on hsiomix?
>
>
> It works well with this change in dtsi.
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 0e01ff649956..e930ae3122ec 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1087,6 +1087,7 @@ usbotg1: usb@32e40000 {
>                                 assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
>                                 fsl,usbphy = <&usbphynop1>;
>                                 fsl,usbmisc = <&usbmisc1 0>;
> +                               power-domains = <&pgc_otg1>;
>                                 status = "disabled";
>                         };
>
> @@ -1106,6 +1107,7 @@ usbotg2: usb@32e50000 {
>                                 assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
>                                 fsl,usbphy = <&usbphynop2>;
>                                 fsl,usbmisc = <&usbmisc2 0>;
> +                               power-domains = <&pgc_otg2>;
>                                 status = "disabled";
>                         };
>

Even with USB disabled, I was still having issues resuming from
suspend-to-ram.  I'll enable these and try again.

adam
>
> Regards,
> Peng.
>
> >
> > >
> > > Could you post a github branch, then I could give a look?
> >
> > No problem.
> >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
> > com%2Faford173%2Flinux%2Ftree%2Ffor-next&amp;data=04%7C01%7Cpen
> > g.fan%40nxp.com%7C29fe5fa2af704121c2d508d930b25126%7C686ea1d3bc
> > 2b4c6fa92cd99c5c301635%7C0%7C0%7C637594364693106714%7CUnknow
> > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6tiEiL7TMioVeb88WKHTYxVPxE
> > MT1pboN%2FSMxiKA1yM%3D&amp;reserved=0
> >
> > thanks
> >
> > adam
> >
> > >
> > > Thanks,
> > > Peng.
> > >
> > > >
> > > > adam
> > > >>
> > > >> adam
> > > >>
> > > >>> ---
> > > >>>   drivers/soc/imx/Makefile         |   2 +-
> > > >>>   drivers/soc/imx/blk-ctl-imx8mm.c | 139
> > +++++++++++++++++++++++++++++++
> > > >>>   2 files changed, 140 insertions(+), 1 deletion(-)
> > > >>>   create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
> > > >>>
> > > >>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> > > >>> index d3d2b49a386c..c260b962f495 100644
> > > >>> --- a/drivers/soc/imx/Makefile
> > > >>> +++ b/drivers/soc/imx/Makefile
> > > >>> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
> > > >>>   endif
> > > >>>   obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> > > >>>   obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> > > >>> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> > > >>> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> > blk-ctl-imx8mm.o
> > > >>> diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c
> > > >>> b/drivers/soc/imx/blk-ctl-imx8mm.c
> > > >>> new file mode 100644
> > > >>> index 000000000000..59443588f892
> > > >>> --- /dev/null
> > > >>> +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
> > > >>> @@ -0,0 +1,139 @@
> > > >>> +// SPDX-License-Identifier: GPL-2.0
> > > >>> +/*
> > > >>> + * Copyright 2021 NXP
> > > >>> + */
> > > >>> +
> > > >>> +#include <dt-bindings/clock/imx8mm-clock.h>
> > > >>> +#include <dt-bindings/power/imx8mm-power.h>
> > > >>> +#include <linux/clk.h>
> > > >>> +#include <linux/err.h>
> > > >>> +#include <linux/io.h>
> > > >>> +#include <linux/module.h>
> > > >>> +#include <linux/mutex.h>
> > > >>> +#include <linux/of_address.h>
> > > >>> +#include <linux/of_device.h>
> > > >>> +#include <linux/platform_device.h> #include <linux/slab.h>
> > > >>> +#include <linux/types.h> #include <linux/pm_domain.h> #include
> > > >>> +<linux/regmap.h>
> > > >>> +
> > > >>> +#include "blk-ctl.h"
> > > >>> +
> > > >>> +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN
> > BIT(6)
> > > >>> +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN
> > BIT(5)
> > > >>> +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN
> > BIT(4)
> > > >>> +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN
> > BIT(3)
> > > >>> +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN
> > GENMASK(2, 0)
> > > >>> +
> > > >>> +#define MEDIA_BLK_BUS_PD_MASK
> > BIT(12)
> > > >>> +#define MEDIA_BLK_MIPI_CSI_PD_MASK
> > GENMASK(11, 10)
> > > >>> +#define MEDIA_BLK_MIPI_DSI_PD_MASK
> > GENMASK(9, 8)
> > > >>> +#define MEDIA_BLK_LCDIF_PD_MASK
> > GENMASK(7, 6)
> > > >>> +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK
> > GENMASK(5, 0)
> > > >>> +
> > > >>> +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
> > > >>> +       IMX_BLK_CTL_PD("CSI_BRIDGE", NULL,
> > IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
> > > >>> +                      MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0,
> > MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> > > >>> +                      IMX_BLK_CTL_PD_RESET),
> > > >>> +       IMX_BLK_CTL_PD("LCDIF", NULL,
> > IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
> > > >>> +                      MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> > > >>> +       IMX_BLK_CTL_PD("MIPI_DSI", "mipi",
> > IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
> > > >>> +                      MEDIA_BLK_MIPI_DSI_PD_MASK, 0,
> > MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> > > >>> +                      IMX_BLK_CTL_PD_RESET),
> > > >>> +       IMX_BLK_CTL_PD("MIPI_CSI", "mipi",
> > IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
> > > >>> +                      MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> > > >>> +
> > MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN |
> > MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> > > >>> +                      IMX_BLK_CTL_PD_RESET),
> > > >>> +       IMX_BLK_CTL_PD("DISPMIX_BUS", "dispmix",
> > IMX8MM_BLK_CTL_PD_DISPMIX_BUS, 0x4,
> > > >>> +                      MEDIA_BLK_BUS_PD_MASK, 0,
> > MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> > > >>> +                      IMX_BLK_CTL_PD_HANDSHAKE |
> > > >>> +IMX_BLK_CTL_PD_RESET) };
> > > >>> +
> > > >>> +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
> > > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2",
> > IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
> > > >>> +                      BIT(0), 0, BIT(0),
> > IMX_BLK_CTL_PD_RESET),
> > > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1",
> > IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
> > > >>> +                      BIT(1), 0, BIT(1),
> > IMX_BLK_CTL_PD_RESET),
> > > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1",
> > IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
> > > >>> +                      BIT(2), 0, BIT(2),
> > IMX_BLK_CTL_PD_RESET),
> > > >>> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_BUS", "vpumix",
> > IMX8MM_BLK_CTL_PD_VPU_BUS, 0x4,
> > > >>> +                      BIT(2), 0, BIT(2),
> > IMX_BLK_CTL_PD_HANDSHAKE
> > > >>> +| IMX_BLK_CTL_PD_RESET) };
> > > >>> +
> > > >>> +static const struct regmap_config imx8mm_blk_ctl_regmap_config = {
> > > >>> +       .reg_bits               = 32,
> > > >>> +       .reg_stride             = 4,
> > > >>> +       .val_bits               = 32,
> > > >>> +       .max_register           = 0x30,
> > > >>> +       .fast_io                = true,
> > > >>> +};
> > > >>> +
> > > >>> +static const struct imx_blk_ctl_dev_data
> > imx8mm_vpumix_blk_ctl_dev_data = {
> > > >>> +       .pds = imx8mm_vpumix_blk_ctl_pds,
> > > >>> +       .pds_num = ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
> > > >>> +       .max_num = IMX8MM_BLK_CTL_PD_VPU_MAX,
> > > >>> +       .hw_hsk = &imx8mm_vpumix_blk_ctl_pds[3],
> > > >>> +       .config = imx8mm_blk_ctl_regmap_config,
> > > >>> +       .name = "imx-vpumix-blk-ctl", };
> > > >>> +
> > > >>> +static const struct imx_blk_ctl_dev_data
> > imx8mm_dispmix_blk_ctl_dev_data = {
> > > >>> +       .pds = imx8mm_dispmix_blk_ctl_pds,
> > > >>> +       .pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> > > >>> +       .max_num = IMX8MM_BLK_CTL_PD_DISPMIX_MAX,
> > > >>> +       .hw_hsk = &imx8mm_dispmix_blk_ctl_pds[4],
> > > >>> +       .config = imx8mm_blk_ctl_regmap_config,
> > > >>> +       .name = "imx-dispmix-blk-ctl", };
> > > >>> +
> > > >>> +static int imx8mm_blk_ctl_probe(struct platform_device *pdev) {
> > > >>> +       struct device *dev = &pdev->dev;
> > > >>> +       const struct imx_blk_ctl_dev_data *dev_data =
> > of_device_get_match_data(dev);
> > > >>> +       struct regmap *regmap;
> > > >>> +       struct imx_blk_ctl *ctl;
> > > >>> +       void __iomem *base;
> > > >>> +
> > > >>> +       ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> > > >>> +       if (!ctl)
> > > >>> +               return -ENOMEM;
> > > >>> +
> > > >>> +       base = devm_platform_ioremap_resource(pdev, 0);
> > > >>> +       if (IS_ERR(base))
> > > >>> +               return PTR_ERR(base);
> > > >>> +
> > > >>> +       regmap = devm_regmap_init_mmio(dev, base,
> > &dev_data->config);
> > > >>> +       if (IS_ERR(regmap))
> > > >>> +               return PTR_ERR(regmap);
> > > >>> +
> > > >>> +       ctl->regmap = regmap;
> > > >>> +       ctl->dev = dev;
> > > >>> +       mutex_init(&ctl->lock);
> > > >>> +
> > > >>> +       ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
> > > >>> +       if (ctl->num_clks < 0)
> > > >>> +               return ctl->num_clks;
> > > >>> +
> > > >>> +       dev_set_drvdata(dev, ctl);
> > > >>> +       ctl->dev_data = dev_data;
> > > >>> +
> > > >>> +       return imx_blk_ctl_register(dev); }
> > > >>> +
> > > >>> +static const struct of_device_id imx_blk_ctl_of_match[] = {
> > > >>> +       { .compatible = "fsl,imx8mm-vpumix-blk-ctl", .data =
> > &imx8mm_vpumix_blk_ctl_dev_data },
> > > >>> +       { .compatible = "fsl,imx8mm-dispmix-blk-ctl", .data =
> > &imx8mm_dispmix_blk_ctl_dev_data },
> > > >>> +       { /* Sentinel */ }
> > > >>> +};
> > > >>> +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
> > > >>> +
> > > >>> +static struct platform_driver imx_blk_ctl_driver = {
> > > >>> +       .probe = imx8mm_blk_ctl_probe,
> > > >>> +       .driver = {
> > > >>> +               .name = "imx8mm-blk-ctl",
> > > >>> +               .of_match_table =
> > of_match_ptr(imx_blk_ctl_of_match),
> > > >>> +               .pm = &imx_blk_ctl_pm_ops,
> > > >>> +       },
> > > >>> +};
> > > >>> +module_platform_driver(imx_blk_ctl_driver);
> > > >>> --
> > > >>> 2.30.0
> > > >>>
