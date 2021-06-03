Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696EF399B53
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFCHP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFCHPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622704451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL7aJqhus7yWQntKyImh1IsMt1S+2O5OTo6wvEOUBgg=;
        b=Br704sCqgVBSLj/CZ1H1lplUWeaCk1R+wfZzWu8nrhYhYKA5msCpaNGQZBIemIkOys0bjc
        jmZTuW0U2iY3dz/eBlHQKHfCz0qNn5ysJwP/YHz4dXKXTTeKQTU8qIw3QkYYjck1U7tW4j
        q5lBK15T0ke4WC/QTA/Jzdv7g9EGPeQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-LYunrfi5NfGyKQqWXsONww-1; Thu, 03 Jun 2021 03:14:10 -0400
X-MC-Unique: LYunrfi5NfGyKQqWXsONww-1
Received: by mail-pg1-f200.google.com with SMTP id 4-20020a6317440000b029021689797ccaso3432489pgx.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 00:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zL7aJqhus7yWQntKyImh1IsMt1S+2O5OTo6wvEOUBgg=;
        b=l/q9XD2YcXqvBSzXlTj2YJN1F3o/BHw3JcH68S/9NSdtLjiU0LNQruiUo2Fv7MqKSa
         v5Wd9htv70jZqqrG4J4hEn2YKPR+P6ummR7i8ZzbtAG+GYi51MeSWZ16AEGGFDBVppB5
         +aNrBHf2MTWr5J8aaLBiC5Z/FZP7TrptdjGY1P7XltovXjY/1kDbpjPM1BD6N1UTl5r5
         Zlf+FcFsR5wClAUwuSOZrlEzngubvQsaTmWveVPCvCQlhMxFoywyiN+NMiffNwhgeKQu
         XZ0JsAZtrVjT5PkOhseblQi5ghayYb0VBLZcOb1HwJDhLBx0MtKuHbV1hrKTcy0H/HKj
         ICug==
X-Gm-Message-State: AOAM531od/jZmRJAVwXDRJPuD3AwIBLAYy9l/G4eK8kpXhtbbHxnJ6pO
        GAdnyOhXgs2P/ssNffjHyMShh753wLhGPErOfGulTmgk0B92NpLGE7iJjVT47enw3klXYt337IJ
        gQiHAx/dvK8KrckoRDqqu4QBTlqzVu2T7vKoE5CO4RqAFX8hWvnhSlbD8T1/aPIV8MY2pfpxZ5F
        OA
X-Received: by 2002:a05:6a00:b83:b029:2ec:7400:ae59 with SMTP id g3-20020a056a000b83b02902ec7400ae59mr129959pfj.11.1622704448409;
        Thu, 03 Jun 2021 00:14:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza5Yg1MWyygPq1dd+sj5xBhdm780OGEiBEA5IDxRZNXGREqaIkuTNqhkYi1BdoYjLzPgcrtA==
X-Received: by 2002:a05:6a00:b83:b029:2ec:7400:ae59 with SMTP id g3-20020a056a000b83b02902ec7400ae59mr129917pfj.11.1622704447912;
        Thu, 03 Jun 2021 00:14:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ip7sm1095621pjb.39.2021.06.03.00.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 00:14:07 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa/mlx5: Add support for running with virtio_vdpa
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210602085854.62690-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5d11538f-62ef-c545-4f7e-61001f4c20f5@redhat.com>
Date:   Thu, 3 Jun 2021 15:14:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602085854.62690-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/2 ÏÂÎç4:58, Eli Cohen Ð´µÀ:
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


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> v0 --> v1:
>      1. Clear user_mr after successful creation of DMA MR
>      2. Check return code of mlx5_vdpa_create_mr() and emit warning
>         if failed.
>
> v1 --> v2:
>      Only set mr->initialized if successful
>
>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>   drivers/vdpa/mlx5/core/mr.c        | 86 +++++++++++++++++++++++++-----
>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 +++++-
>   3 files changed, 87 insertions(+), 15 deletions(-)
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
> index 800cfd1967ad..f0b89b62de36 100644
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
> @@ -426,33 +423,94 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
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
> +	if (!err)
> +		mr->initialized = true;
> +
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

