Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDB3A5DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhFNHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:54:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3226 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhFNHyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:54:39 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3Nm307LTz6F9F6;
        Mon, 14 Jun 2021 15:45:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 09:52:34 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 08:52:33 +0100
Subject: Re: [PATCH v12 5/5] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-6-git-send-email-john.garry@huawei.com>
 <1b58516d-73d5-0c40-11de-58b998ec803e@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3b1c277e-fd8a-64d7-4fcb-1a4d64fbcfd4@huawei.com>
Date:   Mon, 14 Jun 2021 08:46:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1b58516d-73d5-0c40-11de-58b998ec803e@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2021 03:23, Lu Baolu wrote:
> On 2021/6/11 20:20, John Garry wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index ccbd5d4c1a50..146cb71c7441 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -350,10 +350,9 @@ static int __init iommu_dma_setup(char *str)
>>   }
>>   early_param("iommu.strict", iommu_dma_setup);
>> -void iommu_set_dma_strict(bool strict)
>> +void iommu_set_dma_strict(void)
>>   {
>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>> -        iommu_dma_strict = strict;
>> +        iommu_dma_strict = true;
>>   }
> 
> Will this change break the functionality of iommu.strict?
> 

No, iommu_dma_strict is written directly in iommu_dma_setup() for 
iommu.strict cmdline processing.

Here I'm just saying that anyone that who uses iommu_set_dma_strict(bool 
strict) always passes true, so I just remove that argument and simplify 
that function.

Thanks,
John

