Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C420356622
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbhDGILT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:11:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2780 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbhDGILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:11:13 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFcQr3sX9z687ng;
        Wed,  7 Apr 2021 16:05:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 10:11:02 +0200
Received: from [10.210.168.126] (10.210.168.126) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 09:11:01 +0100
Subject: Re: [PATCH 0/3] iommu/iova: Add CPU hotplug handler to flush rcaches
 to core code
To:     Joerg Roedel <joro@8bytes.org>
CC:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <robin.murphy@arm.com>
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
 <YG1noCU6pFQRC+yF@8bytes.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ed59d02d-e3dc-21dc-bc82-199988700d31@huawei.com>
Date:   Wed, 7 Apr 2021 09:08:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YG1noCU6pFQRC+yF@8bytes.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.126]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2021 09:04, Joerg Roedel wrote:
> On Mon, Mar 01, 2021 at 08:12:18PM +0800, John Garry wrote:
>> The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
>> offlined.
>>
>> Let's move it to core code, so everyone can take advantage.
>>
>> Also correct a code comment.
>>
>> Based on v5.12-rc1. Tested on arm64 only.
>>
>> John Garry (3):
>>    iova: Add CPU hotplug handler to flush rcaches
>>    iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>>    iova: Correct comment for free_cpu_cached_iovas()
>>
>>   drivers/iommu/intel/iommu.c | 31 -------------------------------
>>   drivers/iommu/iova.c        | 32 ++++++++++++++++++++++++++++++--
>>   include/linux/cpuhotplug.h  |  2 +-
>>   include/linux/iova.h        |  1 +
>>   4 files changed, 32 insertions(+), 34 deletions(-)
> 
> Applied, thanks.
> 
> .
> 

Thanks, but there was a v2 on this series. Not sure which you applied.

https://lore.kernel.org/linux-iommu/9aad6e94-ecb7-ca34-7f7d-3df6e43e9c42@huawei.com/T/#mbea81468782c75fa84744ad7a7801831a4c952e9

