Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829774136EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhIUQGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhIUQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:06:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:05:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so40775448wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gbhCudCRqsSPPfgLZae8+wcvvU+Va6IH5/SUP4OHRQ0=;
        b=aRZJUcSX6Y3XBmn3tkIFVZMeWRtKzuyye+NTDyqyK+Jr+VjiMtRgY7PUQ7YTkeAGO7
         OizSDdZiNhnNZGK+baCgeYk3guHhh7h6pQK8XBgMaW1X+6pRGcIHgcPtjrCykmUl+TMV
         faURgtco8FRIng9mDP02P22JEmYd9SZcU7BN+dBakg6sRZAharYpynJdGpnfJz4PsuKw
         +8lvNpQP+0w6SCVs6Cb4YRy0GWO4xJTtyKf/0GLXDxbFk0czQklD7UVDdzM0AbH350pD
         /1UAoeTAOq/q/glUWyqdfClVjPQg9JgCcjmch5R1d4jB7je782yBdw7YwG4fn4u/Je3j
         Hi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gbhCudCRqsSPPfgLZae8+wcvvU+Va6IH5/SUP4OHRQ0=;
        b=q0MU63XtllksAqBLq2x/Rtff29lmo7YrR1SZ9zgJCyKpuk0TTc5e5mQkszrEFlE6Ha
         hQMBp9UhTouoEsmORAqGiD5ZqHUiSOpxdziJgMj34P+UucRKx7+MIE62EsqEGgkPovlr
         iw6HBg22u4VX4wCBiegRaxUU2TqWnmXVpgC6S5FJy+KxMFLVLuCcp+1ryzADRQlJXg/9
         gU2LFQlJF9G8tFaAR2rnuCf6cxgqL/iILtV5zqpjNnGrVzwq4CRRZibTF5FuNIfbVjzb
         AjiFCuNKUZ9zwpe1mvZT97A3VJRzbzxOS/zmd36LtohsTZjuwxE2ZPkZrX2B8MRC0vwS
         wW/A==
X-Gm-Message-State: AOAM533/IllX4tpDGAvXtFsz/r03VpISMPTZ3pkAwElwTu3z06jVR02v
        mk51Yv0NBRrc/0dPqVJw6O9t28v9npo5Tw==
X-Google-Smtp-Source: ABdhPJwQ5ZH/isufxraKDORq4lCwIokvgZG93u1Y74aucCOMgMsxkuZwXJ8u1kr13CcLxTFlhFQ/8g==
X-Received: by 2002:a1c:9d96:: with SMTP id g144mr5726353wme.12.1632240307855;
        Tue, 21 Sep 2021 09:05:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id n15sm5518661wrg.58.2021.09.21.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:05:07 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:04:45 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 05/11] iommu/virtio: Add SVA feature and related
 enable/disable callbacks
Message-ID: <YUoCneU8zveJ54Kv@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-6-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-6-vivek.gautam@arm.com>
X-TUID: dlqycTTe2OVr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:21:41PM +0530, Vivek Gautam wrote:
> Add a feature flag to virtio iommu for Shared virtual addressing
> (SVA). This feature would indicate the availablily path for handling
> device page faults, and the provision for sending page response.

In this case the feature should probably be called PAGE_REQUEST or
similar. SVA aggregates PF + PASID + shared page tables

Thanks,
Jean

