Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABADC3BBE85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGEO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhGEO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:58:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF6C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 07:55:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m0Q0G-0007rp-4w; Mon, 05 Jul 2021 16:55:20 +0200
Message-ID: <0fc1f5043eeedb0c40ae9f76e245c648e0c88cde.camel@pengutronix.de>
Subject: Re: [PATCH V8 3/4] soc: imx: Add generic blk-ctl driver
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        jagan@amarulasolutions.com, Peng Fan <peng.fan@nxp.com>
Date:   Mon, 05 Jul 2021 16:55:17 +0200
In-Reply-To: <20210629072941.7980-4-peng.fan@oss.nxp.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
         <20210629072941.7980-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Am Dienstag, dem 29.06.2021 um 15:29 +0800 schrieb Peng Fan (OSS):
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
> ---
>  drivers/soc/imx/Makefile  |   2 +-
>  drivers/soc/imx/blk-ctl.c | 324 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h |  85 ++++++++++
>  3 files changed, 410 insertions(+), 1 deletion(-)
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
> diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
> new file mode 100644
> index 000000000000..cec1884202e0
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "blk-ctl.h"
> +
> +static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct generic_pm_domain *genpd)
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
> +static int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
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

I'm still not a fan of enabling all the clocks going into the blk-ctl
to power up/down one specific domain. It's not really a problem with
clocks, where the parents are always on, as the clock gate/ungate is
pretty cheap, but as soon as you get to something like the display
pixel clock, where the parent PLL may be shut down, the clock enable
may easily be the most costly operation of this whole function, even if
this specific clock isn't even needed for the domain in question.

> +	if (ret) {
> +		mutex_unlock(&blk_ctl->lock);
> +		return ret;
> +	}
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret)
> +			dev_err(blk_ctl->dev, "Handshake failed when power on\n");
> +
> +		/* Expected, handshake already handle reset*/
> +		goto disable_clk;
> +	}
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
> +		if (ret)
> +			goto disable_clk;
> +
> +		/* Wait for reset propagate */
> +		udelay(5);
> +
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> 

I find this very hard to follow and reason about. Why do we even need
those different paths for domains with or without the handshake?

Shouldn't it be enough to just be enough to do the following in all
cases:
1. release sft reset
2. enable sft clock
3. wait a little for reset to propagate or ADB to ack power up

> +disable_clk:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	mutex_unlock(&blk_ctl->lock);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_power_off(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
> +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
> +	int ret = 0;
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
> +			goto disable_clk;
> +
> +		if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +			ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
> +			if (ret)
> +				goto disable_clk;
> +		}
> +	} else {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);

Why would we need to enable the handshake again in the power DOWN path?
The clock/reset bits should still be set from the power up. The power
down should probably just be a no-op for the blk-ctl bus domains, to
allow the proper ADB handshake in the PGC domain power-down.

> +		if (ret)
> +			dev_err(blk_ctl->dev, "Handshake failed when power off\n");
> +	}
> +
> +disable_clk:
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
> +
> +	if (domain->hw->active_pd_name) {
> +		active_pd = dev_pm_domain_attach_by_name(dev, domain->hw->active_pd_name);
> +		if (IS_ERR_OR_NULL(active_pd)) {
> +			ret = PTR_ERR(active_pd) ? : -ENODATA;
> +			pdev->dev.of_node = NULL;

This is extremely ugly. I think we should not even have separate
platform drivers for the blk-ctl domains, there is just no reason for
it. See below for more comments in that direction.
 
> +			return ret;
> +		}
> +
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
> +		dev_warn(dev, "failed to add subdomain: %s\n", domain->genpd.name);

I don't see where the dispmix_bus domain and clock is kept enabled. I
would guess that the bus domain should be some kind of parent to the
lcdif and mipi domains, as I don't think it would be okay to disable
the bus clock, while any of the peripherals in the dispmix complex are
still active. Am I missing something here?

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
> +	if (domain->hw->active_pd_name)
> +		parent_genpd = pd_to_genpd(active_pd->pm_domain);

This has probably never been tested. active_pd is undefined at this
point, so will most likely lead to a kernel crash.
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
> +	if (idx >= genpd_data->num_domains)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!genpd_data->domains[idx])
> +		return ERR_PTR(-ENOENT);
> +
> +	domain = to_imx_blk_ctl_pd(genpd_data->domains[idx]);
> +
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

We don't need a full blow platform device and a driver for the
individual domains. The only point where we need the device is to
attach the parent PGC power domains and for this we only need a
device. 

So we could either have a dummy device for this usage in the domain or
we could even reuse the device in the genpd, which is initialized in
pm_genpd_init.

Now while I think about it... genpd_dev_pm_attach_by_name already
allocates the virtual dummy device. I don't think we need to do
anything here on our own. Just get rid of the platform device and
driver.

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

There is really no need for the complexity with the hooked property
(the mutex around the read/write access still doesn't make it properly
thread safe) and the blk-ctl domain probe/remove calls. Just handle
everything within this loop. This would make the driver a whole lot
more easy to follow.

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
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +};
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);

This code is linked into the same module as the platform driver using
it. So there is no need to export those symbols and expose them to the
whole kernel.

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

Initialized, but unused.

> +	char *name;
> +	char *active_pd_name;
> +	u32 offset;
> +	u32 mask;

offset and mask are way too generic names. I had to spend some time
reading the driver to find out that those are the clock enable bits.
This should be clear from the naming.

> +	u32 flags; 
> +	u32 id;
> +	u32 rst_offset;
> +	u32 rst_mask;
> +	u32 errata;

Unused.

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

There are already a lot of pointers between the different structures.
Why do we need those id properties? You should be able to get to all
needed information by chasing pointers, instead of  indexing into
arrays. Really the only point where a id->domain mapping is done should
be the xlate function.

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

There should be nothing special about the bus domain at all. Right now
this permeates through the whole driver that the bus domain is somehow
special. It should just be a parent domain of the other domains, or
kept alive via some other appropriate means.

> +
> +	struct mutex lock;

This mutex is only used in the common blk-ctl code, but is initialized
in imx8mm_blk_ctrl_probe. This seems very inconsistent. I would have
expected this mutex to be initialized in imx_blk_ctl_register. However,
once you get rid of the hooked and bus domain magic, this mutex may as
well be per-domain, at which point I think you don't even need the
mutex, as the genpd locking should be enough then.

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


