Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED442460248
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 00:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhK0XPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 18:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230082AbhK0XNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 18:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638054603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1EKa07C9btxCh09mEEz7bXhy2ReeCiovE+mbyXMOvJk=;
        b=d38KLuZIgOyPlfOSMhfHTF7Nuyr+7slFwvk4D+GkSOsKBw0oTI+Y6Ms1psyJccXq1KNfFj
        y4fxOlD8q/8XhCDb9C0jt9eJKluODXdZUbyUt/38klPXQrbyQ/nWoFsOFwW2N0NUTN9A5t
        xW5VEPBwdYBgAuIZvtuEPBatofjCTJQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-bZmo6hwdOCS5NPUqCk9G0g-1; Sat, 27 Nov 2021 18:10:02 -0500
X-MC-Unique: bZmo6hwdOCS5NPUqCk9G0g-1
Received: by mail-wm1-f69.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so7159134wmg.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 15:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1EKa07C9btxCh09mEEz7bXhy2ReeCiovE+mbyXMOvJk=;
        b=mOOyaA0eyKAIzGtFbMBOt1AwDdJVpHZJtIJmepSO4S7I8hEeogSSsptrp5Du7XAww2
         8bvI44ZU4sd0x/OJbVYMJs0wd9TBsB6/5KOW0NZLAv4PtH10K34tE8A7n40tzGiUSZ9N
         0zPC8tWAS5LK8P6w7mah2W5J2Z4ZH+wmFEfsj7l5M4bbY6GzKkGHWv0CaygdqXdR9w22
         D0YJpfcxE/fXk5eYieuzu94R1DDyzcICWWUuleDcz82hP12IbJcb29lqsL8K32KneHlx
         3LsokDDeuo8ji5Nu9mIEo0jfcDbNH0INr6IVmvE0WXWZCxuXmpwjv4MlHj+86kn15LX+
         c8xg==
X-Gm-Message-State: AOAM531QctGqut/wEGFHzLqj3vyqxTNKiuxmM9Pk/BBRFBOcX4/nEikn
        hafiyIdM4joILQJ+ikIV3+7JWz+zRLKxP2s4y7N9uLl8Qi7j9TOy78Dp1nanhJUe9/h3z6iPd97
        WR8cQJXh/X052QxL5IG1rFed8
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr23540214wri.343.1638054601060;
        Sat, 27 Nov 2021 15:10:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzms3nBiSGgLSlbVrcBrfL3xe3M9wymYpfR9ud7pfgrJAw8q/TcFAUVVL2cyPsBTALpRaDwUg==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr23540196wri.343.1638054600882;
        Sat, 27 Nov 2021 15:10:00 -0800 (PST)
Received: from redhat.com ([2.55.9.9])
        by smtp.gmail.com with ESMTPSA id e8sm9296105wrr.26.2021.11.27.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 15:10:00 -0800 (PST)
Date:   Sat, 27 Nov 2021 18:09:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v2 4/5] iommu/virtio: Pass end address to
 viommu_add_mapping()
Message-ID: <20211127180742-mutt-send-email-mst@kernel.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-5-jean-philippe@linaro.org>
 <7b79fe9b-9d51-8bda-2868-b48781f07fc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b79fe9b-9d51-8bda-2868-b48781f07fc9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 06:09:40PM +0100, Eric Auger wrote:
> 
> 
> On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> > To support identity mappings, the virtio-iommu driver must be able to
> > represent full 64-bit ranges internally. Pass (start, end) instead of
> > (start, size) to viommu_add/del_mapping().
> >
> > Clean comments. The one about the returned size was never true: when
> > sweeping the whole address space the returned size will most certainly
> > be smaller than 2^64.
> >
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 
> > ---
> >  drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
> >  1 file changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index d63ec4d11b00..eceb9281c8c1 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -311,8 +311,8 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
> >   *
> >   * On success, return the new mapping. Otherwise return NULL.
> >   */
> > -static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> > -			      phys_addr_t paddr, size_t size, u32 flags)
> > +static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
> > +			      phys_addr_t paddr, u32 flags)
> >  {
> >  	unsigned long irqflags;
> >  	struct viommu_mapping *mapping;

I am worried that API changes like that will cause subtle
bugs since types of arguments change but not their
number. If we forgot to update some callers it will all be messed up.

How about passing struct Range instead?

> > @@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> >  
> >  	mapping->paddr		= paddr;
> >  	mapping->iova.start	= iova;
> > -	mapping->iova.last	= iova + size - 1;
> > +	mapping->iova.last	= end;
> >  	mapping->flags		= flags;
> >  
> >  	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
> > @@ -338,26 +338,24 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> >   *
> >   * @vdomain: the domain
> >   * @iova: start of the range
> > - * @size: size of the range. A size of 0 corresponds to the entire address
> > - *	space.
> > + * @end: end of the range
> >   *
> > - * On success, returns the number of unmapped bytes (>= size)
> > + * On success, returns the number of unmapped bytes
> >   */
> >  static size_t viommu_del_mappings(struct viommu_domain *vdomain,
> > -				  unsigned long iova, size_t size)
> > +				  u64 iova, u64 end)
> >  {
> >  	size_t unmapped = 0;
> >  	unsigned long flags;
> > -	unsigned long last = iova + size - 1;
> >  	struct viommu_mapping *mapping = NULL;
> >  	struct interval_tree_node *node, *next;
> >  
> >  	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> > -	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
> > +	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
> >  	while (next) {
> >  		node = next;
> >  		mapping = container_of(node, struct viommu_mapping, iova);
> > -		next = interval_tree_iter_next(node, iova, last);
> > +		next = interval_tree_iter_next(node, iova, end);
> >  
> >  		/* Trying to split a mapping? */
> >  		if (mapping->iova.start < iova)
> > @@ -656,8 +654,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
> >  {
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > -	/* Free all remaining mappings (size 2^64) */
> > -	viommu_del_mappings(vdomain, 0, 0);
> > +	/* Free all remaining mappings */
> > +	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
> >  
> >  	if (vdomain->viommu)
> >  		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
> > @@ -742,6 +740,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  {
> >  	int ret;
> >  	u32 flags;
> > +	u64 end = iova + size - 1;
> >  	struct virtio_iommu_req_map map;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > @@ -752,7 +751,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  	if (flags & ~vdomain->map_flags)
> >  		return -EINVAL;
> >  
> > -	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
> > +	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -761,7 +760,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		.domain		= cpu_to_le32(vdomain->id),
> >  		.virt_start	= cpu_to_le64(iova),
> >  		.phys_start	= cpu_to_le64(paddr),
> > -		.virt_end	= cpu_to_le64(iova + size - 1),
> > +		.virt_end	= cpu_to_le64(end),
> >  		.flags		= cpu_to_le32(flags),
> >  	};
> >  
> > @@ -770,7 +769,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  
> >  	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> >  	if (ret)
> > -		viommu_del_mappings(vdomain, iova, size);
> > +		viommu_del_mappings(vdomain, iova, end);
> >  
> >  	return ret;
> >  }
> > @@ -783,7 +782,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
> >  	struct virtio_iommu_req_unmap unmap;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > -	unmapped = viommu_del_mappings(vdomain, iova, size);
> > +	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
> >  	if (unmapped < size)
> >  		return 0;
> >  

