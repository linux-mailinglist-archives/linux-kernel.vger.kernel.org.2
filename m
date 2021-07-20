Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632E63CF63B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhGTH4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234547AbhGTH4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A80611F2;
        Tue, 20 Jul 2021 08:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626770223;
        bh=tk64h37rbGdmfMscy8QNd//U3myF1pAkJYpkjcnjgFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGKBr2qu0vtaAN2BSckVMjpj6meSNJepAAzLgh/vVSQOrnNAnf6Cla7PVqUq/E8/P
         LVk7IItDSLURiLi7F1a8ZmOJ0IHixeIx7UgpEu5/iQ+IegrQjAHEFqnkF0GbjAXFPP
         lyEnGfBUmdj3vpG1YQoGxDyHY7ZRBVllEVSGNnQwzoXgW3Bpx8AlScYZinqcvo5OTC
         j1kGEYXtdF1TwVUdT4jwyrpVRnlnCq/X0h9sGIj1okvnsJk3sZfChKPct3NKtQlPO8
         BJxBhbUgFPgCcPMVYSNAtP7gWmfsnj8ybbdrF3vZITmper0cd5wtC3WKbgns//+UdW
         qFhE7HiVoxSfw==
Date:   Tue, 20 Jul 2021 14:06:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: amlogic: Add a new driver for the HDMI TX
 PHY on Meson8/8b/8m2
Message-ID: <YPaLKwEKcDLWwztM@matsya>
References: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
 <20210629182047.893415-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629182047.893415-3-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-21, 20:20, Martin Blumenstingl wrote:
> Amlogic Meson8/8b/8m2 have a built-in HDMI PHY in the HHI register
> region. Unfortunately only few register bits are documented. For
> HHI_HDMI_PHY_CNTL0 the magic numbers are taken from the 3.10 vendor
> kernel.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/phy/amlogic/Kconfig              |  10 ++
>  drivers/phy/amlogic/Makefile             |   1 +
>  drivers/phy/amlogic/phy-meson8-hdmi-tx.c | 162 +++++++++++++++++++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index db5d0cd757e3..486ca23aba32 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -2,6 +2,16 @@
>  #
>  # Phy drivers for Amlogic platforms
>  #
> +config PHY_MESON8_HDMI_TX
> +	tristate "Meson8, Meson8b and Meson8m2 HDMI TX PHY driver"
> +	depends on (ARCH_MESON && ARM) || COMPILE_TEST
> +	depends on OF
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the HDMI TX PHYs found in Meson8,
> +	  Meson8b and Meson8m2 SoCs.
> +	  If unsure, say N.
> +
>  config PHY_MESON8B_USB2
>  	tristate "Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY driver"
>  	default ARCH_MESON
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 8fa07fbd0d92..c0886c850bb0 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_PHY_MESON8_HDMI_TX)		+= phy-meson8-hdmi-tx.o
>  obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
> diff --git a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c b/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
> new file mode 100644
> index 000000000000..ba5a4de54811
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Meson8, Meson8b and Meson8m2 HDMI TX PHY.
> + *
> + * Copyright (C) 2021 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#define HHI_HDMI_PHY_CNTL0				0x0
> +	#define HHI_HDMI_PHY_CNTL0_HDMI_CTL1		GENMASK(31, 16)
> +	#define HHI_HDMI_PHY_CNTL0_HDMI_CTL0		GENMASK(15, 0)
> +
> +#define HHI_HDMI_PHY_CNTL1				0x4
> +	#define HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE		BIT(1)
> +	#define HHI_HDMI_PHY_CNTL1_SOFT_RESET		BIT(0)
> +
> +#define HHI_HDMI_PHY_CNTL2				0x8
> +
> +struct phy_meson8_hdmi_tx_priv {
> +	struct regmap		*hhi;
> +	struct clk		*tmds_clk;
> +	unsigned int		reg_offset;
> +};
> +
> +static int phy_meson8_hdmi_tx_init(struct phy *phy)
> +{
> +	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +
> +	return clk_prepare_enable(priv->tmds_clk);
> +}
> +
> +static int phy_meson8_hdmi_tx_exit(struct phy *phy)
> +{
> +	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +
> +	clk_disable_unprepare(priv->tmds_clk);
> +
> +	return 0;
> +}
> +
> +static int phy_meson8_hdmi_tx_power_on(struct phy *phy)
> +{
> +	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +	unsigned int i;
> +	u16 hdmi_ctl0;
> +
> +	if (clk_get_rate(priv->tmds_clk) >= 2970UL * 1000 * 1000)
> +		hdmi_ctl0 = 0x1e8b;
> +	else
> +		hdmi_ctl0 = 0x4d0b;

magic numbers..? I guess these are register offsets, would be better to
define..

> +
> +	regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL0,
> +		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL1, 0x08c3) |
> +		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL0, hdmi_ctl0));
> +
> +	regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL1, 0x0);
> +
> +	/* Reset three times, just like the vendor driver does */
> +	for (i = 0; i < 3; i++) {
> +		regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL1,
> +			     HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE |
> +			     HHI_HDMI_PHY_CNTL1_SOFT_RESET);
> +		usleep_range(1000, 2000);
> +
> +		regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL1,
> +			     HHI_HDMI_PHY_CNTL1_CLOCK_ENABLE);
> +		usleep_range(1000, 2000);
> +	}
> +
> +	return 0;
> +}
> +
> +static int phy_meson8_hdmi_tx_power_off(struct phy *phy)
> +{
> +	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
> +
> +	regmap_write(priv->hhi, priv->reg_offset + HHI_HDMI_PHY_CNTL0,
> +		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL1, 0x0841) |
> +		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL0, 0x8d00));

more magic..

> +
> +	return 0;
> +}
> +
> +static const struct phy_ops phy_meson8_hdmi_tx_ops = {
> +	.init		= phy_meson8_hdmi_tx_init,
> +	.exit		= phy_meson8_hdmi_tx_exit,
> +	.power_on	= phy_meson8_hdmi_tx_power_on,
> +	.power_off	= phy_meson8_hdmi_tx_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct phy_meson8_hdmi_tx_priv *priv;
> +	struct phy_provider *phy_provider;
> +	struct phy *phy;
> +	u32 reg[2];
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(&pdev->dev, "reg", reg,
> +					     ARRAY_SIZE(reg));

we have reg as single property, why array with 2 entries here?

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to parse the 'reg' property\n");
> +
> +	priv->reg_offset = reg[0];

and mystery deepens, no use of reg[1],  leftover artifacts?

> +
> +	priv->hhi = syscon_node_to_regmap(np->parent);
> +	if (IS_ERR(priv->hhi))
> +		return PTR_ERR(priv->hhi);
> +
> +	priv->tmds_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->tmds_clk))
> +		return PTR_ERR(priv->tmds_clk);
> +
> +	phy = devm_phy_create(&pdev->dev, np, &phy_meson8_hdmi_tx_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, priv);
> +
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev,
> +						     of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id phy_meson8_hdmi_tx_of_match[] = {
> +	{ .compatible = "amlogic,meson8-hdmi-tx-phy" },
> +	{ .compatible = "amlogic,meson8b-hdmi-tx-phy" },
> +	{ .compatible = "amlogic,meson8m2-hdmi-tx-phy" },
> +	{ /* sentinel */ }

I see that all three are handled similarly, no difference!

Maybe also add a amlogic,meson8-hdmi compatible and use that?

-- 
~Vinod
