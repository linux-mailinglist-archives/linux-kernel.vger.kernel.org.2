Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E337417021
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbhIXKP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245422AbhIXKPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632478432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0Xu8+2QxmEE/12WsxSCXDBug3dgoFNscQbbAMWG7XU=;
        b=eXZLFGCDJ8j6y5FL35DAfuI+4OIgJsPK20M/8SM3KlxWFTF3wT7+38IuQa256/t3O0a8He
        jv83/oAwSjNbfbGuo1Ex9/IluEhhIZkP5C4wvboWDg2vPDfGZJO7gmSC+tWiqY0UlovAHI
        dpOzWAGZys9uL0YEMF0MpvQXfOHfkqA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-f0vi66YPMfuwCTEbGE7wVg-1; Fri, 24 Sep 2021 06:13:51 -0400
X-MC-Unique: f0vi66YPMfuwCTEbGE7wVg-1
Received: by mail-wr1-f69.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so7674455wrf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 03:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=X0Xu8+2QxmEE/12WsxSCXDBug3dgoFNscQbbAMWG7XU=;
        b=En7ce/Cx2QugBvuzhCIwmZDCUh0+BW8kU7vH8t3Cz1KSsowlD/KP+AP+0d5UZaAAb7
         xCCEzkt5MqoByyI7zrzx0Azp/MZH1C01Z8DT0EKJ0LBdO7ifglKuUn2mH/ZmPJgzgcpU
         Y5geoYVWicljU94BvEuWU3VGifOJySvJ1d/kZ4AL0r03aRHIsGasm7ZeJB2CTXpQIJOd
         cI/lSzIW7s9362kOw294A8SncZyKuPggYpqGDeh2ajPBPU73cJqny/p96xecNL9RbjIf
         P2f/BvZwtRvEmIza3z+4wnoKIiumt77pfKGf0oEieVxdCWxnAcLH7duAWaLVcu1W66Qs
         bhmQ==
X-Gm-Message-State: AOAM532irlJPQbeS1R8FWUA7isPf98aaD/cAym6kMaUuW86DbMbzYE0J
        wl+T153QbrEVl40Yrujr7VC1Hse835uo8+MYrhDRaxymrGsMZhc7d/3DxJYetA1mC//bS7P2xNS
        NvpYPxLUmOmnOZ15oQ+hPd7X3
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr1158125wmi.143.1632478429907;
        Fri, 24 Sep 2021 03:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKN6bDuoxj1EViKhyE1TY+qT9WxmW8owOfK7HTvxGxrnAhTWeXy86pnx+VD6g3WTR8fdt79A==
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr1158110wmi.143.1632478429676;
        Fri, 24 Sep 2021 03:13:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id w14sm7648763wro.8.2021.09.24.03.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 03:13:49 -0700 (PDT)
Subject: Re: [PATCH v2] mm/hugetlb: Drop __unmap_hugepage_range definition
 from hugetlb.h
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20210917165108.9341-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <99610e8c-cd4a-3a3f-d3f8-507a4822590a@redhat.com>
Date:   Fri, 24 Sep 2021 12:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210917165108.9341-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.21 18:51, Peter Xu wrote:
> Remove __unmap_hugepage_range() from the header file, because it is only used
> in hugetlb.c.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/hugetlb.h | 10 ----------
>   mm/hugetlb.c            |  6 +++---
>   2 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..3cbf60464398 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -143,9 +143,6 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>   			  struct vm_area_struct *vma,
>   			  unsigned long start, unsigned long end,
>   			  struct page *ref_page);
> -void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -				unsigned long start, unsigned long end,
> -				struct page *ref_page);
>   void hugetlb_report_meminfo(struct seq_file *);
>   int hugetlb_report_node_meminfo(char *buf, int len, int nid);
>   void hugetlb_show_meminfo(void);
> @@ -385,13 +382,6 @@ static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>   	BUG();
>   }
>   
> -static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
> -			struct vm_area_struct *vma, unsigned long start,
> -			unsigned long end, struct page *ref_page)
> -{
> -	BUG();
> -}
> -
>   static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
>   			struct vm_area_struct *vma, unsigned long address,
>   			unsigned int flags)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 95dc7b83381f..d394d9545c4e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4426,9 +4426,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   	return ret;
>   }
>   
> -void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -			    unsigned long start, unsigned long end,
> -			    struct page *ref_page)
> +static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +				   unsigned long start, unsigned long end,
> +				   struct page *ref_page)
>   {
>   	struct mm_struct *mm = vma->vm_mm;
>   	unsigned long address;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

