Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631DB377FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhEJJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:49:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47758 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhEJJtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:49:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24EF020016E;
        Mon, 10 May 2021 11:48:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15CE5200165;
        Mon, 10 May 2021 11:48:14 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0024420340;
        Mon, 10 May 2021 11:48:13 +0200 (CEST)
Date:   Mon, 10 May 2021 12:48:13 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Message-ID: <20210510094813.vye2yjdspuqkiocd@fsr-ub1664-175>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
 <20210510040704.14997-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510040704.14997-5-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-10 12:07:04, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
> that support in this driver.
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
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
> index 000000000000..5ca8d6c52917
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
> +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN			BIT(6)
> +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN			BIT(5)
> +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN			BIT(4)
> +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN			BIT(3)
> +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN				GENMASK(2, 0)
> +
> +#define MEDIA_BLK_BUS_PD_MASK					BIT(12)
> +#define MEDIA_BLK_MIPI_CSI_PD_MASK				GENMASK(11, 10)
> +#define MEDIA_BLK_MIPI_DSI_PD_MASK				GENMASK(9, 8)
> +#define MEDIA_BLK_LCDIF_PD_MASK					GENMASK(7, 6)
> +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK				GENMASK(5, 0)
> +
> +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] = {
> +	IMX_BLK_CTL_PD("CSI_BRIDGE", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
> +		       MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0, MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> +		       IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("LCDIF", "dispmix", IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
> +		       MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> +	IMX_BLK_CTL_PD("MIPI_DSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
> +		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0, MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> +		       IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("MIPI_CSI", "mipi", IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
> +		       MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> +		       MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN | MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> +		       IMX_BLK_CTL_PD_RESET)
> +};
> +
> +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] = {
> +	IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2", IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
> +		       BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1", IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
> +		       BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
> +	IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1", IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
> +		       BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),
> +};
> +
> +static const struct regmap_config imx8mm_blk_ctl_regmap_config = {
> +	.reg_bits		= 32,
> +	.reg_stride		= 4,
> +	.val_bits		= 32,
> +	.max_register		= 0x30,
> +	.fast_io		= true,
> +};
> +
> +static const struct imx_blk_ctl_dev_data imx8mm_vpumix_blk_ctl_dev_data = {
> +	.pds = imx8mm_vpumix_blk_ctl_pds,
> +	.pds_num = ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
> +	.hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, IMX8MM_BLK_CTL_PD_VPU_H1, 0x4, BIT(2), 0, BIT(2),
> +				 IMX_BLK_CTL_PD_HANDSHAKE),
> +	.config = imx8mm_blk_ctl_regmap_config,
> +	.active_pd_names = (char*[]){"vpumix", "g1", "g2", "h1"},
> +	.num_active_pd = 4,
> +};
> +
> +static const struct imx_blk_ctl_dev_data imx8mm_dispmix_blk_ctl_dev_data = {
> +	.pds = imx8mm_dispmix_blk_ctl_pds,
> +	.pds_num = ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> +	.hw_hsk = IMX_BLK_CTL_PD(NULL, NULL, -1, 0x4, MEDIA_BLK_BUS_PD_MASK, 0,
> +				 MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> +				 IMX_BLK_CTL_PD_HANDSHAKE | IMX_BLK_CTL_PD_RESET),
> +	.config = imx8mm_blk_ctl_regmap_config,
> +	.active_pd_names = (char*[]){"dispmix", "mipi"},
> +	.num_active_pd = 2,
> +};
> +
> +static int imx8mm_blk_ctl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +	struct regmap *regmap;
> +	struct imx_blk_ctl *ctl;
> +	void __iomem *base;
> +
> +	ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> +	if (!ctl)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ctl->regmap = regmap;
> +	ctl->dev = dev;
> +	ctl->power_count = 0;
> +	mutex_init(&ctl->lock);
> +
> +	ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
> +	if (ctl->num_clks < 0)
> +		return ctl->num_clks;
> +
> +	dev_set_drvdata(dev, ctl);
> +	ctl->dev_data = dev_data;
> +
> +	return imx_blk_ctl_register(dev);
> +}

Nitpick:

Pretty sure all the other platforms will have a similar probe function.
So maybe we can move this into the generic and call it imx8_blk_ctl_register
and pass on the PDs, dev data and regmap_config. 

We could also do this later on when i.MX8MP variant will be done. 

> +
> +static const struct of_device_id imx_blk_ctl_of_match[] = {
> +	{ .compatible = "fsl,imx8mm-vpumix-blk-ctl", .data = &imx8mm_vpumix_blk_ctl_dev_data },
> +	{ .compatible = "fsl,imx8mm-dispmix-blk-ctl", .data = &imx8mm_dispmix_blk_ctl_dev_data },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
> +
> +static struct platform_driver imx_blk_ctl_driver = {
> +	.probe = imx8mm_blk_ctl_probe,
> +	.driver = {
> +		.name = "imx8mm-blk-ctl",
> +		.of_match_table = of_match_ptr(imx_blk_ctl_of_match),
> +		.pm = &imx_blk_ctl_pm_ops,
> +	},
> +};
> +module_platform_driver(imx_blk_ctl_driver);
> -- 
> 2.30.0
> 
