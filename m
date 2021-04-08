Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2163584A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhDHN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:26:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15628 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhDHN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:26:29 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGMQp1WjJzpWXF;
        Thu,  8 Apr 2021 21:23:30 +0800 (CST)
Received: from [10.174.179.129] (10.174.179.129) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 21:26:10 +0800
Subject: Re: [PATCH 3/3] mtd: phram: Fix error return code in phram_setup()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <joern@lazybastard.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <matthias.bgg@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yi.zhang@huawei.com>
References: <20210408111514.1011020-1-yukuai3@huawei.com>
 <20210408111514.1011020-4-yukuai3@huawei.com> <20210408144610.0c0686ae@xps13>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <cc02de9c-6315-3fa6-4b0a-4287b2713484@huawei.com>
Date:   Thu, 8 Apr 2021 21:26:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210408144610.0c0686ae@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/08 20:46, Miquel Raynal wrote:
> Hi Yu,
> 
> Yu Kuai <yukuai3@huawei.com> wrote on Thu, 8 Apr 2021 19:15:14 +0800:
> 
>> Fix to return a negative error code from the error handling
>> case instead of 0, as done elsewhere in this function.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/mtd/devices/phram.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
>> index 5b04ae6c3057..6ed6c51fac69 100644
>> --- a/drivers/mtd/devices/phram.c
>> +++ b/drivers/mtd/devices/phram.c
>> @@ -270,6 +270,7 @@ static int phram_setup(const char *val)
>>   	if (len == 0 || erasesize == 0 || erasesize > len
>>   	    || erasesize > UINT_MAX || rem) {
>>   		parse_err("illegal erasesize or len\n");
>> +		ret = -EINVAL;
>>   		goto error;
>>   	}
>>   
> 
> It looks like you're doing the opposite of what you say.
> 
Hi,

sorry about that, I misunderstood 'fix to'.

Thanks
Yu Kuai
> Thanks,
> Miquèl
> .
> 
