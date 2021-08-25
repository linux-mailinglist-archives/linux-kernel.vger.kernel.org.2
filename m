Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97E3F7AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhHYQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241877AbhHYQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629909189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoY0bVNxEj+4qPPvAQDYe3W3WCKpG0YSd9qQfxjoWZY=;
        b=DM6Fyglps+6hMuAr4TT4FLqHG/GYxfjV87pnRH5wRxPE/9k2SfG3rBnAGJOkkB8Vuug2hM
        1opPAXnutzuWutlwJGWt0czI3zfCuQIExhWNg9SLmyMmYeWd4JL3OE98uOHJ0S7wlNhQpE
        3shZJm7tfhmHfInxyOKcCtws70Z3PiA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-QqZzSN3uOoGnI5RtIajzvQ-1; Wed, 25 Aug 2021 12:33:07 -0400
X-MC-Unique: QqZzSN3uOoGnI5RtIajzvQ-1
Received: by mail-wr1-f72.google.com with SMTP id b8-20020a5d5508000000b001574e8e9237so24286wrv.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FoY0bVNxEj+4qPPvAQDYe3W3WCKpG0YSd9qQfxjoWZY=;
        b=a4bbhV+h6uUHDqP9cAvyJNOkWsb/RPjfar1/XFSGfoVZFQ/yfllpfifYb8wI+Fpqg2
         TcyqaK3xu7bQ9pFs8JqfYbGb0w7WSKHe3NyhXcFwOFg4Uo6+gniG43CKAZztC7FOLNZg
         mlXuihnl3nIm2ZrRhQcH5ThPlXW2jVXXNHh7t8/TqrE+Aq92JVRCZhcIQll/NzWZmUCm
         Esy0qkC1kIGPIZjMiqFWi8Rjk56MN0AK/zedKeuQZfBjoK1VqTIUb+gbl0Q8SpROZ9jP
         5yKLcXuSDp7Is2D3ZVGYMJc28A/srMbMv8Q3GUDThlwxS+2vlA6Hr9ZrJrU+R2862AD6
         d2kw==
X-Gm-Message-State: AOAM533AR/v0t8KCIX6dlwz2omKgS/vldS1oXfnWcqww8Ft09HoVf9ov
        3PWXxyJSfW16mhnAkKtdUxcnZfxOqFSG/ZuoCoE+lXEAJhGr3fXB2JSuANJpcwYlvLM/V6gAP6Z
        eMKw+Rt4CbPFY88BioXlN4I80
X-Received: by 2002:adf:edc2:: with SMTP id v2mr26421735wro.255.1629909186762;
        Wed, 25 Aug 2021 09:33:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp+z3dTuCMxJooUvL6XT0vwnopkl68J8+g+mJcar2SwHhWo40SdaJsuaTQQMFgicKksW1AkQ==
X-Received: by 2002:adf:edc2:: with SMTP id v2mr26421711wro.255.1629909186543;
        Wed, 25 Aug 2021 09:33:06 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id l7sm125235wmj.9.2021.08.25.09.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:33:05 -0700 (PDT)
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-2-zhengqi.arch@bytedance.com>
 <edd82170-7149-1abf-6204-f1d665a5fca2@redhat.com>
 <c650ef29-0f9e-02a0-9426-b406a4608c8f@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/9] mm: introduce pmd_install() helper
