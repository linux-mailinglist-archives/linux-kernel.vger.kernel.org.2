Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAAF35886D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhDHPae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:30:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:56174 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhDHPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617895817; x=1649431817;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TT4D5obQiTEQmvL2iO1zE2BCc0Dx26vSve2ZLmK6gD4=;
  b=1nEKCHyAD+6W/fXrNOFWkqYELvGDIhQgHQRlJeKQO/XlcFoPHucUf57L
   ePwRdwnsvYyr4uewlUNSCm7kBW2joAxnHxpRKGLQnK14nATXS93Fw1ior
   p6lUI7K6MjPGUcN4hqm6wjqulOEM9qksIEF22VoApxJexoHx71IocPxDc
   6CzUs3LWxtksUmRokwKhLMWgHeYi5K8uTlILMBM9chsrIy1TlDX+mg1fZ
   knrYu95xiN+rRMp0BAivV1nwIHTiA9yDsvjvs5DqU3REOtGTUAsbf4MMX
   gXmsPvwElB7eKF4WAeH4GmzJoKoP06BqXoLh7tDtK0Sfyv2qx4pFk2tBN
   g==;
IronPort-SDR: IcSpApEGl6sfLKIm5uVk8URGJFWf3py7vxtdcAzIFqYgmHx1aJgQrGm2bXCpVfT8kir+tJaMtz
 4GgSED6ckLC6VYysnX2piTJgiYeJG66n5V76Cf8BEXd2E2+7Jerg0qpEfpx3B7SlPdEdcrdWxQ
 0SBqu0QBOsymJmvf3uEZo8pIaCSu0KW+TBzfLyElBWyZNrXQUc0O7T8Z3WWhXg/D5itqFBW1TA
 /cBmnror+SzfnQ70SmmlKdfmplZONXzpmy0GjxW3fgZl7i8r+hkQrYgz9F+e1pvvBzeWdEyVjB
 Ys8=
X-IronPort-AV: E=Sophos;i="5.82,206,1613458800"; 
   d="scan'208";a="112913761"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2021 08:30:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 08:30:16 -0700
Received: from [10.12.88.246] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 8 Apr 2021 08:30:14 -0700
Subject: Re: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-23-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <3d39d952-03f2-0952-72ee-b639fd4339f2@microchip.com>
Date:   Thu, 8 Apr 2021 17:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331105908.23027-23-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/03/2021 at 12:59, Claudiu Beznea wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Introduce new family of SoCs, sama7, and first SoC, sama7g5.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   arch/arm/mach-at91/Makefile |  1 +
>   arch/arm/mach-at91/sama7.c  | 48 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
>   create mode 100644 arch/arm/mach-at91/sama7.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index f565490f1b70..6cc6624cddac 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
>   obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
>   obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
>   obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> +obj-$(CONFIG_SOC_SAMA7)		+= sama7.o

Nit: alphabetic order tells that it should be before samv7

>   
>   # Power Management
>   obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
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

I'm not sure we need two DT_MACHINE_START() entries and associated 
functions right now. Probably the most generic one is sufficient.
We can add such distinction in the future if the need arises.

Regards,
   Nicolas

-- 
Nicolas Ferre
