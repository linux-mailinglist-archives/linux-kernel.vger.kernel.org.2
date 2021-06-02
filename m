Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122533982FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhFBHbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbhFBHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622619003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AIMJ1wDfcsnadW+2812aa3UstJXUN6qADShYHbFMHI=;
        b=aGC1pFcXT2+RnDXd/2fNjDD55H3ZGzOavgu2Y2MBxf+U4DzZzafCDuEAXwVUhLU84owikL
        8qhwKnXHCKD9YPuJYvZkvR1ERvI8DOg+H1C84BDLoYCztBeINZP5eoSjpBNL+CmA7/W5dy
        1NLKdpSYUoDEvmyuINvY9IPr79B4e7I=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-3yoyqFnkMx2Bs3iHdAgyWw-1; Wed, 02 Jun 2021 03:30:02 -0400
X-MC-Unique: 3yoyqFnkMx2Bs3iHdAgyWw-1
Received: by mail-pg1-f198.google.com with SMTP id d64-20020a6368430000b02902104a07607cso1168978pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6AIMJ1wDfcsnadW+2812aa3UstJXUN6qADShYHbFMHI=;
        b=mMf8m5TuP1fSFkFaLcTuXSOs7wY2/dLG5XdZrIBcxYx2JTaPDN0NHfXJpGVvFa/dHo
         5O2NAyZe6uJ96sKf1rB35P67h53pwebH2D+cMYYOQI02OSpdlVzQxfygLZPJwiFCRYvG
         JJGiw8jGbyDb2lK9l04+9c1q4RSng5eAo0xdyNY7qaM6yofnS//kDNnA3ooqRgk/Tv8n
         FgD2Ab4Lxj6M5wiuXSjg0r8lK0pY/PDt232qQFMrOpNJjGyRyqnrWKgGWHQLGPy8zt1x
         ODfzzpYrhQX/8fshF/ERPc9ddzdoazp2juu9ekW0mdmTUm5Gc+kB5BhkSIKgU1EQaKOS
         chKg==
X-Gm-Message-State: AOAM532WQK0e25VeFe+jg9iC+B/C+5PYMVREPibL7tRttf5xmT2WcJoD
        WRMkPoavODv5osb5J/w1uxw+Wy5RGPtrU1l7+ZJzzTG/dGY4DpjS506s7TJ21Ml40QxAQnQ4fFv
        6ZuGOKPjwTbn4PpCUoNxJZfP5cOjdca/pn2N6wva9Np22qxYHzeGUNDq98SqsiBuDil1HpQAgBf
        tQ
X-Received: by 2002:a17:90a:d70f:: with SMTP id y15mr3389721pju.220.1622619000969;
        Wed, 02 Jun 2021 00:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymYtLtE9oER1yh8UIGEqRJzss30I19zXLCYKDFA2oiIvIAwt1lDsiyl1oPiS6Uodd+VnaxGg==
X-Received: by 2002:a17:90a:d70f:: with SMTP id y15mr3389692pju.220.1622619000630;
        Wed, 02 Jun 2021 00:30:00 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c16sm14933694pfd.206.2021.06.02.00.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 00:30:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160448.31537-1-elic@nvidia.com>
 <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
 <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
 <67b26a20-b418-4893-a42f-f03852c2123e@redhat.com>
 <20210601102129.GB215954@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <76a44f0b-91c7-595b-f3a8-1d07e2f1bc78@redhat.com>
Date:   Wed, 2 Jun 2021 15:29:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601102129.GB215954@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 下午6:21, Eli Cohen 写道:
> On Tue, Jun 01, 2021 at 01:03:36PM +0800, Jason Wang wrote:
>> 在 2021/6/1 下午12:13, Eli Cohen 写道:
>>> On Tue, Jun 01, 2021 at 10:18:04AM +0800, Jason Wang wrote:
>>>> 在 2021/6/1 上午12:04, Eli Cohen 写道:
>>>>> Only return the value of the ready field if the VQ is initialized in
>>>>> which case the value of the field is valid.
>>>>>
>>>>> Failing to do so can result in virtio_vdpa failing to load if the device
>>>>> was previously used by vhost_vdpa and the old values are ready.
>>>>> virtio_vdpa expects to find VQs in "not ready" state.
>>>>>
>>>>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>> ---
>>>>>     drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> index 02a05492204c..f6b680d2ab1c 100644
>>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> @@ -1407,7 +1407,7 @@ static bool mlx5_vdpa_get_vq_ready(struct vdpa_device *vdev, u16 idx)
>>>>>     	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>>>     	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
>>>>> -	return mvq->ready;
>>>>> +	return mvq->initialized && mvq->ready;
>>>> I think the more suitable fix is to reset mvq->ready during reset. The
>>>> vq_ready should follow the queue_enable semantic in virtio-pci:
>>>>
>>>> "
>>>> The device MUST present a 0 in queue_enable on reset.
>>>> "
>>> Thinking again, I think we should call set_vq_ready() from
>>> qemu/virtio_vdpa etc. after reset to explicitly set ready to false.
>>
>> This is not what I read from the spec and how the current driver behave.
>>
>> And I don't see why we need to stick to 1 after the reset.
> Like you said below, this must be clarified by the spec.


I will add this to my todo list.


> Because my
> understanding of the text is that the ready flag is a means for the
> driver to tell the device whether it may or may not execute requests. So
> following this reasoning, the driver should tell the device when ready
> should be zero. As you suggest, after reset.


Another thought, reset should prevent the device from executing requests 
on each queue. In this case, presenting vq_ready to zero make sense. 
Otherwise there would be a conflict.

Thanks


>
> Meanwhile I am going to change the code to reset ready after device
> reset.
>
>>
>>> The ready indication is not necessairily a reflection of the hardware
>>> queue:
>>>
>>> "Virtual queue ready bit
>>> Writing one (0x1) to this register notifies the device that it can
>>> execute requests from this virtual queue. Reading from this register
>>> returns the last value written to it. Both read and write accesses apply
>>> to the queue selected by writing to QueueSel."
>>
>> My understanding that this applies if not reset in the middle. We can
>> clarify this in the spec if needed.
>>
>> Thanks
>>
>>
>>>
>>>> Thanks
>>>>
>>>>
>>>>>     }
>>>>>     static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,

