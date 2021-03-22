Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3FC343B70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCVINg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:13:36 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:55346 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhCVINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:13:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 6D39E3FE5D;
        Mon, 22 Mar 2021 09:13:19 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=HcLH/7tT;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0eW8CeNzc491; Mon, 22 Mar 2021 09:13:18 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id BCAB73F39B;
        Mon, 22 Mar 2021 09:13:15 +0100 (CET)
Received: from [192.168.1.108] (2.71.25.58.mobile.tre.se [2.71.25.58])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A54013600BA;
        Mon, 22 Mar 2021 09:13:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616400795; bh=ftxuHrqVt3LcJ6pfzDEqMV30xdNNqBuZ31nTRzOF8Y8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HcLH/7tTFUKA4+aZAskEI+go7IUsEJe86sYoHi5kr+7X8iPzvcQcUkemZ2QBhkDLV
         jCwml0Mbl0nrlqdl/eA3iI5Q/UDFxXvboarpFOPkmTzQK4tOKXlgLD3LbC/ZboU4hx
         7bL+/izXvJaNoW1fOESN7615jEVMnPKnpj2WNDj0=
Subject: Re: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-3-thomas_os@shipmail.org>
 <d49fad17-f515-d4f2-cef2-4108c8375747@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <5578ccaa-9751-3a01-1846-330c09bf9ce7@shipmail.org>
Date:   Mon, 22 Mar 2021 09:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d49fad17-f515-d4f2-cef2-4108c8375747@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 3/22/21 8:47 AM, Christian König wrote:
> Am 21.03.21 um 19:45 schrieb Thomas Hellström (Intel):
>> To block fast gup we need to make sure TTM ptes are always special.
>> With MIXEDMAP we, on architectures that don't support pte_special,
>> insert normal ptes, but OTOH on those architectures, fast is not
>> supported.
>> At the same time, the function documentation to vm_normal_page() 
>> suggests
>> that ptes pointing to system memory pages of MIXEDMAP vmas are always
>> normal, but that doesn't seem consistent with what's implemented in
>> vmf_insert_mixed(). I'm thus not entirely sure this patch is actually
>> needed.
>>
>> But to make sure and to avoid also normal (non-fast) gup, make all
>> TTM vmas PFNMAP. With PFNMAP we can't allow COW mappings
>> anymore so make is_cow_mapping() available and use it to reject
>> COW mappigs at mmap time.
>
> I would separate the disallowing of COW mapping from the PFN change. 
> I'm pretty sure that COW mappings never worked on TTM BOs in the first 
> place.

COW doesn't work with PFNMAP together with non-linear maps, so as a 
consequence from moving from MIXEDMAP to PFNMAP we must disallow COW, so 
it seems logical to me to do it in one patch.

And working COW was one of the tests I used for huge PMDs/PUDs, so it 
has indeed been working, but I can't think of any relevant use-cases.

Did you, BTW, have a chance to test this with WC mappings?

Thanks,
/Thomas



>
> But either way this patch is Reviewed-by: Christian König 
> <christian.koenig@amd.com>.
>
> Thanks,
> Christian.
>
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
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++--------------
>>   include/linux/mm.h              |  5 +++++
>>   mm/internal.h                   |  5 -----
>>   3 files changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 1c34983480e5..708c6fb9be81 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -372,12 +372,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct 
>> vm_fault *vmf,
>>            * at arbitrary times while the data is mmap'ed.
>>            * See vmf_insert_mixed_prot() for a discussion.
>>            */
>> -        if (vma->vm_flags & VM_MIXEDMAP)
>> -            ret = vmf_insert_mixed_prot(vma, address,
>> -                            __pfn_to_pfn_t(pfn, PFN_DEV),
>> -                            prot);
>> -        else
>> -            ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>> +        ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>>             /* Never error on prefaulted PTEs */
>>           if (unlikely((ret & VM_FAULT_ERROR))) {
>> @@ -555,18 +550,14 @@ static void ttm_bo_mmap_vma_setup(struct 
>> ttm_buffer_object *bo, struct vm_area_s
>>        * Note: We're transferring the bo reference to
>>        * vma->vm_private_data here.
>>        */
>> -
>>       vma->vm_private_data = bo;
>>         /*
>> -     * We'd like to use VM_PFNMAP on shared mappings, where
>> -     * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
>> -     * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
>> -     * bad for performance. Until that has been sorted out, use
>> -     * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
>> +     * PFNMAP forces us to block COW mappings in mmap(),
>> +     * and with MIXEDMAP we would incorrectly allow fast gup
>> +     * on TTM memory on architectures that don't have pte_special.
>>        */
>> -    vma->vm_flags |= VM_MIXEDMAP;
>> -    vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>> +    vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>>   }
>>     int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>> @@ -579,6 +570,9 @@ int ttm_bo_mmap(struct file *filp, struct 
>> vm_area_struct *vma,
>>       if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET_START))
>>           return -EINVAL;
>>   +    if (unlikely(is_cow_mapping(vma->vm_flags)))
>> +        return -EINVAL;
>> +
>>       bo = ttm_bo_vm_lookup(bdev, vma->vm_pgoff, vma_pages(vma));
>>       if (unlikely(!bo))
>>           return -EINVAL;
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 77e64e3eac80..c6ebf7f9ddbb 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -686,6 +686,11 @@ static inline bool vma_is_accessible(struct 
>> vm_area_struct *vma)
>>       return vma->vm_flags & VM_ACCESS_FLAGS;
>>   }
>>   +static inline bool is_cow_mapping(vm_flags_t flags)
>> +{
>> +    return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>> +}
>> +
>>   #ifdef CONFIG_SHMEM
>>   /*
>>    * The vma_is_shmem is not inline because it is used only by slow
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 9902648f2206..1432feec62df 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -296,11 +296,6 @@ static inline unsigned int buddy_order(struct 
>> page *page)
>>    */
>>   #define buddy_order_unsafe(page) READ_ONCE(page_private(page))
>>   -static inline bool is_cow_mapping(vm_flags_t flags)
>> -{
>> -    return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>> -}
>> -
>>   /*
>>    * These three helpers classifies VMAs for virtual memory accounting.
>>    */
