Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B178B39D2D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFGCNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 22:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhFGCNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623031892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/EuEKKNsDXHQ7kk/CTUamf7HDQxmDfNXZ1E2EtyO34=;
        b=fAgv4K3GQbMeaLJrzTCBWNOxmoxhJCi7VpyLyUyNDNqkClPFhJXOpkqdJRgksaoLdd21tp
        hD6gzlO0XB3QyqY+myRCJ2HHgBw+gjj6PCGRm41DLdMhrn8NX2RpGqA4ny/C19m3l9BV6B
        huGeLvVkfARmGw2WNkIYqLO6TpZ7BI4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-2Vi4CMfnNoyAgo_RnOz5ug-1; Sun, 06 Jun 2021 22:11:31 -0400
X-MC-Unique: 2Vi4CMfnNoyAgo_RnOz5ug-1
Received: by mail-pf1-f200.google.com with SMTP id l3-20020a056a001403b02902ea25d3c7d4so6292423pfu.15
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 19:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A/EuEKKNsDXHQ7kk/CTUamf7HDQxmDfNXZ1E2EtyO34=;
        b=SJhfiuOycIt4nAsrV6j4bxree8zgbSmqPYGSQYB4avLDyQAkmlAGkXhxLQyhwSH2Q2
         h54vDGe9Y+uqWPktuv6GpPJhQ1HVrAPk5fznEHfoAa39CiAa0MtVQ42c+knyHa1FVorZ
         zg89wTAE8AYVeJ+nPY98q7kGPCrpAl9colgqg4a65cIawA9puOBN2lFqeF8lsFT4gBuw
         lWCW29SXd3tNrHOmEilrUqcIUTsXvGYNX9qtOexu7PubvxHiavSqwOEMDNdasWJrsRf3
         nw6Lx4CX3qzN+VIMvIsKjnTGocYqqy3ZLLxkyEW/3V3WPLsO22xTUT7S0BPOy2lz+2Qv
         t4Vg==
X-Gm-Message-State: AOAM531WWWXRfyDhLXGKaP20NW0D6po5hx3m7emh6aCzdtoRXU0IuGXg
        J2L3ckDDrrSc+ePz0GwVIbNuIfD70SjYENCZo05HmU9zqDAjELajtY+MmJHPqzjw/wU3wF0YE5V
        qjIkkar3gjbGP8Vs5/kL8r9Ts+xmVyy2og25NXPncR02D4x/ADnr/ipCIC4o5Xuf9QPlh3QDSB0
        mq
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr30280715pja.181.1623031889878;
        Sun, 06 Jun 2021 19:11:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAx4rB2M3pplY+UpbwardmP9ceIokSBmI4mAdVk+jKYwUSzn/gx2IwSAPiLV02x1ehjAP2dg==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr30280685pja.181.1623031889551;
        Sun, 06 Jun 2021 19:11:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h16sm6699394pfk.119.2021.06.06.19.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 19:11:29 -0700 (PDT)
Subject: Re: [PATCH v1] vdp/mlx5: Fix setting the correct dma_device
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210606053150.170489-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fa91edcc-2c99-311d-3501-8643e37c83de@redhat.com>
Date:   Mon, 7 Jun 2021 10:11:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606053150.170489-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/6 ÏÂÎç1:31, Eli Cohen Ð´µÀ:
> Before SF support was introduced, the DMA device was equal to
> mdev->device which was in essence equal to pdev->dev.
>
> With SF introduction this is no longer true. It has already been
> handled for vhost_vdpa since the reference to the dma device can from
> within mlx5_vdpa. With virtio_vdpa this broke. To fix this we set the
> real dma device when initializing the device.
>
> In addition, for the sake of consistency, previous references in the
> code to the dma device are changed to vdev->dma_dev.
>
> Fixes: d13a15d544ce5 ("vdpa/mlx5: Use the correct dma device when registering memory")
> Signed-off-by: Eli Cohen <elic@nvidia.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> v0 --> v1:
>     Change blamed commit and modify references to the dma device
>
>   drivers/vdpa/mlx5/core/mr.c       | 9 ++-------
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>   2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index f0b89b62de36..dcee6039e966 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -219,11 +219,6 @@ static void destroy_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_m
>   	mlx5_vdpa_destroy_mkey(mvdev, &mkey->mkey);
>   }
>   
> -static struct device *get_dma_device(struct mlx5_vdpa_dev *mvdev)
> -{
> -	return &mvdev->mdev->pdev->dev;
> -}
> -
>   static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr,
>   			 struct vhost_iotlb *iotlb)
>   {
> @@ -239,7 +234,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>   	u64 pa;
>   	u64 paend;
>   	struct scatterlist *sg;
> -	struct device *dma = get_dma_device(mvdev);
> +	struct device *dma = mvdev->vdev.dma_dev;
>   
>   	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
>   	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
> @@ -298,7 +293,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
>   
>   static void unmap_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr)
>   {
> -	struct device *dma = get_dma_device(mvdev);
> +	struct device *dma = mvdev->vdev.dma_dev;
>   
>   	destroy_direct_mr(mvdev, mr);
>   	dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 7e0d1b8ae3d3..a5163d8a4828 100644
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

