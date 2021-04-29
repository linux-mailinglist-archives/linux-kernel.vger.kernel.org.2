Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6116C36ECA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbhD2Otc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhD2Otb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619707724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tkl/J7KdySQSxmwL4nToe0M/Xh0jvxPcUzrvauVfBCc=;
        b=iSi5jPUf8GrptG9AIA+UzCXJQRkLhCTudznXyReUK8jIZhEennuESwEFpZZ7j+vp1vCJui
        ZaiRozZTTEhvih9g+WwMkaYIDyYHNLGqIJaLnN9WEGQZztGlJZ+rYY9bbPjAzkzZf4zcXE
        SUAyt7glonWg4vLwKtgEX/TGBb7jNQ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-Ib8TO8iLMJy_sWRE2kCz3w-1; Thu, 29 Apr 2021 10:48:42 -0400
X-MC-Unique: Ib8TO8iLMJy_sWRE2kCz3w-1
Received: by mail-wm1-f72.google.com with SMTP id n9-20020a1c40090000b02901401bf40f9dso4820070wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tkl/J7KdySQSxmwL4nToe0M/Xh0jvxPcUzrvauVfBCc=;
        b=JM8pGFbiQB2VSYGhNsTE+sA+6rpzLxuJZJcrZZoHbVnqdE6T7g2AGqw2Uo2ZFYxMr2
         mGCUh2LVeaaatCveWcU/a2mKnsv5InHE6rO0o6Wf3li2qGEDxmCCq7kThyt4f+X7YnIH
         8iz/h/icrNmFQOZuPyhfgSLvGPuqzbvWX4nGJNuvKwQ4RXLNmNE+1YIMv7DH33/GCd5T
         qB8ZLC3a6rqkLvLVPUnvbUW+LXk5agmwvs8/HdBhHvKkVspl6NOdaVtZ8Q3FNhK32rWx
         Swe05EbIcyEFR7iQGaf3HbTFaWCBpX73oZJbBRzVOcgUx2tvmultepvyugWoP9zS2s3p
         /Aaw==
X-Gm-Message-State: AOAM531nR9Sy/2Xod7Di+gB6qlrLaHTiTNuNzHb4gWrNSDSGudUWFgcl
        GJg1zYMS174UOpLqr80jaESy93RgVXpj0jz9Wt8DSyUCJXvfCaW4CSZWSSmpbuSqEn3MDgcZg3C
        HvmMj96F5RP3gpamxEvDSZJ6b
X-Received: by 2002:a05:600c:2d4b:: with SMTP id a11mr375461wmg.185.1619707721313;
        Thu, 29 Apr 2021 07:48:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK5tOEhSkHKJM0+mEkeUgviEzMNg++fZFr8Lr9yMtdQOF0i9GqBldz4nWleT5OKc6yM0IfdQ==
X-Received: by 2002:a05:600c:2d4b:: with SMTP id a11mr375426wmg.185.1619707721051;
        Thu, 29 Apr 2021 07:48:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6158.dip0.t-ipconnect.de. [91.12.97.88])
        by smtp.gmail.com with ESMTPSA id p17sm5000217wru.1.2021.04.29.07.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 07:48:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] mm/huge_memory.c: remove dedicated macro
 HPAGE_CACHE_INDEX_MASK
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210429132648.305447-1-linmiaohe@huawei.com>
 <20210429132648.305447-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c7dab2a5-cf77-a1dd-201a-f4a5f190c4d7@redhat.com>
Date:   Thu, 29 Apr 2021 16:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429132648.305447-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 15:26, Miaohe Lin wrote:
> Rewrite the pgoff checking logic to remove macro HPAGE_CACHE_INDEX_MASK
> which is only used here to simplify the code.
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/huge_mm.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9626fda5efce..0a526f211fec 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -152,15 +152,13 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>   
>   bool transparent_hugepage_enabled(struct vm_area_struct *vma);
>   
> -#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
> -
>   static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>   		unsigned long haddr)
>   {
>   	/* Don't have to check pgoff for anonymous vma */
>   	if (!vma_is_anonymous(vma)) {
> -		if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
> -			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
> +		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> +				HPAGE_PMD_NR))
>   			return false;

I'd have used

if (!IS_ALIGNED(PHYS_PFN(vma->vm_start) - vma->vm_pgoff,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

