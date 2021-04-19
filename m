Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1FD3641A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhDSMZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:25:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16602 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDSMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:25:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FP5YD4sSjz1BGPw;
        Mon, 19 Apr 2021 20:22:24 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 19 Apr 2021 20:24:40 +0800
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
Date:   Mon, 19 Apr 2021 20:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210415220137.GA1672608@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/16 6:01, Jason Gunthorpe wrote:
> On Tue, Apr 13, 2021 at 11:36:22AM +0800, Longfang Liu wrote:
>> Register the live migration driver of the accelerator module to vfio
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>>  drivers/vfio/pci/vfio_pci.c         | 11 +++++++++++
>>  drivers/vfio/pci/vfio_pci_private.h |  9 +++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 65e7e6b..e1b0e37 100644
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -407,6 +407,17 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>>  		}
>>  	}
>>  
>> +	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
>> +	    IS_ENABLED(CONFIG_VFIO_PCI_HISI_MIGRATION)) {
>> +		ret = vfio_pci_hisilicon_acc_init(vdev);
> 
> This is exactly what we want to avoid with the work we are doing on
> the vfio-pci modularity.
> 
> It is a complete mess to just keep adding more stuff here, and as
> we've discussed to death really ugly to have such a ridiculously wide
> ID match.
> 
> You should be working with us on that project and base your work on
> top of Max's series.. Alex given the interest here I think we should
> find some way forward while we work on completed version of the mlx5
> pci vfio driver..
> 
> I'm also confused how this works securely at all, as a general rule a
> VFIO PCI driver cannot access the MMIO memory of the function it is
> planning to assign to the guest. There is a lot of danger that the
> guest could access that MMIO space one way or another.
> 
VF's MMIO memory is divided into two parts, one is the guest part,
and the other is the live migration part. They do not affect each other,
so there is no security problem.

> Here I see the driver obtaining a devm_ioremap() of the same pdev it
> is going to assign (and I really wonder why pci_release_mem_regions()
> exists at all..)
> 
The driver here obtains the VF's MMIO memory address through devm_ioremap(),
and adding pci_release_mem_regions() is to get the MMIO memory address
in the guest after the driver here obtains the MMIO memory address.

If pci_release_mem_regions() is not added here,
The guests using pci_request_mem_regions() will return an error.
Then, the guest will not be able to obtain the MMIO address of the VF.

> This is why the mlx5 RFC was showing how to juggle two PCI devices via
> the aux device connector.
> 
I also noticed the mlx5 RFC, but it will take some time to analyze it. If the analysis
process goes well. I will import the mlx5 RFC into our driver and use this solution
to test and verify our live migration function.

If we use the mlx5 RFC, what should we pay attention to?

> Jason
> .
> 
Thanks.
Longfang.
