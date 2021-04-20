Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381B336593F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhDTMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:50:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16144 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:50:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPk3R0lJvzpZfN;
        Tue, 20 Apr 2021 20:47:15 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 20:50:12 +0800
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
Date:   Tue, 20 Apr 2021 20:50:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210419123314.GT1370958@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/19 20:33, Jason Gunthorpe wrote:
> On Mon, Apr 19, 2021 at 08:24:40PM +0800, liulongfang wrote:
> 
>>> I'm also confused how this works securely at all, as a general rule a
>>> VFIO PCI driver cannot access the MMIO memory of the function it is
>>> planning to assign to the guest. There is a lot of danger that the
>>> guest could access that MMIO space one way or another.
>>
>> VF's MMIO memory is divided into two parts, one is the guest part,
>> and the other is the live migration part. They do not affect each other,
>> so there is no security problem.
> 
> AFAIK there are several scenarios where a guest can access this MMIO
> memory using DMA even if it is not mapped into the guest for CPU
> access.
> 
The hardware divides VF's MMIO memory into two parts. The live migration
driver in the host uses the live migration part, and the device driver in
the guest uses the guest part. They obtain the address of VF's MMIO memory
in their respective drivers, although these two parts The memory is
continuous on the hardware device, but due to the needs of the drive function,
they will not perform operations on another part of the memory, and the
device hardware also independently responds to the operation commands of
the two parts.
So, I still don't understand what the security risk you are talking about is,
and what do you think the security design should look like?
Can you elaborate on it?

>> If pci_release_mem_regions() is not added here,
>> The guests using pci_request_mem_regions() will return an error.
>> Then, the guest will not be able to obtain the MMIO address of the VF.
> 
> Which is why VFIO has this protection to prevent sharing MMIO regions
> on the VF assigned to the guest
> 
> Jason
> .
> 

Thanks.
Longfang.
