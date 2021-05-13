Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEEE37F15D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhEMCgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:36:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2647 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhEMCgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:36:21 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgbJg4HY1zQmMF
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:31:47 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.252) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 10:35:01 +0800
Subject: Re: [PATCH] reset: hi6220: Use the correct HiSilicon copyright
To:     Philipp Zabel <p.zabel@pengutronix.de>
References: <1617087044-19572-1-git-send-email-fanghao11@huawei.com>
 <9094d229c86bd55395ad9b01ae8f5432bb80fd35.camel@pengutronix.de>
CC:     <puck.chen@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <prime.zeng@hisilicon.com>
From:   "fanghao (A)" <fanghao11@huawei.com>
Message-ID: <a54e7ec4-7b20-0adb-151f-6e943c61d9e3@huawei.com>
Date:   Thu, 13 May 2021 10:35:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <9094d229c86bd55395ad9b01ae8f5432bb80fd35.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/12 14:19, Philipp Zabel wrote:
> On Tue, 2021-03-30 at 14:50 +0800, Hao Fang wrote:
>> s/Hisilicon/HiSilicon/g.
>> It should use capital S, according to
>> https://www.hisilicon.com/en/terms-of-use.
>>
>> Signed-off-by: Hao Fang <fanghao11@huawei.com>
>> ---
>>  drivers/reset/hisilicon/hi6220_reset.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
>> index 1992650..5ca145b 100644
>> --- a/drivers/reset/hisilicon/hi6220_reset.c
>> +++ b/drivers/reset/hisilicon/hi6220_reset.c
>> @@ -3,7 +3,7 @@
>>   * Hisilicon Hi6220 reset controller driver
>
> Why leave this "Hisilicon" alone?

HiSilicon has applied for two trademarks Hisilicon/HiSilicon, so I think this one is OK. But there is only one English name for the company,
We have consulted with company's lawyer who suggested that should use a copyright statement consistent with the official website.

>
>>   *
>>   * Copyright (c) 2016 Linaro Limited.
>> - * Copyright (c) 2015-2016 Hisilicon Limited.
>> + * Copyright (c) 2015-2016 HiSilicon Limited.
>>   *
>>   * Author: Feng Chen <puck.chen@hisilicon.com>
>>   */
>
> That will be a lot of churn:
>
>   git grep Copyright.*Hisilicon | wc -l
>   141
>
>   git grep Hisilicon | wc -l
>   371

As mentioned above, I am focused on correcting the copyright.
5.13-rc1 has been released and I will continue to clean the rest by make one patch per subsystem.

Should I resend this based on 5.13-rc1?

>
> Could I get an Acked-by from someone at HiSilicon for this?

Maybe I could remind the author.

>
> regards
> Philipp
>
> .
>

Thank,
Hao