Message-ID: <324674f0-399b-aea4-e9b9-fe054a926fdf@redhat.com>
Date:   Wed, 25 Aug 2021 18:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c650ef29-0f9e-02a0-9426-b406a4608c8f@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.21 18:20, Qi Zheng wrote:
> 
> 
> On 2021/8/25 AM12:26, David Hildenbrand wrote:
>> On 19.08.21 05:18, Qi Zheng wrote:
>>> Currently we have three times the same few lines repeated in the
>>> code. Deduplicate them by newly introduced pmd_install() helper.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>    include/linux/mm.h |  1 +
>>>    mm/filemap.c       | 11 ++---------
>>>    mm/memory.c        | 34 ++++++++++++++++------------------
>>>    3 files changed, 19 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index ce8fc0fd6d6e..57e48217bd71 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -2471,6 +2471,7 @@ static inline spinlock_t *pud_lock(struct
>>> mm_struct *mm, pud_t *pud)
>>>        return ptl;
>>>    }
>>> +extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t
>>> *pte);
>>>    extern void __init pagecache_init(void);
>>>    extern void __init free_area_init_memoryless_node(int nid);
>>>    extern void free_initmem(void);
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 53913fced7ae..9f773059c6dc 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3210,15 +3210,8 @@ static bool filemap_map_pmd(struct vm_fault
>>> *vmf, struct page *page)
>>>            }
>>>        }
>>> -    if (pmd_none(*vmf->pmd)) {
>>> -        vmf->ptl = pmd_lock(mm, vmf->pmd);
>>> -        if (likely(pmd_none(*vmf->pmd))) {
>>> -            mm_inc_nr_ptes(mm);
>>> -            pmd_populate(mm, vmf->pmd, vmf->prealloc_pte);
>>> -            vmf->prealloc_pte = NULL;
>>> -        }
>>> -        spin_unlock(vmf->ptl);
>>> -    }
>>> +    if (pmd_none(*vmf->pmd))
>>> +        pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
>>>        /* See comment in handle_pte_fault() */
>>>        if (pmd_devmap_trans_unstable(vmf->pmd)) {
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 39e7a1495c3c..ef7b1762e996 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -433,9 +433,20 @@ void free_pgtables(struct mmu_gather *tlb, struct
>>> vm_area_struct *vma,
>>>        }
>>>    }
>>> +void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
>>> +{
>>> +    spinlock_t *ptl = pmd_lock(mm, pmd);
>>> +
>>> +    if (likely(pmd_none(*pmd))) {    /* Has another populated it ? */
>>> +        mm_inc_nr_ptes(mm);
>>> +        pmd_populate(mm, pmd, *pte);
>>> +        *pte = NULL;
>>> +    }
>>> +    spin_unlock(ptl);
>>> +}
>>> +
>>>    int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>>>    {
>>> -    spinlock_t *ptl;
>>>        pgtable_t new = pte_alloc_one(mm);
>>>        if (!new)
>>>            return -ENOMEM;
>>> @@ -455,13 +466,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>>>         */
>>>        smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
>>> -    ptl = pmd_lock(mm, pmd);
>>> -    if (likely(pmd_none(*pmd))) {    /* Has another populated it ? */
>>> -        mm_inc_nr_ptes(mm);
>>> -        pmd_populate(mm, pmd, new);
>>> -        new = NULL;
>>> -    }
>>> -    spin_unlock(ptl);
>>> +    pmd_install(mm, pmd, &new);
>>>        if (new)
>>>            pte_free(mm, new);
>>>        return 0;
>>> @@ -4027,17 +4032,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>                    return ret;
>>>            }
>>> -        if (vmf->prealloc_pte) {
>>> -            vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>> -            if (likely(pmd_none(*vmf->pmd))) {
>>> -                mm_inc_nr_ptes(vma->vm_mm);
>>> -                pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
>>> -                vmf->prealloc_pte = NULL;
>>> -            }
>>> -            spin_unlock(vmf->ptl);
>>> -        } else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
>>> +        if (vmf->prealloc_pte)
>>> +            pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
>>> +        else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
>>>                return VM_FAULT_OOM;
>>> -        }
>>>        }
>>>        /* See comment in handle_pte_fault() */
>>>
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Thanks for your review, I will add this to the patch v3.
> 
>>
>> That's mostly unrelated to the remaining part of the series and can be
>> picked up early.
> 
> The implementation of subsequent patches depends on pmd_install().
> So I am worried that if this patch is submitted as a separate patch,
> subsequent patches will not be updated until this patch is merged.
> What do you think?

Usually I tend to send cleanups out independently, and then just base 
the other series on top of the other series.

I'll have some more comments in reply to v2. It's fairly hard to review 
because you do a lot of complicated stuff in only a handful of patches 
:) I'll try to think of something reasonable on how to split this up to 
make it easier to digest.

-- 
Thanks,

David / dhildenb

