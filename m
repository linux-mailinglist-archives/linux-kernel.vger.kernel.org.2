Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42B53A6F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhFNTcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:32:23 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:37806 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhFNTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:32:21 -0400
Received: by mail-ej1-f48.google.com with SMTP id ce15so18416804ejb.4;
        Mon, 14 Jun 2021 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSpnw+tTY8+Kyz/sVjltk30bkCcnr49vv8cnl01H+2g=;
        b=u3uz5ayPQt6Ko6lD/4N9IPjiIfUk/aztJpMTPza3WAmYzG0aaNdNQKs/Ofso8g8HjK
         Ph/z1CROjhSCcMbl5t5smYJU9Wie465duhKElXvGt2hD/CGV9pnig/2ti65TUEntsqgb
         Pv4b51bWexzMLHDf/z7FBs6pibRzuBVA9nPvUGpqyyVc0mNNFGyyWBRljp9YWtmx7eCQ
         XiKqf2a2Lf7wM+eHzXqwZBuSu+FfDhK5fmo0xmwbeblFIauO9wLwdY/qrZKb+Y0o/wRX
         nVpU0YmR6WXoGscirc7UNxd4wDG7PcFSV1Icuo5cfhzZLLqcxB6JCEkZ1bAFpUUDlHBm
         Ihrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSpnw+tTY8+Kyz/sVjltk30bkCcnr49vv8cnl01H+2g=;
        b=SPIttIppKigHNxbIEE8VfXAWV3+zLtkSWIgxVDD4JzdL+oF+gCy+/8l/FYWFf3iDbZ
         VLiXtFvjPMbN1UVaK+Evyv0zCp+pay5iCmMamsGGfW+DvNs9PhsC24tXgLxQqqPKM8g8
         /ps10dBcJY1YBf+55mHMP2TMWhv0p1tEHRFyICFGi+2nSP6XI8X0NTOsqpWz2j6eCh7T
         oJCBl2aAuB4bb6lAMP8pX/UoBPsE7OEH9iRWKYESRpPB+2tv3lmnNKIVCfnrzhi3oUAK
         fNBfeepta2VO639BVvIrsFk9PltIlJLPUrsC1olB+y1lRYbAiUBFRqyD4ZGfPVOIWifH
         fY6A==
X-Gm-Message-State: AOAM530uYahbGseVra6zitOZrC3SfgKO02i+TKaSu6Dwrmxail8Rk6v8
        /Z4MBdBqlcEfYu6H7YK2zqBN5iAMq8ajcmRQe4U=
X-Google-Smtp-Source: ABdhPJw8IYTIfAj68hdl2jyoR72c87eC1VvHHBjtRgofO0TBkO0YEdojGvJt5eFypteniN48sjD/c0cfODSonbitXhc=
X-Received: by 2002:a17:907:70d3:: with SMTP id yk19mr10228672ejb.450.1623698957355;
 Mon, 14 Jun 2021 12:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210612133134.2738-1-peng.fan@oss.nxp.com> <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
