Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E6397732
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhFAPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:53:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3120 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFAPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:53:14 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fvc195RKCz6Q3Df;
        Tue,  1 Jun 2021 23:45:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:51:31 +0200
Received: from [10.47.91.52] (10.47.91.52) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:51:30 +0100
Subject: Re: [PATCH] iommu: Print default strict or lazy mode at init time
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>
References: <1622209074-37899-1-git-send-email-john.garry@huawei.com>
 <3ee986a0-29c1-100c-c72f-360f919caf7d@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e478aea8-54d3-bfc6-1bc8-b0c7709e353a@huawei.com>
Date:   Tue, 1 Jun 2021 16:50:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3ee986a0-29c1-100c-c72f-360f919caf7d@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.91.52]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2021 10:09, Robin Murphy wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 808ab70d5df5..f25fae62f077 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -138,6 +138,11 @@ static int __init iommu_subsys_init(void)
>>           (iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
>>               "(set via kernel command line)" : "");
>> +    pr_info("Default DMA domain mode: %s %s\n",
> 
> Nit: I think this might be a little unclear for end-users - *I'm* not 
> even sure whether "Default" here is meant to refer to the mode setting 
> itself or to default domains (of DMA type). Maybe something like "DMA 
> domain TLB invalidation policy"? Certainly it seems like a good idea to 
> explicitly mention invalidation to correlate with the documentation of 
> the "iommu.strict" parameter.
> 
> Ack to the general idea though.

ok, so I'll go with this:

pr_info("DMA domain default TLB invalidation policy: %s mode %s\n",
               iommu_dma_strict ? "strict" : "lazy",
                (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
                        "(set via kernel command line)" : "");

I think it's worth mentioning "default" somewhere, as not all IOMMUs or 
devices will use lazy mode even if it's default.

Thanks,
John
