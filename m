Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6234435F78C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351974AbhDNPZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234089AbhDNPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618413886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJHSXjtiEnq1lLxlzPCgR7MDQEFwzThawyaXJPYUnzI=;
        b=Knaf7DtdDtFTv2QmT/kNCR8dTnGCYu0RRM3tEeTS4BY2PLUgJOuia64j/9lUW3pivee6/Y
        kMqEgx0NGgHcppqhISeJQZdQngC/DNxdI54tA+X43p0/ZN+0i/B3apDat/nzXKEB2fonC9
        vX9T7WXpJSi5Ok1EV5dIpD9mJvH9TOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-aZ0Lis5HM-2DGYyOuWZ5bQ-1; Wed, 14 Apr 2021 11:24:44 -0400
X-MC-Unique: aZ0Lis5HM-2DGYyOuWZ5bQ-1
Received: by mail-wm1-f69.google.com with SMTP id v5-20020a05600c2145b029012bdd9ddcb7so1506901wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DJHSXjtiEnq1lLxlzPCgR7MDQEFwzThawyaXJPYUnzI=;
        b=XM+/iDfCjy87NCwjNvqM4DKSQTu6mCKXljTX1EN7x1M4yKXzsbMVk3a8Rvs/HmGhdr
         qIXTOY2mR6zsucNMdoj34u6h5Ypr4E0ONzJfbG9QhM6gR+upeVmZgFhmhKrm0d9pabpz
         drWGDtxfnRhO4GxHjkTPKLDyisqIP6MOkc83tsDDfjScuPx/Lbw5zafyNM1wRpohDeeA
         y+C6frEsq3UqTZFLQle0H/oJoUJhm2GtH26MKpxr13mHWfPXrPPRFfrF2dkRz+sZFQqs
         eTTPhQs/bVTE/7aey01QBqG/StdzuRjVx/CiUl+9pQWZDLJpBEqnAv1Qv/Q28DEwQ3Yc
         OqcQ==
X-Gm-Message-State: AOAM533KZDpXV6cNzoqkc00sWxsLfao1yhfkq1pn1+WVFcf94oc1x63W
        05qm7EA2MtrcPxRcWgDOIczxC/WQSgIRh8o0bj7F8F8M9S8tIksUfZLvyRUejpcq3w9u8y4Ke0F
        joBq6JDKdwZZsKb7Qn5LCeLhL
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr43839474wri.349.1618413883499;
        Wed, 14 Apr 2021 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEw1n6/gmVlMn97XxaYElS8ypQgxqhWN52cWJQKttA76qIZNPdA0R7Y5TvH7QZQ4/rNGTCOg==
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr43839457wri.349.1618413883285;
        Wed, 14 Apr 2021 08:24:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id x2sm15399098wrg.31.2021.04.14.08.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:24:43 -0700 (PDT)
Subject: Re: [PATCH] mm: Optimise nth_page for contiguous memmap
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Douglas Gilbert <dougg@torque.net>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20210413194625.1472345-1-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <67922c5b-0a7b-4eab-9fee-455acf555ebf@redhat.com>
Date:   Wed, 14 Apr 2021 17:24:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210413194625.1472345-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.21 21:46, Matthew Wilcox (Oracle) wrote:
> If the memmap is virtually contiguous (either because we're using
> a virtually mapped memmap or because we don't support a discontig
> memmap at all), then we can implement nth_page() by simple addition.
> Contrary to popular belief, the compiler is not able to optimise this
> itself for a vmemmap configuration.  This reduces one example user (sg.c)
> by four instructions:
> 
>          struct page *page = nth_page(rsv_schp->pages[k], offset >> PAGE_SHIFT);
> 
> before:
>     49 8b 45 70             mov    0x70(%r13),%rax
>     48 63 c9                movslq %ecx,%rcx
>     48 c1 eb 0c             shr    $0xc,%rbx
>     48 8b 04 c8             mov    (%rax,%rcx,8),%rax
>     48 2b 05 00 00 00 00    sub    0x0(%rip),%rax
>             R_X86_64_PC32      vmemmap_base-0x4
>     48 c1 f8 06             sar    $0x6,%rax
>     48 01 d8                add    %rbx,%rax
>     48 c1 e0 06             shl    $0x6,%rax
>     48 03 05 00 00 00 00    add    0x0(%rip),%rax
>             R_X86_64_PC32      vmemmap_base-0x4
> 
> after:
>     49 8b 45 70             mov    0x70(%r13),%rax
>     48 63 c9                movslq %ecx,%rcx
>     48 c1 eb 0c             shr    $0xc,%rbx
>     48 c1 e3 06             shl    $0x6,%rbx
>     48 03 1c c8             add    (%rax,%rcx,8),%rbx
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/mm.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 25b9041f9925..2327f99b121f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -234,7 +234,11 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
>   int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
>   		pgoff_t index, gfp_t gfp, void **shadowp);
>   
> +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>   #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> +#else
> +#define nth_page(page,n) ((page) + (n))
> +#endif

For sparsemem we could optimize within a single memory section. But not 
sure if it's worth the trouble.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

