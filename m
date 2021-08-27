Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC393FA079
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhH0USo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:18:44 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43157 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhH0USn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:18:43 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BB93B1C0003;
        Fri, 27 Aug 2021 20:17:49 +0000 (UTC)
Date:   Fri, 27 Aug 2021 22:17:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     kavyasree.kotagiri@microchip.com
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Manohar.Puri@microchip.com,
        Madhuri.Sripada@microchip.com
Subject: Re: [PATCH] ARM: at91: add basic support for new SoC lan966x
Message-ID: <YSlIaUMt0nS7MFoP@piout.net>
References: <20210827092623.10677-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827092623.10677-1-kavyasree.kotagiri@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kavya,

Thank you for the patch and the upstreaming effort!

On 27/08/2021 14:56:23+0530, kavyasree.kotagiri@microchip.com wrote:
> From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>
> 
> This patch introduces Microchip LAN966X ARMv7 based SoC family
> of multiport gigabit AVB/TSN-capable ethernet switches.
> It supports two SKUs: 4-port LAN9662 with multiprotocol
> processing support and 8-port LAN9668 switch.
> 
> LAN966X includes copper and serial ethernet interfaces,
> peripheral interfaces such as PCIe, USB, TWI, SPI, UART, QSPI,
> SD/eMMC, Parallel Interface (PI) as well as synchronization
> and trigger inputs/outputs.
> 
> Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig   | 13 +++++++++++++
>  arch/arm/mach-at91/Makefile  |  1 +
>  arch/arm/mach-at91/lan966x.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 arch/arm/mach-at91/lan966x.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index ccd7e80ce943..06cb425af761 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -122,6 +122,14 @@ config SOC_SAM9X60
>  	help
>  	  Select this if you are using Microchip's SAM9X60 SoC
> 
> +config SOC_LAN966X
> +	bool "ARMv7 based Microchip LAN966X SoC family"
> +	depends on ARCH_MULTI_V7
> +	select SOC_LAN966
> +	select DW_APB_TIMER_OF
> +	help
> +	  This enables support for ARMv7 based Microchip LAN966X SoC family.
> +
>  comment "Clocksource driver selection"
> 
>  config ATMEL_CLOCKSOURCE_PIT
> @@ -188,6 +196,11 @@ config SOC_SAMA5
>  	select SOC_SAM_V7
>  	select SRAM if PM
> 
> +config SOC_LAN966
> +	bool
> +	select ARM_GIC
> +	select MEMORY
> +
>  config ATMEL_PM
>  	bool
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index f565490f1b70..93cfd5b4e6d4 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -6,6 +6,7 @@
>  # CPU-specific support
>  obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
>  obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
> +obj-$(CONFIG_SOC_LAN966X)	+= lan966x.o
>  obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
>  obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
>  obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> diff --git a/arch/arm/mach-at91/lan966x.c b/arch/arm/mach-at91/lan966x.c
> new file mode 100644
> index 000000000000..de689f854068
> --- /dev/null
> +++ b/arch/arm/mach-at91/lan966x.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Setup code for LAN966X
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
> +static void __init lan966x_dt_device_init(void)
> +{
> +	of_platform_default_populate(NULL, NULL, NULL);

Are you sure this is needed? This is a workaround that is there on the
other platforms because of the at91 pinctrl driver. Ideally, you should
be able to boot without that. Can you confirm?

> +}
> +
> +static const char *const lan966x_dt_board_compat[] __initconst = {
> +	"microchip,lan966x",
> +	NULL
> +};
> +
> +DT_MACHINE_START(lan966x_dt, "Microchip LAN966X")
> +	/* Maintainer: Microchip */
> +	.init_machine	= lan966x_dt_device_init,
> +	.dt_compat	= lan966x_dt_board_compat,
> +MACHINE_END
> --
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
