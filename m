Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458343B8E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhGAIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234635AbhGAIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625126482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kkO+UX+kTqcYTfctkZezZWjIyhRJe4+TF27ND409mQ=;
        b=J2qV2RZYCbAb7MK5fW02J+Syk+yohBnlzYGZT+HqISyo8gZ0xneDto/vO6UdDIzyka5AWF
        aTgNRFmMvHJk7gMnI8u8mV3+U1yFNF0kMkq2+wgu5mqstFkV2UFQMflnZJtLARWd2Kzvd3
        Qwjj+6FQn242MDHYgi6bgG/Aa9UZU3o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-RGpIk38SONulxYakwZ68_A-1; Thu, 01 Jul 2021 04:01:21 -0400
X-MC-Unique: RGpIk38SONulxYakwZ68_A-1
Received: by mail-pl1-f200.google.com with SMTP id q2-20020a170902e302b0290128ec775274so2372934plc.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3kkO+UX+kTqcYTfctkZezZWjIyhRJe4+TF27ND409mQ=;
        b=tSq7lNDo+xR+QzDfEKAMzbdLQIYFpZxf6HoN6lUQwbd8YJlWxOuaKOgkC++/MMcXZo
         hmrj9r5IXR+7VhQB51h4UDvRiu4iGTVEoB+JFyd25dOIoKNNG9z3K+QMziXpe9w2Ibu0
         oS9Foy/zL+SSnMqewZJ/iruHoiYrqbjp0/sKF8FcyVowf4TtgpF9tt3rcupq1JWOKb7J
         YTdGVRFsgP3SA8vc0I24g5jpY1xY2C81Ti0aENG2mGCxK87fA0jrpTR8dwNfiJx2jDam
         dfHV+krC5kNpytXAEwNt8/wPfUytlaW6ESUbR+jUtrQELdvpSgqZvMJWI6S8Btkukdya
         W7fw==
X-Gm-Message-State: AOAM531R/c5Wf1ueB6/SkgTyRhEn5K7sDRj84e/uCzqdWmj1ID7Bcdmh
        MX6DBi84NGvu/SWvBaFglKpF99R643GYj9dTJDEXC2Hv2ShfeK7bCr/fMjV3wtHObjXKDgp+yuj
        nbpW8g991q19yvTJ9nS98WDR9XYtz9T+s6HhN/Iqg/5tcQiVHkSB3EU4wPHY7SLoqNy+TUzLrhn
        Fx
X-Received: by 2002:a63:794:: with SMTP id 142mr6983334pgh.198.1625126151794;
        Thu, 01 Jul 2021 00:55:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+FJQkpNj2SGJqmkRE0B+JqnTbGGKE300PtWwx2ZJ5+wT2j2YuZ2VlEIodQZCrR0j2AFzwoQ==
X-Received: by 2002:a63:794:: with SMTP id 142mr6983291pgh.198.1625126151412;
        Thu, 01 Jul 2021 00:55:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a6sm23966070pfo.212.2021.07.01.00.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 00:55:50 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To:     Yongji Xie <xieyongji@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <YNSatrDFsg+4VvH4@stefanha-x1.localdomain>
 <CACycT3vaXQ4dxC9QUzXXJs7og6TVqqVGa8uHZnTStacsYAiFwQ@mail.gmail.com>
 <YNw+q/ADMPviZi6S@stefanha-x1.localdomain>
 <CACycT3t6M5i0gznABm52v=rdmeeLZu8smXAOLg+WsM3WY1fgTw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7264cb0b-7072-098e-3d22-2b7e89216545@redhat.com>
Date:   Thu, 1 Jul 2021 15:55:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3t6M5i0gznABm52v=rdmeeLZu8smXAOLg+WsM3WY1fgTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/1 下午2:50, Yongji Xie 写道:
> On Wed, Jun 30, 2021 at 5:51 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> On Tue, Jun 29, 2021 at 10:59:51AM +0800, Yongji Xie wrote:
>>> On Mon, Jun 28, 2021 at 9:02 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>> On Tue, Jun 15, 2021 at 10:13:30PM +0800, Xie Yongji wrote:
>>>>> +/* ioctls */
>>>>> +
>>>>> +struct vduse_dev_config {
>>>>> +     char name[VDUSE_NAME_MAX]; /* vduse device name */
>>>>> +     __u32 vendor_id; /* virtio vendor id */
>>>>> +     __u32 device_id; /* virtio device id */
>>>>> +     __u64 features; /* device features */
>>>>> +     __u64 bounce_size; /* bounce buffer size for iommu */
>>>>> +     __u16 vq_size_max; /* the max size of virtqueue */
>>>> The VIRTIO specification allows per-virtqueue sizes. A device can have
>>>> two virtqueues, where the first one allows up to 1024 descriptors and
>>>> the second one allows only 128 descriptors, for example.
>>>>
>>> Good point! But it looks like virtio-vdpa/virtio-pci doesn't support
>>> that now. All virtqueues have the same maximum size.
>> I see struct vpda_config_ops only supports a per-device max vq size:
>> u16 (*get_vq_num_max)(struct vdpa_device *vdev);
>>
>> virtio-pci supports per-virtqueue sizes because the struct
>> virtio_pci_common_cfg->queue_size register is per-queue (controlled by
>> queue_select).
>>
> Oh, yes. I miss queue_select.
>
>> I guess this is a question for Jason: will vdpa will keep this limitation?
>> If yes, then VDUSE can stick to it too without running into problems in
>> the future.


I think it's better to extend the get_vq_num_max() per virtqueue.

Currently, vDPA assumes the parent to have a global max size. This seems 
to work on most of the parents but not vp-vDPA (which could be backed by 
QEMU, in that case cvq's size is smaller).

Fortunately, we haven't enabled had cvq support in the userspace now.

I can post the fixes.


>>
>>>>> +     __u16 padding; /* padding */
>>>>> +     __u32 vq_num; /* the number of virtqueues */
>>>>> +     __u32 vq_align; /* the allocation alignment of virtqueue's metadata */
>>>> I'm not sure what this is?
>>>>
>>>   This will be used by vring_create_virtqueue() too.
>> If there is no official definition for the meaning of this value then
>> "/* same as vring_create_virtqueue()'s vring_align parameter */" would
>> be clearer. That way the reader knows what to research in order to
>> understand how this field works.
>>
> OK.
>
>> I don't remember but maybe it was used to support vrings when the
>> host/guest have non-4KB page sizes. I wonder if anyone has an official
>> definition for this value?
> Not sure. Maybe we might need some alignment which is less than
> PAGE_SIZE sometimes.


So I see CCW always use 4096, but I'm not sure whether or not it's 
smaller than PAGE_SIZE.

Thanks


>
> Thanks,
> Yongji
>

