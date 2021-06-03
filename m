Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D4399B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCHI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhFCHI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622704002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SF0GJBKw3q/Jw1E8kxVF3Zvky/XXDj5sAnakkxfvBnI=;
        b=PPqp21WlOvjzbHUBXmoBpL9F7xPt4y4jGC8osLfHqJj6HOHyN6QgY9qvgzTQKdT9As/8+x
        VFd1wQ9E1+4uwyNVNC1ksjwPgAH1l0/gbdWU3U6cXWebX5aqDSpIk0IYLdEcKUsaFM/IBm
        TETVKLVNkMCsDotvzZ8cAu44XQac1DM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-N8AgkOvrPEC7ZmNWspW0Qw-1; Thu, 03 Jun 2021 03:06:40 -0400
X-MC-Unique: N8AgkOvrPEC7ZmNWspW0Qw-1
Received: by mail-pj1-f69.google.com with SMTP id ot14-20020a17090b3b4eb029016677cc42f4so4880854pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 00:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SF0GJBKw3q/Jw1E8kxVF3Zvky/XXDj5sAnakkxfvBnI=;
        b=dfRzcoF1+pYyaGpzq/I7XJZg5FUTujMj7mK7RwYCMU+IxxcM+LLq5AF3MPuml5aYk/
         YoFLSc8YztVYtVbSW6YEAzq/iuyUIyKPioxqaloxfOuyRTJzo+l1SymNUkXJPSJOQZWD
         W/xz0VazMglv4Siy+QvpInIxIT444h1jE+gLcNCayIQPcMSRBFXijHlJr4zUvHZABPoR
         7WX2fOOZ57UdPzV6K1siMMr69QfZGxK6u7tJmSZQ7uvyDzQ3z8NHBM0cPQzSZm7g0X6O
         ANigCbXMav/LH1dhj8UaNMC9+X9LDQHBhcic8hyKVWtsI9bbNn4UhAiflHNy3luAXcEx
         Om3Q==
X-Gm-Message-State: AOAM532016isxpqLhHZ2ufNkB7b38jMc21as9RG/jJkrddtyWQwBrgVW
        0LnizrFjwTFoEd+b9ttWoT1pIeS27UX0qdV6ppaXSxMxAJnYToVwKkv/mbGrWTyCZLIVZk/KO1r
        ZjJ9EbwDUz0iCVFnWogGdX09kWHF7duvX39+CvyvhqziXJJJhDgs+OtwZI+sXJtbnXcPoD23Cmv
        Bx
X-Received: by 2002:a65:42ca:: with SMTP id l10mr19171761pgp.292.1622703999259;
        Thu, 03 Jun 2021 00:06:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZiFb1hA1pmoeWkKaUGcYoPZ+R5gUyE5hjaV9RB2NucArkemqf0Uhd+HyX3eLWIlcSICxZRQ==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr19171717pgp.292.1622703998703;
        Thu, 03 Jun 2021 00:06:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h8sm1448553pfn.0.2021.06.03.00.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 00:06:38 -0700 (PDT)
Subject: Re: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
From:   Jason Wang <jasowang@redhat.com>
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210602085924.62777-1-elic@nvidia.com>
 <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
Message-ID: <782562f2-6903-68cb-d753-ac90aea854e4@redhat.com>
Date:   Thu, 3 Jun 2021 15:06:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 下午3:00, Jason Wang 写道:
>
> 在 2021/6/2 下午4:59, Eli Cohen 写道:
>> After device reset, the virtqueues are not ready so clear the ready
>> field.
>>
>> Failing to do so can result in virtio_vdpa failing to load if the device
>> was previously used by vhost_vdpa and the old values are ready.
>> virtio_vdpa expects to find VQs in "not ready" state.
>>
>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 
>> devices")
>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>


A second thought.

destroy_virtqueue() could be called many places.

One of them is the mlx5_vdpa_change_map(), if this is case, this looks 
wrong.

It looks to me it's simpler to do this in clear_virtqueues() which can 
only be called during reset.

Thanks


>
>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 02a05492204c..e8bc0842b44c 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -862,6 +862,7 @@ static void destroy_virtqueue(struct 
>> mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
>>           return;
>>       }
>>       umems_destroy(ndev, mvq);
>> +    mvq->ready = false;
>>   }
>>     static u32 get_rqpn(struct mlx5_vdpa_virtqueue *mvq, bool fw)