In-Reply-To: <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 14 Jun 2021 14:29:06 -0500
Message-ID: <CAHCN7xK86pdcx_BouriGTchnBdamNN1Cjjh-UuF-Oy=abq7rrw@mail.gmail.com>
Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
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
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 1:07 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
> > that support in this driver.
> >
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> Maybe my TF-A is too old, but I am not able to wake the device from
> suspend-to-ram with this series.  I used the device tree from [1] to
> enable both the GPCv2 and the blk-ctl stuff.
>
> [1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210604111005.6804-1-peng.fan@oss.nxp.com/
>
> I based both off Shawn's for-next branch.

I tried to enable USB with the GPCv2 stuff pulled into Shawn's
for-next branch, and my board hangs when USB is loaded, but USB
doesn't use blk-ctl, it just uses GPCv2.

I looked at some of the changes with GPCv2, and I noticed a comment in
the GPCv2 function called imx_pgc_power_up.  The comment reads:

/*
* ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
*   (reg_val & domain->bits.hskack), 0,
*   USEC_PER_MSEC);
* Technically we need the commented code to wait handshake. But that needs
* the BLK-CTL module BUS clk-en bit being set.
*
* There is a separate BLK-CTL module and we will have such a driver for it,
* that driver will set the BUS clk-en bit and handshake will be triggered
* automatically there. Just add a delay and suppose the handshake finish
* after that.
*/

I didn't see a delay here despite the comment saying we should add one.

With the blk-ctl enabled, I attempted to uncomment the above line of
code without much success in preventing the board from hanging.

If BUS clk-en bit needs to be set in order for the handshake to work,
should all these power domains reference it to bring it up?  If we
decide against using the BUS clk-en bit, what should this delay be?

adam
>
> adam
>
> > ---
> >  drivers/soc/imx/Makefile         |   2 +-
> >  drivers/soc/imx/blk-ctl-imx8mm.c | 139 +++++++++++++++++++++++++++++++
> >  2 files changed, 140 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
> >
> > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> > index d3d2b49a386c..c260b962f495 100644
> > --- a/drivers/soc/imx/Makefile
> > +++ b/drivers/soc/imx/Makefile
> > @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
> >  endif
> >  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> >  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> > -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> > +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o blk-ctl-imx8mm.o
> > diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c b/drivers/soc/imx/blk-ctl-imx8mm.c
> > new file mode 100644
> > index 000000000000..59443588f892
> > --- /dev/null
> > +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2021 NXP
> > + */
> > +
> > +#include <dt-bindings/clock/imx8mm-clock.h>
> > +#include <dt-bindings/power/imx8mm-power.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "blk-ctl.h"
> > +
> > +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN                     BIT(6)
> > +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN                    BIT(5)
> > +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN                    BIT(4)
> > +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN                  BIT(3)
> > +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN                            GENMASK(2, 0)
> > +
> > +#define MEDIA_BLK_BUS_PD_MASK                                  BIT(12)
> > +#define MEDIA_BLK_MIPI_CSI_PD_MASK                             GENMASK(11, 10)
> > +#define MEDIA_BLK_MIPI_DSI_PD_MASK                             GENMASK(9, 8)
> > +#define MEDIA_BLK_LCDIF_PD_MASK                                        GENMASK(7, 6)
> > +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK                           GENMASK(5, 0)
> > +
> > +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
> > +       IMX_BLK_CTL_PD("CSI_BRIDGE", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
> > +                      MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> > +                      IMX_BLK_CTL_PD_RESET),
> > +       IMX_BLK_CTL_PD("LCDIF", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
> > +                      MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> > +       IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
> > +                      MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> > +                      IMX_BLK_CTL_PD_RESET),
> > +       IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
> > +                      MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> > +                      MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> > +                      IMX_BLK_CTL_PD_RESET),
> > +       IMX_BLK_CTL_PD("DISPMIX_BUS", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_BUS, 0x4,
> > +                      MEDIA_BLK_BUS_PD_MASK, 0, MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> > +                      IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
> > +};
> > +
> > +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
> > +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
> > +                      BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
> > +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
> > +                      BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
> > +       IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
> > +                      BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_RESET),
> > +       IMX_BLK_CTL_PD("VPU_BLK_CTL_BUS", "vpumix", IMX8MM_BLK_CTL_PD_VPU_BUS, 0x4,
> > +                      BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
> > +};
> > +
> > +static const struct regmap_config imx8mm_blk_ctl_regmap_config = {
> > +       .reg_bits               = 32,
> > +       .reg_stride             = 4,
> > +       .val_bits               = 32,
> > +       .max_register           = 0x30,
> > +       .fast_io                = true,
> > +};
> > +
> > +static const struct imx_blk_ctl_dev_data imx8mm_vpumix_blk_ctl_dev_data = {
> > +       .pds = imx8mm_vpumix_blk_ctl_pds,
> > +       .pds_num = ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
> > +       .max_num = IMX8MM_BLK_CTL_PD_VPU_MAX,
> > +       .hw_hsk = &imx8mm_vpumix_blk_ctl_pds[3],
> > +       .config = imx8mm_blk_ctl_regmap_config,
> > +       .name = "imx-vpumix-blk-ctl",
> > +};
> > +
> > +static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
> > +       .pds = imx8mm_dispmix_blk_ctl_pds,
> > +       .pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> > +       .max_num = IMX8MM_BLK_CTL_PD_DISPMIX_MAX,
> > +       .hw_hsk = &imx8mm_dispmix_blk_ctl_pds[4],
> > +       .config = imx8mm_blk_ctl_regmap_config,
> > +       .name = "imx-dispmix-blk-ctl",
> > +};
> > +
> > +static int imx8mm_blk_ctl_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> > +       struct regmap *regmap;
> > +       struct imx_blk_ctl *ctl;
> > +       void __iomem *base;
> > +
> > +       ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> > +       if (!ctl)
> > +               return -ENOMEM;
> > +
> > +       base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(base))
> > +               return PTR_ERR(base);
> > +
> > +       regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
> > +       if (IS_ERR(regmap))
> > +               return PTR_ERR(regmap);
> > +
> > +       ctl->regmap = regmap;
> > +       ctl->dev = dev;
> > +       mutex_init(&ctl->lock);
> > +
> > +       ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
> > +       if (ctl->num_clks < 0)
> > +               return ctl->num_clks;
> > +
> > +       dev_set_drvdata(dev, ctl);
> > +       ctl->dev_data = dev_data;
> > +
> > +       return imx_blk_ctl_register(dev);
> > +}
> > +
> > +static const struct of_device_id imx_blk_ctl_of_match[] = {
> > +       { .compatible = "fsl,imx8mm-vpumix-blk-ctl", .data = &imx8mm_vpumix_blk_ctl_dev_data },
> > +       { .compatible = "fsl,imx8mm-dispmix-blk-ctl", .data = &imx8mm_dispmix_blk_ctl_dev_data },
> > +       { /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
> > +
> > +static struct platform_driver imx_blk_ctl_driver = {
> > +       .probe = imx8mm_blk_ctl_probe,
> > +       .driver = {
> > +               .name = "imx8mm-blk-ctl",
> > +               .of_match_table = of_match_ptr(imx_blk_ctl_of_match),
> > +               .pm = &imx_blk_ctl_pm_ops,
> > +       },
> > +};
> > +module_platform_driver(imx_blk_ctl_driver);
> > --
> > 2.30.0
> >
