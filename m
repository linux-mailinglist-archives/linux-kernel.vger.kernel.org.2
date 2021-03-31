Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1435040A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhCaQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:01:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48121 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhCaQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:01:31 -0400
Received: from localhost (lfbn-lyo-1-1679-174.w90-65.abo.wanadoo.fr [90.65.110.174])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 20CE3240011;
        Wed, 31 Mar 2021 16:01:24 +0000 (UTC)
Date:   Wed, 31 Mar 2021 18:01:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: Re: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
Message-ID: <YGSc1L8yW0KniOsx@piout.net>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-23-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331105908.23027-23-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2021 13:59:06+0300, Claudiu Beznea wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Introduce new family of SoCs, sama7, and first SoC, sama7g5.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/Makefile |  1 +
>  arch/arm/mach-at91/sama7.c  | 48 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 arch/arm/mach-at91/sama7.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index f565490f1b70..6cc6624cddac 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
>  obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
>  obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
>  obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> +obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
>  
>  # Power Management
>  obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
> diff --git a/arch/arm/mach-at91/sama7.c b/arch/arm/mach-at91/sama7.c
> new file mode 100644
> index 000000000000..e04cadb569ad
> --- /dev/null
> +++ b/arch/arm/mach-at91/sama7.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Setup code for SAMA7
> + *
> + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> + *
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/system_misc.h>
> +
> +#include "generic.h"
> +
> +static void __init sama7_common_init(void)
> +{
> +	of_platform_default_populate(NULL, NULL, NULL);

Is this necessary? This is left as a workaround for the old SoCs using
pinctrl-at91. I guess this will be using pio4 so this has to be removed.

> +}
> +
> +static void __init sama7_dt_device_init(void)
> +{
> +	sama7_common_init();
> +}
> +
> +static const char *const sama7_dt_board_compat[] __initconst = {
> +	"microchip,sama7",
> +	NULL
> +};
> +
> +DT_MACHINE_START(sama7_dt, "Microchip SAMA7")
> +	/* Maintainer: Microchip */
> +	.init_machine	= sama7_dt_device_init,
> +	.dt_compat	= sama7_dt_board_compat,
> +MACHINE_END
> +
> +static const char *const sama7g5_dt_board_compat[] __initconst = {
> +	"microchip,sama7g5",
> +	NULL
> +};
> +
> +DT_MACHINE_START(sama7g5_dt, "Microchip SAMA7G5")
> +	/* Maintainer: Microchip */
> +	.init_machine	= sama7_dt_device_init,
> +	.dt_compat	= sama7g5_dt_board_compat,
> +MACHINE_END
> +
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
