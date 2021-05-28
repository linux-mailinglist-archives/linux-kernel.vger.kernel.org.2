Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963BD3940B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhE1KNB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 May 2021 06:13:01 -0400
Received: from aposti.net ([89.234.176.197]:52280 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhE1KMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:12:48 -0400
Date:   Fri, 28 May 2021 11:10:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm: Fix for GEM buffers with write-combine memory
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, list@opendingux.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <6YATTQ.MSZ3AMJZMTBZ1@crapouillou.net>
In-Reply-To: <b3ae134e-2494-82ce-d8d2-ca7284129075@ideasonboard.com>
References: <26b5424a-ff4c-090b-a08f-0e3e32278180@ideasonboard.com>
        <20210527230334.151947-1-paul@crapouillou.net>
        <b3ae134e-2494-82ce-d8d2-ca7284129075@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Le ven., mai 28 2021 at 08:59:15 +0300, Tomi Valkeinen 
<tomi.valkeinen@ideasonboard.com> a écrit :
> On 28/05/2021 02:03, Paul Cercueil wrote:
>> The previous commit wrongly assumed that dma_mmap_wc() could be 
>> replaced
>> by pgprot_writecombine() + dma_mmap_pages(). It did work on my setup,
>> but did not work everywhere.
>> 
>> Use dma_mmap_wc() when the buffer has the write-combine cache 
>> attribute,
>> and dma_mmap_pages() when it has the non-coherent cache attribute.
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> Fixes: cf8ccbc72d61 ("drm: Add support for GEM buffers backed by 
>> non-coherent memory")
>> ---
>>   drivers/gpu/drm/drm_gem_cma_helper.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c 
>> b/drivers/gpu/drm/drm_gem_cma_helper.c
>> index 235c7a63da2b..4c3772651954 100644
>> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
>> @@ -514,13 +514,17 @@ int drm_gem_cma_mmap(struct drm_gem_object 
>> *obj, struct vm_area_struct *vma)
>>     	cma_obj = to_drm_gem_cma_obj(obj);
>>   -	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>> -	if (!cma_obj->map_noncoherent)
>> -		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>> +	if (cma_obj->map_noncoherent) {
>> +		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>> +
>> +		ret = dma_mmap_pages(cma_obj->base.dev->dev,
>> +				     vma, vma->vm_end - vma->vm_start,
>> +				     virt_to_page(cma_obj->vaddr));
>> +	} else {
>> +		ret = dma_mmap_wc(cma_obj->base.dev->dev, vma, cma_obj->vaddr,
>> +				  cma_obj->paddr, vma->vm_end - vma->vm_start);
>>   -	ret = dma_mmap_pages(cma_obj->base.dev->dev,
>> -			     vma, vma->vm_end - vma->vm_start,
>> -			     virt_to_page(cma_obj->vaddr));
>> +	}
>>   	if (ret)
>>   		drm_gem_vm_close(vma);
>>   
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> and
> 
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Thanks, I applied it now.

> 
> Thanks!
> 
> Btw, the kernel-doc for drm_gem_cma_create doesn't quite match, as it 
> says wc is always used.

Alright, I'll send a patch later for this one too.

Cheers,
-Paul


