Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A735A524
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhDISBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:01:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:2114 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDISBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:01:02 -0400
IronPort-SDR: dNx40MQFNOz/0kZHiKwEfuUWXpUh3oWyXswlpVWYpMfE79L7LwknVZrFHLcAOOwetnaDzzujQn
 RL8c6wedh+dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="180942777"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="180942777"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:00:49 -0700
IronPort-SDR: J+zkHtPe2orqaaEnwRqKH/64CAh9vwyAvWXN9GT91BmMxgwONnY//an6VZUshWZZILgpM+mCp6
 xr+ozroq2fYw==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="459316292"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:00:49 -0700
Date:   Fri, 9 Apr 2021 11:03:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210409110305.6b0471d9@jacob-builder>
In-Reply-To: <YHAoY9+w2ebYZ7VV@myrica>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <YHAoY9+w2ebYZ7VV@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On Fri, 9 Apr 2021 12:11:47 +0200, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Thu, Apr 08, 2021 at 10:08:56AM -0700, Jacob Pan wrote:
> > diff --git a/drivers/iommu/iommu-sva-lib.c
> > b/drivers/iommu/iommu-sva-lib.c index bd41405..bd99f6b 100644
> > --- a/drivers/iommu/iommu-sva-lib.c
> > +++ b/drivers/iommu/iommu-sva-lib.c
> > @@ -12,27 +12,33 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
> >  
> >  /**
> >   * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> > - * @mm: the mm
> >   * @min: minimum PASID value (inclusive)
> >   * @max: maximum PASID value (inclusive)
> >   *
> > - * Try to allocate a PASID for this mm, or take a reference to the
> > existing one
> > - * provided it fits within the [@min, @max] range. On success the
> > PASID is
> > - * available in mm->pasid, and must be released with
> > iommu_sva_free_pasid().
> > + * Try to allocate a PASID for the current mm, or take a reference to
> > the
> > + * existing one provided it fits within the [@min, @max] range. On
> > success
> > + * the PASID is available in the current mm->pasid, and must be
> > released with
> > + * iommu_sva_free_pasid().
> >   * @min must be greater than 0, because 0 indicates an unused
> > mm->pasid. *
> >   * Returns 0 on success and < 0 on error.
> >   */
> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max) +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
> >  {
> >  	int ret = 0;
> >  	ioasid_t pasid;
> > +	struct mm_struct *mm;
> >  
> >  	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> >  	    min == 0 || max < min)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&iommu_sva_lock);
> > +	mm = get_task_mm(current);
> > +	if (!mm) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}  
> 
> I still think it would be more elegant to keep the choice of context in
> iommu_sva_bind_device() and pass it down to leaf functions such as
> iommu_sva_alloc_pasid(). The patch is trying to solve two separate

I agree if iommu_sva_alloc_pasid() is a leaf function, but it is a public
function, e.g. called by smmu code:
	/* Allocate a PASID for this mm if necessary */
	ret = iommu_sva_alloc_pasid(1, (1U << master->ssid_bits) - 1);
If we give mm as parameter, it will give callers the illusion that this
mm doesn't have to be current->mm.

Should we make it into a leaf function by splitting iommu_sva_alloc_pasid()
into two parts?
1. iommu_sva_assign_pasid() //a new leaf helper function does mm->pasid
assignment
2. ioasid_alloc()

in iommu_sva_bind_device(), we do:
1. handle = driver ops->sva_bind(dev, mm, flags);
2. pasid = sva_get_pasid(handle);
3. iommu_sva_assign_pasid(mm, pasid)

