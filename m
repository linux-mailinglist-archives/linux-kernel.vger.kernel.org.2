Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C7396AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhFACT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhFACTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622513894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qah3pGsHCuXsfTF0OUk7eXsZti9ZWLtXe4xmV52gYbI=;
        b=K/rwQvoTbsGAKQdHRng/nhV4B3jw7bBStbFKFYSfgAp0mnboBDV14yMH8/zG/glaHs19wq
        W0R7zriIUawDn2wDKn+6yN4Eq1la3x8T6kC2ugHscgLnyfFu1azctBNF8Sw1OfFlPm/2Vo
        WWvBUU83SqadVmpTHBn2fLJETUz0Zjc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-yL4i1be9P76stXHJeCjQFg-1; Mon, 31 May 2021 22:18:13 -0400
X-MC-Unique: yL4i1be9P76stXHJeCjQFg-1
Received: by mail-pj1-f72.google.com with SMTP id h32-20020a17090a29a3b0290161dfc5d1bfso997024pjd.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qah3pGsHCuXsfTF0OUk7eXsZti9ZWLtXe4xmV52gYbI=;
        b=HHTRFz2uakqnPI3X8FYHvlZXqTRyI12cRbQoYAofcDXK32WFRIfW6G/dSxMOw/0NqM
         bCNGtyvFINFNKsi7EenqjGcGlM6qGRvggERRr4nzxzrkvfd3BpvkJqxZL5rGE+r2C9lL
         4+R+r5L/pa4/sAxKXskRFCC3qOZEPeYPBRswbkEQBTvbYUC4hWYSd8ey4wx8VGMYeVbQ
         RbmiGIBxPOWw+/3lzUME3I6d6hHRtmoadthqTBDdeCFM4IaWLy8c3BOfUbV/FF/YIpPE
         FIRsHbVR1pjga/M0FtDn4eOULxd9ZlC44jNgtb1ii1YOvZXkH6A+42K4cs9xq0Qb/hFH
         U/Nw==
X-Gm-Message-State: AOAM533FC4eRdKPMF+HziS9MrVdpGYd2Z+Jjb6NDnil0Cb9wGsq6Q8+s
        6yFACUIrsYUz8w/WkV5tBdm4bgFUwZ0BepTr2HarCH2KOL+9gmJ4tzzaJi/9Oo9FNZ95bdLpdg6
        4amOiL4efL0NEVnjGPdMh4BpSw908tA8MEAGOMoUA2DFoZAjkpStvtoJ730Wor57cF30BwvbJ0A
        R5
X-Received: by 2002:aa7:9001:0:b029:2d4:9408:9998 with SMTP id m1-20020aa790010000b02902d494089998mr19494506pfo.9.1622513891632;
        Mon, 31 May 2021 19:18:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyViY/11X5ZmHxcXMbLw20tdAdNdmLZ/NY2hL8pS6mFvRo+xXempO+kgmaKJ7FVMPR7k2FjOA==
X-Received: by 2002:aa7:9001:0:b029:2d4:9408:9998 with SMTP id m1-20020aa790010000b02902d494089998mr19494489pfo.9.1622513891309;
        Mon, 31 May 2021 19:18:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g6sm2679339pfq.110.2021.05.31.19.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 19:18:10 -0700 (PDT)
Subject: Re: [PATCH 2/3] vdpa/mlx5: Only return vq ready if vq is initialized
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160448.31537-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0fbd8484-9e8b-d7cc-4996-74306e6e2867@redhat.com>
Date:   Tue, 1 Jun 2021 10:18:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531160448.31537-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/1 ÉÏÎç12:04, Eli Cohen Ð´µÀ:
> Only return the value of the ready field if the VQ is initialized in
> which case the value of the field is valid.
>
> Failing to do so can result in virtio_vdpa failing to load if the device
> was previously used by vhost_vdpa and the old values are ready.
> virtio_vdpa expects to find VQs in "not ready" state.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 02a05492204c..f6b680d2ab1c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1407,7 +1407,7 @@ static bool mlx5_vdpa_get_vq_ready(struct vdpa_device *vdev, u16 idx)
>   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>   	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
>   
> -	return mvq->ready;
> +	return mvq->initialized && mvq->ready;


I think the more suitable fix is to reset mvq->ready during reset. The 
vq_ready should follow the queue_enable semantic in virtio-pci:

"
The device MUST present a 0 in queue_enable on reset.
"

Thanks


>   }
>   
>   static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,

