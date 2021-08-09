Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BBB3E428E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhHIJYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234285AbhHIJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628501053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gf5zAZTKDCzUjBi4iBqzapJeQmqdwtpc/dVF+3UUB7I=;
        b=SzmFvhCxtRzkcKEDzDslWos6ohQBjNKQV7k5Gh5L5nrOZT+Ddb82RaxicKIUlToYMGNabA
        MBomgRIkKuJ3DbrwlaYqrl+pdEdHvULaFp/9+1mZ59z4G6Q9L0CWzH+rML2GqtTH4BY2dD
        e/9EpnhB190tb1p3upcePx3iRE2q5U4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-RpDOaQtWMPqL42R9CO_2Bw-1; Mon, 09 Aug 2021 05:24:11 -0400
X-MC-Unique: RpDOaQtWMPqL42R9CO_2Bw-1
Received: by mail-wm1-f72.google.com with SMTP id j204-20020a1c23d50000b029024e75a15714so4427344wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Gf5zAZTKDCzUjBi4iBqzapJeQmqdwtpc/dVF+3UUB7I=;
        b=FbHGKbV5Uf8vmv8bowMXaEB4gB4F0KtiPKuHj2dGssswT7ANuScDTVWz/y9UmMUP9t
         l4jltlVwvqgKUSlj8g2KUv/ZQV0M3X2c9sPZiuBJKDEgzNc0sGnn5uZj8nHZvfu6VQWk
         yH7y+p5KPKif4vbtQlNCEc0TTDBUgUdql9du5btSVp2di1bA6cOjrdtAg6hRWXk08U0z
         T+5jdrmVAqoRJUh6+tNgEfIkCst60EuG7ZfMbps6DswEUBldjfRJ816dj57wc7Wg/DBJ
         ER3naCPgot8R+RTSOFKy9F0JwWrJwCBnaYMUawToVNvOnr9zPwuYPWyxziKIAIejpool
         84Og==
X-Gm-Message-State: AOAM5318w7NBbg1pdfsYET+4Bf7Y916qFIpN1scP9jv0idC7N7XDyNJ/
        GVaA9oXEs71FGlGVBTBEOMu2TKmm8Zltl5/rrJ9VDdFVGkUGAuWnzaBKqtTDOaqpJsPvI2MeXA2
        stLUvTLHjxXGywMOlKLgWZsK2sGRo9jxbDvnnP3OMPGR0+rLHpTYZ5WViiokNkZ+lMvnMhtHL
X-Received: by 2002:a5d:5147:: with SMTP id u7mr24081662wrt.181.1628501050656;
        Mon, 09 Aug 2021 02:24:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqwNs3WqX1YeqYoIBfWPgUNcNrKn1nNW77zqBb7B+1FZhHGFQWkvCq9jfruwzCWiCGkBOwxA==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr24081636wrt.181.1628501050466;
        Mon, 09 Aug 2021 02:24:10 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id n3sm16747084wmi.0.2021.08.09.02.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 02:24:10 -0700 (PDT)
Subject: Re: [PATCH 5/5] mm: gup: use helper PAGE_ALIGNED in
 populate_vma_page_range()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, kirill.shutemov@linux.intel.com,
        jack@suse.cz, jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210807093620.21347-1-linmiaohe@huawei.com>
 <20210807093620.21347-6-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <60e83492-db02-4c73-1fd4-e1f2ba383cfe@redhat.com>
Date:   Mon, 9 Aug 2021 11:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807093620.21347-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.21 11:36, Miaohe Lin wrote:
> Use helper PAGE_ALIGNED to check if address is aligned to PAGE_SIZE.
> Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/gup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 8c89e614d4aa..802a3deb50cd 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1471,8 +1471,8 @@ long populate_vma_page_range(struct vm_area_struct *vma,
>   	unsigned long nr_pages = (end - start) / PAGE_SIZE;
>   	int gup_flags;
>   
> -	VM_BUG_ON(start & ~PAGE_MASK);
> -	VM_BUG_ON(end   & ~PAGE_MASK);
> +	VM_BUG_ON(!PAGE_ALIGNED(start));
> +	VM_BUG_ON(!PAGE_ALIGNED(end));
>   	VM_BUG_ON_VMA(start < vma->vm_start, vma);
>   	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
>   	mmap_assert_locked(mm);
> 

Making it look more like faultin_vma_page_range(), nice :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

