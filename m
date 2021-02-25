Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1E3257DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhBYUli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:41:38 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:43009 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhBYUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:41:30 -0500
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D23AD100005;
        Thu, 25 Feb 2021 20:40:45 +0000 (UTC)
Date:   Thu, 25 Feb 2021 21:40:45 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/3] reset: mchp: sparx5: add switch reset driver
Message-ID: <YDgLTczzqTBCwEUY@piout.net>
References: <20210225095005.1510846-1-steen.hegelund@microchip.com>
 <20210225095005.1510846-3-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225095005.1510846-3-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 25/02/2021 10:50:04+0100, Steen Hegelund wrote:
> The Sparx5 Switch SoC has a number of components that can be reset
> indiviually, but at least the Switch Core needs to be in a well defined
> state at power on, when any of the Sparx5 drivers starts to access the
> Switch Core, this reset driver is available.
> 
> The reset driver is loaded early via the postcore_initcall interface, and
> will then be available for the other Sparx5 drivers (SGPIO, SwitchDev etc)
> that are loaded next, and the first of them to be loaded can perform the
> one-time Switch Core reset that is needed.
> 
> The driver has protection so that the system busses, DDR controller, PCI-E
> and ARM A53 CPU and a few other subsystems are not touched by the reset.
> 
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  drivers/reset/Kconfig                  |   8 ++
>  drivers/reset/Makefile                 |   1 +
>  drivers/reset/reset-microchip-sparx5.c | 151 +++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 drivers/reset/reset-microchip-sparx5.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 71ab75a46491..05c240c47a8a 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -101,6 +101,14 @@ config RESET_LPC18XX
>  	help
>  	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
>  
> +config RESET_MCHP_SPARX5
> +	bool "Microchip Sparx5 reset driver"
> +	depends on HAS_IOMEM || COMPILE_TEST
> +	default y if SPARX5_SWITCH
> +	select MFD_SYSCON
> +	help
> +	  This driver supports switch core reset for the Microchip Sparx5 SoC.
> +
>  config RESET_MESON
>  	tristate "Meson Reset Driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 1054123fd187..341fd9ab4bf6 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
> +obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>  obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
> new file mode 100644
> index 000000000000..36f00ef68f0d
> --- /dev/null
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Microchip Sparx5 Switch Reset driver
> + *
> + * Copyright (c) 2020 Microchip Technology Inc. and its subsidiaries.
> + *
> + * The Sparx5 Chip Register Model can be browsed at this location:
> + * https://github.com/microchip-ung/sparx-5_reginfo
> + */
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#define PROTECT_REG    0x84
> +#define PROTECT_BIT    BIT(10)
> +#define SOFT_RESET_REG 0x00
> +#define SOFT_RESET_BIT BIT(1)
> +
> +struct mchp_reset_context {
> +	struct regmap *cpu_ctrl;
> +	struct regmap *gcb_ctrl;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static struct regmap_config sparx5_reset_regmap_config = {
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +};
> +
> +static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct mchp_reset_context *ctx =
> +		container_of(rcdev, struct mchp_reset_context, rcdev);
> +	u32 val;
> +
> +	/* Make sure the core is PROTECTED from reset */
> +	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
> +
> +	/* Start soft reset */
> +	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> +
> +	/* Wait for soft reset done */
> +	return regmap_read_poll_timeout(ctx->gcb_ctrl, SOFT_RESET_REG, val,
> +					(val & SOFT_RESET_BIT) == 0,
> +					1, 100);
> +}
> +
> +static const struct reset_control_ops sparx5_reset_ops = {
> +	.reset = sparx5_switch_reset,
> +};
> +
> +static int mchp_sparx5_map_syscon(struct platform_device *pdev, char *name,
> +				  struct regmap **target)
> +{
> +	struct device_node *syscon_np;
> +	struct regmap *regmap;
> +	int err;
> +
> +	syscon_np = of_parse_phandle(pdev->dev.of_node, name, 0);
> +	if (!syscon_np)
> +		return -ENODEV;
> +	regmap = syscon_node_to_regmap(syscon_np);
> +	of_node_put(syscon_np);
> +	if (IS_ERR(regmap)) {
> +		err = PTR_ERR(regmap);
> +		dev_err(&pdev->dev, "No '%s' map: %d\n", name, err);
> +		return err;
> +	}
> +	*target = regmap;
> +	return 0;
> +}
> +
> +static int mchp_sparx5_map_io(struct platform_device *pdev, char *name,
> +			      struct regmap **target)
> +{
> +	struct resource *res;
> +	struct regmap *map;
> +	void __iomem *mem;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No '%s' resource\n", name);
> +		return -ENODEV;
> +	}
> +	mem = devm_ioremap(&pdev->dev, res->start, res->end - res->start + 1);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "Could not map '%s' resource\n", name);
> +		return -ENXIO;
> +	}

Someone is going to tell you to use
devm_platform_get_and_ioremap_resource so it may as well be me ;)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
