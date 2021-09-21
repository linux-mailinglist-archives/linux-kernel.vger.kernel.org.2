Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD184136DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhIUQBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbhIUQBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:01:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271FBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:59:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so40729028wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AtZyyTP986q5izPT5lFbv6cJ5CVeOkj7bVUgoAF+aPE=;
        b=qn8z1Wbkql8CqtKixkOZJfHbzjeuBbinRO0kMwKxCb0qOIrbleyJ5e2P2YBme9hhQd
         npB+D2tprMu7tQ9xPboAPoUxLWvzYj0qtGUdZWjjnX/QACr4MJjk9P6kaSN/NVT4vhSo
         C9ODmI/mHhyqcDhULh3v0wjFyt8Uu/Elftxsz4cTyqK6mkROt3VFsJtokj4kXciRUZfX
         OsxZgAgRk2Z8USr6T+8L0LP7KNak3SelmLNRb6o1DuePBxyc0FGr/ZG6/wccXWQhCKg4
         fu5VLgQA3b/YaW/POQ2oM8m7kG1gdwq9KHKIwzfrYAYUI2CMm+Wbw7X6yS6nTTRLRwEq
         3kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtZyyTP986q5izPT5lFbv6cJ5CVeOkj7bVUgoAF+aPE=;
        b=uGJOt+fIVvsqW3MifORQRMi4Bvqf6Fw1XQZ3376bc7iTZL4slumGV4o/XdiK3aMsee
         DqRDKF8zM/GlwDpEBiby3QMLj6SG8cnInsulcHlR1syJKGpdf9qmVwqjgwmxnokFiWNa
         8T4ABSAZp8lBwK64lDsAQwyysNUw/cXXN1ut/dhN3R0d+8NF2NgoC8eQ4jB1DGwlV6Ct
         s8+ac/n26w8ftPLga1gGQ53chnRJLjBWajFW1puLJxwPrveKBflb3hg0QHMhEjizi/HE
         SLktAZyDQGMsxoCs7k872w+AkPfa8Wb0ARfc7UE/wg1C+OedCxSsPY+kr3xmQ+D2mMvD
         2MTw==
X-Gm-Message-State: AOAM533lDvzjT97Gj17m2rqkniP5uRQulx2zYuqtEt4+2UnXuzX2zAbM
        wfCGbg0qIFx5YuDW1ag9b0Qyog==
X-Google-Smtp-Source: ABdhPJwaROKNZrdKnelWS30U+Qu/Ae+90Y3oEspXKLXzr2302zCcSxHLGjrCndLcOXgApQye9wguvg==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr36130015wru.285.1632239985681;
        Tue, 21 Sep 2021 08:59:45 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id o1sm2799031wmq.26.2021.09.21.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:59:45 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:59:23 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints
 served by viommu_dev
Message-ID: <YUoBW13+CvIljUgc@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-3-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423095147.27922-3-vivek.gautam@arm.com>
X-TUID: +1WeLErnK1xS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:21:38PM +0530, Vivek Gautam wrote:
> Keeping a record of list of endpoints that are served by the virtio-iommu
> device would help in redirecting the requests of page faults to the
> correct endpoint device to handle such requests.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 50039070e2aa..c970f386f031 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -48,6 +48,7 @@ struct viommu_dev {
>  	spinlock_t			request_lock;
>  	struct list_head		requests;
>  	void				*evts;
> +	struct list_head		endpoints;

As we're going to search by ID, an xarray or rb_tree would be more
appropriate than a list

>  
>  	/* Device configuration */
>  	struct iommu_domain_geometry	geometry;
> @@ -115,6 +116,12 @@ struct viommu_endpoint {
>  	void				*pgtf;
>  };
>  
> +struct viommu_ep_entry {
> +	u32				eid;
> +	struct viommu_endpoint		*vdev;
> +	struct list_head		list;
> +};

No need for a separate struct, I think you can just add the list head and
id into viommu_endpoint.

> +
>  struct viommu_request {
>  	struct list_head		list;
>  	void				*writeback;
> @@ -573,6 +580,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  	size_t probe_len;
>  	struct virtio_iommu_req_probe *probe;
>  	struct virtio_iommu_probe_property *prop;
> +	struct viommu_ep_entry *ep;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  
> @@ -640,6 +648,18 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  		prop = (void *)probe->properties + cur;
>  		type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
>  	}
> +	if (ret)
> +		goto out_free;
> +
> +	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
> +	if (!ep) {
> +		ret = -ENOMEM;
> +		goto out_free;
> +	}
> +	ep->eid = probe->endpoint;
> +	ep->vdev = vdev;
> +
> +	list_add(&ep->list, &viommu->endpoints);

This should be in viommu_probe_device() (viommu_probe_endpoint() is only
called if F_PROBE is negotiated). I think we need a lock for this
list/xarray

Thanks,
Jean

>  
>  out_free:
>  	kfree(probe);
> @@ -1649,6 +1669,7 @@ static int viommu_probe(struct virtio_device *vdev)
>  	viommu->dev = dev;
>  	viommu->vdev = vdev;
>  	INIT_LIST_HEAD(&viommu->requests);
> +	INIT_LIST_HEAD(&viommu->endpoints);
>  
>  	ret = viommu_init_vqs(viommu);
>  	if (ret)
> -- 
> 2.17.1
> 
