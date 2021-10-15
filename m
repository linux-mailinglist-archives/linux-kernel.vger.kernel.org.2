Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75F42EA96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhJOHyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:54:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:51060 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhJOHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284307; x=1665820307;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PJaL5ZGcehf0Yo81gLvYooEFbaQry5SGcgGgkYKmjJA=;
  b=j1cuovyE1TzhDiD4qaLAplRj/1smR3rAbiF8S3lKlKdnxzVnXGOhdC2i
   lN6tTE54/X4LuVrCPH/nu1urA8jFAN/whhyv7HZA0Fv8vSRjPCGtH8wgF
   B4tHh3OTJRZytkfBg0WXZg+Hok+ecinZaitNOZTtjwic99aT7Cb2CRKEO
   NNM8IsG8Jl7vA48SmeJv6E6ElOshJJ13y3il3+rgiv92wbrp/EHVBYQWO
   W4Tjoswt19Nc/VdrkTPf8uDvil0k8BXcddFsk/VYge6h8+w+LbufNKuu8
   /qFRzpGXsldWBwj+hzag14e/WYxKSzlr2o4ybFDxRhwsKDoTt8eRfM96L
   g==;
IronPort-SDR: cxxJ4FHyPPHpE2CbklUp+OjoN/ddtgC/YY6mQhvj93zLshVn93n0Cl+O2S0HHqsc2hKSQHrMho
 cwM6nik3MIAQmBco4t+oFKgGsB3zTrZ+NiPdjyvm6NGUV5BWiDW4pOMCLVmcTXSSZqlBMvglC8
 bVBNwzuy5gATiCLGvYRfi1upIcqfja51os9ZrPeuRPCsCuyM1C5JQoVI2GdibGDjMHcKiIUPon
 aPjlaPnLCtxs3bj5CvxMqSXOS3YopQBrw2INzsKoVnn3EcvMYOpxd52VYTLIbFO9O7bkbmWUd+
 2a0rHNNoAqIjwwrXarX4JhWh
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="148207732"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:51:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:51:47 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:45 -0700
Subject: Re: [PATCH v5 02/15] clk: at91: pmc: execute suspend/resume only for
 backup mode
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-3-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <ae6e6277-8ca0-100d-56e5-cd7591deee95@microchip.com>
Date:   Fri, 15 Oct 2021 09:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> Before going to backup mode architecture specific PM code sets the first
> word in securam (file arch/arm/mach-at91/pm.c, function at91_pm_begin()).
> Thus take this into account when suspending/resuming clocks. This will
> avoid executing unnecessary instructions when suspending to non backup
> modes.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Ok to do it like this:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


> ---
>   drivers/clk/at91/pmc.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index b2806946a77a..517973062719 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -8,6 +8,7 @@
>   #include <linux/clkdev.h>
>   #include <linux/clk/at91_pmc.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
> @@ -110,13 +111,35 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
>   }
>   
>   #ifdef CONFIG_PM
> +
> +/* Address in SECURAM that say if we suspend to backup mode. */
> +static void __iomem *at91_pmc_backup_suspend;
> +
>   static int at91_pmc_suspend(void)
>   {
> +	unsigned int backup;
> +
> +	if (!at91_pmc_backup_suspend)
> +		return 0;
> +
> +	backup = readl_relaxed(at91_pmc_backup_suspend);
> +	if (!backup)
> +		return 0;
> +
>   	return clk_save_context();
>   }
>   
>   static void at91_pmc_resume(void)
>   {
> +	unsigned int backup;
> +
> +	if (!at91_pmc_backup_suspend)
> +		return;
> +
> +	backup = readl_relaxed(at91_pmc_backup_suspend);
> +	if (!backup)
> +		return;
> +
>   	clk_restore_context();
>   }
>   
> @@ -144,6 +167,22 @@ static int __init pmc_register_ops(void)
>   	}
>   	of_node_put(np);
>   
> +	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
> +	if (!np)
> +		return -ENODEV;
> +
> +	if (!of_device_is_available(np)) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +	of_node_put(np);
> +
> +	at91_pmc_backup_suspend = of_iomap(np, 0);
> +	if (!at91_pmc_backup_suspend) {
> +		pr_warn("%s(): unable to map securam\n", __func__);
> +		return -ENOMEM;
> +	}
> +
>   	register_syscore_ops(&pmc_syscore_ops);
>   
>   	return 0;
> 


-- 
Nicolas Ferre
