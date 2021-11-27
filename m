Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51346006A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354621AbhK0RPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 12:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233999AbhK0RNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638032985;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFe5yi/mr65ynfmwsUKvWvB/XkbIsXm8YUYXCa3ZMc0=;
        b=gSoLKpVcNyaxqlDAYfUKK4pFisNVyMXTxLKAs9FOtyJKi3xcCt8gA4UjB6po4yw/DTarsK
        hnGTO7mC5a9uWhwW6Wjr8LgtzsKXcuUIO2PeSCn1th0eeVnXaA2QYi3BKRqdAVTzAT8z7o
        N7iosy7nAtKAdOaFKlsUKW18+Pm4Lu0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-jo72zMwSOa2DbiEIWF4LKg-1; Sat, 27 Nov 2021 12:09:44 -0500
X-MC-Unique: jo72zMwSOa2DbiEIWF4LKg-1
Received: by mail-wm1-f69.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso7283280wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=KFe5yi/mr65ynfmwsUKvWvB/XkbIsXm8YUYXCa3ZMc0=;
        b=EqrnHJBrrMX3gZEkAdRw7r7h3vgquSmCSu1x8ZAvwkjhpGxONz73NCZxxsRo3+2C/w
         PyIkxdVf4/cJLx2HCfJrIT9OE3oOqcHLDVV6sHnYLM8JnOrNHC9K2SWYaYApzt2f3eZu
         fMbybCRwfVtj8tOsrlU/XddizE48gagGbePJoi2TIfxNZuOAjfNYJCJJtwcpB/yR47sy
         FkXcAZ/fnGYTiJHEv5Kwk4w/6+jSXF84BQqsTUbpmDRmOuK2LKKD29RYLHFpKwPT+HjU
         ZfFaXz1Vq15zhvCo3S0vCQCvwpFvKt9mwekEFvnZJ2/Wh3EkZ3S8A2X/uBb7x4gYcy/I
         KAjw==
X-Gm-Message-State: AOAM530WBXTuRvSqeZfej0dUdSCmLgIis24CiRt0YYmuwWlE9fahS9zw
        2CkZ7uWYAq4wXsfsgAXdU/HzSrBDt8cWyqivua21+QDyNEoF7MX8LVM7Wrp+ywwKGEKKMiMcjKw
        6ZsJC3XOVYjD+5rYYaCJwf9s9
X-Received: by 2002:a5d:604a:: with SMTP id j10mr21446964wrt.93.1638032982828;
        Sat, 27 Nov 2021 09:09:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKkAndP1VxD/wPVzJiOOQlf4hxPHuE1NhzAzQNf9jHdgC1HjQtChnnWsj8U3KacpCaoBgyEg==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr21446941wrt.93.1638032982584;
        Sat, 27 Nov 2021 09:09:42 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id e8sm8682624wrr.26.2021.11.27.09.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 09:09:41 -0800 (PST)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 4/5] iommu/virtio: Pass end address to
 viommu_add_mapping()
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-5-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <7b79fe9b-9d51-8bda-2868-b48781f07fc9@redhat.com>
Date:   Sat, 27 Nov 2021 18:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> To support identity mappings, the virtio-iommu driver must be able to
> represent full 64-bit ranges internally. Pass (start, end) instead of
> (start, size) to viommu_add/del_mapping().
>
> Clean comments. The one about the returned size was never true: when
> sweeping the whole address space the returned size will most certainly
> be smaller than 2^64.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index d63ec4d11b00..eceb9281c8c1 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -311,8 +311,8 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
>   *
>   * On success, return the new mapping. Otherwise return NULL.
>   */
> -static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> -			      phys_addr_t paddr, size_t size, u32 flags)
> +static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
> +			      phys_addr_t paddr, u32 flags)
>  {
>  	unsigned long irqflags;
>  	struct viommu_mapping *mapping;
> @@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
>  
>  	mapping->paddr		= paddr;
>  	mapping->iova.start	= iova;
> -	mapping->iova.last	= iova + size - 1;
> +	mapping->iova.last	= end;
>  	mapping->flags		= flags;
>  
>  	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
> @@ -338,26 +338,24 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
>   *
>   * @vdomain: the domain
>   * @iova: start of the range
> - * @size: size of the range. A size of 0 corresponds to the entire address
> - *	space.
> + * @end: end of the range
>   *
> - * On success, returns the number of unmapped bytes (>= size)
> + * On success, returns the number of unmapped bytes
>   */
>  static size_t viommu_del_mappings(struct viommu_domain *vdomain,
> -				  unsigned long iova, size_t size)
> +				  u64 iova, u64 end)
>  {
>  	size_t unmapped = 0;
>  	unsigned long flags;
> -	unsigned long last = iova + size - 1;
>  	struct viommu_mapping *mapping = NULL;
>  	struct interval_tree_node *node, *next;
>  
>  	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> -	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
> +	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
>  	while (next) {
>  		node = next;
>  		mapping = container_of(node, struct viommu_mapping, iova);
> -		next = interval_tree_iter_next(node, iova, last);
> +		next = interval_tree_iter_next(node, iova, end);
>  
>  		/* Trying to split a mapping? */
>  		if (mapping->iova.start < iova)
> @@ -656,8 +654,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> -	/* Free all remaining mappings (size 2^64) */
> -	viommu_del_mappings(vdomain, 0, 0);
> +	/* Free all remaining mappings */
> +	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
>  
>  	if (vdomain->viommu)
>  		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
> @@ -742,6 +740,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  {
>  	int ret;
>  	u32 flags;
> +	u64 end = iova + size - 1;
>  	struct virtio_iommu_req_map map;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> @@ -752,7 +751,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  	if (flags & ~vdomain->map_flags)
>  		return -EINVAL;
>  
> -	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
> +	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
>  	if (ret)
>  		return ret;
>  
> @@ -761,7 +760,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  		.domain		= cpu_to_le32(vdomain->id),
>  		.virt_start	= cpu_to_le64(iova),
>  		.phys_start	= cpu_to_le64(paddr),
> -		.virt_end	= cpu_to_le64(iova + size - 1),
> +		.virt_end	= cpu_to_le64(end),
>  		.flags		= cpu_to_le32(flags),
>  	};
>  
> @@ -770,7 +769,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  
>  	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
>  	if (ret)
> -		viommu_del_mappings(vdomain, iova, size);
> +		viommu_del_mappings(vdomain, iova, end);
>  
>  	return ret;
>  }
> @@ -783,7 +782,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
>  	struct virtio_iommu_req_unmap unmap;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> -	unmapped = viommu_del_mappings(vdomain, iova, size);
> +	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
>  	if (unmapped < size)
>  		return 0;
>  

