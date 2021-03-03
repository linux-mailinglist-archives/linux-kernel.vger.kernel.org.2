Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55FA32BE46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385394AbhCCRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:19:10 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48039 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381544AbhCCNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:30:32 -0500
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 706EA3B61AC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 13:27:30 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 28D0524000D;
        Wed,  3 Mar 2021 13:24:13 +0000 (UTC)
Date:   Wed, 3 Mar 2021 14:24:13 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [RESEND 1/1] arch: arm: mach-at91: pm: Move prototypes to
 mutually included header
Message-ID: <YD+N/QVRYbm/Idp3@piout.net>
References: <20210303124149.3149511-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303124149.3149511-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 12:41:49+0000, Lee Jones wrote:
> Both the caller and the supplier's source file should have access to
> the include file containing the prototypes.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/pinctrl/pinctrl-at91.c:1637:6: warning: no previous prototype for ‘at91_pinctrl_gpio_suspend’ [-Wmissing-prototypes]
>  1637 | void at91_pinctrl_gpio_suspend(void)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/pinctrl/pinctrl-at91.c:1661:6: warning: no previous prototype for ‘at91_pinctrl_gpio_resume’ [-Wmissing-prototypes]
>  1661 | void at91_pinctrl_gpio_resume(void)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I'm pretty sure you had my ack on v3 ;)

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

or again, alternatively, I can apply it with Linus' ack

> ---
>  arch/arm/mach-at91/pm.c        | 19 ++++++++-----------
>  drivers/pinctrl/pinctrl-at91.c |  2 ++
>  include/soc/at91/pm.h          | 16 ++++++++++++++++
>  3 files changed, 26 insertions(+), 11 deletions(-)
>  create mode 100644 include/soc/at91/pm.h
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 120f9aa6fff32..90dcdfe3b3d0d 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -17,6 +17,8 @@
>  #include <linux/clk/at91_pmc.h>
>  #include <linux/platform_data/atmel.h>
>  
> +#include <soc/at91/pm.h>
> +
>  #include <asm/cacheflush.h>
>  #include <asm/fncpy.h>
>  #include <asm/system_misc.h>
> @@ -25,17 +27,6 @@
>  #include "generic.h"
>  #include "pm.h"
>  
> -/*
> - * FIXME: this is needed to communicate between the pinctrl driver and
> - * the PM implementation in the machine. Possibly part of the PM
> - * implementation should be moved down into the pinctrl driver and get
> - * called as part of the generic suspend/resume path.
> - */
> -#ifdef CONFIG_PINCTRL_AT91
> -extern void at91_pinctrl_gpio_suspend(void);
> -extern void at91_pinctrl_gpio_resume(void);
> -#endif
> -
>  struct at91_soc_pm {
>  	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
>  	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
> @@ -326,6 +317,12 @@ static void at91_pm_suspend(suspend_state_t state)
>  static int at91_pm_enter(suspend_state_t state)
>  {
>  #ifdef CONFIG_PINCTRL_AT91
> +	/*
> +	 * FIXME: this is needed to communicate between the pinctrl driver and
> +	 * the PM implementation in the machine. Possibly part of the PM
> +	 * implementation should be moved down into the pinctrl driver and get
> +	 * called as part of the generic suspend/resume path.
> +	 */
>  	at91_pinctrl_gpio_suspend();
>  #endif
>  
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 8003d1bd16953..fc61aaec34cc9 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -23,6 +23,8 @@
>  /* Since we request GPIOs from ourself */
>  #include <linux/pinctrl/consumer.h>
>  
> +#include <soc/at91/pm.h>
> +
>  #include "pinctrl-at91.h"
>  #include "core.h"
>  
> diff --git a/include/soc/at91/pm.h b/include/soc/at91/pm.h
> new file mode 100644
> index 0000000000000..7a41e53a3ffa3
> --- /dev/null
> +++ b/include/soc/at91/pm.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Atmel Power Management
> + *
> + * Copyright (C) 2020 Atmel
> + *
> + * Author: Lee Jones <lee.jones@linaro.org>
> + */
> +
> +#ifndef __SOC_ATMEL_PM_H
> +#define __SOC_ATMEL_PM_H
> +
> +void at91_pinctrl_gpio_suspend(void);
> +void at91_pinctrl_gpio_resume(void);
> +
> +#endif /* __SOC_ATMEL_PM_H */
> -- 
> 2.27.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
