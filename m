Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F472442DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhKBMZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Nov 2021 08:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:25:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D3C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 05:23:18 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhsok-0008Ea-4s; Tue, 02 Nov 2021 13:23:06 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mhsoe-004AoX-2M; Tue, 02 Nov 2021 13:23:00 +0100
Message-ID: <296d4a9fdbe2b60eea4d259f1e2e3fe8d67b3c07.camel@pengutronix.de>
Subject: Re: [PATCH v3 4/8] reset: Add Sunplus SP7021 reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com
Date:   Tue, 02 Nov 2021 13:22:59 +0100
In-Reply-To: <c6f0aaef57b25705af988797ede5ab7119852a5c.1635737544.git.qinjian@cqplus1.com>
References: <cover.1635737544.git.qinjian@cqplus1.com>
         <c6f0aaef57b25705af988797ede5ab7119852a5c.1635737544.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-01 at 13:01 +0800, Qin Jian wrote:
> Add reset driver for Sunplus SP7021 SoC.

You don't mention Q645 here, it appears this driver supports both SoCs?

[...]
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index be799a5ab..50695ab47 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -249,6 +249,14 @@ config RESET_TI_SYSCON
>  	  you wish to use the reset framework for such memory-mapped devices,
>  	  say Y here. Otherwise, say N.
> 
>
> +config RESET_SUNPLUS

Please add these entries in alphabetical order.

> +	bool "Sunplus SoCs Reset Driver"

Can this be made:

	depends SOC_SP7021 || SOC_Q645 || COMPILE_TEST

?

> +	help
> +	  This enables the reset driver support for Sunplus SP7021 SoC family.
> +	  Say Y if you want to control reset signals by the reset controller.
> +	  Otherwise, say N.
> +	  This driver is selected automatically by platform config.

Which platform config?


[...]
> diff --git a/drivers/reset/reset-sunplus.c b/drivers/reset/reset-sunplus.c
> new file mode 100644
> index 000000000..696efd75e
> --- /dev/null
> +++ b/drivers/reset/reset-sunplus.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * SP7021 reset driver
> + *
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Drop this boilerplate, this is not required with the SPDX identifier
above.

> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/reboot.h>
> +
> +#if defined(CONFIG_SOC_SP7021)
> +#include <dt-bindings/reset/sp-sp7021.h>
> +#elif defined(CONFIG_SOC_Q645)
> +#include <dt-bindings/reset/sp-q645.h>
> +#endif

I'd prefer if you added namespace prefixes to the defines and included
both headers unconditionally.
These are just required for RST_MAX, correct?

> +
> +#define BITASSERT(id, val)          ((1 << (16 + id)) | (val << id))
> +
> +
> +struct sp_reset_data {
> +	struct reset_controller_dev	rcdev;
> +	void __iomem			*membase;
> +} sp_reset;

Please allocate this with devm_kzalloc in the probe function instead.

> +
> +
> +static inline struct sp_reset_data *
> +to_sp_reset_data(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct sp_reset_data, rcdev);
> +}
> +
> +static int sp_reset_update(struct reset_controller_dev *rcdev,
> +			      unsigned long id, bool assert)
> +{
> +	struct sp_reset_data *data = to_sp_reset_data(rcdev);
> +	int reg_width = sizeof(u32)/2;
> +	int bank = id / (reg_width * BITS_PER_BYTE);
> +	int offset = id % (reg_width * BITS_PER_BYTE);
> +	void __iomem *addr;
> +
> +	addr = data->membase + (bank * 4);
> +
> +	if (assert)
> +		writel(BITASSERT(offset, 1), addr);
> +	else
> +		writel(BITASSERT(offset, 0), addr);

Could be

	writel(BITASSERT(offset, assert), addr);

> +
> +	return 0;
> +}
> +
> +static int sp_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	return sp_reset_update(rcdev, id, true);
> +}
> +
> +
> +static int sp_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	return sp_reset_update(rcdev, id, false);
> +}
> +
> +static int sp_reset_status(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct sp_reset_data *data = to_sp_reset_data(rcdev);
> +	int reg_width = sizeof(u32)/2;
> +	int bank = id / (reg_width * BITS_PER_BYTE);
> +	int offset = id % (reg_width * BITS_PER_BYTE);
> +	u32 reg;
> +
> +	reg = readl(data->membase + (bank * 4));
> +
> +	return !!(reg & BIT(offset));
> +}
> +
> +static int sp_restart(struct notifier_block *this, unsigned long mode,
> +				void *cmd)
> +{
> +	sp_reset_assert(&sp_reset.rcdev, RST_SYSTEM);
> +	sp_reset_deassert(&sp_reset.rcdev, RST_SYSTEM);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sp_restart_nb = {
> +	.notifier_call = sp_restart,
> +	.priority = 192,
> +};
> +
> +static const struct reset_control_ops sp_reset_ops = {
> +	.assert		= sp_reset_assert,
> +	.deassert	= sp_reset_deassert,
> +	.status		= sp_reset_status,
> +};
> +
> +static const struct of_device_id sp_reset_dt_ids[] = {
> +	{ .compatible = "sunplus,sp7021-reset", },
> +	{ .compatible = "sunplus,q645-reset", },
> +	{ /* sentinel */ },
> +};
> +
> +static int sp_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sp_reset_data *data = &sp_reset;
> +	void __iomem *membase;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	membase = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(membase))
> +		return PTR_ERR(membase);
> +
> +	data->membase = membase;
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = RST_MAX;

Use of_device_get_match_data() to determine the correct number of
resets.

regards
Philipp
