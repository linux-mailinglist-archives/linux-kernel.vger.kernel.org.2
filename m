Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CE3FDF3F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbhIAQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:00:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5286 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230129AbhIAQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:00:32 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 181Bx9Fe031964;
        Wed, 1 Sep 2021 17:58:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dmswWeHE+9B8VOaL4IRd+83Q+HDkWTJFmrdLfyJESVU=;
 b=DvW5y29/oN0th7WqLDaVx5i0HPhr/ECi/nufq7qTY6+AkF2Wnj/kjuvutQOsvQnYz2Dw
 6V53UdwqbFX/3Tr8Pa4I7UYtRnP07FpcvBk+Nvnjw55Qj1xqwb9T8fhege24Ct8iknj+
 p4+OjexJP6yzIuJiFDPiqBOMomOefKvZehwH0gn6tgtoHuyyNLljTvu54Rj0o0t165Ye
 X4hRaLucplUAG+IQ+ZAQGDM9ghBMdLoRHrezxaOPDwc611HiL36VS4qcRWMRMoEIzpWA
 p3BrjzVvQlptS2d1U7sHDfBTMlldXCdVQDzxhDg0ZyTiLufNPtOpd3iC71d+Hg0KNfwJ Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3at5y939y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 17:58:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0735D10002A;
        Wed,  1 Sep 2021 17:58:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7E5B231DC7;
        Wed,  1 Sep 2021 17:58:37 +0200 (CEST)
Received: from lmecxl1094.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Sep
 2021 17:58:36 +0200
Subject: Re: [Linux-stm32] [PATCH] mtd: rawnand: stm32_fmc2: Make use of the
 helper function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210901074222.9433-1-caihuoqing@baidu.com>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
Message-ID: <a69d1484-fb7a-6da5-3d46-48c49b612d2a@foss.st.com>
Date:   Wed, 1 Sep 2021 17:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901074222.9433-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-01_05,2021-09-01_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/21 9:42 AM, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 1c277fbb91f2..97b4e02e43e4 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1899,15 +1899,11 @@ static int stm32_fmc2_nfc_probe(struct platform_device *pdev)
>   
>   		nfc->data_phys_addr[chip_cs] = res->start;
>   
> -		res = platform_get_resource(pdev, IORESOURCE_MEM,
> -					    mem_region + 1);
> -		nfc->cmd_base[chip_cs] = devm_ioremap_resource(dev, res);
> +		nfc->cmd_base[chip_cs] = devm_platform_ioremap_resource(pdev, mem_region + 1);
>   		if (IS_ERR(nfc->cmd_base[chip_cs]))
>   			return PTR_ERR(nfc->cmd_base[chip_cs]);
>   
> -		res = platform_get_resource(pdev, IORESOURCE_MEM,
> -					    mem_region + 2);
> -		nfc->addr_base[chip_cs] = devm_ioremap_resource(dev, res);
> +		nfc->addr_base[chip_cs] = devm_platform_ioremap_resource(pdev, mem_region + 2);
>   		if (IS_ERR(nfc->addr_base[chip_cs]))
>   			return PTR_ERR(nfc->addr_base[chip_cs]);
>   	}
> 

Reviewed-by: Christophe Kerello <christophe.kerello@foss.st.com>