In vendor driver sva_bind(), it just use ioasid_alloc directly with custom
range. e.g. arm-smmu-v3-sva.c
- ret = iommu_sva_alloc_pasid(1, (1U << master->ssid_bits) - 1);
+ ret = ioasid_alloc(&iommu_sva_pasid, 1, (1U << master->ssid_bits);
                                   
> problems:
> 
> * We don't have a use-case for binding the mm of a remote process (and
>   it's supposedly difficult for device drivers to do it securely). So OK,
>   we remove the mm argument from iommu_sva_bind_device() and use the
>   current mm. But the IOMMU driver isn't going to do get_task_mm(current)
>   every time it needs the mm being bound, it will take it from
>   iommu_sva_bind_device(). Likewise iommu_sva_alloc_pasid() shouldn't need
>   to bother with get_task_mm().
> 
> * cgroup accounting for IOASIDs needs to be on the current task. Removing
>   the mm parameter from iommu_sva_alloc_pasid() doesn't help with that.
>   Sure it indicates that iommu_sva_alloc_pasid() needs a specific task
>   context but that's only for cgroup purpose, and I'd rather pass the
>   cgroup down from iommu_sva_bind_device() anyway (but am fine with
>   keeping it within ioasid_alloc() for now). Plus it's an internal helper,
>   easy for us to check that the callers are doing the right thing.
> 
With the above split, we really just have one allocation function:
ioasid_alloc(), so it can manage current cgroup accounting within. Would
this work?

> >  	if (mm->pasid) {
> >  		if (mm->pasid >= min && mm->pasid <= max)
> >  			ioasid_get(mm->pasid);
> > @@ -45,22 +51,32 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> > ioasid_t min, ioasid_t max) else
> >  			mm->pasid = pasid;
> >  	}
> > +	mmput(mm);
> > +out_unlock:
> >  	mutex_unlock(&iommu_sva_lock);
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> >  
> >  /**
> > - * iommu_sva_free_pasid - Release the mm's PASID
> > + * iommu_sva_free_pasid - Release the current mm's PASID
> >   * @mm: the mm
> >   *
> >   * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
> >   */
> > -void iommu_sva_free_pasid(struct mm_struct *mm)
> > +void iommu_sva_free_pasid(void)
> >  {
> > +	struct mm_struct *mm;
> > +
> >  	mutex_lock(&iommu_sva_lock);
> > +	mm = get_task_mm(current);
> > +	if (!mm)
> > +		goto out_unlock;
> > +  
> 
> More importantly, could we at least dissociate free_pasid() from the
> current process?  Otherwise drivers can't clean up from a workqueue (as
> amdkfd does) or from an rcu callback. Given that iommu_sva_unbind_device()
> takes the SVA handle owned by whomever did bind(), there shouldn't be any
> security issue. For the cgroup problem, ioasid.c could internally keep
> track of the cgroup used during allocation rather than assuming the
> context of ioasid_put() is the same as ioasid_get()
> 
Good point, you are right cgroup uncharge does not have to be on the
current. I will keep the mm parameter here.

