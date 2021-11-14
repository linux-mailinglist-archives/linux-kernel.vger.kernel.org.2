Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF744F7A7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhKNLnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhKNLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:43:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B5C061746;
        Sun, 14 Nov 2021 03:40:19 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b15so58074410edd.7;
        Sun, 14 Nov 2021 03:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WZ91H4wBdYslX3OKBOXzVhkhMTQIbocNo56iYKvAHVU=;
        b=mNvzIXG9+HfcNu4jnH/zJKFM1BVB4+vWmVZU1m5f2fQfGq1ZF40i8C+xjWn0JOK5b0
         MkiNHf/DyabchAjTlIdz2d/0PXqi2XcV4pdBZc06evLYIelqtq+468fm5maYhLJ9GUEs
         f3WXRlcbjOX/2ut4ssrEZ8e4UhZkijJtq07Ra4CDgkHzFznx7kZRB2WHqIrt4Ogu1b0z
         XzXrBuGKKL0AwaabV3hhu95SoknvCbw37RFmJRqBUzAKGEXe93GGabbpHja6mzHUcX5J
         rjUiW7LD5M9DzoQcj5p/YV2oK0J0IQnemUs6yB+kezW5qjJcOPtB0+KYD4btU4VyvijG
         O/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZ91H4wBdYslX3OKBOXzVhkhMTQIbocNo56iYKvAHVU=;
        b=NHlBLEoDcwU7V43ZjEVuJNqF1s0HYYbe0Nza7KAC6aifsh7OOqV/LO9I25Rf3e4zbU
         Fx0+w41XGj9//KnvMRqEGpRUc7DnaQ4EotAM8Bx3gk8hwASXOVFPVnzW4nepxdhATg8r
         jJBD3x5M1YSDMO5O9uU3yqszCXT9IBqQ5ZObzE4Vfx98JsZ2AuzV9KXU0gCx0GTRW2MX
         vqFgejywD/xS/5ZHUVvO2hxS+AS83mYBEbGuzVv0M8YYcSPDzN1mbMUuS+eZdaUjt7kz
         CPsH6q2DKH8wyw0sp4sNOGSfSRmoVjQ0bwg2VcUPtA2+JMiesi79jGpgg4S9r2ghDCsk
         u7PA==
X-Gm-Message-State: AOAM532qeCVvVHIzoToJX0WI2yI5yt86/CDX/oxNK2Ehg5A9/5Hf3wGT
        zvJxOk6tc6vImML1EZ6TJjE=
X-Google-Smtp-Source: ABdhPJzFsWipB3DvO0A0hoE3Xn+7FiaOkWoGrdeFWa2xy/P4c22gKeKTD39u2atJzhpw8WMoZAlCVw==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr42719956edc.328.1636890018175;
        Sun, 14 Nov 2021 03:40:18 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y15sm858218eda.13.2021.11.14.03.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 03:40:17 -0800 (PST)
Subject: Re: [PATCH v3 2/3] phy/rockchip: add naneng combo phy for RK3568
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com
References: <20211025080632.32063-1-yifeng.zhao@rock-chips.com>
 <20211025080632.32063-3-yifeng.zhao@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <65898b49-87ee-211e-f5ef-39147107ef83@gmail.com>
Date:   Sun, 14 Nov 2021 12:40:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025080632.32063-3-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Some comments. Have a look if it's useful.

