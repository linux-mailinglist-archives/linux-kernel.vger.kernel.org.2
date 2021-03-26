Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0931534A0CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 06:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZFQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 01:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZFPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 01:15:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75680C0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:15:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so345409plt.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oN13yPbaAsOv4qWLYqKdeUMjaQgF1YjFDRa8G7F1Wns=;
        b=MHKrmGYdWvxfU6nP53gVJ5o3QYXhXONq42CG74OvvDcxJUI3jQYYfy4vK9US1P8Lv6
         kJkfd34cGxYIhJfmNIsS/UviGwuTWtZKsU+emSCCZsTnrMJgrIYhNuvU+zEWcWZOUVsS
         PNzkiXMI8Ya/gImUrrYzUUOJ7PJInAiaN2A/zOa8Knl4S8wctKALuEZLFPP0qBdhFRQO
         WLRp+YF5qccYcOcPm6x39J6ddFUqFIky3DyD6HxCkhBUXroQtpoNTKVXWfO+2hbkhGKX
         HVGShowUaHz/Pe9JqJ+F5c3cR+rV78rh5nCkmB+A/MY9dpONMpZ+tClZQxijUe/OiQzN
         bq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oN13yPbaAsOv4qWLYqKdeUMjaQgF1YjFDRa8G7F1Wns=;
        b=a8BOkEhJArzNQ6pMsuGJtttIv62YA+j0kTjf54gPxwVFnLhRXnqrXIAqG3R5/Ope0H
         M2k5J0xsZ1wDz+A0p/llJgIDbMPXezAvdCQfvpEaFmSUIPoTys+SNpxTHm2Wi0KlrSDJ
         HvV/ZBNsQ7xcEfFhm9wmFA94ErPUKg6YcY6kXQi+gC4vkBrUydd6ucl9y374Vod8lTQ0
         /xRQTL4as2zmIsamhOv3r+NX8WdjqgMQ4hiMpDdFDpAZcmBPogU5EX+8WShrVvK0xKH2
         D8kXMZkBx/b/Syp92uDhc65OX96jN46KOqngkMbRA8v+Jm5ksDAo8AGWmozxBoBzWHkV
         zhBw==
X-Gm-Message-State: AOAM532eRVgzYhrG5J+zPN1l26c3Go2MEuoaTjXy7a5FWUg/5X3CZqJG
        LMHVPOD1mr+7MOkLEN4i0AM=
X-Google-Smtp-Source: ABdhPJyxPxOLe+skuF9DoXO9L/gWbycGcV6blk57NdpBvnx/vG95h9BukJ3WmcKzR14TbUYzECUHmA==
X-Received: by 2002:a17:902:b088:b029:e6:e1d8:20cc with SMTP id p8-20020a170902b088b02900e6e1d820ccmr13455564plr.27.1616735740442;
        Thu, 25 Mar 2021 22:15:40 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id t22sm7162931pjw.54.2021.03.25.22.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 22:15:39 -0700 (PDT)
Date:   Fri, 26 Mar 2021 16:15:36 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        david@redhat.com, daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] kernel/resource: Fix locking in
 request_free_mem_region
