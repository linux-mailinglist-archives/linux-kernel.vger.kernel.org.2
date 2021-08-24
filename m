Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2803F5922
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhHXHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:40:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14315 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhHXHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:40:36 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gv1GJ17D1z89RY;
        Tue, 24 Aug 2021 15:39:36 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 15:39:48 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 15:39:48 +0800
Subject: Re: [PATCH -next] soc: aspeed-lpc-ctrl: Fix missing
 clk_disable_unprepare() on error in aspeed_lpc_ctrl_probe()
To:     Joel Stanley <joel@jms.id.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>
References: <20210823130043.1087204-1-yangyingliang@huawei.com>
 <CACPK8XeUJV2cCaCu+xnX-pGkHVxV9vp3LPj8dJbJbi8SC4Bazw@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <7ee18b90-f877-15cd-e8aa-c8024847f924@huawei.com>
Date:   Tue, 24 Aug 2021 15:39:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XeUJV2cCaCu+xnX-pGkHVxV9vp3LPj8dJbJbi8SC4Bazw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/8/24 12:52, Joel Stanley wrote:
> On Mon, 23 Aug 2021 at 12:55, Yang Yingliang <yangyingliang@huawei.com> wrote:
>> Fix the missing clk_disable_unprepare() before return
>> from aspeed_lpc_ctrl_probe() in the error handling case.
>>
>> Fixes: 2f9b25fa6682 ("soc: aspeed: Re-enable FWH2AHB on AST2600")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/soc/aspeed/aspeed-lpc-ctrl.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
>> index 6893c5ec3259..f4c989584d6b 100644
>> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
>> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
>> @@ -312,7 +312,8 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>>                  lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
>>                  if (IS_ERR(lpc_ctrl->scu)) {
>>                          dev_err(dev, "couldn't find scu\n");
>> -                       return PTR_ERR(lpc_ctrl->scu);
>> +                       rc = PTR_ERR(lpc_ctrl->scu);
>> +                       goto err;
> Thanks for the patch. Alternatively, we could move this code above the
> devm_clk_get/clk_prepare_enable. I would prefer that option, if you
> want to send a v2.
I can send a v2.

Thanks,
Yang
>
> Cheers,
>
> Joel
> .
