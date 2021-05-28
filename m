Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55A5393CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 07:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhE1GBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 02:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhE1GA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 02:00:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63637C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 22:59:20 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 205E38C7;
        Fri, 28 May 2021 07:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622181556;
        bh=5MPRFX/ipK2MKZ+iQkI1Y4J/gxMGdBaqkcwIS4PyaGI=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=d2an8QylcEg0p1MZ+ftpbbY2/JuInuTgQV+QL/E/1NkllV7+psEds5c1FSWP4sY21
         unxXAVfIcs9rsyh67btvzCupRVjTBUy0ws+kd/EVV8+strkBLUdJRbp0LAxX3xl84L
         ch6Ska1618fbYWxZqD7NMmxeATL7tFYzE13MS0jk=
To:     Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <26b5424a-ff4c-090b-a08f-0e3e32278180@ideasonboard.com>
 <20210527230334.151947-1-paul@crapouillou.net>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH] drm: Fix for GEM buffers with write-combine memory
Message-ID: <b3ae134e-2494-82ce-d8d2-ca7284129075@ideasonboard.com>
Date:   Fri, 28 May 2021 08:59:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527230334.151947-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 02:03, Paul Cercueil wrote:
> The previous commit wrongly assumed that dma_mmap_wc() could be replaced
> by pgprot_writecombine() + dma_mmap_pages(). It did work on my setup,
> but did not work everywhere.
> 
> Use dma_mmap_wc() when the buffer has the write-combine cache attribute,
> and dma_mmap_pages() when it has the non-coherent cache attribute.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Fixes: cf8ccbc72d61 ("drm: Add support for GEM buffers backed by non-coherent memory")
> ---
>   drivers/gpu/drm/drm_gem_cma_helper.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 235c7a63da2b..4c3772651954 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -514,13 +514,17 @@ int drm_gem_cma_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>   
>   	cma_obj = to_drm_gem_cma_obj(obj);
>   
> -	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> -	if (!cma_obj->map_noncoherent)
> -		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> +	if (cma_obj->map_noncoherent) {
> +		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +
> +		ret = dma_mmap_pages(cma_obj->base.dev->dev,
> +				     vma, vma->vm_end - vma->vm_start,
> +				     virt_to_page(cma_obj->vaddr));
> +	} else {
> +		ret = dma_mmap_wc(cma_obj->base.dev->dev, vma, cma_obj->vaddr,
> +				  cma_obj->paddr, vma->vm_end - vma->vm_start);
>   
> -	ret = dma_mmap_pages(cma_obj->base.dev->dev,
> -			     vma, vma->vm_end - vma->vm_start,
> -			     virt_to_page(cma_obj->vaddr));
> +	}
>   	if (ret)
>   		drm_gem_vm_close(vma);
>   
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

and

Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Thanks!

Btw, the kernel-doc for drm_gem_cma_create doesn't quite match, as it 
says wc is always used.

  Tomi
