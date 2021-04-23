Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA28369A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbhDWTHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:07:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33022 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWTHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:07:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13NJ6sVD104992;
        Fri, 23 Apr 2021 14:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619204814;
        bh=MAP55pXss4MbD1ZDBAEBd9q93h+e6Ym4v7PzVAfMBr8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XaH81qLsP3oP5HX5kOouR62RVXKDVW1cEoIAPXf7KoePJ50lXHYR5Umj7qFw0uQAp
         Xm9FgYzBJpK8eC+RbGzh2MBI8SZrYSnxzKOsN17ReIVfyxLQuysYDwBSeRuyZ5zlaF
         fm1DrsoKSrtQ79r6Rg8Dd0WWwWDRKy2C3pmqBfFs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13NJ6s73075366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Apr 2021 14:06:54 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 23
 Apr 2021 14:06:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 23 Apr 2021 14:06:53 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13NJ6pAt101168;
        Fri, 23 Apr 2021 14:06:52 -0500
Subject: Re: [PATCH] soc: ti: Use devm_platform_ioremap_resource_byname
To:     <dingsenjie@163.com>, <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        dingsenjie <dingsenjie@yulong.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
References: <20210423090409.25032-1-dingsenjie@163.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <229e8a69-818a-5024-67f7-8afc09522810@ti.com>
Date:   Fri, 23 Apr 2021 22:06:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423090409.25032-1-dingsenjie@163.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2021 12:04, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
> 
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>
> ---
>   drivers/soc/ti/k3-ringacc.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index b495b0d..aa8ebd4 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -1352,7 +1352,6 @@ static int k3_ringacc_init(struct platform_device *pdev,
>   	const struct soc_device_attribute *soc;
>   	void __iomem *base_fifo, *base_rt;
>   	struct device *dev = &pdev->dev;
> -	struct resource *res;
>   	int ret, i;
>   
>   	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
> @@ -1373,24 +1372,19 @@ static int k3_ringacc_init(struct platform_device *pdev,
>   		ringacc->dma_ring_reset_quirk = soc_data->dma_ring_reset_quirk;
>   	}
>   
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rt");
> -	base_rt = devm_ioremap_resource(dev, res);
> +	base_rt = devm_platform_ioremap_resource_byname(pdev, "rt");
>   	if (IS_ERR(base_rt))
>   		return PTR_ERR(base_rt);
>   
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fifos");
> -	base_fifo = devm_ioremap_resource(dev, res);
> +	base_fifo = devm_platform_ioremap_resource_byname(pdev, "fifos");
>   	if (IS_ERR(base_fifo))
>   		return PTR_ERR(base_fifo);
>   
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "proxy_gcfg");
> -	ringacc->proxy_gcfg = devm_ioremap_resource(dev, res);
> +	ringacc->proxy_gcfg = devm_platform_ioremap_resource_byname(pdev, "proxy_gcfg");
>   	if (IS_ERR(ringacc->proxy_gcfg))
>   		return PTR_ERR(ringacc->proxy_gcfg);
>   
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -					   "proxy_target");
> -	ringacc->proxy_target_base = devm_ioremap_resource(dev, res);
> +	ringacc->proxy_target_base = devm_platform_ioremap_resource_byname(pdev, "proxy_target");
>   	if (IS_ERR(ringacc->proxy_target_base))
>   		return PTR_ERR(ringacc->proxy_target_base);
>   
> @@ -1458,7 +1452,6 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
>   	struct device *dev = &pdev->dev;
>   	struct k3_ringacc *ringacc;
>   	void __iomem *base_rt;
> -	struct resource *res;
>   	int i;
>   
>   	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
> @@ -1473,8 +1466,7 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
>   
>   	mutex_init(&ringacc->req_lock);
>   
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ringrt");
> -	base_rt = devm_ioremap_resource(dev, res);
> +	base_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
>   	if (IS_ERR(base_rt))
>   		return ERR_CAST(base_rt);
>   
> 

-- 
Best regards,
grygorii
