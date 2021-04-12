Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9A35C27C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhDLJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240417AbhDLJYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618219419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYKRsudbOeg9+JxQeSQgy3b7HIceE1y/TyGuk/iOs+Q=;
        b=gzjal0XzG0mRKGsl7htqwcC+mssU3VZYO+sdRpO349TTTx9xMJZHGfkoJYWXPpZDijcaYQ
        PP6FlnOrub0C7a58s8szSZio1udtmkNB8vYabPuE8YcxVcp+uycmcYeKmI4TrN7G1CTiyu
        PS1pib53tYKP4c95aRqhles1c+ebsb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-hSTfSQBcPpSP-TNFeYwo6g-1; Mon, 12 Apr 2021 05:23:37 -0400
X-MC-Unique: hSTfSQBcPpSP-TNFeYwo6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 451066D585;
        Mon, 12 Apr 2021 09:23:36 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-232.pek2.redhat.com [10.72.13.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F365419C45;
        Mon, 12 Apr 2021 09:23:28 +0000 (UTC)
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
Date:   Mon, 12 Apr 2021 17:23:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412050730-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/4/12 下午5:09, Michael S. Tsirkin 写道:
> On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
>> 在 2021/4/10 上午12:04, Michael S. Tsirkin 写道:
>>> On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
>>>> 在 2021/4/8 下午11:59, Michael S. Tsirkin 写道:
>>>>> On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
>>>>>> This patch mandates 1.0 for vDPA devices. The goal is to have the
>>>>>> semantic of normative statement in the virtio spec and eliminate the
>>>>>> burden of transitional device for both vDPA bus and vDPA parent.
>>>>>>
>>>>>> uAPI seems fine since all the vDPA parent mandates
>>>>>> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
>>>>>>
>>>>>> For legacy guests, it can still work since Qemu will mediate when
>>>>>> necessary (e.g doing the endian conversion).
>>>>>>
>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> Hmm. If we do this, don't we still have a problem with
>>>>> legacy drivers which don't ack 1.0?
>>>> Yes, but it's not something that is introduced in this commit. The legacy
>>>> driver never work ...
>>> My point is this neither fixes or prevents this.
>>>
>>> So my suggestion is to finally add ioctls along the lines
>>> of PROTOCOL_FEATURES of vhost-user.
>>>
>>> Then that one can have bits for legacy le, legacy be and modern.
>>>
>>> BTW I looked at vhost-user and it does not look like that
>>> has a solution for this problem either, right?
>>
>> Right.
>>
>>
>>>
>>>>> Note 1.0 affects ring endianness which is not mediated in QEMU
>>>>> so QEMU can't pretend to device guest is 1.0.
>>>> Right, I plan to send patches to do mediation in the Qemu to unbreak legacy
>>>> drivers.
>>>>
>>>> Thanks
>>> I frankly think we'll need PROTOCOL_FEATURES anyway, it's too useful ...
>>> so why not teach drivers about it and be done with it? You can't emulate
>>> legacy on modern in a cross endian situation because of vring
>>> endian-ness ...
>>
>> So the problem still. This can only work when the hardware can support
>> legacy vring endian-ness.
>>
>> Consider:
>>
>> 1) the leagcy driver support is non-normative in the spec
>> 2) support a transitional device in the kenrel may requires the hardware
>> support and a burden of kernel codes
>>
>> I'd rather simply drop the legacy driver support
>
> My point is this patch does not drop legacy support. It merely mandates
> modern support.


I am not sure I get here. This patch fails the set_feature if VERSION_1 
is not negotiated. This means:

1) vDPA presents a modern device instead of transitonal device
2) legacy driver can't be probed

What I'm missing?


>
>> to have a simple and easy
>> abstarction in the kenrel. For legacy driver in the guest, hypervisor is in
>> charge of the mediation:
>>
>> 1) config space access endian conversion
>> 2) using shadow virtqueue to change the endian in the vring
>>
>> Thanks
> I'd like to avoid shadow virtqueue hacks if at all possible.
> Last I checked performance wasn't much better than just emulating
> virtio in software.


I think the legacy driver support is just a nice to have. Or do you see 
any value to that? I guess for mellanox and intel, only modern device is 
supported in the hardware.

Thanks


>
>>>
>>>>>
>>>>>
>>>>>
>>>>>> ---
>>>>>>     include/linux/vdpa.h | 6 ++++++
>>>>>>     1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>>> index 0fefeb976877..cfde4ec999b4 100644
>>>>>> --- a/include/linux/vdpa.h
>>>>>> +++ b/include/linux/vdpa.h
>>>>>> @@ -6,6 +6,7 @@
>>>>>>     #include <linux/device.h>
>>>>>>     #include <linux/interrupt.h>
>>>>>>     #include <linux/vhost_iotlb.h>
>>>>>> +#include <uapi/linux/virtio_config.h>
>>>>>>     /**
>>>>>>      * vDPA callback definition.
>>>>>> @@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>>>>>>     {
>>>>>>             const struct vdpa_config_ops *ops = vdev->config;
>>>>>> +        /* Mandating 1.0 to have semantics of normative statements in
>>>>>> +         * the spec. */
>>>>>> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>>     	vdev->features_valid = true;
>>>>>>             return ops->set_features(vdev, features);
>>>>>>     }
>>>>>> -- 
>>>>>> 2.25.1

