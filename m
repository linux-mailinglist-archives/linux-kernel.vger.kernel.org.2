Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719023FEDA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbhIBMRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234142AbhIBMRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630584979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KB5SyFwwSjd3I7RFdLEADuQgZugol7EKe1fCuJWPl0=;
        b=DZR299q5fQz8LPzs6zZuZwTAlkSs58H9rGeFd1QGe1cGfZbJ9g/3+bWAgexPo9+Pd4TPbE
        kAsqglWsRpqxR8Z8JKloDgn8HNgjzpHkV2OT3CRUXl+pcUXla3JNYut8iEH0ESGKk5P1Y1
        jnewhODo7q35q+IY/SZBmMMZ1nFuqoo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-XQPQ0pVVMgmrFpNlI9ENAw-1; Thu, 02 Sep 2021 08:16:18 -0400
X-MC-Unique: XQPQ0pVVMgmrFpNlI9ENAw-1
Received: by mail-wm1-f69.google.com with SMTP id y188-20020a1c7dc5000000b002e80e0b2f87so931018wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0KB5SyFwwSjd3I7RFdLEADuQgZugol7EKe1fCuJWPl0=;
        b=jZk3TqaOFaoKodLJhaSUtO+sY3t7wzXSniqdcFRKiiP+kxE2L/vl/GiFReUJaIkX+/
         XEQkyX/9hrFh/9Phi1gHZZ1xwQy77a6bC2BvUbRVT9nVLNoq+i5ESgpqTnbwk+jYMUXE
         /j7IKLwHdjI4FcqgBDmFMQwwuPL5Cx9DyN9OimOv26KAI46LBB7DQroBtMfTOSatnPyF
         5mZXIYalKVMITUlUZ513uKvqHijOkZCwFUJcs8cgD49TmlqSYGjFAttNoeBxdOk0WkNO
         iNynR1xaJpOg559xLVBtUKJTA4M61KKVZQAKAeF5iVZi5R0SEbApqxEHCp3BYLrs9ELU
         Vw2Q==
X-Gm-Message-State: AOAM530b46wTc7dJNa7H0ZlawBkza1uauExj83lPtnu44db6xT+7NM2h
        ePrnrQfucuOmRS4Yk3m0WJvQHLHYCoDMxVJorkxXsOBvlj5ynDf8h2fAk6IuCEcaQgib214kYuW
        RArkt1ZWLIvHzeLd8tCoqRDmj711a9kwjNchX7b2CjQpvoHZJWAc3lnVmlbsbWl7C05rDclZl
X-Received: by 2002:a5d:6781:: with SMTP id v1mr3393720wru.249.1630584977473;
        Thu, 02 Sep 2021 05:16:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxLVdMLy9E2mqTLvOGLjmzD7yZiwY5dVGzMc0woHfMYLZKh3OehsTEMsYjvAj3cc5ucR6Ohg==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr3393681wru.249.1630584977132;
        Thu, 02 Sep 2021 05:16:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60bd.dip0.t-ipconnect.de. [91.12.96.189])
        by smtp.gmail.com with ESMTPSA id k16sm1722414wrx.87.2021.09.02.05.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:16:16 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] mm/page_alloc.c: avoid allocating highmem pages
 via alloc_pages_exact[_nid]
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     vbabka@suse.cz, sfr@canb.auug.org.au, peterz@infradead.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210902121242.41607-1-linmiaohe@huawei.com>
 <20210902121242.41607-6-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1ef3dc5d-7eb9-90a5-afbf-f551afcf7d8b@redhat.com>
Date:   Thu, 2 Sep 2021 14:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902121242.41607-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.21 14:12, Miaohe Lin wrote:
> Don't use with __GFP_HIGHMEM because page_address() cannot represent
> highmem pages without kmap(). Newly allocated pages would leak as
> page_address() will return NULL for highmem pages here. But It works
> now because the callers do not specify __GFP_HIGHMEM now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9c09dcb24149..e1d0e27d005a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5614,8 +5614,8 @@ void *alloc_pages_exact(size_t size, gfp_t gfp_mask)
>   	unsigned int order = get_order(size);
>   	unsigned long addr;
>   
> -	if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
> -		gfp_mask &= ~__GFP_COMP;
> +	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
> +		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
>   
>   	addr = __get_free_pages(gfp_mask, order);
>   	return make_alloc_exact(addr, order, size);
> @@ -5639,8 +5639,8 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask)
>   	unsigned int order = get_order(size);
>   	struct page *p;
>   
> -	if (WARN_ON_ONCE(gfp_mask & __GFP_COMP))
> -		gfp_mask &= ~__GFP_COMP;
> +	if (WARN_ON_ONCE(gfp_mask & (__GFP_COMP | __GFP_HIGHMEM)))
> +		gfp_mask &= ~(__GFP_COMP | __GFP_HIGHMEM);
>   
>   	p = alloc_pages_node(nid, gfp_mask, order);
>   	if (!p)
> 

Ideally we would convert this WARN_ON_ONCE() to pr_warn_once(), but I 
guess this really never ever happens on a production system and would 
get caught early while testing.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

