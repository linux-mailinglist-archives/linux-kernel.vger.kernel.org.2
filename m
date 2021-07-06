Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465BD3BC4D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGFCjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhGFCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625538996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+t7xgkqb9EDjx9o5Ws18UiODNH1rDl4lfk/LxQtMlSA=;
        b=NK1wWH9rkxnLR90cVUEJvjdzPPWivwMByGT4WlcH+tLWv9MXsOH3DCeWyj1AvcFV1RhD5v
        /4ArBIKBGrjp2Fs/afVTCZ7zsETFCTjOvLjaMDQpupHeZABrkp99BlwzVMdZf62AwZQ0Re
        feG5WCCrjA7oP1reqYNXzlS0V9RzP1k=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-PVqHV2caP3ePnbO9BRPxiw-1; Mon, 05 Jul 2021 22:36:35 -0400
X-MC-Unique: PVqHV2caP3ePnbO9BRPxiw-1
Received: by mail-oo1-f72.google.com with SMTP id z6-20020a4ab6060000b029024c2413e5c6so9539206oon.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 19:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+t7xgkqb9EDjx9o5Ws18UiODNH1rDl4lfk/LxQtMlSA=;
        b=PjK79kDAi/2GQs6Ddee37BZYqg1GOXIuHKKHGzGWJeLpW+QH7wPDC6fUeoaIR4kzee
         OU90hYdZelm4qwlhcIihEB4loZx3CVcYp9gWaQVJt6zVOANvYlH0Cy+XVMy63zcMX79J
         cK3Vh5+HgchwpZP/xHp7idv/mBjQb5Q5HkFVuTKD6FfEicLSR6zF77Ut1eXMOowqpdYN
         2zTbVdREkiDyAe2Q54z4UhRro72fAvmyRVHm4rbd8m+w66cDdTOu5s+lRB5ZNxcxuIJj
         Xh16V+5ry/tp7J2DOSi1eqyh5Xl4sML9P50QgNH+wBso6+ecym6j3+2IpZcYRLqr0+R/
         kaAw==
X-Gm-Message-State: AOAM533ScWiQxJgY9rpX55lcwNBAnMAUxxoHoLJBDzkPyddxyw3vU5Eb
        4s210Ad2gt77LC4QTF9bOCc5vSGKJgn/cEioOofcXfJbE6ubFxSJDcoNy22EDT8fryPJZW2i//w
        ey6KmypbuHJAtVZ/XgY1zhC7i
X-Received: by 2002:a17:90b:124f:: with SMTP id gx15mr2053893pjb.8.1625538664049;
        Mon, 05 Jul 2021 19:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGJ3C4PIS2j1yjac50lMKMZ06m91aoC+A1GrgZ9KMYDd3ldGiJnB8VFZ5kPGCmj4zRcWEfnQ==
X-Received: by 2002:a17:90b:124f:: with SMTP id gx15mr2053875pjb.8.1625538663867;
        Mon, 05 Jul 2021 19:31:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d25sm13862589pgn.42.2021.07.05.19.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 19:31:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] vdpa: vp_vdpa: don't use hard-coded maximum virtqueue
 size
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, xieyongji@bytedance.com,
        stefanha@redhat.com
References: <20210705071910.31965-1-jasowang@redhat.com>
 <20210705071910.31965-2-jasowang@redhat.com>
 <20210705032602-mutt-send-email-mst@kernel.org>
 <02139c5f-92c5-eda6-8d2d-8e1b6ac70f3e@redhat.com>
 <20210705065534-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e0744583-fcdc-07d0-a414-31d660089e2b@redhat.com>
Date:   Tue, 6 Jul 2021 10:30:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705065534-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/6 上午1:59, Michael S. Tsirkin 写道:
> On Mon, Jul 05, 2021 at 03:29:47PM +0800, Jason Wang wrote:
>> 在 2021/7/5 下午3:26, Michael S. Tsirkin 写道:
>>> On Mon, Jul 05, 2021 at 03:19:10PM +0800, Jason Wang wrote:
>>>> This patch switch to read virtqueue size from the capability instead
>>>> of depending on the hardcoded value. This allows the per virtqueue
>>>> size could be advertised.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> So let's add an ioctl for this? It's really a bug we don't..
>>
>> As explained in patch 1. Qemu doesn't use VHOST_VDPA_GET_VRING_NUM actually.
>> Instead it checks the result VHOST_VDPA_SET_VRING_NUM.
>>
>> So I change VHOST_VDPA_GET_VRING_NUM to return the minimal size of all the
>> virtqueues.
>>
>> If you wish we can add a VHOST_VDPA_GET_VRING_NUM2, but I'm not sure it will
>> have a user or not.
>>
>> Thanks
> Question is how do we know returning the minimal and not e.g. the max
> size is the right thing to do?


For the new ioctl, it will return the max queue size per vq.

It's probably too late to fix the old one, so it's only safe to return 
the minimal one.

Actually, most of the vDPA parents should be fine except for the 
vp_vdpa. When running in a nested environment, Qemu only advertise cvq 
with 64 entries.

Thanks


>
>
>>>> ---
>>>>    drivers/vdpa/virtio_pci/vp_vdpa.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>> index 2926641fb586..198f7076e4d9 100644
>>>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>> @@ -18,7 +18,6 @@
>>>>    #include <linux/virtio_pci.h>
>>>>    #include <linux/virtio_pci_modern.h>
>>>> -#define VP_VDPA_QUEUE_MAX 256
>>>>    #define VP_VDPA_DRIVER_NAME "vp_vdpa"
>>>>    #define VP_VDPA_NAME_SIZE 256
>>>> @@ -197,7 +196,10 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>>>>    static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa, u16 qid)
>>>>    {
>>>> -	return VP_VDPA_QUEUE_MAX;
>>>> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>>>> +	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
>>>> +
>>>> +	return vp_modern_get_queue_size(mdev, qid);
>>>>    }
>>>>    static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
>>>> -- 
>>>> 2.25.1

