Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD55739558E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhEaGqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhEaGqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622443482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUaSuygZibRbIXo2WqN5Ex4ftPJcRx59Uhx8TtNHYWQ=;
        b=iRAUEXzbEDTiVYrrs3c8pQ1p1T6T1jP3LwM3EB2VnfS6v1XBn9x80EVc8IKnzxB68X8+z8
        WbTGubSX6dgN0gPdmJPPOI7aGLhq/4XVMnb8n6ixQSFpIX7ppl9jc+oC2yHVDVx1zbVhUR
        UCoB0OuyD7T9G7wFzWAQzug7xDk1UyI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-fH2bFV6nMj-Gv2rJUzsaRQ-1; Mon, 31 May 2021 02:44:41 -0400
X-MC-Unique: fH2bFV6nMj-Gv2rJUzsaRQ-1
Received: by mail-pf1-f197.google.com with SMTP id j206-20020a6280d70000b02902e9e02e1654so574015pfd.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 23:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SUaSuygZibRbIXo2WqN5Ex4ftPJcRx59Uhx8TtNHYWQ=;
        b=MWzXt7LPylk9iYbMe1904JPo98veD0VxiIRjUL09KqQv88AgdA05qoHISUJh8QRnmT
         cPLaR/lbf480hDjZEHNap02ybh3ypXlf2nqVX0ztFqO/wfX2mWmQnbG64IJaqP/KWFad
         R7CINHC2LqV8m3IET1Beh8bFLjB1ro6Zsd2f5iPTxxoxBgqxe7+w+VstCPsd7rf8gAqV
         sqeWagVAJme5YAw6xHcfpOD9+f1v3AJEIBM2KGZVoNlil+3WroYJrShUyAEm16nN/uNB
         n3fUNhvh2CIVtJ47PnILuAgA38X/znxtjT9neq8M8ROimj95ABGd7GmLk+AMDpAnyGq4
         0sog==
X-Gm-Message-State: AOAM530fPTRY9wyOu2NUNPTC7nE78AqiVcBaNbDupLl8Q/2obcCRkjoc
        RS2I4wCKdqBXdn/s2ibAAVtmSDIel3XwIr6Vm4VCsOVMukTD3EqHxLR1S741y/LHiUkcQOY+qef
        pjhVgYLYTZLR3BPBPjxi9XomS31ShnSycfEzSwSqQB+cfLrqX4vNWGbZ0iNEf7bb2g7z9ms29yD
        3d
X-Received: by 2002:a65:5684:: with SMTP id v4mr20716495pgs.218.1622443479669;
        Sun, 30 May 2021 23:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpfywURmpQK3qDRNW85wBFBQSUdZKWt/D1g3uaED+Wsy/u7Ad8Q8SY34NgN/HEhXWXj30lAA==
X-Received: by 2002:a65:5684:: with SMTP id v4mr20716472pgs.218.1622443479280;
        Sun, 30 May 2021 23:44:39 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm11475580pgk.33.2021.05.30.23.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 23:44:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] vdpa/mlx5: Add support for running with virtio_vdpa
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-3-elic@nvidia.com>
 <9b130015-d116-7fb0-1b86-2604353a2283@redhat.com>
 <20210531051308.GC158940@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a2f13f08-7e50-1fb3-3367-1b03f80af6ac@redhat.com>
Date:   Mon, 31 May 2021 14:44:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531051308.GC158940@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/31 下午1:13, Eli Cohen 写道:
> On Mon, May 31, 2021 at 11:16:11AM +0800, Jason Wang wrote:
>> 在 2021/5/30 下午3:54, Eli Cohen 写道:
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
>>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>>    drivers/vdpa/mlx5/core/mr.c        | 81 ++++++++++++++++++++++++------
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 13 ++++-
>>>    3 files changed, 80 insertions(+), 15 deletions(-)
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
>>> index 800cfd1967ad..020c0ce4d203 100644
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
>>> @@ -426,33 +423,89 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
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
>>
>> Do we need to set user_mr to false here?
> I think the right place to do this should be inside create_dma_mr(), the
> same as we set it true in ().


Fine.


>>
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
>>> index fdf3e74bffbd..f16756661c19 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1780,6 +1780,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>>>    		ndev->mvdev.status = 0;
>>>    		ndev->mvdev.mlx_features = 0;
>>>    		++mvdev->generation;
>>> +		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
>>> +			mlx5_vdpa_create_mr(mvdev, NULL);
>>
>> I wonder if it's possible/worth to avoid the destroy and re-create of dma MR
>> here. (In the case of it has been used by us).
> If it is a user MR, you must destroy it since it is useless. If it's
> DMA MR, you might be able to do it but since the DMA MR's are
> lightweight, I don't think it's worth it.


Yes, I agree.

Thanks


>
>> Thanks
>>
>>
>>>    		return;
>>>    	}
>>> @@ -1859,6 +1861,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>>>    	ndev = to_mlx5_vdpa_ndev(mvdev);
>>>    	free_resources(ndev);
>>> +	mlx5_vdpa_destroy_mr(mvdev);
>>>    	mlx5_vdpa_free_resources(&ndev->mvdev);
>>>    	mutex_destroy(&ndev->reslock);
>>>    }
>>> @@ -2023,9 +2026,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
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
>>> @@ -2037,6 +2046,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>>>    err_reg:
>>>    	free_resources(ndev);
>>> +err_mr:
>>> +	mlx5_vdpa_destroy_mr(mvdev);
>>>    err_res:
>>>    	mlx5_vdpa_free_resources(&ndev->mvdev);
>>>    err_mtu:

