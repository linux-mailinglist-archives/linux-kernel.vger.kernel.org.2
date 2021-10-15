Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10FA42EACD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhJOIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:00:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:7506 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhJOIAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284718; x=1665820718;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oCB7i+Ff2eyLa/FEWfr5IeaOAbYgKZzhb8tXmlEFifA=;
  b=ZyKELkkxVoQSEMwiVBfq6YilsscDXG2Xww2xPkgdYqXVQoaSqglZON6P
   7xtj0iF3/UGI31DzyWy0C6fqaiwKN6oxYPrF76wVvoPQMth4vlMqSWp6a
   B/wLvsUbqZ3zqVoWvdtta6RayHNPoHnotx7wYD/16cs77H+h7mvj5xfZE
   zBhPv0cq9RMO6imz+/YcrJZdGfKN39IPKSFxCJrgeEM3sD/USesaOJHUg
   SJrWkS/2EdffRt7bm5GGQjB7Hy64IVxjBsLlqpIAfxBH4PCxmFntVydXM
   iF+RiI1x9dxLAlK9VAuHytbgDZuWPqCFKnstQnYWSGADSQWn9CqONu6oH
   A==;
IronPort-SDR: c/fIwTs9DiQJoYJ7tivX1d/2TCEAVBJIdSFIT28xXiTocPRNKnFt+9N3K2qdviZZ7r6lKr2Z1S
 IqD91CqzojTzEBrkYq6lJxCCg1Fyy5fwZt7aS2x9qzvQ6pAHBjh2UM9wPt/zZaPYGbo7WnDzTC
 JdzVLC3PCcWY9y9UaDwdYgyho5EJJlau3jK9gpmik846tw6Vo9sC1j/mfMc9epMdhyuACetOj6
 IXu9iWVmxAHvDQGad5Wg8c2xz4K6yjurrgZWtrwQgvkauKwYuDmnUVp5Yp0eLzJ0rsv4hj7Ml2
 TUMYWUm0Zyrzl/YZEQ+dsDRZ
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="135630219"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:58:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:58:36 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:58:35 -0700
Subject: Re: [PATCH v5 10/15] clk: at91: clk-master: fix prescaler logic
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-11-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <220aaf60-0ee1-97d1-6b65-eb3b57ddab10@microchip.com>
Date:   Fri, 15 Oct 2021 09:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-11-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> When prescaler value read from register is MASTER_PRES_MAX it means
> that the input clock will be divided by 3. Fix the code to reflect
> this.
> 
> Fixes: 7a110b9107ed8 ("clk: at91: clk-master: re-factor master clock")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/clk-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 6da9ae34313a..e67bcd03a827 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -386,7 +386,7 @@ static unsigned long clk_master_pres_recalc_rate(struct clk_hw *hw,
>   
>   	val &= master->layout->mask;
>   	pres = (val >> master->layout->pres_shift) & MASTER_PRES_MASK;
> -	if (pres == 3 && characteristics->have_div3_pres)
> +	if (pres == MASTER_PRES_MAX && characteristics->have_div3_pres)
>   		pres = 3;
>   	else
>   		pres = (1 << pres);
> 


-- 
Nicolas Ferre
