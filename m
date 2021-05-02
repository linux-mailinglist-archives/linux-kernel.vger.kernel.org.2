Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EA5370EE1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhEBTzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhEBTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 15:55:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF8C06138B
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 12:54:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n10so131562ion.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VGpYy/1zWV/NQYSTMPSWihj0KmJxGbDNurHwTwE9HM=;
        b=sAOdmZ7Tj6Yp46aAAgLBOcpyjoiQEzJ9bopaYE6PHeS+brnLFPq8BqP7sdPmsj5TEw
         TXDGHj92816H3Lym7ZWSfC5q47Mxmdej0df/PGvWbjg4liWZTSKmYqB/W2akMywyHty9
         FEgyEbJpZJmUBhWU8Gj0WaacVbx0gAHSi5+3W9uoAOu5M+oxgESk3wtK8KyDHOFn+dwf
         wrbm9YVPkxq2C5nbicmECMNEuBgGyke9RztfMIn6TNReCSDowu3oM4i5iOFSw+jGYVRL
         Ih5LhF08XqfqrsHllvytKkAX1f7oMEyroLyhPzrEzU3TULXWhCX0ORxgrVWcUCJ0bfkL
         ytWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=1VGpYy/1zWV/NQYSTMPSWihj0KmJxGbDNurHwTwE9HM=;
        b=oZVc93A/B/gtIUjrhhfxZC+r35p7xOKklEK8hdLKYWmesD80u9RSq0aZSWN7OMdXrJ
         827D2b14Tc7UhXA25K/xwKyYGrBDDL+jDRYUjijhhUpOMrEgkYI7iW+f7aTSckjscqew
         jd+mCSdmxmBgZgfE1Oqe7AXecyYnUFwnMRK08jKhKcwMFxGTRolLPL2inZomFbNYb4qV
         2QSj8jglBbZMaS4Br9Bwv4K3GK4crC12NxYiTFFohc5v1gQ9RU46BN5mj5wkenibMV0o
         q7p/lGXpH/k45jJ+KwS2IqAk9j8uG+Vfd+jTdp4BgwwUn4tJfBPdNBg/5BD+6tsRRnvI
         1Z6Q==
X-Gm-Message-State: AOAM531L1eMMFxnqAve6MjDpEU9qzdpXfZ2iBf2A5uyCOmPYGO6X2UzD
        iIqholUapW7S8BfkJTi/cX8oNA==
X-Google-Smtp-Source: ABdhPJwP2mcqPGiTkoaaUbOq/rPQAYTRf2ATZL19JX8yuRctalk0esbxisYKWz4bz8l0wLe1q7+SqQ==
X-Received: by 2002:a5e:aa1a:: with SMTP id s26mr11533614ioe.95.1619985249561;
        Sun, 02 May 2021 12:54:09 -0700 (PDT)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net. [71.237.100.236])
        by smtp.gmail.com with ESMTPSA id l7sm4479777ilh.49.2021.05.02.12.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 12:54:09 -0700 (PDT)
Date:   Sun, 2 May 2021 13:54:07 -0600
From:   Jordan Crouse <jordan@cosmicpenguin.net>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] drm/msm: use the right pgprot when mapping BOs in
 the kernel
Message-ID: <20210502195407.3packotroi5l5ie6@cosmicpenguin.net>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210423190833.25319-1-jonathan@marek.ca>
 <20210423190833.25319-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423190833.25319-4-jonathan@marek.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:08:19PM -0400, Jonathan Marek wrote:
> Use the same logic as the userspace mapping.
> 
> This fixes msm_rd with cached BOs.
> 

Acked-by: Jordan Crouse <jordan@cosmicpenguin.net>

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 09abda42d764..0f58937be0a9 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -199,6 +199,15 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
>  	/* when we start tracking the pin count, then do something here */
>  }
>  
> +static pgprot_t msm_gem_pgprot(struct msm_gem_object *msm_obj, pgprot_t prot)
> +{
> +	if (msm_obj->flags & MSM_BO_WC)
> +		return pgprot_writecombine(prot);
> +	if (msm_obj->flags & MSM_BO_UNCACHED)
> +		return pgprot_noncached(prot);
> +	return prot;
> +}
> +
>  int msm_gem_mmap_obj(struct drm_gem_object *obj,
>  		struct vm_area_struct *vma)
>  {
> @@ -206,13 +215,7 @@ int msm_gem_mmap_obj(struct drm_gem_object *obj,
>  
>  	vma->vm_flags &= ~VM_PFNMAP;
>  	vma->vm_flags |= VM_MIXEDMAP;
> -
> -	if (msm_obj->flags & MSM_BO_WC)
> -		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> -	else if (msm_obj->flags & MSM_BO_UNCACHED)
> -		vma->vm_page_prot = pgprot_noncached(vm_get_page_prot(vma->vm_flags));
> -	else
> -		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +	vma->vm_page_prot = msm_gem_pgprot(msm_obj, vm_get_page_prot(vma->vm_flags));
>  
>  	return 0;
>  }
> @@ -632,7 +635,7 @@ static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
>  			goto fail;
>  		}
>  		msm_obj->vaddr = vmap(pages, obj->size >> PAGE_SHIFT,
> -				VM_MAP, pgprot_writecombine(PAGE_KERNEL));
> +				VM_MAP, msm_gem_pgprot(msm_obj, PAGE_KERNEL));
>  		if (msm_obj->vaddr == NULL) {
>  			ret = -ENOMEM;
>  			goto fail;
> -- 
> 2.26.1
> 
