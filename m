Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E73365315
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhDTHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:19:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16141 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhDTHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:19:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPZjY5HcwzpZCx;
        Tue, 20 Apr 2021 15:16:17 +0800 (CST)
Received: from [10.174.178.100] (10.174.178.100) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 15:19:15 +0800
Subject: Re: [PATCH -next] tools/testing/nvdimm: Make symbol
 '__nfit_test_ioremap' static
To:     Santosh Sivaraj <santosh@fossix.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>
References: <1617779451-81730-1-git-send-email-zou_wei@huawei.com>
 <87h7k1zco0.fsf@fossix.org>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <066633f6-e624-54ef-0de0-5589305fdbe3@huawei.com>
Date:   Tue, 20 Apr 2021 15:19:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87h7k1zco0.fsf@fossix.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.100]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

Thanks for your review, and sorry for my mistake. I will send the v2 soon.

On 2021/4/20 14:35, Santosh Sivaraj wrote:
> 
> Hi Zou,
> 
> Zou Wei <zou_wei@huawei.com> writes:
> 
>> The sparse tool complains as follows:
>>
>> tools/testing/nvdimm/test/iomap.c:65:14: warning:
>>   symbol '__nfit_test_ioremap' was not declared. Should it be static?
>>
>> This symbol is not used outside of security.c, so this
> 
> s/security.c/iomap.c/
> 
> Thanks,
> Santosh
> 
>> commit marks it static.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>> ---
>>   tools/testing/nvdimm/test/iomap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
>> index c62d372..ed563bd 100644
>> --- a/tools/testing/nvdimm/test/iomap.c
>> +++ b/tools/testing/nvdimm/test/iomap.c
>> @@ -62,7 +62,7 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
>>   }
>>   EXPORT_SYMBOL(get_nfit_res);
>>   
>> -void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
>> +static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
>>   		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
>>   {
>>   	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
>> -- 
>> 2.6.2
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> .
> 
