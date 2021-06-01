Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31F396ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhFACLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232592AbhFACLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622513395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r47Xy6A8bsPkRYw9CbgJmxGQcq9VxrCwM+C/xXm0PYE=;
        b=EJy5MYs+cjJ4Bk4w1+JGu2KWszEFxWIL2tYoWhX8krYqZ+NMYtXTzuatVDbXRqbcWBOrvX
        EhSq4opvy0/79JQ0THgbuqwOOxD3Yab73G7/smRe3YkSKdxAChhlLfiNvIYZhdtTbiRbtK
        pfocC/PNJh26SW9Vv3ldeDo60h63TQg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-0Xr8GtYhOKO2feriGFGmfQ-1; Mon, 31 May 2021 22:09:54 -0400
X-MC-Unique: 0Xr8GtYhOKO2feriGFGmfQ-1
Received: by mail-pf1-f200.google.com with SMTP id g17-20020a056a0023d1b029028f419cb9a2so6546157pfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r47Xy6A8bsPkRYw9CbgJmxGQcq9VxrCwM+C/xXm0PYE=;
        b=KfsVyqyWxQokwbnRlPU/dc72cQTaPJHuYUmRjpd6ss0cjbCQKxxEbIN2hY89O6N2rH
         bwnro0OnSRrCJ1T/j+MZh81G3PZ4HCQsUoGKHZ3SF4rtiYE20pfcADyz4oNepBhuqDlS
         bE92mS4aSLNgikyZoEO98OTEXPdmlLYeUF9ZFXdnqil/Ub5K34LOE7r8qWAh3uVjWmHm
         svkiJh94Q8OjQw0o4CATUuqA93Ayq7MHhiMF37hHbBH8s4oO7jr/B617UQOfSGT3kxMB
         PIq892xac4DjEG+hk+5O0nYQXgNgnbe/OcE6diLV9/3zLuG5VlME2V5NHFQA+wj3Y3OT
         fA5g==
X-Gm-Message-State: AOAM533WYxtH7iUogs+ZoADRkI7dQoSLbuyiJknimlre5d4axGMZoUZb
        c7HC5nuYUKL4Ch7Iw++poENutzNbWXps8tGoRrquFvPQJvz1NXQnoGZs/s0hMCkeheTHtBDxNBU
        8g0xVIEQ1ecXqqmicPHlqOMDhVsYsOaFX4/tIPSFRYhgNHWF1bqc2i8ajnhAqriEKWTNayZke2Y
        V7
X-Received: by 2002:a63:dd48:: with SMTP id g8mr25308551pgj.102.1622513392921;
        Mon, 31 May 2021 19:09:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs1Ax2moRQwexv6k/rvLP/EFg6inDFKcotswJgtxVHBrO8bsVReVN77MSCLJ4eaYlzuqiawA==
