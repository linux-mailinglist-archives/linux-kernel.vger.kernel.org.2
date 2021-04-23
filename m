Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A247F3691B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbhDWMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:03:42 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34262 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242259AbhDWMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:03:40 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NC24LM015246;
        Fri, 23 Apr 2021 14:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WD96ZYftirjps1b7STHm3D8G2o7VrvWXKlGU+slnDzA=;
 b=QWSIQn0rA70SBTvEpG87q+vOwzUeAmH0wACwXjBG3/R2Ea0L/S54z06W3ZrQE0GlJCtS
 uqJWHodePUjdqSpzSc5/0t67nZ7z8s7QCbF18/ckwlqbPnOkGDlIHxrl0W0eYeov4sSR
 pUMUHufdMwNomVUk9LoimzsgObDivNC+RLBEs2JNi0J8xHc5CRRajqQ7FcgFMqfRnIBk
 k7QCXQI/VufY5LZCZKc58r1ujSXOPoZzepuaWmD/6trAwoUm8er4L+ZHMHz8rKQ5HQbP
 /aBJKbujf2Bt9TqoH/V2+0FuMUvNVZsRMvn67HF0OB8exABPzj9kTrMGuYwvYWsHNJdt nA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3836fcqekv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 14:02:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5FD7A10002A;
        Fri, 23 Apr 2021 14:02:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3E926229DBC;
        Fri, 23 Apr 2021 14:02:40 +0200 (CEST)
Received: from [10.48.0.224] (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 14:02:39 +0200
Subject: Re: [Linux-stm32] [PATCH 1/2] memory: stm32-fmc2-ebi: add missing
 of_node_put for loop iteration
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210423101815.119341-1-krzysztof.kozlowski@canonical.com>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
Message-ID: <86a216db-b9b7-da45-ab74-a32538da6e00@foss.st.com>
Date:   Fri, 23 Apr 2021 14:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210423101815.119341-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_04:2021-04-23,2021-04-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 4/23/21 12:18 PM, Krzysztof Kozlowski wrote:
> Early exits from for_each_available_child_of_node() should decrement the
> node reference counter.  Reported by Coccinelle:
> 
>    drivers/memory/stm32-fmc2-ebi.c:1046:1-33: WARNING:
>      Function "for_each_available_child_of_node" should have of_node_put() before return around line 1051.
> 
> Fixes: 66b8173a197f ("memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   drivers/memory/stm32-fmc2-ebi.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
> index 4d5758c419c5..ffec26a99313 100644
> --- a/drivers/memory/stm32-fmc2-ebi.c
> +++ b/drivers/memory/stm32-fmc2-ebi.c
> @@ -1048,16 +1048,19 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
>   		if (ret) {
>   			dev_err(dev, "could not retrieve reg property: %d\n",
>   				ret);
> +			of_node_put(child);
>   			return ret;
>   		}
>   
>   		if (bank >= FMC2_MAX_BANKS) {
>   			dev_err(dev, "invalid reg value: %d\n", bank);
> +			of_node_put(child);
>   			return -EINVAL;
>   		}
>   
>   		if (ebi->bank_assigned & BIT(bank)) {
>   			dev_err(dev, "bank already assigned: %d\n", bank);
> +			of_node_put(child);
>   			return -EINVAL;
>   		}
>   
> @@ -1066,6 +1069,7 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
>   			if (ret) {
>   				dev_err(dev, "setup chip select %d failed: %d\n",
>   					bank, ret);
> +				of_node_put(child);
>   				return ret;
>   			}
>   		}
>

Reviewed-by: Christophe Kerello <christophe.kerello@foss.st.com>

Regards,
Christophe Kerello.

