Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130AF3A4C84
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFLDwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLDwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:52:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45512610CD;
        Sat, 12 Jun 2021 03:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623469804;
        bh=cER1QkPGiI/TsZSaBFzRWb81XQJwlnykiqGUOl4ySss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CD3g6Fa23eS47Pk5NAC3dRsUj84TA8dsalZPdfDDOvxtsN7Ksj93wCLTW1dBeNE12
         l/ZmzDXXf3cu6KVmlBZORgCOKZFqqWzvDqyoLDt7ULXJCLmIp3xAOfYejgyXkS1Hd6
         SgzdO+KqsuyPIBqYMuWz03JD9RQM9DcvS+jrOgXmOwW4W5KymmgyoxP7NgZYjIbZJd
         gKLfeTrJtMVkvqo1/zE+ruxz1X1nIqd5cDw5Nsl5RSyYhH1WgekdkYM6JZnQnw/6VK
         vB6K1dBTY+GZzXXcy2WC/QFYVjY0VD2qXm9vjdcVE9hTiArduoYn9yYj0Mp4S3NKXu
         GZWnL23EdNctw==
Date:   Sat, 12 Jun 2021 11:49:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] soc: imx: gpcv2: add support for i.MX8MN power
 domains
Message-ID: <20210612034958.GL29138@dragon>
References: <20210525010732.115562-1-aford173@gmail.com>
 <20210525010732.115562-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525010732.115562-3-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:07:29PM -0500, Adam Ford wrote:
