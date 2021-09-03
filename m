Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B313FFB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbhICH06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234791AbhICH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:26:57 -0400
X-Greylist: delayed 149325 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Sep 2021 03:26:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630653955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSs9jhYIc4tuPmP+RqJPsx9TcphJP1kswHl64EqKBk0=;
        b=RLX/Odg+Mnd/M31bVc+WalWapH7rQDe/LbkrtTVytdqBqQxlI4FRj4JqX87lC+h5CNXeQl
        p7MSBkNd7s1nYtHeF6oeRYXJ9MGgir2wljKruoSDKUw9x+FlquJLX1WB2nX4Tsg7yTDWvB
        wmL6xxCTHmfpiE72gd1MxpbX1S/fc6w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-l6WtgCf0MgGqnDSDb8-Fgg-1; Fri, 03 Sep 2021 03:25:54 -0400
X-MC-Unique: l6WtgCf0MgGqnDSDb8-Fgg-1
Received: by mail-wr1-f71.google.com with SMTP id h14-20020a056000000e00b001575b00eb08so1267446wrx.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dSs9jhYIc4tuPmP+RqJPsx9TcphJP1kswHl64EqKBk0=;
        b=JX21lH24FFcHSr4l8oDzfivUyhaWCal8Yg8fE2Wq9cgyweuYz7UGmjxMAfWXGXrH4z
         a7BNmX/3uStPBcwo4qdqEAfxo4qy57MZAhh5hRXMs6GWrQFB55GSCAgJjc6Qy6/JR2c1
         BZ2ksldUcI0lMTQWE0ppUPIg7F1mZH+0elSTOADTLTt/+x7G16JCyUlEqJuWDGQOGKdC
         JwHIgxHXVZNIldLdca8t/dpznDw5yxIiUu9Q+p5kyGHTp0eA/ZE16gaZ5H6J8ohxKlw+
         lRNLKYdqEWUlHH1lrT0URM5+yHSV5PpSjLcmIcu7T9osJTmAuK+Dt+tT1uDpRz8YLn1x
         IBIA==
X-Gm-Message-State: AOAM532LlnNjevxBsqUuI3/2HE1DH30SLTNp2xSVwnbnj6AYJj3Rd0lM
        hTrMAHMmaypgPEgH6GQ80fgkI4hs34WfvXT7zQ92sQRtAP8xJWdeFFS3jrCydjblID5qXuUpfdg
        JIVhkzjRL0sFXe6YCOrwg1WbB
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr1840511wmb.112.1630653953385;
        Fri, 03 Sep 2021 00:25:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCLqP0N/WoWFnWHpg0pkGCyTN+2A8G7u0hibsfoTv8ptu4dUdxFKvMgluO+VB1S+c/WAJ/AA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr1840493wmb.112.1630653953127;
        Fri, 03 Sep 2021 00:25:53 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e05.dip0.t-ipconnect.de. [79.242.62.5])
        by smtp.gmail.com with ESMTPSA id b12sm4571279wrx.72.2021.09.03.00.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 00:25:52 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201836.53605-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Message-ID: <ecd7c89e-da54-d08c-5085-88c2ee8cdfaf@redhat.com>
Date:   Fri, 3 Sep 2021 09:25:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902201836.53605-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.21 22:18, Peter Xu wrote:
> Firstly, the comment in zap_pte_range() is misleading because it checks against
> details rather than check_mappings, so it's against what the code did.
> 
> Meanwhile, it's confusing too on not explaining why passing in the details

s/on//

> pointer would mean to skip all swap entries.  New user of zap_details could
> very possibly miss this fact if they don't read deep until zap_pte_range()
> because there's no comment at zap_details talking about it at all, so swap
> entries could be errornously skipped without being noticed.

s/errornously/erroneously/

