Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B6432330
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhJRPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233284AbhJRPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634571752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r7mw1O+Bt5c0sQ6lX8KPW8uaz0FCUii8T8NQx68gypg=;
        b=ATl8N+flCDin0tQZ+niyNZxNBHO57Q4su7Ud4xhVb0kODSqGvTBd8gCtKeE7w2oGbn1Dp4
        MXbBjaBga0ZJiJJ6zWGiFj/SRLecf1Rj7BLxZ+0Nd3sHE0rUVtu0ltR+N5Ui9xjBnQkAvh
        OA/PwqHrH0xqUnRWC8AELCEaO2bDmuk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Ry7EkcdLMvibB3Y8St4s7w-1; Mon, 18 Oct 2021 11:42:30 -0400
X-MC-Unique: Ry7EkcdLMvibB3Y8St4s7w-1
Received: by mail-wr1-f71.google.com with SMTP id r25-20020adfab59000000b001609ddd5579so8940665wrc.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7mw1O+Bt5c0sQ6lX8KPW8uaz0FCUii8T8NQx68gypg=;
        b=e2XYqAbRkZMT2PYIGGqpLHenbzJi0MpzdXL3BmBryLFECk6XjscuMfQnF2M6crTnv5
         KyibAi5HJw2kl0Tiqy9CTbq+ZwXgI1msHQYlwAvcqbkCN4Mz8jGkb2fYqybX/D1MlubR
         QpNuZQsFfJs+W/5zna7JQKgRmX/+iC8+6zMMwtnyy1YP/pEIUh2YQViRBIQZ5OidEtDZ
         UCtEU+0rYIZMmdk+OYc6/deh5gu+4jv9hJR/+0at7nMZbaxctL8K9bF7IpYuCsK4JJ5H
         rRpMbUKAo9bvQq6m8KamSFvRiv9ugHsBWJg7FyTUjmK6NHm3QlGrnm99SCFiFR0bb2+k
         DOUg==
X-Gm-Message-State: AOAM532K37aExKw+v8Yw9/6jkLTwaqRbS7vMkGh+DhNA+38cvs0PT8ZY
        QxGLa3n4zswY6mP+zk+nsha6/dKtsEHfiOthWHKGYCId6W2MyF5Dks9lJzcZA2/CxR8Wrdc1ONr
        2ReuzYTO8APxB06P0ou4p/o3f
X-Received: by 2002:adf:e292:: with SMTP id v18mr35186389wri.369.1634571749029;
        Mon, 18 Oct 2021 08:42:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBSOSiWq21d1Yw7khQZe7v4MbUWpxK1TCoqbBEOQYqnf+rf+Nc44g+h+f4t+6eFrbtQZTAiw==
X-Received: by 2002:adf:e292:: with SMTP id v18mr35186353wri.369.1634571748802;
        Mon, 18 Oct 2021 08:42:28 -0700 (PDT)
Received: from redhat.com ([2.55.19.190])
        by smtp.gmail.com with ESMTPSA id l124sm19136758wml.8.2021.10.18.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:42:27 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:42:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, jasowang@redhat.com,
        robin.murphy@arm.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
Message-ID: <20211018114215-mutt-send-email-mst@kernel.org>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632477717-5254-2-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:01:53PM +0800, John Garry wrote:
> It really is a property of the IOVA rcache code that we need to alloc a
> power-of-2 size, so relocate the functionality to resize into
> alloc_iova_fast(), rather than the callsites.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

for vdpa code:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/iommu/dma-iommu.c            | 8 --------
>  drivers/iommu/iova.c                 | 9 +++++++++
>  drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
>  3 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 896bea04c347..a99b3445fef8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -444,14 +444,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  
>  	shift = iova_shift(iovad);
>  	iova_len = size >> shift;
> -	/*
> -	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -	 * will come back to bite us badly, so we have to waste a bit of space
> -	 * rounding up anything cacheable to make sure that can't happen. The
> -	 * order of the unadjusted size will still match upon freeing.
> -	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -		iova_len = roundup_pow_of_two(iova_len);
>  
>  	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>  
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 9e8bc802ac05..ff567cbc42f7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  	unsigned long iova_pfn;
>  	struct iova *new_iova;
>  
> +	/*
> +	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> +	 * will come back to bite us badly, so we have to waste a bit of space
> +	 * rounding up anything cacheable to make sure that can't happen. The
> +	 * order of the unadjusted size will still match upon freeing.
> +	 */
> +	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +		size = roundup_pow_of_two(size);
> +
>  	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
>  	if (iova_pfn)
>  		return iova_pfn;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 1daae2608860..2b1143f11d8f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
>  	unsigned long iova_len = iova_align(iovad, size) >> shift;
>  	unsigned long iova_pfn;
>  
> -	/*
> -	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -	 * will come back to bite us badly, so we have to waste a bit of space
> -	 * rounding up anything cacheable to make sure that can't happen. The
> -	 * order of the unadjusted size will still match upon freeing.
> -	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -		iova_len = roundup_pow_of_two(iova_len);
>  	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
>  
>  	return iova_pfn << shift;
> -- 
> 2.26.2

