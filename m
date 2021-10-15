Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B904942EB20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhJOILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:11:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:29891 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhJOILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634285342; x=1665821342;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eyJy8OAqdD3sS/xEeHYG9Z5SneuiIt+HjwAtZeZEo3E=;
  b=z2+ei3hcZ+JUeP0XmyFcPmNoB4i6SI7pLF+WASczkYCLgu844oBMLw4/
   qV9AdVpRB8O3YOSYFeF+QDgMk7+bT/tjVOVb/G8mHMVAz0TbqoF9ovjHp
   Oag84bb3qvKoXYYW57Sr/Gq7lKQ+Em1GQrR+YKHWH2nVaS0RPV/U5vKaq
   VXEx9FZ7PuOCDK1sViHSn41MfTA7rXVYufZWoVDzBA2O4rY1WY1rsV7dB
   Mcldskabic1N5Zdx++iZRaXVjDD0hg67wWWl+MjcxS3qs1h63TbDzIBS1
   30CmpMiCW2NE3Y2mqQFRKDqPEtmhLNKSJ09hDboGEmVCnb2el/7MM3V4a
   w==;
IronPort-SDR: eU+lKDjjYpa87MLKge2Sc8cB9opczheKXeqPrKGNhpTRYx62BMgmRU8k63wppC3z+72k13C2YN
 ivgVQZfKr/sJvKnqOTYGeesSMI17+YkIQqCbcBImFS4j5G+7dUXNKHryiGw+/Sy0Cf5s4+xSmq
 30Z7PTjBUBqbKPCLzqA4Tz//fTifSIFkv2PumdThFsPG1ViY+OsLaVTDsOZGtlYBKgRkLzAnyK
 8xepDfMoW/pAej85w6REJ6FapDVlIy+4feF3bKYt0vvyFjMR9ZvG9CVzueyV8J7QY07OIxcmwl
 b7ibUM+1es6VLjCOu3xXA38c
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="139818623"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 01:09:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 01:09:00 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 01:08:58 -0700
Subject: Re: [PATCH v5 15/15] clk: use clk_core_get_rate_recalc() in
 clk_rate_get()
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-16-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <1684834b-f68f-79eb-c12b-f7dbb2420173@microchip.com>
Date:   Fri, 15 Oct 2021 10:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-16-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> In case clock flags contains CLK_GET_RATE_NOCACHE the clk_rate_get()
> will return the cached rate. Thus, use clk_core_get_rate_recalc() which
> takes proper action when clock flags contains CLK_GET_RATE_NOCACHE.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 65508eb89ec9..64838754cdef 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3108,7 +3108,7 @@ static int clk_rate_get(void *data, u64 *val)
>   {
>   	struct clk_core *core = data;
>   
> -	*val = core->rate;
> +	*val = clk_core_get_rate_recalc(core);
>   	return 0;
>   }
>   
> 


-- 
Nicolas Ferre