> This adds support for the power domains founds on i.MX8MN. The Nano
> has fewer domains than the Mini, and the access to some of these domains
> is different than that of the Mini, the Mini power domains cannot be
> reused.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 35bbb1bc5159..3120718e1dd7 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -20,6 +20,7 @@
>  #include <dt-bindings/power/imx7-power.h>
>  #include <dt-bindings/power/imx8mq-power.h>
>  #include <dt-bindings/power/imx8mm-power.h>
> +#include <dt-bindings/power/imx8mn-power.h>
>  
>  #define GPC_LPCR_A_CORE_BSC			0x000
>  
> @@ -58,6 +59,12 @@
>  #define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
>  #define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
>  
> +#define IMX8MN_DISPMIX_A53_DOMAIN		BIT(12)
> +#define IMX8MN_GPUMIX_A53_DOMAIN		BIT(9)
> +#define IMX8MN_DDR1_A53_DOMAIN		BIT(7)
> +#define IMX8MN_OTG1_A53_DOMAIN		BIT(4)
> +#define IMX8MN_MIPI_A53_DOMAIN		BIT(2)
> +
>  #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
>  #define GPC_PU_PGC_SW_PDN_REQ		0x104
>  
> @@ -94,6 +101,12 @@
>  #define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
>  #define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
>  
> +#define IMX8MN_DISPMIX_SW_Pxx_REQ		BIT(10)
> +#define IMX8MN_GPUMIX_SW_Pxx_REQ		BIT(7)
> +#define IMX8MN_DDR1_SW_Pxx_REQ		BIT(5)
> +#define IMX8MN_OTG1_SW_Pxx_REQ		BIT(2)
> +#define IMX8MN_MIPI_SW_Pxx_REQ		BIT(0)
> +
>  #define GPC_M4_PU_PDN_FLG		0x1bc
>  
>  #define GPC_PU_PWRHSK			0x1fc
> @@ -116,6 +129,14 @@
>  #define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
>  #define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
>  #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
> +
> +#define IMX8MN_GPUMIX_HSK_PWRDNACKN		(BIT(29) | BIT(27))
> +#define IMX8MN_DISPMIX_HSK_PWRDNACKN		BIT(25)
> +#define IMX8MN_HSIO_HSK_PWRDNACKN		BIT(23)
> +#define IMX8MN_GPUMIX_HSK_PWRDNREQN		(BIT(11) | BIT(9))
> +#define IMX8MN_DISPMIX_HSK_PWRDNREQN		BIT(7)
> +#define IMX8MN_HSIO_HSK_PWRDNREQN		BIT(5)
> +
>  /*
>   * The PGC offset values in Reference Manual
>   * (Rev. 1, 01/2018 and the older ones) GPC chapter's
> @@ -152,6 +173,12 @@
>  #define IMX8MM_PGC_VPUG2		28
>  #define IMX8MM_PGC_VPUH1		29
>  
> +#define IMX8MN_PGC_MIPI		16
> +#define IMX8MN_PGC_OTG1		18
> +#define IMX8MN_PGC_DDR1		21
> +#define IMX8MN_PGC_GPUMIX		23
> +#define IMX8MN_PGC_DISPMIX		26
> +
>  #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
>  #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
>  
> @@ -764,6 +791,71 @@ static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
>  	.reg_access_table = &imx8mm_access_table,
>  };
>  
> +static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
> +	[IMX8MN_POWER_DOMAIN_HSIOMIX] = {
> +		.genpd = {
> +			.name = "hsiomix",
> +		},
> +		.bits  = {
> +			.pxx = 0, /* no power sequence control */
> +			.map = 0, /* no power sequence control */
> +			.hskreq = IMX8MN_HSIO_HSK_PWRDNREQN,
> +			.hskack = IMX8MN_HSIO_HSK_PWRDNACKN,
> +		},
> +	},
> +
> +	[IMX8MN_POWER_DOMAIN_OTG1] = {
> +		.genpd = {
> +			.name = "usb-otg1",
> +		},
> +		.bits  = {
> +			.pxx = IMX8MN_OTG1_SW_Pxx_REQ,
> +			.map = IMX8MN_OTG1_A53_DOMAIN,
> +		},
> +		.pgc   = IMX8MN_PGC_OTG1,
> +	},
> +
> +	[IMX8MN_POWER_DOMAIN_GPUMIX] = {
> +		.genpd = {
> +			.name = "gpumix",
> +		},
> +		.bits  = {
> +			.pxx = IMX8MN_GPUMIX_SW_Pxx_REQ,
> +			.map = IMX8MN_GPUMIX_A53_DOMAIN,
> +			.hskreq = IMX8MN_GPUMIX_HSK_PWRDNREQN,
> +			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
> +		},
> +		.pgc   = IMX8MN_PGC_GPUMIX,
> +	},
> +};
> +
> +static const struct regmap_range imx8mn_yes_ranges[] = {
> +	regmap_reg_range(GPC_LPCR_A_CORE_BSC,
> +			 GPC_PU_PWRHSK),
> +	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_MIPI),
> +			 GPC_PGC_SR(IMX8MN_PGC_MIPI)),
> +	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_OTG1),
> +			 GPC_PGC_SR(IMX8MN_PGC_OTG1)),
> +	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_DDR1),
> +			 GPC_PGC_SR(IMX8MN_PGC_DDR1)),
> +	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_GPUMIX),
> +			 GPC_PGC_SR(IMX8MN_PGC_GPUMIX)),
> +	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_DISPMIX),
> +			 GPC_PGC_SR(IMX8MN_PGC_DISPMIX)),
> +};
> +
> +static const struct regmap_access_table imx8mn_access_table = {
> +	.yes_ranges	= imx8mn_yes_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(imx8mn_yes_ranges),
> +};
> +
> +static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
> +	.domains = imx8mn_pgc_domains,
> +	.domains_num = ARRAY_SIZE(imx8mn_pgc_domains),
> +	.reg_access_table = &imx8mn_access_table,
> +};
> +
> +

One newline is good enough.

Fixed it up and applied the patch.

Shawn

>  static int imx_pgc_domain_probe(struct platform_device *pdev)
>  {
>  	struct imx_pgc_domain *domain = pdev->dev.platform_data;
> @@ -948,6 +1040,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>  static const struct of_device_id imx_gpcv2_dt_ids[] = {
>  	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
>  	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
> +	{ .compatible = "fsl,imx8mn-gpc", .data = &imx8mn_pgc_domain_data, },
>  	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
>  	{ }
>  };
> -- 
> 2.25.1
> 
