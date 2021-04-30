Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8996936F6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhD3HuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhD3HuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619768954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdE52s6Ia2XxSP/rGASaY3GfsX9+V3SzPEJR36wEdVo=;
        b=RKUjDY5CvgXPI14h76O0KSJnW3JhGlLg7sfizIBnXJx1nKkur9y39SUNHvKl9jM/5TWeXa
        icS7fRu5m7EuHvk8DejnWoVVWLuqhWlAwxe2A+3Pc9lam5JY6smPPnxWEFwcphXC6besrs
        LSIAI4lIJuNT/y5CUNpj/yRMr2ayASI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-56gX_gsnMzKDPnHlPb4lfg-1; Fri, 30 Apr 2021 03:49:11 -0400
X-MC-Unique: 56gX_gsnMzKDPnHlPb4lfg-1
Received: by mail-wr1-f70.google.com with SMTP id i32-20020adf90a30000b029010d9e6b3833so836895wri.18
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NdE52s6Ia2XxSP/rGASaY3GfsX9+V3SzPEJR36wEdVo=;
        b=ao5zTmZAFFk+bADTZNdz6/TK0fMHjUwgMia2IWITCFA6nwcErBEQa/9rKHpIyUp7Ai
         IJLIuebl29tdgaMT2YbajWs8z/OtOf01y/pG2jucHUq/HuK7kbOgVEee6yxGDZDq9SRO
         H4xZdoUY2anhydqUuBHOkMhbhR6TePjBqZuPgJhLiBJIT4BCa9IBkeTgxaSxUd9xVUbs
         Du5l7PEsfRA+T2FZ3yc8e1r8v+fTJrDtCXUcTF1cS0hSo62pp5w1kkerPe2SVQFNpIyI
         FBTf+TlFLwPZ6WjkQnoU+GXX5iP6+Ug2T77s9p3hJoyx4JTqkXvddqXcCs1+tEvVQvOB
         4qmw==
X-Gm-Message-State: AOAM532gwXWBzEmyQix4i8Jevj3IEfRshdV0ZhHfp4UFTGgE6N/ESrLD
        1hSOT9WHODEW9tIM8Iq/58JtOWKVGbuVkOKKgPgcHcl95YjXNFn+dSmMCXmE8+K/d7qSKh0m3qT
        mvZA8RqddCDtoYKuySjTGPTU6
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr4634850wmf.178.1619768949771;
        Fri, 30 Apr 2021 00:49:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVzDPeN+DYIFn/vvDUzdD1hJ+aZvr6/0Su4NMoj8EnOIE/SucvQiM3uLFLpRsib2PT6gNRWw==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr4634824wmf.178.1619768949464;
        Fri, 30 Apr 2021 00:49:09 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60f5.dip0.t-ipconnect.de. [91.12.96.245])
        by smtp.gmail.com with ESMTPSA id g197sm13579107wme.43.2021.04.30.00.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 00:49:09 -0700 (PDT)
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210429132648.305447-1-linmiaohe@huawei.com>
 <20210429132648.305447-4-linmiaohe@huawei.com>
 <68c8c4a8-c4f8-83db-7326-dabeea74239c@redhat.com>
 <9b511ad9-0ba1-e896-4eb5-0e91ca4b97ab@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/5] mm/huge_memory.c: add missing read-only THP
 checking in transparent_hugepage_enabled()
Message-ID: <9c340151-6dbb-504c-e205-3edda6a5aff8@redhat.com>
Date:   Fri, 30 Apr 2021 09:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9b511ad9-0ba1-e896-4eb5-0e91ca4b97ab@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.21 03:57, Miaohe Lin wrote:
> On 2021/4/29 22:57, David Hildenbrand wrote:
>> On 29.04.21 15:26, Miaohe Lin wrote:
>>> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
>>> (non-shmem) FS"), read-only THP file mapping is supported. But it
>>> forgot to add checking for it in transparent_hugepage_enabled().
>>> To fix it, we add checking for read-only THP file mapping and also
>>> introduce helper transhuge_vma_enabled() to check whether thp is
>>> enabled for specified vma to reduce duplicated code.
>>>
>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    include/linux/huge_mm.h | 21 +++++++++++++++++----
>>>    mm/huge_memory.c        |  6 ++++++
>>>    mm/khugepaged.c         |  4 +---
>>>    mm/shmem.c              |  3 +--
>>>    4 files changed, 25 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 0a526f211fec..f460b74619fc 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -115,6 +115,16 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>      extern unsigned long transparent_hugepage_flags;
>>>    +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
>>> +                      unsigned long vm_flags)
>>
>> You're passing the vma already, why do you pass vma->vm_flags separately? It's sufficient to pass in the vma only.
>>
> 
> Many thanks for comment! IMO, vm_flags may not always equal to vma->vm_flags. When hugepage_vma_check()
> is called from collapse_pte_mapped_thp, vma_flags = vma->vm_flags | VM_HUGEPAGE. So I think we should
> pass vm_flags here.

Oh, sorry, I missed the hugepage_vma_check() user. That's unfortunate.

>>>    static inline void prep_transhuge_page(struct page *page) {}
>>>      static inline bool is_transparent_hugepage(struct page *page)
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 76ca1eb2a223..e24a96de2e37 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -68,12 +68,18 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>>>        /* The addr is used to check if the vma size fits */
>>>        unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
>>>    +    if (!transhuge_vma_enabled(vma, vma->vm_flags))
>>> +        return false;
>>>        if (!transhuge_vma_suitable(vma, addr))
>>>            return false;
>>>        if (vma_is_anonymous(vma))
>>>            return __transparent_hugepage_enabled(vma);
>>>        if (vma_is_shmem(vma))
>>>            return shmem_huge_enabled(vma);
>>> +    if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
>>> +        !inode_is_open_for_write(vma->vm_file->f_inode) &&
>>> +        (vma->vm_flags & VM_EXEC))
>>> +        return true;
>>
>> Nit: I'm really wondering why we have 3 different functions that sound like they are doing the same thing
>>
>> transparent_hugepage_enabled(vma)
>> transhuge_vma_enabled()
>> transhuge_vma_suitable()
>>
>> Which check belongs where? Does it really have to be that complicated?
>>
> 
> IMO, transhuge_vma_suitable() checks whether pgoff , vm_start and vm_end is possible for thp.
> transhuge_vma_enabled() checks whether thp is explicitly disabled through madvise.
> And transparent_hugepage_enabled() use these helpers to get the conclusion whether thp is
> enabled for specified vma.
> 
> Any suggestions?

transparent_hugepage_enabled() vs. transhuge_vma_enabled() is really 
sub-optimal naming. I guess "transparent_hugepage_active()" would have 
been clearer (enabled + suitable + applicable). Cannot really give a 
good suggestion here on how to name transhuge_vma_enabled() differently.


We now have

transparent_hugepage_enabled()
-> transhuge_vma_enabled()
-> __transparent_hugepage_enabled() -> transhuge_vma_enabled()
-> shmem_huge_enabled() -> transhuge_vma_enabled()

That looks sub-optimal as well. Maybe we should have a

static inline bool file_thp_enabled(struct vma *vma)
{
	return transhuge_vma_enabled() &&
	       IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
	       !inode_is_open_for_write(vma->vm_file->f_inode) &&
	       (vma->vm_flags & VM_EXEC))
}

and in transparent_hugepage_enabled() only do a

if (vma->vm_file)
	return file_thp_enabled(vma);


Or move the transhuge_vma_enabled() check completely to 
transparent_hugepage_enabled() if possible.

-- 
Thanks,

David / dhildenb

