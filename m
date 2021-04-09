Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3400359BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhDIKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbhDIKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:13:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B677EC0613DC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:12:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b9so5084234wrs.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUEnxg1OMOOSur94A9aN7FlFsVHuAQgGH0u9Ma67aXY=;
        b=libOP/UUaphY8XlEKHcmzyTKJOCF1p/aoHsSQX/kwn4Z4H5pndIo31iu9Inqw2j95q
         FvxzDAvcH+hgrXdcKOik/rcQZAG9Kq1WkmID0h2Y4V6HBHHse5x1WrnoZEhb0Lgk0GZS
         GzUmyK5Lqj9UyNNCJ0beE1wHgj9m/bEpXMXHQmcgqX8oQRegUGyZOUZhs2HwNGRg8pgS
         U/4M8v4TcPmJ6+9CgqvzXL2onF1p1buuRocfbYkKABJBZHVZYPo5yRWrzuFqmgu0cBg3
         H1nnzuz9fcYeT56jP44hc7YROrpRWrcIfXmThnTTY2LLLaqkf8ATriKtnzruPIJK7Yx8
         pL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUEnxg1OMOOSur94A9aN7FlFsVHuAQgGH0u9Ma67aXY=;
        b=J11EX7pBNyYvamDlH/DviTDdvlzWLHRQ+zo++6F6eORqn5eCNstp17vDEluVGsDNHs
         BaI/KDA3dZK2C7QVlrYqV5sgXqpJAJb/TlgAamGsqXLS4oioD+rSGL1lJmnJwTBgRf1T
         KOmM5OTLrDg3i2+m/eKq6mUWJwiLfFlxXuDxlwfETu+lawElJZPm1gftgw/kfoNcrVlq
         FphwBaj0cvxyyTbmdhTXDYpU9f0AkSA8sNDq5nui/hzcG+NGf/cOChIPdkBljCUjO5m/
         /LZopC83TTm9hZOM5Z+0f+AY6Aql3CAJgrRmHWOWX1q7IczO2ludTEKAqzGIB3LyE5Ia
         P4GA==
X-Gm-Message-State: AOAM5317adern+Yk7cKZUo8Tksa3I1xcjNhYUv/8juOlOzqMJ508Mswb
        J+6SZ0ETX4O7a1rJUMCS5tB+mQ==
