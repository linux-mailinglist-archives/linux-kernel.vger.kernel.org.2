Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F6E39B07C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFDChw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhFDChw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622774166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6UjoDdlJiC6Yn9pHe8qyqTWIaVoNYoyg0T0P15ZZCk=;
        b=B9T7QQaEEZu6ag51U2Y7ycqtRGhNTef8hvw9r6FOo5O7aPtrTVG8w25pH2W26RSv84ec2L
        VnX03UePi823h0JAxA8jUR2A7XHIBGkDYdemdUoua7TPmFWxqB2LL4R+eWjFWEWHiG6CKF
        6Aw9K/QrA5XwBI9e5222fGbGpqY0tzk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-CmoVyd63M6SNrmCe9VeZPQ-1; Thu, 03 Jun 2021 22:36:04 -0400
X-MC-Unique: CmoVyd63M6SNrmCe9VeZPQ-1
Received: by mail-pl1-f197.google.com with SMTP id t2-20020a170902b202b02900ec9b8c34b6so3458753plr.15
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n6UjoDdlJiC6Yn9pHe8qyqTWIaVoNYoyg0T0P15ZZCk=;
        b=TeskFIFMj0Hu8DOIUxrvvC4a3fQ9IzNfz0xYiFVb1af3FpdG11+WOFxnJc46Av5giF
         L7rUMlAJywe+wtTvnv6YB4pexGsalA5WTx3EsdNCmyD/bLaYz34y24t43jl+a3q2xjmG
         rbrmgAFOyYQGELejfBLDCZGencxqgb/TwpdVyx5ithTBdTj4rqCnMXB/ote2MKEDFnV6
         +k+ZkXbRECgrVHtcDtug8v9F2AdPrzamvLj3NDr8tdpWfZl9no2Jn5/HpZo0Cg/Ukzr5
         1BNh6PDPvekzIJ3zXJqGLLV0tCYlejOrUh3V2lSatrw7DkvX8qlTrqDU/obJU1OYUtO3
         2BLw==
X-Gm-Message-State: AOAM531FQ/QCdNmIvRroqyPE+pCnTrNQrNwKxfmQkrRqsZWx0/oAJf9g
        akq1fizFyghtS6BhUAQyAg8as7cbRKl/qVnQV+fAjZgDJvhuDULrpoyeAxRCRSrdCg8/G5SRene
        ZkBJns9N+mNDsCmCoCLL0mixukPQSI8bSnFX/qkhEZev+t0FijJYDyIToJDmIbIgl1u9h0RTTrx
        XE
X-Received: by 2002:a17:90b:4d86:: with SMTP id oj6mr14439104pjb.41.1622774163621;
        Thu, 03 Jun 2021 19:36:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOvO94kC9a5yxmAdnPqn6EgGnSeSnL9Vn9YzNj8RL5DzWTWWDt9P02tNGSg/9icFWwvCQ9fA==
X-Received: by 2002:a17:90b:4d86:: with SMTP id oj6mr14439081pjb.41.1622774163299;
        Thu, 03 Jun 2021 19:36:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y205sm322100pfb.53.2021.06.03.19.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 19:36:02 -0700 (PDT)
Subject: Re: [PATCH] vdp/mlx5: Fix setting the correct dma_device
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210603112215.69259-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com>
Date:   Fri, 4 Jun 2021 10:35:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603112215.69259-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/3 ÏÂÎç7:22, Eli Cohen Ð´µÀ:
> Before SF support was introduced, the DMA device was equal to
> mdev->device which was in essence equal to pdev->dev;
> With SF introduction this is no longer true. It has already been
> handled for vhost_vdpa since the reference to the dma device can from
> within mlx5_vdpa. With virtio_vdpa this broke. To fix this we set the
> real dma device when initializing the device.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")


Note sure this is correct, according to the commit log it should be the 
patch that introduces the SF or aux bus support for vDPA.


> Signed-off-by: Eli Cohen <elic@nvidia.com>


Patch looks correct.

Thanks


> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index bc33f2c523d3..a4ff158181e0 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2046,7 +2046,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>   	if (err)
>   		goto err_mtu;
>   
> -	mvdev->vdev.dma_dev = mdev->device;
> +	mvdev->vdev.dma_dev = &mdev->pdev->dev;
>   	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>   	if (err)
>   		goto err_mtu;

