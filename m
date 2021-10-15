Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497EA42EAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhJOH4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:56:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:20586 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhJOH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284445; x=1665820445;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zQaLXl76PE8+h3DdG+gufronQg25e23Fb+DmD9fslEY=;
  b=seBLCtsXYmpO2AygPeZHPW6gy3jyQeEj40y7/oK3eYabnvxMIwcnk7do
   0pSyEtQYSjV7QLzcf7AXgK91doeXGs6uaORwUBIlOMUYoLRh18NnzPsG4
   71GIQHEqvl8zBtUFIAgjyYE8vlUA2IVnFJN9BhNl+QNv+HselGs83zLbF
   a8IeYdx3R1KyEa3fsipfOH06J+MjGS5vSCuKCRAOVj2r37G7rJUn29Cd+
   w/gTq+8jViRTvCT9j7jM90Syn2wssZ3KxXSf0LUtpvCIs8YYumVvty8TX
   9iBln/oR1ubmdYSvYK1iNkm2O8A5r0vkYuwpJ91y+L+R53MKXbGzXSbJM
   Q==;
IronPort-SDR: 13+gWVQ/7Py/d3dqkuLEvVt7ri21SYqrIo9LyiaTLYNknZIxOrG3YCmjUbcUrvx6sIiaisEU6T
 qQ84AlwqZeOLnsNOqBfSQ7OOMSi60Oex3LQGTaKovYCoZpinhNt01gfLvrgyUHPLVJ4WQPpeVp
 anEhkGpe3af5Xn/HJwuKvD6pzPammjzccgKEekf/LDu/8JmCnPO/xyDSRp++XLm1O3xp4UpFSv
 TS10qMQTrd9vQLy2EET0M6fwEDj+uGwTmAny/SsLNGQUymCJLnY9kCt2DX/vZuMphITuFjAjSD
 aTI67zOpY2qLByvwohh501wt
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="139817490"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:54:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:54:04 -0700
Received: from [10.12.67.94] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:54:02 -0700
Subject: Re: [PATCH v5 06/15] clk: at91: pmc: add sama7g5 to the list of
 available pmcs
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
 <20211011112719.3951784-7-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <4414e97d-b467-fd5b-0e22-783833e1feba@microchip.com>
Date:   Fri, 15 Oct 2021 09:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011112719.3951784-7-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 at 13:27, Claudiu Beznea wrote:
> Add SAMA7G5 to the list of available PMCs such that the suspend/resume
> code for clocks to be used on backup mode.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/clk/at91/pmc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 517973062719..5aa9c1f1c886 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -148,8 +148,9 @@ static struct syscore_ops pmc_syscore_ops = {
>   	.resume = at91_pmc_resume,
>   };
>   
> -static const struct of_device_id sama5d2_pmc_dt_ids[] = {
> +static const struct of_device_id pmc_dt_ids[] = {
>   	{ .compatible = "atmel,sama5d2-pmc" },
> +	{ .compatible = "microchip,sama7g5-pmc", },
>   	{ /* sentinel */ }
>   };
>   
> @@ -157,7 +158,7 @@ static int __init pmc_register_ops(void)
>   {
>   	struct device_node *np;
>   
> -	np = of_find_matching_node(NULL, sama5d2_pmc_dt_ids);
> +	np = of_find_matching_node(NULL, pmc_dt_ids);
>   	if (!np)
>   		return -ENODEV;
>   
> 


-- 
Nicolas Ferre
