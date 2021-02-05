Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD6311735
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhBEXiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231592AbhBEOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612540690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lkJ85pmPT0jRY9KVUggOoEd97lIiayLDWBOxGNlCN5o=;
        b=hHv63HetSHH80+ZEm13c6FXRVyBXqW67btQzBmPVWl4GS5eApZXwaDTLuQ1n1ry1KXy6ho
        hT3NM4jDiJkFyGbW5vjDlW9c0m1msoNuHvqhTpXHJG4dz7KtWeyZxG4ZWb2gt4mel8b0a9
        ZAloMoqnDLBYONmNPVdy8Um0DN6ZYrY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-4eeA6gyVPyKdaBZOC6-b4A-1; Fri, 05 Feb 2021 10:27:19 -0500
X-MC-Unique: 4eeA6gyVPyKdaBZOC6-b4A-1
Received: by mail-ej1-f72.google.com with SMTP id by20so6873010ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lkJ85pmPT0jRY9KVUggOoEd97lIiayLDWBOxGNlCN5o=;
        b=f7uuMd5MvA1cxb9vWrX7OczJcN6F+iybz2P4BLSijqtCHsli+tTv/0f1s86rd7rWFT
         +JGiL5ArmUXgMSL5UOzQJaN9TCyq8CVnCeLndzuRQNa38sLp0SV0VvP4M5YIDEPyt0nH
         gA5KBgpWIvYcrfsHnHxsYae0OeYI4Gcn29YzGekLrmIcEwjK/9RPyuw7asSYGAF4TCxt
         wiBAVWzoPRQSMYzbIP4Z0f8kATsPTYx/6JQk9I5U4vRNA7Vsthjtzyaq/IzOrp9CE5YM
         gY8S3Fe7bjUM6hWkOoXS4RpoCAKimevpbkhuxR4XpSMJceoqONKemQORTwa/7tqH4Gfr
         yc6Q==
X-Gm-Message-State: AOAM5323eqW7J/RSVPUbkkrhIhOXXyLDTgWnMwGLg0l/mkCi0nw50SjO
        ll1qBunfSjXBCtZ2oThA/dlhVFKHwu9tuXWyzlPS8TtLtfSoLz4WgIpc+Vkth5bFEQnAfuNF//N
        GCN5mGOUo/Pq6JCMf/NPjCzXC
X-Received: by 2002:aa7:da98:: with SMTP id q24mr3996643eds.370.1612538838293;
        Fri, 05 Feb 2021 07:27:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz14kFXujPV+m0BMsIR9hKeSD8G6x+1pbVrCCMu6Pop+DPMTWoaAYbxIZyrBhCwOuOslafp1Q==
X-Received: by 2002:aa7:da98:: with SMTP id q24mr3996627eds.370.1612538838134;
        Fri, 05 Feb 2021 07:27:18 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id u17sm4059550ejr.59.2021.02.05.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:27:17 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:27:14 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V3 17/19] vdpa: set the virtqueue num during register
Message-ID: <20210205102552-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-18-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104065503.199631-18-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:55:01PM +0800, Jason Wang wrote:
> This patch delay the queue number setting to vDPA device
> registering. This allows us to probe the virtqueue numbers between
> device allocation and registering.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Conflicts with other patches in the vhost tree.
Can you rebase please?

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c   | 5 ++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 ++---
>  drivers/vdpa/vdpa.c               | 8 ++++----
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 4 ++--
>  include/linux/vdpa.h              | 7 +++----
>  5 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 8b4028556cb6..d65f3221d8ed 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -438,8 +438,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	}
>  
>  	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> -				    dev, &ifc_vdpa_ops,
> -				    IFCVF_MAX_QUEUE_PAIRS * 2);
> +				    dev, &ifc_vdpa_ops);
>  	if (adapter == NULL) {
>  		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>  		return -ENOMEM;
> @@ -463,7 +462,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++)
>  		vf->vring[i].irq = -EINVAL;
>  
> -	ret = vdpa_register_device(&adapter->vdpa);
> +	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
>  	if (ret) {
>  		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
>  		goto err;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f1d54814db97..a1b9260bf04d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1958,8 +1958,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
>  	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>  
> -	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
> -				 2 * mlx5_vdpa_max_qps(max_vqs));
> +	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops);
>  	if (IS_ERR(ndev))
>  		return PTR_ERR(ndev);
>  
> @@ -1986,7 +1985,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	if (err)
>  		goto err_res;
>  
> -	err = vdpa_register_device(&mvdev->vdev);
> +	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
>  	if (err)
>  		goto err_reg;
>  
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index a69ffc991e13..ba89238f9898 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -61,7 +61,6 @@ static void vdpa_release_dev(struct device *d)
>   * initialized but before registered.
>   * @parent: the parent device
>   * @config: the bus operations that is supported by this device
> - * @nvqs: number of virtqueues supported by this device
>   * @size: size of the parent structure that contains private data
>   *
>   * Driver should use vdpa_alloc_device() wrapper macro instead of
> @@ -72,7 +71,6 @@ static void vdpa_release_dev(struct device *d)
>   */
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> -					int nvqs,
>  					size_t size)
>  {
>  	struct vdpa_device *vdev;
> @@ -99,7 +97,6 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  	vdev->index = err;
>  	vdev->config = config;
>  	vdev->features_valid = false;
> -	vdev->nvqs = nvqs;
>  
>  	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
>  	if (err)
> @@ -122,11 +119,14 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
>   * vdpa_register_device - register a vDPA device
>   * Callers must have a succeed call of vdpa_alloc_device() before.
>   * @vdev: the vdpa device to be registered to vDPA bus
> + * @nvqs: number of virtqueues supported by this device
>   *
>   * Returns an error when fail to add to vDPA bus
>   */
> -int vdpa_register_device(struct vdpa_device *vdev)
> +int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
>  {
> +	vdev->nvqs = nvqs;
> +
>  	return device_add(&vdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_register_device);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 6a90fdb9cbfc..b129cb4dd013 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -357,7 +357,7 @@ static struct vdpasim *vdpasim_create(void)
>  	else
>  		ops = &vdpasim_net_config_ops;
>  
> -	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
> +	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops);
>  	if (!vdpasim)
>  		goto err_alloc;
>  
> @@ -393,7 +393,7 @@ static struct vdpasim *vdpasim_create(void)
>  	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>  
>  	vdpasim->vdpa.dma_dev = dev;
> -	ret = vdpa_register_device(&vdpasim->vdpa);
> +	ret = vdpa_register_device(&vdpasim->vdpa, VDPASIM_VQ_NUM);
>  	if (ret)
>  		goto err_iommu;
>  
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 30bc7a7223bb..d9e9d17b9083 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -244,18 +244,17 @@ struct vdpa_config_ops {
>  
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>  					const struct vdpa_config_ops *config,
> -					int nvqs,
>  					size_t size);
>  
> -#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
> +#define vdpa_alloc_device(dev_struct, member, parent, config)   \
>  			  container_of(__vdpa_alloc_device( \
> -				       parent, config, nvqs, \
> +				       parent, config, \
>  				       sizeof(dev_struct) + \
>  				       BUILD_BUG_ON_ZERO(offsetof( \
>  				       dev_struct, member))), \
>  				       dev_struct, member)
>  
> -int vdpa_register_device(struct vdpa_device *vdev);
> +int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
>  void vdpa_unregister_device(struct vdpa_device *vdev);
>  
>  /**
> -- 
> 2.25.1

