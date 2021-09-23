Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C914161E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhIWPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbhIWPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632410367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGCu5vIJXzqgCg8xHHPR2KnAZqh2TqcPDCJS3P0Px/M=;
        b=EyiWcpSUPIYHO8ZvlWEgPzwy3llR9Gjkv5714GZP5CYUsFgw6sVOsWJjH6U/+f7Z/MC7sX
        sgddpm9I3nI6VEfWNDE5m0XaY3aVMEGfAr8dTOECUZPFNzyjV+VXglWRt2Got07Xvupe9S
        MGjKRsDHg3T9L4jxxZlnkyvq7KEDagA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-U819BazYOcuKRYcYvOg3tA-1; Thu, 23 Sep 2021 11:19:25 -0400
X-MC-Unique: U819BazYOcuKRYcYvOg3tA-1
Received: by mail-wr1-f71.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso5386887wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XGCu5vIJXzqgCg8xHHPR2KnAZqh2TqcPDCJS3P0Px/M=;
        b=dOtK29dQcKQh0gVuL65gseORhk5zHMRxdWyIeF+bClIlEssmm7nB634DJAoqit6dSR
         zR9e4N4JCeo4ObDCIBNkyG39Un0Hm7fhzw1M1p1Gdp2lqC15g9io6Mig+Ia3Xizw5q4C
         yuUr6eauJkCIvnC5NgLlUUO+ptWx41kYvjboABeXf5Osh/Dqmg4esaeljqaCWdXtzm/y
         1KG/zqUATJw7qJcpxQNT6lg8Wc2zI6GItV4I7ItIpCsWUbFRdJqMqSocK7HaBCl9U6B6
         rDpqIkomjdr9dxlhDd1iYsvtIeY1C3EtQevx6CMz1H1+bDfVhlDW8j6V7ceHWtImAkfm
         jkrg==
X-Gm-Message-State: AOAM530zP4V8bZKPQhQXYM+P8YVBZ3BxvL5xESR7X4RFbA1K5k7DMI9m
        HjsovDU9IlCFm2J85RbYwlvGHw7W3vMAZ3F1W4S1gA8/GafowXpLkimEka40KEA0Skp84S8Qtxt
        1f2axfF3EJJp7B3VCdRLPb+AI
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr16390935wmo.39.1632410364456;
        Thu, 23 Sep 2021 08:19:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSN9YInxHJH0+b/VUtAFg6XTyNqR/4Wp+Pvtm/ukXlGQBhABku40FhX82R08bdZ8ySOn/iiQ==
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr16390921wmo.39.1632410364252;
        Thu, 23 Sep 2021 08:19:24 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e5d.dip0.t-ipconnect.de. [79.242.62.93])
        by smtp.gmail.com with ESMTPSA id j4sm5899868wrt.67.2021.09.23.08.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 08:19:23 -0700 (PDT)
Subject: Re: [PATCH] mm/memory_failure: Fix the missing pte_unmap() call
To:     Qi Zheng <zhengqi.arch@bytedance.com>, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7330e2e0-9dc4-e412-a821-ed62a469371d@redhat.com>
Date:   Thu, 23 Sep 2021 17:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.21 14:26, Qi Zheng wrote:
> The paired pte_unmap() call is missing before the
> dev_pagemap_mapping_shift() returns. So fix it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/memory-failure.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e2984c123e7e..4e5419f16fd4 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -306,6 +306,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>   		struct vm_area_struct *vma)
>   {
>   	unsigned long address = vma_address(page, vma);
> +	unsigned long ret = 0;
>   	pgd_t *pgd;
>   	p4d_t *p4d;
>   	pud_t *pud;
> @@ -330,10 +331,12 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>   		return PMD_SHIFT;
>   	pte = pte_offset_map(pmd, address);
>   	if (!pte_present(*pte))
> -		return 0;
> +		goto unmap;
>   	if (pte_devmap(*pte))
> -		return PAGE_SHIFT;
> -	return 0;
> +		ret = PAGE_SHIFT;
> +unmap:
> +	pte_unmap(pte);
> +	return ret;
>   }
>   
>   /*
> 

I guess this code never runs on 32bit / highmem, that's why we didn't 
notice so far.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

