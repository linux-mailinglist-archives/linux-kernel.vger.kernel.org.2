Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2798231E9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhBRMS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:18:57 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51251 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhBRKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:52:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UOtYqqH_1613645468;
Received: from B-J2UMLVDL-1650.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0UOtYqqH_1613645468)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Feb 2021 18:51:09 +0800
Subject: Re: [PATCH] misc/pvpanic: Export module FDT device table
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20210218094024.69354-1-shile.zhang@linux.alibaba.com>
 <YC46tZLAesfSNg40@kroah.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <9dc35ee1-cf67-e434-c641-d2822ad0f6a7@linux.alibaba.com>
Date:   Thu, 18 Feb 2021 18:51:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YC46tZLAesfSNg40@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/18 18:00, Greg Kroah-Hartman wrote:
> On Thu, Feb 18, 2021 at 05:40:24PM +0800, Shile Zhang wrote:
>> Export the module FDT device table to ensure the FDT compatible strings
>> are listed in the module alias. This help the pvpanic driver can be
>> loaded on boot automatically not only the ACPI device, but also the FDT
>> device.
>>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> ---
>>   drivers/misc/pvpanic.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
>> index 41cab297d66e..2356d621967e 100644
>> --- a/drivers/misc/pvpanic.c
>> +++ b/drivers/misc/pvpanic.c
>> @@ -92,6 +92,7 @@ static const struct of_device_id pvpanic_mmio_match[] = {
>>   	{ .compatible = "qemu,pvpanic-mmio", },
>>   	{}
>>   };
>> +MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
> 
> What caused this to not work properly?  I.e. should there be a "Fixes:"
> tag in the commit changelog as well?

Sorry, I think it should be:

Fixes: 46f934c9a12fc ("misc/pvpanic: add support to get pvpanic device 
info FDT")

Shall I sent v2 with this update?

Thanks!

> 
> thanks,
> 
> greg k-h
> 
