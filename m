Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341E940B256
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhINO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:59:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:45972 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhINO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631631491; x=1663167491;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8LHkH775IoW7FIVyJJcT3VFkhmSbcXiFASsFpny9obY=;
  b=k79Gxt3LAxHJbz61nMbZabv3aabFQugeVglgPBhocs6ZZcwihnqXkjaW
   gvRu1vRLKj83hI9haeuY3/yctCT3hAhPkEzzbWz2V6sjjSAbNcLUixqDr
   iVTq0GnJXbmmB8Cl27kYfUTKuJM6eN3fjdwwt4zeOURdL92g+vUGnS/qr
   WOb9PkaSwE44zSOIz6ffA1uvl5JHlGXlOk2ZnH2k4uzQ6pXCUSM21+k+c
   z3fmSWgVNldwMluA92JlHj16mx5JN/E2t9wSy6guIy7ameiiRvlrfCvVT
   pDu8LOp4clzZfDQyZR43fzqQ29KzSrgE9l6f5PuFjpwxW5HherrxBeKGl
   Q==;
IronPort-SDR: S1b8cBVart6H4hhJC9L9hzsl9DB3V2cxQyl/OuZPpEr2fYq0LBkgWHPSTE4EP9B3v0ATS0VfWy
 YRmqzvfqUL3VNA+PqhVLDdIn/TjXxw4i9zqHVUIlYQwNDk0eomZY4PTe0VCB4hAJMjVbS94XpK
 G8grhFPJUAMywa2m0Uyvic350ArpgklM1P6oTCB82bD9C3oS4LL0Lu2E3LGeCtoIn7alIZAiMG
 +HIP6260apjoXHyDSDgxbEGAUf5z+VklQvMDpJTihwOBtk3xjP7AiYkIVMsvlVTp746W2ywI0D
 r/Xt3DzY46NJvKv+8JJz03id
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="129270682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2021 07:58:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 07:58:10 -0700
Received: from [10.171.246.26] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 14 Sep 2021 07:58:09 -0700
Subject: Re: [PATCH] ARM: at91: pm: switch backup area to vbat in backup mode
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210830100927.22711-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <32c932f7-26da-cc09-31e7-0aa4a209b7a6@microchip.com>
Date:   Tue, 14 Sep 2021 16:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830100927.22711-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2021 at 12:09, Claudiu Beznea wrote:
> Backup area is now switched to VDDIN33 at boot (with the help of
> bootloader). When switching to backup mode we need to switch backup area
> to VBAT as all the other power sources are cut off. The resuming from
> backup mode is done with the help of bootloader, so there is no need to
> do something particular in Linux to restore backup area power source.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

And queued to at91-fixes for 5.15.

Best regards,
   Nicolas


> ---
> 
> Hi Nicolas,
> 
> This applies clean on top of patch with title
> "ARM: at91: pm: do not panic if ram controllers are not enabled"
> 
> Thank you,
> Claudiu Beznea
> 
>   arch/arm/mach-at91/pm.c | 52 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index d92afca64b49..8711d6824c1f 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -47,12 +47,26 @@ struct at91_pm_bu {
>   	unsigned long ddr_phy_calibration[BACKUP_DDR_PHY_CALIBRATION];
>   };
>   
> +/*
> + * struct at91_pm_sfrbu_offsets: registers mapping for SFRBU
> + * @pswbu: power switch BU control registers
> + */
> +struct at91_pm_sfrbu_regs {
> +	struct {
> +		u32 key;
> +		u32 ctrl;
> +		u32 state;
> +		u32 softsw;
> +	} pswbu;
> +};
> +
>   /**
>    * struct at91_soc_pm - AT91 SoC power management data structure
>    * @config_shdwc_ws: wakeup sources configuration function for SHDWC
>    * @config_pmc_ws: wakeup srouces configuration function for PMC
>    * @ws_ids: wakup sources of_device_id array
>    * @data: PM data to be used on last phase of suspend
> + * @sfrbu_regs: SFRBU registers mapping
>    * @bu: backup unit mapped data (for backup mode)
>    * @memcs: memory chip select
>    */
> @@ -62,6 +76,7 @@ struct at91_soc_pm {
>   	const struct of_device_id *ws_ids;
>   	struct at91_pm_bu *bu;
>   	struct at91_pm_data data;
> +	struct at91_pm_sfrbu_regs sfrbu_regs;
>   	void *memcs;
>   };
>   
> @@ -356,9 +371,36 @@ static int at91_suspend_finish(unsigned long val)
>   	return 0;
>   }
>   
> +static void at91_pm_switch_ba_to_vbat(void)
> +{
> +	unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
> +	unsigned int val;
> +
> +	/* Just for safety. */
> +	if (!soc_pm.data.sfrbu)
> +		return;
> +
> +	val = readl(soc_pm.data.sfrbu + offset);
> +
> +	/* Already on VBAT. */
> +	if (!(val & soc_pm.sfrbu_regs.pswbu.state))
> +		return;
> +
> +	val &= ~soc_pm.sfrbu_regs.pswbu.softsw;
> +	val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
> +	writel(val, soc_pm.data.sfrbu + offset);
> +
> +	/* Wait for update. */
> +	val = readl(soc_pm.data.sfrbu + offset);
> +	while (val & soc_pm.sfrbu_regs.pswbu.state)
> +		val = readl(soc_pm.data.sfrbu + offset);
> +}
> +
>   static void at91_pm_suspend(suspend_state_t state)
>   {
>   	if (soc_pm.data.mode == AT91_PM_BACKUP) {
> +		at91_pm_switch_ba_to_vbat();
> +
>   		cpu_suspend(0, at91_suspend_finish);
>   
>   		/* The SRAM is lost between suspend cycles */
> @@ -1155,6 +1197,11 @@ void __init sama5d2_pm_init(void)
>   	soc_pm.ws_ids = sama5d2_ws_ids;
>   	soc_pm.config_shdwc_ws = at91_sama5d2_config_shdwc_ws;
>   	soc_pm.config_pmc_ws = at91_sama5d2_config_pmc_ws;
> +
> +	soc_pm.sfrbu_regs.pswbu.key = (0x4BD20C << 8);
> +	soc_pm.sfrbu_regs.pswbu.ctrl = BIT(0);
> +	soc_pm.sfrbu_regs.pswbu.softsw = BIT(1);
> +	soc_pm.sfrbu_regs.pswbu.state = BIT(3);
>   }
>   
>   void __init sama7_pm_init(void)
> @@ -1185,6 +1232,11 @@ void __init sama7_pm_init(void)
>   
>   	soc_pm.ws_ids = sama7g5_ws_ids;
>   	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
> +
> +	soc_pm.sfrbu_regs.pswbu.key = (0x4BD20C << 8);
> +	soc_pm.sfrbu_regs.pswbu.ctrl = BIT(0);
> +	soc_pm.sfrbu_regs.pswbu.softsw = BIT(1);
> +	soc_pm.sfrbu_regs.pswbu.state = BIT(2);
>   }
>   
>   static int __init at91_pm_modes_select(char *str)
> 


-- 
Nicolas Ferre
