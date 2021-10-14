Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16AF42D8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhJNMDB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Oct 2021 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhJNMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:03:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA31C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:00:56 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mazPk-00008i-29; Thu, 14 Oct 2021 14:00:48 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mazPj-00055W-Ot; Thu, 14 Oct 2021 14:00:47 +0200
Message-ID: <8241fb1053df3583d9f4f0698907038c8f4ac769.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] reset: mchp: sparx5: Extend support for lan966x
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, robh+dt@kernel.org,
        andrew@lunn.ch, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 14 Oct 2021 14:00:47 +0200
In-Reply-To: <20211013073807.2282230-3-horatiu.vultur@microchip.com>
References: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
         <20211013073807.2282230-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-13 at 09:38 +0200, Horatiu Vultur wrote:
> This patch extends sparx5 driver to support also the lan966x. The
> process to reset the switch is the same only it has different offsets.
> Therefore make the driver more generic and add support for lan966x.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/reset/Kconfig                  |  2 +-
>  drivers/reset/reset-microchip-sparx5.c | 81 +++++++++++++++++++++++---
>  2 files changed, 74 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index be799a5abf8a..36ce6c8bcf1e 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -116,7 +116,7 @@ config RESET_LPC18XX
>  
>  config RESET_MCHP_SPARX5
>  	bool "Microchip Sparx5 reset driver"
> -	depends on ARCH_SPARX5 || COMPILE_TEST
> +	depends on ARCH_SPARX5 || SOC_LAN966 || COMPILE_TEST
>  	default y if SPARX5_SWITCH
>  	select MFD_SYSCON
>  	help
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
> index f01e7db8e83b..211ee338e4b6 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -6,6 +6,7 @@
>   * The Sparx5 Chip Register Model can be browsed at this location:
>   * https://github.com/microchip-ung/sparx-5_reginfo
>   */
> +#include <linux/gpio/consumer.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_device.h>
>  #include <linux/module.h>
> @@ -13,15 +14,22 @@
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>  
> -#define PROTECT_REG    0x84
> -#define PROTECT_BIT    BIT(10)
> -#define SOFT_RESET_REG 0x00
> -#define SOFT_RESET_BIT BIT(1)
> +struct reset_props {
> +	u32 protect_reg;
> +	u32 protect_bit;
> +	u32 reset_reg;
> +	u32 reset_bit;
> +	u32 cuphy_reg;
> +	u32 cuphy_bit;
> +};
>  
>  struct mchp_reset_context {
>  	struct regmap *cpu_ctrl;
>  	struct regmap *gcb_ctrl;
> +	struct regmap *cuphy_ctrl;
>  	struct reset_controller_dev rcdev;
> +	const struct reset_props *props;
> +	struct gpio_desc *phy_reset_gpio;
>  };
>  
>  static struct regmap_config sparx5_reset_regmap_config = {
> @@ -36,17 +44,39 @@ static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
>  	struct mchp_reset_context *ctx =
>  		container_of(rcdev, struct mchp_reset_context, rcdev);
>  	u32 val;
> +	int err;
>  
>  	/* Make sure the core is PROTECTED from reset */
> -	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
> +	regmap_update_bits(ctx->cpu_ctrl, ctx->props->protect_reg,
> +			   ctx->props->protect_bit, ctx->props->protect_bit);
>  
>  	/* Start soft reset */
> -	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> +	regmap_write(ctx->gcb_ctrl, ctx->props->reset_reg,
> +		     ctx->props->reset_bit);
>  
>  	/* Wait for soft reset done */
> -	return regmap_read_poll_timeout(ctx->gcb_ctrl, SOFT_RESET_REG, val,
> -					(val & SOFT_RESET_BIT) == 0,
> +	err = regmap_read_poll_timeout(ctx->gcb_ctrl, ctx->props->reset_reg, val,
> +					(val & ctx->props->reset_bit) == 0,
>  					1, 100);
> +	if (err)
> +		return err;
> +
> +	if (!ctx->cuphy_ctrl)
> +		return 0;
> +
> +	/* In case there are external PHYs toggle the GPIO to release the reset
> +	 * of the PHYs
> +	 */
> +	if (ctx->phy_reset_gpio) {
> +		gpiod_direction_output(ctx->phy_reset_gpio, 1);
> +		gpiod_set_value(ctx->phy_reset_gpio, 0);
> +		gpiod_set_value(ctx->phy_reset_gpio, 1);
> +		gpiod_set_value(ctx->phy_reset_gpio, 0);
> +	}
> +
> +	/* Release the reset of internal PHY */
> +	return regmap_update_bits(ctx->cuphy_ctrl, ctx->props->cuphy_reg,
> +				  ctx->props->cuphy_bit, ctx->props->cuphy_bit);
>  }
>  
>  static const struct reset_control_ops sparx5_reset_ops = {
> @@ -111,17 +141,52 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	/* This resource is required on lan966x, to take the internal PHYs out
> +	 * of reset

Ah, here we go, required on lan966x. This should be reflected in the
binding yaml.

> +	 */
> +	err = mchp_sparx5_map_syscon(pdev, "cuphy-syscon", &ctx->cuphy_ctrl);
> +	if (err && err != -ENODEV)
> +		return err;

So -ENODEV should return an error if .cuphy_reg is set?

> +
>  	ctx->rcdev.owner = THIS_MODULE;
>  	ctx->rcdev.nr_resets = 1;
>  	ctx->rcdev.ops = &sparx5_reset_ops;
>  	ctx->rcdev.of_node = dn;
> +	ctx->props = device_get_match_data(&pdev->dev);
> +
> +	ctx->phy_reset_gpio = devm_gpiod_get_optional(&pdev->dev, "phy-reset",
> +						      GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->phy_reset_gpio)) {
> +		dev_err(&pdev->dev, "Could not get reset GPIO\n");
> +		return PTR_ERR(ctx->phy_reset_gpio);

You could use dev_err_probe() here.

regards
Philipp
