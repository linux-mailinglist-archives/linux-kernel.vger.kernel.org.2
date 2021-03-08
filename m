Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC6331178
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhCHO4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:56:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2654 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhCHO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:56:16 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvLs253wrz67wtT;
        Mon,  8 Mar 2021 22:51:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 15:56:11 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 14:56:10 +0000
Subject: Re: [PATCH] iommu/dma: Resurrect the "forcedac" option
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <murphyt7@tcd.ie>,
        <thunder.leizhen@huawei.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <7eece8e0ea7bfbe2cd0e30789e0d46df573af9b0.1614961776.git.robin.murphy@arm.com>
 <76a931ab-fd2a-284e-61ef-9e26bceb4890@huawei.com>
 <3b1d1dea-ebba-f811-06af-d26a8061d678@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1f7198b6-bbed-1494-19ee-3453217d12a6@huawei.com>
Date:   Mon, 8 Mar 2021 14:54:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3b1d1dea-ebba-f811-06af-d26a8061d678@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.214]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 13:08, Robin Murphy wrote:
> On 2021-03-05 17:41, John Garry wrote:
>> On 05/03/2021 16:32, Robin Murphy wrote:
>>> In converting intel-iommu over to the common IOMMU DMA ops, it quietly
>>> lost the functionality of its "forcedac" option. Since this is a handy
>>> thing both for testing and for performance optimisation on certain
>>> platforms, reimplement it under the common IOMMU parameter namespace.
>>>
>>> For the sake of fixing the inadvertent breakage of the Intel-specific
>>> parameter, remove the dmar_forcedac remnants and hook it up as an alias
>>> while documenting the transition to the new common parameter.
>>>
>>
>> Do you think that having a kconfig option to control the default for 
>> this can help identify the broken platforms which rely on forcedac=0? 
>> But seems a bit trivial for that, though.
> 
> I think it's still a sizeable can of worms - unlike, say, 
> ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT, we can't actually tell when things 
> have gone awry and explicitly call it out. While I was getting the 
> dma-ranges right on my Juno, everything broke differently - the SATA 
> controller fails gracefully; the ethernet controller got the kernel tied 
> up somewhere (to the point that the USB keyboard died) once it tried to 
> brink up the link, but was at least spewing regular timeout backtraces 
> that implicated the networking layer; having an (unused) NVMe plugged in 
> simply wedged the boot process early on with no hint whatsoever of why.
> 
> TBH I'm not really sure what the best way forward is in terms of trying 
> to weed out platforms that would need quirking.

I was more thinking of an unstable TEST config, like 
DEBUG_TEST_DRIVER_REMOVE. So we know that this particular config breaks 
many platforms. But at least those in the know can turn it on locally 
and detect and fix issues, and strive towards having a platform for 
which it works.

But then it does become a little harder to justify such a config when we 
can enable via commadline.

> Our discussion just 
> reminded me of this option and that it had gone AWOL, so bringing it 
> back to be potentially *some* use to everyone seems justifiable on its own.

Of course.

Cheers,
John
