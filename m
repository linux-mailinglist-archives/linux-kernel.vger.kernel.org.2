Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60575345D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCWLsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCWLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:47:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:47:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so20433610wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=riev4q0SocYg+t59VV4jeUGzLfgXPce8r3inSkdpgP8=;
        b=EuGZoQRp0Ar/FWrbti0VOzivbL8+K52z7tT1QolbfVKrztBeft/JghVd5GK47YMBcM
         6H8OxStUnFCIUTORj+zKe5F4jfvbqIOPivAXAipd7SBEgfBqxF4a+w7fUzcWxzwPBmuN
         AKnebZ/VmCFFdHuIfHUaenqMo58v+a9dYAoZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=riev4q0SocYg+t59VV4jeUGzLfgXPce8r3inSkdpgP8=;
        b=FagJ1QPm5oTR8j6nJftUlr6qce7wyFM50VVz2LQUS1QjcC+9qo8HBwhDRsbk9+Y3oH
         vTMtKrEZwykKIj6hDjBRLYbE90hCpiqHF07eO5NGyyiz8fZ7DHN+9ETEmzJlNNu4JoIA
         z6RTY5g3WvYcVL/YYNeIszgSzePsrOW0odsRbKMrme8a1DuhA2z1+jLysR2WTPZz9B0J
         leDxmPihvAZxsLfGEF1BOzEKYlRhboPHr6c6STV1S7FljC8Azyv/CxT7ivbZXYJJxEtm
         Z6PhlE0EhLwG9n0odLK4OMpiPzdStdPiIkvMV91MU7Upn1wifweZkKQopWMvPLPGIVeY
         SBSA==
X-Gm-Message-State: AOAM533cBeYP1lIu2fVo1wkG4s3z9nSDSqrijozkSnq7ZaMl/HxofZ9X
        cmRJ9lYqACFZY1i9sV3/8NDkaQ==
X-Google-Smtp-Source: ABdhPJxkKPcUm9KmorxPmIPOybYhrPJMk/cWM/v2xitGTE3ftHnFLeE0TR7EAx44csdliBNJeki4DA==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr3514940wrz.211.1616500047082;
        Tue, 23 Mar 2021 04:47:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t23sm24019097wra.50.2021.03.23.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:47:26 -0700 (PDT)
Date:   Tue, 23 Mar 2021 12:47:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
Message-ID: <YFnVTIGKBFnlsGxF@phenom.ffwll.local>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
        dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210321184529.59006-3-thomas_os@shipmail.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 07:45:29PM +0100, Thomas Hellström (Intel) wrote:
> To block fast gup we need to make sure TTM ptes are always special.
> With MIXEDMAP we, on architectures that don't support pte_special,
> insert normal ptes, but OTOH on those architectures, fast is not
> supported.
> At the same time, the function documentation to vm_normal_page() suggests
> that ptes pointing to system memory pages of MIXEDMAP vmas are always
> normal, but that doesn't seem consistent with what's implemented in
> vmf_insert_mixed(). I'm thus not entirely sure this patch is actually
> needed.
> 
> But to make sure and to avoid also normal (non-fast) gup, make all
> TTM vmas PFNMAP. With PFNMAP we can't allow COW mappings
> anymore so make is_cow_mapping() available and use it to reject
> COW mappigs at mmap time.
> 
> There was previously a comment in the code that WC mappings together
> with x86 PAT + PFNMAP was bad for performance. However from looking at
> vmf_insert_mixed() it looks like in the current code PFNMAP and MIXEDMAP
> are handled the same for architectures that support pte_special. This
> means there should not be a performance difference anymore, but this
> needs to be verified.
> 
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++--------------
>  include/linux/mm.h              |  5 +++++
>  mm/internal.h                   |  5 -----
>  3 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 1c34983480e5..708c6fb9be81 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -372,12 +372,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_mixed_prot() for a discussion.
>  		 */
> -		if (vma->vm_flags & VM_MIXEDMAP)
> -			ret = vmf_insert_mixed_prot(vma, address,
> -						    __pfn_to_pfn_t(pfn, PFN_DEV),
> -						    prot);
> -		else
> -			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>  
>  		/* Never error on prefaulted PTEs */
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
> @@ -555,18 +550,14 @@ static void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_s
>  	 * Note: We're transferring the bo reference to
>  	 * vma->vm_private_data here.
>  	 */
> -
>  	vma->vm_private_data = bo;
>  
>  	/*
> -	 * We'd like to use VM_PFNMAP on shared mappings, where
> -	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
> -	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
> -	 * bad for performance. Until that has been sorted out, use
> -	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
> +	 * PFNMAP forces us to block COW mappings in mmap(),
> +	 * and with MIXEDMAP we would incorrectly allow fast gup
> +	 * on TTM memory on architectures that don't have pte_special.
>  	 */
> -	vma->vm_flags |= VM_MIXEDMAP;
> -	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>  }
>  
>  int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
> @@ -579,6 +570,9 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>  	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET_START))
>  		return -EINVAL;
>  
> +	if (unlikely(is_cow_mapping(vma->vm_flags)))
> +		return -EINVAL;
> +
>  	bo = ttm_bo_vm_lookup(bdev, vma->vm_pgoff, vma_pages(vma));
>  	if (unlikely(!bo))
>  		return -EINVAL;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 77e64e3eac80..c6ebf7f9ddbb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -686,6 +686,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_ACCESS_FLAGS;
>  }
>  
> +static inline bool is_cow_mapping(vm_flags_t flags)

Bit a bikeshed, but I wonder whether the public interface shouldn't be
vma_is_cow_mapping. Or whether this shouldn't be rejected somewhere else,
since at least in drivers/gpu we have tons of cases that don't check for
this and get it all kinds of wrong I think.

remap_pfn_range handles this for many cases, but by far not for all.

Anyway patch itself lgtm:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'll try and find some -mm folks to look at this too.
-Daniel

> +{
> +	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> +}
> +
>  #ifdef CONFIG_SHMEM
>  /*
>   * The vma_is_shmem is not inline because it is used only by slow
> diff --git a/mm/internal.h b/mm/internal.h
> index 9902648f2206..1432feec62df 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -296,11 +296,6 @@ static inline unsigned int buddy_order(struct page *page)
>   */
>  #define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
>  
> -static inline bool is_cow_mapping(vm_flags_t flags)
> -{
> -	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> -}
> -
>  /*
>   * These three helpers classifies VMAs for virtual memory accounting.
>   */
> -- 
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