> 
> Actually very recently we introduced unmap_mapping_page() in 22061a1ffabd, I
> think that should also look into swap entries.  Add a comment there.  IOW, this
> patch will be a functional change to unmap_mapping_page() but hopefully in the
> right way to do it.
> 
> This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
> but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
> "details" parameter: the caller should explicitly set this to skip swap
> entries, otherwise swap entries will always be considered (which should still
> be the major case here).
> 
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/mm.h | 16 ++++++++++++++++
>   mm/memory.c        |  6 +++---
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 81e402a5fbc9..a7bcdb2ec956 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1716,12 +1716,18 @@ static inline bool can_do_mlock(void) { return false; }
>   extern int user_shm_lock(size_t, struct ucounts *);
>   extern void user_shm_unlock(size_t, struct ucounts *);
>   
> +typedef unsigned int __bitwise zap_flags_t;
> +
> +/* Whether to skip zapping swap entries */
> +#define  ZAP_FLAG_SKIP_SWAP  ((__force zap_flags_t) BIT(0))

Interestingly, this will also skip fake some swap entries (e.g., 
migration entries but not private/exclusive entries). Maybe extend that 
documentation a bit.

... but, looking into zap_pmd_range(), we don't care about "details" 
when calling zap_huge_pmd(), which will zap pmd migration entries IIUC 
... so it's really unclear to me what the flag (and current behavior) 
really is and what should be documented. Should we maybe really only 
care about "real" swap entries?

Most probably I'm just missing something important.

> +
>   /*
>    * Parameter block passed down to zap_pte_range in exceptional cases.
>    */
>   struct zap_details {
>   	struct address_space *zap_mapping;	/* Check page->mapping if set */
>   	struct page *single_page;		/* Locked page to be unmapped */
> +	zap_flags_t zap_flags;			/* Extra flags for zapping */
>   };
>   
>   /*
> @@ -1737,6 +1743,16 @@ zap_skip_check_mapping(struct zap_details *details, struct page *page)
>   	return details->zap_mapping != page_rmapping(page);
>   }
>   
> +/* Return true if skip swap entries, false otherwise */
> +static inline bool
> +zap_skip_swap(struct zap_details *details)
> +{
> +	if (!details)
> +		return false;
> +
> +	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> +}
> +
>   struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>   			     pte_t pte);
>   struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index e5ee8399d270..4cb269ca8249 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1379,8 +1379,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>   			continue;
>   		}
>   
> -		/* If details->check_mapping, we leave swap entries. */
> -		if (unlikely(details))
> +		if (unlikely(zap_skip_swap(details)))
>   			continue;
>   
>   		if (!non_swap_entry(entry))
> @@ -3351,6 +3350,7 @@ void unmap_mapping_page(struct page *page)
>   	first_index = page->index;
>   	last_index = page->index + thp_nr_pages(page) - 1;
>   
> +	/* Keep ZAP_FLAG_SKIP_SWAP cleared because we're truncating */
>   	details.zap_mapping = mapping;
>   	details.single_page = page;
>   
> @@ -3377,7 +3377,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>   		pgoff_t nr, bool even_cows)
>   {
>   	pgoff_t	first_index = start, last_index = start + nr - 1;
> -	struct zap_details details = { };
> +	struct zap_details details = { .zap_flags = ZAP_FLAG_SKIP_SWAP };
>   
>   	details.zap_mapping = even_cows ? NULL : mapping;
>   	if (last_index < first_index)
> 

I think what would really help is to add a high-level description what 
unmap_mapping_page() vs. unmap_mapping_pages() really does, and what the 
expectations/use cases are. The names are just way too similar ...

I wonder if it would make sense to split this into two parts

a) Introduce ZAP_FLAG_SKIP_SWAP and use it accordingly for existing cases
b) Stop setting it for unmap_mapping_page()

So we'd have the change in behavior isolated. But not sure if it's worth 
the trouble, especially if we want to backport the fix ...

-- 
Thanks,

David / dhildenb

