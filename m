Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB1396C95
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 07:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFAFCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 01:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231375AbhFAFCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 01:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622523629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJIU1bGNGgmVCYMPmOdU1mFXlFN7cBTWtHqGqP0FxvQ=;
        b=O5pUHUOngJtgCF4PMhHi5S+hXHP0LVff4V7v8wcehdsFtKL6hGYryBBiIYme3QMHMUML+p
        EPrXY5jJpV08aHCOx6zk+5NtwLJTR40WF5NpVtlXi43IHrYZunUls3GcqDaU2VPE8yYYSb
        AbkUJ8Dj9BE9WbdtfDgFyIoIK94N4aY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-fz0WRTQNNWO2nsxJxnsGWw-1; Tue, 01 Jun 2021 01:00:27 -0400
X-MC-Unique: fz0WRTQNNWO2nsxJxnsGWw-1
Received: by mail-pl1-f197.google.com with SMTP id u14-20020a170903304eb02900ec9757f3dbso3964816pla.17
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 22:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JJIU1bGNGgmVCYMPmOdU1mFXlFN7cBTWtHqGqP0FxvQ=;
        b=E7Sqf90qnPnpaAS6fwQaJG03+rU/d3w9j+nN5FpC5VbjP4WnaFTEDvUkXDSmBUPERv
         cIdtZh+JlO2RlwYz0pgtOEVgiEJFv84NjOUrc1wiWhtoK1ZOz8UnV/lGn5JNqgqbJMBW
         hyOWiOOKTLS+5RtVZeSMg7PwVO9x3RjIkalh+Sek/eb4KD8uN0+pkKa+EwF6La6yNO78
         h0dIbwskYoBIIOsoEpTVczwx0RsV9keQwP9lVPzbe21mfULFlz9CjWSGec/TtSiyZMl8
         HNSmOvM9F6xN433Z4WAjlbNgMvs4XnfXXDAi4wFJFGAhJBRL0Ydk66kqJYOfKZP9cy8K
         Th1g==
X-Gm-Message-State: AOAM530iE3w7FiOUrHHDc7Z9e9qv7vTMFGZDlLwu2UXCdG9r4uUsSuWQ
        Qs9az6wRk858wFRtS0UBVSo/tKFgjFX28nb1AYCVrjF3qF+XgIFbVXbkYToCfBO/uL6Vmt0Bz/Y
        8rKTTkaBh8sSjLDN10RZcYu5j4cyXPyWTicNMvQwsZLFBII59aiRAuSOdA9Ox7AMRXifHvUM1eC
        /K
X-Received: by 2002:a65:6549:: with SMTP id a9mr25920007pgw.213.1622523625740;
        Mon, 31 May 2021 22:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDcuBG7OX6ZlZjFBQUP3ylce11K8CFZG5T9OPDSqZg3c1DzxTHGFbzXnbEzbBtPt/xrJJTDg==
X-Received: by 2002:a65:6549:: with SMTP id a9mr25919956pgw.213.1622523625268;
        Mon, 31 May 2021 22:00:25 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 189sm6637140pfu.84.2021.05.31.22.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 22:00:24 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for running with virtio_vdpa
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160428.31454-1-elic@nvidia.com>
 <117f8549-85c5-6603-c941-77c63b596bdd@redhat.com>
 <20210601034018.GA203469@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cd1aee86-86df-b7df-e6da-5402f9525ce5@redhat.com>
