Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80858350290
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbhCaOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:44:25 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60799 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbhCaOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:44:13 -0400
Received: from localhost (lfbn-lyo-1-1679-174.w90-65.abo.wanadoo.fr [90.65.110.174])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 94CBE240012;
        Wed, 31 Mar 2021 14:44:05 +0000 (UTC)
Date:   Wed, 31 Mar 2021 16:44:04 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/24] ARM: at91: pm: move pm_bu to soc_pm data structure
Message-ID: <YGSKtCZsZjibQPHG@piout.net>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331105908.23027-2-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2021 13:58:45+0300, Claudiu Beznea wrote:
> Move pm_bu to soc_pm data structure.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/arm/mach-at91/pm.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 90dcdfe3b3d0..e13ceef7ac9a 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -27,10 +27,25 @@
>  #include "generic.h"
>  #include "pm.h"
>  
> +/**
> + * struct at91_pm_bu - AT91 power management backup unit data structure
> + * @suspended: true if suspended to backup mode
> + * @reserved: reserved
> + * @canary: canary data for memory checking after exit from backup mode
> + * @resume: resume API
> + */
> +struct at91_pm_bu {
> +	int suspended;
> +	unsigned long reserved;
> +	phys_addr_t canary;
> +	phys_addr_t resume;
> +};
> +
>  struct at91_soc_pm {
>  	int (*config_shdwc_ws)(void __iomem *shdwc, u32 *mode, u32 *polarity);
>  	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
>  	const struct of_device_id *ws_ids;
> +	struct at91_pm_bu *bu;
>  	struct at91_pm_data data;
>  };
>  
> @@ -71,13 +86,6 @@ static int at91_pm_valid_state(suspend_state_t state)
>  
>  static int canary = 0xA5A5A5A5;
>  
> -static struct at91_pm_bu {
> -	int suspended;
> -	unsigned long reserved;
> -	phys_addr_t canary;
> -	phys_addr_t resume;
> -} *pm_bu;
> -
>  struct wakeup_source_info {
>  	unsigned int pmc_fsmr_bit;
>  	unsigned int shdwc_mr_bit;
> @@ -288,7 +296,7 @@ static int at91_suspend_finish(unsigned long val)
>  static void at91_pm_suspend(suspend_state_t state)
>  {
>  	if (soc_pm.data.mode == AT91_PM_BACKUP) {
> -		pm_bu->suspended = 1;
> +		soc_pm.bu->suspended = 1;
>  
>  		cpu_suspend(0, at91_suspend_finish);
>  
> @@ -657,16 +665,16 @@ static int __init at91_pm_backup_init(void)
>  		goto securam_fail;
>  	}
>  
> -	pm_bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
> -	if (!pm_bu) {
> +	soc_pm.bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
> +	if (!soc_pm.bu) {
>  		pr_warn("%s: unable to alloc securam!\n", __func__);
>  		ret = -ENOMEM;
>  		goto securam_fail;
>  	}
>  
> -	pm_bu->suspended = 0;
> -	pm_bu->canary = __pa_symbol(&canary);
> -	pm_bu->resume = __pa_symbol(cpu_resume);
> +	soc_pm.bu->suspended = 0;
> +	soc_pm.bu->canary = __pa_symbol(&canary);
> +	soc_pm.bu->resume = __pa_symbol(cpu_resume);
>  
>  	return 0;
>  
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
