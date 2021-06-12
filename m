Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9384C3A4BDF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 03:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFLBPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 21:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhFLBPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 21:15:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53061610F8;
        Sat, 12 Jun 2021 01:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623460393;
        bh=nuUV4RQkScXLvbyjmnxYXWKYJEgIHRMed4JmIsceU+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqJ3MH5nHIRUP2zvfQz+QB0J8wbKnk9G2HYjk1oaECbUqpUt1EXsFLgvTrubQ42z3
         FFM6RsZTRM9gjaePbRWf149PQ11Vn9B7enzcpK4nmU9dgFZ+XoHYZSOR3svMun06R5
         jhNXhpSAes4W0RUDjNYh17HvO3z16XQaNr7PrlIR2nISoAEfROxguhpD/2JQ2Sp2C7
         Yr8J6BhoyJojN4Iw4SDXFrSKuH9qhzRe5lyjdakru84SOX1GPGSAnHk6jgyfBebpQC
         ADLtLvAfygEurwZo5FDi6wFPm/p3HFrwP0nLUzrnQpdBILMvq7ENJWzCM7aq8PML5O
         3KQLbyQxZglrA==
Date:   Sat, 12 Jun 2021 09:13:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 3/4] soc: imx: Add generic blk-ctl driver
Message-ID: <20210612011304.GD29138@dragon>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
 <20210522134249.15322-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522134249.15322-4-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 09:42:48PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MM introduces an IP named BLK_CTL and usually is comprised of
> some GPRs.
> 
> The GPRs has some clock bits and reset bits, but here we take it
> as virtual PDs, because of the clock and power domain A/B lock issue
> when taking it as a clock controller.
> 
> For some bits, it might be good to also make it as a reset controller,
> but to i.MX8MM, we not add that support for now.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I would like to see some Reviewed-by tags.

> ---
>  drivers/soc/imx/Makefile  |   2 +-
>  drivers/soc/imx/blk-ctl.c | 334 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h |  85 ++++++++++
>  3 files changed, 420 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/imx/blk-ctl.c
>  create mode 100644 drivers/soc/imx/blk-ctl.h
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 078dc918f4f3..d3d2b49a386c 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>  endif
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o

As it's a generic blk-ctl driver, should we have a dedicated Kconfig
option for it?

> diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
> new file mode 100644
> index 000000000000..8e286b8ef1b3
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/pm_domain.h>
> +#include <linux/reset-controller.h>

Some of the includes are out of alphabetic order.  Also please check if
you need all of these headers.

> +
> +#include "blk-ctl.h"
> +
> +static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct generic_pm_domain *genpd)

Did you run checkpatch on it?  Isn't this line beyond 80 column?

> +{
> +	return container_of(genpd, struct imx_blk_ctl_domain, genpd);
> +}
> +
> +static int imx_blk_ctl_enable_hsk(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_hw *hw = blk_ctl->dev_data->hw_hsk;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	int ret;
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> +
> +	/* Wait for handshake */
> +	udelay(5);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_on(struct generic_pm_domain *domain)

static?

> +{
> +	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
> +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
> +	int ret;
> +
> +	mutex_lock(&blk_ctl->lock);
> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret) {
> +		mutex_unlock(&blk_ctl->lock);
> +		return ret;
> +	}
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret)
> +			dev_err(blk_ctl->dev, "Hankshake failed when power on\n");
> +
> +		goto disable_clk;

Goto disable_clk regardless of the ret check?

> +	}
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
> +	/* Wait for reset propagate */
> +	udelay(5);

The delay will be there even when IMX_BLK_CTL_PD_RESET is not set.

> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> +	if (ret)
> +		goto disable_clk;

Useless goto.

> +
> +disable_clk:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	mutex_unlock(&blk_ctl->lock);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_off(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
> +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
> +	int ret;
> +
> +	mutex_lock(&blk_ctl->lock);
> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret) {
> +		mutex_unlock(&blk_ctl->lock);
> +		return ret;
> +	}
> +
> +	if (!(hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)) {
> +		ret = regmap_clear_bits(regmap, hw->offset, hw->mask);
> +		if (ret)
> +			goto hsk_fail;
> +
> +		if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +			ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
> +			if (ret)
> +				goto hsk_fail;
> +		}
> +	}
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret)
> +			dev_err(blk_ctl->dev, "Hankshake failed when power off\n");
> +	}
> +
> +hsk_fail:

You use disable_clk in above function for the same code.  Inconsistent
labeling strategy.

> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	mutex_unlock(&blk_ctl->lock);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_probe(struct platform_device *pdev)
> +{
> +	struct imx_blk_ctl_domain *domain = pdev->dev.platform_data;
> +	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
> +	struct generic_pm_domain *parent_genpd;
> +	struct device *dev = &pdev->dev;
> +	struct device *active_pd;
> +	int ret;
> +
> +	pdev->dev.of_node = blk_ctl->dev->of_node;

Have a newline.

> +	if (domain->hw->active_pd_name) {
> +		active_pd = dev_pm_domain_attach_by_name(dev, domain->hw->active_pd_name);
> +		if (IS_ERR_OR_NULL(active_pd)) {
> +			ret = PTR_ERR(active_pd) ? : -ENODATA;
> +			pdev->dev.of_node = NULL;

Why is this necessary?

> +			return ret;
> +		}

Have a newline.

> +		domain->active_pd = active_pd;
> +	} else {
> +		if (!blk_ctl->bus_domain) {
> +			pdev->dev.of_node = NULL;
> +			return -EPROBE_DEFER;
> +		}
> +	}
> +
> +	if (domain->hw->active_pd_name)
> +		parent_genpd = pd_to_genpd(active_pd->pm_domain);
> +	else
> +		parent_genpd = blk_ctl->bus_domain;
> +
> +	if (pm_genpd_add_subdomain(parent_genpd, &domain->genpd)) {
> +		pr_warn("failed to add subdomain: %s\n", domain->genpd.name);

dev_warn()?

> +	} else {
> +		mutex_lock(&blk_ctl->lock);
> +		domain->hooked = true;
> +		mutex_unlock(&blk_ctl->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_blk_ctl_remove(struct platform_device *pdev)
> +{
> +	struct imx_blk_ctl_domain *domain = pdev->dev.platform_data;
> +	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
> +	struct generic_pm_domain *parent_genpd;
> +	struct device *active_pd;
> +
> +	pdev->dev.of_node = blk_ctl->dev->of_node;

Why is this needed for .remove?

I stop right here.  The patch really needs some level cross reviewing.

Shawn

> +	if (domain->hw->active_pd_name)
> +		parent_genpd = pd_to_genpd(active_pd->pm_domain);
> +	else
> +		parent_genpd = blk_ctl->bus_domain;
> +
> +	pm_genpd_remove_subdomain(parent_genpd, &domain->genpd);
> +
> +	mutex_lock(&blk_ctl->lock);
> +	domain->hooked = false;
> +	mutex_unlock(&blk_ctl->lock);
> +
> +	if (domain->hw->active_pd_name)
> +		dev_pm_domain_detach(domain->active_pd, false);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id imx_blk_ctl_id[] = {
> +	{ "imx-vpumix-blk-ctl", },
> +	{ "imx-dispmix-blk-ctl", },
> +	{ },
> +};
> +
> +static struct platform_driver imx_blk_ctl_driver = {
> +	.driver = {
> +		.name = "imx-blk-ctl",
> +	},
> +	.probe    = imx_blk_ctl_probe,
> +	.remove   = imx_blk_ctl_remove,
> +	.id_table = imx_blk_ctl_id,
> +};
> +builtin_platform_driver(imx_blk_ctl_driver)
> +
> +static struct generic_pm_domain *imx_blk_ctl_genpd_xlate(struct of_phandle_args *genpdspec,
> +							 void *data)
> +{
> +	struct genpd_onecell_data *genpd_data = data;
> +	unsigned int idx = genpdspec->args[0];
> +	struct imx_blk_ctl_domain *domain;
> +	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
> +
> +	if (genpdspec->args_count != 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (idx >= genpd_data->num_domains) {
> +		pr_err("%s: invalid domain index %u\n", __func__, idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!genpd_data->domains[idx])
> +		return ERR_PTR(-ENOENT);
> +
> +	domain = to_imx_blk_ctl_pd(genpd_data->domains[idx]);
> +	mutex_lock(&domain->blk_ctl->lock);
> +	if (domain->hooked)
> +		genpd = genpd_data->domains[idx];
> +	mutex_unlock(&domain->blk_ctl->lock);
> +
> +	return genpd;
> +}
> +
> +int imx_blk_ctl_register(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
> +	int num = dev_data->pds_num;
> +	struct imx_blk_ctl_domain *domain;
> +	struct generic_pm_domain *genpd;
> +	struct platform_device *pd_pdev;
> +	int domain_index;
> +	int i, ret;
> +
> +	blk_ctl->onecell_data.num_domains = num;
> +	blk_ctl->onecell_data.xlate = imx_blk_ctl_genpd_xlate;
> +	blk_ctl->onecell_data.domains = devm_kcalloc(dev, num, sizeof(struct generic_pm_domain *),
> +						     GFP_KERNEL);
> +	if (!blk_ctl->onecell_data.domains)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; i++) {
> +		domain_index = dev_data->pds[i].id;
> +		if (domain_index >= num) {
> +			dev_warn(dev, "Domain index %d is out of bounds\n", domain_index);
> +			continue;
> +		}
> +
> +		domain = devm_kzalloc(dev, sizeof(struct imx_blk_ctl_domain), GFP_KERNEL);
> +		if (!domain)
> +			goto error;
> +
> +		pd_pdev = platform_device_alloc(dev_data->name, domain_index);
> +		if (!pd_pdev) {
> +			dev_err(dev, "Failed to allocate platform device\n");
> +			goto error;
> +		}
> +
> +		pd_pdev->dev.platform_data = domain;
> +
> +		domain->blk_ctl = blk_ctl;
> +		domain->hw = &dev_data->pds[i];
> +		domain->id = domain_index;
> +		domain->genpd.name = dev_data->pds[i].name;
> +		domain->genpd.power_off = imx_blk_ctl_power_off;
> +		domain->genpd.power_on = imx_blk_ctl_power_on;
> +		domain->dev = &pd_pdev->dev;
> +		domain->hooked = false;
> +
> +		ret = pm_genpd_init(&domain->genpd, NULL, true);
> +		pd_pdev->dev.parent = dev;
> +
> +		if (domain->hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)
> +			blk_ctl->bus_domain = &domain->genpd;
> +
> +		ret = platform_device_add(pd_pdev);
> +		if (ret) {
> +			platform_device_put(pd_pdev);
> +			goto error;
> +		}
> +		blk_ctl->onecell_data.domains[i] = &domain->genpd;
> +	}
> +
> +	return of_genpd_add_provider_onecell(dev->of_node, &blk_ctl->onecell_data);
> +
> +error:
> +	for (; i >= 0; i--) {
> +		genpd = blk_ctl->onecell_data.domains[i];
> +		if (!genpd)
> +			continue;
> +		domain = to_imx_blk_ctl_pd(genpd);
> +		if (domain->dev)
> +			platform_device_put(to_platform_device(domain->dev));
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
> +
> +const struct dev_pm_ops imx_blk_ctl_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +			   pm_runtime_force_resume)
> +};
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
> diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
> new file mode 100644
> index 000000000000..6780d00ec8c5
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_IMX_BLK_CTL_H
> +#define __SOC_IMX_BLK_CTL_H
> +
> +enum imx_blk_ctl_pd_type {
> +	BLK_CTL_PD,
> +};
> +
> +struct imx_blk_ctl_hw {
> +	int type;
> +	char *name;
> +	char *active_pd_name;
> +	u32 offset;
> +	u32 mask;
> +	u32 flags;
> +	u32 id;
> +	u32 rst_offset;
> +	u32 rst_mask;
> +	u32 errata;
> +};
> +
> +struct imx_blk_ctl_domain {
> +	struct generic_pm_domain genpd;
> +	struct device *active_pd;
> +	struct imx_blk_ctl *blk_ctl;
> +	struct imx_blk_ctl_hw *hw;
> +	struct device *dev;
> +	bool hooked;
> +	u32 id;
> +};
> +
> +struct imx_blk_ctl_dev_data {
> +	struct regmap_config config;
> +	struct imx_blk_ctl_hw *pds;
> +	struct imx_blk_ctl_hw *hw_hsk;
> +	u32 pds_num;
> +	u32 max_num;
> +	char *name;
> +};
> +
> +struct imx_blk_ctl {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct genpd_onecell_data onecell_data;
> +	const struct imx_blk_ctl_dev_data *dev_data;
> +	struct clk_bulk_data *clks;
> +	u32 num_clks;
> +	struct generic_pm_domain *bus_domain;
> +
> +	struct mutex lock;
> +};
> +
> +#define IMX_BLK_CTL(_type, _name, _active_pd, _id, _offset, _mask, _rst_offset, _rst_mask,	\
> +		    _flags, _errata)								\
> +	{											\
> +		.type = _type,									\
> +		.name = _name,									\
> +		.active_pd_name = _active_pd,							\
> +		.id = _id,									\
> +		.offset = _offset,								\
> +		.mask = _mask,									\
> +		.flags = _flags,								\
> +		.rst_offset = _rst_offset,							\
> +		.rst_mask = _rst_mask,								\
> +		.errata = _errata,								\
> +	}
> +
> +#define IMX_BLK_CTL_PD(_name, _active_pd, _id, _offset, _mask, _rst_offset, _rst_mask, _flags)	\
> +	IMX_BLK_CTL(BLK_CTL_PD, _name, _active_pd, _id, _offset, _mask, _rst_offset,		\
> +		    _rst_mask, _flags, 0)
> +
> +#define IMX_BLK_CTL_PD_ERRATA(_name, _active_pd, _id, _offset, _mask, _rst_offset, _rst_mask,	\
> +			      _flags, _errata)							\
> +	IMX_BLK_CTL(BLK_CTL_PD, _name, _active_pd, _id, _offset, _mask, _rst_offset,		\
> +		    _rst_mask, _flags, _errata)
> +
> +int imx_blk_ctl_register(struct device *dev);
> +
> +#define IMX_BLK_CTL_PD_HANDSHAKE	BIT(0)
> +#define IMX_BLK_CTL_PD_RESET		BIT(1)
> +#define IMX_BLK_CTL_PD_BUS		BIT(2)
> +
> +const extern struct dev_pm_ops imx_blk_ctl_pm_ops;
> +
> +#endif
> -- 
> 2.30.0
> 
