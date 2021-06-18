Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5233F3ACB14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhFRMh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:37:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8278 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFRMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:37:26 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5ytV5r8dz1BNvZ;
        Fri, 18 Jun 2021 20:30:10 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 20:35:14 +0800
Received: from [10.174.178.208] (10.174.178.208) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 20:35:14 +0800
Subject: Re: [PATCH -next] mtd: rawnand: arasan: Fix missing
 clk_disable_unprepare() on error in anfc_probe()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <nagasure@xilinx.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1623816404-66213-1-git-send-email-zou_wei@huawei.com>
 <20210618092752.5f117365@xps13>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <be3b786d-dc6e-90b5-9bc6-05d078b21c40@huawei.com>
Date:   Fri, 18 Jun 2021 20:35:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210618092752.5f117365@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

Thanks for your review, and it's OK include the goto change.

On 2021/6/18 15:27, Miquel Raynal wrote:
> Hi Zou,
> 
> Zou Wei <zou_wei@huawei.com> wrote on Wed, 16 Jun 2021 12:06:44 +0800:
> 
>> Fix the missing clk_disable_unprepare() before return
>> from anfc_probe() in the error handling case.
>>
>> Fixes: 61622f6791a1 ("mtd: rawnand: arasan: Use the right DMA mask")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> 
> Thanks for the patch, 61622f6791a1 being problematic because of the
> mask not being correctly declared I prefer to fix this patch inline and
> if you don't mind I'll include the goto change as well.
> 
>> ---
>>   drivers/mtd/nand/raw/arasan-nand-controller.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
>> index 8317d97..9cbcc69 100644
>> --- a/drivers/mtd/nand/raw/arasan-nand-controller.c
>> +++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
>> @@ -1452,7 +1452,7 @@ static int anfc_probe(struct platform_device *pdev)
>>   
>>   	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>>   	if (ret)
>> -		return ret;
>> +		goto disable_bus_clk;
>>   
>>   	ret = anfc_parse_cs(nfc);
>>   	if (ret)
> 
> Thanks,
> Miquèl
> .
> 
