Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB9540F96E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhIQNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:42:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:32761 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhIQNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631886066; x=1663422066;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Oa0ink7SFX66emYOzWbcfzSJqZKQbbcdxaG91Brmu5E=;
  b=kuVMxAa1LrdpFWP/JuNgWhPi+eUXQZikUk+2VZYvLOEdlezOHLqmLoUP
   RgvR5Qt9vjTO4V00p1398oCs0lph1SB5uAdxp1zkeccOdY7VgvLVDXuVh
   kJsqVUrHj+HkHBXyuYcuQhGzH34q/ZhBnLSOl5T4styvfb72S30/kT0DW
   gke40Sgw7ZHtGPlXjFSes3OjZTh/jf++DmyOJGzt9rFD6JoV3nnO55Q0T
   ppGLhs63fLR0Nl+Era7rNatmSGiviRGCJbRne984CVJLrIN4xuJ/qS2Er
   TY00uZ2VfyhxTDdujR1owOQgyvEG4UXNmyqufPmFI1vEhkTp55uM0EE2/
   w==;
IronPort-SDR: degCHNWaZCoOgkvl72wGfazGR+Z2Z4lJPvbfWQpUeWaHZNqz7pHIW1Thv0CiasWHQ5LZnjqFnI
 MnoZjDGGq06mN/8g9XZMuvnrJ8hFDkL98C21y4LiUHnT4HOBwkWmrAipdevGCIm1ElXjlLCRiq
 Ye+GoEHZIep6I3DJxGTqcZZvJr1giZfubc8OAoh0mpzMrKP9fUF8FADjkTht+Ntp9FbH/5JKJV
 66/hc3jSgS8a9u+3rgRwTIQ0ZU7AADSPW/87v4bUsWCvXkkEHmjEFsdDssSM0xekrFwiKWgvTy
 +Gog1hJnuatMjMP1cQ2Cuj9G
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="136365065"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 06:41:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 06:41:03 -0700
Received: from [10.171.246.21] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 17 Sep 2021 06:41:01 -0700
Subject: Re: [PATCH v2] ARM: at91: add basic support for new SoC lan966x
To:     <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manohar.Puri@microchip.com>,
        <Madhuri.Sripada@microchip.com>
References: <20210831102138.2476-1-kavyasree.kotagiri@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <8610dd7a-a6eb-0c65-f66e-b4f9fdbce854@microchip.com>
Date:   Fri, 17 Sep 2021 15:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831102138.2476-1-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2021 at 12:21, kavyasree.kotagiri@microchip.com wrote:
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

Your name fixed with your permission and as Rob suggested in a previous 
series.

> ---
> v1 -> v2:
> - Removed lan966x_dt_device_init().
>    System boots fine without this function.
> 
>   arch/arm/mach-at91/Kconfig   | 13 +++++++++++++
>   arch/arm/mach-at91/Makefile  |  1 +

Kconfig and Makefile files updated to avoid merge conflict with SAMA7G5 
that was integrated in 5.15-rc1.

>   arch/arm/mach-at91/lan966x.c | 25 +++++++++++++++++++++++++


>   3 files changed, 39 insertions(+)
>   create mode 100644 arch/arm/mach-at91/lan966x.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index ccd7e80ce943..06cb425af761 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -122,6 +122,14 @@ config SOC_SAM9X60
>   	help
>   	  Select this if you are using Microchip's SAM9X60 SoC
>   
> +config SOC_LAN966X
> +	bool "ARMv7 based Microchip LAN966X SoC family"
> +	depends on ARCH_MULTI_V7
> +	select SOC_LAN966
> +	select DW_APB_TIMER_OF
> +	help
> +	  This enables support for ARMv7 based Microchip LAN966X SoC family.
> +
>   comment "Clocksource driver selection"
>   
>   config ATMEL_CLOCKSOURCE_PIT
> @@ -188,6 +196,11 @@ config SOC_SAMA5
>   	select SOC_SAM_V7
>   	select SRAM if PM
>   
> +config SOC_LAN966
> +	bool
> +	select ARM_GIC
> +	select MEMORY
> +
>   config ATMEL_PM
>   	bool
>   
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index f565490f1b70..93cfd5b4e6d4 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -6,6 +6,7 @@
>   # CPU-specific support
>   obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
>   obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
> +obj-$(CONFIG_SOC_LAN966X)	+= lan966x.o
>   obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
>   obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
>   obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> diff --git a/arch/arm/mach-at91/lan966x.c b/arch/arm/mach-at91/lan966x.c
> new file mode 100644
> index 000000000000..154d616569ae
> --- /dev/null
> +++ b/arch/arm/mach-at91/lan966x.c
> @@ -0,0 +1,25 @@
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
> +static const char *const lan966x_dt_board_compat[] __initconst = {
> +	"microchip,lan966x",

This compatibility string will need to be documented in 
Documentation/arm/microchip.rst
and
Documentation/devicetree/bindings/arm/atmel-at91.yaml (or a similar 
file, as you wish).

You'll add it to your DT patches.

> +	NULL
> +};
> +
> +DT_MACHINE_START(lan966x_dt, "Microchip LAN966X")
> +	/* Maintainer: Microchip */
> +	.dt_compat	= lan966x_dt_board_compat,
> +MACHINE_END
> 

All the rest looks good to me: no need to resend. It's queued in 
at91-soc branch targeting 5.16.
You'll see it appearing in linux-next in the next few days.

Best regards,
   Nicolas


-- 
Nicolas Ferre
