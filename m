Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD483668AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhDUJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:59:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16611 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhDUJ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:59:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FQGD94s8Tz19Lm1;
        Wed, 21 Apr 2021 17:56:41 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 17:59:02 +0800
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
To:     Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
 <20210420160457.6b91850a@x1.home.shazbot.org>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
Date:   Wed, 21 Apr 2021 17:59:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210420160457.6b91850a@x1.home.shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/21 6:04, Alex Williamson wrote:
> On Tue, 20 Apr 2021 09:59:57 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Tue, Apr 20, 2021 at 08:50:12PM +0800, liulongfang wrote:
>>> On 2021/4/19 20:33, Jason Gunthorpe wrote:  
>>>> On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:
>>>>   
>>>>>> I'm also confused how this works securely at all, as a general rule a
>>>>>> VFIO PCI driver cannot access the MMIO memory of the function it is
>>>>>> planning to assign to the guest. There is a lot of danger that the
>>>>>> guest could access that MMIO space one way or another.  
>>>>>
>>>>> VF's MMIO memory is divided into two parts, one is the guest part,
>>>>> and the other is the live migration part. They do not affect each other,
>>>>> so there is no security problem.  
>>>>
>>>> AFAIK there are several scenarios where a guest can access this MMIO
>>>> memory using DMA even if it is not mapped into the guest for CPU
>>>> access.
>>>>   
>>> The hardware divides VF's MMIO memory into two parts. The live migration
>>> driver in the host uses the live migration part, and the device driver in
>>> the guest uses the guest part. They obtain the address of VF's MMIO memory
>>> in their respective drivers, although these two parts The memory is
>>> continuous on the hardware device, but due to the needs of the drive function,
>>> they will not perform operations on another part of the memory, and the
>>> device hardware also independently responds to the operation commands of
>>> the two parts.  
>>
>> It doesn't matter, the memory is still under the same PCI BDF and VFIO
>> supports scenarios where devices in the same IOMMU group are not
>> isolated from each other.
>>
>> This is why the granual of isolation is a PCI BDF - VFIO directly
>> blocks kernel drivers from attaching to PCI BDFs that are not
>> completely isolated from VFIO BDF.
>>
>> Bypassing this prevention and attaching a kernel driver directly to
>> the same BDF being exposed to the guest breaks that isolation model.
>>
>>> So, I still don't understand what the security risk you are talking about is,
>>> and what do you think the security design should look like?
>>> Can you elaborate on it?  
>>
>> Each security domain must have its own PCI BDF.
>>
>> The migration control registers must be on a different VF from the VF
>> being plugged into a guest and the two VFs have to be in different
>> IOMMU groups to ensure they are isolated from each other.
> 
> I think that's a solution, I don't know if it's the only solution.
> AIUI, the issue here is that we have a device specific kernel driver
> extending vfio-pci with migration support for this device by using an

If the two parts of the MMIO region are split into different BAR spaces on
the device, the MMIO region of ​​the business function is still placed in BAR2,
and the MMIO region of ​​the live migration function is moved to BAR4.
Only BAR2 is mapped in the guest. only BAR4 is mapped in the host.
This can solve this security issue.

> MMIO region of the same device.  This is susceptible to DMA> manipulation by the user device.   Whether that's a security issue or> not depends on how the user can break the device.  If the scope is
> limited to breaking their own device, they can do that any number of
> ways and it's not very interesting.  If the user can manipulate device
> state in order to trigger an exploit of the host-side kernel driver,
> that's obviously more of a problem.
> 
> The other side of this is that if migration support can be implemented
> entirely within the VF using this portion of the device MMIO space, why
> do we need the host kernel to support this rather than implementing it
> in userspace?  For example, QEMU could know about this device,
> manipulate the BAR size to expose only the operational portion of MMIO
> to the VM and use the remainder to support migration itself.  I'm
> afraid that just like mdev, the vfio migration uAPI is going to be used
> as an excuse to create kernel drivers simply to be able to make use of
> that uAPI.  I haven't looked at this driver to know if it has some

When the accelerator device is designed to support the live migration
function, it is based on the uAPI of the migration region to realize the
live migration function, so the live migration function requires a driver
that connects to this uAPI.
Is this set of interfaces not open to us now?

> other reason to exist beyond what could be done through vfio-pci and
> userspace migration support.  Thanks,
> 
> Alex
> 
> .
> 
Thanks，
Longfang.