X-Received: by 2002:a63:dd48:: with SMTP id g8mr25308522pgj.102.1622513392512;
        Mon, 31 May 2021 19:09:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 23sm13113302pgv.90.2021.05.31.19.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 19:09:52 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for running with virtio_vdpa
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160428.31454-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <117f8549-85c5-6603-c941-77c63b596bdd@redhat.com>
Date:   Tue, 1 Jun 2021 10:09:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531160428.31454-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/1 ÉÏÎç12:04, Eli Cohen Ð´µÀ:
> In order to support running vdpa using vritio_vdpa driver, we need  to
> create a different kind of MR, one that has 1:1 mapping, since the
> addresses referring to virtqueues are dma addresses.
>
> We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
> supports the general capability umem_uid_0. The reason for that is that
> 1:1 MRs must be created with uid == 0 while virtqueue objects can be
> created with uid == 0 only when the firmware capability is on.
>
> If the set_map() callback is called with new translations provided
> through iotlb, the driver will destroy the 1:1 MR and create a regular
> one.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 --> v1:
>    1. Clear user_mr after successful creation of DMA MR
>    2. Check return code of mlx5_vdpa_create_mr() and emit warning if
>       failed.
>
>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>   drivers/vdpa/mlx5/core/mr.c        | 84 +++++++++++++++++++++++++-----
>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 +++++-
>   3 files changed, 85 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index b6cc53ba980c..09a16a3d1b2a 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -35,6 +35,7 @@ struct mlx5_vdpa_mr {
>   
>   	/* serialize mkey creation and destruction */
>   	struct mutex mkey_mtx;
> +	bool user_mr;
>   };
>   
>   struct mlx5_vdpa_resources {
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 800cfd1967ad..3c6c1d846f5e 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -360,7 +360,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
>    * indirect memory key that provides access to the enitre address space given
>    * by iotlb.
>    */
> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> +static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>   {
>   	struct mlx5_vdpa_mr *mr = &mvdev->mr;
>   	struct mlx5_vdpa_direct_mr *dmr;
> @@ -374,9 +374,6 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>   	int err = 0;
>   	int nnuls;
>   
> -	if (mr->initialized)
> -		return 0;
> -
>   	INIT_LIST_HEAD(&mr->head);
>   	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
>   	     map = vhost_iotlb_itree_next(map, start, last)) {
> @@ -414,7 +411,7 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>   	if (err)
>   		goto err_chain;
>   
> -	mr->initialized = true;
> +	mr->user_mr = true;
>   	return 0;
>   
>   err_chain:
> @@ -426,33 +423,92 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>   	return err;
>   }
>   
> -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> +static int create_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> +{
> +	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
> +	void *mkc;
> +	u32 *in;
> +	int err;
> +
> +	in = kzalloc(inlen, GFP_KERNEL);
> +	if (!in)
> +		return -ENOMEM;
> +
> +	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
> +
> +	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_PA);
> +	MLX5_SET(mkc, mkc, length64, 1);
> +	MLX5_SET(mkc, mkc, lw, 1);
> +	MLX5_SET(mkc, mkc, lr, 1);
> +	MLX5_SET(mkc, mkc, pd, mvdev->res.pdn);
> +	MLX5_SET(mkc, mkc, qpn, 0xffffff);
> +
> +	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
> +	if (!err)
> +		mr->user_mr = false;


Rethink about this. I wonder this is correct when we fail to create 
memory key.

In this case, user_mr is true but user_mr is already destroyed. Can this 
lead double free for user mr?

Thanks


> +
> +	kfree(in);
> +	return err;
> +}
> +
> +static void destroy_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> +{
> +	mlx5_vdpa_destroy_mkey(mvdev, &mr->mkey);
> +}
> +
> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>   {
>   	struct mlx5_vdpa_mr *mr = &mvdev->mr;
>   	int err;
>   
> -	mutex_lock(&mr->mkey_mtx);
> +	if (mr->initialized)
> +		return 0;
> +
> +	if (iotlb)
> +		err = create_user_mr(mvdev, iotlb);
> +	else
> +		err = create_dma_mr(mvdev, mr);
> +
> +	mr->initialized = true;
> +	return err;
> +}
> +
> +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> +{
> +	int err;
> +
> +	mutex_lock(&mvdev->mr.mkey_mtx);
>   	err = _mlx5_vdpa_create_mr(mvdev, iotlb);
> -	mutex_unlock(&mr->mkey_mtx);
> +	mutex_unlock(&mvdev->mr.mkey_mtx);
>   	return err;
>   }
>   
> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> +static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
>   {
> -	struct mlx5_vdpa_mr *mr = &mvdev->mr;
>   	struct mlx5_vdpa_direct_mr *dmr;
>   	struct mlx5_vdpa_direct_mr *n;
>   
> -	mutex_lock(&mr->mkey_mtx);
> -	if (!mr->initialized)
> -		goto out;
> -
>   	destroy_indirect_key(mvdev, mr);
>   	list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
>   		list_del_init(&dmr->list);
>   		unmap_direct_mr(mvdev, dmr);
>   		kfree(dmr);
>   	}
> +}
> +
> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> +{
> +	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> +
> +	mutex_lock(&mr->mkey_mtx);
> +	if (!mr->initialized)
> +		goto out;
> +
> +	if (mr->user_mr)
> +		destroy_user_mr(mvdev, mr);
> +	else
> +		destroy_dma_mr(mvdev, mr);
> +
>   	memset(mr, 0, sizeof(*mr));
>   	mr->initialized = false;
>   out:
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fdf3e74bffbd..02a05492204c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1780,6 +1780,10 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   		ndev->mvdev.status = 0;
>   		ndev->mvdev.mlx_features = 0;
>   		++mvdev->generation;
> +		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> +			if (mlx5_vdpa_create_mr(mvdev, NULL))
> +				mlx5_vdpa_warn(mvdev, "create MR failed\n");
> +		}
>   		return;
>   	}
>   
> @@ -1859,6 +1863,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   	ndev = to_mlx5_vdpa_ndev(mvdev);
>   
>   	free_resources(ndev);
> +	mlx5_vdpa_destroy_mr(mvdev);
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
>   	mutex_destroy(&ndev->reslock);
>   }
> @@ -2023,9 +2028,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>   	if (err)
>   		goto err_mtu;
>   
> +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> +		err = mlx5_vdpa_create_mr(mvdev, NULL);
> +		if (err)
> +			goto err_res;
> +	}
> +
>   	err = alloc_resources(ndev);
>   	if (err)
> -		goto err_res;
> +		goto err_mr;
>   
>   	mvdev->vdev.mdev = &mgtdev->mgtdev;
>   	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
> @@ -2037,6 +2048,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>   
>   err_reg:
>   	free_resources(ndev);
> +err_mr:
> +	mlx5_vdpa_destroy_mr(mvdev);
>   err_res:
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
>   err_mtu:

