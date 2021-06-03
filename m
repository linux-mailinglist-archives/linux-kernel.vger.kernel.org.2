Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F4399BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFCHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFCHjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622705853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pn+lH6sffLfQFOlhNqIHBoOQtQXxd+QKLAWzZG0wEls=;
        b=jNLHu0GfIUerSFeF4wboz6siqDqNoK2jruC9s+rULYR1YGk/iDpbY7a+oNADGY/Giou6yn
        PTM6wFgpiFMlHPyxc3Mc9PKhbAVgN8oNT7WvMHh9YAjWeuz32xLQylEq9iygFat0hRXcO6
        a0MdK91Tgup3QRY+OuZHC/sc4+E1Q6c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-pVBGelepNxKgy42jXkCocQ-1; Thu, 03 Jun 2021 03:37:32 -0400
X-MC-Unique: pVBGelepNxKgy42jXkCocQ-1
Received: by mail-pg1-f197.google.com with SMTP id 4-20020a6317440000b029021689797ccaso3462247pgx.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 00:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pn+lH6sffLfQFOlhNqIHBoOQtQXxd+QKLAWzZG0wEls=;
        b=Q/4/CvpNvQVGuVpN2xmwEfv/86IOkYIZAysA4KWH/KmA/ZrDSF28Ybqowlf74CYHio
         qXiwMLQ0Lq05XrQy+z/OgIe4SGr2CITT3sMsacszbb1hJ1iMp8pQQgBTTqAPLt3orcdd
         Ub7Q62sjdyO/SRPhJK/6pGpvTQVtQO0Y2o0AnA5E/D+OPXXFIhNiU6aVprL2sUSlheYV
         KEdpSRtGFbGYQnsrawSgFLtmvAMIgHqOBQjlzo8i/EIMyDxu9OQWhHmQCFR8ntdjT69Y
         EL90GWsRaEmTj3CimNmWYQzwslCIVpee7528DJ7mNV0bfppo0SNgaXM5Kohij2o73gE8
         rPWQ==
X-Gm-Message-State: AOAM531Y+V4h8FCf5pUAgn5FK1jQCaPrGiqcLL8Bg/t8X6+7VdGYdvVU
        2qjI0sN/30ZnBaKIT/DpfUuL2MIMSU+Y4+HnAI1627VxEWx/MNOpTklbDnyVQmabIB8Js+irqOg
        mYZZZboswzQfxmL6T8UeQhez99MeyiRMO9H2vxJCOqPCOZ4rpqZqxj9/OZO+T1pO38/tivuHSFx
        Ap
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr35351566pjb.52.1622705851266;
        Thu, 03 Jun 2021 00:37:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTqWD/nEiY9eQgpWpCRmj0CbNPmYM6Y2ORnmD/a5cBt9X5O5wta2GGPKhK8EoVnMkzO6bZ9Q==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr35351532pjb.52.1622705850859;
        Thu, 03 Jun 2021 00:37:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s15sm1404541pjr.18.2021.06.03.00.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 00:37:30 -0700 (PDT)
Subject: Re: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210602085924.62777-1-elic@nvidia.com>
 <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
 <782562f2-6903-68cb-d753-ac90aea854e4@redhat.com>
 <20210603073046.GA58414@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <af2561a4-7b46-3c0c-2956-f5dd37577b8d@redhat.com>
Date:   Thu, 3 Jun 2021 15:37:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603073046.GA58414@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 下午3:30, Eli Cohen 写道:
> On Thu, Jun 03, 2021 at 03:06:31PM +0800, Jason Wang wrote:
>> 在 2021/6/3 下午3:00, Jason Wang 写道:
>>> 在 2021/6/2 下午4:59, Eli Cohen 写道:
>>>> After device reset, the virtqueues are not ready so clear the ready
>>>> field.
>>>>
>>>> Failing to do so can result in virtio_vdpa failing to load if the device
>>>> was previously used by vhost_vdpa and the old values are ready.
>>>> virtio_vdpa expects to find VQs in "not ready" state.
>>>>
>>>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5
>>>> devices")
>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>
>> A second thought.
>>
>> destroy_virtqueue() could be called many places.
>>
>> One of them is the mlx5_vdpa_change_map(), if this is case, this looks
>> wrong.
> Right, although most likely VQs become ready only after all map changes
> occur becuase I did not encounter any issue while testing.


Yes, but it's not guaranteed that the map won't be changed. Userspace 
can update the mapping when new memory is plugged into the guest for 
example.


>> It looks to me it's simpler to do this in clear_virtqueues() which can only
>> be called during reset.
> There is no clear_virtqueues() function. You probably mean to insert a
> call in mlx5_vdpa_set_status() in case it performs reset. This function
> will go over all virtqueues and clear their ready flag.


Right.


>
> Alternatively we can add boolean argument to teardown_driver() that
> signifies if we are in reset flow and in this case we clear ready.


Yes, but doing in set_status() seems easier.

Thanks


>
>> Thanks
>>
>>
>>>
>>>> ---
>>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> index 02a05492204c..e8bc0842b44c 100644
>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> @@ -862,6 +862,7 @@ static void destroy_virtqueue(struct
>>>> mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
>>>>            return;
>>>>        }
>>>>        umems_destroy(ndev, mvq);
>>>> +    mvq->ready = false;
>>>>    }
>>>>      static u32 get_rqpn(struct mlx5_vdpa_virtqueue *mvq, bool fw)

