Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5135A34EF51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhC3RX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:23:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42696 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhC3RXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617124990; x=1648660990;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hWeb1+TRWPqxCyB/ieGKfNFvG7dBHh2X0HpH2Qfdr8s=;
  b=Az8wGMOytETJyjHybfreuZ6z+W5yHnH7LLzcA4nbWXluN0F5jV5OG+9+
   demRAPabAikqj0GwXYKh+uSNkSjEY1rdXWkfF+B4PO9+pWrcPI5r+kCFM
   2Hzv6YH6rHBBq/8o6zaCKo8xrmaVXxreOOXv4f36zpyNtfo/LZBXWAD1p
   /nuGO4E5gtaufhU3il/X9vPcIEpvZW9vwMZtlBXROf1JJ+zlqI3S7cmGJ
   /gG9XA3YS8OVJOnivyoR2PLsyN13VDAdAPxDWe627JyoFFitZzTIF3VyB
   wbRLrTVWjlMT89tW8W1qNAJ54saXCB5q4moqZsW9fuEwc++elyMz4IYkl
   A==;
IronPort-SDR: UNc8k8Yfv9C8YJGe3lsCoYBewliCXdicrThVYbj5F0+8de/P2oXVBlsPicY38uAvbDbfRSU2YH
 hP/LjPRZqLcmp7QB8lPGOvsyiCJ3e247e0bK3g9FVODUT3RUW3eP+7skWF5Xzg6QGUqbwrgHIJ
 /xqJOVuE1NyxLk/hixG1bEtK4Fck2K8SRA35pnSpm5feTSirMx0vSg+aPI07ZQtOnUZmoy1Vo/
 m7XyovUqUBkP1u/4eoXygpcn5CcHR/yK74i9ogoecxmXVW5r2C6+/UsYs4NpHXA62txetf3qvU
 Nv0=
X-IronPort-AV: E=Sophos;i="5.81,291,1610434800"; 
   d="scan'208";a="109107089"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2021 10:23:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 10:23:10 -0700
Received: from [10.171.246.97] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 30 Mar 2021 10:23:08 -0700
Subject: Re: [RESEND PATCH 4/5] clk: at91: clk-master: add register definition
 for sama7g5's master clock
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
 <20210324094353.1710114-5-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <607e986b-1170-503a-84cc-ee9a9f32fd32@microchip.com>
Date:   Tue, 30 Mar 2021 19:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324094353.1710114-5-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 at 10:43, Claudiu Beznea wrote:
> Add register definitions for SAMA7G5's master clock. These would be
> also used by architecture specific power saving code. With this, update
> also clk-master.c.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   drivers/clk/at91/clk-master.c | 51 +++++++++++++++++------------------
>   include/linux/clk/at91_pmc.h  | 26 ++++++++++++++++++
>   2 files changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 6f1fb2eb2a8d..a6a393bb1def 100644
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
> @@ -685,17 +677,20 @@ static void clk_sama7g5_master_set(struct clk_master *master,
>   
>   	spin_lock_irqsave(master->lock, flags);
>   
> -	regmap_write(master->regmap, PMC_MCR, PMC_MCR_ID(master->id));
> -	regmap_read(master->regmap, PMC_MCR, &val);
> -	regmap_update_bits(master->regmap, PMC_MCR,
> -			   (status ? PMC_MCR_EN : 0) | PMC_MCR_CSS | PMC_MCR_DIV |
> -			   PMC_MCR_CMD | PMC_MCR_ID_MSK,
> -			   (status ? PMC_MCR_EN : 0) |
> +	regmap_write(master->regmap, AT91_PMC_MCR_V2,
> +		     AT91_PMC_MCR_V2_ID(master->id));
> +	regmap_read(master->regmap, AT91_PMC_MCR_V2, &val);
> +	regmap_update_bits(master->regmap, AT91_PMC_MCR_V2,
> +			   (status ? AT91_PMC_MCR_V2_EN : 0) |
> +			   AT91_PMC_MCR_V2_CSS | AT91_PMC_MCR_V2_DIV |
> +			   AT91_PMC_MCR_V2_CMD | AT91_PMC_MCR_V2_ID_MSK,
> +			   (status ? AT91_PMC_MCR_V2_EN : 0) |

Ok, here also. Can't we make it simpler to read?

>   			   (master->parent << PMC_MCR_CSS_SHIFT) |
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
> @@ -720,10 +715,12 @@ static void clk_sama7g5_master_disable(struct clk_hw *hw)
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
> @@ -736,12 +733,12 @@ static int clk_sama7g5_master_is_enabled(struct clk_hw *hw)
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
> @@ -837,10 +834,10 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
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
> diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
> index a4f82e836a7c..ccb3f034bfa9 100644
> --- a/include/linux/clk/at91_pmc.h
> +++ b/include/linux/clk/at91_pmc.h
> @@ -137,6 +137,32 @@
>   #define			AT91_PMC_PLLADIV2_ON		(1 << 12)
>   #define		AT91_PMC_H32MXDIV	BIT(24)
>   
> +#define	AT91_PMC_MCR_V2		0x30				/* Master Clock Register [SAMA7G5 only] */
> +#define		AT91_PMC_MCR_V2_ID_MSK	(0xF)
> +#define			AT91_PMC_MCR_V2_ID(_id)		((_id) & AT91_PMC_MCR_V2_ID_MSK)
> +#define		AT91_PMC_MCR_V2_CMD	(1 << 7)
> +#define		AT91_PMC_MCR_V2_DIV	(7 << 8)
> +#define			AT91_PMC_MCR_V2_DIV1		(0 << 8)
> +#define			AT91_PMC_MCR_V2_DIV2		(1 << 8)
> +#define			AT91_PMC_MCR_V2_DIV4		(2 << 8)
> +#define			AT91_PMC_MCR_V2_DIV8		(3 << 8)
> +#define			AT91_PMC_MCR_V2_DIV16		(4 << 8)
> +#define			AT91_PMC_MCR_V2_DIV32		(5 << 8)
> +#define			AT91_PMC_MCR_V2_DIV64		(6 << 8)
> +#define			AT91_PMC_MCR_V2_DIV3		(7 << 8)
> +#define		AT91_PMC_MCR_V2_CSS	(0x1F << 16)
> +#define			AT91_PMC_MCR_V2_CSS_MD_SLCK	(0 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_TD_SLCK	(1 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_MAINCK	(2 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_MCK0	(3 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_SYSPLL	(5 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_DDRPLL	(6 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_IMGPLL	(7 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_BAUDPLL	(8 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_AUDIOPLL	(9 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_ETHPLL	(10 << 16)
> +#define		AT91_PMC_MCR_V2_EN	(1 << 28)
> +
>   #define AT91_PMC_XTALF		0x34			/* Main XTAL Frequency Register [SAMA7G5 only] */
>   
>   #define	AT91_PMC_USB		0x38			/* USB Clock Register [some SAM9 only] */
> 

Autherwise, it's fine. Thanks. Best regards,
   Nicolas

-- 
Nicolas Ferre
