Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8776041701B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbhIXKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245488AbhIXKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632478279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CCJWmEkOKRF8YEuH0GEFrZjGS+trpPLyEMqqAo/hqo=;
        b=IIplvRp8Icym7zzRs3uDgvIe9RyTCS9OS/EL4NU1YZ4s9YeXwjCAn4v9ol/EPHHj8B+SnV
        sNPJ4CfMQuN6OCUlL8EZ7iQJCicJVMKJcj4UOpP3RoQtwXJszWoHwyYdTg2q+3K83+vv4c
        r1CJMzTNxwpfVQeQxALiBbzwgPotG2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-qwCqLmh2Opa9CnnPak5VEw-1; Fri, 24 Sep 2021 06:11:18 -0400
X-MC-Unique: qwCqLmh2Opa9CnnPak5VEw-1
Received: by mail-wr1-f72.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so7643351wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 03:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/CCJWmEkOKRF8YEuH0GEFrZjGS+trpPLyEMqqAo/hqo=;
        b=Umw6d/WCTtAw2oMOIr0L0PoX/hJwqop4drYbrHKZS6aVR36IXJHEdrzi/otGSuqxFA
         O3wdQWzQ1rqkiapOjWl1U8LBFm7uhBS9Tcy5y+zrRahY4B15ykS37sIynunIihBXRQ+Q
         806nfK+6ojVvm0gBH9lwIaKURLd8IXmYZLdrO+zru54x9SfL/Mxxn1bQO4FvcS9pm8J4
         tb8p4HCwTE+GBSUNCXBWq4XwM82KrShrKjjJOVNFY6g5qIsXj7pQhrrtxu7q8VYap4fh
         CoVTmBhdophfYfIfwhWgcg4N5IkqiHy+eRTjdKz2osyVF6L1aBhrnqY627G2dTaSXTYB
         0czg==
X-Gm-Message-State: AOAM533hEFq54e+UKVYZJJR47v2D1iQznY23Nc7FfZfUJFlIQ7ySDySq
        KUvuvAGqI0QSdWP6H3drcjGfMOc8+5DMM/Z4NJwBoUmr13pN6sOrEcdr/i8lu5RdFzFxIobKPpk
        CYPo81tjxnr7LPHUxuuU+oO/8
X-Received: by 2002:adf:e30d:: with SMTP id b13mr10469245wrj.438.1632478277221;
        Fri, 24 Sep 2021 03:11:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI2MmdDtWgYWK7tqU5QWe0PLlYrgQvbJr7j8j/MPpSSLuqsdwiXXXKfUh50RCbadioWrL+zg==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr10469221wrj.438.1632478277057;
        Fri, 24 Sep 2021 03:11:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id i9sm12457009wmi.44.2021.09.24.03.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 03:11:16 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] mm: Add zap_skip_check_mapping() helper
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210915181456.10739-1-peterx@redhat.com>
 <20210915181538.11288-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <12fa0797-05ea-aede-eeae-826133f03499@redhat.com>
Date:   Fri, 24 Sep 2021 12:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210915181538.11288-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.21 20:15, Peter Xu wrote:
> Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
> because "check_mapping" looks like a bool but in fact it stores the mapping
> itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
> cleared we skip the check, which works like the old way.
> 
> Move the duplicated comments to the helper too.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/mm.h | 16 +++++++++++++++-
>   mm/memory.c        | 29 ++++++-----------------------
>   2 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d1126f731221..ed44f31615d9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1721,10 +1721,24 @@ extern void user_shm_unlock(size_t, struct ucounts *);
>    * Parameter block passed down to zap_pte_range in exceptional cases.
>    */
>   struct zap_details {
> -	struct address_space *check_mapping;	/* Check page->mapping if set */
> +	struct address_space *zap_mapping;	/* Check page->mapping if set */
>   	struct page *single_page;		/* Locked page to be unmapped */
>   };
>   
> +/*
> + * We set details->zap_mappings when we want to unmap shared but keep private
> + * pages. Return true if skip zapping this page, false otherwise.
> + */
> +static inline bool
> +zap_skip_check_mapping(struct zap_details *details, struct page *page)

I agree with Hugh that the name of this helper is suboptimal.

What about inverting the conditions and getting

static inline bool should_zap_page()
{
...
}

The calling code is then

if (unlikely(!should_zap_page(details, page)))
	continue;


I don't really like renaming "zap_mapping", again, because it's 
contained within "struct zap_details" already.

Factoring this out into a helper sounds like a good idea to me. Clear 
case of code de-duplication.

-- 
Thanks,

David / dhildenb

