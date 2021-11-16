Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D811453405
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhKPOYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:24:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4100 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbhKPOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:24:14 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Htp6h1wrjz67ybx;
        Tue, 16 Nov 2021 22:17:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 15:21:14 +0100
Received: from [10.47.82.31] (10.47.82.31) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 16 Nov
 2021 14:21:13 +0000
Subject: Re: [PATCH 0/5] iommu: Some IOVA code reorganisation
To:     Will Deacon <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xieyongji@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <20211004114418.GC27373@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cdb502c5-4896-385b-8872-f4f20e9c7e34@huawei.com>
Date:   Tue, 16 Nov 2021 14:21:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004114418.GC27373@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.31]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 12:44, Will Deacon wrote:
> On Fri, Sep 24, 2021 at 06:01:52PM +0800, John Garry wrote:
>> The IOVA domain structure is a bit overloaded, holding:
>> - IOVA tree management
>> - FQ control
>> - IOVA rcache memories
>>
>> Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
>> uses the FQ feature.
>>
>> This series separates out that structure. In addition, it moves the FQ
>> code into dma-iommu.c . This is not strictly necessary, but it does make
>> it easier for the FQ domain lookup the rcache domain.
>>
>> The rcache code stays where it is, as it may be reworked in future, so
>> there is not much point in relocating and then discarding.
>>
>> This topic was initially discussed and suggested (I think) by Robin here:
>> https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/
> It would be useful to have Robin's Ack on patches 2-4. The implementation
> looks straightforward to me, but the thread above isn't very clear about
> what is being suggested.

Hi Robin,

Just wondering if you had made any progress on your FQ code rework or 
your own re-org?

I wasn't planning on progressing 
https://lore.kernel.org/linux-iommu/1626259003-201303-1-git-send-email-john.garry@huawei.com/ 
until this is done first (and that is still a big issue), even though 
not strictly necessary.

Thanks,
John
