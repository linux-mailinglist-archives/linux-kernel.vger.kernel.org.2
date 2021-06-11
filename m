Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496943A4264
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhFKMvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:51:21 -0400
Received: from foss.arm.com ([217.140.110.172]:57510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhFKMvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:51:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FF5D6E;
        Fri, 11 Jun 2021 05:49:19 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEB23F73D;
        Fri, 11 Jun 2021 05:49:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
To:     Will Deacon <will@kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
 <20210611104524.GD15274@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
Date:   Fri, 11 Jun 2021 13:49:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611104524.GD15274@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-11 11:45, Will Deacon wrote:
> On Thu, Jun 10, 2021 at 09:46:53AM +0530, Ashish Mhetre wrote:
>> Domain is getting created more than once during asynchronous multiple
>> display heads(devices) probe. All the display heads share same SID and
>> are expected to be in same domain. As iommu_alloc_default_domain() call
>> is not protected, the group->default_domain and group->domain are ending
>> up with different domains and leading to subsequent IOMMU faults.
>> Fix this by protecting iommu_alloc_default_domain() call with group->mutex.
> 
> Can you provide some more information about exactly what the h/w
> configuration is, and the callstack which exhibits the race, please?

It'll be basically the same as the issue reported long ago with PCI 
groups in the absence of ACS not being constructed correctly. Triggering 
the iommu_probe_device() replay in of_iommu_configure() off the back of 
driver probe is way too late and allows calls to happen in the wrong 
order, or indeed race in parallel as here. Fixing that is still on my 
radar, but will not be simple, and will probably go hand-in-hand with 
phasing out the bus ops (for the multiple-driver-coexistence problem).

>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/iommu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 808ab70..2700500 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
>>   	 * support default domains, so the return value is not yet
>>   	 * checked.
>>   	 */
>> +	mutex_lock(&group->mutex);
>>   	iommu_alloc_default_domain(group, dev);
>> +	mutex_unlock(&group->mutex);
> 
> It feels wrong to serialise this for everybody just to cater for systems
> with aliasing SIDs between devices.

If two or more devices are racing at this point then they're already 
going to be serialised by at least iommu_group_add_device(), so I doubt 
there would be much impact - only the first device through here will 
hold the mutex for any appreciable length of time. Every other path 
which modifies group->domain does so with the mutex held (note the 
"expected" default domain allocation flow in bus_iommu_probe() in 
particular), so not holding it here does seem like a straightforward 
oversight.

Robin.
