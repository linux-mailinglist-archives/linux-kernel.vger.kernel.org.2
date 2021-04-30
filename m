Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56F36F623
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhD3HEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230491AbhD3HEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619766197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ev+FiH0qOrXUckbdDN0f3TiSYH0KxnX5cJCySBReIKw=;
        b=EnrQQimngAybrFDpeGLn5W9Jjqv7DqfY8jViTtdaphdkTZloaftouV3y8X98U+1XBSp1uD
        tOLZ93GjCotJwRC3SQjAKKQjbfjAVC4ESawsR7TW1u99CFFUdEemQQtsWoo7s7hU0A3z+5
        tauMYVmOY7YUaO91kcfseZrmvoXEee4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-myIhA6HXOU-mKfNKDX_j3g-1; Fri, 30 Apr 2021 03:03:14 -0400
X-MC-Unique: myIhA6HXOU-mKfNKDX_j3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE8601008062;
        Fri, 30 Apr 2021 07:03:13 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-175.pek2.redhat.com [10.72.12.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 697EF70588;
        Fri, 30 Apr 2021 07:03:08 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To:     "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
 <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
 <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
 <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
 <bdf10e38-8746-51cf-b460-a904a133329c@redhat.com>
 <20210429100033.GA215200@mtl-vdi-166.wap.labs.mlnx>
 <fc887d99-7058-1057-2d1a-3bdc5802a59a@redhat.com>
 <836263af-6791-0bd3-22c7-22197da021e9@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <79d57f53-a5c9-58df-4a79-6cc7892ab1a2@redhat.com>
Date:   Fri, 30 Apr 2021 15:03:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <836263af-6791-0bd3-22c7-22197da021e9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/4/30 下午2:31, Zhu, Lingshan 写道:
>
>
> On 4/30/2021 12:40 PM, Jason Wang wrote:
>>
>> 在 2021/4/29 下午6:00, Eli Cohen 写道:
>>> On Thu, Apr 22, 2021 at 04:59:11PM +0800, Jason Wang wrote:
>>>> 在 2021/4/22 下午4:39, Eli Cohen 写道:
>>>>> On Thu, Apr 22, 2021 at 04:21:45PM +0800, Jason Wang wrote:
>>>>>> 在 2021/4/22 下午4:07, Eli Cohen 写道:
>>>>>>> On Thu, Apr 22, 2021 at 09:03:58AM +0300, Eli Cohen wrote:
>>>>>>>> On Thu, Apr 22, 2021 at 10:37:38AM +0800, Jason Wang wrote:
>>>>>>>>> 在 2021/4/21 下午6:41, Eli Cohen 写道:
>>>>>>>>>> Implement mlx5_get_vq_notification() to return the doorbell 
>>>>>>>>>> address.
>>>>>>>>>> Size is set to one system page as required.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>>>>>>> ---
>>>>>>>>>>      drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
>>>>>>>>>>      drivers/vdpa/mlx5/core/resources.c | 1 +
>>>>>>>>>>      drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
>>>>>>>>>>      3 files changed, 8 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h 
>>>>>>>>>> b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>>>>>> index b6cc53ba980c..49de62cda598 100644
>>>>>>>>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>>>>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>>>>>>>>> @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
>>>>>>>>>>          u32 pdn;
>>>>>>>>>>          struct mlx5_uars_page *uar;
>>>>>>>>>>          void __iomem *kick_addr;
>>>>>>>>>> +    u64 phys_kick_addr;
>>>>>>>>>>          u16 uid;
>>>>>>>>>>          u32 null_mkey;
>>>>>>>>>>          bool valid;
>>>>>>>>>> diff --git a/drivers/vdpa/mlx5/core/resources.c 
>>>>>>>>>> b/drivers/vdpa/mlx5/core/resources.c
>>>>>>>>>> index 6521cbd0f5c2..665f8fc1710f 100644
>>>>>>>>>> --- a/drivers/vdpa/mlx5/core/resources.c
>>>>>>>>>> +++ b/drivers/vdpa/mlx5/core/resources.c
>>>>>>>>>> @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct 
>>>>>>>>>> mlx5_vdpa_dev *mvdev)
>>>>>>>>>>              goto err_key;
>>>>>>>>>>          kick_addr = mdev->bar_addr + offset;
>>>>>>>>>> +    res->phys_kick_addr = kick_addr;
>>>>>>>>>>          res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
>>>>>>>>>>          if (!res->kick_addr) {
>>>>>>>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>>>>>>>>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>>>>>>> index 10c5fef3c020..680751074d2a 100644
>>>>>>>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>>>>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>>>>>>> @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct 
>>>>>>>>>> vdpa_device *vdev)
>>>>>>>>>>      static struct vdpa_notification_area 
>>>>>>>>>> mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>>>>>>>>>>      {
>>>>>>>>>> +    struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>>>>>>>>          struct vdpa_notification_area ret = {};
>>>>>>>>>> +    struct mlx5_vdpa_net *ndev;
>>>>>>>>>> +
>>>>>>>>>> +    ndev = to_mlx5_vdpa_ndev(mvdev);
>>>>>>>>>> +    ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
>>>>>>>>>> +    ret.size = PAGE_SIZE;
>>>>>>>>> Note that the page will be mapped in to guest, so it's only 
>>>>>>>>> safe if the
>>>>>>>>> doorbeel exclusively own the page. This means if there're 
>>>>>>>>> other registers in
>>>>>>>>> the page, we can not let the doorbell bypass to work.
>>>>>>>>>
>>>>>>>>> So this is suspicious at least in the case of subfunction 
>>>>>>>>> where we calculate
>>>>>>>>> the bar length in mlx5_sf_dev_table_create() as:
>>>>>>>>>
>>>>>>>>> table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, 
>>>>>>>>> log_min_sf_size) + 12);
>>>>>>>>>
>>>>>>>>> It looks to me this can only work for the arch with PAGE_SIZE 
>>>>>>>>> = 4096,
>>>>>>>>> otherwise we can map more into the userspace(guest).
>>>>>>>>>
>>>>>>>> Correct, so I guess I should return here 4096.
>>>>>> I'm not quite sure but since the calculation of the sf_bar_length 
>>>>>> is doen
>>>>>> via a shift of 12, it might be correct.
>>>>>>
>>>>>> And please double check if the doorbell own the page exclusively.
>>>>> I am checking if it is safe to map the any part of the SF's BAR to
>>>>> userspace without harming other functions. If this is true, I will 
>>>>> check
>>>>> if I can return PAGE_SIZE without compromising security.
>>>>
>>>> It's usally not safe and a layer violation if other registers are 
>>>> placed at
>>>> the same page.
>>>>
>>>>
>>>>>    I think we may
>>>>> need to extend struct vdpa_notification_area to contain another field
>>>>> offset which indicates the offset from addr where the actual doorbell
>>>>> resides.
>>>>
>>>> The movitiaton of the current design is to be fit seamless into how 
>>>> Qemu
>>>> model doorbell layouts currently:
>>>>
>>>> 1) page-per-vq, each vq has its own page aligned doorbell
>>>> 2) 2 bytes doorbell, each vq has its own 2 byte aligend doorbell
>>>>
>>>> Only 1) is support in vhost-vDPA (and vhost-user) since it's rather 
>>>> simple
>>>> and secure (page aligned) to be modelled and implemented via mmap().
>>>>
>>>> Exporting a complex layout is possbile but requires careful design.
>>>>
>>>> Actually, we had antoher option
>>>>
>>>> 3) shared doorbell: all virtqueue shares a single page aligned 
>>>> doorbell
>>> I am not sure how this could solve the problem of 64KB archs.
>>> The point is that in ConnectX devices, the virtio queue objects 
>>> doorbell
>>> is aligned to 4K. For larger system page sizes, the doorbell may not be
>>> aligned to a system page.
>>> So it seems not too complex to introduce offset within the page.
>>
>>
>> Three major issues:
>>
>> 1) single mmap() works at page level, it means we need map 64K to 
>> guest and we can only do this safely if no other registers are placed 
>> into the same page
>> 2) new uAPI to let the userspace know the offset
>> 3) how to model them with the virtio-pci in Qemu, and this may 
>> introduce burdens for management (need some changes in the qemu 
>> command line) to deal with the migration compatibility
>>
>> So consider the complexity, we can just stick to the current code. 
>> That means mmap() will fail and qemu will keep using the eventfd 
>> based kick.
> There is another case, mmap() works at page level, page size is at 
> least 4K. Consider if a device has a bar containing the shared 
> doorbell page at its last 4K space. In this bar layout, map a 
> arch.page_size=64K page to usersapce would lead to fatal errors.


