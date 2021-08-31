Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850B53FC760
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhHaMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhHaMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:37:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C5C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:36:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q3so10529040plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=v9g9wZbjQum2R8lBMgDtJLNvpHwYm9wDR3lI7i7rcFU=;
        b=sNkLyHwNNfFF76COqbJqEQo1Ny08kSwqJPx9SQq+TKr5su2z0NRZX1dL1+G8pcKV/T
         Yfj2qysGhdNIwTILbExSUF6zQ/Udza5KRyCJlbGnjAJ+UU8TKPK8wlGYZloeNkWqUNWG
         ZRjGJKU8It967TpSJPsvZyke+gorQdLfLqwXLXOGc+ePXVTNBzdfxXPwHlg269jFdRNN
         w/f0T2pYp9cj+AAdRQX5altSBt7MYK98voUg7ARMNFeYSdSwuGZ5ZUyIF6SzX4ANE7Fv
         QejU+iNUiMhb+8Akz7SGUxvpFDKDv+t8nR1Nhki5DAmUWAqafUGzW8PaNoqo5NIcYWZb
         CJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=v9g9wZbjQum2R8lBMgDtJLNvpHwYm9wDR3lI7i7rcFU=;
        b=ExbjOdln1xIxHCpF+vP8gi+1VL/qaEOlgIa++fQPn48lsaute5oDCRmmK5Dj9JBg4e
         WkBKiUGlphcQCiCuFtXlh907TOkAUnlsYDvAenSFtCfbyColI3sWINqnDKq/wE+oGqif
         7nkKbKrgUlgrrdiDuSPx5hZnSlj5EG9aZlAOwLy0bnhMv5TSPA/Bpt7uZieak2c4iffT
         bNu5KYuyskPwH1pREX+AP5zSNsDlAV+z7isP5fRvFbIEHjEe+nAwLdc0umX0YO/2JxW9
         17bVZSbwH1yG1eObmuBI2QakrsJvfNbyqeEYxD0XyqUoqtkEoQpJF32sqTNm2WMiJri1
         XhXQ==
X-Gm-Message-State: AOAM530rLIARSgTPC7qw1R0lnlk4Eu4HRUxY19Mr27mHaSP4QTF9sh+o
        65j4kt+ITwWZj1x8sWcdwd+l3eAWAAGe1w==
X-Google-Smtp-Source: ABdhPJwE+H6sMqaImTHXCa39myLxG5X+AE/9mNuCpzedptSRGf6Y7h2n8durJreLqgRFhsWUFEsssQ==
X-Received: by 2002:a17:90a:14c4:: with SMTP id k62mr5224838pja.126.1630413417784;
        Tue, 31 Aug 2021 05:36:57 -0700 (PDT)
Received: from [10.254.46.235] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id j9sm21208132pgl.1.2021.08.31.05.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 05:36:57 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mm: remove redundant smp_wmb()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210828042306.42886-1-zhengqi.arch@bytedance.com>
 <20210828042306.42886-3-zhengqi.arch@bytedance.com>
 <9da807d4-1fcc-72e0-dc9e-91ab9fbeb7c6@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <3f8e9805-b90f-7df3-8514-139afa653671@bytedance.com>
