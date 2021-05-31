Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379B339569F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhEaIAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhEaIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622447948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcjnvAEV/WokSDAC3vU2MZce29x+fSn0lTKuolUmQWk=;
        b=MTwDPOg76gtLhTBZ9Pmz7YcJGH/rbuO+GHDPEwKvdio0JAo2NrbmFmPvNXiQcxiYpFcBko
        gGIABdO/Ag/7r88aLinKkaeHXRhIGAVj95a/3b1XlnuFWLbgiuBbw0QS3GwTbDwrWefiiT
        39ws0azUc/fQWz29ADrX/oVoeWBLxE0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-n7WTfk_0NP27YZG1e2CY8Q-1; Mon, 31 May 2021 03:59:07 -0400
X-MC-Unique: n7WTfk_0NP27YZG1e2CY8Q-1
Received: by mail-pl1-f199.google.com with SMTP id o9-20020a1709026b09b0290102b8314d05so843735plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JcjnvAEV/WokSDAC3vU2MZce29x+fSn0lTKuolUmQWk=;
        b=GCXESU9k7FdQY55bMlXHV/O24Cb7F7LlWFZY9jngQNjqa0LNfgipyMebfjK1nFIuS8
         vt/I0txCJUMCs+YZxPbBv4CPoBFfn+p3ZZU3mgMvOd0ws7Va46X8VqkBh4clycs1URXL
         OHqo6vjyQJt0LIKRsT8dnqsj0qUoAy6O/J8AqSYgb1BBWOs4dfmM/y7SaUBF9JXLjY7Q
         J0Zoz49ym/Z4J1QF+R34oX+ODUd8ZS4jNHrNyYkWfUuOX+JQsCEhMU3Y5qSqMNmU1S3w
         KsQKRi+cUTW5Xci4/wQhScrrou8XhCBKrEKvi6wZeqEFWvi/pPbo0cPZRSWMRqD3X/cO
         LxPg==
X-Gm-Message-State: AOAM5308a2AJ0Hhc/mD91BJfMctG9yPq7M3TlHsx/4ejcfJsP8L+Aj/f
        W3Hed+YhWQL19fpQRh6oddEo9bSND2Hf40CS6kWCDj4Xzgg81birHefld09bLlhMslhb+Tnct4q
        aSC6e1ov2cxb2sWCfD5BdaeIrKOWrHt1N/SmP8xopfh+dOQH9Tuq7w6Z9k7atOg1QHtvpdUwjnr
        Wt
X-Received: by 2002:a63:5641:: with SMTP id g1mr21567116pgm.351.1622447945627;
        Mon, 31 May 2021 00:59:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMx8B/T1/OnnAi1V0HSgbPjxa3+DCXtOfsmzA4DAuI8EMfFrGhnkzCQyirBKQrwzJ+jZTLLg==
X-Received: by 2002:a63:5641:: with SMTP id g1mr21567093pgm.351.1622447945379;
        Mon, 31 May 2021 00:59:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 13sm1042820pfn.33.2021.05.31.00.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 00:59:04 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa/mlx5: Fix umem sizes assignments on VQ create
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210530090317.8284-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a373e852-6b8a-322d-06a3-546b30194081@redhat.com>
Date:   Mon, 31 May 2021 15:58:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210530090317.8284-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/30 ÏÂÎç5:03, Eli Cohen Ð´µÀ:
> Fix copy paste bug assigning umem1 size to umem2 and umem3. The issue
> was discovered when trying to use a 1:1 MR that covers the entire
> address space where firmware complained that provided sizes are not
> large enough. 1:1 MRs are required to support virtio_vdpa.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V0 --> V1:
> Add more information in changelog
>
> V1 --> V2:
> Fix typo in changelog


Acked-by: Jason Wang <jasowang@redhat.com>


>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 189e4385df40..53312f0460ad 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
>   	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
>   	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
>   	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>   	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
>   	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
>   		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);

