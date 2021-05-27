Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F8D39301B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhE0Nvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:51:39 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2374 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhE0Nvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:51:37 -0400
Received: from dggeml710-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FrTcZ4xJFz66BM;
        Thu, 27 May 2021 21:46:22 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggeml710-chm.china.huawei.com (10.3.17.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 21:50:00 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 21:49:54 +0800
Subject: Re: [PATCH -next] i3c: master: svc: drop free_irq of devm_request_irq
 allocated irq
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
References: <20210518131127.1308550-1-yangyingliang@huawei.com>
 <20210527120123.75f2ea09@xps13>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <7052d19a-54cb-d634-f195-dbd8ef37f1e7@huawei.com>
Date:   Thu, 27 May 2021 21:49:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210527120123.75f2ea09@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/5/27 18:01, Miquel Raynal wrote:
> Hi Yang,
>
> Yang Yingliang <yangyingliang@huawei.com> wrote on Tue, 18 May 2021
> 21:11:27 +0800:
>
>> irq allocated with devm_request_irq should not be freed using
>> free_irq, because doing so causes a dangling pointer, and a
>> subsequent double free.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/i3c/master/svc-i3c-master.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
>> index 1f6ba4221817..761c9c468357 100644
>> --- a/drivers/i3c/master/svc-i3c-master.c
>> +++ b/drivers/i3c/master/svc-i3c-master.c
>> @@ -1448,7 +1448,7 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	free_irq(master->irq, master);
>> +	devm_free_irq(&pdev->dev, master->irq, master);
> Wouldn't removing this call the right solution? If it's a device
> managed resource, it won't probably be needed to free it explicitly in
> the remove path.
Some drivers would expect to free irq itself, I am not sure if it's ok 
to remove
the free_irq() in i3c, I just keep the original logic here and avoid 
double free.

Thanks,
Yang
>
>>   	clk_disable_unprepare(master->pclk);
>>   	clk_disable_unprepare(master->fclk);
>>   	clk_disable_unprepare(master->sclk);
> Thanks,
> Miquèl
> .
