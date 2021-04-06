Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14A354EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhDFIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:32:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2761 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhDFIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:32:27 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF0xt062Gz687Z7;
        Tue,  6 Apr 2021 16:27:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:32:18 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 09:32:17 +0100
Subject: Re: [PATCH v2 0/4] iommu/iova: Add CPU hotplug handler to flush
 rcaches to core code
To:     Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
 <20210325175354.GE15504@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9aad6e94-ecb7-ca34-7f7d-3df6e43e9c42@huawei.com>
Date:   Tue, 6 Apr 2021 09:29:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210325175354.GE15504@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.136]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2021 17:53, Will Deacon wrote:
> On Thu, Mar 25, 2021 at 08:29:57PM +0800, John Garry wrote:
>> The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
>> offlined.
>>
>> Let's move it to core code, so everyone can take advantage.
>>
>> Also throw in a patch to stop exporting free_iova_fast().
>>
>> Differences to v1:
>> - Add RB tags (thanks!)
>> - Add patch to stop exporting free_iova_fast()
>> - Drop patch to correct comment
>> - Add patch to delete iommu_dma_free_cpu_cached_iovas() and associated
>>    changes
>>
>> John Garry (4):
>>    iova: Add CPU hotplug handler to flush rcaches
>>    iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>>    iommu: Delete iommu_dma_free_cpu_cached_iovas()
>>    iommu: Stop exporting free_iova_fast()
> Looks like this is all set for 5.13, so hopefully Joerg can stick it in
> -next for a bit more exposure.
> 


Hi Joerg,

Can you kindly consider picking this up now?

Thanks,
John

