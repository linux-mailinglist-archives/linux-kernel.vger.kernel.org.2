Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767B742EABA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhJOH5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:57:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:1067 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhJOH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284538; x=1665820538;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=je+fRzZbUtkEQeC1OXFMaXlMlWixDGzDWn2+u6AGNhc=;
  b=c5FZAnXyBfCOkzqdF+V34mXxIhqrqb4DIjCQ2EHqUjKXPJk9R8ezC1uh
   2i0+8psmwQLYUCjojtGUbwfpLF8Eh/hsRZ9hS6FJ8nHFZUp1I7/Oz7IlW
   8QNplnkIp/1DDN8ZAmkOfnJa9ljjyqY9xVQNZyuSo5rtLp8d2ks68aI+w
   65KFQ6qkLKgkgVWCGSaqwDWkx48Bj66eobXzSD53p8K+fRr8H+CSzDKN6
   FUHADDMBesEV9GPXhgZWWJ/ZQR1Cnp9kQuRhBUGbWh0h4ELaD6b7tnAa0
   NP80dLDVrBcyMJiks+r14v5ik45z18Ln0hA5OQb60sUrlnt/BVvvY3Q3H
   Q==;
IronPort-SDR: 7DOrw+CuIqYQBmgcp1cQwrbTsL0Bx0hMA6YeUI76OgaDZyPO0WexPMCCOyqi6OSjvGZgB4Mpr6
 n4gNgHJEs1QfYYXctfjYrxg8X3SspTpHL1kpto+xBkc6+uj9jIMnkZtX4xM9FESVLwoFRkJ6+1
 Wblw3oQUV8v4mnCtrxKQarjFO+TYs8zsBUy6vQAxbkj2iINIyQu+y8BekuiE8WW1Z4rxMCzNGM
 k7jiBgchBmUIczNCkArJAMkL0enrcGcwvRXOsqaHCVdEC7+4XRkpV0oG8dGVWyolrBvmsTdFQl
 B6fp3tvT0IQz4n59TpCcuC1R
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="133104565"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:55:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:55:37 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:55:36 -0700
Subject: Re: [PATCH v5 08/15] clk: at91: clk-master: check if div or pres is
 zero
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-9-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <e56bc978-5442-c229-ce01-e37c4aea46e7@microchip.com>
Date:   Fri, 15 Oct 2021 09:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-9-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> Check if div or pres is zero before using it as argument for ffs().
> In case div is zero ffs() will return 0 and thus substracting from
> zero will lead to invalid values to be setup in registers.
> 
> Fixes: 7a110b9107ed8 ("clk: at91: clk-master: re-factor master clock")
> Fixes: 75c88143f3b87 ("clk: at91: clk-master: add master clock support for SAMA7G5")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/clk-master.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 9a2c8e64cacf..2093e13b5068 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -344,7 +344,7 @@ static int clk_master_pres_set_rate(struct clk_hw *hw, unsigned long rate,
>   
>   	else if (pres == 3)
>   		pres = MASTER_PRES_MAX;
> -	else
> +	else if (pres)
>   		pres = ffs(pres) - 1;
>   
>   	spin_lock_irqsave(master->lock, flags);
> @@ -757,7 +757,7 @@ static int clk_sama7g5_master_set_rate(struct clk_hw *hw, unsigned long rate,
>   
>   	if (div == 3)
>   		div = MASTER_PRES_MAX;
> -	else
> +	else if (div)
>   		div = ffs(div) - 1;
>   
>   	spin_lock_irqsave(master->lock, flags);
> 


-- 
Nicolas Ferre