Message-ID: <20210326051536.GN77072@balbir-desktop>
References: <20210326012035.3853-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326012035.3853-1-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:20:35PM +1100, Alistair Popple wrote:
> request_free_mem_region() is used to find an empty range of physical
> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> over the range of possible addresses using region_intersects() to see if
> the range is free.
> 
> region_intersects() obtains a read lock before walking the resource tree
> to protect against concurrent changes. However it drops the lock prior
> to returning. This means by the time request_mem_region() is called in
> request_free_mem_region() another thread may have already reserved the
> requested region resulting in unexpected failures and a message in the
> kernel log from hitting this condition:
> 
>         /*
>          * mm/hmm.c reserves physical addresses which then
>          * become unavailable to other users.  Conflicts are
>          * not expected.  Warn to aid debugging if encountered.
>          */
>         if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
>                 pr_warn("Unaddressable device %s %pR conflicts with %pR",
>                         conflict->name, conflict, res);
> 
> To fix this create versions of region_intersects() and
> request_mem_region() that allow the caller to take the appropriate lock
> such that it may be held over the required calls.
> 
> Instead of creating another version of devm_request_mem_region() that
> doesn't take the lock open-code it to allow the caller to pre-allocate
> the required memory prior to taking the lock.
> 
> Fixes: 0c385190392d8 ("resource: add a not device managed request_free_mem_region variant")
> Fixes: 0092908d16c60 ("mm: factor out a devm_request_free_mem_region helper")
> Fixes: 4ef589dc9b10c ("mm/hmm/devmem: device memory hotplug using ZONE_DEVICE")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> v2:
>  - Added Fixes tag
> 
> ---
>  kernel/resource.c | 146 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 94 insertions(+), 52 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 627e61b0c124..2d4652383dd2 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
>  }
>  EXPORT_SYMBOL_GPL(page_is_ram);
>  
> +static int __region_intersects(resource_size_t start, size_t size,
> +			       unsigned long flags, unsigned long desc)
> +{
> +	struct resource res;
> +	int type = 0; int other = 0;
> +	struct resource *p;
> +
> +	res.start = start;
> +	res.end = start + size - 1;
> +
> +	for (p = iomem_resource.child; p ; p = p->sibling) {
> +		bool is_type = (((p->flags & flags) == flags) &&
> +				((desc == IORES_DESC_NONE) ||
> +				 (desc == p->desc)));

is_type is a bad name, are we saying "is" as in boolean question?
Or is it short for something like intersection_type? I know you've
just moved the code over :)

> +
> +		if (resource_overlaps(p, &res))
> +			is_type ? type++ : other++;
> +	}
> +
> +	if (type == 0)
> +		return REGION_DISJOINT;
> +
> +	if (other == 0)
> +		return REGION_INTERSECTS;
> +
> +	return REGION_MIXED;
> +}
> +
>  /**
>   * region_intersects() - determine intersection of region with known resources
>   * @start: region start address
> @@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
>  int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>  		      unsigned long desc)
>  {
> -	struct resource res;
> -	int type = 0; int other = 0;
> -	struct resource *p;
> -
> -	res.start = start;
> -	res.end = start + size - 1;
> +	int rc;
>  
>  	read_lock(&resource_lock);
> -	for (p = iomem_resource.child; p ; p = p->sibling) {
> -		bool is_type = (((p->flags & flags) == flags) &&
> -				((desc == IORES_DESC_NONE) ||
> -				 (desc == p->desc)));
> -
> -		if (resource_overlaps(p, &res))
> -			is_type ? type++ : other++;
> -	}
> +	rc = __region_intersects(start, size, flags, desc);
>  	read_unlock(&resource_lock);
> -
> -	if (type == 0)
> -		return REGION_DISJOINT;
> -
> -	if (other == 0)
> -		return REGION_INTERSECTS;
> -
> -	return REGION_MIXED;
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(region_intersects);
>  
> @@ -1171,31 +1180,17 @@ struct address_space *iomem_get_mapping(void)
>  	return smp_load_acquire(&iomem_inode)->i_mapping;
>  }
>  
> -/**
> - * __request_region - create a new busy resource region
> - * @parent: parent resource descriptor
> - * @start: resource start address
> - * @n: resource region size
> - * @name: reserving caller's ID string
> - * @flags: IO resource flags
> - */
> -struct resource * __request_region(struct resource *parent,
> -				   resource_size_t start, resource_size_t n,
> -				   const char *name, int flags)
> +static bool request_region_locked(struct resource *parent,
> +				    struct resource *res, resource_size_t start,
> +				    resource_size_t n, const char *name, int flags)
>  {
> -	DECLARE_WAITQUEUE(wait, current);
> -	struct resource *res = alloc_resource(GFP_KERNEL);
>  	struct resource *orig_parent = parent;
> -
> -	if (!res)
> -		return NULL;
> +	DECLARE_WAITQUEUE(wait, current);

This part of the diff looks confusing, do we have a waitqueue and we call
schedule() within a function called with the lock held?

>  
>  	res->name = name;
>  	res->start = start;
>  	res->end = start + n - 1;
>  
> -	write_lock(&resource_lock);
> -
>  	for (;;) {
>  		struct resource *conflict;
>  
> @@ -1230,16 +1225,39 @@ struct resource * __request_region(struct resource *parent,
>  			write_lock(&resource_lock);
>  			continue;
>  		}
> -		/* Uhhuh, that didn't work out.. */
> -		free_resource(res);
> -		res = NULL;
> -		break;
> +		return false;
>  	}
> -	write_unlock(&resource_lock);
>  
>  	if (res && orig_parent == &iomem_resource)
>  		revoke_iomem(res);
>  
> +	return true;
> +}
> +
> +/**
> + * __request_region - create a new busy resource region
> + * @parent: parent resource descriptor
> + * @start: resource start address
> + * @n: resource region size
> + * @name: reserving caller's ID string
> + * @flags: IO resource flags
> + */
> +struct resource *__request_region(struct resource *parent,
> +				  resource_size_t start, resource_size_t n,
> +				  const char *name, int flags)
> +{
> +	struct resource *res = alloc_resource(GFP_KERNEL);
> +
> +	if (!res)
> +		return NULL;
> +
> +	write_lock(&resource_lock);
> +	if (!request_region_locked(parent, res, start, n, name, flags)) {
> +		/* Uhhuh, that didn't work out.. */
> +		free_resource(res);
> +		res = NULL;
> +	}
> +	write_unlock(&resource_lock);

Should the function be called __request_region_locked?

>  	return res;
>  }
>  EXPORT_SYMBOL(__request_region);
> @@ -1779,26 +1797,50 @@ static struct resource *__request_free_mem_region(struct device *dev,
>  {
>  	resource_size_t end, addr;
>  	struct resource *res;
> +	struct region_devres *dr = NULL;
> +
> +	res = alloc_resource(GFP_KERNEL);
> +	if (!res)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (dev) {
> +		dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
> +				  GFP_KERNEL);
> +		if (!dr) {
> +			free_resource(res);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
>  
>  	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
>  	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
>  	addr = end - size + 1UL;
>  
> +	write_lock(&resource_lock);
>  	for (; addr > size && addr >= base->start; addr -= size) {
> -		if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> +		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
>  				REGION_DISJOINT)
>  			continue;
>  
> -		if (dev)
> -			res = devm_request_mem_region(dev, addr, size, name);
> -		else
> -			res = request_mem_region(addr, size, name);
> -		if (!res)
> -			return ERR_PTR(-ENOMEM);
> +		if (!request_region_locked(&iomem_resource, res, addr,
> +						   size, name, 0))
> +			break;
> +
>  		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> +		if (dev) {
> +			dr->parent = &iomem_resource;
> +			dr->start = addr;
> +			dr->n = size;
> +			devres_add(dev, dr);
> +		}
> +
> +		write_unlock(&resource_lock);
>  		return res;
>  	}
>  
> +	write_unlock(&resource_lock);
> +	free_resource(res);
> +
>  	return ERR_PTR(-ERANGE);
>  }
>

Balbir Singh.  
