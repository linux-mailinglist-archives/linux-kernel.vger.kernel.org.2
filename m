Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2A399B55
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFCHQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFCHQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622704497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnbuU0fDADScyN4D+Z91sdr8ftGo7PShkTKmw8niS1s=;
        b=aA9dQ+bV4tLvjeSPO2NdHw8HdVrkiBGhY2CK+qTGcvq62fh/u3lHc/80EpI4r9owUSzc7K
        mOwD2dSz4Lp1l4/nFxCZQLykaW4YNGYt7QIVkWCjhJQeNvdb2QHbs0ra8idz8DlQcBUoXu
        BmNjQkWcCtXo1FLG6FJObMGC0Jel9wA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213--Q7ADfmeM1G_JrRq-25APg-1; Thu, 03 Jun 2021 03:14:56 -0400
X-MC-Unique: -Q7ADfmeM1G_JrRq-25APg-1
Received: by mail-pl1-f197.google.com with SMTP id b15-20020a1709027e0fb02900fef41cdedfso2259520plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 00:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nnbuU0fDADScyN4D+Z91sdr8ftGo7PShkTKmw8niS1s=;
        b=j6jBUfb+KEEAReVHu1CwQ9Rfj7bODWnF+GrPactxyvA4rr266ejRUioKOKrDFJIIj0
         Ge4Vrjp20oF3RcMMrKH9Wil8AzrwgaILYLKuqaFwGIDbRuxyYYtg97WNNZdUHefXHUjw
         nBwOk1LFLgnOdk4HEyzqCYPscUNgIv9jWiyw0SvZ3uV/xLalMfRAly+c9vZEXhdJfVT8
         jJQlNfCVjfmTk10aSr2ft75Ibr9GZ2BhGvgD1U+7psP3MKKaJmFQTyW7SKIK93UCyY8D
         v4T9hhWQXKDw0QBMNMY6JbvVfK2hYFHs94MRZsFibfQmtR2Nqqgu9bFuC1H3OE8eCAiZ
         km3w==
X-Gm-Message-State: AOAM530J0AL0JOzZm13r6AigoL/Nd5gR3f96L47eOqDeDU9NNGvVaBAw
        L2aCw4UyTwpNtBLzx46GcTevYiqRvLForkQU96ITxH28M0t6v9gEr2M0EBksOsQ6L16bt4Nffbk
        Fa1m1euZTU6mZ5u07oBrfGwfL
X-Received: by 2002:a17:902:7205:b029:ed:6fc0:bbd4 with SMTP id ba5-20020a1709027205b02900ed6fc0bbd4mr34978949plb.4.1622704494547;
        Thu, 03 Jun 2021 00:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcMf1yi5YrM3ZQ0E6Vd9YMsWvJYGeeRw+gZHSHDc3E71UInsJbTim5M4WExk813zBaqHxkoQ==
X-Received: by 2002:a17:902:7205:b029:ed:6fc0:bbd4 with SMTP id ba5-20020a1709027205b02900ed6fc0bbd4mr34978932plb.4.1622704494247;
        Thu, 03 Jun 2021 00:14:54 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c130sm1454035pfc.51.2021.06.03.00.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 00:14:53 -0700 (PDT)
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To:     Eli Cohen <elic@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, parav@nvidia.com,
        Lingshan Zhu <lingshan.zhu@intel.com>, mapfelba@redhat.com
References: <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
 <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
 <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
 <20210511061740-mutt-send-email-mst@kernel.org>
 <CACGkMEuvqUL04_wHqSKPUufu5O6ydhytHAx0NryLODNHkEO+Fw@mail.gmail.com>
 <20210602103025.GA17279@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c885b2e2-0f90-d215-27c7-02f0d1527991@redhat.com>
Date:   Thu, 3 Jun 2021 15:14:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602103025.GA17279@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/2 下午6:30, Eli Cohen 写道:
> On Wed, May 12, 2021 at 05:24:21PM +0800, Jason Wang wrote:
>
> Michael,
> Did you and Jason came into agreement regarding this?


Probably, let me send a formal patch and see what happens.

Thanks


