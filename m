Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC136B285
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhDZLu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:50:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17038 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhDZLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:50:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FTNQj4qtGzPtFP;
        Mon, 26 Apr 2021 19:46:37 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 26 Apr 2021 19:49:40 +0800
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
 <20210420160457.6b91850a@x1.home.shazbot.org>
 <25d033e6-1cba-0da0-2ee7-03a14e75b8a5@huawei.com>
 <20210421121224.62382e5d@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <b648e315-e312-79ef-d321-595562bd7a2f@huawei.com>
Date:   Mon, 26 Apr 2021 19:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210421121224.62382e5d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/22 2:12, Alex Williamson wrote:
> On Wed, 21 Apr 2021 17:59:02 +0800
> liulongfang <liulongfang@huawei.com> wrote:
> 
>> On 2021/4/21 6:04, Alex Williamson wrote:
>>> On Tue, 20 Apr 2021 09:59:57 -0300
>>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>   
>>>> On Tue, Apr 20, 2021 at 08:50:12PM +0800, liulongfang wrote:  
>>>>> On 2021/4/19 20:33, Jason Gunthorpe wrote:    
>>>>>> On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:
>>>>>>     
>>>>>>>> I'm also confused how this works securely at all, as a general rule a
>>>>>>>> VFIO PCI driver cannot access the MMIO memory of the function it is
>>>>>>>> planning to assign to the guest. There is a lot of danger that the
>>>>>>>> guest could access that MMIO space one way or another.    
>>>>>>>
>>>>>>> VF's MMIO memory is divided into two parts, one is the guest part,
>>>>>>> and the other is the live migration part. They do not affect each other,
>>>>>>> so there is no security problem.    
>>>>>>
>>>>>> AFAIK there are several scenarios where a guest can access this MMIO
>>>>>> memory using DMA even if it is not mapped into the guest for CPU
>>>>>> access.
>>>>>>     
>>>>> The hardware divides VF's MMIO memory into two parts. The live migration
>>>>> driver in the host uses the live migration part, and the device driver in
>>>>> the guest uses the guest part. They obtain the address of VF's MMIO memory
>>>>> in their respective drivers, although these two parts The memory is
>>>>> continuous on the hardware device, but due to the needs of the drive function,
>>>>> they will not perform operations on another part of the memory, and the
>>>>> device hardware also independently responds to the operation commands of
>>>>> the two parts.    
>>>>
>>>> It doesn't matter, the memory is still under the same PCI BDF and VFIO
>>>> supports scenarios where devices in the same IOMMU group are not
>>>> isolated from each other.
>>>>
>>>> This is why the granual of isolation is a PCI BDF - VFIO directly
>>>> blocks kernel drivers from attaching to PCI BDFs that are not
>>>> completely isolated from VFIO BDF.
>>>>
>>>> Bypassing this prevention and attaching a kernel driver directly to
>>>> the same BDF being exposed to the guest breaks that isolation model.
>>>>  
>>>>> So, I still don't understand what the security risk you are talking about is,
>>>>> and what do you think the security design should look like?
>>>>> Can you elaborate on it?    
>>>>
>>>> Each security domain must have its own PCI BDF.
>>>>
>>>> The migration control registers must be on a different VF from the VF
>>>> being plugged into a guest and the two VFs have to be in different
>>>> IOMMU groups to ensure they are isolated from each other.  
>>>
>>> I think that's a solution, I don't know if it's the only solution.
>>> AIUI, the issue here is that we have a device specific kernel driver
>>> extending vfio-pci with migration support for this device by using an  
>>
>> If the two parts of the MMIO region are split into different BAR spaces on
>> the device, the MMIO region of ​​the business function is still placed in BAR2,
>> and the MMIO region of ​​the live migration function is moved to BAR4.
>> Only BAR2 is mapped in the guest. only BAR4 is mapped in the host.
>> This can solve this security issue.
> 
> The concern is really the "on the device" part rather than whether the
> resources are within the same BAR or not.  We need to assume that a
> user driver can generate a DMA targeting any address in the system,
> including in this case the user driver could generate a DMA targeting
> this migration BAR.  Ideally this would be routed upstream to the IOMMU
> where it would be blocked for lack of a translation entry.  However,
> because this range resides on the same PCIe requester ID, it's
> logically more similar to a two-function device where the functions are
> considered non-isolated and are therefore exposed within the same IOMMU
> group.  We would not allow a kernel driver for one of those functions
> and a userspace driver for the other.  In this case those drivers are
> strongly related, but we still need to consider to what extent a
> malicious user driver can interfere with or exploit the kernel side
> driver.
> 
> 
>>> MMIO region of the same device.  This is susceptible to DMA> manipulation by the user device.   Whether that's a security issue or> not depends on how the user can break the device.  If the scope is
>>> limited to breaking their own device, they can do that any number of
>>> ways and it's not very interesting.  If the user can manipulate device
>>> state in order to trigger an exploit of the host-side kernel driver,
>>> that's obviously more of a problem.
>>>
>>> The other side of this is that if migration support can be implemented
>>> entirely within the VF using this portion of the device MMIO space, why
>>> do we need the host kernel to support this rather than implementing it
>>> in userspace?  For example, QEMU could know about this device,
>>> manipulate the BAR size to expose only the operational portion of MMIO
>>> to the VM and use the remainder to support migration itself.  I'm
>>> afraid that just like mdev, the vfio migration uAPI is going to be used
>>> as an excuse to create kernel drivers simply to be able to make use of
>>> that uAPI.  I haven't looked at this driver to know if it has some  
>>
>> When the accelerator device is designed to support the live migration
>> function, it is based on the uAPI of the migration region to realize the
>> live migration function, so the live migration function requires a driver
>> that connects to this uAPI.
>> Is this set of interfaces not open to us now?
> 
> In your model, if both BARs are exposed to userspace and a device
> specific extension in QEMU claims the migration BAR rather than
> exposing it to the VM, could that driver mimic the migration region
> uAPI from userspace?  For example, you don't need page pinning to
> interact with the IOMMU, you don't need resources beyond the scope
> of the endpoint device itself, and the migration info BAR is safe for
> userspace to manage?  If so, then a kernel-based driver to expose a
> migration uAPI seems like it's only a risk for the kernel, ie. moving
> what could be a userspace driver into the kernel for the convenience of
> re-using a kernel uAPI.  Thanks,
> 
> Alex
> 
> .
> 
Thanks for your review and suggestions.

We discussed the security issues you mentioned and put forward some new solutions.
These new solutions are now being implemented. After they are tested successfully,
they will be issued in the second version of the RFC.

Thanks,
Longfang.