> Also add necessary methods to enable and disable SVA so that the
> masters can enable the SVA path. This also requires enabling the
> PRI capability on the device.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c      | 268 ++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_iommu.h |   1 +
>  2 files changed, 269 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3da5f0807711..250c137a211b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <linux/platform_device.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
> @@ -26,6 +27,7 @@
>  
>  #include <uapi/linux/virtio_iommu.h>
>  #include "iommu-pasid-table.h"
> +#include "iommu-sva-lib.h"
>  
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> @@ -37,6 +39,9 @@
>  /* Some architectures need an Address Space ID for each page table */
>  DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
>  
> +static DEFINE_MUTEX(sva_lock);
> +static DEFINE_MUTEX(iopf_lock);
> +
>  struct viommu_dev_pri_work {
>  	struct work_struct		work;
>  	struct viommu_dev		*dev;
> @@ -71,6 +76,7 @@ struct viommu_dev {
>  
>  	bool				has_map:1;
>  	bool				has_table:1;
> +	bool				has_sva:1;
>  };
>  
>  struct viommu_mapping {
> @@ -124,6 +130,12 @@ struct viommu_endpoint {
>  	void				*pstf;
>  	/* Preferred page table format */
>  	void				*pgtf;
> +
> +	/* sva */
> +	bool				ats_supported;
> +	bool				pri_supported;
> +	bool				sva_enabled;
> +	bool				iopf_enabled;
>  };
>  
>  struct viommu_ep_entry {
> @@ -582,6 +594,64 @@ static int viommu_add_pstf(struct viommu_endpoint *vdev, void *pstf, size_t len)
>  	return 0;
>  }
>  
> +static int viommu_init_ats_pri(struct viommu_endpoint *vdev)
> +{
> +	struct device *dev = vdev->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!dev_is_pci(vdev->dev))
> +		return -EINVAL;
> +
> +	if (pci_ats_supported(pdev))
> +		vdev->ats_supported = true;
> +
> +	if (pci_pri_supported(pdev))
> +		vdev->pri_supported = true;
> +
> +	return 0;
> +}
> +
> +static int viommu_enable_pri(struct viommu_endpoint *vdev)
> +{
> +	int ret;
> +	struct pci_dev *pdev;
> +
> +	/* Let's allow only 4 requests for PRI right now */
> +	size_t max_inflight_pprs = 4;
> +
> +	if (!vdev->pri_supported || !vdev->ats_supported)
> +		return -ENODEV;
> +
> +	pdev = to_pci_dev(vdev->dev);
> +
> +	ret = pci_reset_pri(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_enable_pri(pdev, max_inflight_pprs);
> +	if (ret) {
> +		dev_err(vdev->dev, "cannot enable PRI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void viommu_disable_pri(struct viommu_endpoint *vdev)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(vdev->dev))
> +		return;
> +
> +	pdev = to_pci_dev(vdev->dev);
> +
> +	if (!pdev->pri_enabled)
> +		return;
> +
> +	pci_disable_pri(pdev);
> +}
> +
>  static int viommu_init_queues(struct viommu_dev *viommu)
>  {
>  	viommu->iopf_pri = iopf_queue_alloc(dev_name(viommu->dev));
> @@ -684,6 +754,10 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  	if (ret)
>  		goto out_free_eps;
>  
> +	ret = viommu_init_ats_pri(vdev);
> +	if (ret)
> +		goto out_free_eps;
> +
>  	kfree(probe);
>  	return 0;
>  
> @@ -1681,6 +1755,194 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>  
> +static bool viommu_endpoint_iopf_supported(struct viommu_endpoint *vdev)
> +{
> +	/* TODO: support Stall model later */
> +	return vdev->pri_supported;
> +}
> +
> +bool viommu_endpoint_sva_supported(struct viommu_endpoint *vdev)
> +{
> +	struct viommu_dev *viommu = vdev->viommu;
> +
> +	if (!viommu->has_sva)
> +		return false;
> +
> +	return vdev->pasid_bits;
> +}
> +
> +bool viommu_endpoint_sva_enabled(struct viommu_endpoint *vdev)
> +{
> +	bool enabled;
> +
> +	mutex_lock(&sva_lock);
> +	enabled = vdev->sva_enabled;
> +	mutex_unlock(&sva_lock);
> +	return enabled;
> +}
> +
> +static int viommu_endpoint_sva_enable_iopf(struct viommu_endpoint *vdev)
> +{
> +	int ret;
> +	struct device *dev = vdev->dev;
> +
> +	if (!viommu_endpoint_iopf_supported(vdev))
> +		return 0;
> +
> +	if (!vdev->iopf_enabled)
> +		return -EINVAL;
> +
> +	if (vdev->pri_supported) {
> +		ret = iopf_queue_add_device(vdev->viommu->iopf_pri, dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* No other way to handle io page fault then */
> +		return -EINVAL;
> +	}
> +
> +	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
> +	if (ret)
> +		iopf_queue_remove_device(vdev->viommu->iopf_pri, dev);
> +
> +	return ret;
> +}
> +
> +static void viommu_endpoint_sva_disable_iopf(struct viommu_endpoint *vdev)
> +{
> +	struct device *dev = vdev->dev;
> +
> +	if (!vdev->iopf_enabled)
> +		return;
> +
> +	iommu_unregister_device_fault_handler(dev);
> +	iopf_queue_remove_device(vdev->viommu->iopf_pri, dev);
> +}
> +
> +static int viommu_endpoint_enable_sva(struct viommu_endpoint *vdev)
> +{
> +	int ret;
> +
> +	mutex_lock(&sva_lock);
> +	ret = viommu_endpoint_sva_enable_iopf(vdev);
> +	if (!ret)
> +		vdev->sva_enabled = true;
> +	mutex_unlock(&sva_lock);
> +
> +	return ret;
> +}
> +
> +static int viommu_endpoint_disable_sva(struct viommu_endpoint *vdev)
> +{
> +	mutex_lock(&sva_lock);
> +	viommu_endpoint_sva_disable_iopf(vdev);
> +	vdev->sva_enabled = false;
> +	mutex_unlock(&sva_lock);
> +
> +	return 0;
> +}
> +
> +int viommu_endpoint_enable_iopf(struct viommu_endpoint *vdev)
> +{
> +	int ret;
> +
> +	mutex_lock(&iopf_lock);
> +	if (vdev->pri_supported) {
> +		ret = viommu_enable_pri(vdev);
> +		if (ret)
> +			return ret;
> +	}
> +	vdev->iopf_enabled = true;
> +	mutex_unlock(&iopf_lock);
> +	return 0;
> +}
> +
> +int viommu_endpoint_disable_iopf(struct viommu_endpoint *vdev)
> +{
> +	if (vdev->sva_enabled)
> +		return -EBUSY;
> +
> +	mutex_lock(&iopf_lock);
> +	viommu_disable_pri(vdev);
> +	vdev->iopf_enabled = false;
> +	mutex_unlock(&iopf_lock);
> +	return 0;
> +}
> +
> +static bool viommu_dev_has_feature(struct device *dev,
> +				   enum iommu_dev_features feat)
> +{
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	if (!vdev)
> +		return false;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		return viommu_endpoint_iopf_supported(vdev);
> +	case IOMMU_DEV_FEAT_SVA:
> +		return viommu_endpoint_sva_supported(vdev);
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool viommu_dev_feature_enabled(struct device *dev,
> +				       enum iommu_dev_features feat)
> +{
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	if (!vdev)
> +		return false;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		return vdev->iopf_enabled;
> +	case IOMMU_DEV_FEAT_SVA:
> +		return viommu_endpoint_sva_enabled(vdev);
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int viommu_dev_enable_feature(struct device *dev,
> +				     enum iommu_dev_features feat)
> +{
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	if (!viommu_dev_has_feature(dev, feat))
> +		return -ENODEV;
> +
> +	if (viommu_dev_feature_enabled(dev, feat))
> +		return -EBUSY;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		return viommu_endpoint_enable_iopf(vdev);
> +	case IOMMU_DEV_FEAT_SVA:
> +		return viommu_endpoint_enable_sva(vdev);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int viommu_dev_disable_feature(struct device *dev,
> +				      enum iommu_dev_features feat)
> +{
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +
> +	if (!viommu_dev_feature_enabled(dev, feat))
> +		return -EINVAL;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_IOPF:
> +		return viommu_endpoint_disable_iopf(vdev);
> +	case IOMMU_DEV_FEAT_SVA:
> +		return viommu_endpoint_disable_sva(vdev);
> +	default:
> +		return -EINVAL;
> +	}
> +}
>  static struct iommu_ops viommu_ops = {
>  	.domain_alloc		= viommu_domain_alloc,
>  	.domain_free		= viommu_domain_free,
> @@ -1695,6 +1957,9 @@ static struct iommu_ops viommu_ops = {
>  	.get_resv_regions	= viommu_get_resv_regions,
>  	.put_resv_regions	= generic_iommu_put_resv_regions,
>  	.of_xlate		= viommu_of_xlate,
> +	.dev_feat_enabled	= viommu_dev_feature_enabled,
> +	.dev_enable_feat	= viommu_dev_enable_feature,
> +	.dev_disable_feat	= viommu_dev_disable_feature,
>  };
>  
>  static int viommu_init_vqs(struct viommu_dev *viommu)
> @@ -1811,6 +2076,8 @@ static int viommu_probe(struct virtio_device *vdev)
>  		goto err_free_vqs;
>  	}
>  
> +	viommu->has_sva = virtio_has_feature(vdev, VIRTIO_IOMMU_F_SVA);
> +
>  	viommu->geometry = (struct iommu_domain_geometry) {
>  		.aperture_start	= input_start,
>  		.aperture_end	= input_end,
> @@ -1902,6 +2169,7 @@ static unsigned int features[] = {
>  	VIRTIO_IOMMU_F_PROBE,
>  	VIRTIO_IOMMU_F_MMIO,
>  	VIRTIO_IOMMU_F_ATTACH_TABLE,
> +	VIRTIO_IOMMU_F_SVA,
>  };
>  
>  static struct virtio_device_id id_table[] = {
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 53aa88e6b077..88a3db493108 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -17,6 +17,7 @@
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
>  #define VIRTIO_IOMMU_F_ATTACH_TABLE		6
> +#define VIRTIO_IOMMU_F_SVA			7
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> -- 
> 2.17.1
> 
