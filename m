Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A0441AC93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbhI1KD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:03:29 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43811 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbhI1KD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:03:27 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D62D3240005;
        Tue, 28 Sep 2021 10:01:45 +0000 (UTC)
Date:   Tue, 28 Sep 2021 12:01:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux@armlinux.org.uk, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: at91: pm: preload base address of controllers
 in tlb
Message-ID: <YVLoCWkmet31syKU@piout.net>
References: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
 <20210928084257.2188017-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928084257.2188017-4-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2021 11:42:57+0300, Claudiu Beznea wrote:
> In suspend/resume procedure for AT91 architecture different controllers
> (PMC, SHDWC, RAM, RAM PHY, SFRBU) are accessed to do the proper settings
> for power saving. Commit f0bbf17958e8 ("ARM: at91: pm: add self-refresh
> support for sama7g5") introduced the access to RAMC PHY controller for
> SAMA7G5. The access to this controller is done after RAMC ports are
> closed, thus any TLB walk necessary for RAMC PHY virtual address will
> fail. In the development branch this was not encountered. However, on
> current kernel the issue is reproducible.
> 
> To solve the issue the previous mechanism of pre-loading the TLB with
> the RAMC PHY virtual address has been used. However, only the addition
> of this new pre-load breaks the functionality for ARMv5 based
> devices (SAM9X60). This behavior has been encountered previously
> while debugging this code and using the same mechanism for pre-loading
> address for different controllers (e.g. pin controller, the assumption
> being that other requested translations are replaced from TLB).
> 
> To solve this new issue the TBL flush + the extension of pre-loading
> the rest of controllers to TBL (e.g. PMC, RAMC) has been added. The

s/TBL/TLB

> rest of the controllers should have been pre-loaded previously, anyway.
> 
> Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/pm_suspend.S | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index 34f251fdb743..fdb4f63ecde4 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -1014,6 +1014,10 @@ ENTRY(at91_pm_suspend_in_sram)
>  	mov	tmp1, #0
>  	mcr	p15, 0, tmp1, c7, c10, 4
>  
> +	/* Flush tlb. */
> +	mov	r4, #0
> +	mcr	p15, 0, r4, c8, c7, 0
> +
>  	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
>  	str	tmp1, .mckr_offset
>  	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
> @@ -1023,23 +1027,42 @@ ENTRY(at91_pm_suspend_in_sram)
>  	ldr	tmp1, [r0, #PM_DATA_MODE]
>  	str	tmp1, .pm_mode
>  
> +	/*
> +	 * ldrne below are here to preload their address in the TLB as access
> +	 * to RAM may be limited while in self-refresh.
> +	 */
>  	ldr	tmp1, [r0, #PM_DATA_PMC]
>  	str	tmp1, .pmc_base
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
>  	ldr	tmp1, [r0, #PM_DATA_RAMC0]
>  	str	tmp1, .sramc_base
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
>  	ldr	tmp1, [r0, #PM_DATA_RAMC1]
>  	str	tmp1, .sramc1_base
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
> +#ifndef CONFIG_SOC_SAM_V4_V5
> +	/* ldrne below are here to preload their address in the TLB */
>  	ldr	tmp1, [r0, #PM_DATA_RAMC_PHY]
>  	str	tmp1, .sramc_phy_base
> -	/* Both ldrne below are here to preload their address in the TLB */
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
>  	ldr	tmp1, [r0, #PM_DATA_SHDWC]
>  	str	tmp1, .shdwc
>  	cmp	tmp1, #0
>  	ldrne	tmp2, [tmp1, #0]
> +
>  	ldr	tmp1, [r0, #PM_DATA_SFRBU]
>  	str	tmp1, .sfrbu
>  	cmp	tmp1, #0
>  	ldrne	tmp2, [tmp1, #0x10]
> +#endif
>  
>  	/* Active the self-refresh mode */
>  	at91_sramc_self_refresh_ena
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