On 10/25/21 10:06 AM, Yifeng Zhao wrote:
> This patch implements a combo phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v3:
> - Using api devm_reset_control_get_optional_exclusive and dev_err_probe
> - Remove apb_rst
> - Redefine registers address
> 
> Changes in v2:
> - Using api devm_platform_get_and_ioremap_resource.
> - Modify rockchip_combphy_set_Mode.
> - Add some PHY registers definition.
> 
>  drivers/phy/rockchip/Kconfig                  |   8 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 638 ++++++++++++++++++
>  3 files changed, 647 insertions(+)
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
> index 000000000000..e5bea21a1d35
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -0,0 +1,638 @@
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
> +#define RK3568_T22_PHYREG5		0x14
> +#define T22_PHYREG5_PLL_DIV_MASK	GENMASK(7, 6)
> +#define T22_PHYREG5_PLL_DIV_SHIFT	6
> +#define T22_PHYREG5_PLL_DIV_2		1
> +
> +#define RK3568_T22_PHYREG6		0x18
> +#define T22_PHYREG6_TX_RTERM_MASK	GENMASK(7, 4)
> +#define T22_PHYREG6_TX_RTERM_SHIFT	4
> +#define T22_PHYREG6_TX_RTERM_50OHM	0x8
> +#define T22_PHYREG6_RX_RTERM_MASK	GENMASK(3, 0)
> +#define T22_PHYREG6_RX_RTERM_SHIFT	0
> +#define T22_PHYREG6_RX_RTERM_44OHM	0xF
> +
> +#define RK3568_T22_PHYREG7		0x1C
> +#define T22_PHYREG7_SSC_EN		BIT(4)
> +
> +#define RK3568_T22_PHYREG10		0x28
> +#define T22_PHYREG10_SU_TRIM_0_7	0xF0
> +
> +#define RK3568_T22_PHYREG11		0x2C
> +#define T22_PHYREG11_PLL_LPF_ADJ	0x4
> +
> +#define RK3568_T22_PHYREG12		0x30
> +#define T22_PHYREG12_RESISTER_MASK	GENMASK(5, 4)
> +#define T22_PHYREG12_RESISTER_SHIFT	0x4
> +#define T22_PHYREG12_RESISTER_HIGH_Z	0x3
> +#define T22_PHYREG12_CKRCV_AMP0		BIT(7)
> +
> +#define RK3568_T22_PHYREG13		0x34
> +#define T22_PHYREG13_CKRCV_AMP1		BIT(0)
> +
> +#define RK3568_T22_PHYREG14		0x38
> +#define T22_PHYREG14_CTLE_EN		BIT(0)
> +#define T22_PHYREG14_SSC_CNT_MASK	GENMASK(7, 6)
> +#define T22_PHYREG14_SSC_CNT_SHIFT	6
> +#define T22_PHYREG14_SSC_CNT_VALUE	0x1
> +
> +#define RK3568_T22_PHYREG15		0x3C
> +#define T22_PHYREG15_SSC_CNT_VALUE	0x5f
> +
> +#define RK3568_T22_PHYREG17		0x44
> +#define T22_PHYREG17_PLL_LOOP		0x32
> +
> +#define RK3568_T22_PHYREG31		0x7C
> +#define T22_PHYREG31_SSC_MASK		GENMASK(7, 4)
> +#define T22_PHYREG31_SSC_DIR_SHIFT	4
> +#define T22_PHYREG31_SSC_UPWARD		0
> +#define T22_PHYREG31_SSC_DOWNWARD	1
> +#define T22_PHYREG31_SSC_OFFSET_SHIFT	6
> +#define T22_PHYREG31_SSC_OFFSET_500PPM	1
> +
> +#define RK3568_T22_PHYREG32		0x80
> +#define T22_PHYREG32_PLL_KVCO_MASK	GENMASK(4, 2)
> +#define T22_PHYREG32_PLL_KVCO_SHIFT	2
> +#define T22_PHYREG32_PLL_KVCO_VALUE	2
> +
> +struct rockchip_combphy_priv;
> +
> +struct combphy_reg {
> +	u16 offset;
> +	u16 bitend;
> +	u16 bitstart;
> +	u16 disable;
> +	u16 enable;
> +};
> +
> +struct rockchip_combphy_grfcfg {
> +	struct combphy_reg pcie_mode_set;
> +	struct combphy_reg usb_mode_set;
> +	struct combphy_reg sgmii_mode_set;
> +	struct combphy_reg qsgmii_mode_set;
> +	struct combphy_reg pipe_rxterm_set;
> +	struct combphy_reg pipe_txelec_set;
> +	struct combphy_reg pipe_txcomp_set;
> +	struct combphy_reg pipe_clk_25m;
> +	struct combphy_reg pipe_clk_100m;
> +	struct combphy_reg pipe_phymode_sel;
> +	struct combphy_reg pipe_rate_sel;
> +	struct combphy_reg pipe_rxterm_sel;
> +	struct combphy_reg pipe_txelec_sel;
> +	struct combphy_reg pipe_txcomp_sel;
> +	struct combphy_reg pipe_clk_ext;
> +	struct combphy_reg pipe_sel_usb;
> +	struct combphy_reg pipe_sel_qsgmii;
> +	struct combphy_reg pipe_phy_status;
> +	struct combphy_reg con0_for_pcie;
> +	struct combphy_reg con1_for_pcie;
> +	struct combphy_reg con2_for_pcie;
> +	struct combphy_reg con3_for_pcie;
> +	struct combphy_reg con0_for_sata;
> +	struct combphy_reg con1_for_sata;
> +	struct combphy_reg con2_for_sata;
> +	struct combphy_reg con3_for_sata;
> +	struct combphy_reg pipe_con0_for_sata;
> +	struct combphy_reg pipe_sgmii_mac_sel;
> +	struct combphy_reg pipe_xpcs_phy_ready;
> +	struct combphy_reg u3otg0_port_en;
> +	struct combphy_reg u3otg1_port_en;
> +};
> +
> +struct rockchip_combphy_cfg {
> +	const int num_clks;
> +	const struct clk_bulk_data *clks;
> +	const struct rockchip_combphy_grfcfg *grfcfg;
> +	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
> +};
> +
> +struct rockchip_combphy_priv {
> +	u8 mode;
> +	void __iomem *mmio;
> +	int num_clks;
> +	struct clk_bulk_data *clks;
> +	struct device *dev;
> +	struct regmap *pipe_grf;
> +	struct regmap *phy_grf;
> +	struct phy *phy;
> +	struct reset_control *phy_rst;

Example:

bool ext-refclk;
bool enable-ssc;

> +	const struct rockchip_combphy_cfg *cfg;
> +};
> +

