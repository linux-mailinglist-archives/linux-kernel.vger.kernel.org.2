Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7531DE04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhBQRPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 12:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234378AbhBQRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613582025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QiquG9IOiLb2ArxThqBsSmOSv1VEYLQ2aODCK5RKfjM=;
        b=YFL91b4aHCnHJt1bMmguFZITJU5YUPxL/3yQ7pbSG9qBT6+Yxalvg3juAde/tzdCyMQ1Sk
        PnAbLKkTSp2057sZG7OOmHEXXtWr9VBxNO0Dqm2uqmpga2QluSSy55tspnD+qalvcg+yJ1
        2aMoFpFQ5wrGWIBQrTy4LJajU+a+qAA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-dR-8yaVwPv-2BvJZSW8nWg-1; Wed, 17 Feb 2021 12:13:43 -0500
X-MC-Unique: dR-8yaVwPv-2BvJZSW8nWg-1
Received: by mail-ed1-f70.google.com with SMTP id bd22so10826111edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 09:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QiquG9IOiLb2ArxThqBsSmOSv1VEYLQ2aODCK5RKfjM=;
        b=akL6GOOCwaPeJHLgMx6utjbsw6k2mBPWnGRGP/Wmddt6v2ZIP9dcD9diTj3WhaWbCe
         4YnEZcfivbV9v8P72QqSQ2bBNkiCCoiXCpeC3iiOs/DHIospRwQAQdKMRoLX1pXxj8qe
         s6RR+8RvdObZYszN55zIu1uXCr/N1pmrTuJHOsfv7k/iwZo977ruL7G6psV/2QFXR5YK
         7bSMxBBSZLO0vzDsSt6I1ZRasL4K5en42ATI40mTH+sX3DH19jrcXW8L72bhXkQzjUlf
         RftYk2olYP4P97pU5f2P7XsA9qzn1OO8DLA6xJlW1ETXpW5PVvX8wrktjW+K/IiiMNCC
         cyww==
X-Gm-Message-State: AOAM530Kj/pdmOH9vH3HMl0NQtbCDwP8t/7oBe94HSy1ISeMjbxD3k5l
        Nyd2plyd6F2X8/7VNgjLfSQxDr7eR8SYzXSAydxc63KBwSQklkAnGgviIjd1pCTL0IjLiWaeDR0
        zvWhAvzARa8v5yrfZj2ENNCOI
X-Received: by 2002:a05:6402:1484:: with SMTP id e4mr27937280edv.104.1613582022713;
        Wed, 17 Feb 2021 09:13:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuvd1ltECKJmOuiIgpNkSWnIT6BYItP6BB7mgr9PrMcDvlJLCU0gU86eEIIRUXY3AbAs2Oww==
X-Received: by 2002:a05:6402:1484:: with SMTP id e4mr27937261edv.104.1613582022551;
        Wed, 17 Feb 2021 09:13:42 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id f13sm1302362ejf.42.2021.02.17.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 09:13:41 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:13:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 2/2 v1] vdpa/mlx5: Enable user to add/delete vdpa device
Message-ID: <20210217121315-mutt-send-email-mst@kernel.org>
References: <20210217113136.10215-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217113136.10215-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 01:31:36PM +0200, Eli Cohen wrote:
> Allow to control vdpa device creation and destruction using the vdpa
> management tool.
> 
> Examples:
> 1. List the management devices
> $ vdpa mgmtdev show
> pci/0000:3b:00.1:
>   supported_classes net
> 
> 2. Create vdpa instance
> $ vdpa dev add mgmtdev pci/0000:3b:00.1 name vdpa0
> 
> 3. Show vdpa devices
> $ vdpa dev show
> vdpa0: type network mgmtdev pci/0000:3b:00.1 vendor_id 5555 max_vqs 16 \
> max_vq_size 256
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

where's the rest of the patchset though? I only got 2/2 ... confused.

