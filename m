Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195303765A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhEGMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhEGMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:54:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75DDC061574;
        Fri,  7 May 2021 05:53:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s6so10051269edu.10;
        Fri, 07 May 2021 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHRJRdAFkz70G3mNgGnWbhUAZ9vIa3DzZeOxCISpUKY=;
        b=azrQRvLcp4ty12MR/jR4fszxD+JI4w7uBw3PqE17J6SDjalLoSYZeZqUZFoblE7m6v
         WnY6GbnswwRwAn/FLl8ACCkg24Q7DjUncD+PlBnzBuk53fSh74qd7wwqGxIsTKoi+adb
         US/ojLWZLFLLzTabekecnyd1QRFOoYg7X4vq4hiuB/FC2JwivwdtkXy2hkzsPMNjQGF5
         SjnsSAzOf0MuagiPhHzbZenWxXS3aA4onqz2WNmhNoYjtnLGCwRJM0ZgzQHJBhDUHTSE
         XYA8/Fjl5iGFC8bp8MDKY+UoV/Gl6Wpa9TJhgiax5YLvLHlDl6/QLB2W5lc+nQyDhRe7
         FHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHRJRdAFkz70G3mNgGnWbhUAZ9vIa3DzZeOxCISpUKY=;
        b=fRxp+sv4SKIGBdb+o7uxoyCCv+PplrijVkNZrVGfGUNvcXD1Fprn37mYSHLbEafpLL
         KwJzwvNW2ab4Hog0vF4BJBp7Pc9LMja06ws7bbCXL2GjUhImizel57hLMmIs5CaPvY8k
         B7RznJHEzdnxkNEBWedxxPwdhtFqg6k08GEChdN7jBxzWtGwr+Y5c5v7bgglOdSHsAGf
         7DiwQv9Ko5vV/J4BuZ88304hjXoDOshjhOmoEQ3ZKSWz9uXrE+9abgSdozcC1RuHcqih
         /C+UqAx6nWqxbcPjcZcpareVnbbhohpUi1lUols5AR1LWxIAIDV+HqxPkCf1wynH7fCI
         Xjyg==
X-Gm-Message-State: AOAM531GHj+1ecyBL5acrsD40W/4xodCWayq/VE3NmTvzSXd45ANLnOQ
        jq4vCm1VdGyVhaL7rEap+0YhMsieWv2B247PuUU=
X-Google-Smtp-Source: ABdhPJyw8r+3oBy9l6EiYdDA0WJ8tlZkK+T/yhDep7mwrb5uhnO/Ty+ulpQs820MOkIgoe4zJMrAQak0VrZSnHKa6RI=
X-Received: by 2002:a05:6402:20f:: with SMTP id t15mr11207033edv.370.1620392002352;
 Fri, 07 May 2021 05:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210506041555.10719-1-peng.fan@oss.nxp.com> <20210506041555.10719-5-peng.fan@oss.nxp.com>
In-Reply-To: <20210506041555.10719-5-peng.fan@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 7 May 2021 07:53:11 -0500
Message-ID: <CAHCN7x+TM5X4JyqAxRLW-Y4z=yMSSaHrEDfDQXfQezsEGJOcbw@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
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

On Wed, May 5, 2021 at 10:44 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
> that support in this driver.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/Makefile         |   2 +-
>  drivers/soc/imx/blk-ctl-imx8mm.c | 138 +++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
>
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index d3d2b49a386c..c260b962f495 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>  endif
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o blk-ctl-imx8mm.o
> diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c b/drivers/soc/imx/blk-ctl-imx8mm.c
> new file mode 100644
> index 000000000000..cc6e6705f755
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <dt-bindings/clock/imx8mm-clock.h>
> +#include <dt-bindings/power/imx8mm-power.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +
> +#include "blk-ctl.h"
> +
> +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN                     BIT(6)
> +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN                    BIT(5)
> +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN                    BIT(4)
> +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN                  BIT(3)
> +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN                            GENMASK(2, 0)
> +
> +#define MEDIA_BLK_BUS_PD_MASK                                  BIT(12)
> +#define MEDIA_BLK_MIPI_CSI_PD_MASK                             GENMASK(11, 10)
> +#define MEDIA_BLK_MIPI_DSI_PD_MASK                             GENMASK(9, 8)
> +#define MEDIA_BLK_LCDIF_PD_MASK                                        GENMASK(7, 6)
> +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK                           GENMASK(5, 0)
> +
> +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
> +       IMX_BLK_CTL_PD("CSI_BRIDGE", "dispmix", IMX8MM_BLK_CTL_DISPMIX_CSI_BRIDGE, 0x4,
> +                      MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> +                      IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("LCDIF", "dispmix", IMX8MM_BLK_CTL_DISPMIX_LCDIF, 0x4,
> +                      MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> +       IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_DISPMIX_MIPI_DSI, 0x4,
> +                      MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> +                      IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_DISPMIX_MIPI_CSI, 0x4,
> +                      MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> +                      MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> +                      IMX_BLK_CTL_PD_RESET)
> +};
> +
> +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_G2_PD, 0x4,
> +                      BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_G1_PD, 0x4,
> +                      BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_H1_PD, 0x4,
> +                      BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),

