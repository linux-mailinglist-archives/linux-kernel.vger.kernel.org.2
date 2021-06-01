Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49260396C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFAFF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhFAFF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622523826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G4xPXgmRao4zlx3pSRsI1OzlbqWv379yzh8jVfWIHn8=;
        b=WJxMDbMxCe6upgAX6wGoQsCkAa/VFgZ8laf7/NCDPpS8bhasnBBtxP8hoR90M4pXdijCxw
        lzijo34+hntL6EgW1sdU1/cSvfIbr8TKtAg/hsHdk7+xZG0Ok/oWVDv6Boy9AbaeC8PgkZ
        8pR3xWRSnjdwHkULsdY8ZCmxgquL7YY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-q9ni1opnOGW408eUX4d-OA-1; Tue, 01 Jun 2021 01:03:45 -0400
X-MC-Unique: q9ni1opnOGW408eUX4d-OA-1
Received: by mail-pj1-f72.google.com with SMTP id hf1-20020a17090aff81b02901630f822d2aso880105pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=G4xPXgmRao4zlx3pSRsI1OzlbqWv379yzh8jVfWIHn8=;
        b=Oquz82djAwH09RYkwnNr8I99/IVQzb2I0cc6ZdChtBwMw9P0c3SuT7mqPryUFj1fh7
         eA+bqeScNPofroTR0vju+5jjqCWl1UUAm0iSsAegf8Le0apP+Miwu2tIIyfZMbXgaet8
         P/3msy+zPj/cDSdv8/uUv/7sH0z1evjQBQSxmHzcSrI9Dbnl+NlvZfyEVnOcfSW2LFMI
         2BvHd8UMxHZRTYHgH+UG3egGde66AoOTD5Vge+VSH0gS1f11f0tY/1jQtI4+7t+w8d6s
         2f+AioOWWcsrIkAoGoGpBuKwaA9qqssqSRfJ8eOpDZemXPjIiznjgSfxhgOXGTqejtZE
         erAA==
X-Gm-Message-State: AOAM532xnMA2CxZ+auYuokSSXUSThrbmscy4qcx4tfKKDdBHnd822dz4
        BSO04XrEb/huPQN6I+ySBoTnJb7K1OKgOqa/7EW8xv0ZkwVxu6WsdjslFYI/XppwrNF210wysCU
        BFssw1yA1iZvunWZ8eqh8k0egVHATrxUH2No/IurzBV1qfHcOhsR/r6wqr2SNmN1Ht842zTOxr5
        8m
X-Received: by 2002:a17:902:a40f:b029:fe:fee9:92fe with SMTP id p15-20020a170902a40fb02900fefee992femr22714904plq.26.1622523824134;
        Mon, 31 May 2021 22:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLVOUMSb6U/UchT8myrtUaWkyYyY5luHhLO64YPIyhDNndX7GsRByxJqGUxTQndQBf5UjwoA==
X-Received: by 2002:a17:902:a40f:b029:fe:fee9:92fe with SMTP id p15-20020a170902a40fb02900fefee992femr22714873plq.26.1622523823808;
        Mon, 31 May 2021 22:03:43 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n17sm1545604pfv.125.2021.05.31.22.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 22:03:43 -0700 (PDT)
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160448.31537-1-elic@nvidia.com>
 <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
 <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <67b26a20-b418-4893-a42f-f03852c2123e@redhat.com>
Date:   Tue, 1 Jun 2021 13:03:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601041351.GC203469@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 下午12:13, Eli Cohen 写道:
> On Tue, Jun 01, 2021 at 10:18:04AM +0800, Jason Wang wrote:
>> 在 2021/6/1 上午12:04, Eli Cohen 写道:
>>> Only return the value of the ready field if the VQ is initialized in
>>> which case the value of the field is valid.
>>>
>>> Failing to do so can result in virtio_vdpa failing to load if the device
>>> was previously used by vhost_vdpa and the old values are ready.
>>> virtio_vdpa expects to find VQs in "not ready" state.
>>>
>>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 02a05492204c..f6b680d2ab1c 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1407,7 +1407,7 @@ static bool mlx5_vdpa_get_vq_ready(struct vdpa_device *vdev, u16 idx)
>>>    	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>    	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
>>> -	return mvq->ready;
>>> +	return mvq->initialized && mvq->ready;
>>
>> I think the more suitable fix is to reset mvq->ready during reset. The
>> vq_ready should follow the queue_enable semantic in virtio-pci:
>>
>> "
>> The device MUST present a 0 in queue_enable on reset.
>> "
> Thinking again, I think we should call set_vq_ready() from
> qemu/virtio_vdpa etc. after reset to explicitly set ready to false.


This is not what I read from the spec and how the current driver behave.

And I don't see why we need to stick to 1 after the reset.


>
> The ready indication is not necessairily a reflection of the hardware
> queue:
>
> "Virtual queue ready bit
> Writing one (0x1) to this register notifies the device that it can
> execute requests from this virtual queue. Reading from this register
> returns the last value written to it. Both read and write accesses apply
> to the queue selected by writing to QueueSel."


My understanding that this applies if not reset in the middle. We can 
clarify this in the spec if needed.

Thanks


>
>
>> Thanks
>>
>>
>>>    }
>>>    static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,

