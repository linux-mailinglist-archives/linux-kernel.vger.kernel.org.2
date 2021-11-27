Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8136E460024
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 17:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhK0QXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 11:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233999AbhK0QVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 11:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638029913;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kP9G5nOumtKjxrGUQQJElSXHdsDYmsWeOL5Vc10tFp8=;
        b=JeZYRbuaorxwqgd7Q4/YKLbe6mWsPrBVbI41EJN3t0Krpaxt6eRH8xwcxBZB6oJ3oc2bgr
        r/s5B5QEMDqIfX1KciKt6wyb5qGsmn8FY3K5eHH+9ftEBLr8R3KUl2p5kHqope/WVAXA3L
        sH9ZccFQ3XVe1Rsw+q3VKVj6yYbb4mM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-wc7VTqxQPsy2dttpimuN-Q-1; Sat, 27 Nov 2021 11:18:32 -0500
X-MC-Unique: wc7VTqxQPsy2dttpimuN-Q-1
Received: by mail-wm1-f71.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so4212605wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 08:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=kP9G5nOumtKjxrGUQQJElSXHdsDYmsWeOL5Vc10tFp8=;
        b=5spjcdFX0Pu+fciVF1s6x9zLk2A9OAgQdHcEFPKWw2Y29LFB+sesOrzLLQi58kVhNW
         tbf4SLA9AFOdZ1s+jXsm0sPwjz88ia2AlWuGPSiu21epvMJLuhW9RPgst5egzSHX447a
         GOUItSOgf6gY50A+cQe2WRj96Xe/0v9zqAvTQ/PNQGV4GCINhDmpgE6K6PJBeo0St6Ba
         kmNlLobR+xR2EdMvzdHr1TlFqTGl/FRjkyG13YAVqYtHZWlgEz89PQWNh0xats+quWAN
         5g7r2y7LDZ4yjYfbfaso7XCQ3EhoLMAEJcwS4TokAnE9vHyx1npqC50pjb+hC+djVhsU
         pTrQ==
X-Gm-Message-State: AOAM530XbhE7EiOCSf1HKwNq4G5wl1NX5Ff1zlX2ryRtFkaF3PFzMJzn
        8w8iDTfthDmg4Gu2g8Tg99GX6XZcWWBJlexoUzDvndfY+uH+ovkD9+Ezf7IpHkH9CG99c8qobZy
        TGQsvaALrV0nQ6HN4lEFQo9F/
X-Received: by 2002:adf:fd90:: with SMTP id d16mr21220527wrr.385.1638029910828;
        Sat, 27 Nov 2021 08:18:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytZwHqxY+KvXMZhaFZl21+/JpV13hJPqRL/1UC79cwtAyf0HQ7txFbJs99R25+hd9EGf2Tfg==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr21220508wrr.385.1638029910605;
        Sat, 27 Nov 2021 08:18:30 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id bd18sm9210802wmb.43.2021.11.27.08.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 08:18:29 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 2/5] iommu/virtio: Support bypass domains
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-3-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <fd03ac99-9bd4-197b-26c8-dcc5de1b3057@redhat.com>
Date:   Sat, 27 Nov 2021 17:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 11/23/21 4:52 PM, Jean-Philippe Brucker wrote:
> The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the ATTACH
> request, that creates a bypass domain. Use it to enable identity
> domains.
>
> When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device, we
> currently fail attaching to an identity domain. Future patches will
> instead create identity mappings in this case.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 80930ce04a16..ee8a7afd667b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -71,6 +71,7 @@ struct viommu_domain {
>  	struct rb_root_cached		mappings;
>  
>  	unsigned long			nr_endpoints;
> +	bool				bypass;
>  };
>  
>  struct viommu_endpoint {
> @@ -587,7 +588,9 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>  {
>  	struct viommu_domain *vdomain;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
>  
>  	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
> @@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  	vdomain->map_flags	= viommu->map_flags;
>  	vdomain->viommu		= viommu;
>  
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		if (!virtio_has_feature(viommu->vdev,
nit: couldn't the check be done before the ida_alloc_range(),
simplifying the failure cleanup?

Thanks

Eric
> +					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +			ida_free(&viommu->domain_ids, vdomain->id);
> +			vdomain->viommu = 0;
> +			return -EOPNOTSUPP;
> +		}
> +
> +		vdomain->bypass = true;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -691,6 +705,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		.domain		= cpu_to_le32(vdomain->id),
>  	};
>  
> +	if (vdomain->bypass)
> +		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
> +
>  	for (i = 0; i < fwspec->num_ids; i++) {
>  		req.endpoint = cpu_to_le32(fwspec->ids[i]);
>  
> @@ -1132,6 +1149,7 @@ static unsigned int features[] = {
>  	VIRTIO_IOMMU_F_DOMAIN_RANGE,
>  	VIRTIO_IOMMU_F_PROBE,
>  	VIRTIO_IOMMU_F_MMIO,
> +	VIRTIO_IOMMU_F_BYPASS_CONFIG,
>  };
>  
>  static struct virtio_device_id id_table[] = {

