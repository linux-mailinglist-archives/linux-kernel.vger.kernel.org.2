Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140FD42EB09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhJOIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:09:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27135 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhJOIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634285236; x=1665821236;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uitAjkFUX1pEFSCABf4unNxAQcVHpJXhFxJqh1CRV50=;
  b=BOiQ5xsBP2K8UFDneqe6LQYKk0B4bvUzYWCy3nhVTNE/aFoWhEzyMsLB
   /dAec9yRIlZjzOzjs2IoIenBcyHsocOnTY68nw8Aj/gMVkNp5mbvcdaHB
   OgePaMNwBAN1U2xzqwHokDcfnvkHR8BgO49t8DJarcFgePlHLyBydJLIt
   XuDwSMVtBMTT4CvQ29eoBpgnTOtoQNFp/vA4IfiOE48pW7CRD8FDsmOqN
   dekRcEt56qsJEd4vpFJar7rDOhru0LtoExTpOCJMt7fUmuc6DXB9QMeA+
   udrEJQIFKYH/mWsQjuoJoS3Msb+7MmQlE4/gJ1zp4pW7TFYSlLbCQh/5Q
   g==;
IronPort-SDR: w4laEWHJRu+jDg91Gb+yCFFZPhZa8MsyviSfK1LuXWDf881wIKjxie7OTVFQfuSMq96wEKBABL
 EJ3t86wWlYzb+xFm5hDLf9ThylLLl+/E6duvGh1dKz1C7A1RnKHi9e5A93HppGEEEmF7xLTDdH
 t+BZpTZ7Zhfv6xapMclTRrGmCaIsn7xJhhJLEUjjc1MtNXT8zaQv7Qd3OFAIWYIu1WfDz0UI+k
 HMAj2PPNXFmzerYkyrrGlGpP4a0WLsYgSFCaCPf6MJsyidcBD6afBNGfl58AoH3OFzBO12BUbk
 Wzo9FREj/ZdvWVuUBHVmJZAu
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="73045448"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 01:07:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 01:07:15 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 01:07:13 -0700
Subject: Re: [PATCH v5 13/15] clk: at91: sama7g5: remove prescaler part of
 master clock
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-14-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <9ba33681-f65d-1b65-22ef-85ef973b723a@microchip.com>
Date:   Fri, 15 Oct 2021 10:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-14-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> On SAMA7G5 the prescaler part of master clock has been implemented as a
> changeable one. Everytime the prescaler is changed the PMC_SR.MCKRDY bit
> must be polled. Value 1 for PMC_SR.MCKRDY means the prescaler update is
> done. Driver polls for this bit until it becomes 1. On SAMA7G5 it has
> been discovered that in some conditions the PMC_SR.MCKRDY is not rising
> but the rate it provides it's stable. The workaround is to add a timeout
> when polling for PMC_SR.MCKRDY. At the moment, for SAMA7G5, the prescaler
> will be removed from Linux clock tree as all the frequencies for CPU could
> be obtained from PLL and also there will be less overhead when changing
> frequency via DVFS.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Indeed:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/sama7g5.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index c66bde6f7b47..fd9d17eabf54 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -992,16 +992,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>   	}
>   
>   	parent_names[0] = "cpupll_divpmcck";
> -	hw = at91_clk_register_master_pres(regmap, "cpuck", 1, parent_names,
> -					   &mck0_layout, &mck0_characteristics,
> -					   &pmc_mck0_lock,
> -					   CLK_SET_RATE_PARENT, 0);
> -	if (IS_ERR(hw))
> -		goto err_free;
> -
> -	sama7g5_pmc->chws[PMC_CPU] = hw;
> -
> -	hw = at91_clk_register_master_div(regmap, "mck0", "cpuck",
> +	hw = at91_clk_register_master_div(regmap, "mck0", "cpupll_divpmcck",
>   					  &mck0_layout, &mck0_characteristics,
>   					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
>   	if (IS_ERR(hw))
> 


-- 
Nicolas Ferre