> Do you think we
> can have the bits in 5.13 and still have time for me to push the vdpa
> too stuff?
>
>
>> On Wed, May 12, 2021 at 3:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Tue, May 11, 2021 at 04:43:13AM -0400, Jason Wang wrote:
>>>>
>>>> ----- 原始邮件 -----
>>>>> 在 2021/4/21 下午4:03, Michael S. Tsirkin 写道:
>>>>>> On Wed, Apr 21, 2021 at 03:41:36PM +0800, Jason Wang wrote:
>>>>>>> 在 2021/4/12 下午5:23, Jason Wang 写道:
>>>>>>>> 在 2021/4/12 下午5:09, Michael S. Tsirkin 写道:
>>>>>>>>> On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
>>>>>>>>>> 在 2021/4/10 上午12:04, Michael S. Tsirkin 写道:
>>>>>>>>>>> On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
>>>>>>>>>>>> 在 2021/4/8 下午11:59, Michael S. Tsirkin 写道:
>>>>>>>>>>>>> On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
>>>>>>>>>>>>>> This patch mandates 1.0 for vDPA devices. The goal is to have the
>>>>>>>>>>>>>> semantic of normative statement in the virtio
>>>>>>>>>>>>>> spec and eliminate the
>>>>>>>>>>>>>> burden of transitional device for both vDPA bus and vDPA parent.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> uAPI seems fine since all the vDPA parent mandates
>>>>>>>>>>>>>> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> For legacy guests, it can still work since Qemu will mediate when
>>>>>>>>>>>>>> necessary (e.g doing the endian conversion).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>>>>>>>> Hmm. If we do this, don't we still have a problem with
>>>>>>>>>>>>> legacy drivers which don't ack 1.0?
>>>>>>>>>>>> Yes, but it's not something that is introduced in this
>>>>>>>>>>>> commit. The legacy
>>>>>>>>>>>> driver never work ...
>>>>>>>>>>> My point is this neither fixes or prevents this.
>>>>>>>>>>>
>>>>>>>>>>> So my suggestion is to finally add ioctls along the lines
>>>>>>>>>>> of PROTOCOL_FEATURES of vhost-user.
>>>>>>>>>>>
>>>>>>>>>>> Then that one can have bits for legacy le, legacy be and modern.
>>>>>>>>>>>
>>>>>>>>>>> BTW I looked at vhost-user and it does not look like that
>>>>>>>>>>> has a solution for this problem either, right?
>>>>>>>>>> Right.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>>> Note 1.0 affects ring endianness which is not mediated in QEMU
>>>>>>>>>>>>> so QEMU can't pretend to device guest is 1.0.
>>>>>>>>>>>> Right, I plan to send patches to do mediation in the
>>>>>>>>>>>> Qemu to unbreak legacy
>>>>>>>>>>>> drivers.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks
>>>>>>>>>>> I frankly think we'll need PROTOCOL_FEATURES anyway, it's
>>>>>>>>>>> too useful ...
>>>>>>>>>>> so why not teach drivers about it and be done with it? You
>>>>>>>>>>> can't emulate
>>>>>>>>>>> legacy on modern in a cross endian situation because of vring
>>>>>>>>>>> endian-ness ...
>>>>>>>>>> So the problem still. This can only work when the hardware can support
>>>>>>>>>> legacy vring endian-ness.
>>>>>>>>>>
>>>>>>>>>> Consider:
>>>>>>>>>>
>>>>>>>>>> 1) the leagcy driver support is non-normative in the spec
>>>>>>>>>> 2) support a transitional device in the kenrel may requires the
>>>>>>>>>> hardware
>>>>>>>>>> support and a burden of kernel codes
>>>>>>>>>>
>>>>>>>>>> I'd rather simply drop the legacy driver support
>>>>>>>>> My point is this patch does not drop legacy support. It merely mandates
>>>>>>>>> modern support.
>>>>>>>> I am not sure I get here. This patch fails the set_feature if VERSION_1
>>>>>>>> is not negotiated. This means:
>>>>>>>>
>>>>>>>> 1) vDPA presents a modern device instead of transitonal device
>>>>>>>> 2) legacy driver can't be probed
>>>>>>>>
>>>>>>>> What I'm missing?
>>>>>>> Hi Michael:
>>>>>>>
>>>>>>> Do you agree to find the way to present modern device? We need a
>>>>>>> conclusion
>>>>>>> to make the netlink API work to move forward.
>>>>>>>
>>>>>>> Thanks
>>>>>> I think we need a way to support legacy with no data path overhead. qemu
>>>>>> setting VERSION_1 for a legacy guest affects the ring format so it does
>>>>>> not really work. This seems to rule out emulating config space entirely
>>>>>> in userspace.
>>>>>
>>>>> So I'd rather drop the legacy support in this case. It never work for
>>>>> vDPA in the past and virtio-vDPA doesn't even need that. Note that
>>>>> ACCESS_PLATFORM is mandated for all the vDPA parents right now which
>>>>> implies modern device and LE. I wonder what's the value for supporting
>>>>> legacy in this case or do we really encourage vendors to ship card with
>>>>> legacy support (e.g endian support in the hardware)?
>>>> Hi Michael:
>>>>
>>>> Any thoughts on this approach?
>>>>
>>>> My understanding is that dropping legacy support will simplify a lot of stuffs.
>>>>
>>>> Thanks
>>> So basically the main condition is that strong memory barriers aren't
>>> needed for virtio, smp barriers are enough.
>>> Are there architectures besides x86 (where it's kind of true - as long as
>>> one does not use non-temporals) where that is true?
>>> If all these architectures are LE then we don't need to worry
>>> about endian support in the hardware.
>> So I agree it's better not to add those stuffs in either qemu or
>> kernel. See below.
>>
>>> In other words I guess yes we could have qemu limit things to x86 and
>>> then just pretend to the card that it's virtio 1.
>>> So endian-ness we can address.
>>>
>>> Problem is virtio 1 has effects beyond this. things like header size
>>> with mergeable buffers off for virtio net.
>>>
>>> So I am inclined to say let us not do the "pretend it's virtio 1" game
>>> in qemu.
>> I fully agree.
>>
>>    Let us be honest to the card about what happens.
>>> But if you want to limit things to x86 either in kernel or in qemu,
>>> that's ok by me.
>> So what I want to do is:
>>
>> 1) mandate 1.0 device on the kernel
>> 2) don't try to pretend transitional or legacy device on top of modern
>> device in Qemu, so qemu will fail to start if vhost-vDPA is started
>> with a legacy or transitional device
>>
>> And this simply the management API which can assume LE for
>> pre-configuration via config space.
>>
>> So if I'm not misunderstanding, we can merge this patch and I can do
>> the Qemu work on top?
>>
>> Thanks
>>
>>>>>
>>>>>> So I think we should add an ioctl along the lines of
>>>>>> protocol features. Then I think we can reserve feature bits
>>>>>> for config space format: legacy LE, legacy BE, modern.
>>>>>
>>>>> We had VHOST_SET_VRING_ENDIAN but this will complicates both the vDPA
>>>>> parent and management. What's more important, legacy behaviour is not
>>>>> restrictied by the spec.
>>>>>
>>>>>
>>>>>> Querying the feature bits will provide us with info about
>>>>>> what does the device support. Acking them will tell device
>>>>>> what does guest need.
>>>>>
>>>>> I think this can work, but I wonder how much we can gain from such
>>>>> complexitiy.
>>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>>>>> to have a simple and easy
>>>>>>>>>> abstarction in the kenrel. For legacy driver in the guest,
>>>>>>>>>> hypervisor is in
>>>>>>>>>> charge of the mediation:
>>>>>>>>>>
>>>>>>>>>> 1) config space access endian conversion
>>>>>>>>>> 2) using shadow virtqueue to change the endian in the vring
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>> I'd like to avoid shadow virtqueue hacks if at all possible.
>>>>>>>>> Last I checked performance wasn't much better than just emulating
>>>>>>>>> virtio in software.
>>>>>>>> I think the legacy driver support is just a nice to have. Or do you see
>>>>>>>> any value to that? I guess for mellanox and intel, only modern device is
>>>>>>>> supported in the hardware.
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>       include/linux/vdpa.h | 6 ++++++
>>>>>>>>>>>>>>       1 file changed, 6 insertions(+)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>>>>>>>>>>> index 0fefeb976877..cfde4ec999b4 100644
>>>>>>>>>>>>>> --- a/include/linux/vdpa.h
>>>>>>>>>>>>>> +++ b/include/linux/vdpa.h
>>>>>>>>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>>>>>>>>       #include <linux/device.h>
>>>>>>>>>>>>>>       #include <linux/interrupt.h>
>>>>>>>>>>>>>>       #include <linux/vhost_iotlb.h>
>>>>>>>>>>>>>> +#include <uapi/linux/virtio_config.h>
>>>>>>>>>>>>>>       /**
>>>>>>>>>>>>>>        * vDPA callback definition.
>>>>>>>>>>>>>> @@ -317,6 +318,11 @@ static inline int
>>>>>>>>>>>>>> vdpa_set_features(struct vdpa_device *vdev, u64
>>>>>>>>>>>>>> features)
>>>>>>>>>>>>>>       {
>>>>>>>>>>>>>>               const struct vdpa_config_ops *ops = vdev->config;
>>>>>>>>>>>>>> +        /* Mandating 1.0 to have semantics of
>>>>>>>>>>>>>> normative statements in
>>>>>>>>>>>>>> +         * the spec. */
>>>>>>>>>>>>>> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
>>>>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>           vdev->features_valid = true;
>>>>>>>>>>>>>>               return ops->set_features(vdev, features);
>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>> --
>>>>>>>>>>>>>> 2.25.1
>>>>>

