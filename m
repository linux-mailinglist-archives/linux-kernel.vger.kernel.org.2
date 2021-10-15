Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3174642EABF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhJOH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:58:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48651 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhJOH6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284605; x=1665820605;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BGy4nKkFSUYhNDse2rH6kKGMeEkum5mhKIYnkWkpkE8=;
  b=waztTigSx7/gmIrbuachBcpRhn3P2/mpGtk1ec10SwZiyMCOoJMKuBHE
   zqgXhawW4cpbXF5ni0NGa2GnvKGdhqC2k5NDlSD6DMxzXf+4VN55/CC17
   kVI6FYWPYjtQLo30+Mh2z4AbRVDYkZHzzdNRfeW4izOLX22U3R6aH3tU6
   DLvSFqSAHyzwPmnu8Q/TDp8mvQmnmc8z0iSe0aVHxWzLLRtYGBDQhtvAs
   MmMxWFN1HCqwzWeypYnbbNEFCqZG3pabmz2Ril7U8g14og65Yxyz/dcNS
   iADKkvX7Z9NA97tq5MIKNIQKp9ATmGe4v3COpeOsAg2R/CiVXR/M7C07F
   Q==;
IronPort-SDR: wbQTdL9+1lsQc4C8EYa3Qtfm+H2Ex4UJVsau1O2LN5QhbzRynAliwGZw3GLSTvTm3MPFOr4+xs
 aqvcUdWRYdZEkz3WS873x1ORSXuDFK4GNRdlR66dPoZTRxQ4+KFP212xtK0R7FW6tLnuR1AGYW
 ph7LMqeR6tEk0CbSqN/LqKiozI4s3yXQ+xBfYNMbiwdqdNNTBXblf3zNq5BfVjHliIPFlWusyW
 ksSxSPGMsGTODZuwpKTClU/G1t+1vyZ/2Gf2Yg7T6IY5Ww5HxZBXT9P94k+1/MQRiaIeSyWgjn
 YZQv2bqre/RoQIHMrzT9HFJc
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="140403841"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:56:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:56:44 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:56:43 -0700
Subject: Re: [PATCH v5 09/15] clk: at91: clk-master: mask mckr against
 layout->mask
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-10-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <579573e1-ab48-75b2-b185-5885ac5a15c5@microchip.com>
Date:   Fri, 15 Oct 2021 09:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-10-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> Mask values read/written from/to MCKR against layout->mask as this
> mask may be different b/w PMC versions.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/clk-master.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 2093e13b5068..6da9ae34313a 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -186,8 +186,8 @@ static int clk_master_div_set_rate(struct clk_hw *hw, unsigned long rate,
>   	if (ret)
>   		goto unlock;
>   
> -	tmp = mckr & master->layout->mask;
> -	tmp = (tmp >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
> +	mckr &= master->layout->mask;
> +	tmp = (mckr >> MASTER_DIV_SHIFT) & MASTER_DIV_MASK;
>   	if (tmp == div)
>   		goto unlock;
>   
> @@ -384,6 +384,7 @@ static unsigned long clk_master_pres_recalc_rate(struct clk_hw *hw,
>   	regmap_read(master->regmap, master->layout->offset, &val);
>   	spin_unlock_irqrestore(master->lock, flags);
>   
> +	val &= master->layout->mask;
>   	pres = (val >> master->layout->pres_shift) & MASTER_PRES_MASK;
>   	if (pres == 3 && characteristics->have_div3_pres)
>   		pres = 3;
> @@ -403,6 +404,8 @@ static u8 clk_master_pres_get_parent(struct clk_hw *hw)
>   	regmap_read(master->regmap, master->layout->offset, &mckr);
>   	spin_unlock_irqrestore(master->lock, flags);
>   
> +	mckr &= master->layout->mask;
> +
>   	return mckr & AT91_PMC_CSS;
>   }
>   
> 


-- 
Nicolas Ferre
