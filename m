Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9783F62A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhHXQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229896AbhHXQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629822407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYtQtl/3C2Gj/kt8xj0pTccd7H5GHAf8Dw42NMrmVXU=;
        b=TDpaDZ6Udwpu0ea601OExdaZovM+kITkfMqhecbycp4Mv4FkS6szKHzdY+0IbwUqEmO+mV
        SjXG6R+VlLCNChg0iAzFmznfPdbBemYkdXfoSA/blewuF9CJWun/xTBbS8lDZ3mBqNCq2g
        EeBohuuE1YHjwGlX3hDLqiA2+Mv/mKU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423--0wmEQ3DN9yuuFQ7Z6Kt1g-1; Tue, 24 Aug 2021 12:26:46 -0400
X-MC-Unique: -0wmEQ3DN9yuuFQ7Z6Kt1g-1
Received: by mail-wm1-f70.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso148181wmx.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TYtQtl/3C2Gj/kt8xj0pTccd7H5GHAf8Dw42NMrmVXU=;
        b=BSYbM8INa5nvqwHEfVwLn0TY5aYa0yZ434oEp4pyE9dQnrUjJSXnXcpU4UtIQRPvDV
         j82BSNRQ8lMaujdHX3sqKNm/VHuFDl15LuA3wreQaOG10n906dhKKS+q4UXWEHsefRhP
         +C+fgG14hRH5geTxxM1lhqWygMu2Z0bSYzTeJSFDPblJUWifgXKg87RAN02twuOqBYK/
         4r3J8yFba9jmdQ1kc5FEMRb61qu1LjEcfQPNKGM9L7iXNIVOfKH6Pu2vKeqBRkn/nzDn
         CEELHMWQFHWdLHBMN1yIxO+hxPHR4bVvkQkzURsynRCehtTeV3Ol4BlrMgGMouj3MBdM
         taHw==
X-Gm-Message-State: AOAM531uf7Y+kadBz1Fp2KUoYZW12aUwOISNfut+g6rZopYVLE6qB1yA
        c3XretFVDG84j/3U3zWGS3ELgQO2fDJwHtbwgl6vmaaEUostEyvgR3s6cjJu4Xlog/6jwmF9PD/
        WrgR/iOkjs4LkFFFqK3rNcYPY
X-Received: by 2002:adf:f101:: with SMTP id r1mr17135270wro.355.1629822404268;
        Tue, 24 Aug 2021 09:26:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx97fjaFa36+aZbM+EMQ9R++YVwrZeW3RMKAV9fGubIm+gCe79sLjVmW3/mIgQ7bDDbaucWcg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr17135258wro.355.1629822404086;
        Tue, 24 Aug 2021 09:26:44 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c4d.dip0.t-ipconnect.de. [79.242.60.77])
        by smtp.gmail.com with ESMTPSA id e2sm19925957wrq.56.2021.08.24.09.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:26:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] mm: introduce pmd_install() helper
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-2-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <edd82170-7149-1abf-6204-f1d665a5fca2@redhat.com>
Date:   Tue, 24 Aug 2021 18:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819031858.98043-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.21 05:18, Qi Zheng wrote:
> Currently we have three times the same few lines repeated in the
> code. Deduplicate them by newly introduced pmd_install() helper.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   include/linux/mm.h |  1 +
>   mm/filemap.c       | 11 ++---------
>   mm/memory.c        | 34 ++++++++++++++++------------------
>   3 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ce8fc0fd6d6e..57e48217bd71 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2471,6 +2471,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>   	return ptl;
>   }
>   
> +extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>   extern void __init pagecache_init(void);
>   extern void __init free_area_init_memoryless_node(int nid);
>   extern void free_initmem(void);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 53913fced7ae..9f773059c6dc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3210,15 +3210,8 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
>   	    }
>   	}
>   
> -	if (pmd_none(*vmf->pmd)) {
> -		vmf->ptl = pmd_lock(mm, vmf->pmd);
> -		if (likely(pmd_none(*vmf->pmd))) {
> -			mm_inc_nr_ptes(mm);
> -			pmd_populate(mm, vmf->pmd, vmf->prealloc_pte);
> -			vmf->prealloc_pte = NULL;
> -		}
> -		spin_unlock(vmf->ptl);
> -	}
> +	if (pmd_none(*vmf->pmd))
> +		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
>   
>   	/* See comment in handle_pte_fault() */
>   	if (pmd_devmap_trans_unstable(vmf->pmd)) {
> diff --git a/mm/memory.c b/mm/memory.c
> index 39e7a1495c3c..ef7b1762e996 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -433,9 +433,20 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   	}
>   }
>   
> +void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
> +{
> +	spinlock_t *ptl = pmd_lock(mm, pmd);
> +
> +	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
> +		mm_inc_nr_ptes(mm);
> +		pmd_populate(mm, pmd, *pte);
> +		*pte = NULL;
> +	}
> +	spin_unlock(ptl);
> +}
> +
>   int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>   {
> -	spinlock_t *ptl;
>   	pgtable_t new = pte_alloc_one(mm);
>   	if (!new)
>   		return -ENOMEM;
> @@ -455,13 +466,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
>   	 */
>   	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
>   
> -	ptl = pmd_lock(mm, pmd);
> -	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
> -		mm_inc_nr_ptes(mm);
> -		pmd_populate(mm, pmd, new);
> -		new = NULL;
> -	}
> -	spin_unlock(ptl);
> +	pmd_install(mm, pmd, &new);
>   	if (new)
>   		pte_free(mm, new);
>   	return 0;
> @@ -4027,17 +4032,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   				return ret;
>   		}
>   
> -		if (vmf->prealloc_pte) {
> -			vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> -			if (likely(pmd_none(*vmf->pmd))) {
> -				mm_inc_nr_ptes(vma->vm_mm);
> -				pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
> -				vmf->prealloc_pte = NULL;
> -			}
> -			spin_unlock(vmf->ptl);
> -		} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
> +		if (vmf->prealloc_pte)
> +			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
> +		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
>   			return VM_FAULT_OOM;
> -		}
>   	}
>   
>   	/* See comment in handle_pte_fault() */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

That's mostly unrelated to the remaining part of the series and can be 
picked up early.

-- 
Thanks,

David / dhildenb

