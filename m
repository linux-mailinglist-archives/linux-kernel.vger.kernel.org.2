Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5570942EA9A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhJOHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:55:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27892 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhJOHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284372; x=1665820372;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4ExT827jz8fUwlLEiEC1VnZQr9SqXkx3GiWyxjWU34o=;
  b=ywg8RbUVXl+cGNdDgSonDxUbwltonCfk7FW4t6Pw5tD2+ZchJgFeRK5k
   AlbsZHJGhEJF4LnrkmmvV2u5yPOc3UXT8/Jnacka1D3GEs8JLVoBfspF8
   yrLsx2+yFBKJvDgTDoq/y1cjP+VfeVtgLhLPdhjTDRSnAwYAVaY5lGY4e
   hxpp8UkkaA8xncpxfiHHFhCxoozalHBwRAapD6KWZVw6xVtuVIwf1yrtg
   wu9ZfMMP9rSrwixAcoA0UrujdpRVLsl1QNEgumLTWCbnxvYYdQQw554+X
   gFCslS3KDb5tifToqJsfi5xecs4pI0G+/bC9Yt0bxpektUM8LlkxUqFG4
   g==;
IronPort-SDR: ZdDBkdB/LmiB4HSAYb4hAmPrV+0rddY4ZgC9sHYGEqnbxfeC0IZ7IzS2i5VY40iNjhw/UEKoiP
 xwx/QpLu7fACjSFCFGi+2SxHmWhJqVVbdaqVmZQ3YrnC+1rNL9NEl90+YdAU9CMWAWiBvBOtM3
 UPVXBgtc0trTozWcaA8Y5KLXG2GGtSYvm+4MbkxuFGazO8Yk7awz0BDzpYDdRNrZoHSVVVSODs
 37TPOo2w6tmB/JtHzWmqo3GWhbYrOvPq4ySR9S+HSNBoXAiljdeZnwGCcl9SKqPv5x4zy6VafT
 dwa5IybyVxadi0flGphsgS6Z
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="140403336"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:52:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:52:51 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:52:50 -0700
Subject: Re: [PATCH v5 04/15] clk: at91: clk-master: add register definition
 for sama7g5's master clock
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-5-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <5124d916-cb17-5fd7-bea3-3e024bcdcc04@microchip.com>
Date:   Fri, 15 Oct 2021 09:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-5-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> SAMA7G5 has 4 master clocks (MCK1..4) which are controlled though the
> register at offset 0x30 (relative to PMC). In the last/first phase of
> suspend/resume procedure (which is architecture specific) the parent
> of master clocks are changed (via assembly code) for more power saving
> (see file arch/arm/mach-at91/pm_suspend.S, macros at91_mckx_ps_enable
> and at91_mckx_ps_restore). Thus the macros corresponding to register
> at offset 0x30 need to be shared b/w clk-master.c and pm_suspend.S.
> commit ec03f18cc222 ("clk: at91: add register definition for sama7g5's
> master clock") introduced the proper macros but didn't adapted the
> clk-master.c as well. Thus, this commit adapt the clk-master.c to use
> the macros introduced in commit ec03f18cc222 ("clk: at91: add register
> definition for sama7g5's master clock").
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/clk-master.c | 50 ++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index f75549fff023..88f7af1bfff6 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -17,15 +17,7 @@
>   #define MASTER_DIV_SHIFT	8
>   #define MASTER_DIV_MASK		0x7
>   
> -#define PMC_MCR			0x30
> -#define PMC_MCR_ID_MSK		GENMASK(3, 0)
> -#define PMC_MCR_CMD		BIT(7)
> -#define PMC_MCR_DIV		GENMASK(10, 8)
> -#define PMC_MCR_CSS		GENMASK(20, 16)
>   #define PMC_MCR_CSS_SHIFT	(16)
> -#define PMC_MCR_EN		BIT(28)
> -
> -#define PMC_MCR_ID(x)		((x) & PMC_MCR_ID_MSK)
>   
>   #define MASTER_MAX_ID		4
>   
> @@ -687,20 +679,22 @@ static void clk_sama7g5_master_set(struct clk_master *master,
>   {
>   	unsigned long flags;
>   	unsigned int val, cparent;
> -	unsigned int enable = status ? PMC_MCR_EN : 0;
> +	unsigned int enable = status ? AT91_PMC_MCR_V2_EN : 0;
>   
>   	spin_lock_irqsave(master->lock, flags);
>   
> -	regmap_write(master->regmap, PMC_MCR, PMC_MCR_ID(master->id));
> -	regmap_read(master->regmap, PMC_MCR, &val);
> -	regmap_update_bits(master->regmap, PMC_MCR,
> -			   enable | PMC_MCR_CSS | PMC_MCR_DIV |
> -			   PMC_MCR_CMD | PMC_MCR_ID_MSK,
> +	regmap_write(master->regmap, AT91_PMC_MCR_V2,
> +		     AT91_PMC_MCR_V2_ID(master->id));
> +	regmap_read(master->regmap, AT91_PMC_MCR_V2, &val);
> +	regmap_update_bits(master->regmap, AT91_PMC_MCR_V2,
> +			   enable | AT91_PMC_MCR_V2_CSS | AT91_PMC_MCR_V2_DIV |
> +			   AT91_PMC_MCR_V2_CMD | AT91_PMC_MCR_V2_ID_MSK,
>   			   enable | (master->parent << PMC_MCR_CSS_SHIFT) |
>   			   (master->div << MASTER_DIV_SHIFT) |
> -			   PMC_MCR_CMD | PMC_MCR_ID(master->id));
> +			   AT91_PMC_MCR_V2_CMD |
> +			   AT91_PMC_MCR_V2_ID(master->id));
>   
> -	cparent = (val & PMC_MCR_CSS) >> PMC_MCR_CSS_SHIFT;
> +	cparent = (val & AT91_PMC_MCR_V2_CSS) >> PMC_MCR_CSS_SHIFT;
>   
>   	/* Wait here only if parent is being changed. */
>   	while ((cparent != master->parent) && !clk_master_ready(master))
> @@ -725,10 +719,12 @@ static void clk_sama7g5_master_disable(struct clk_hw *hw)
>   
>   	spin_lock_irqsave(master->lock, flags);
>   
> -	regmap_write(master->regmap, PMC_MCR, master->id);
> -	regmap_update_bits(master->regmap, PMC_MCR,
> -			   PMC_MCR_EN | PMC_MCR_CMD | PMC_MCR_ID_MSK,
> -			   PMC_MCR_CMD | PMC_MCR_ID(master->id));
> +	regmap_write(master->regmap, AT91_PMC_MCR_V2, master->id);
> +	regmap_update_bits(master->regmap, AT91_PMC_MCR_V2,
> +			   AT91_PMC_MCR_V2_EN | AT91_PMC_MCR_V2_CMD |
> +			   AT91_PMC_MCR_V2_ID_MSK,
> +			   AT91_PMC_MCR_V2_CMD |
> +			   AT91_PMC_MCR_V2_ID(master->id));
>   
>   	spin_unlock_irqrestore(master->lock, flags);
>   }
> @@ -741,12 +737,12 @@ static int clk_sama7g5_master_is_enabled(struct clk_hw *hw)
>   
>   	spin_lock_irqsave(master->lock, flags);
>   
> -	regmap_write(master->regmap, PMC_MCR, master->id);
> -	regmap_read(master->regmap, PMC_MCR, &val);
> +	regmap_write(master->regmap, AT91_PMC_MCR_V2, master->id);
> +	regmap_read(master->regmap, AT91_PMC_MCR_V2, &val);
>   
>   	spin_unlock_irqrestore(master->lock, flags);
>   
> -	return !!(val & PMC_MCR_EN);
> +	return !!(val & AT91_PMC_MCR_V2_EN);
>   }
>   
>   static int clk_sama7g5_master_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -842,10 +838,10 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
>   	master->mux_table = mux_table;
>   
>   	spin_lock_irqsave(master->lock, flags);
> -	regmap_write(master->regmap, PMC_MCR, master->id);
> -	regmap_read(master->regmap, PMC_MCR, &val);
> -	master->parent = (val & PMC_MCR_CSS) >> PMC_MCR_CSS_SHIFT;
> -	master->div = (val & PMC_MCR_DIV) >> MASTER_DIV_SHIFT;
> +	regmap_write(master->regmap, AT91_PMC_MCR_V2, master->id);
> +	regmap_read(master->regmap, AT91_PMC_MCR_V2, &val);
> +	master->parent = (val & AT91_PMC_MCR_V2_CSS) >> PMC_MCR_CSS_SHIFT;
> +	master->div = (val & AT91_PMC_MCR_V2_DIV) >> MASTER_DIV_SHIFT;
>   	spin_unlock_irqrestore(master->lock, flags);
>   
>   	hw = &master->hw;
> 


-- 
Nicolas Ferre
