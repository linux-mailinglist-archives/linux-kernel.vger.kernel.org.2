Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A553A6DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhFNSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhFNSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:10:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D7EC061574;
        Mon, 14 Jun 2021 11:07:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id my49so18129492ejc.7;
        Mon, 14 Jun 2021 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1Cakn0uG10fNohfx55/ZOz9Y+WYtu4BA3Uf2nTwTa4=;
        b=QD8fCsZywE9b7iWqHYst85IC+XEJvDgHLAfpgWLjQf/LQgkEHm1V8mZBWPG0uau9Yj
         Tchw26YKUMehiVIsNZVxE5oR/0BCk5XMDEYlYXWTLnOFRWnbBXDeK9PXMHz5PzAfwY3K
         xBCHgg7dQisc4KSZQjHb9k2+ImCsJcSG6XBXdlqqhNWBHA0M3Vnpt7SImLEysckYkLZK
         17j4G0sGFoo7oiK/IyTrtI01ikJPxDIkZCZACDYFbWtE+4uwPzbpD1MDx7uXW6Ibiabe
         rIukQRGgISxsEi+H7u8NN0Dp0PdY6JYZaahe+RIhAZ+x9DDylv1hIQzXgLscWi5RT8Nm
         970A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1Cakn0uG10fNohfx55/ZOz9Y+WYtu4BA3Uf2nTwTa4=;
        b=AWpMxHWe4wOuXukgXAU2aQUmSYO1Ts62D/aTznRAek6+vYuxqFHydR7mQ4uKXlz0oO
         k/rf3q8dEyeYortdInCiQHfafDNyaODV+RVBOzuSPxuK073l7L1GwLZygPtU4LwNhyxg
         sUtYtaNBe+xkFS3kRMG6G/ExOSFwCCOhajZ5825z40NNmHHdqE5ER6Sf3Tr55L21TPjW
         fSV0BGbu7ik0Ldyr+OPE1mFELdeuppfUxP31qgIsqaA1zQsujTEB7QzfKaKPArZZN3a7
         TA5/2gqWd9d2Enkj8hHRcpmJtwQ1SQ1S15Ttu+R+BkNbIAJLfY3V35+pAPsyH6QPEhN6
         29Ow==
X-Gm-Message-State: AOAM532idLpc6mrNxBPuJlKsFm3tpT73tMeBxlEwW/gizgBL/PQi0+LS
        FvWcItwnyePqx5UQe1ep6efYakAnPJmiv+kZwN0=
X-Google-Smtp-Source: ABdhPJy1xFAsRYfI0UZo+1HyfDmuO5ykI92Hu1VzokFxr69nVs4s248ozy/HXQvBBo6ZRFRRa/7cWzNsCQhyyNQcsds=
X-Received: by 2002:a17:906:f744:: with SMTP id jp4mr16423991ejb.210.1623694067635;
 Mon, 14 Jun 2021 11:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210612133134.2738-1-peng.fan@oss.nxp.com> <20210612133134.2738-5-peng.fan@oss.nxp.com>
In-Reply-To: <20210612133134.2738-5-peng.fan@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 14 Jun 2021 13:07:36 -0500
Message-ID: <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
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

On Sat, Jun 12, 2021 at 7:58 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
> that support in this driver.
>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Maybe my TF-A is too old, but I am not able to wake the device from
suspend-to-ram with this series.  I used the device tree from [1] to
enable both the GPCv2 and the blk-ctl stuff.

[1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210604111005.6804-1-peng.fan@oss.nxp.com/

I based both off Shawn's for-next branch.

adam

> ---
>  drivers/soc/imx/Makefile         |   2 +-
>  drivers/soc/imx/blk-ctl-imx8mm.c | 139 +++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+), 1 deletion(-)
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
> index 000000000000..59443588f892
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
> @@ -0,0 +1,139 @@
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
> +       IMX_BLK_CTL_PD("CSI_BRIDGE", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
> +                      MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> +                      IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("LCDIF", NULL, IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
> +                      MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> +       IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
> +                      MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> +                      IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
> +                      MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> +                      MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> +                      IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("DISPMIX_BUS", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_BUS, 0x4,
> +                      MEDIA_BLK_BUS_PD_MASK, 0, MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> +                      IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
> +};
> +
> +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
> +                      BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
> +                      BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
> +                      BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_RESET),
> +       IMX_BLK_CTL_PD("VPU_BLK_CTL_BUS", "vpumix", IMX8MM_BLK_CTL_PD_VPU_BUS, 0x4,
> +                      BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET)
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
> +       .max_num = IMX8MM_BLK_CTL_PD_VPU_MAX,
> +       .hw_hsk = &imx8mm_vpumix_blk_ctl_pds[3],
> +       .config = imx8mm_blk_ctl_regmap_config,
> +       .name = "imx-vpumix-blk-ctl",
> +};
> +
> +static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
> +       .pds = imx8mm_dispmix_blk_ctl_pds,
> +       .pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> +       .max_num = IMX8MM_BLK_CTL_PD_DISPMIX_MAX,
> +       .hw_hsk = &imx8mm_dispmix_blk_ctl_pds[4],
> +       .config = imx8mm_blk_ctl_regmap_config,
> +       .name = "imx-dispmix-blk-ctl",
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
