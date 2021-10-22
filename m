Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895944375B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhJVKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbhJVKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE77460560;
        Fri, 22 Oct 2021 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634899796;
        bh=0N9euYvolHICbMqCsFL6zp/Zm/NyWT3YNUnL9sLoKA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i71yzpodiCIsPew+jgWa539RfutcCEYWttPcVFJURi2rFo+r9ed5mHxFdp9tu3r9Y
         fRVM8VIes1lw6JlL6X7ssvAkzKHRcOc4ZdqJtOFlD1qlv5+AMFaKQWsaXT+x5+vb0V
         S7WcCrJ4HYNKMXTjAgMAxl0NaQzjAI0TkFusLc2JdhL1fVcsbBuI8ujEA9cQX7VwK+
         t5c+Mg5VtvnB2N5gKVEizfvesHU1jTtRUfKbsr/CJJ23DGeS91oij5EK8jMB1To/dk
         QR2KISQa9hPHcDomS+2MS8fZyTBOE0pfRoorhbuht0CCuZGDfBdAqdCtsHt88ZK2ae
         D7HFqsdQoJFwg==
Date:   Fri, 22 Oct 2021 16:19:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v2 2/3] phy/rockchip: add naneng combo phy for RK3568
Message-ID: <YXKXULdyPuv1BirB@matsya>
References: <20211013101938.28061-1-yifeng.zhao@rock-chips.com>
 <20211013101938.28061-3-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013101938.28061-3-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-10-21, 18:19, Yifeng Zhao wrote:
> This patch implements a combo phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v2:
> - Using api devm_platform_get_and_ioremap_resource.
> - Modify rockchip_combphy_set_Mode.
> - Add some PHY registers definition.
> 
>  drivers/phy/rockchip/Kconfig                  |   8 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 650 ++++++++++++++++++
>  3 files changed, 659 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index e812adad7242..9022e395c056 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -66,6 +66,14 @@ config PHY_ROCKCHIP_INNO_DSIDPHY
>  	  Enable this to support the Rockchip MIPI/LVDS/TTL PHY with
>  	  Innosilicon IP block.
>  
> +config PHY_ROCKCHIP_NANENG_COMBO_PHY
> +	tristate "Rockchip NANENG COMBO PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip PCIe/USB3.0/SATA/QSGMII
> +	  combo PHY with NaNeng IP block.
> +
>  config PHY_ROCKCHIP_PCIE
>  	tristate "Rockchip PCIe PHY Driver"
>  	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index f0eec212b2aa..a5041efb5b8f 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY)	+= phy-rockchip-inno-csidphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
> +obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> new file mode 100644
> index 000000000000..fbfc5fbbd5b8
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip PIPE USB3.0 PCIE SATA combphy driver
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#define BIT_WRITEABLE_SHIFT		16
> +#define REF_CLOCK_24MHz			24000000
> +#define REF_CLOCK_25MHz			25000000
> +#define REF_CLOCK_100MHz		100000000
> +/* RK3568 T22 COMBO PHY REG */
> +#define RK3568_T22_PHYREG5		(0x5 << 2)
> +#define T22_PHYREG5_PLL_DIV_MASK	GENMASK(7, 6)
> +#define T22_PHYREG5_PLL_DIV_SHIFT	6
> +#define T22_PHYREG5_PLL_DIV_2		1
> +
> +#define RK3568_T22_PHYREG6		(0x6 << 2)
> +#define T22_PHYREG6_TX_RTERM_MASK	GENMASK(7, 4)
> +#define T22_PHYREG6_TX_RTERM_SHIFT	4
> +#define T22_PHYREG6_TX_RTERM_50OHM	0x8
> +#define T22_PHYREG6_RX_RTERM_MASK	GENMASK(3, 0)
> +#define T22_PHYREG6_RX_RTERM_SHIFT	0
> +#define T22_PHYREG6_RX_RTERM_44OHM	0xF
> +
> +#define RK3568_T22_PHYREG7		(0x7 << 2)

Pls use GENMASK for these?

> +#define T22_PHYREG7_SSC_EN		BIT(4)
> +
> +#define RK3568_T22_PHYREG10		(0xA << 2)
> +#define T22_PHYREG10_SU_TRIM_0_7	0xF0
> +
> +#define RK3568_T22_PHYREG11		(0xB << 2)
> +#define T22_PHYREG11_PLL_LPF_ADJ	0x4
> +
> +#define RK3568_T22_PHYREG12		(0xC << 2)
> +#define T22_PHYREG12_RESISTER_MASK	GENMASK(5, 4)
> +#define T22_PHYREG12_RESISTER_SHIFT	0x4

bitfield.h has nice helpers which can extract/program values and avoid
one to define these shifts
-- 
~Vinod
