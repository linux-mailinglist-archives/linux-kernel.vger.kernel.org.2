Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0042EAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhJOH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:56:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:59437 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbhJOH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284478; x=1665820478;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ct3zMn5uJYMTMazgwCgbpkfLam5EAt+NrPc1iijkyX8=;
  b=P9gdJTKyoJESL5vLebiBsc+N2uc1MyKNCGy9jh1W0FOKY7vtsOL/XgEr
   fA1SFfBkvOZ+zqxO7Y8CiA2lNuXzQG/Pr7NJX0KEywy3wlUtp6n2gDcva
   el4wh6eXB6/KtMzERGFWW9tEJ6mAI/eieLscL9gqZNnn9ZvTZGq+XzMIu
   zjEXo6rBt+NqyTEGtvyfjpMCoIoy+TNkQETFrlZaTjo6hbtZA9bZSK+Zr
   7xubmzQspu+NOFLIWGi5lq3UpaNqB0K0Uk5RmjEah4Ni659DvvFM8IgLO
   ATgwCY2O+Kcne73igTW3FT4VqfDLEcRab7x5bfG8hYnxpWboYFCN8lqI6
   Q==;
IronPort-SDR: WosOnCY4FEHoU66Eu9T6uvuh7aqgb83UdcB9ZaRRec7tRXHla7OGo2Zc5Crh2FcB+CAfphFBfY
 AZYpotpkf9MBnrjdEcjtV9iKUUKw5hDBNmWjZXnA6W2CSGHEc182c7rQjtWUqF1cQGTWHZ7r1B
 DbNzdLPFt8h3LrHThUw9smk7NIkRZqo67158OUJVjgXh/w/04BpgBDoghPR/ACp05Zmo5pLb2I
 6Fh0RxStDTZpbcvO5rHlYMC68ybFM75mlTTblYotoZucRVRFBiYiy8PUlEkG3NSLUEsHtMhPfc
 X/rV7oQcygoW4IZWjr1XI+mP
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="135629857"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:54:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:54:37 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:54:35 -0700
Subject: Re: [PATCH v5 07/15] clk: at91: sam9x60-pll: use
 DIV_ROUND_CLOSEST_ULL
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-8-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <62bea638-22b8-916e-85ad-55ae1b51ba68@microchip.com>
Date:   Fri, 15 Oct 2021 09:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-8-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> Use DIV_ROUND_CLOSEST_ULL() to avoid any inconsistency b/w the rate
> computed in sam9x60_frac_pll_recalc_rate() and the one computed in
> sam9x60_frac_pll_compute_mul_frac().
> 
> Fixes: 43b1bb4a9b3e1 ("clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple outputs")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/clk-sam9x60-pll.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index 7020d3bf6e13..a73d7c96ce1d 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -73,8 +73,8 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
>   	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
>   	struct sam9x60_frac *frac = to_sam9x60_frac(core);
>   
> -	return (parent_rate * (frac->mul + 1) +
> -		((u64)parent_rate * frac->frac >> 22));
> +	return parent_rate * (frac->mul + 1) +
> +		DIV_ROUND_CLOSEST_ULL((u64)parent_rate * frac->frac, (1 << 22));
>   }
>   
>   static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
> 


-- 
Nicolas Ferre
