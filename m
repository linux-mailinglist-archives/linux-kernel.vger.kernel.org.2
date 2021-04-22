Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8B3678E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 06:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhDVEw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 00:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhDVEw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 00:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619067142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9k2K+Ex6th6PfN+n1tdJx10Bdm1/2R+GEbRdjId//8=;
        b=gtQncPCYpHNHPdk8800cHteE3RB1gDrGNXv+tF8s1X6586eiXHfPEAintdUDEgcxENPVH6
        ZalNVgLbQMQC8iqBAxe7ISn4PHkFlFj7oxpCRRcBahNqTG9ApORURiqlbmzVnEBBfm3wwF
        BsKGZ7nnDpAzAsgcMyXzZ2AwzUpVGT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-GO-Dxq9TPE6RJTrUoLDQWw-1; Thu, 22 Apr 2021 00:52:19 -0400
X-MC-Unique: GO-Dxq9TPE6RJTrUoLDQWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 444EF8189C6;
        Thu, 22 Apr 2021 04:52:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-214.pek2.redhat.com [10.72.13.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61A5662693;
        Thu, 22 Apr 2021 04:52:11 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Eli Cohen <elic@nvidia.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <a77efb06-b2ae-c94a-96bc-290b8b7332ba@nextfour.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7bdb251a-5e16-dd22-d204-6ff57e12e72f@redhat.com>
Date:   Thu, 22 Apr 2021 12:52:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <a77efb06-b2ae-c94a-96bc-290b8b7332ba@nextfour.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/4/22 上午11:27, Mika Penttilä 写道:
>
>
> On 22.4.2021 5.37, Jason Wang wrote:
>>
>> 在 2021/4/21 下午6:41, Eli Cohen 写道:
>>> Implement mlx5_get_vq_notification() to return the doorbell address.
>>> Size is set to one system page as required.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
>>>   drivers/vdpa/mlx5/core/resources.c | 1 +
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
>>>   3 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h 
>>> b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> index b6cc53ba980c..49de62cda598 100644
>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
>>>       u32 pdn;
>>>       struct mlx5_uars_page *uar;
>>>       void __iomem *kick_addr;
>>> +    u64 phys_kick_addr;
>>>       u16 uid;
>>>       u32 null_mkey;
>>>       bool valid;
>>> diff --git a/drivers/vdpa/mlx5/core/resources.c 
>>> b/drivers/vdpa/mlx5/core/resources.c
>>> index 6521cbd0f5c2..665f8fc1710f 100644
>>> --- a/drivers/vdpa/mlx5/core/resources.c
>>> +++ b/drivers/vdpa/mlx5/core/resources.c
>>> @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct 
>>> mlx5_vdpa_dev *mvdev)
>>>           goto err_key;
>>>         kick_addr = mdev->bar_addr + offset;
>>> +    res->phys_kick_addr = kick_addr;
>>>         res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
>>>       if (!res->kick_addr) {
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 10c5fef3c020..680751074d2a 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device 
>>> *vdev)
>>>     static struct vdpa_notification_area 
>>> mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>>>   {
>>> +    struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>       struct vdpa_notification_area ret = {};
>>> +    struct mlx5_vdpa_net *ndev;
>>> +
>>> +    ndev = to_mlx5_vdpa_ndev(mvdev);
>>>   +    ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
>>> +    ret.size = PAGE_SIZE;
>>
>>
>> Note that the page will be mapped in to guest, so it's only safe if 
>> the doorbeel exclusively own the page. This means if there're other 
>> registers in the page, we can not let the doorbell bypass to work.
>>
>> So this is suspicious at least in the case of subfunction where we 
>> calculate the bar length in mlx5_sf_dev_table_create() as:
>>
>> table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
>>
>> It looks to me this can only work for the arch with PAGE_SIZE = 4096, 
>> otherwise we can map more into the userspace(guest).
>>
>> Thanks
>>
>>
> Is there support as of today (in qemu  or elsewhere) to use this mmap 
> doorbell instead of the traditional kick.


Vhost-user had already had this support in Qemu (see set_host_notifier_mr).

And I've posted patches to support this for qemu[1] and vp_vdpa[2] driver.

Thanks

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg798935.html

[2] 
https://lore.kernel.org/virtualization/20210415073147.19331-5-jasowang@redhat.com/T/


>
> --Mika
>
>
>
>>
>>>       return ret;
>>>   }
>>
>