Date:   Tue, 31 Aug 2021 20:36:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9da807d4-1fcc-72e0-dc9e-91ab9fbeb7c6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/31 PM6:02, David Hildenbrand wrote:
> On 28.08.21 06:23, Qi Zheng wrote:
>> The smp_wmb() which is in the __pte_alloc() is used to
>> ensure all ptes setup is visible before the pte is made
>> visible to other CPUs by being put into page tables. We
>> only need this when the pte is actually populated, so
>> move it to pte_install(). __pte_alloc_kernel(),
>> __p4d_alloc(), __pud_alloc() and __pmd_alloc() are similar
>> to this case.
>>
>> We can also defer smp_wmb() to the place where the pmd entry
>> is really populated by preallocated pte. There are two kinds
>> of user of preallocated pte, one is filemap & finish_fault(),
>> another is THP. The former does not need another smp_wmb()
>> because the smp_wmb() has been done by pte_install().
>> Fortunately, the latter also does not need another smp_wmb()
>> because there is already a smp_wmb() before populating the
>> new pte when the THP uses a preallocated pte to split a huge
>> pmd.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   mm/memory.c         | 47 
>> ++++++++++++++++++++---------------------------
>>   mm/sparse-vmemmap.c |  2 +-
>>   2 files changed, 21 insertions(+), 28 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index ef7b1762e996..9c7534187454 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -439,6 +439,20 @@ void pmd_install(struct mm_struct *mm, pmd_t 
>> *pmd, pgtable_t *pte)
>>       if (likely(pmd_none(*pmd))) {    /* Has another populated it ? */
>>           mm_inc_nr_ptes(mm);
>> +        /*
>> +         * Ensure all pte setup (eg. pte page lock and page clearing) 
>> are
>> +         * visible before the pte is made visible to other CPUs by being
>> +         * put into page tables.
>> +         *
>> +         * The other side of the story is the pointer chasing in the 
>> page
>> +         * table walking code (when walking the page table without 
>> locking;
>> +         * ie. most of the time). Fortunately, these data accesses 
>> consist
>> +         * of a chain of data-dependent loads, meaning most CPUs (alpha
>> +         * being the notable exception) will already guarantee loads are
>> +         * seen in-order. See the alpha page table accessors for the
>> +         * smp_rmb() barriers in page table walking code.
>> +         */
>> +        smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
>>           pmd_populate(mm, pmd, *pte);
>>           *pte = NULL;
>>       }
>> @@ -451,21 +465,6 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>>       if (!new)
>>           return -ENOMEM;
>> -    /*
>> -     * Ensure all pte setup (eg. pte page lock and page clearing) are
>> -     * visible before the pte is made visible to other CPUs by being
>> -     * put into page tables.
>> -     *
>> -     * The other side of the story is the pointer chasing in the page
>> -     * table walking code (when walking the page table without locking;
>> -     * ie. most of the time). Fortunately, these data accesses consist
>> -     * of a chain of data-dependent loads, meaning most CPUs (alpha
>> -     * being the notable exception) will already guarantee loads are
>> -     * seen in-order. See the alpha page table accessors for the
>> -     * smp_rmb() barriers in page table walking code.
>> -     */
>> -    smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
>> -
>>       pmd_install(mm, pmd, &new);
>>       if (new)
>>           pte_free(mm, new);
>> @@ -478,10 +477,9 @@ int __pte_alloc_kernel(pmd_t *pmd)
>>       if (!new)
>>           return -ENOMEM;
>> -    smp_wmb(); /* See comment in __pte_alloc */
>> -
>>       spin_lock(&init_mm.page_table_lock);
>>       if (likely(pmd_none(*pmd))) {    /* Has another populated it ? */
>> +        smp_wmb(); /* See comment in pmd_install() */
>>           pmd_populate_kernel(&init_mm, pmd, new);
>>           new = NULL;
>>       }
>> @@ -3857,7 +3855,6 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>>           vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
>>           if (!vmf->prealloc_pte)
>>               return VM_FAULT_OOM;
>> -        smp_wmb(); /* See comment in __pte_alloc() */
>>       }
>>       ret = vma->vm_ops->fault(vmf);
>> @@ -3919,7 +3916,6 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, 
>> struct page *page)
>>           vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
>>           if (!vmf->prealloc_pte)
>>               return VM_FAULT_OOM;
>> -        smp_wmb(); /* See comment in __pte_alloc() */
>>       }
>>       vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>> @@ -4144,7 +4140,6 @@ static vm_fault_t do_fault_around(struct 
>> vm_fault *vmf)
>>           vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
>>           if (!vmf->prealloc_pte)
>>               return VM_FAULT_OOM;
>> -        smp_wmb(); /* See comment in __pte_alloc() */
>>       }
>>       return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
>> @@ -4819,13 +4814,13 @@ int __p4d_alloc(struct mm_struct *mm, pgd_t 
>> *pgd, unsigned long address)
>>       if (!new)
>>           return -ENOMEM;
>> -    smp_wmb(); /* See comment in __pte_alloc */
>> -
>>       spin_lock(&mm->page_table_lock);
>>       if (pgd_present(*pgd))        /* Another has populated it */
>>           p4d_free(mm, new);
>> -    else
>> +    else {
>> +        smp_wmb(); /* See comment in pmd_install() */
>>           pgd_populate(mm, pgd, new);
>> +    }
> 
> Nit:
> 
> if () {
> 
> } else {
> 
> }
> 
> see Documentation/process/coding-style.rst
> 
> "This does not apply if only one branch of a conditional statement is a 
> single statement; in the latter case use braces in both branches:"

Got it.

> 
> 
> Apart from that, I think this is fine,
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks,
Qi