Why it's a fatal error? Userspace should survive from mmap() errors and 
keep using the kickfd.


> I think we can assign the actual size of the doorbell area size to 
> vdpa_notification.size than arch.page_size to avoid such issues. Then 
> upper layers like vhost_vdpa should check whether this size can work 
> with the machine arch and its alignment, if not, should fail over to 
> use eventfd.


Isn't this how get_vet_notification() designed and implemented right 
now? What parent need is just to report the doorbell size, it's the bus 
driver (vhost-vDPA) to decide if and how it is used.

Thanks


> Then do we still need a uAPI tell the offset within the page?
>
> Thanks
> Zhu Lingshan
>>
>>
>>
>>>
>>> BTW, for now, I am going to send another patch that makes sure page
>>> boundaries are not vilated. It requires some support from mlx5_core
>>> which is currently being reviewed internally.
>>
>>
>> Sure.
>>
>> Thanks
>>
>>
>>>
>>>> This is not yet supported by Qemu.
>>>>
>>>> Thanks
>>>>
>>>>
>>>>>>>> I also think that the check in vhost_vdpa_mmap() should verify 
>>>>>>>> that the
>>>>>>>> returned size is not smaller than PAGE_SIZE because the 
>>>>>>>> returned address
>>>>>>> Actually I think it's ok since you verify the size equals 
>>>>>>> vma->vm_end -
>>>>>>> vma->vm_start which must be at least PAGE_SIZE.
>>>>>> Yes.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>>>> might just be aligned to PAGE_SIZE. I think this should be 
>>>>>>>> enoght but
>>>>>>>> maybe also use the same logic in vhost_vdpa_fault().
>>
>

