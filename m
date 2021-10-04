Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E991F420929
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhJDKPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:15:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37092 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhJDKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633342395; x=1664878395;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZRiPgFOwdB5HQVEmuLOGDb/uc8iQaPWmGWovZpGxIpw=;
  b=NyyJH8tB3hnFpCVa11fnWchfaFrJmnieiIrEyRdOfIqK7CrZ5ElGBrG9
   umylK/nsulPTA+b39/fuAlnheX7uygzDS0J5As1B4jGBm3EdxnxLJqDNu
   R/L9jHBojqwgcyF/6dWuxpbB4/DMwVdcBoej8GVcWJuryKZ4BPAcUfGsG
   yDLhIiNfyAFVabe202/n3SHJNJj8cI0A17ll8oyv5rc9tbpKxNcdDTH/p
   0uQv+UWPP5W7NkoDd+CtQ88v89hff2XGaL6jzA/IRGnAM6N5UdBjrgmUI
   +qZDFsOryzXOoE5634MCITrrHVNEVJ7gKb0pUaSWphSc6vbwl/hiayJFW
   A==;
IronPort-SDR: nWwVL5THIJKc1iCif3n1JInows5yrOx6wTAf/MURZXDOAnfjm5B/27ywqnscJV4999OXbUJbBq
 +QexuKMty7YcFi02ZL/pHd0VVwB4fdaMj7BZxf+DyVaE4tfmsNPISR6Z/ypOdLhSNa0bMQ+2Ld
 wsTcsMUdiaFo9L1wZ7wwDbtGkYt+3aMUvrgElmJjIBOZ/ZFmiGPltyXTk/JKXdD+lGtnzARDeS
 B6X+D3B97VPxoNw2EK6tIUL2+4MtDZtoDjtLCW6kxcZBPBkPUKGJHUU+kgET8pFhMLa73HV/lN
 8kbOvaoHdIg0kgRsqbsYRe/s
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="146651402"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 03:13:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 03:13:13 -0700
Received: from [10.12.73.58] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Oct 2021 03:13:11 -0700
Subject: Re: [PATCH v2 3/3] ARM: at91: pm: preload base address of controllers
 in tlb
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
 <20210930154219.2214051-4-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <ac27aa9b-255f-613e-6ea2-6f5915550685@microchip.com>
Date:   Mon, 4 Oct 2021 12:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210930154219.2214051-4-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 at 17:42, Claudiu Beznea wrote:
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
> To solve this new issue the TLB flush + the extension of pre-loading
> the rest of controllers to TLB (e.g. PMC, RAMC) has been added. The
> rest of the controllers should have been pre-loaded previously, anyway.
> 
> Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Hi Nicolas,
> 
> Please link this patch with the previous one in this series ("ARM: at91:
> pm: group constants and addresses loading") with a Depends-on tag as this
> will fail to apply if backported to older kernel versions.

Done.

For whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Whole series added to at91-fixes. To be sent as a second fixes tag to 
arm-soc.

Best regards,
   Nicolas


>   arch/arm/mach-at91/pm_suspend.S | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index 34f251fdb743..fdb4f63ecde4 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -1014,6 +1014,10 @@ ENTRY(at91_pm_suspend_in_sram)
>   	mov	tmp1, #0
>   	mcr	p15, 0, tmp1, c7, c10, 4
>   
> +	/* Flush tlb. */
> +	mov	r4, #0
> +	mcr	p15, 0, r4, c8, c7, 0
> +
>   	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
>   	str	tmp1, .mckr_offset
>   	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
> @@ -1023,23 +1027,42 @@ ENTRY(at91_pm_suspend_in_sram)
>   	ldr	tmp1, [r0, #PM_DATA_MODE]
>   	str	tmp1, .pm_mode
>   
> +	/*
> +	 * ldrne below are here to preload their address in the TLB as access
> +	 * to RAM may be limited while in self-refresh.
> +	 */
>   	ldr	tmp1, [r0, #PM_DATA_PMC]
>   	str	tmp1, .pmc_base
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
>   	ldr	tmp1, [r0, #PM_DATA_RAMC0]
>   	str	tmp1, .sramc_base
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
>   	ldr	tmp1, [r0, #PM_DATA_RAMC1]
>   	str	tmp1, .sramc1_base
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
> +#ifndef CONFIG_SOC_SAM_V4_V5
> +	/* ldrne below are here to preload their address in the TLB */
>   	ldr	tmp1, [r0, #PM_DATA_RAMC_PHY]
>   	str	tmp1, .sramc_phy_base
> -	/* Both ldrne below are here to preload their address in the TLB */
> +	cmp	tmp1, #0
> +	ldrne	tmp2, [tmp1, #0]
> +
>   	ldr	tmp1, [r0, #PM_DATA_SHDWC]
>   	str	tmp1, .shdwc
>   	cmp	tmp1, #0
>   	ldrne	tmp2, [tmp1, #0]
> +
>   	ldr	tmp1, [r0, #PM_DATA_SFRBU]
>   	str	tmp1, .sfrbu
>   	cmp	tmp1, #0
>   	ldrne	tmp2, [tmp1, #0x10]
> +#endif
>   
>   	/* Active the self-refresh mode */
>   	at91_sramc_self_refresh_ena
> 


-- 
Nicolas Ferre
