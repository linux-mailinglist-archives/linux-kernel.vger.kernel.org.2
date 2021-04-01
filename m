Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C2F350CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhDACit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:38:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15127 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDACii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:38:38 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9nPV3Vl6z1BGFN;
        Thu,  1 Apr 2021 10:36:30 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.252) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 10:38:25 +0800
Subject: Re: [PATCH] phy: hisilicon: Use the correct HiSilicon copyright
To:     Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <1617086861-13900-1-git-send-email-fanghao11@huawei.com>
 <YGRrQV8VEp3rs19L@vkoul-mobl.Dlink>
CC:     <kishon@ti.com>, <xuejiancheng@huawei.com>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>
From:   "fanghao (A)" <fanghao11@huawei.com>
Message-ID: <8947f542-cf3e-1e72-1361-051921fa754b@huawei.com>
Date:   Thu, 1 Apr 2021 10:38:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YGRrQV8VEp3rs19L@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.252]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/31 20:29, Vinod Koul wrote:
> On 30-03-21, 14:47, Hao Fang wrote:
>> s/Hisilicon/HiSilicon/g.
>> It should use capital S,
>> according to https://www.hisilicon.com/en/terms-of-use.
>
> And I have not agreed to those terms of use! If you wish to change the
> name, please do send the patch dropping this terms of use link. I dont
> mind name appearing properly...
>

I put a link to show the correct example for copyright, maybe it makes a misunderstanding.
I will change it to "according to the official website", and send V2.

Thanks.

Hao

> Thanks
>>
>> Signed-off-by: Hao Fang <fanghao11@huawei.com>
>> ---
>>  drivers/phy/hisilicon/phy-hi6220-usb.c   | 2 +-
>>  drivers/phy/hisilicon/phy-hix5hd2-sata.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/hisilicon/phy-hi6220-usb.c b/drivers/phy/hisilicon/phy-hi6220-usb.c
>> index be05292..e92ba78 100644
>> --- a/drivers/phy/hisilicon/phy-hi6220-usb.c
>> +++ b/drivers/phy/hisilicon/phy-hi6220-usb.c
>> @@ -1,7 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * Copyright (c) 2015 Linaro Ltd.
>> - * Copyright (c) 2015 Hisilicon Limited.
>> + * Copyright (c) 2015 HiSilicon Limited.
>>   */
>>
>>  #include <linux/mfd/syscon.h>
>> diff --git a/drivers/phy/hisilicon/phy-hix5hd2-sata.c b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
>> index c67b78c..b0f99a9 100644
>> --- a/drivers/phy/hisilicon/phy-hix5hd2-sata.c
>> +++ b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
>> @@ -1,7 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * Copyright (c) 2014 Linaro Ltd.
>> - * Copyright (c) 2014 Hisilicon Limited.
>> + * Copyright (c) 2014 HiSilicon Limited.
>>   */
>>
>>  #include <linux/delay.h>
>> --
>> 2.8.1
>

