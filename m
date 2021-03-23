Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA8346341
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhCWPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:46:41 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:57348 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhCWPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:46:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CB47340788;
        Tue, 23 Mar 2021 16:46:08 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="rHKVk9Lc";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tFJo68TOyrQL; Tue, 23 Mar 2021 16:46:07 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5ACE040789;
        Tue, 23 Mar 2021 16:46:05 +0100 (CET)
Received: from [192.168.0.209] (unknown [192.198.151.43])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 282813602AF;
        Tue, 23 Mar 2021 16:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616514364; bh=/YRbLyyT2+b0x+xy9LzPsteGLOtTqIZRl6La1xXuixw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rHKVk9LcDAJi/SFeskJmGVMZq6XkliOXWcwycvl8g1nRLVTmb4RIpIgFak5JH/47E
         7xkSJb3MvPNZA1viPKpoAz16O2Zy+u/aA7/MJRjbs3g4VyZQ5qPYACWBnuYg0pvNiY
         ecAJqm0cFWJxCsXdn1qoqg2Pq7HyVugR8sFtk6+U=
Subject: Re: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-3-thomas_os@shipmail.org>
 <20210323140030.GE2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <dff54e6f-91bf-8cb9-4d15-259a45154ceb@shipmail.org>
Date:   Tue, 23 Mar 2021 16:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323140030.GE2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/21 3:00 PM, Jason Gunthorpe wrote:
> On Sun, Mar 21, 2021 at 07:45:29PM +0100, Thomas Hellström (Intel) wrote:
>> To block fast gup we need to make sure TTM ptes are always special.
>> With MIXEDMAP we, on architectures that don't support pte_special,
>> insert normal ptes, but OTOH on those architectures, fast is not
>> supported.
>> At the same time, the function documentation to vm_normal_page() suggests
>> that ptes pointing to system memory pages of MIXEDMAP vmas are always
>> normal, but that doesn't seem consistent with what's implemented in
>> vmf_insert_mixed(). I'm thus not entirely sure this patch is actually
>> needed.
>>
>> But to make sure and to avoid also normal (non-fast) gup, make all
>> TTM vmas PFNMAP. With PFNMAP we can't allow COW mappings
>> anymore so make is_cow_mapping() available and use it to reject
>> COW mappigs at mmap time.
>>
>> There was previously a comment in the code that WC mappings together
>> with x86 PAT + PFNMAP was bad for performance. However from looking at
>> vmf_insert_mixed() it looks like in the current code PFNMAP and MIXEDMAP
>> are handled the same for architectures that support pte_special. This
>> means there should not be a performance difference anymore, but this
>> needs to be verified.
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: linux-mm@kvack.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++--------------
>>   include/linux/mm.h              |  5 +++++
>>   mm/internal.h                   |  5 -----
>>   3 files changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 1c34983480e5..708c6fb9be81 100644
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -372,12 +372,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>>   		 * at arbitrary times while the data is mmap'ed.
>>   		 * See vmf_insert_mixed_prot() for a discussion.
>>   		 */
>> -		if (vma->vm_flags & VM_MIXEDMAP)
>> -			ret = vmf_insert_mixed_prot(vma, address,
>> -						    __pfn_to_pfn_t(pfn, PFN_DEV),
>> -						    prot);
>> -		else
>> -			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>> +		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>>   
>>   		/* Never error on prefaulted PTEs */
>>   		if (unlikely((ret & VM_FAULT_ERROR))) {
>> @@ -555,18 +550,14 @@ static void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_s
>>   	 * Note: We're transferring the bo reference to
>>   	 * vma->vm_private_data here.
>>   	 */
>> -
>>   	vma->vm_private_data = bo;
>>   
>>   	/*
>> -	 * We'd like to use VM_PFNMAP on shared mappings, where
>> -	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
>> -	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
>> -	 * bad for performance. Until that has been sorted out, use
>> -	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
>> +	 * PFNMAP forces us to block COW mappings in mmap(),
>> +	 * and with MIXEDMAP we would incorrectly allow fast gup
>> +	 * on TTM memory on architectures that don't have pte_special.
>>   	 */
>> -	vma->vm_flags |= VM_MIXEDMAP;
>> -	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>> +	vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>>   }
>>   
>>   int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>> @@ -579,6 +570,9 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>>   	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET_START))
>>   		return -EINVAL;
>>   
>> +	if (unlikely(is_cow_mapping(vma->vm_flags)))
>> +		return -EINVAL;
>> +
>>   	bo = ttm_bo_vm_lookup(bdev, vma->vm_pgoff, vma_pages(vma));
>>   	if (unlikely(!bo))
>>   		return -EINVAL;
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 77e64e3eac80..c6ebf7f9ddbb 100644
>> +++ b/include/linux/mm.h
>> @@ -686,6 +686,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
>>   	return vma->vm_flags & VM_ACCESS_FLAGS;
>>   }
>>   
>> +static inline bool is_cow_mapping(vm_flags_t flags)
>> +{
>> +	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>> +}
> Most driver places are just banning VM_SHARED.
>
> I see you copied this from remap_pfn_range(), but that logic is so
> special I'm not sure..

It's actually used all over the place. Both in drivers and also 
redefined with
CONFIG_MEM_SOFT_DIRTY which makes me think Daniels idea of 
vma_is_cow_mapping() is better since it won't clash and cause 
compilation failures...

>
> Can the user mprotect the write back on with the above logic?
No, it's blocked by mprotect.
> Do we
> need VM_DENYWRITE too?

Seems tied to MAP_DENYWRITE which is nowadays ignored according to man 
mmap().

Thanks,

Thomas

>
> Jason