> >  	if (ioasid_put(mm->pasid))
> >  		mm->pasid = 0;
> > +	mmput(mm);
> > +out_unlock:
> >  	mutex_unlock(&iommu_sva_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
> > diff --git a/drivers/iommu/iommu-sva-lib.h
> > b/drivers/iommu/iommu-sva-lib.h index b40990a..278b8b4 100644
> > --- a/drivers/iommu/iommu-sva-lib.h
> > +++ b/drivers/iommu/iommu-sva-lib.h
> > @@ -8,8 +8,8 @@
> >  #include <linux/ioasid.h>
> >  #include <linux/mm_types.h>
> >  
> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max); -void iommu_sva_free_pasid(struct mm_struct *mm);
> > +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max);
> > +void iommu_sva_free_pasid(void);
> >  struct mm_struct *iommu_sva_find(ioasid_t pasid);
> >  
> >  #endif /* _IOMMU_SVA_LIB_H */
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index bf0a20f..25840e6 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/property.h>
> >  #include <linux/fsl/mc.h>
> >  #include <linux/module.h>
> > +#include <linux/sched/mm.h>
> >  #include <trace/events/iommu.h>
> >  
> >  static struct kset *iommu_group_kset;
> > @@ -2959,9 +2960,8 @@ int iommu_aux_get_pasid(struct iommu_domain
> > *domain, struct device *dev) EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
> >  
> >  /**
> > - * iommu_sva_bind_device() - Bind a process address space to a device
> > + * iommu_sva_bind_device() - Bind the current process address space to
> > a device
> >   * @dev: the device
> > - * @mm: the mm to bind, caller must hold a reference to it
> >   * @flags: options for the bind operation
> >   *
> >   * Create a bond between device and address space, allowing the device
> > to access  
> 
> There is another reference to @mm to remove in the function description
> 
will do

> > @@ -2975,9 +2975,10 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
> >   * On error, returns an ERR_PTR value.
> >   */
> >  struct iommu_sva *
> > -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
> > unsigned int flags) +iommu_sva_bind_device(struct device *dev, unsigned
> > int flags) {
> >  	struct iommu_group *group;
> > +	struct mm_struct *mm = NULL;
> >  	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> >  	const struct iommu_ops *ops = dev->bus->iommu_ops;
> >  
> > @@ -2989,8 +2990,11 @@ iommu_sva_bind_device(struct device *dev, struct
> > mm_struct *mm, unsigned int fla return ERR_PTR(-ENODEV);
> >  
> >  	/* Supervisor SVA does not need the current mm */
> > -	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
> > -		return ERR_PTR(-EINVAL);
> > +	if (!(flags & IOMMU_SVA_BIND_SUPERVISOR)) {
> > +		mm = get_task_mm(current);
> > +		if (!mm)
> > +			return ERR_PTR(-EINVAL);
> > +	}
> >  	/* Ensure device count and domain don't change while we're
> > binding */ mutex_lock(&group->mutex);
> >  
> > @@ -3004,6 +3008,8 @@ iommu_sva_bind_device(struct device *dev, struct
> > mm_struct *mm, unsigned int fla goto out_unlock;
> >  
> >  	handle = ops->sva_bind(dev, mm, flags);
> > +	if (mm)
> > +		mmput(mm);
> >  out_unlock:
> >  	mutex_unlock(&group->mutex);
> >  	iommu_group_put(group);
> > diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> > index 27e0e04..da4401a 100644
> > --- a/drivers/misc/uacce/uacce.c
> > +++ b/drivers/misc/uacce/uacce.c
> > @@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device
> > *uacce, struct uacce_queue *q) if (!(uacce->flags & UACCE_DEV_SVA))
> >  		return 0;
> >  
> > -	handle = iommu_sva_bind_device(uacce->parent, current->mm, 0);
> > +	handle = iommu_sva_bind_device(uacce->parent, 0);
> >  	if (IS_ERR(handle))
> >  		return PTR_ERR(handle);
> >  
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index a3fbaa2..cf752f3 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -231,8 +231,8 @@ struct iommu_iotlb_gather {
> >   * @dev_feat_enabled: check enabled feature
> >   * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
> >   * @aux_get_pasid: get the pasid given an aux-domain
> > - * @sva_bind: Bind process address space to device
> > - * @sva_unbind: Unbind process address space from device
> > + * @sva_bind: Bind the current process address space to device
> > + * @sva_unbind: Unbind the current process address space from device  
> 
> These don't need changing since we're still passing the mm down to the
> drivers
> 
Right, I struggled between two options :)

> Thanks,
> Jean
> 
> >   * @sva_get_pasid: Get PASID associated to a SVA handle
> >   * @page_response: handle page request response
> >   * @cache_invalidate: invalidate translation caches
> > @@ -652,7 +652,6 @@ void iommu_aux_detach_device(struct iommu_domain
> > *domain, struct device *dev); int iommu_aux_get_pasid(struct
> > iommu_domain *domain, struct device *dev); 
> >  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> > -					struct mm_struct *mm,
> >  					unsigned int flags);
> >  void iommu_sva_unbind_device(struct iommu_sva *handle);
> >  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> > @@ -1028,7 +1027,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain,
> > struct device *dev) }
> >  
> >  static inline struct iommu_sva *
> > -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
> > unsigned int flags) +iommu_sva_bind_device(struct device *dev, unsigned
> > int flags) {
> >  	return NULL;
> >  }
> > -- 
> > 2.7.4
> >   


Thanks,

Jacob
