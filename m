Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E25C372841
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEDJtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhEDJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:48:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 02:47:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ldreS-0003Qr-1i; Tue, 04 May 2021 11:47:36 +0200
Message-ID: <6997abd422ffa1fa384a048552109aec1095abc3.camel@pengutronix.de>
Subject: Re: [PATCH V2 3/4] soc: imx: Add generic blk-ctl driver
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Date:   Tue, 04 May 2021 11:47:32 +0200
In-Reply-To: <20210430052746.10815-4-peng.fan@oss.nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
         <20210430052746.10815-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 30.04.2021 um 13:27 +0800 schrieb Peng Fan (OSS):
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
>  drivers/soc/imx/Makefile  |   2 +-
>  drivers/soc/imx/blk-ctl.c | 303 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h |  76 ++++++++++
>  3 files changed, 380 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/imx/blk-ctl.c
>  create mode 100644 drivers/soc/imx/blk-ctl.h
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 078dc918f4f3..d3d2b49a386c 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>  endif
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
> new file mode 100644
> index 000000000000..1f764dfd308d
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
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
> +
> +#include "blk-ctl.h"
> +
> +static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct generic_pm_domain *genpd)
> +{
> +	return container_of(genpd, struct imx_blk_ctl_domain, pd);
> +}
> +
> +static int imx_blk_ctl_enable_hsk(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->hw_hsk;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	int ret;
> +
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> +
> +	/* Wait for handshake */
> +	udelay(5);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_off(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd;
> +	struct imx_blk_ctl *blk_ctl;
> +	const struct imx_blk_ctl_hw *hw;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	pd = to_imx_blk_ctl_pd(domain);
> +	blk_ctl = pd->blk_ctl;
> +	regmap = blk_ctl->regmap;
> +	hw = &blk_ctl->dev_data->pds[pd->id];
> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret)
> +		return ret;

This looks a bit strange to me. Does that mean that you keep all the
CCM clocks going into the blkctl enabled as long as one of the blkctl
virtual power domains is up? I would have expected each virtual PD to
have a list of clock names that need to be enabled, to make this more
selective.

I haven't completely thought it through if this is a problem, but I
could see some CCM PLLs running without a reason if all CCM clocks are
kept enabled. This surely is something we want to avoid from a pwoer
consumption PoV.

> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, 0);
> +	if (ret)
> +		goto hsk_fail;
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);
> +
> +	if (atomic_dec_and_test(&blk_ctl->power_count)) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret) {
> +			dev_err(blk_ctl->dev, "Hankshake fail\n");
> +			goto hsk_fail;
> +		}
> +	}
> +
> +hsk_fail:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd;
> +	struct regmap *regmap;
> +	const struct imx_blk_ctl_hw *hw;
> +	int ret;
> +	struct imx_blk_ctl *blk_ctl;
> +
> +	pd = to_imx_blk_ctl_pd(domain);
> +	blk_ctl = pd->blk_ctl;
> +	regmap = blk_ctl->regmap;
> +	hw = &blk_ctl->dev_data->pds[pd->id];
> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret)
> +		return ret;
> +
> +	if ((atomic_read(&blk_ctl->power_count) == 0)) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret) {
> +			dev_err(blk_ctl->dev, "Hankshake fail\n");
> +			goto disable_clk;
> +		}
> +	}

This is bogus. The variable isn't used as a atomic, if at all this
should use atomic_inc_return, but I think even that isn't correct in
that case. imx_blk_ctl_enable_hsk() includes a wait time, so if two
paths call this function at the same time, the second caller would be
able to overtake the first one, which is still waiting for the
handshake to complete, effectively skipping the handshake. This needs a
proper lock, as this function isn't called from a performance critical
path it makes no sense to try to optimize this with an atomic counter,
rather than going with a mutex.

> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);
> +
> +	/* Wait for reset propagate */
> +	udelay(5);
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> +	if (ret)
> +		goto disable_clk;
> +
> +	atomic_inc(&blk_ctl->power_count);
> +
> +disable_clk:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_attach_pd(struct device *dev, struct device **devs, char **pd_names,
> +				 u32 num_pds)
> +{
> +	int i, ret;
> +
> +	if (!pd_names)
> +		return 0;
> +
> +	if (dev->pm_domain) {
> +		devs[0] = dev;
> +		pm_runtime_enable(dev);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < num_pds; i++) {
> +		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
> +		if (IS_ERR_OR_NULL(devs[i])) {
> +			ret = PTR_ERR(devs[i]) ? : -ENODATA;
> +			goto detach_pm;
> +		}
> +	}
> +
> +	return 0;
> +
> +detach_pm:
> +	for (i--; i >= 0; i--)
> +		dev_pm_domain_detach(devs[i], false);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_register_pd(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
> +	int num = dev_data->pds_num;
> +	struct imx_blk_ctl_domain *domain;
> +	int i, ret;
> +
> +	blk_ctl->onecell_data.num_domains = num;
> +	blk_ctl->onecell_data.domains = devm_kcalloc(dev, num,
> +						     sizeof(struct generic_pm_domain *),
> +						     GFP_KERNEL);
> +
> +	if (!blk_ctl->onecell_data.domains)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; i++) {
> +		domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
> +		if (!domain) {
> +			ret = -ENOMEM;
> +			goto remove_genpd;
> +		}
> +		domain->pd.name = dev_data->pds[i].name;
> +		domain->pd.power_off = imx_blk_ctl_power_off;
> +		domain->pd.power_on = imx_blk_ctl_power_on;
> +		domain->blk_ctl = blk_ctl;
> +		domain->id = i;
> +
> +		ret = pm_genpd_init(&domain->pd, NULL, true);
> +		if (ret)
> +			return ret;
> +
> +		blk_ctl->onecell_data.domains[i] = &domain->pd;
> +	}
> +
> +	return 0;
> +
> +remove_genpd:
> +	for (i = i - 1; i >= 0; i--)
> +		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_hook_pd(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
> +	const struct imx_blk_ctl_hw *pds = dev_data->pds;
> +	int num_active_pd = dev_data->num_active_pd;
> +	int num = dev_data->pds_num;
> +	struct generic_pm_domain *genpd, *child_genpd;
> +	int ret;
> +	int i, j;
> +
> +	blk_ctl->active_pds = devm_kcalloc(dev, num_active_pd, sizeof(struct device *), GFP_KERNEL);
> +	if (!blk_ctl->active_pds)
> +		return -ENOMEM;
> +
> +	ret = imx_blk_ctl_attach_pd(dev, blk_ctl->active_pds, dev_data->active_pd_names,
> +				    num_active_pd);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		dev_err(dev, "Failed to attach active pd: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		for (j = 0; j < num_active_pd; j++) {
> +			genpd = pd_to_genpd(blk_ctl->active_pds[j]->pm_domain);
> +			if (!strcmp(genpd->name, pds[i].parent_name))
> +				break;
> +		}
> +
> +		child_genpd = blk_ctl->onecell_data.domains[i];
> +		if (pm_genpd_add_subdomain(genpd, child_genpd))
> +			pr_warn("failed to add subdomain:\n");
> +	}
> +
> +	return 0;
> +}
> +
> +int imx_blk_ctl_register(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
> +	int num = dev_data->pds_num;
> +	int i, ret;
> +
> +	if (!blk_ctl)
> +		return -ENODEV;
> +
> +	ret = imx_blk_ctl_register_pd(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_blk_ctl_hook_pd(dev);
> +	if (ret)
> +		goto unregister_pd;
> +
> +	ret = of_genpd_add_provider_onecell(dev->of_node, &blk_ctl->onecell_data);
> +	if (ret)
> +		goto detach_pd;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	pm_runtime_put(dev);
> +
> +	return 0;
> +
> +detach_pd:
> +	for (i = blk_ctl->dev_data->num_active_pd; i >= 0; i--)
> +		dev_pm_domain_detach(blk_ctl->active_pds[i], false);
> +unregister_pd:
> +	for (i = num - 1; i >= 0; i--)
> +		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
> +
> +static int __maybe_unused imx_blk_ctl_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int __maybe_unused imx_blk_ctl_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}

Why those empty stubs? If you don't need to do anything for
suspend/resume, just don't add the functions.

> +
> +const struct dev_pm_ops imx_blk_ctl_pm_ops = {
> +	SET_RUNTIME_PM_OPS(imx_blk_ctl_runtime_suspend,
> +			   imx_blk_ctl_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +			   pm_runtime_force_resume)
> +};
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
> diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
> new file mode 100644
> index 000000000000..e736369406a1
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.h
> @@ -0,0 +1,76 @@
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
> +	char *parent_name;
> +	u32 offset;
> +	u32 mask;
> +	u32 flags;
> +	u32 id;
> +	u32 rst_offset;
> +	u32 rst_mask;
> +};
> +
> +struct imx_blk_ctl_domain {
> +	struct generic_pm_domain pd;
> +	struct imx_blk_ctl *blk_ctl;
> +	u32 id;
> +};
> +
> +struct imx_blk_ctl_dev_data {
> +	struct regmap_config config;
> +	struct imx_blk_ctl_hw *pds;
> +	struct imx_blk_ctl_hw hw_hsk;
> +	u32 pds_num;
> +	char **active_pd_names;
> +	u32 num_active_pd;
> +};
> +
> +struct imx_blk_ctl {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct device **active_pds;
> +	u32 pds_num;
> +	u32 active_pd_count;
> +	struct genpd_onecell_data onecell_data;
> +	const struct imx_blk_ctl_dev_data *dev_data;
> +	struct clk_bulk_data *clks;
> +	u32 num_clks;
> +
> +	atomic_t power_count;
> +};
> +
> +#define IMX_BLK_CTL(_type, _name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask,	\
> +		    _flags)								\
> +	{										\
> +		.type = _type,								\
> +		.name = _name,								\
> +		.parent_name = _parent_name,						\
> +		.id = _id,								\
> +		.offset = _offset,							\
> +		.mask = _mask,								\
> +		.flags = _flags,							\
> +		.rst_offset = _rst_offset,						\
> +		.rst_mask = _rst_mask,							\
> +	}
> +
> +#define IMX_BLK_CTL_PD(_name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask, _flags) \
> +	IMX_BLK_CTL(BLK_CTL_PD, _name, _parent_name, _id, _offset, _mask, _rst_offset,		\
> +		    _rst_mask, _flags)
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


