Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1AF3668AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhDUJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:59:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17808 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhDUJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:59:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FQGDB6w0Wz7wCG;
        Wed, 21 Apr 2021 17:56:42 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 17:59:04 +0800
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
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
 <20210420231830.GD1370958@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <8930d7db-2145-5cc3-ce6f-67dc3959d391@huawei.com>
Date:   Wed, 21 Apr 2021 17:59:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210420231830.GD1370958@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/21 7:18, Jason Gunthorpe wrote:
> On Tue, Apr 20, 2021 at 04:04:57PM -0600, Alex Williamson wrote:
> 
>>> The migration control registers must be on a different VF from the VF
>>> being plugged into a guest and the two VFs have to be in different
>>> IOMMU groups to ensure they are isolated from each other.
>>
>> I think that's a solution, I don't know if it's the only solution.
> 
> Maybe, but that approach does offer DMA access for the migration. For
> instance to implement something that needs a lot of data like
> migrating a complicated device state, or dirty page tracking or
> whatver.
> 
> This driver seems very simple - it has only 17 state elements - and
> doesn't use DMA.
> 
Yes£¬the operating address of this driver is the MMIO address,
not the DMA address, but the internal hardware DMA address is used
as data for migration.

> I can't quite tell, but does this pass the hypervisor BAR into the
> guest anyhow? That would certainly be an adquate statement that it is
> safe, assuming someone did a good security analysis.
> 
>> ways and it's not very interesting.  If the user can manipulate device
>> state in order to trigger an exploit of the host-side kernel driver,
>> that's obviously more of a problem.
> 
> Well, for instance, we have an implementation of
> (VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING) which means the
> guest CPUs are still running and a hostile guest can be manipulating
> the device.
> 
> But this driver is running code, like vf_qm_state_pre_save() in this
> state. Looks very suspicious.
> 
> One quick attack I can imagine is to use the guest CPU to DOS the
> migration and permanently block it, eg by causing qm_mb() or other
> looping functions to fail.
> 
> There may be worse things possible, it is a bit hard to tell just from
> the code.
> 
> .. also drivers should not be open coding ARM assembly as in
> qm_mb_write()
> 
OK, these codes need to be encapsulated and should not be presented in
this driver.

> .. and also, code can not randomly call pci_get_drvdata() on a struct
> device it isn't attached to haven't verified the right driver is
> bound, or locked correctly.
> 
Yes, This call needs to be placed in an encapsulation interface,
and access protection needs to be added.

>> manipulate the BAR size to expose only the operational portion of MMIO
>> to the VM and use the remainder to support migration itself.  I'm
>> afraid that just like mdev, the vfio migration uAPI is going to be used
>> as an excuse to create kernel drivers simply to be able to make use of
>> that uAPI.
> 
> I thought that is the general direction people had agreed on during
> the IDXD mdev discussion?
> 
> People want the IOCTLs from VFIO to be the single API to program all
> the VMMs to and to not implement user space drivers..
> 
> This actually seems like a great candidate for a userspace driver.
> 
> I would like to know we are still settled on this direction as the
> mlx5 drivers we are working on also have some complicated option to be
> user space only.
> 
> Jason
> .
> 
