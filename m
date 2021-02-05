Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F90310A46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhBEL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:29:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48394 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhBEL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:26:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 115BO1wf048344;
        Fri, 5 Feb 2021 05:24:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612524241;
        bh=vVhluiN+5BOsD2L9K3Iny8HhR+qZ41FlPExCZ+PrPR0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R0v8+yhiWdYyyheBcgfM8gf4VQHejMqvBqEpQUmE7xN1lD4c9xpMp8kkNHdVvx50c
         PYkOD5pg+ED+9JSbVd3NMccJHnB7xyk31St+bZFGpc21nP6LRghRD3bebpk0Z4mDKk
         HxXeWHiSF+s866ZaalNom1+NnoDXf4FZtv5Ri7Is=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 115BO12F093234
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Feb 2021 05:24:01 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Feb
 2021 05:24:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Feb 2021 05:24:01 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 115BNxr2116113;
        Fri, 5 Feb 2021 05:24:00 -0600
Subject: Re: [PATCH] soc: ti: k3-ringacc: Use of_device_get_match_data()
To:     Suman Anna <s-anna@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210130050400.28085-1-s-anna@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <7340caba-6975-2bc3-021e-c54a67cbcd18@ti.com>
Date:   Fri, 5 Feb 2021 13:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210130050400.28085-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2021 07:04, Suman Anna wrote:
> Simplify the retrieval of getting the match data in the probe
> function by directly using of_device_get_match_data() instead
> of using of_match_node() and getting data.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>   drivers/soc/ti/k3-ringacc.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index b495b0d5d0fa..312ba0f98ad7 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -9,6 +9,7 @@
>   #include <linux/io.h>
>   #include <linux/init.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/sys_soc.h>
>   #include <linux/dma/ti-cppi5.h>
> @@ -1517,15 +1518,13 @@ EXPORT_SYMBOL_GPL(k3_ringacc_dmarings_init);
>   static int k3_ringacc_probe(struct platform_device *pdev)
>   {
>   	const struct ringacc_match_data *match_data;
> -	const struct of_device_id *match;
>   	struct device *dev = &pdev->dev;
>   	struct k3_ringacc *ringacc;
>   	int ret;
>   
> -	match = of_match_node(k3_ringacc_of_match, dev->of_node);
> -	if (!match)
> +	match_data = of_device_get_match_data(&pdev->dev);
> +	if (!match_data)
>   		return -ENODEV;
> -	match_data = match->data;
>   
>   	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
>   	if (!ringacc)
> 

Thank you
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
-- 
Best regards,
grygorii
