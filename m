Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FBD41AC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbhI1KCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:02:47 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58967 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbhI1KCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:02:47 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 09C38200020;
        Tue, 28 Sep 2021 10:01:05 +0000 (UTC)
Date:   Tue, 28 Sep 2021 12:01:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux@armlinux.org.uk, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: at91: pm: group constants and addresses loading
Message-ID: <YVLn4WScnmybTzy1@piout.net>
References: <20210928084257.2188017-1-claudiu.beznea@microchip.com>
 <20210928084257.2188017-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928084257.2188017-3-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28/09/2021 11:42:56+0300, Claudiu Beznea wrote:
> Group constants and addresses loading. This commit prepares the field for
> the next one. Added fixes tag on this commit as the next one will fail
> to apply if backported alone to older kernels.

The proper notation is to use Depends-on: on the next patch.

> 
> Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/pm_suspend.S | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index cbd61a3bcab1..34f251fdb743 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -1014,6 +1014,15 @@ ENTRY(at91_pm_suspend_in_sram)
>  	mov	tmp1, #0
>  	mcr	p15, 0, tmp1, c7, c10, 4
>  
> +	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
> +	str	tmp1, .mckr_offset
> +	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
> +	str	tmp1, .pmc_version
> +	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
> +	str	tmp1, .memtype
> +	ldr	tmp1, [r0, #PM_DATA_MODE]
> +	str	tmp1, .pm_mode
> +
>  	ldr	tmp1, [r0, #PM_DATA_PMC]
>  	str	tmp1, .pmc_base
>  	ldr	tmp1, [r0, #PM_DATA_RAMC0]
> @@ -1022,14 +1031,6 @@ ENTRY(at91_pm_suspend_in_sram)
>  	str	tmp1, .sramc1_base
>  	ldr	tmp1, [r0, #PM_DATA_RAMC_PHY]
>  	str	tmp1, .sramc_phy_base
> -	ldr	tmp1, [r0, #PM_DATA_MEMCTRL]
> -	str	tmp1, .memtype
> -	ldr	tmp1, [r0, #PM_DATA_MODE]
> -	str	tmp1, .pm_mode
> -	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
> -	str	tmp1, .mckr_offset
> -	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
> -	str	tmp1, .pmc_version
>  	/* Both ldrne below are here to preload their address in the TLB */
>  	ldr	tmp1, [r0, #PM_DATA_SHDWC]
>  	str	tmp1, .shdwc
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
