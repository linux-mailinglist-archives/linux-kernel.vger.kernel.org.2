Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2454438E569
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhEXL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:27:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3643 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhEXL07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:26:59 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZYH2MGTzNytN;
        Mon, 24 May 2021 19:21:55 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:25:25 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 19:25:25 +0800
Subject: Re: [PATCH -next] mm/dmapool: use DEVICE_ATTR_RO macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210523064626.41532-1-yuehaibing@huawei.com>
 <YKuD4rturdqC6oZF@smile.fi.intel.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3c79a2e6-4560-b417-9a11-b5baa5f28a25@huawei.com>
Date:   Mon, 24 May 2021 19:25:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YKuD4rturdqC6oZF@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/24 18:45, Andy Shevchenko wrote:
> On Sun, May 23, 2021 at 02:46:26PM +0800, YueHaibing wrote:
>> Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
>> which makes the code a bit shorter and easier to read.
> 
> DEVICE_ATTR_RO()
> DEVICE_ATTR()
> 
> After addressing above and below,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Ok, will send v2.
> 
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  mm/dmapool.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/dmapool.c b/mm/dmapool.c
>> index 16483f86360e..62083ef04878 100644
>> --- a/mm/dmapool.c
>> +++ b/mm/dmapool.c
>> @@ -62,8 +62,8 @@ struct dma_page {		/* cacheable header for 'allocation' bytes */
>>  static DEFINE_MUTEX(pools_lock);
>>  static DEFINE_MUTEX(pools_reg_lock);
>>  
>> -static ssize_t
>> -show_pools(struct device *dev, struct device_attribute *attr, char *buf)
>> +static ssize_t pools_show(struct device *dev,
>> +			  struct device_attribute *attr, char *buf)
>>  {
>>  	unsigned temp;
>>  	unsigned size;
> 
> Unrelated change.

There change show_pools() to pools_show()

> 
>> @@ -103,7 +103,7 @@ show_pools(struct device *dev, struct device_attribute *attr, char *buf)
>>  	return PAGE_SIZE - size;
>>  }
>>  
>> -static DEVICE_ATTR(pools, 0444, show_pools, NULL);
>> +static DEVICE_ATTR_RO(pools);
>>  
>>  /**
>>   * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
>> -- 
>> 2.17.1
>>
> 
