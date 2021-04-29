Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6174136ECD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhD2O6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233128AbhD2O6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619708264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VW6tjD6feTHs5rrGnhbZrNt/b+Sq5VBqFh5p3ij41kI=;
        b=eDBWwEW8yWBxYZ6K3BeFVR+C8tGCWNkZIJ+Zi+A6fYV/A2VpE/+P0xsXvvgxKp6rDCGMdr
        EppDM0HAP+vn6wLVwtSo6zeRhk9Kfj7TxoGiWulVz97aPgIOQMWMeYT8VCey0IbfoYVl0D
        VGm0zI0bmEeAsWTxzsM0rLHz0+ElIvQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-DugUbX0xPxyYwKTH8nvh8Q-1; Thu, 29 Apr 2021 10:57:42 -0400
X-MC-Unique: DugUbX0xPxyYwKTH8nvh8Q-1
Received: by mail-ed1-f69.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so5244367edu.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VW6tjD6feTHs5rrGnhbZrNt/b+Sq5VBqFh5p3ij41kI=;
        b=VYLMIncYHoekyfiNXBQlM5W0r1MOyOwd6E+hshP7WCdO5rSDZKs7HAl1DEoNuopwWS
         Cr1kjUrdEjePZvCm4JFVH4DsM7dZ/v50fystB+rHv32rv7n3PBMIsRD/nIxtsyKyiuJ8
         kP0Eo/s1zgdvYSFTw6CHFOOvPjaz6l70/UVHteblxFXsOKIlsitrBu3xbzo5VVNtMZM8
         zercIPdLDuXbQqzGLeFDz/gML81qv+65Y+erUIL989P3T+qeZ0JIHJylegofgRMnS4ko
         VUJymCaXDaIkGc8pipZvLaK8We7MiBt8arL4ibLQjXG5gHBG2+J42tr2mRcgY3Tr14k8
         e6Sg==
X-Gm-Message-State: AOAM533WwESiGlq9MjxaNvIt5qX71EBekJUuZyO+i1Rb6YBjt1vwMBAu
        UTFigxcrjOjeDU1fv4DLbQ9nus+MVJXrVe9v2Dz2lBK5d65REKj1sm7uT8fOO21KAN2SEs1B+IK
        UvWuGoephGcNhAXR+utGLQVsB
X-Received: by 2002:a17:906:2ac5:: with SMTP id m5mr211434eje.517.1619708261712;
        Thu, 29 Apr 2021 07:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPIDvzLG80uieLFneg3V7Kz9qe0O9OKY902F+CTvCVSpX1T9affEnLVwJAvOOu9EZ4YU8URw==
X-Received: by 2002:a17:906:2ac5:: with SMTP id m5mr211394eje.517.1619708261380;
        Thu, 29 Apr 2021 07:57:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6158.dip0.t-ipconnect.de. [91.12.97.88])
        by smtp.gmail.com with ESMTPSA id w6sm104904eje.107.2021.04.29.07.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 07:57:41 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] mm/huge_memory.c: add missing read-only THP
 checking in transparent_hugepage_enabled()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210429132648.305447-1-linmiaohe@huawei.com>
 <20210429132648.305447-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <68c8c4a8-c4f8-83db-7326-dabeea74239c@redhat.com>
Date:   Thu, 29 Apr 2021 16:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429132648.305447-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 15:26, Miaohe Lin wrote:
> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
> (non-shmem) FS"), read-only THP file mapping is supported. But it
> forgot to add checking for it in transparent_hugepage_enabled().
> To fix it, we add checking for read-only THP file mapping and also
> introduce helper transhuge_vma_enabled() to check whether thp is
> enabled for specified vma to reduce duplicated code.
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/huge_mm.h | 21 +++++++++++++++++----
>   mm/huge_memory.c        |  6 ++++++
>   mm/khugepaged.c         |  4 +---
>   mm/shmem.c              |  3 +--
>   4 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 0a526f211fec..f460b74619fc 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -115,6 +115,16 @@ extern struct kobj_attribute shmem_enabled_attr;
>   
>   extern unsigned long transparent_hugepage_flags;
>   
> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> +					  unsigned long vm_flags)

You're passing the vma already, why do you pass vma->vm_flags 
separately? It's sufficient to pass in the vma only.

> +{
> +	/* Explicitly disabled through madvise. */
> +	if ((vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +		return false;
> +	return true;
> +}
> +
>   /*
>    * to be used on vmas which are known to support THP.
>    * Use transparent_hugepage_enabled otherwise
> @@ -128,15 +138,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>   	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
>   		return false;
>   
> -	if (vma->vm_flags & VM_NOHUGEPAGE)
> +	if (!transhuge_vma_enabled(vma, vma->vm_flags))
>   		return false;
>   
>   	if (vma_is_temporary_stack(vma))
>   		return false;
>   
> -	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -		return false;
> -
>   	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>   		return true;
>   
> @@ -362,6 +369,12 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>   	return false;
>   }
>   
> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> +					  unsigned long vm_flags)
> +{
> +	return false;
> +}
> +
>   static inline void prep_transhuge_page(struct page *page) {}
>   
>   static inline bool is_transparent_hugepage(struct page *page)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 76ca1eb2a223..e24a96de2e37 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -68,12 +68,18 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>   	/* The addr is used to check if the vma size fits */
>   	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
>   
> +	if (!transhuge_vma_enabled(vma, vma->vm_flags))
> +		return false;
>   	if (!transhuge_vma_suitable(vma, addr))
>   		return false;
>   	if (vma_is_anonymous(vma))
>   		return __transparent_hugepage_enabled(vma);
>   	if (vma_is_shmem(vma))
>   		return shmem_huge_enabled(vma);
> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> +	    !inode_is_open_for_write(vma->vm_file->f_inode) &&
> +	    (vma->vm_flags & VM_EXEC))
> +		return true;

Nit: I'm really wondering why we have 3 different functions that sound 
like they are doing the same thing

transparent_hugepage_enabled(vma)
transhuge_vma_enabled()
transhuge_vma_suitable()

Which check belongs where? Does it really have to be that complicated?

>   
>   	return false;
>   }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6c0185fdd815..d97b20fad6e8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -442,9 +442,7 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
>   static bool hugepage_vma_check(struct vm_area_struct *vma,
>   			       unsigned long vm_flags)
>   {
> -	/* Explicitly disabled through madvise. */
> -	if ((vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +	if (!transhuge_vma_enabled(vma, vm_flags))
>   		return false;
>   
>   	/* Enabled via shmem mount options or sysfs settings. */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a08cedefbfaa..1dcbec313c70 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4032,8 +4032,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>   	loff_t i_size;
>   	pgoff_t off;
>   
> -	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +	if (!transhuge_vma_enabled(vma, vma->vm_flags))
>   		return false;
>   	if (shmem_huge == SHMEM_HUGE_FORCE)
>   		return true;
> 


-- 
Thanks,

David / dhildenb

