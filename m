Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31196393B21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 03:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhE1Bpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:45:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5119 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhE1Bpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:45:35 -0400
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrnTW2h19zYnQX;
        Fri, 28 May 2021 09:41:19 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggeml756-chm.china.huawei.com (10.1.199.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 09:43:59 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:43:59 +0800
Subject: Re: [PATCH -next] i3c: master: svc: drop free_irq of devm_request_irq
 allocated irq
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
References: <20210518131127.1308550-1-yangyingliang@huawei.com>
 <20210527120123.75f2ea09@xps13>
 <7052d19a-54cb-d634-f195-dbd8ef37f1e7@huawei.com>
 <20210527164058.3c9145b2@xps13>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <7912f44a-39ea-928c-8b51-6b8967588abd@huawei.com>
Date:   Fri, 28 May 2021 09:43:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210527164058.3c9145b2@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/27 22:40, Miquel Raynal wrote:
> Hi Yang,
>
> Yang Yingliang <yangyingliang@huawei.com> wrote on Thu, 27 May 2021
> 21:49:53 +0800:
>
>> Hi,
>>
>> On 2021/5/27 18:01, Miquel Raynal wrote:
>>> Hi Yang,
>>>
>>> Yang Yingliang <yangyingliang@huawei.com> wrote on Tue, 18 May 2021
>>> 21:11:27 +0800:
>>>   
>>>> irq allocated with devm_request_irq should not be freed using
>>>> free_irq, because doing so causes a dangling pointer, and a
>>>> subsequent double free.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>> ---
>>>>    drivers/i3c/master/svc-i3c-master.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
>>>> index 1f6ba4221817..761c9c468357 100644
>>>> --- a/drivers/i3c/master/svc-i3c-master.c
>>>> +++ b/drivers/i3c/master/svc-i3c-master.c
>>>> @@ -1448,7 +1448,7 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
>>>>    	if (ret)
>>>>    		return ret;
>>>>    >> -	free_irq(master->irq, master);
>>>> +	devm_free_irq(&pdev->dev, master->irq, master);
>>> Wouldn't removing this call the right solution? If it's a device
>>> managed resource, it won't probably be needed to free it explicitly in
>>> the remove path.
>> Some drivers would expect to free irq itself,
> I don't get it. Drivers do not expect anything, they should just comply
> with the API. If robots complain because a device managed resource is
> being freed without the device managed helper, this does not mean that
> the resource should explicitly be freed, it just means that *if* it
> must be explicitly freed, the wrong helper is being used.
>
>> I am not sure if it's ok to remove the free_irq() in i3c,
> What is the link with I3C? Sorry I might be missing something but
> master->irq is a driver variable, I don't get the link with the I3C
> framework and why it would interfere.
>
>> I just keep the original logic here and avoid double free.
> I don't think it is sane. Calling devm_free_irq() maybe is the right
> solution - I don't feel like it is - but your certainly can't hide
> behind a 'I just want the robots to be happy' justification. Hiding
> bugs on purpose is not something that I personally appreciate much.
Freeing irq in ->remove() is earlier than in device manage framework, if
just remove the free_irq() in svc_i3c_master_remove() and free the irq by
device manage framework, I am not sure if it breaks the resource free
sequence in Silvaco I3C master driver. If it's OK, I can resend a patch with
removing the free_irq().

Thanks,
Yang
>
> Thanks,
> Miquèl
> .
