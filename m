Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204EF3460C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhCWN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:59:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2732 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhCWN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:59:20 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F4Xqz3cftz682Vk;
        Tue, 23 Mar 2021 21:52:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 14:59:14 +0100
Received: from [10.47.11.95] (10.47.11.95) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 13:59:13 +0000
Subject: Re: [PATCH 3/3] iova: Correct comment for free_cpu_cached_iovas()
To:     Robin Murphy <robin.murphy@arm.com>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
 <1614600741-15696-4-git-send-email-john.garry@huawei.com>
 <87b4af01-2352-e963-824f-1cea1a6ee718@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cb4547e8-bab4-bea5-e9c2-18884e3e5e12@huawei.com>
Date:   Tue, 23 Mar 2021 13:56:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87b4af01-2352-e963-824f-1cea1a6ee718@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.11.95]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 13:05, Robin Murphy wrote:
> On 2021-03-01 12:12, John Garry wrote:
>> Function free_cpu_cached_iovas() is not only called when a CPU is
>> hotplugged, so remove that part of the code comment.
> 
> FWIW I read it as clarifying why this is broken out into a separate 
> function vs. a monolithic "free all cached IOVAs" routine that handles 
> both the per-cpu and global caches 

> it never said "*only* used..."

It seems to be implying that.

It's only a code comment, so I don't care too much either way and can 
drop this change.

> 
> As such I'd hesitate to call it incorrect, but it's certainly arguable 
> whether it needs to be stated or not, especially once the hotplug 
> callsite is now obvious in the same file - on which note the function 
> itself also shouldn't need to be public any more, no?
> 

Right, I actually missed deleting iommu_dma_free_cpu_cached_iovas(), so 
can fix that now.

Cheers,
John

> Robin.
> 
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/iova.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index c78312560425..465b3b0eeeb0 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -996,7 +996,7 @@ static void free_iova_rcaches(struct iova_domain 
>> *iovad)
>>   }
>>   /*
>> - * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
>> + * free all the IOVA ranges cached by a cpu
>>    */
>>   void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>>   {
>>
> .

