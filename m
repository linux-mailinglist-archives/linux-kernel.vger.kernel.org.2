Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B420342FB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhJOS6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbhJOS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:58:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2033C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:56:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbSMy-00052W-5B; Fri, 15 Oct 2021 20:55:52 +0200
Message-ID: <b01729b54f43c300307fbf71ac8ad7c973e81f34.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/9] phy: freescale: pcie: initialize the imx8 pcie
 standalone phy driver
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, tharvey@gateworks.com,
        kishon@ti.com, vkoul@kernel.org, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Date:   Fri, 15 Oct 2021 20:55:50 +0200
In-Reply-To: <1634028078-2387-6-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 12.10.2021 um 16:41 +0800 schrieb Richard Zhu:
> Add the standalone i.MX8 PCIe PHY driver.
> Some reset bits should be manipulated between PHY configurations and
> status check(internal PLL is locked or not).
> So, do the PHY configuration in the phy_calibrate().
> And check the PHY is ready or not in the phy_init().
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/phy/freescale/Kconfig              |   9 +
>  drivers/phy/freescale/Makefile             |   1 +
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 218 +++++++++++++++++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index 320630ffe3cd..fb08e5242602 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -14,3 +14,12 @@ config PHY_MIXEL_MIPI_DPHY
>  	help
>  	  Enable this to add support for the Mixel DSI PHY as found
>  	  on NXP's i.MX8 family of SOCs.
> +
> +config PHY_FSL_IMX8M_PCIE
> +	tristate "Freescale i.MX8 PCIE PHY"
> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	default ARCH_MXC

Not sure if we need this default, but if you want to keep it add at
least a "&& ARM64" to not enable it on old 32bit i.MX SoCs.