X-Google-Smtp-Source: ABdhPJwCQh2lHhwl3BW2JH3jGbEZvdjBGs8b9p0Ock98TtAcZGIfIX/AnZHQdwZwdsF0ZSztRjf2dw==
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr16924599wrw.240.1617963126420;
        Fri, 09 Apr 2021 03:12:06 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n4sm2902160wmq.40.2021.04.09.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:12:05 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:11:47 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <YHAoY9+w2ebYZ7VV@myrica>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:08:56AM -0700, Jacob Pan wrote:
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index bd41405..bd99f6b 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -12,27 +12,33 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
>  
>  /**
>   * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> - * @mm: the mm
>   * @min: minimum PASID value (inclusive)
>   * @max: maximum PASID value (inclusive)
>   *
> - * Try to allocate a PASID for this mm, or take a reference to the existing one
> - * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> + * Try to allocate a PASID for the current mm, or take a reference to the
> + * existing one provided it fits within the [@min, @max] range. On success
> + * the PASID is available in the current mm->pasid, and must be released with
> + * iommu_sva_free_pasid().
>   * @min must be greater than 0, because 0 indicates an unused mm->pasid.
>   *
>   * Returns 0 on success and < 0 on error.
>   */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
>  {
>  	int ret = 0;
>  	ioasid_t pasid;
> +	struct mm_struct *mm;
>  
>  	if (min == INVALID_IOASID || max == INVALID_IOASID ||
>  	    min == 0 || max < min)
>  		return -EINVAL;
>  
>  	mutex_lock(&iommu_sva_lock);
> +	mm = get_task_mm(current);
> +	if (!mm) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

I still think it would be more elegant to keep the choice of context in
iommu_sva_bind_device() and pass it down to leaf functions such as
iommu_sva_alloc_pasid(). The patch is trying to solve two separate
problems:

* We don't have a use-case for binding the mm of a remote process (and
  it's supposedly difficult for device drivers to do it securely). So OK,
  we remove the mm argument from iommu_sva_bind_device() and use the
  current mm. But the IOMMU driver isn't going to do get_task_mm(current)
  every time it needs the mm being bound, it will take it from
  iommu_sva_bind_device(). Likewise iommu_sva_alloc_pasid() shouldn't need
  to bother with get_task_mm().

* cgroup accounting for IOASIDs needs to be on the current task. Removing
  the mm parameter from iommu_sva_alloc_pasid() doesn't help with that.
  Sure it indicates that iommu_sva_alloc_pasid() needs a specific task
  context but that's only for cgroup purpose, and I'd rather pass the
  cgroup down from iommu_sva_bind_device() anyway (but am fine with
  keeping it within ioasid_alloc() for now). Plus it's an internal helper,
  easy for us to check that the callers are doing the right thing.

>  	if (mm->pasid) {
>  		if (mm->pasid >= min && mm->pasid <= max)
>  			ioasid_get(mm->pasid);
> @@ -45,22 +51,32 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  		else
>  			mm->pasid = pasid;
>  	}
> +	mmput(mm);
> +out_unlock:
>  	mutex_unlock(&iommu_sva_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
>  
>  /**
> - * iommu_sva_free_pasid - Release the mm's PASID
> + * iommu_sva_free_pasid - Release the current mm's PASID
>   * @mm: the mm
>   *
>   * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
>   */
> -void iommu_sva_free_pasid(struct mm_struct *mm)
> +void iommu_sva_free_pasid(void)
>  {
> +	struct mm_struct *mm;
> +
>  	mutex_lock(&iommu_sva_lock);
> +	mm = get_task_mm(current);
> +	if (!mm)
> +		goto out_unlock;
> +

More importantly, could we at least dissociate free_pasid() from the
current process?  Otherwise drivers can't clean up from a workqueue (as
amdkfd does) or from an rcu callback. Given that iommu_sva_unbind_device()
takes the SVA handle owned by whomever did bind(), there shouldn't be any
security issue. For the cgroup problem, ioasid.c could internally keep
track of the cgroup used during allocation rather than assuming the
context of ioasid_put() is the same as ioasid_get()

>  	if (ioasid_put(mm->pasid))
>  		mm->pasid = 0;
> +	mmput(mm);
> +out_unlock:
>  	mutex_unlock(&iommu_sva_lock);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index b40990a..278b8b4 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -8,8 +8,8 @@
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
>  
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
> -void iommu_sva_free_pasid(struct mm_struct *mm);
> +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max);
> +void iommu_sva_free_pasid(void);
>  struct mm_struct *iommu_sva_find(ioasid_t pasid);
>  
>  #endif /* _IOMMU_SVA_LIB_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index bf0a20f..25840e6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -23,6 +23,7 @@
>  #include <linux/property.h>
>  #include <linux/fsl/mc.h>
>  #include <linux/module.h>
> +#include <linux/sched/mm.h>
>  #include <trace/events/iommu.h>
>  
>  static struct kset *iommu_group_kset;
> @@ -2959,9 +2960,8 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>  
>  /**
> - * iommu_sva_bind_device() - Bind a process address space to a device
> + * iommu_sva_bind_device() - Bind the current process address space to a device
>   * @dev: the device
> - * @mm: the mm to bind, caller must hold a reference to it
>   * @flags: options for the bind operation
>   *
>   * Create a bond between device and address space, allowing the device to access

There is another reference to @mm to remove in the function description

> @@ -2975,9 +2975,10 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>   * On error, returns an ERR_PTR value.
>   */
>  struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
> +iommu_sva_bind_device(struct device *dev, unsigned int flags)
>  {
>  	struct iommu_group *group;
> +	struct mm_struct *mm = NULL;
>  	struct iommu_sva *handle = ERR_PTR(-EINVAL);
>  	const struct iommu_ops *ops = dev->bus->iommu_ops;
>  
> @@ -2989,8 +2990,11 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
>  		return ERR_PTR(-ENODEV);
>  
>  	/* Supervisor SVA does not need the current mm */
> -	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
> -		return ERR_PTR(-EINVAL);
> +	if (!(flags & IOMMU_SVA_BIND_SUPERVISOR)) {
> +		mm = get_task_mm(current);
> +		if (!mm)
> +			return ERR_PTR(-EINVAL);
> +	}
>  	/* Ensure device count and domain don't change while we're binding */
>  	mutex_lock(&group->mutex);
>  
> @@ -3004,6 +3008,8 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
>  		goto out_unlock;
>  
>  	handle = ops->sva_bind(dev, mm, flags);
> +	if (mm)
> +		mmput(mm);
>  out_unlock:
>  	mutex_unlock(&group->mutex);
>  	iommu_group_put(group);
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 27e0e04..da4401a 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
>  	if (!(uacce->flags & UACCE_DEV_SVA))
>  		return 0;
>  
> -	handle = iommu_sva_bind_device(uacce->parent, current->mm, 0);
> +	handle = iommu_sva_bind_device(uacce->parent, 0);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a3fbaa2..cf752f3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -231,8 +231,8 @@ struct iommu_iotlb_gather {
>   * @dev_feat_enabled: check enabled feature
>   * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
>   * @aux_get_pasid: get the pasid given an aux-domain
> - * @sva_bind: Bind process address space to device
> - * @sva_unbind: Unbind process address space from device
> + * @sva_bind: Bind the current process address space to device
> + * @sva_unbind: Unbind the current process address space from device

These don't need changing since we're still passing the mm down to the
drivers

Thanks,
Jean

>   * @sva_get_pasid: Get PASID associated to a SVA handle
>   * @page_response: handle page request response
>   * @cache_invalidate: invalidate translation caches
> @@ -652,7 +652,6 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
>  int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
>  
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> -					struct mm_struct *mm,
>  					unsigned int flags);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> @@ -1028,7 +1027,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  }
>  
>  static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)
> +iommu_sva_bind_device(struct device *dev, unsigned int flags)
>  {
>  	return NULL;
>  }
> -- 
> 2.7.4
> 
