Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB24B3A8E66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFPBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:33:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4924 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhFPBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:33:45 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4SHx3sJvz70FQ;
        Wed, 16 Jun 2021 09:28:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:31:38 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 09:31:37 +0800
Subject: Re: [PATCH 1/3] mcb: Use DEFINE_RES_MEM() to simplify code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, Johannes Thumshirn <jth@kernel.org>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
 <1eefa01948355a890b18a68c1eb6a90dc9dc6a87.1623768541.git.johannes.thumshirn@wdc.com>
 <YMjKZhC0vHkikUQs@kroah.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <454b2783-8415-22f4-876a-156973480cd6@huawei.com>
Date:   Wed, 16 Jun 2021 09:31:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YMjKZhC0vHkikUQs@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/15 23:42, Greg Kroah-Hartman wrote:
> On Tue, Jun 15, 2021 at 11:55:28PM +0900, Johannes Thumshirn wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> The value of '.end' should be "start + size - 1". So the previous writing
>> should have omitted subtracted 1.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
>> ---
>>  drivers/mcb/mcb-lpc.c | 13 ++-----------
>>  1 file changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
>> index 506676754538..53decd89876e 100644
>> --- a/drivers/mcb/mcb-lpc.c
>> +++ b/drivers/mcb/mcb-lpc.c
>> @@ -105,17 +105,8 @@ static int mcb_lpc_create_platform_device(const struct dmi_system_id *id)
>>  	return ret;
>>  }
>>  
>> -static struct resource sc24_fpga_resource = {
>> -	.start = 0xe000e000,
>> -	.end = 0xe000e000 + CHAM_HEADER_SIZE,
>> -	.flags = IORESOURCE_MEM,
>> -};
>> -
>> -static struct resource sc31_fpga_resource = {
>> -	.start = 0xf000e000,
>> -	.end = 0xf000e000 + CHAM_HEADER_SIZE,
>> -	.flags = IORESOURCE_MEM,
>> -};
>> +static struct resource sc24_fpga_resource = DEFINE_RES_MEM(0xe000e000, CHAM_HEADER_SIZE);
>> +static struct resource sc31_fpga_resource = DEFINE_RES_MEM(0xf000e000, CHAM_HEADER_SIZE);
> 
> Does this simplify stuff, or does it fix a bug with the existing
> definition?

It does not fix a bug, the actual value of .end should be "0xe000e000 + CHAM_HEADER_SIZE - 1".
There is no functional problem, just a little more memory. So it's just been corrected in the
process of simplification.

Do you think it's necessary to split it into two patches?

> 
> Your changelog text says one thing, but your subject says the other...

Okay, I'll change the description. How about:
Use DEFINE_RES_MEM() to save a couple of lines of code, which makes the
code a bit shorter and easier to read. The start address does not need to
appear twice.

By the way, the value of '.end' should be "start + size - 1". So the
previous writing should have omitted subtracted 1.

> 
> thanks,
> 
> greg k-h
> 
> .
> 