> +	help
> +	  Enable this to add support for the PCIE PHY as found on
> +	  i.MX8M family of SOCs.
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
> index 1d02e3869b45..55d07c742ab0 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
> +obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> new file mode 100644
> index 000000000000..317cf61bff37
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +#define IMX8MM_PCIE_PHY_CMN_REG061	0x184
> +#define  ANA_PLL_CLK_OUT_TO_EXT_IO_EN	BIT(0)
> +#define IMX8MM_PCIE_PHY_CMN_REG062	0x188
> +#define  ANA_PLL_CLK_OUT_TO_EXT_IO_SEL	BIT(3)
> +#define IMX8MM_PCIE_PHY_CMN_REG063	0x18C
> +#define  AUX_PLL_REFCLK_SEL_SYS_PLL	GENMASK(7, 6)
> +#define IMX8MM_PCIE_PHY_CMN_REG064	0x190
> +#define  ANA_AUX_RX_TX_SEL_TX		BIT(7)
> +#define  ANA_AUX_RX_TERM_GND_EN		BIT(3)
> +#define  ANA_AUX_TX_TERM		BIT(2)
> +#define IMX8MM_PCIE_PHY_CMN_REG065	0x194
> +#define  ANA_AUX_RX_TERM		(BIT(7) | BIT(4))
> +#define  ANA_AUX_TX_LVL			GENMASK(3, 0)
> +#define IMX8MM_PCIE_PHY_CMN_REG75	0x1D4
> +#define  PCIE_PHY_CMN_REG75_PLL_DONE	0x3
> +#define PCIE_PHY_TRSV_REG5		0x414
> +#define  PCIE_PHY_TRSV_REG5_GEN1_DEEMP	0x2D
> +#define PCIE_PHY_TRSV_REG6		0x418
> +#define  PCIE_PHY_TRSV_REG6_GEN2_DEEMP	0xF
> +
> +#define IMX8MM_GPR_PCIE_REF_CLK_SEL	GENMASK(25, 24)
> +#define IMX8MM_GPR_PCIE_REF_CLK_PLL	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3)
> +#define IMX8MM_GPR_PCIE_REF_CLK_EXT	FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2)
> +#define IMX8MM_GPR_PCIE_AUX_EN		BIT(19)
> +#define IMX8MM_GPR_PCIE_CMN_RST		BIT(18)
> +#define IMX8MM_GPR_PCIE_POWER_OFF	BIT(17)
> +#define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
> +#define IMX8MM_GPR_PCIE_REF_USE_PAD	BIT(9)
> +
> +struct imx8_pcie_phy {
> +	u32			refclk_pad_mode;

Moving this to the end of the structure will get rid of a hole due to
padding.

> +	void __iomem		*base;
> +	struct clk		*clk;
> +	struct phy		*phy;
> +	struct regmap		*iomuxc_gpr;
> +	struct reset_control	*reset;
> +};
> +
> +static int imx8_pcie_phy_init(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, pad_mode;
> +	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
> +
> +	reset_control_assert(imx8_phy->reset);
> +
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_REF_USE_PAD,
> +			   imx8_phy->refclk_pad_mode == 1 ?
> +			   IMX8MM_GPR_PCIE_REF_USE_PAD : 0);
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_AUX_EN,
> +			   IMX8MM_GPR_PCIE_AUX_EN);
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_POWER_OFF, 0);
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_SSC_EN, 0);
> +
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_REF_CLK_SEL,
> +			   imx8_phy->refclk_pad_mode == 1 ?
> +			   IMX8MM_GPR_PCIE_REF_CLK_EXT :
> +			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
> +	usleep_range(100, 200);
> +
> +	/* Do the PHY common block reset */
> +	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> +			   IMX8MM_GPR_PCIE_CMN_RST,
> +			   IMX8MM_GPR_PCIE_CMN_RST);
> +	usleep_range(200, 500);
> +
> +
> +	pad_mode = imx8_phy->refclk_pad_mode;
> +	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT) {
> +		/* Configure the pad as input */
> +		val = readl(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +		writel(val & ~ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +	} else if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT) {
> +		/* Configure the PHY to output the refclock via pad */
> +		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
> +		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
> +		val = ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
> +		writel(val | ANA_AUX_RX_TERM_GND_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
> +		writel(ANA_AUX_RX_TERM | ANA_AUX_TX_LVL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
> +	}
> +
> +	/* Tune PHY de-emphasis setting to pass PCIe compliance. */
> +	writel(PCIE_PHY_TRSV_REG5_GEN1_DEEMP,
> +	       imx8_phy->base + PCIE_PHY_TRSV_REG5);
> +	writel(PCIE_PHY_TRSV_REG6_GEN2_DEEMP,
> +	       imx8_phy->base + PCIE_PHY_TRSV_REG6);

I guess those are at least in part board specific. Maybe it would be a
good idea to add DT properties to allow each board to specify the
actual de-emphasis values?

> +
> +	reset_control_deassert(imx8_phy->reset);
> +
> +	/* Polling to check the phy is ready or not. */
> +	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG75,
> +				 val, val == PCIE_PHY_CMN_REG75_PLL_DONE,
> +				 10, 20000);
> +	return ret;
> +}
> +
> +static int imx8_pcie_phy_power_on(struct phy *phy)
> +{
> +	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
> +
> +	return clk_prepare_enable(imx8_phy->clk);
> +}
> +
> +static int imx8_pcie_phy_power_off(struct phy *phy)
> +{
> +	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
> +
> +	clk_disable_unprepare(imx8_phy->clk);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops imx8_pcie_phy_ops = {
> +	.init		= imx8_pcie_phy_init,
> +	.power_on	= imx8_pcie_phy_power_on,
> +	.power_off	= imx8_pcie_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int imx8_pcie_phy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct imx8_pcie_phy *imx8_phy;
> +	struct resource *res;
> +
> +	imx8_phy = devm_kzalloc(dev, sizeof(*imx8_phy), GFP_KERNEL);
> +	if (!imx8_phy)
> +		return -ENOMEM;
> +
> +	/* get PHY refclk pad mode */
> +	of_property_read_u32(np, "fsl,refclk-pad-mode",
> +			     &imx8_phy->refclk_pad_mode);
> +
> +	imx8_phy->clk = devm_clk_get(dev, "phy");
> +	if (IS_ERR(imx8_phy->clk)) {
> +		dev_err(dev, "failed to get imx pcie phy clock\n");
> +		return PTR_ERR(imx8_phy->clk);
> +	}
> +
> +	/* Grab GPR config register range */
> +	imx8_phy->iomuxc_gpr =
> +		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");

I would prefer if we could get the syscon via a phandle and make the
GPR register to use another cell of the handle.

That's not really important for the 8MM, where there is only one PCIe
PHY, but if we want to retrofit this model to the i.MX8MQ, we need to
deal with different GPR offsets for both PHYs and I would like to have
this explicit in the DT. Doing the same here would be good for
consistency.

Overall, looks much better than the last submission.

Regards,
Lucas

> +	if (IS_ERR(imx8_phy->iomuxc_gpr)) {
> +		dev_err(dev, "unable to find iomuxc registers\n");
> +		return PTR_ERR(imx8_phy->iomuxc_gpr);
> +	}
> +
> +	imx8_phy->reset = devm_reset_control_get_exclusive(dev, "pciephy");
> +	if (IS_ERR(imx8_phy->reset)) {
> +		dev_err(dev, "Failed to get PCIEPHY reset control\n");
> +		return PTR_ERR(imx8_phy->reset);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	imx8_phy->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(imx8_phy->base))
> +		return PTR_ERR(imx8_phy->base);
> +
> +	imx8_phy->phy = devm_phy_create(dev, NULL, &imx8_pcie_phy_ops);
> +	if (IS_ERR(imx8_phy->phy))
> +		return PTR_ERR(imx8_phy->phy);
> +
> +	phy_set_drvdata(imx8_phy->phy, imx8_phy);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id imx8_pcie_phy_of_match[] = {
> +	{.compatible = "fsl,imx8mm-pcie-phy",},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
> +
> +static struct platform_driver imx8_pcie_phy_driver = {
> +	.probe	= imx8_pcie_phy_probe,
> +	.driver = {
> +		.name	= "imx8-pcie-phy",
> +		.of_match_table	= imx8_pcie_phy_of_match,
> +	}
> +};
> +module_platform_driver(imx8_pcie_phy_driver);
> +
> +MODULE_DESCRIPTION("FSL IMX8 PCIE PHY driver");
> +MODULE_LICENSE("GPL");


