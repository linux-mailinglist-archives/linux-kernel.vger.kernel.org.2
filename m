Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186E4413701
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhIUQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhIUQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:11:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09580C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:09:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so39035410wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n/dUevHsiLdE2irKaS1K4eioH3NiOV8sQVgnvAoo5Ko=;
        b=mfU91cRuSYxoetgBDYjcRxoyjxzZNOhzDWtY9d0TYAAmHG0KE/ijeHoF7573yNouyH
         RkVW0cPEEr6cTRAn0+3XYADRMFj0hG7QpVeZQyPRKy6yWxP9rSdhTwYK6A7qjsqioj0I
         DL1dMhbzXj1kHxEulMNRKhALT3iaSxiJg3zSBt4NGDbGRSztkRW2NwzVHKOh6C1+ir2q
         lOKAenY5YLo+A5ur2WYBK95yVMjqo+DZLGY3onk8smssehg0eg9KB0dEl6TSvukBb1eG
         Nu+77/ytnWeV1lqlaLwQeSvXNbJHVE1MDxw0OvymIuiRf4Kej3stGYgUA/TxbY4KENe8
         Gl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n/dUevHsiLdE2irKaS1K4eioH3NiOV8sQVgnvAoo5Ko=;
        b=KQ+QMoPAZXDaEmXCWWX1+bhs9tEFls92qrgrh7PRVsX7qNle93IUZIUVPPen0ynF4n
         jRKNBwwcaDIHitUszk02DigWdd8bH1KA3RkSmUBIU+Rhj0L776SXMruZMhQBwchCvpqq
         HkqnVy4H0Yj8U6E5/EtH1AKlEQb3mCkyQwqtb5U8cQyUAzi4efRuc+vAHfAHDNwYI+Nq
         8FdMoE/6/Yzfuq61sOwAfypp7kpX7Cf+VovDl0fsscsXw9xV3/aVGn5aTcNSNZuu9B7P
         QQZeDqsjuMkNr0mlTlUv/9s134hDezQlG258InWbRO02DQ5hQhGqKJPN0c1m+UvObnuh
         1ALQ==
X-Gm-Message-State: AOAM530oS+ajglxAdVU0tkcF+xynQeOF66qUZT8t7PQL48sPUoPBsYXi
        HJ4h/5z/3jxNlXe+RrFQ3s/krA==
X-Google-Smtp-Source: ABdhPJxBu+3YJh8avIZrTawiYkjU/W2b+1aQMbVujqjUbPyuv6hyDWne+bNnYKVD0hbLSVljVhUkuA==
X-Received: by 2002:a05:600c:1c26:: with SMTP id j38mr5732706wms.12.1632240590526;
        Tue, 21 Sep 2021 09:09:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id c4sm13205218wrt.23.2021.09.21.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:09:50 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:09:28 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 09/11] iommu/virtio: Implement sva bind/unbind
 calls
Message-ID: <YUoDuOg0pVw8GGOl@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-10-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-10-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:21:45PM +0530, Vivek Gautam wrote:
> SVA bind and unbind implementations will allow to prepare translation
> context with CPU page tables that can be programmed into host iommu
> hardware to realize shared address space utilization between the CPU
> and virtualized devices using virtio-iommu.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c      | 199 +++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_iommu.h |   2 +
>  2 files changed, 199 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 250c137a211b..08f1294baeab 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -14,6 +14,9 @@
>  #include <linux/interval_tree.h>
>  #include <linux/iommu.h>
>  #include <linux/io-pgtable.h>
> +#include <linux/mm.h>
> +#include <linux/mmu_context.h>
> +#include <linux/mmu_notifier.h>
>  #include <linux/module.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
> @@ -28,6 +31,7 @@
>  #include <uapi/linux/virtio_iommu.h>
>  #include "iommu-pasid-table.h"
>  #include "iommu-sva-lib.h"
> +#include "io-pgtable-arm.h"

Is this used here?

