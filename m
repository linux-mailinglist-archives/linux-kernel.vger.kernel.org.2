Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4363F7139
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhHYIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhHYIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629881000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbsXMyTovfUKWZOEFQO3h1qOrrlv91veJJTI8bsXjsw=;
        b=OeUwpkb2grkVyfwlWigCTz9EASnD1Rs+CjmPEBFaKA+DMG3QTCOM2xvMQehfjAGFZmAI47
        JVI5qPFLKTEslLXk9Yn04g3nln+LOlfs32cz7OUIkB1ISkqebD//2JH5Kx5HnJXEJjkOWc
        2KYNVSyws07IrosjUif5YBthfk9Aovs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-i10m7SSoNVmN-F0AWR5Egw-1; Wed, 25 Aug 2021 04:43:17 -0400
X-MC-Unique: i10m7SSoNVmN-F0AWR5Egw-1
Received: by mail-wm1-f69.google.com with SMTP id o20-20020a05600c379400b002e755735eedso1709268wmr.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CbsXMyTovfUKWZOEFQO3h1qOrrlv91veJJTI8bsXjsw=;
        b=Ks2wDdYFcncbxiZZKPae0vsAuvo48yzhZMtEc0Gfm7wPwrYWZd8Dzs0C1ooFjDoROw
         1e3EB0uNGd+JLTKIsgtokLMRHbyLFhmYKuEOroidQfJppzMqoI7o6vCK5KGQ75LB1J1/
         b7zLWUzBadDIArrklp/jYFCXybJGDW393V3H56xWZElxnXDZpYy5gqvsi3PrW4Q0bc3i
         2zusBEB+GozsdVQ+Avm/vbCdylh3sha5rctSzKwGlYtsDQ3f6EYms5MIdMl2Jd7rO88W
         uZs3X0jbwIbAKcPxll7yGand0KqEtCcc+DBNIdO+H6LnFWsW6cT4WCjUj17mthGjJIhl
         T+qA==
X-Gm-Message-State: AOAM5333tE3hDmhf6rUxRMijVI+d5pmg8VeVA2BhWAGHOxBKKlRGrNOe
        2geV2BIb1ewlXadkjOf1EZGm7hHHZYPLotcMntS1uYPY4aNEN8tvk436IyeNpCB10zs9txtVcTA
        KOBFnjATjbETIYC3FIIKUJY6KidggK5MgrH2sKlEoiKWyikR8lTzbwMlCsWpvbR/1PPQtn7dl
X-Received: by 2002:adf:c44b:: with SMTP id a11mr23568478wrg.416.1629880996050;
        Wed, 25 Aug 2021 01:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUyD1KLk0iI2jPyHl9GDFe6jSrc1gBZb/3vUsGD54fVrtirIG5zJq0Teb+VGu/hRxrzQ1gSg==
X-Received: by 2002:adf:c44b:: with SMTP id a11mr23568447wrg.416.1629880995860;
        Wed, 25 Aug 2021 01:43:15 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id k18sm4619837wmi.25.2021.08.25.01.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 01:43:15 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag to
 allocate pte-mapped pages
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0a6341d6-c5be-ade3-9fb9-66cc8ebe1619@redhat.com>
Date:   Wed, 25 Aug 2021 10:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823132513.15836-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.21 15:25, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> When __GFP_PTE_MAPPED flag is passed to an allocation request of order 0,
> the allocated page will be mapped at PTE level in the direct map.
> 
> To reduce the direct map fragmentation, maintain a cache of 4K pages that
> are already mapped at PTE level in the direct map. Whenever the cache
> should be replenished, try to allocate 2M page and split it to 4K pages
> to localize shutter of the direct map. If the allocation of 2M page fails,
> fallback to a single page allocation at expense of the direct map
> fragmentation.
> 
> The cache registers a shrinker that releases free pages from the cache to
> the page allocator.
> 
> The __GFP_PTE_MAPPED and caching of 4K pages are enabled only if an
> architecture selects ARCH_WANTS_PTE_MAPPED_CACHE in its Kconfig.
> 
> [
> cache management are mostly copied from
> https://lore.kernel.org/lkml/20210505003032.489164-4-rick.p.edgecombe@intel.com/
> ]
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/Kconfig                    |   8 +
>   arch/x86/Kconfig                |   1 +
>   include/linux/gfp.h             |  11 +-
>   include/linux/mm.h              |   2 +
>   include/linux/pageblock-flags.h |  26 ++++
>   init/main.c                     |   1 +
>   mm/internal.h                   |   3 +-
>   mm/page_alloc.c                 | 261 +++++++++++++++++++++++++++++++-
>   8 files changed, 309 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 129df498a8e1..2db95331201b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -243,6 +243,14 @@ config ARCH_HAS_SET_MEMORY
>   config ARCH_HAS_SET_DIRECT_MAP
>   	bool

[...]

> +static int __pte_mapped_cache_init(struct pte_mapped_cache *cache)
> +{
> +	int err;
> +
> +	err = list_lru_init(&cache->lru);
> +	if (err)
> +		return err;
> +
> +	cache->shrinker.count_objects = pte_mapped_cache_shrink_count;
> +	cache->shrinker.scan_objects = pte_mapped_cache_shrink_scan;
> +	cache->shrinker.seeks = DEFAULT_SEEKS;
> +	cache->shrinker.flags = SHRINKER_NUMA_AWARE;
> +
> +	err = register_shrinker(&cache->shrinker);
> +	if (err)
> +		goto err_list_lru_destroy;

With a shrinker in place, it really does somewhat feel like this should 
be a cache outside of the buddy. Or at least moved outside of 
page_alloc.c with a clean interface to work with the buddy.

But I only had a quick glimpse over this patch.

-- 
Thanks,

David / dhildenb