> +static inline bool param_read(struct regmap *base,
> +			      const struct combphy_reg *reg, u32 val)

The function param_read() is never used! Remove.

If you still need it later then change to:

rockchip_combphy_param_read()
For FTRACE it is needed that all functions start with the same function
prefix.

> +{
> +	int ret;
> +	u32 mask, orig, tmp;
> +
> +	ret = regmap_read(base, reg->offset, &orig);
> +	if (ret)
> +		return false;
> +
> +	mask = GENMASK(reg->bitend, reg->bitstart);
> +	tmp = (orig & mask) >> reg->bitstart;
> +
> +	return tmp == val;
> +}
> +

> +static int param_write(struct regmap *base,
> +		       const struct combphy_reg *reg, bool en)

rockchip_combphy_param_write()
For FTRACE it is needed that all functions start with the same function
prefix.

> +{
> +	u32 val, mask, tmp;
> +
> +	tmp = en ? reg->enable : reg->disable;
> +	mask = GENMASK(reg->bitend, reg->bitstart);
> +	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
> +
> +	return regmap_write(base, reg->offset, val);
> +}
> +
> +static u32 rockchip_combphy_is_ready(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 mask, val;
> +
> +	mask = GENMASK(cfg->pipe_phy_status.bitend,
> +		       cfg->pipe_phy_status.bitstart);
> +
> +	regmap_read(priv->phy_grf, cfg->pipe_phy_status.offset, &val);
> +	val = (val & mask) >> cfg->pipe_phy_status.bitstart;
> +
> +	return val;
> +}
> +
> +static int rockchip_combphy_set_mode(struct rockchip_combphy_priv *priv)
> +{
> +	int ret = 0;
> +
> +	switch (priv->mode) {
> +	case PHY_TYPE_PCIE:
> +	case PHY_TYPE_USB3:
> +	case PHY_TYPE_SATA:
> +	case PHY_TYPE_SGMII:
> +	case PHY_TYPE_QSGMII:
> +		if (priv->cfg->combphy_cfg)
> +			ret = priv->cfg->combphy_cfg(priv);
> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		dev_err(priv->dev, "failed to init phy for phy mode %x\n", priv->mode);
> +
> +	return ret;
> +}
> +
> +static int rockchip_combphy_init(struct phy *phy)
> +{
> +	struct rockchip_combphy_priv *priv = phy_get_drvdata(phy);
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> +	if (ret) {
> +		dev_err(priv->dev, "failed to enable clks\n");
> +		return ret;
> +	}
> +
> +	ret = rockchip_combphy_set_mode(priv);
> +	if (ret)
> +		goto err_clk;
> +
> +	ret = reset_control_deassert(priv->phy_rst);
> +	if (ret)
> +		goto err_clk;
> +
> +	if (priv->mode == PHY_TYPE_USB3) {
> +		ret = readx_poll_timeout_atomic(rockchip_combphy_is_ready,
> +						priv, val,
> +						val == cfg->pipe_phy_status.enable,
> +						10, 1000);
> +		if (ret)
> +			dev_warn(priv->dev, "wait phy status ready timeout\n");
> +	}
> +
> +	return 0;
> +
> +err_clk:
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +
> +	return ret;
> +}
> +
> +static int rockchip_combphy_exit(struct phy *phy)
> +{
> +	struct rockchip_combphy_priv *priv = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +	reset_control_assert(priv->phy_rst);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops rochchip_combphy_ops = {
> +	.init = rockchip_combphy_init,
> +	.exit = rockchip_combphy_exit,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct phy *rockchip_combphy_xlate(struct device *dev,
> +					  struct of_phandle_args *args)
> +{
> +	struct rockchip_combphy_priv *priv = dev_get_drvdata(dev);
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "invalid number of arguments\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (priv->mode != PHY_NONE && priv->mode != args->args[0])
> +		dev_warn(dev, "phy type select %d overwriting type %d\n",
> +			 args->args[0], priv->mode);
> +
> +	priv->mode = args->args[0];
> +
> +	return priv->phy;
> +}
> +
> +static int rockchip_combphy_parse_dt(struct device *dev,
> +				     struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_cfg *phy_cfg = priv->cfg;
> +	int ret, mac_id;
> +
> +	ret = devm_clk_bulk_get(dev, priv->num_clks, priv->clks);

Maybe use:

priv->num_clks = devm_clk_bulk_get_all();

/**
 * devm_clk_bulk_get_all - managed get multiple clk consumers
 * @dev: device for clock "consumer"
 * @clks: pointer to the clk_bulk_data table of consumer
 *

 * Returns a positive value for the number of clocks obtained while the
 * clock references are stored in the clk_bulk_data table in @clks field.
 * Returns 0 if there're none and a negative value if something failed.

 *
 * This helper function allows drivers to get several clk
 * consumers in one operation with management, the clks will
 * automatically be freed when the device is unbound.
 */


> +	if (ret == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	if (ret)
> +		priv->num_clks = 0;

Why defer? The clocks are defined in the DT or not.

> +
> +	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							 "rockchip,pipe-grf");
> +	if (IS_ERR(priv->pipe_grf)) {
> +		dev_err(dev, "failed to find peri_ctrl pipe-grf regmap\n");
> +		return PTR_ERR(priv->pipe_grf);
> +	}
> +
> +	priv->phy_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							"rockchip,pipe-phy-grf");
> +	if (IS_ERR(priv->phy_grf)) {
> +		dev_err(dev, "failed to find peri_ctrl pipe-phy-grf regmap\n");
> +		return PTR_ERR(priv->phy_grf);
> +	}
> +

device_property_read_bool(priv->ext-refclk, "rockchip,ext-refclk")

documentation?

device_property_read_bool(priv->enable-ssc, "rockchip,enable-ssc")

documentation?

> +	if (device_property_present(dev, "rockchip,dis-u3otg0-port"))

documentation?

> +		param_write(priv->pipe_grf, &phy_cfg->grfcfg->u3otg0_port_en,
> +			    false);
> +	else if (device_property_present(dev, "rockchip,dis-u3otg1-port"))

documentation?

> +		param_write(priv->pipe_grf, &phy_cfg->grfcfg->u3otg1_port_en,
> +			    false);
> +
> +	if (!device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &mac_id) &&

documentation?

> +	    (mac_id > 0))
> +		param_write(priv->pipe_grf, &phy_cfg->grfcfg->pipe_sgmii_mac_sel, true)> +
> +	priv->phy_rst = devm_reset_control_get_optional_exclusive(dev, "combphy");

There are 2 resets. When the reset order does matter then use
devm_reset_control_array_get() to get the resets.
The use of reset-names is then not needed.


> +	if (IS_ERR(priv->phy_rst))
> +		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy reset\n");
> +
> +	return 0;
> +}
> +
> +static int rockchip_combphy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_combphy_priv *priv;
> +	const struct rockchip_combphy_cfg *phy_cfg;
> +	struct resource *res;
> +	int ret;
> +
> +	phy_cfg = of_device_get_match_data(dev);
> +	if (!phy_cfg) {
> +		dev_err(dev, "No OF match data provided\n");
> +		return -EINVAL;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->mmio)) {
> +		ret = PTR_ERR(priv->mmio);
> +		return ret;
> +	}
> +
> +	priv->num_clks = phy_cfg->num_clks;
> +
> +	priv->clks = devm_kmemdup(dev, phy_cfg->clks,
> +				  phy_cfg->num_clks * sizeof(struct clk_bulk_data),
> +				  GFP_KERNEL);
> +
> +	if (!priv->clks)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->mode = PHY_NONE;
> +	priv->cfg = phy_cfg;
> +
> +	ret = rockchip_combphy_parse_dt(dev, priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_assert(priv->phy_rst);
> +	if (ret) {
> +		dev_err(dev, "failed to reset phy\n");
> +		return ret;
> +	}
> +
> +	priv->phy = devm_phy_create(dev, NULL, &rochchip_combphy_ops);
> +	if (IS_ERR(priv->phy)) {
> +		dev_err(dev, "failed to create combphy\n");
> +		return PTR_ERR(priv->phy);
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +	phy_set_drvdata(priv->phy, priv);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, rockchip_combphy_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	struct clk *refclk = NULL;
> +	unsigned long rate;
> +	int i;
> +	u32 val;
> +

> +	/* Configure PHY reference clock frequency */

Phrases start with a capital and end with a dot.
Fix them all.

> +	for (i = 0; i < priv->num_clks; i++) {
> +		if (!strncmp(priv->clks[i].id, "ref", 3)) {
> +			refclk = priv->clks[i].clk;
> +			break;
> +		}
> +	}
> +
> +	if (!refclk) {
> +		dev_err(priv->dev, "No refclk found\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (priv->mode) {
> +	case PHY_TYPE_PCIE:
> +		/* Set SSC downward spread spectrum */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG31);
> +		val &= ~T22_PHYREG31_SSC_MASK;
> +		val |= T22_PHYREG31_SSC_DOWNWARD << T22_PHYREG31_SSC_DIR_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG31);
> +
> +		param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG31);
> +		val &= ~T22_PHYREG31_SSC_MASK;
> +		val |= T22_PHYREG31_SSC_DOWNWARD << T22_PHYREG31_SSC_DIR_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG31);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG14);
> +		val |= T22_PHYREG14_CTLE_EN;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG14);
> +
> +		/* Set PLL KVCO fine tuning signals */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG32);
> +		val &= ~T22_PHYREG32_PLL_KVCO_MASK;
> +		val |= T22_PHYREG32_PLL_KVCO_VALUE << T22_PHYREG32_PLL_KVCO_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG32);
> +
> +		/* Enable controlling random jitter */
> +		writel(T22_PHYREG11_PLL_LPF_ADJ, priv->mmio + RK3568_T22_PHYREG11);
> +
> +		/* Set PLL input clock divider 1/2 */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG5);
> +		val &= ~T22_PHYREG5_PLL_DIV_MASK;
> +		val |= T22_PHYREG5_PLL_DIV_2 << T22_PHYREG5_PLL_DIV_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG5);
> +
> +		writel(T22_PHYREG17_PLL_LOOP, priv->mmio + RK3568_T22_PHYREG17);
> +		writel(T22_PHYREG10_SU_TRIM_0_7, priv->mmio + RK3568_T22_PHYREG10);
> +
> +		param_write(priv->phy_grf, &cfg->pipe_sel_usb, true);
> +		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* Enable adaptive CTLE for SATA Rx */
> +		val = readl(priv->mmio + RK3568_T22_PHYREG14);
> +		val |= T22_PHYREG14_CTLE_EN;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG14);
> +		/*
> +		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA
> +		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
> +		 */
> +		val = T22_PHYREG6_TX_RTERM_50OHM << T22_PHYREG6_TX_RTERM_SHIFT;
> +		val |= T22_PHYREG6_RX_RTERM_44OHM << T22_PHYREG6_RX_RTERM_SHIFT;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG6);
> +
> +		param_write(priv->phy_grf, &cfg->con0_for_sata, true);
> +		param_write(priv->phy_grf, &cfg->con1_for_sata, true);
> +		param_write(priv->phy_grf, &cfg->con2_for_sata, true);
> +		param_write(priv->phy_grf, &cfg->con3_for_sata, true);
> +		param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
> +		break;
> +	case PHY_TYPE_SGMII:
> +		param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		param_write(priv->phy_grf, &cfg->sgmii_mode_set, true);
> +		break;
> +	case PHY_TYPE_QSGMII:
> +		param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
> +		param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
> +		param_write(priv->phy_grf, &cfg->pipe_rate_sel, true);
> +		param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> +		param_write(priv->phy_grf, &cfg->qsgmii_mode_set, true);
> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(refclk);
> +
> +	switch (rate) {
> +	case REF_CLOCK_24MHz:
> +		if (priv->mode == PHY_TYPE_USB3 || priv->mode == PHY_TYPE_SATA) {
> +			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
> +			val = readl(priv->mmio + RK3568_T22_PHYREG14);
> +			val &= ~T22_PHYREG14_SSC_CNT_MASK;
> +			val |= T22_PHYREG14_SSC_CNT_VALUE << T22_PHYREG14_SSC_CNT_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG14);
> +			writel(T22_PHYREG15_SSC_CNT_VALUE, priv->mmio + RK3568_T22_PHYREG15);
> +		}
> +		break;
> +	case REF_CLOCK_25MHz:
> +		param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
> +		break;
> +	case REF_CLOCK_100MHz:
> +		param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (priv->mode == PHY_TYPE_PCIE) {
> +			/* PLL KVCO tuning fine */
> +			val = readl(priv->mmio + RK3568_T22_PHYREG32);
> +			val &= ~T22_PHYREG32_PLL_KVCO_MASK;
> +			val |= T22_PHYREG32_PLL_KVCO_VALUE << T22_PHYREG32_PLL_KVCO_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG32);
> +
> +			/* Enable controlling random jitter */
> +			writel(T22_PHYREG11_PLL_LPF_ADJ, priv->mmio + RK3568_T22_PHYREG11);
> +
> +			val = readl(priv->mmio + RK3568_T22_PHYREG5);
> +			val &= ~T22_PHYREG5_PLL_DIV_MASK;
> +			val |= T22_PHYREG5_PLL_DIV_2 << T22_PHYREG5_PLL_DIV_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG5);
> +
> +			writel(T22_PHYREG17_PLL_LOOP, priv->mmio + RK3568_T22_PHYREG17);
> +			writel(T22_PHYREG10_SU_TRIM_0_7, priv->mmio + RK3568_T22_PHYREG10);
> +		} else if (priv->mode == PHY_TYPE_SATA) {
> +			/* downward spread spectrum +500ppm */
> +			val = readl(priv->mmio + RK3568_T22_PHYREG31);
> +			val &= ~T22_PHYREG31_SSC_MASK;
> +			val |= T22_PHYREG31_SSC_DOWNWARD << T22_PHYREG31_SSC_DIR_SHIFT;
> +			val |= T22_PHYREG31_SSC_OFFSET_500PPM << T22_PHYREG31_SSC_OFFSET_SHIFT;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG31);
> +		}
> +		break;
> +	default:
> +		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +

> +	if (device_property_read_bool(priv->dev, "rockchip,ext-refclk")) {

Example:
priv->ext-refclk

Use a variable in priv. Move all parsing in one place to
rockchip_combphy_parse_dt().

> +		param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (priv->mode == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			val = readl(priv->mmio + RK3568_T22_PHYREG12);
> +			val &= ~T22_PHYREG12_RESISTER_MASK;
> +			val |= T22_PHYREG12_RESISTER_HIGH_Z << T22_PHYREG12_RESISTER_SHIFT;
> +			val |= T22_PHYREG12_CKRCV_AMP0;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG12);
> +
> +			val = readl(priv->mmio + RK3568_T22_PHYREG13);
> +			val |= T22_PHYREG13_CKRCV_AMP1;
> +			writel(val, priv->mmio + RK3568_T22_PHYREG13);
> +		}
> +	}
> +

> +	if (device_property_read_bool(priv->dev, "rockchip,enable-ssc")) {

Example:
priv->enable-ssc

Use a variable in priv. Move all parsing to rockchip_combphy_parse_dt().

> +		val = readl(priv->mmio + RK3568_T22_PHYREG7);
> +		val |= T22_PHYREG7_SSC_EN;
> +		writel(val, priv->mmio + RK3568_T22_PHYREG7);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
> +	/* pipe-phy-grf */
> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
> +	.sgmii_mode_set		= { 0x0000, 5, 0, 0x00, 0x01 },
> +	.qsgmii_mode_set	= { 0x0000, 5, 0, 0x00, 0x21 },
> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
> +	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
> +	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
> +	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
> +	.pipe_sel_usb		= { 0x000c, 14, 13, 0x00, 0x01 },
> +	.pipe_sel_qsgmii	= { 0x000c, 15, 13, 0x00, 0x07 },
> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
> +	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0119 },
> +	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0040 },
> +	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c3 },
> +	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
> +	/* pipe-grf */
> +	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
> +	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
> +	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
> +	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
> +	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },
> +};
> +

