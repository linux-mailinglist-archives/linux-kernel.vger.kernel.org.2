Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5053FD739
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbhIAJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:52:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16674 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhIAJwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630489918; x=1662025918;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CT+UDxn6as6xh9A8sRKHCVHW8lQ6e8ercxAnl+msfa4=;
  b=eA2DkHGWAdUrgdtGIlHGq8Hc5LUol0cO+qk89BDG0IrGmmT0NOwebu16
   MDvlKB2BqNPaN9uiH/kXABjGSrxmNZpl+Tf/88jMIlNaDJW60MVjHWLPW
   oD9RQuIJfliq1KeFqMclKXjCLfnR5piyUPCqNlsmeE0rwT+3dsuScCFHR
   2YxM+Xtjx2EcwwZCfpTWlzNyPzM5c5NpseaWR7rKBShJz9I+DDUYS3/cC
   U+IRjs1lLDnMWXxp0S7ZxAbc9Qnb7tNyqncd2kBUtlMxchZk8HrNs1o3e
   YORebQNGpdDm0uFf2L9G6t1JKwkOat8yn20AMBKcBL86VfMFYCSjnxLaE
   Q==;
IronPort-SDR: vn4D+YekV0Fiv6VB5tu6Q4vZrImudio67aI8no935WoRuMOzTfSaBQCobDKRVb40CRWiq8uwZw
 Dgv+nmF3XqcTz823/pnc8R7mHlljvXjGma6SWiQsqAoad8AVAkmmrPC7tAQ0q42jJsN0I4Ma0G
 SLdL1mg//CwwT1/NSa6yyLezkjTvnlnw5tHAPjLZggKUfp4PCD1d+gszQIWXHNJrLAXIQh7+ee
 shHlDYpva3KPgIKSQo1Cf/bysA88C6zH/sUKwMr5P05aCEmBrGpjSoqAUeThP1QmAX+/i28A/T
 JiftHf6uz+cmuwWiP0O1UiOI
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="142389275"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 02:51:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 02:51:49 -0700
Received: from [10.12.72.234] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 1 Sep 2021 02:51:47 -0700
Subject: Re: [PATCH] mtd: rawnand: atmel: Make use of the helper function
 devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210901074031.8883-1-caihuoqing@baidu.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <3ac919ad-be84-f050-a7d1-c15c8c06217e@microchip.com>
Date:   Wed, 1 Sep 2021 11:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901074031.8883-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2021 at 09:40, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/mtd/nand/raw/atmel/pmecc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index cbb023bf00f7..498e41ccabbd 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -834,7 +834,6 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
>   {
>          struct device *dev = &pdev->dev;
>          struct atmel_pmecc *pmecc;
> -       struct resource *res;
> 
>          pmecc = devm_kzalloc(dev, sizeof(*pmecc), GFP_KERNEL);
>          if (!pmecc)
> @@ -844,13 +843,11 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
>          pmecc->dev = dev;
>          mutex_init(&pmecc->lock);
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, pmecc_res_idx);
> -       pmecc->regs.base = devm_ioremap_resource(dev, res);
> +       pmecc->regs.base = devm_platform_ioremap_resource(pdev, pmecc_res_idx);
>          if (IS_ERR(pmecc->regs.base))
>                  return ERR_CAST(pmecc->regs.base);
> 
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, errloc_res_idx);
> -       pmecc->regs.errloc = devm_ioremap_resource(dev, res);
> +       pmecc->regs.errloc = devm_platform_ioremap_resource(pdev, errloc_res_idx);
>          if (IS_ERR(pmecc->regs.errloc))
>                  return ERR_CAST(pmecc->regs.errloc);
> 
> --
> 2.25.1
> 


-- 
Nicolas Ferre
