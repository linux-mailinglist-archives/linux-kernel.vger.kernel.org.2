Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA43242FB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhJOTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbhJOTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:02:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61700C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:00:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbSRM-0005Tk-5y; Fri, 15 Oct 2021 21:00:24 +0200
Message-ID: <57282e6ea0c01dc403c02e245e048d41ec696808.camel@pengutronix.de>
Subject: Re: [PATCH v3 9/9] PCI: imx: add the imx8mm pcie support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, tharvey@gateworks.com,
        kishon@ti.com, vkoul@kernel.org, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Date:   Fri, 15 Oct 2021 21:00:22 +0200
In-Reply-To: <1634028078-2387-10-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-10-git-send-email-hongxing.zhu@nxp.com>
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
> i.MX8MM PCIe works mostly like the i.MX8MQ one, but has a different PHY
> and allows to output the internal PHY reference clock via the refclk pad.
> Add the i.MX8MM PCIe support based on the standalone PHY driver.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 63 ++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 26f49f797b0f..73022e37b1c5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -29,6 +29,7 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
> +#include <linux/phy/phy.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -49,6 +50,7 @@ enum imx6_pcie_variants {
>  	IMX6QP,
>  	IMX7D,
>  	IMX8MQ,
> +	IMX8MM,
>  };
>  
>  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> @@ -80,6 +82,7 @@ struct imx6_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> +	u32			refclk_pad_mode;

As Matthias already noticed: drop this.

>  	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
> @@ -88,6 +91,7 @@ struct imx6_pcie {
>  	struct device		*pd_pcie;
>  	/* power domain for pcie phy */
>  	struct device		*pd_pcie_phy;
> +	struct phy		*phy;
>  	const struct imx6_pcie_drvdata *drvdata;
>  };
>  
> @@ -372,6 +376,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  	case IMX7D:
>  	case IMX8MQ:
>  		reset_control_assert(imx6_pcie->pciephy_reset);
> +		fallthrough;
> +	case IMX8MM:
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;
>  	case IMX6SX:
> @@ -407,7 +413,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
>  {
> -	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
> +	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
> +		imx6_pcie->drvdata->variant != IMX8MM);
>  	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>  
> @@ -447,6 +454,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  	case IMX7D:
>  		break;
>  	case IMX8MQ:
> +	case IMX8MM:
>  		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
>  		if (ret) {
>  			dev_err(dev, "unable to enable pcie_aux clock\n");
> @@ -522,6 +530,14 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  		goto err_ref_clk;
>  	}
>  
> +	switch (imx6_pcie->drvdata->variant) {
> +	case IMX8MM:
> +		if (phy_power_on(imx6_pcie->phy))
> +			pr_info("unable to enable pcie phy clock\n");

It a implementation detail of the PHY driver that this just turns on
the clock. dev_err("unable to power on PHY\n") or something like that.

> +		break;
> +	default:
> +		break;
> +	}
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
>  
> @@ -538,6 +554,10 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	case IMX8MQ:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  		break;
> +	case IMX8MM:
> +		if (phy_init(imx6_pcie->phy) != 0)
> +			dev_err(dev, "Waiting for PHY ready timeout!\n");
> +		break;
>  	case IMX7D:
>  		reset_control_deassert(imx6_pcie->pciephy_reset);
>  
> @@ -614,6 +634,8 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
>  	switch (imx6_pcie->drvdata->variant) {
> +	case IMX8MM:
> +		break;
>  	case IMX8MQ:
>  		/*
>  		 * TODO: Currently this code assumes external
> @@ -753,6 +775,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>  		break;
>  	case IMX7D:
>  	case IMX8MQ:
> +	case IMX8MM:
>  		reset_control_deassert(imx6_pcie->apps_reset);
>  		break;
>  	}
> @@ -871,6 +894,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>  				   IMX6Q_GPR12_PCIE_CTL_2, 0);
>  		break;
>  	case IMX7D:
> +	case IMX8MM:
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;
>  	default:
> @@ -930,6 +954,7 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>  		break;
>  	case IMX8MQ:
> +	case IMX8MM:
>  		clk_disable_unprepare(imx6_pcie->pcie_aux);
>  		break;
>  	default:
> @@ -985,6 +1010,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct imx6_pcie *imx6_pcie;
>  	struct device_node *np;
>  	struct resource *dbi_base;
> +	struct device_node *phy_node;
>  	struct device_node *node = dev->of_node;
>  	int ret;
>  	u16 val;
> @@ -1019,6 +1045,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx6_pcie->phy_base);
>  	}
>  
> +	imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(imx6_pcie->phy)) {
> +		if (PTR_ERR(imx6_pcie->phy) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		/* Set NULL if there is no pcie-phy */
> +		imx6_pcie->phy = NULL;
> +	}

Move this into the i.MX8MM specific section below. The PHY is required
on the 8MM and we should not ignore any errors.

Regards,
Lucas

> +
>  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
>  	if (IS_ERR(pci->dbi_base))
> @@ -1090,6 +1124,18 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx6_pcie->apps_reset);
>  		}
>  		break;
> +	case IMX8MM:
> +		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> +		if (IS_ERR(imx6_pcie->pcie_aux))
> +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> +					     "pcie_aux clock source missing or invalid\n");
> +		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> +									 "apps");
> +		if (IS_ERR(imx6_pcie->apps_reset)) {
> +			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> +			return PTR_ERR(imx6_pcie->apps_reset);
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -1130,6 +1176,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  				 &imx6_pcie->tx_swing_low))
>  		imx6_pcie->tx_swing_low = 127;
>  
> +	/* get PHY refclk pad mode if there is PHY node */
> +	phy_node = of_parse_phandle(node, "phys", 0);
> +	if (phy_node) {
> +		of_property_read_u32(phy_node, "fsl,refclk-pad-mode",
> +				     &imx6_pcie->refclk_pad_mode);
> +		of_node_put(phy_node);
> +	}
> +
>  	/* Limit link speed */
>  	pci->link_gen = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
> @@ -1202,6 +1256,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  	},
> +	[IMX8MM] = {
> +		.variant = IMX8MM,
> +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> +	},
>  };
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
> @@ -1209,7 +1267,8 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
>  	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
>  	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
> -	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], } ,
> +	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
> +	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
>  	{},
>  };
>  