>  
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> @@ -41,6 +45,7 @@ DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
>  
>  static DEFINE_MUTEX(sva_lock);
>  static DEFINE_MUTEX(iopf_lock);
> +static DEFINE_MUTEX(viommu_asid_lock);
>  
>  struct viommu_dev_pri_work {
>  	struct work_struct		work;
> @@ -88,10 +93,22 @@ struct viommu_mapping {
>  struct viommu_mm {
>  	int				pasid;
>  	u64				archid;
> +	struct viommu_sva_bond		*bond;
>  	struct io_pgtable_ops		*ops;
>  	struct viommu_domain		*domain;
>  };
>  
> +struct viommu_sva_bond {
> +	struct iommu_sva		sva;
> +	struct mm_struct		*mm;
> +	struct iommu_psdtable_mmu_notifier	*viommu_mn;
> +	struct list_head		list;
> +	refcount_t			refs;
> +};
> +
> +#define sva_to_viommu_bond(handle) \
> +	container_of(handle, struct viommu_sva_bond, sva)
> +
>  struct viommu_domain {
>  	struct iommu_domain		domain;
>  	struct viommu_dev		*viommu;
> @@ -136,6 +153,7 @@ struct viommu_endpoint {
>  	bool				pri_supported;
>  	bool				sva_enabled;
>  	bool				iopf_enabled;
> +	struct list_head		bonds;
>  };
>  
>  struct viommu_ep_entry {
> @@ -1423,14 +1441,15 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
>  
>  		pst_cfg->iommu_dev = viommu->dev->parent;
>  
> +		mutex_lock(&viommu_asid_lock);
>  		/* Prepare PASID tables info to allocate a new table */
>  		ret = viommu_prepare_pst(vdev, pst_cfg, fmt);
>  		if (ret)
> -			return ret;
> +			goto err_out_unlock;
>  
>  		ret = iommu_psdtable_alloc(tbl, pst_cfg);
>  		if (ret)
> -			return ret;
> +			goto err_out_unlock;
>  
>  		pst_cfg->iommu_dev = viommu->dev->parent;
>  		pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;
> @@ -1452,6 +1471,7 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
>  			if (ret)
>  				goto err_free_ops;
>  		}
> +		mutex_unlock(&viommu_asid_lock);
>  	} else {
>  		/* TODO: otherwise, check for compatibility with vdev. */
>  		return -ENOSYS;
> @@ -1467,6 +1487,8 @@ static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
>  err_free_psdtable:
>  	iommu_psdtable_free(tbl, &tbl->cfg);
>  
> +err_out_unlock:
> +	mutex_unlock(&viommu_asid_lock);
>  	return ret;
>  }
>  
> @@ -1706,6 +1728,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>  	vdev->dev = dev;
>  	vdev->viommu = viommu;
>  	INIT_LIST_HEAD(&vdev->resv_regions);
> +	INIT_LIST_HEAD(&vdev->bonds);
>  	dev_iommu_priv_set(dev, vdev);
>  
>  	if (viommu->probe_size) {
> @@ -1755,6 +1778,175 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>  
> +static u32 viommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
> +
> +	return bond->mm->pasid;
> +}
> +
> +static void viommu_mmu_notifier_free(struct mmu_notifier *mn)
> +{
> +	kfree(mn_to_pstiommu(mn));
> +}
> +
> +static struct mmu_notifier_ops viommu_mmu_notifier_ops = {
> +	.free_notifier		= viommu_mmu_notifier_free,

.invalidate_range and .release will be needed as well, to keep up to date
with changes to the address space

> +};
> +
> +/* Allocate or get existing MMU notifier for this {domain, mm} pair */
> +static struct iommu_psdtable_mmu_notifier *
> +viommu_mmu_notifier_get(struct viommu_domain *vdomain, struct mm_struct *mm,
> +			u32 asid_bits)
> +{
> +	int ret;
> +	struct iommu_psdtable_mmu_notifier *viommu_mn;
> +	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
> +
> +	list_for_each_entry(viommu_mn, &tbl->mmu_notifiers, list) {
> +		if (viommu_mn->mn.mm == mm) {
> +			refcount_inc(&viommu_mn->refs);
> +			return viommu_mn;
> +		}
> +	}
> +
> +	mutex_lock(&viommu_asid_lock);
> +	viommu_mn = iommu_psdtable_alloc_shared(tbl, mm, &viommu_asid_xa,
> +						asid_bits);
> +	mutex_unlock(&viommu_asid_lock);
> +	if (IS_ERR(viommu_mn))
> +		return ERR_CAST(viommu_mn);
> +
> +	refcount_set(&viommu_mn->refs, 1);
> +	viommu_mn->cookie = vdomain;
> +	viommu_mn->mn.ops = &viommu_mmu_notifier_ops;
> +
> +	ret = mmu_notifier_register(&viommu_mn->mn, mm);
> +	if (ret)
> +		goto err_free_cd;
> +
> +	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid,
> +				   viommu_mn->vendor.cd);
> +	if (ret)
> +		goto err_put_notifier;
> +
> +	list_add(&viommu_mn->list, &tbl->mmu_notifiers);
> +	return viommu_mn;
> +
> +err_put_notifier:
> +	/* Frees viommu_mn */
> +	mmu_notifier_put(&viommu_mn->mn);
> +err_free_cd:
> +	iommu_psdtable_free_shared(tbl, &viommu_asid_xa, viommu_mn->vendor.cd);
> +	return ERR_PTR(ret);
> +}
> +
> +static void
> +viommu_mmu_notifier_put(struct iommu_psdtable_mmu_notifier *viommu_mn)
> +{
> +	struct mm_struct *mm = viommu_mn->mn.mm;
> +	struct viommu_domain *vdomain = viommu_mn->cookie;
> +	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
> +	u16 asid = viommu_mn->vendor.cd->asid;
> +
> +	if (!refcount_dec_and_test(&viommu_mn->refs))
> +		return;
> +
> +	list_del(&viommu_mn->list);
> +	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, NULL);
> +
> +	/*
> +	 * If we went through clear(), we've already invalidated, and no
> +	 * new TLB entry can have been formed.
> +	 */
> +	if (!viommu_mn->cleared)
> +		iommu_psdtable_flush_tlb(tbl, vdomain, asid);
> +
> +	/* Frees smmu_mn */
> +	mmu_notifier_put(&viommu_mn->mn);
> +	iommu_psdtable_free_shared(tbl, &viommu_asid_xa, viommu_mn->vendor.cd);
> +}
> +
> +static struct iommu_sva *
> +__viommu_sva_bind(struct device *dev, struct mm_struct *mm)
> +{
> +	int ret;
> +	struct viommu_sva_bond *bond;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct virtio_iommu_probe_table_format *desc = vdev->pgtf;
> +
> +	if (!vdev || !vdev->sva_enabled)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* If bind() was already called for this {dev, mm} pair, reuse it. */
> +	list_for_each_entry(bond, &vdev->bonds, list) {
> +		if (bond->mm == mm) {
> +			refcount_inc(&bond->refs);
> +			return &bond->sva;
> +		}
> +	}
> +
> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +	if (!bond)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Allocate a PASID for this mm if necessary */
> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << vdev->pasid_bits) - 1);
> +	if (ret)
> +		goto err_free_bond;
> +
> +	bond->mm = mm;
> +	bond->sva.dev = dev;
> +	refcount_set(&bond->refs, 1);
> +
> +	bond->viommu_mn = viommu_mmu_notifier_get(vdomain, mm, desc->asid_bits);
> +	if (IS_ERR(bond->viommu_mn)) {
> +		ret = PTR_ERR(bond->viommu_mn);
> +		goto err_free_pasid;
> +	}
> +
> +	list_add(&bond->list, &vdev->bonds);
> +	return &bond->sva;
> +
> +err_free_pasid:
> +	iommu_sva_free_pasid(mm);
> +err_free_bond:
> +	kfree(bond);
> +	return ERR_PTR(ret);
> +}
> +
> +/* closely follows arm_smmu_sva_bind() */
> +static struct iommu_sva *viommu_sva_bind(struct device *dev,
> +					 struct mm_struct *mm, void *drvdata)
> +{
> +	struct iommu_sva *handle;
> +
> +	mutex_lock(&sva_lock);
> +	handle = __viommu_sva_bind(dev, mm);
> +	mutex_unlock(&sva_lock);
> +	return handle;
> +}
> +
> +void viommu_sva_unbind(struct iommu_sva *handle)
> +{
> +	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(handle->dev);
> +
> +	if (vdev->pri_supported)
> +		iopf_queue_flush_dev(handle->dev);
> +
> +	mutex_lock(&sva_lock);
> +	if (refcount_dec_and_test(&bond->refs)) {
> +		list_del(&bond->list);
> +		viommu_mmu_notifier_put(bond->viommu_mn);
> +		iommu_sva_free_pasid(bond->mm);
> +		kfree(bond);
> +	}
> +	mutex_unlock(&sva_lock);
> +}
> +
>  static bool viommu_endpoint_iopf_supported(struct viommu_endpoint *vdev)
>  {
>  	/* TODO: support Stall model later */
> @@ -1960,6 +2152,9 @@ static struct iommu_ops viommu_ops = {
>  	.dev_feat_enabled	= viommu_dev_feature_enabled,
>  	.dev_enable_feat	= viommu_dev_enable_feature,
>  	.dev_disable_feat	= viommu_dev_disable_feature,
> +	.sva_bind		= viommu_sva_bind,
> +	.sva_unbind		= viommu_sva_unbind,
> +	.sva_get_pasid		= viommu_sva_get_pasid,
>  };
>  
>  static int viommu_init_vqs(struct viommu_dev *viommu)
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 88a3db493108..c12d9b6a7243 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -122,6 +122,8 @@ struct virtio_iommu_req_attach_pst_arm {
>  #define VIRTIO_IOMMU_PGTF_ARM_HPD0		(1ULL << 41)
>  #define VIRTIO_IOMMU_PGTF_ARM_EPD1		(1 << 23)
>  
> +#define VIRTIO_IOMMU_PGTF_ARM_IPS_SHIFT		32
> +#define VIRTIO_IOMMU_PGTF_ARM_IPS_MASK		0x7

Probably not the right place for this change

Thanks,
Jean

>  #define VIRTIO_IOMMU_PGTF_ARM_TG0_SHIFT		14
>  #define VIRTIO_IOMMU_PGTF_ARM_TG0_MASK		0x3
>  #define VIRTIO_IOMMU_PGTF_ARM_SH0_SHIFT		12
> -- 
> 2.17.1
> 