Date:   Tue, 1 Jun 2021 13:00:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601034018.GA203469@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/1 上午11:40, Eli Cohen 写道:
> On Tue, Jun 01, 2021 at 10:09:45AM +0800, Jason Wang wrote:
>> 在 2021/6/1 上午12:04, Eli Cohen 写道:
>>> In order to support running vdpa using vritio_vdpa driver, we need  to
>>> create a different kind of MR, one that has 1:1 mapping, since the
>>> addresses referring to virtqueues are dma addresses.
>>>
>>> We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
>>> supports the general capability umem_uid_0. The reason for that is that
>>> 1:1 MRs must be created with uid == 0 while virtqueue objects can be
>>> created with uid == 0 only when the firmware capability is on.
>>>
>>> If the set_map() callback is called with new translations provided
>>> through iotlb, the driver will destroy the 1:1 MR and create a regular
>>> one.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>> v0 --> v1:
>>>     1. Clear user_mr after successful creation of DMA MR
>>>     2. Check return code of mlx5_vdpa_create_mr() and emit warning if
>>>        failed.
>>>
>>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>>    drivers/vdpa/mlx5/core/mr.c        | 84 +++++++++++++++++++++++++-----
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 +++++-
>>>    3 files changed, 85 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> index b6cc53ba980c..09a16a3d1b2a 100644
>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> @@ -35,6 +35,7 @@ struct mlx5_vdpa_mr {
>>>    	/* serialize mkey creation and destruction */
>>>    	struct mutex mkey_mtx;
>>> +	bool user_mr;
>>>    };
>>>    struct mlx5_vdpa_resources {
>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>>> index 800cfd1967ad..3c6c1d846f5e 100644
>>> --- a/drivers/vdpa/mlx5/core/mr.c
>>> +++ b/drivers/vdpa/mlx5/core/mr.c
>>> @@ -360,7 +360,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
>>>     * indirect memory key that provides access to the enitre address space given
>>>     * by iotlb.
>>>     */
>>> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>>> +static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>>>    {
>>>    	struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>    	struct mlx5_vdpa_direct_mr *dmr;
>>> @@ -374,9 +374,6 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>>>    	int err = 0;
>>>    	int nnuls;
>>> -	if (mr->initialized)
>>> -		return 0;
>>> -
>>>    	INIT_LIST_HEAD(&mr->head);
>>>    	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
>>>    	     map = vhost_iotlb_itree_next(map, start, last)) {
>>> @@ -414,7 +411,7 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>>>    	if (err)
>>>    		goto err_chain;
>>> -	mr->initialized = true;
>>> +	mr->user_mr = true;
>>>    	return 0;
>>>    err_chain:
>>> @@ -426,33 +423,92 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>>>    	return err;
>>>    }
>>> -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>>> +static int create_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
>>> +{
>>> +	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
>>> +	void *mkc;
>>> +	u32 *in;
>>> +	int err;
>>> +
>>> +	in = kzalloc(inlen, GFP_KERNEL);
>>> +	if (!in)
>>> +		return -ENOMEM;
>>> +
>>> +	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
>>> +
>>> +	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_PA);
>>> +	MLX5_SET(mkc, mkc, length64, 1);
>>> +	MLX5_SET(mkc, mkc, lw, 1);
>>> +	MLX5_SET(mkc, mkc, lr, 1);
>>> +	MLX5_SET(mkc, mkc, pd, mvdev->res.pdn);
>>> +	MLX5_SET(mkc, mkc, qpn, 0xffffff);
>>> +
>>> +	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
>>> +	if (!err)
>>> +		mr->user_mr = false;
>>
>> Rethink about this. I wonder this is correct when we fail to create memory
>> key.
>>
>> In this case, user_mr is true but user_mr is already destroyed. Can this
>> lead double free for user mr?
> mr->user_mr is a binary flag and its sole purpose is to tell the flavour
> of the MR but is valid only when mr->initialized is true. MR won't be
> freed if mr->initialized is false.


So we have:

static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct 
vhost_iotlb *iotlb)
{
         struct mlx5_vdpa_mr *mr = &mvdev->mr;
         int err;

         if (mr->initialized)
                 return 0;

         if (iotlb)
                 err = create_user_mr(mvdev, iotlb);
         else
                 err = create_dma_mr(mvdev, mr);

         mr->initialized = true;
         return err;
}

It looks to me we need to check err before set mr->initialized.

Thanks