> ---
> v0->v1:
> set mgtdev->ndev NULL on dev delete 
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 79 +++++++++++++++++++++++++++----
>  1 file changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index a51b0f86afe2..08fb481ddc4f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1974,23 +1974,32 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>  	}
>  }
>  
> -static int mlx5v_probe(struct auxiliary_device *adev,
> -		       const struct auxiliary_device_id *id)
> +struct mlx5_vdpa_mgmtdev {
> +	struct vdpa_mgmt_dev mgtdev;
> +	struct mlx5_adev *madev;
> +	struct mlx5_vdpa_net *ndev;
> +};
> +
> +static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>  {
> -	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
> -	struct mlx5_core_dev *mdev = madev->mdev;
> +	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>  	struct virtio_net_config *config;
>  	struct mlx5_vdpa_dev *mvdev;
>  	struct mlx5_vdpa_net *ndev;
> +	struct mlx5_core_dev *mdev;
>  	u32 max_vqs;
>  	int err;
>  
> +	if (mgtdev->ndev)
> +		return -ENOSPC;
> +
> +	mdev = mgtdev->madev->mdev;
>  	/* we save one virtqueue for control virtqueue should we require it */
>  	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
>  	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>  
>  	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
> -				 2 * mlx5_vdpa_max_qps(max_vqs), NULL);
> +				 2 * mlx5_vdpa_max_qps(max_vqs), name);
>  	if (IS_ERR(ndev))
>  		return PTR_ERR(ndev);
>  
> @@ -2018,11 +2027,12 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	if (err)
>  		goto err_res;
>  
> -	err = vdpa_register_device(&mvdev->vdev);
> +	mvdev->vdev.mdev = &mgtdev->mgtdev;
> +	err = _vdpa_register_device(&mvdev->vdev);
>  	if (err)
>  		goto err_reg;
>  
> -	dev_set_drvdata(&adev->dev, ndev);
> +	mgtdev->ndev = ndev;
>  	return 0;
>  
>  err_reg:
> @@ -2035,11 +2045,62 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	return err;
>  }
>  
> +static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> +{
> +	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> +
> +	_vdpa_unregister_device(dev);
> +	mgtdev->ndev = NULL;
> +}
> +
> +static const struct vdpa_mgmtdev_ops mdev_ops = {
> +	.dev_add = mlx5_vdpa_dev_add,
> +	.dev_del = mlx5_vdpa_dev_del,
> +};
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static int mlx5v_probe(struct auxiliary_device *adev,
> +		       const struct auxiliary_device_id *id)
> +
> +{
> +	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
> +	struct mlx5_core_dev *mdev = madev->mdev;
> +	struct mlx5_vdpa_mgmtdev *mgtdev;
> +	int err;
> +
> +	mgtdev = kzalloc(sizeof(*mgtdev), GFP_KERNEL);
> +	if (!mgtdev)
> +		return -ENOMEM;
> +
> +	mgtdev->mgtdev.ops = &mdev_ops;
> +	mgtdev->mgtdev.device = mdev->device;
> +	mgtdev->mgtdev.id_table = id_table;
> +	mgtdev->madev = madev;
> +
> +	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> +	if (err)
> +		goto reg_err;
> +
> +	dev_set_drvdata(&adev->dev, mgtdev);
> +
> +	return 0;
> +
> +reg_err:
> +	kfree(mdev);
> +	return err;
> +}
> +
>  static void mlx5v_remove(struct auxiliary_device *adev)
>  {
> -	struct mlx5_vdpa_dev *mvdev = dev_get_drvdata(&adev->dev);
> +	struct mlx5_vdpa_mgmtdev *mgtdev;
>  
> -	vdpa_unregister_device(&mvdev->vdev);
> +	mgtdev = dev_get_drvdata(&adev->dev);
> +	vdpa_mgmtdev_unregister(&mgtdev->mgtdev);
> +	kfree(mgtdev);
>  }
>  
>  static const struct auxiliary_device_id mlx5v_id_table[] = {
> -- 
> 2.29.2

