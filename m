Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D2352F05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDBSQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBSQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:16:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B1FC61163;
        Fri,  2 Apr 2021 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617387390;
        bh=u3PAqOYVOWNVAEDlIIKhFM2h1sjcd3bKahqTg5C50CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsLg2bXvLAGN3DamTYLeOVKetksSKP2LzmsZa9Wpp5voKAeoTN4Lxj8SgCGv0P9Ao
         c6N8BnNq2BKo5wX6UlpjZuD4ZoE0NvZVCG+7cROJsLqSw5YzL7CVP9BZS89r4e8CdT
         6mSLS8zmEbKVyFBKQ8BO/e7dOXknztAOLlsSZ0+1FQZ6ULh/a8HRxChsVe4dLlmSFH
         TEgwWRHZMqhZ6Mg6DGEDWby3dGx1nN9Z+OIPwSjF2MkruWZhlil7WBwzA1rF983Mqt
         NYJD0BvSWHx5kUx926dfte5kMnwAJXrrNB8fP0HnoPTCq0rvqFtYL84ZffW5lcs589
         AIelMmQPO9GZg==
Date:   Fri, 2 Apr 2021 23:46:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] soc: actions: Add Actions Semi Owl socinfo driver
Message-ID: <20210402181624.GC31906@thinkpad>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <75ec4eff3e6113f4e72daa1b428c355b28005297.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75ec4eff3e6113f4e72daa1b428c355b28005297.1617110420.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:48:18PM +0300, Cristian Ciocaltea wrote:
> The driver provides information about the Action Semi Owl family of
> SoCs (S500, S700 and S900) to user space via sysfs: machine, family,
> soc_id, serial_number.
> 
> Note the serial number is currently provided only for the S500 SoC
> variant.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  drivers/soc/actions/Kconfig                   |   8 +
>  drivers/soc/actions/Makefile                  |   1 +
>  drivers/soc/actions/owl-socinfo.c             | 152 ++++++++++++++++++
>  include/linux/soc/actions/owl-serial-number.h |  20 +++
>  4 files changed, 181 insertions(+)
>  create mode 100644 drivers/soc/actions/owl-socinfo.c
>  create mode 100644 include/linux/soc/actions/owl-serial-number.h
> 
> diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
> index 1aca2058a40c..15faade9282d 100644
> --- a/drivers/soc/actions/Kconfig
> +++ b/drivers/soc/actions/Kconfig
> @@ -14,4 +14,12 @@ config OWL_PM_DOMAINS
>  	  power-gating on Actions Semiconductor S500, S700 and S900 SoCs.
>  	  If unsure, say 'n'.
>  
> +config OWL_SOCINFO
> +	bool "Actions Semi Owl SoC info driver"
> +	default ARCH_ACTIONS
> +	select SOC_BUS
> +	help
> +	  Say 'y' here to support the Action Semiconductor Owl socinfo

Actions Semi

> +	  driver, providing information about the SoC to user space.
> +
>  endif
> diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
> index 4db9e7b050e5..4b2591d3089f 100644
> --- a/drivers/soc/actions/Makefile
> +++ b/drivers/soc/actions/Makefile
> @@ -2,3 +2,4 @@
>  
>  obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
>  obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
> +obj-$(CONFIG_OWL_SOCINFO) += owl-socinfo.o
> diff --git a/drivers/soc/actions/owl-socinfo.c b/drivers/soc/actions/owl-socinfo.c
> new file mode 100644
> index 000000000000..f28eafac3792
> --- /dev/null
> +++ b/drivers/soc/actions/owl-socinfo.c
> @@ -0,0 +1,152 @@

[...]

> + * Access SoC's serial number stored by the bootloader in DDR memory.
> + */
> +static int owl_socinfo_read_serial_rmem(struct device *dev)
> +{
> +	struct reserved_mem *rmem;
> +	struct device_node *np;
> +	int ret = 0;
> +
> +	np = of_find_compatible_node(NULL, NULL, "actions,owl-soc-serial");
> +	if (!np)
> +		return -ENXIO;
> +
> +	rmem = of_reserved_mem_lookup(np);

If you do this correctly, you could use "pdev->dev.of_node" here instead of
using "of_find_compatible_node()" for getting np.

> +	if (!rmem) {
> +		dev_err(dev, "failed to acquire reserved memory region\n");
> +		ret = -EINVAL;
> +		goto out_put;
> +	}
> +

[...]

> +static const struct of_device_id owl_socinfo_of_match[] = {
> +	{ .compatible = "actions,s500-soc", .data = &s500_soc_info, },
> +	{ .compatible = "actions,s700-soc", .data = &s700_soc_info, },
> +	{ .compatible = "actions,s900-soc", .data = &s900_soc_info, },

Please don't add S700/S900 for now.

> +	{ }
> +};
> +
> +static struct platform_driver owl_socinfo_platform_driver = {
> +	.probe = owl_socinfo_probe,
> +	.driver = {
> +		.name = "owl-socinfo",
> +		.of_match_table = owl_socinfo_of_match,
> +	},
> +};
> +
> +static int __init owl_socinfo_init(void)
> +{
> +	return platform_driver_register(&owl_socinfo_platform_driver);
> +}
> +subsys_initcall(owl_socinfo_init);
> diff --git a/include/linux/soc/actions/owl-serial-number.h b/include/linux/soc/actions/owl-serial-number.h
> new file mode 100644
> index 000000000000..f8595417668f
> --- /dev/null
> +++ b/include/linux/soc/actions/owl-serial-number.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + */
> +
> +#ifndef __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__
> +#define __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__
> +
> +#if IS_ENABLED(CONFIG_OWL_SOCINFO)
> +u32 owl_get_soc_serial_low(void);
> +u32 owl_get_soc_serial_high(void);

Where are these APIs used?

Thanks,
Mani

> +#else
> +static inline u32 owl_get_soc_serial_low(void)
> +{ return 0; }
> +
> +static inline u32 owl_get_soc_serial_high(void)
> +{ return 0; }
> +#endif /* CONFIG_OWL_SOCINFO */
> +
> +#endif /* __SOC_ACTIONS_OWL_SERIAL_NUMBER_H__ */
> -- 
> 2.31.1
> 