>
>> Thanks
>>
>>
>>> +
>>> +	kfree(in);
>>> +	return err;
>>> +}
>>> +
>>> +static void destroy_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
>>> +{
>>> +	mlx5_vdpa_destroy_mkey(mvdev, &mr->mkey);
>>> +}
>>> +
>>> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>>>    {
>>>    	struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>    	int err;
>>> -	mutex_lock(&mr->mkey_mtx);
>>> +	if (mr->initialized)
>>> +		return 0;
>>> +
>>> +	if (iotlb)
>>> +		err = create_user_mr(mvdev, iotlb);
>>> +	else
>>> +		err = create_dma_mr(mvdev, mr);
>>> +
>>> +	mr->initialized = true;
>>> +	return err;
>>> +}
>>> +
>>> +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
>>> +{
>>> +	int err;
>>> +
>>> +	mutex_lock(&mvdev->mr.mkey_mtx);
>>>    	err = _mlx5_vdpa_create_mr(mvdev, iotlb);
>>> -	mutex_unlock(&mr->mkey_mtx);
>>> +	mutex_unlock(&mvdev->mr.mkey_mtx);
>>>    	return err;
>>>    }
>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>> +static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
>>>    {
>>> -	struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>    	struct mlx5_vdpa_direct_mr *dmr;
>>>    	struct mlx5_vdpa_direct_mr *n;
>>> -	mutex_lock(&mr->mkey_mtx);
>>> -	if (!mr->initialized)
>>> -		goto out;
>>> -
>>>    	destroy_indirect_key(mvdev, mr);
>>>    	list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
>>>    		list_del_init(&dmr->list);
>>>    		unmap_direct_mr(mvdev, dmr);
>>>    		kfree(dmr);
>>>    	}
>>> +}
>>> +
>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>> +{
>>> +	struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>> +
>>> +	mutex_lock(&mr->mkey_mtx);
>>> +	if (!mr->initialized)
>>> +		goto out;
>>> +
>>> +	if (mr->user_mr)
>>> +		destroy_user_mr(mvdev, mr);
>>> +	else
>>> +		destroy_dma_mr(mvdev, mr);
>>> +
>>>    	memset(mr, 0, sizeof(*mr));
>>>    	mr->initialized = false;
>>>    out:
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index fdf3e74bffbd..02a05492204c 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1780,6 +1780,10 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>>>    		ndev->mvdev.status = 0;
>>>    		ndev->mvdev.mlx_features = 0;
>>>    		++mvdev->generation;
>>> +		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>>> +			if (mlx5_vdpa_create_mr(mvdev, NULL))
>>> +				mlx5_vdpa_warn(mvdev, "create MR failed\n");
>>> +		}
>>>    		return;
>>>    	}
>>> @@ -1859,6 +1863,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>>>    	ndev = to_mlx5_vdpa_ndev(mvdev);
>>>    	free_resources(ndev);
>>> +	mlx5_vdpa_destroy_mr(mvdev);
>>>    	mlx5_vdpa_free_resources(&ndev->mvdev);
>>>    	mutex_destroy(&ndev->reslock);
>>>    }
>>> @@ -2023,9 +2028,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>>>    	if (err)
>>>    		goto err_mtu;
>>> +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>>> +		err = mlx5_vdpa_create_mr(mvdev, NULL);
>>> +		if (err)
>>> +			goto err_res;
>>> +	}
>>> +
>>>    	err = alloc_resources(ndev);
>>>    	if (err)
>>> -		goto err_res;
>>> +		goto err_mr;
>>>    	mvdev->vdev.mdev = &mgtdev->mgtdev;
>>>    	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
>>> @@ -2037,6 +2048,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>>>    err_reg:
>>>    	free_resources(ndev);
>>> +err_mr:
>>> +	mlx5_vdpa_destroy_mr(mvdev);
>>>    err_res:
>>>    	mlx5_vdpa_free_resources(&ndev->mvdev);
>>>    err_mtu:

