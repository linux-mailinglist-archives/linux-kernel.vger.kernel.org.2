Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9922395024
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhE3IjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3IjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622363865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7rqctKhoICHjp9iSUtNIx5KUFyzc0TpaGiXHDc7I/jo=;
        b=aNM785XsMNk0UtUZ0UBhPiY3U8NzowvP+xLOrQscQBl2OzjQCGuk+26I/pIExfChObEUXw
        mTD16jJcZtDLGmp+WDHlOmLLc4qMKB9/WW7k3IymhrbSUzp5QZvayRTb3DIvh80mWL5ewy
        2zJah9R1i70a96qcCIPgfSnAtXo5J08=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Qc2jA85XMvuulAIfRT47GQ-1; Sun, 30 May 2021 04:37:44 -0400
X-MC-Unique: Qc2jA85XMvuulAIfRT47GQ-1
Received: by mail-wm1-f70.google.com with SMTP id o10-20020a05600c4fcab029014ae7fdec90so1996300wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7rqctKhoICHjp9iSUtNIx5KUFyzc0TpaGiXHDc7I/jo=;
        b=szZ78Z3nWYzU7sJaS4cIdaoolw+FyI8lQDY7utMvlOvAIeYmlp06DarUlFlPvj13F7
         ht0OZpAkqKrSFNFJeIkyG49dDDZ2PsmO7mc1yMJOtVWzUiazljTDwrBsHTIA+KRx0gLw
         Z5JciR+SVU086SQA8BirAxwSGjQopk7CLs3hiUkKyiljSpJKgh89krkGOBNAUA0ysjzw
         v7lJOGEcuyYsPiXik+ubSqoJZCpV5OECtTMXHKwU3hGOKQ5bGA9BUadxuQYZu3L5B/08
         SbYLD7JJYB7ZXcVcFJ8G3Bsi9/gVJNY9qFtqSicBgStGJunRpuI1xT3JUAC67ujPEDyc
         QZSw==
X-Gm-Message-State: AOAM532lW0nXNsz4so7X6pbfkTT9aJiWHEKF0oglC7OOmp4rhhuFPAID
        rj2vEgHmo7hKRIILa/de7+kPg2D/k8B453HmqpLoCwpcmH5AVxD4ysLzauPPM6SpBRipHelk/Qy
        wF1Oe0WeSBmflOSQMw30WCb8k
X-Received: by 2002:adf:d841:: with SMTP id k1mr10069383wrl.193.1622363862712;
        Sun, 30 May 2021 01:37:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1U8xwRNt+X8PjA3ahWySkMBG5NHinYPh7n/TG9N62+RkeXncyT1J8vzojlFGX7/MoL/Bj1w==
X-Received: by 2002:adf:d841:: with SMTP id k1mr10069373wrl.193.1622363862586;
        Sun, 30 May 2021 01:37:42 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
        by smtp.gmail.com with ESMTPSA id 25sm2268339wmk.20.2021.05.30.01.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:37:42 -0700 (PDT)
Date:   Sun, 30 May 2021 04:37:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530043721-mutt-send-email-mst@kernel.org>
References: <20210530083548.6545-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530083548.6545-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 11:35:48AM +0300, Eli Cohen wrote:
> Fix copy paste bug assigning umem1 size to umem2 and umem3. The issue
> was discovered when trying to use a 1:1 MR that covers the entire
> address space where firmware complained that provided sizes are not
> large enough.

.. creating the virtqueue then fails?

> 1:1 MRs are requied to support virtio_vdpa.

typo

> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V0 --> V1:
> Add more information in changelog
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 189e4385df40..53312f0460ad 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
>  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
>  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
>  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
>  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
>  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> -- 
> 2.31.1

