Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1B396CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhFAFm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhFAFmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622526072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1NQDpzYkVw3C4qKEnQShbVii8zUQRxdjPHGLNc8HVc=;
        b=DrwbYy7b4SbS/qq9twowAg9u6uRP49vwg30VHGr22DC06/12FCBOz8I2jzIb465TW6yZRN
        fjdntEoNLDFhm3okdJO+Gfoo+EXxiETthy91Thdgk/+Ty+mplwW4JjYPGjljT3KUNAeHA2
        S0U92NQbWhvb1ILQTG0jYSnedd58okM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-S2MfYLJyNoaApgFKwu6weg-1; Tue, 01 Jun 2021 01:41:11 -0400
X-MC-Unique: S2MfYLJyNoaApgFKwu6weg-1
Received: by mail-pj1-f70.google.com with SMTP id h32-20020a17090a29a3b0290161dfc5d1bfso1295717pjd.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C1NQDpzYkVw3C4qKEnQShbVii8zUQRxdjPHGLNc8HVc=;
        b=mh/m99F513HdAYoQNHYUt6BKMgiOD8UIUbr523tIQwGM6DFeAfsGajBtEEcp5EGK5R
         1/QX4PNRyhp0LMQesaeOrZkNlurGP2tV+q3aUcZD2myxab4QFwq29ua21xYPCUWepoFt
         vxhuyeR+/pv4VgE+11KcPVH7VS3P7fgb99WIB1/yNLel6sg1rw2a/gNzXo3XpuHAwb+t
         9nOr3tP7Ff0hEi7foUoX46CfKlBO5vMWDMCe5MqhBcbgLBtyJLL1zqw0HX2P7p1R9KZL
         UqvDbNqIEKeybuR4Z+JRnpTOWQXSlxN3u+1LMd2WW3841DHw4BXp89xhn/F2iP45vxKi
         MbzA==
X-Gm-Message-State: AOAM53190ZZMgr41aJhabG/FNg7qCmTZ5y6I8bN9a2Rs2sNzRBX+VSPX
        6Uo9xFQRFCqQaNdt6TiMZBHfbXIzffHMlTMGJUSgHZ7MEwO96KJsPOt0iUukP3RoQOTzZvmhzCZ
        IO4QeqQv/5tnvj12K7+ZfaMUxYfd8F8/kkW4vEwz0XFVkxjb5CMb/R7dhq3NE74vwF0e7kSWBvl
        kF
X-Received: by 2002:a17:90a:aa0b:: with SMTP id k11mr2974619pjq.153.1622526069905;
        Mon, 31 May 2021 22:41:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVClbCc5D4O+VxgtucOnXx4FQ/UfOs2+Bi5Vn/ZGvK3wa95qutO5mmev48fKsXbYESGPaV2Q==
X-Received: by 2002:a17:90a:aa0b:: with SMTP id k11mr2974589pjq.153.1622526069526;
        Mon, 31 May 2021 22:41:09 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a15sm12044118pff.128.2021.05.31.22.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 22:41:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio/vdpa: Clear the available index during probe
From:   Jason Wang <jasowang@redhat.com>
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160502.31610-1-elic@nvidia.com>
 <2a0a106c-af92-37b7-84de-5754b8ac645b@redhat.com>
Message-ID: <70d6217d-3722-156b-fac0-620129bc3e56@redhat.com>
Date:   Tue, 1 Jun 2021 13:40:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <2a0a106c-af92-37b7-84de-5754b8ac645b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 上午10:20, Jason Wang 写道:
>
> 在 2021/6/1 上午12:05, Eli Cohen 写道:
>> Clear the available index as part of the initialization process to
>> clear and values that might be left from previous usage of the device.
>> For example, if the device was previously used by vhost_vdpa and now
>> probed by vhost_vdpa, you want to start with indices.
>>
>> Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")
>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>> ---
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Note that we probably need a follow-up fixes for vp_vdpa driver.
>
> I will post it soon.
>
> Thanks


Hi Eli:

Rethink about this, it only works for the case of split virtqueue.

I will post a series that makes it work for both packed and split 
virtqueue (with some tweak on this patch).

Does this work for you?

Thanks


>
>
>>   drivers/virtio/virtio_vdpa.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>> index e28acf482e0c..32fb121a6ec4 100644
>> --- a/drivers/virtio/virtio_vdpa.c
>> +++ b/drivers/virtio/virtio_vdpa.c
>> @@ -142,6 +142,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, 
>> unsigned int index,
>>       struct vdpa_callback cb;
>>       struct virtqueue *vq;
>>       u64 desc_addr, driver_addr, device_addr;
>> +    struct vdpa_vq_state state = {0};
>>       unsigned long flags;
>>       u32 align, num;
>>       int err;
>> @@ -191,6 +192,11 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, 
>> unsigned int index,
>>           goto err_vq;
>>       }
>>   +    /* reset available index */
>> +    err = ops->set_vq_state(vdpa, index, &state);
>> +    if (err)
>> +        goto err_vq;
>> +
>>       ops->set_vq_ready(vdpa, index, 1);
>>         vq->priv = info;

