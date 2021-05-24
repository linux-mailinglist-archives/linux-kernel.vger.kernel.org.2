Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD038DEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 03:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhEXBfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 21:35:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5524 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhEXBfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 21:35:14 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpKRN1nYPzkYQT;
        Mon, 24 May 2021 09:30:56 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 09:33:43 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 09:33:42 +0800
Subject: Re: [PATCH -next] ARM: imx: add missing clk_disable_unprepare() in
 imx_mmdc_remove()
To:     Shawn Guo <shawnguo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
References: <20210517111523.477889-1-yangyingliang@huawei.com>
 <20210523051145.GW8194@dragon>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <ed677e7a-66aa-03f0-a2bd-c5f46bf06461@huawei.com>
Date:   Mon, 24 May 2021 09:33:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210523051145.GW8194@dragon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/23 13:11, Shawn Guo wrote:
> On Mon, May 17, 2021 at 07:15:23PM +0800, Yang Yingliang wrote:
>> clock source is prepared and enabled by clk_prepare_enable()
>> in probe function, but no disable or unprepare in remove.
>>
>> Fixes: 9454a0caff6a ("ARM: imx: add mmdc ipg clock operation for mmdc")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   arch/arm/mach-imx/mmdc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
>> index 0dfd0ae7a63d..7d87fa8c70a9 100644
>> --- a/arch/arm/mach-imx/mmdc.c
>> +++ b/arch/arm/mach-imx/mmdc.c
>> @@ -77,6 +77,7 @@ static const struct of_device_id imx_mmdc_dt_ids[] = {
>>   	{ /* sentinel */ }
>>   };
>>   
>> +struct clk *mmdc_ipg_clk;
> Missing static.  But an even better change should be putting it into
> struct mmdc_pmu, I guess.

OK, I will send a v2 later.

Thanks,

Yang

>
> Shawn
>
>>   #ifdef CONFIG_PERF_EVENTS
>>   
>>   static enum cpuhp_state cpuhp_mmdc_state;
>> @@ -463,6 +464,7 @@ static int imx_mmdc_remove(struct platform_device *pdev)
>>   	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
>>   	perf_pmu_unregister(&pmu_mmdc->pmu);
>>   	kfree(pmu_mmdc);
>> +	clk_disable_unprepare(mmdc_ipg_clk);
>>   	return 0;
>>   }
>>   
>> @@ -536,7 +538,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *np = pdev->dev.of_node;
>>   	void __iomem *mmdc_base, *reg;
>> -	struct clk *mmdc_ipg_clk;
>>   	u32 val;
>>   	int err;
>>   
>> -- 
>> 2.25.1
>>
> .
