Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BF39500F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhE3IHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3IHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622361922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tReJm3Ow3/2+blqVFpQuF41IER1CEjyexFjR1pvGmUI=;
        b=cjBzFh6Hhmaud519n/idUszKcXwx2uGyNHr7p95ebNqbm9+WmL4saLJ3GWEz2d4pcN8qzK
        LYQLEidJiaK4tq6zdDu76AVRQCh2gSh8eO0v/ULdUhQJORWgTe+D301VieKCUoG9H2cgY0
        zi72Q+c/SUxHFAe89rFCf8aaiCTVW5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-ysVnunsCPyG25wVsITSELg-1; Sun, 30 May 2021 04:05:21 -0400
X-MC-Unique: ysVnunsCPyG25wVsITSELg-1
Received: by mail-wm1-f69.google.com with SMTP id o3-20020a05600c3783b029017dca14ec2dso1955308wmr.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tReJm3Ow3/2+blqVFpQuF41IER1CEjyexFjR1pvGmUI=;
        b=MD9mdtkT2mVBNL9MfuwJhaFdQB5savvhqYrMCreD8sOfGo4eMqsKN/C8GCM/qRJ47Q
         jrY7FAGrCbCOeu/wmhObHc7NCnydtokFT/r/ImoPMoHV3PNAq/h2k95iLbygtm7oYRKI
         l5f56P9Mgh6WSV3aXDhX7DMm4qOhrdCE+kDWtCG3OuxPRBOEwYZ9eDellgbBvcH1j2y8
         t8T/GChtOkv/oDGGj1TCCZpsd/X2WCz0X7+56hRDFw8OdT+44jC8QM7zhQsz8pKwZH/e
         xGg9r6SLYKnS+qBYzyIAp5ZMC69k3XD7N17ubN8MwkjRRzgDKsQ433AtEh0FeUqoUJ2M
         wvJw==
X-Gm-Message-State: AOAM533q3h58gsItIQrrhkJjyWI6ba/bJMh4wcmxQzjDxWfbIdWfnxGA
        +648T+YSIuXgk+m0xoKmuivlOMcHgh/j31GztwgXZ721/3sVKqJXPFbkCetAGZqIXY4ZqqBcZIf
        ujeeGsHBk6yg2BIrRM03R3J2w
X-Received: by 2002:adf:f28f:: with SMTP id k15mr743510wro.223.1622361920195;
        Sun, 30 May 2021 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3YZyoXl4vPpKtwFqJkPaieEu99nqVfKrgR4uhLGUlDtCIVD6ILm7Z7HET2KJNYvxCHfOkPw==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr743497wro.223.1622361920084;
        Sun, 30 May 2021 01:05:20 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
        by smtp.gmail.com with ESMTPSA id b10sm13137948wrt.24.2021.05.30.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:05:19 -0700 (PDT)
Date:   Sun, 30 May 2021 04:05:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530040458-mutt-send-email-mst@kernel.org>
References: <20210530063128.183258-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530063128.183258-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> Fix copy paste bug assigning umem1 size to umem2 and umem3.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

could you clarify the impact of the bug please?

> ---
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