> +static const struct clk_bulk_data rk3568_clks[] = {
> +	{ .id = "ref" },
> +	{ .id = "apb" },
> +	{ .id = "pipe" },
> +};

Don't waste memory to recreate a complete const structure only to add a id.

> +
> +static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {

> +	.num_clks	= ARRAY_SIZE(rk3568_clks),
> +	.clks		= rk3568_clks,

Maybe remove. Already defined in DT.

> +	.grfcfg		= &rk3568_combphy_grfcfgs,
> +	.combphy_cfg	= rk3568_combphy_cfg,
> +};
> +
> +static const struct of_device_id rockchip_combphy_of_match[] = {
> +	{
> +		.compatible = "rockchip,rk3568-naneng-combphy",
> +		.data = &rk3568_combphy_cfgs,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_combphy_of_match);
> +
> +static struct platform_driver rockchip_combphy_driver = {
> +	.probe	= rockchip_combphy_probe,
> +	.driver = {

> +		.name = "naneng-combphy",

Maybe use:
rockchip-naneng-combphy

This shows up for example in the kernel log.
Keep it in line with the other Rockchip drivers.

> +		.of_match_table = rockchip_combphy_of_match,
> +	},
> +};
> +module_platform_driver(rockchip_combphy_driver);
> +
> +MODULE_DESCRIPTION("Rockchip NANENG COMBPHY driver");
> +MODULE_LICENSE("GPL v2");
> 
