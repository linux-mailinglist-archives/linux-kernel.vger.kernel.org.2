Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9D42EAA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhJOHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:55:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:59364 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbhJOHzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284416; x=1665820416;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qOZVawR/4Z3U1gtxeNah2+OwiB4/ctcc6Tz3DAb3yiw=;
  b=kLAxMy0tfa4Rsz3VhIZKRumAvLd95VIkVGLpIclvUVCMLq4LadezNS6W
   B8LKYH1GHEyPgf6R50pO5RJMdT5gSdBN7pyHxMM2X65sIDMe95YVEyJ4E
   oUoyBJ3R8LlZZXObx/Q7fVjuknbltGsw6WxVjHVyzBTLfyIuOUPBc9FEb
   x0m27RD5NCftJ5g/38y0Ugvquwq1fO0441whMS63zf0GAYjfirsurpssR
   3bRLMH2F3hMyVgpX8iKEM2Xs1sNO1xfLhGdJaW/KeErdtGQnJFdyTvPIr
   wtiipOaB547dgGQO9OhYXNWk5+8em2KVAMf5AvAVM5CQDQr2k5EH0Fz3f
   w==;
IronPort-SDR: vESsJ3HFiBUeqLP+75uyNqmu3Un1qo+N7oNFbTosKHTkyvo0IshQuR3F8TLxX0IRVp9OkMPwI3
 XoeKE2xyVg+PhpkPhaXAyvLiqaN7PH+k0JBsbmqgEAmizWM/wBu4aVkJZ3S0BpkiSbjOQJuNiz
 Je/fRpKw0KiK+jNXQfybhcR43CsaXXcSgoARBbwFacbzN6jDK1fc24VcI/2wfZGpeR3XW0EcXJ
 Gmo6S4DPXnDAHkSUpC74ui+vCm3/8MHc7YQk3+PfkaUQJ+cDKv/uobE6q0nFxb22qnjEmPrdl5
 bmXonB11zFFNEcIgtoP5Q7Id
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="135629748"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:53:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:53:34 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:53:32 -0700
Subject: Re: [PATCH v5 05/15] clk: at91: clk-master: improve readability by
 using local variables
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-6-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <11e656f6-85f6-f733-36b8-8871a8600cf2@microchip.com>
Date:   Fri, 15 Oct 2021 09:53:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-6-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> Improve readability in clk_sama7g5_master_set() by using local
> variables.
> 
> Suggested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

So, obviously ;-) :
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu!

> ---
>   drivers/clk/at91/clk-master.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 88f7af1bfff6..9a2c8e64cacf 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -680,6 +680,8 @@ static void clk_sama7g5_master_set(struct clk_master *master,
>   	unsigned long flags;
>   	unsigned int val, cparent;
>   	unsigned int enable = status ? AT91_PMC_MCR_V2_EN : 0;
> +	unsigned int parent = master->parent << PMC_MCR_CSS_SHIFT;
> +	unsigned int div = master->div << MASTER_DIV_SHIFT;
>   
>   	spin_lock_irqsave(master->lock, flags);
>   
> @@ -689,9 +691,7 @@ static void clk_sama7g5_master_set(struct clk_master *master,
>   	regmap_update_bits(master->regmap, AT91_PMC_MCR_V2,
>   			   enable | AT91_PMC_MCR_V2_CSS | AT91_PMC_MCR_V2_DIV |
>   			   AT91_PMC_MCR_V2_CMD | AT91_PMC_MCR_V2_ID_MSK,
> -			   enable | (master->parent << PMC_MCR_CSS_SHIFT) |
> -			   (master->div << MASTER_DIV_SHIFT) |
> -			   AT91_PMC_MCR_V2_CMD |
> +			   enable | parent | div | AT91_PMC_MCR_V2_CMD |
>   			   AT91_PMC_MCR_V2_ID(master->id));
>   
>   	cparent = (val & AT91_PMC_MCR_V2_CSS) >> PMC_MCR_CSS_SHIFT;
> 


-- 
Nicolas Ferre
