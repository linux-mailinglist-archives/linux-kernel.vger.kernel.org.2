Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C88365B70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhDTOtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhDTOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618930119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3pGrxDQTrsahWqPF4BATAsWy195XHZCR8bZtF3h1SQ=;
        b=XjcrTSbokiv1tJR8TRW7yWAX6kbouUcgpW4j4IeaAro2pRkCZ1MqwDFzQ0/TPtMH+rcbhs
        H1J2luemBmT3BH3HH9JdSoCHEZv2X8dKes4TJdT9RfnhgQNg7rSuAvsT6NQ9L+LTL9arow
        0PXsg/gBSP6sQOEhnxfvXk4lSJIbma0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-tjQ0A6PlPxK9Y_GmiyzWEA-1; Tue, 20 Apr 2021 10:48:34 -0400
X-MC-Unique: tjQ0A6PlPxK9Y_GmiyzWEA-1
Received: by mail-wr1-f70.google.com with SMTP id 91-20020adf82e40000b0290106e67e7bfcso8220473wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z3pGrxDQTrsahWqPF4BATAsWy195XHZCR8bZtF3h1SQ=;
        b=hShtgwMrPdzYsqh7PbHL3cn/SdQDKcsm3W+gjT/gtFbcor0o1ILcKD+r7nKtiTq0Os
         pYjtSkau58RyMkxAw06kmQSPrNMVDL4/lcIUXIa4LHyiCER8v7e/LFZL8W7Pfr2XGWBw
         kxyRA8wYqnsImOVTqLDLv2C1aZ+Apsr4NLYMWL1EW4p0li/D5xp+VncNd0YK0JBoF94/
         lHtl+Ujl2cPZawE4E0AMDW/tm6Qu19RMaNkdEG3TdDRyur2u6zfyg3bw39ivP2WG7MD0
         rGAXTM3xuGK4mcDIYWXVbgN0yO/ah7qlrcLSVzIOCQdLR0s2pglBi3J4APaIEaXKQDGp
         AE4A==
X-Gm-Message-State: AOAM530lbTuJymCbkKex34cIc+viJO4lr/LkrWWaeglkryO0T2RDyTNk
        DEhlop72ik9HeIXN6aRRWwsc4+WzZ3moBSx54ikuH4rvJ6EY01LEc4TnGPhgo0pQ/5c+oOfp5Qv
        sQf7Cmvk88pAHMTYMtis0djfZ
X-Received: by 2002:a1c:4045:: with SMTP id n66mr4768352wma.94.1618930113339;
        Tue, 20 Apr 2021 07:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDFDQA67mvm5ZD4QmmSNpkuMV2HU0SQ4C2NsHoCUD5jbAOYnb9XnMmP/yrEe6VIwTuBA8ZZw==
X-Received: by 2002:a1c:4045:: with SMTP id n66mr4768331wma.94.1618930113148;
        Tue, 20 Apr 2021 07:48:33 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id l14sm16944556wrv.94.2021.04.20.07.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 07:48:32 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] kernel/resource: Fix locking in
 request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, bsingharora@gmail.com, smuchun@gmail.com
References: <20210419070109.4780-1-apopple@nvidia.com>
 <20210419070109.4780-3-apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9edc40ae-daf9-90ef-fac6-824b5ae00e30@redhat.com>
Date:   Tue, 20 Apr 2021 16:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210419070109.4780-3-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.21 09:01, Alistair Popple wrote:
> request_free_mem_region() is used to find an empty range of physical
> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> over the range of possible addresses using region_intersects() to see if
> the range is free before calling request_mem_region() to allocate the
> region.
> 
> However the resource_lock is dropped between these two calls meaning by the
> time request_mem_region() is called in request_free_mem_region() another
> thread may have already reserved the requested region. This results in
> unexpected failures and a message in the kernel log from hitting this
> condition:
> 
>          /*
>           * mm/hmm.c reserves physical addresses which then
>           * become unavailable to other users.  Conflicts are
>           * not expected.  Warn to aid debugging if encountered.
>           */
>          if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
>                  pr_warn("Unaddressable device %s %pR conflicts with %pR",
>                          conflict->name, conflict, res);
> 
> These unexpected failures can be corrected by holding resource_lock across
> the two calls. This also requires memory allocation to be performed prior
> to taking the lock.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   kernel/resource.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 75f8da722497..e8468e867495 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1801,25 +1801,56 @@ static struct resource *__request_free_mem_region(struct device *dev,
>   {
>   	resource_size_t end, addr;
>   	struct resource *res;
> +	struct region_devres *dr = NULL;
>   
>   	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
>   	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
>   	addr = end - size + 1UL;
>   
> +	res = alloc_resource(GFP_KERNEL);
> +	if (!res)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (dev) {
> +		dr = devres_alloc(devm_region_release,
> +				sizeof(struct region_devres), GFP_KERNEL);
> +		if (!dr) {
> +			free_resource(res);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
> +	write_lock(&resource_lock);
>   	for (; addr > size && addr >= base->start; addr -= size) {
> -		if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> +		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
>   				REGION_DISJOINT)
>   			continue;
>   
> -		if (dev)
> -			res = devm_request_mem_region(dev, addr, size, name);
> -		else
> -			res = request_mem_region(addr, size, name);
> -		if (!res)
> -			return ERR_PTR(-ENOMEM);
> +		if (!__request_region_locked(res, &iomem_resource, addr, size,
> +						name, 0))
> +			break;
> +
> +		if (dev) {
> +			dr->parent = &iomem_resource;
> +			dr->start = addr;
> +			dr->n = size;
> +			devres_add(dev, dr);
> +		}
> +
>   		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> +		write_unlock(&resource_lock);
> +
> +		/*
> +		 * A driver is claiming this region so revoke any mappings.
> +		 */
> +		revoke_iomem(res);
>   		return res;
>   	}
> +	write_unlock(&resource_lock);
> +
> +	free_resource(res);
> +	if (dr)
> +		devres_free(dr);
>   
>   	return ERR_PTR(-ERANGE);
>   }
> 

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

