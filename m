Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614E146006C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355649AbhK0RPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 12:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234088AbhK0RNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638033001;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpbaxbvFUA47MZA1WKLWnHmqPk4XzwH/ybSQA0YW/3U=;
        b=ehuC+zCN7tgvWKPIIaL9IZxl4ElmeTQ9HWhfRqUcOKB46yweYRJ6C5g1skrWDwGR95Nu/O
        SPYmdhfUS3jvJIXgxuDPoqh0uw8PB3tUmF79cZinkvXa90yCAhRUWyBVR8juWs3t1uVf1J
        BbRIEGLyeK7U1Ki/1me8EHe9qjTJ2GI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-6EayXV9PN9i7CMbbXXcLVA-1; Sat, 27 Nov 2021 12:09:59 -0500
X-MC-Unique: 6EayXV9PN9i7CMbbXXcLVA-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso7316807wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=HpbaxbvFUA47MZA1WKLWnHmqPk4XzwH/ybSQA0YW/3U=;
        b=3YBvn1YQx3GUysecQe/E6cec+NGRlItWi/4sVuQZLOqNN80MzW2cbkCALWAoLjAZNK
         FXM13E70VrNIFJ9StjNFdx27WsAf6jA7L/awsvuLmO5UdhKD7o5OjTWOn2LP/o5fUJHg
         zxpg8fRzzudp09Tvm0bNvPdNUTpYRgE6/PFvJz71lEjyOs6jmqCeUbcmk2ss5PTERcLe
         t8MSdtoN8dkFoEXkg/yL33O2WGZ6x+8DgqgORafTmyE8DkMskE4Ya5jixu+Pd5ui3hfV
         92L80d9jMEKMvFP2IFnJCapK4scFofxJNTc11i5Dy5zxxdylRpo5hDYAAhPIopcOFzBl
         L5lg==
X-Gm-Message-State: AOAM5301bWW0RZ1ee07//AtqdK+v6OGX3VP8HQuTtkzEDC0bOg6gTBcR
        Jwf76w9HDvIobb3I0ZWDrhmhKZf13BeJwoqvDBafeExcAjV/kWPwt+d+hrjiMHMpWH+k52wL2CC
        S14e3LyFCoXLDGpWKHVc7JuYR
X-Received: by 2002:a05:600c:1993:: with SMTP id t19mr24514982wmq.21.1638032998487;
        Sat, 27 Nov 2021 09:09:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylYMDW9wx2S0IayDXstUPO7/eLe+ycsLrI5JjytrC1XlaOvj4Wu+g0pzy2+IExg10pcHBflw==
X-Received: by 2002:a05:600c:1993:: with SMTP id t19mr24514956wmq.21.1638032998308;
        Sat, 27 Nov 2021 09:09:58 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l5sm10976720wrs.59.2021.11.27.09.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 09:09:57 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 5/5] iommu/virtio: Support identity-mapped domains
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-6-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <58572359-8232-3204-f69a-7f50b887a122@redhat.com>
Date:   Sat, 27 Nov 2021 18:09:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-6-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> Support identity domains for devices that do not offer the
> VIRTIO_IOMMU_F_BYPASS_CONFIG feature, by creating 1:1 mappings between
> the virtual and physical address space. Identity domains created this
> way still perform noticeably better than DMA domains, because they don't
> have the overhead of setting up and tearing down mappings at runtime.
> The performance difference between this and bypass is minimal in
> comparison.
>
> It does not matter that the physical addresses in the identity mappings
> do not all correspond to memory. By enabling passthrough we are trusting
> the device driver and the device itself to only perform DMA to suitable
> locations. In some cases it may even be desirable to perform DMA to MMIO
> regions.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index eceb9281c8c1..6a8a52b4297b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -375,6 +375,55 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
>  	return unmapped;
>  }
>  
> +/*
> + * Fill the domain with identity mappings, skipping the device's reserved
> + * regions.
> + */
> +static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
> +				      struct viommu_domain *vdomain)
> +{
> +	int ret;
> +	struct iommu_resv_region *resv;
> +	u64 iova = vdomain->domain.geometry.aperture_start;
> +	u64 limit = vdomain->domain.geometry.aperture_end;
> +	u32 flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
> +	unsigned long granule = 1UL << __ffs(vdomain->domain.pgsize_bitmap);
> +
> +	iova = ALIGN(iova, granule);
> +	limit = ALIGN_DOWN(limit + 1, granule) - 1;
> +
> +	list_for_each_entry(resv, &vdev->resv_regions, list) {
> +		u64 resv_start = ALIGN_DOWN(resv->start, granule);
> +		u64 resv_end = ALIGN(resv->start + resv->length, granule) - 1;
> +
> +		if (resv_end < iova || resv_start > limit)
> +			/* No overlap */
> +			continue;
> +
> +		if (resv_start > iova) {
> +			ret = viommu_add_mapping(vdomain, iova, resv_start - 1,
> +						 (phys_addr_t)iova, flags);
> +			if (ret)
> +				goto err_unmap;
> +		}
> +
> +		if (resv_end >= limit)
> +			return 0;
> +
> +		iova = resv_end + 1;
> +	}
> +
> +	ret = viommu_add_mapping(vdomain, iova, limit, (phys_addr_t)iova,
> +				 flags);
> +	if (ret)
> +		goto err_unmap;
> +	return 0;
> +
> +err_unmap:
> +	viommu_del_mappings(vdomain, 0, iova);
> +	return ret;
> +}
> +
>  /*
>   * viommu_replay_mappings - re-send MAP requests
>   *
> @@ -637,14 +686,18 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  	vdomain->viommu		= viommu;
>  
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> -		if (!virtio_has_feature(viommu->vdev,
> -					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +		if (virtio_has_feature(viommu->vdev,
> +				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +			vdomain->bypass = true;
> +			return 0;
> +		}
> +
> +		ret = viommu_domain_map_identity(vdev, vdomain);
> +		if (ret) {
>  			ida_free(&viommu->domain_ids, vdomain->id);
> -			vdomain->viommu = 0;
> +			vdomain->viommu = NULL;
nit: that change could have been done in patch 2
>  			return -EOPNOTSUPP;
>  		}
> -
> -		vdomain->bypass = true;
>  	}
>  
>  	return 0;
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

