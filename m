Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5165D3F7A67
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbhHYQV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbhHYQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:21:50 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98654C0611C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:20:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 17so225995pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WfApXgIAJKG8HDMpDxeWIJ0g5a0zCGdRTXnLP/N3w6w=;
        b=yNWmLg4D3MPNwz3iBAd040R8jR3mwmiT7/OveoBUnx9MNH0mZGUVD5U24u+11fAfKu
         a91IZ8N7rdaeM0orJk9dy3N0mjCx0Yu0Sfpiog/Q0vvp5SjYBYa+qB5aucbHlPvnFQxg
         ELDRto3TAI3GsKS4J5a7nQHfFBCd8MS8Em89BuJD8j8ZUk/ROgeXYelhYWzO9Ynho1mq
         Db15kqUQUWEeBPBAI9ezdNAxXbSzajoKJWmZTScnNGMZvCjyw6jXoE8XpGD3UA0+LVPF
         B1qo2b1h/VoOZgU61Jjek+nZEIIsBbUB2TYNMi/CBZ7lLCGLRI69QP+7/KPDIMTjF+5X
         ZxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WfApXgIAJKG8HDMpDxeWIJ0g5a0zCGdRTXnLP/N3w6w=;
        b=jsooj+mEJ09TiCjUMCCjGS2g21XFS5V4odzhZJ7T9hhT6pMoWcoUgj+lGeLdrB0PyT
         jDcqKPIxwJFDaZ7eBpDr+QmVS/KrYHhbR24VJrK7HC0oMlMILaLM4ecYT8wLdGeExSi2
         jnwi+/NZK5JLLU49F1s3nW8EnODDWegORjeTe/t7ko5EqkLPrAMrZJtFsjsQuqyLvPzg
         X4nvuJKQuCM1pHBDynOxYd4Wor2hNj2n4IvPsJVKLxP0UMlP5++eU+3Uw47Ya5tWix4m
         aV8TWCwMnYabt1M8mpN22FInoya2YrcxAYVJFOTt3pKjYzsjVC1BtHDXCge+6fZ0YJ5P
         mcgg==
X-Gm-Message-State: AOAM530LycJ+UhhTS1hvKld+ELG0N1npELRfQ7tBn+F4PAICtp7jrKYQ
        Rtqpr/iHHQ3rqM2Qyy1gpqb1Mg==
X-Google-Smtp-Source: ABdhPJwrAL8hgbvN02uYYKtBnE1DUYV7Xq1vYTj0mWjw2e7+NUaM6k7pyNoflK0khzA8RTUOnBiSQQ==
X-Received: by 2002:a63:2242:: with SMTP id t2mr41795283pgm.111.1629908438181;
        Wed, 25 Aug 2021 09:20:38 -0700 (PDT)
Received: from [10.255.189.11] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t13sm121019pjg.25.2021.08.25.09.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:20:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] mm: introduce pmd_install() helper
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-2-zhengqi.arch@bytedance.com>
 <edd82170-7149-1abf-6204-f1d665a5fca2@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <c650ef29-0f9e-02a0-9426-b406a4608c8f@bytedance.com>
Date:   Thu, 26 Aug 2021 00:20:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <edd82170-7149-1abf-6204-f1d665a5fca2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/25 AM12:26, David Hildenbrand wrote:
> On 19.08.21 05:18, Qi Zheng wrote:
>> Currently we have three times the same few lines repeated in the
>> code. Deduplicate them by newly introduced pmd_install() helper.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/mm.h |  1 +
>>   mm/filemap.c       | 11 ++---------
>>   mm/memory.c        | 34 ++++++++++++++++------------------
>>   3 files changed, 19 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index ce8fc0fd6d6e..57e48217bd71 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2471,6 +2471,7 @@ static inline spinlock_t *pud_lock(struct 
>> mm_struct *mm, pud_t *pud)
>>       return ptl;
>>   }
>> +extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t 
>> *pte);
>>   extern void __init pagecache_init(void);
>>   extern void __init free_area_init_memoryless_node(int nid);
>>   extern void free_initmem(void);
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 53913fced7ae..9f773059c6dc 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3210,15 +3210,8 @@ static bool filemap_map_pmd(struct vm_fault 
>> *vmf, struct page *page)
>>           }
>>       }
>> -    if (pmd_none(*vmf->pmd)) {
>> -        vmf->ptl = pmd_lock(mm, vmf->pmd);
>> -        if (likely(pmd_none(*vmf->pmd))) {
>> -            mm_inc_nr_ptes(mm);
>> -            pmd_populate(mm, vmf->pmd, vmf->prealloc_pte);
>> -            vmf->prealloc_pte = NULL;
>> -        }
>> -        spin_unlock(vmf->ptl);
>> -    }
>> +    if (pmd_none(*vmf->pmd))
>> +        pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
>>       /* See comment in handle_pte_fault() */
>>       if (pmd_devmap_trans_unstable(vmf->pmd)) {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 39e7a1495c3c..ef7b1762e996 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -433,9 +433,20 @@ void free_pgtables(struct mmu_gather *tlb, struct 
>> vm_area_struct *vma,
>>       }
>>   }
>> +void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
>> +{
>> +    spinlock_t *ptl = pmd_lock(mm, pmd);
>> +
>> +    if (likely(pmd_none(*pmd))) {    /* Has another populated it ? */
>> +        mm_inc_nr_ptes(mm);
>> +        pmd_populate(mm, pmd, *pte);
>> +        *pte = NULL;
>> +    }
>> +    spin_unlock(ptl);
>> +}
>> +
>>   int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>>   {
>> -    spinlock_t *ptl;
>>       pgtable_t new = pte_alloc_one(mm);
>>       if (!new)
>>           return -ENOMEM;
>> @@ -455,13 +466,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>>        */
>>       smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
>> -    ptl = pmd_lock(mm, pmd);
>> -    if (likely(pmd_none(*pmd))) {    /* Has another populated it ? */
>> -        mm_inc_nr_ptes(mm);
>> -        pmd_populate(mm, pmd, new);
>> -        new = NULL;
>> -    }
>> -    spin_unlock(ptl);
>> +    pmd_install(mm, pmd, &new);
>>       if (new)
>>           pte_free(mm, new);
>>       return 0;
>> @@ -4027,17 +4032,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>                   return ret;
>>           }
>> -        if (vmf->prealloc_pte) {
>> -            vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>> -            if (likely(pmd_none(*vmf->pmd))) {
>> -                mm_inc_nr_ptes(vma->vm_mm);
>> -                pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
>> -                vmf->prealloc_pte = NULL;
>> -            }
>> -            spin_unlock(vmf->ptl);
>> -        } else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
>> +        if (vmf->prealloc_pte)
>> +            pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
>> +        else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
>>               return VM_FAULT_OOM;
>> -        }
>>       }
>>       /* See comment in handle_pte_fault() */
>>
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for your review, I will add this to the patch v3.

> 
> That's mostly unrelated to the remaining part of the series and can be 
> picked up early.

The implementation of subsequent patches depends on pmd_install().
So I am worried that if this patch is submitted as a separate patch,
subsequent patches will not be updated until this patch is merged.
What do you think?

> 


