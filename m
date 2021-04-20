Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4277A365A15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhDTN32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:29:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17381 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhDTN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:29:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FPkxC5smhzlYGg;
        Tue, 20 Apr 2021 21:26:55 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 21:28:47 +0800
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <b0fadb89-e875-5a0d-016e-29e54d26726e@huawei.com>
Date:   Tue, 20 Apr 2021 21:28:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210420125957.GA1370958@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/20 20:59, Jason Gunthorpe wrote:
> On Tue, Apr 20, 2021 at 08:50:12PM +0800, liulongfang wrote:
>> On 2021/4/19 20:33, Jason Gunthorpe wrote:
>>> On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:
>>>
>>>>> I'm also confused how this works securely at all, as a general rule a
>>>>> VFIO PCI driver cannot access the MMIO memory of the function it is
>>>>> planning to assign to the guest. There is a lot of danger that the
>>>>> guest could access that MMIO space one way or another.
>>>>
>>>> VF's MMIO memory is divided into two parts, one is the guest part,
>>>> and the other is the live migration part. They do not affect each other,
>>>> so there is no security problem.
>>>
>>> AFAIK there are several scenarios where a guest can access this MMIO
>>> memory using DMA even if it is not mapped into the guest for CPU
>>> access.
>>>
>> The hardware divides VF's MMIO memory into two parts. The live migration
>> driver in the host uses the live migration part, and the device driver in
>> the guest uses the guest part. They obtain the address of VF's MMIO memory
>> in their respective drivers, although these two parts The memory is
>> continuous on the hardware device, but due to the needs of the drive function,
>> they will not perform operations on another part of the memory, and the
>> device hardware also independently responds to the operation commands of
>> the two parts.
> 
> It doesn't matter, the memory is still under the same PCI BDF and VFIO
> supports scenarios where devices in the same IOMMU group are not
> isolated from each other.
> 
> This is why the granual of isolation is a PCI BDF - VFIO directly
> blocks kernel drivers from attaching to PCI BDFs that are not
> completely isolated from VFIO BDF.
> 
> Bypassing this prevention and attaching a kernel driver directly to
> the same BDF being exposed to the guest breaks that isolation model.
> 
>> So, I still don't understand what the security risk you are talking about is,
>> and what do you think the security design should look like?
>> Can you elaborate on it?
> 
> Each security domain must have its own PCI BDF.
> 
The basic unit to perform the live migration function is the VF, and the basic
function of the VF is the business function of the device. If the live migration
function and the business function are completely separated, and they are bound
to their respective VFs, it will result in the ability to execute the business
in the guest A functional VF cannot perform live migration, and a VF with a live
migration function cannot perform business functions in the guest.

In fact, the scenario that requires live migration is to migrate its business
functions to the VFs of other hosts when the VF's business functions are heavily
loaded.
This usage scenario itself requires that the VF needs to have these two functions
at the same time.

> The migration control registers must be on a different VF from the VF
> being plugged into a guest and the two VFs have to be in different
> IOMMU groups to ensure they are isolated from each other.
> 
> Jason
> .
> 

Thanks.
Longfang.