Question for you or the group,

I am trying to port this code to the Nano.  I have the various virtual
domains for ISI, CSI, DSI, LCDIF, etc. but the system doesn't wake
from sleep.  I notice that the IMX_BLK_CTL_PD_HANDSHAKE is only used
occasionally, and I was hoping someone could help me identify when
it's needed.  I know the Nano doesn't have the VPU, but I want to make
sure I'm not missing a IMX_BLK_CTL_PD_HANDSHAKE if necessary.

I could also post an RFC to get feedback if that helps.

adam

> +};
> +
> +static const struct regmap_config imx8mm_blk_ctl_regmap_config = {
> +       .reg_bits               = 32,
> +       .reg_stride             = 4,
> +       .val_bits               = 32,
> +       .max_register           = 0x30,
> +       .fast_io                = true,
> +};
> +
> +static const struct imx_blk_ctl_dev_data imx8mm_vpumix_blk_ctl_dev_data = {
> +       .pds = imx8mm_vpumix_blk_ctl_pds,
> +       .pds_num = ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
> +       .hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, IMX8MM_BLK_CTL_H1_PD, 0x4, BIT(2), 0, BIT(2),
> +                                IMX_BLK_CTL_PD_HANDSHAKE),
> +       .config = imx8mm_blk_ctl_regmap_config,
> +       .active_pd_names = (char*[]){"vpumix", "g1", "g2", "h1"},
> +       .num_active_pd = 4,
> +};
> +
> +static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
> +       .pds = imx8mm_dispmix_blk_ctl_pds,
> +       .pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> +       .hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, -1, 0x4, MEDIA_BLK_BUS_PD_MASK, 0,
> +                                MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> +                                IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),
> +       .config = imx8mm_blk_ctl_regmap_config,
> +       .active_pd_names = (char*[]){"dispmix", "mipi"},
> +       .num_active_pd = 2,
> +};
> +
> +static int imx8mm_blk_ctl_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct regmap *regmap;
> +       struct imx_blk_ctl *ctl;
> +       void __iomem *base;
> +
> +       ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> +       if (!ctl)
> +               return -ENOMEM;
> +
> +       base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       ctl->regmap = regmap;
> +       ctl->dev = dev;
> +       ctl->power_count = 0;
> +       mutex_init(&ctl->lock);
> +
> +       ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
> +       if (ctl->num_clks < 0)
> +               return ctl->num_clks;
> +
> +       dev_set_drvdata(dev, ctl);
> +       ctl->dev_data = dev_data;
> +
> +       return imx_blk_ctl_register(dev);
> +}
> +
> +static const struct of_device_id imx_blk_ctl_of_match[] = {
> +       { .compatible = "fsl,imx8mm-vpumix-blk-ctl", .data = &imx8mm_vpumix_blk_ctl_dev_data },
> +       { .compatible = "fsl,imx8mm-dispmix-blk-ctl", .data = &imx8mm_dispmix_blk_ctl_dev_data },
> +       { /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
> +
> +static struct platform_driver imx_blk_ctl_driver = {
> +       .probe = imx8mm_blk_ctl_probe,
> +       .driver = {
> +               .name = "imx8mm-blk-ctl",
> +               .of_match_table = of_match_ptr(imx_blk_ctl_of_match),
> +               .pm = &imx_blk_ctl_pm_ops,
> +       },
> +};
> +module_platform_driver(imx_blk_ctl_driver);
> --
> 2.30.0
>
