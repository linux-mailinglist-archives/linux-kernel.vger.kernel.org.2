Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F11939D2D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhFGCOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 22:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhFGCOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623031932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GHvZi0Hu8bvsfMDpX0vr7h/j/v59gu9iThhVOJvcjU=;
        b=dHwqgLtKVkn8/R3i08iGd4/MCMkzcR1EgyaOdDqc1cPSIHL54fxwXoGLxkRjBL6Pbg9q+r
        qWPa4HzhHVMR/uyLc6C9Ul/ytwwAS6VSUjVlL4+XDsR/9tWFLHHuLKxU1TGpoVI+PaxwJC
        X9ihPD5fKRujyu4aoGd1jjyjMt1XzKQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-N99-4dnHPUmnqkyPVah9Iw-1; Sun, 06 Jun 2021 22:12:11 -0400
X-MC-Unique: N99-4dnHPUmnqkyPVah9Iw-1
Received: by mail-pj1-f72.google.com with SMTP id u11-20020a17090a1d4bb029016df2fceb76so2766937pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 19:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1GHvZi0Hu8bvsfMDpX0vr7h/j/v59gu9iThhVOJvcjU=;
        b=WEl3PnP5DoKVB8A7d3IpAk+wIcveafw8+aO0Xu0AngZ5PF1ia0ksXEnRtwLEQTcQRg
         6ohMv6t7hwqOkrRA9RTP4TZJj36N8an799ZOdBrIpOQl7UPcmx7P3jKi38BCx+yoVTSO
         MwqzG8TCZzvnZnTqYhjIKYYxYNnqZ5V3FGL0ZHUxbV+R9TQ3/+A42SxITRzmcmsH82D/
         /sWvJ5CnKQFccPDYRKyqzzo4XLJUuhQyJChWtnchTTVI/MoJ83SazT7TVnSH3AdVmibd
         QjISM6ikaOlqj6EfW4IAeCp7cb3HRDNqv2E6mscfyy9/sYjO/xhf+5IarwpKbfhgmWJ6
         tIiQ==
X-Gm-Message-State: AOAM533RiBBegV8sC9k1aP/yoCkD7Tg8lnvdUomYLg4l9cCC6do4xaZl
        67xpISno0JVPRYxTV+d1fKKJiSvCnGV+9F5T8eHdXk/YHQ2NXkS2vcJyOz4vuAOc2p8EGHT0rsG
        ZLQqZDDI55xkGxTWrdN2oJCWay7rTkFdCQmls8tEmuN2mv7J1k51T0IkgpEuy4gqa5QXRUO5qm/
        6U
X-Received: by 2002:aa7:9491:0:b029:2ed:2787:be36 with SMTP id z17-20020aa794910000b02902ed2787be36mr8154621pfk.43.1623031929953;
        Sun, 06 Jun 2021 19:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk8i6NVq+YGcz1/Ru/wEpcsxv/kHrMFUEev1UCldIKwxQ4GZDyPeEjNVZOTCVY349/iC9K/Q==
X-Received: by 2002:aa7:9491:0:b029:2ed:2787:be36 with SMTP id z17-20020aa794910000b02902ed2787be36mr8154609pfk.43.1623031929662;
        Sun, 06 Jun 2021 19:12:09 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y138sm6935458pfc.11.2021.06.06.19.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 19:12:09 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa/mlx5: Clear vq ready indication upon device reset
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210606053128.170399-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6f257eb1-c3ff-c17c-c937-7cc7f945f22d@redhat.com>
Date:   Mon, 7 Jun 2021 10:12:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606053128.170399-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/6 ÏÂÎç1:31, Eli Cohen Ð´µÀ:
> After device reset, the virtqueues are not ready so clear the ready
> field.
>
> Failing to do so can result in virtio_vdpa failing to load if the device
> was previously used by vhost_vdpa and the old values are ready.
> virtio_vdpa expects to find VQs in "not ready" state.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> v0 --> v1:
>     Make sure clear of ready is done only in reset flow
> v1 --> v2:
>     use ascending loop iterator to avoid confusion
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 02a05492204c..a42db592e7bb 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1766,6 +1766,14 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
>   	mutex_unlock(&ndev->reslock);
>   }
>   
> +static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
> +		ndev->vqs[i].ready = false;
> +}
> +
>   static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   {
>   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -1776,6 +1784,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   	if (!status) {
>   		mlx5_vdpa_info(mvdev, "performing device reset\n");
>   		teardown_driver(ndev);
> +		clear_vqs_ready(ndev);
>   		mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   		ndev->mvdev.status = 0;
>   		ndev->mvdev.mlx_features = 0;

