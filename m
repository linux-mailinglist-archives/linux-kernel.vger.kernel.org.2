Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AE93733AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhEEB5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhEEB5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620179764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcTx3FgEa0ZtpV+h7gNoIIwMYnfs3k07HI6rrP4pOSc=;
        b=COprRlNYztG4D6fmRj4XbVBo1xqIMaa1V9HNtVvh+2S3W+3Se1SaTqz2MNpDHWpsW/PURo
        fjurJRG2+45Db0PlsrJjkas7LBdyteR3a2Ovpd0OSiTd/2+eMwTQeLaOwl7A1mhilHaNo6
        eAzGUlHmFgxBGRz5L6MaEZ7qgkNNUOg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-0HnL2xUGN0S7S2pewu66kw-1; Tue, 04 May 2021 21:56:02 -0400
X-MC-Unique: 0HnL2xUGN0S7S2pewu66kw-1
Received: by mail-qk1-f199.google.com with SMTP id i141-20020a379f930000b02902e94f6d938dso147624qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 18:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XcTx3FgEa0ZtpV+h7gNoIIwMYnfs3k07HI6rrP4pOSc=;
        b=cVdrSc+Xj0X2rrwkWnDQvPpcoOqiKwgebJ0PP9klEYFP9tEWy5B6D3mtqhZYBkia3N
         i5B6M+AMqggT0XODZiNbhU+RnMWkfn1UZlWpIgy99OqIYhlfSN1MUOC+aTa7xWRO5OyS
         uWmor9KaL4Pt+1GoqPPCLKi2GQyZo6hPYFWRK7e1qQqQrtq5CmI39ehp8ryjE0udiINn
         X/f7SQRM39LtsPKKQPY9RRzYyULfjoVW8IEueBJjxmQbjf7ZL0PRUyxtHNwavbqtgdl5
         KE/Hbb8nPVZi78fPPXXsu9BRFQ0sK3CDZ9lVHgwTLW6s9et8titiLOpH9x3Vrv1qEROn
         Y9Zg==
X-Gm-Message-State: AOAM5300FR1RTp9UccbBgDe5g2ghsPBH9ropEGWohvw5rQ1NiQq2/crR
        gupR2YIFQEFt5swO0ffCt62+riiuuNq75QDLj5DWNwSKV9GglsJPbO+j8xh+nxdwgeKCa1AEl3Q
        oIJ+41j1mGpNnGE00Q297s8yp
X-Received: by 2002:a37:e50e:: with SMTP id e14mr27252305qkg.117.1620179762284;
        Tue, 04 May 2021 18:56:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8nWHVpb0cB/gzpuUMahqkiBpXMCaKBzc/pJJj7x33T7XaCXGRPc33nYRKs0lPFew7O9UEJw==
X-Received: by 2002:a37:e50e:: with SMTP id e14mr27252286qkg.117.1620179762020;
        Tue, 04 May 2021 18:56:02 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id o189sm12603642qkd.60.2021.05.04.18.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 18:56:01 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210504132350.4693-1-longman@redhat.com>
 <20210504132350.4693-3-longman@redhat.com>
 <3c952b24-94e4-3c54-b668-cac778ff5a77@suse.cz>
Message-ID: <26ef8e5d-3a72-324f-4ef9-ead8c6251e70@redhat.com>
Date:   Tue, 4 May 2021 21:55:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3c952b24-94e4-3c54-b668-cac778ff5a77@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/21 12:01 PM, Vlastimil Babka wrote:
> On 5/4/21 3:23 PM, Waiman Long wrote:
>> There are currently two problems in the way the objcg pointer array
>> (memcg_data) in the page structure is being allocated and freed.
>>
>> On its allocation, it is possible that the allocated objcg pointer
>> array comes from the same slab that requires memory accounting. If this
>> happens, the slab will never become empty again as there is at least
>> one object left (the obj_cgroup array) in the slab.
>>
>> When it is freed, the objcg pointer array object may be the last one
>> in its slab and hence causes kfree() to be called again. With the
>> right workload, the slab cache may be set up in a way that allows the
>> recursive kfree() calling loop to nest deep enough to cause a kernel
>> stack overflow and panic the system.
>>
>> One way to solve this problem is to split the kmalloc-<n> caches
>> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
>> (KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
>> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
>> the other caches can allow a mix of accounted and non-accounted objects.
>>
>> With this change, all the objcg pointer array objects will come from
>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>> both the recursive kfree() problem and non-freeable slab problem
>> are gone.
>>
>> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
>> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
>> will include the newly added caches without change.
> Great, thanks I hope there would be also benefits to objcg arrays not
> created for all the normal caches anymore (possibly poorly used due to
> mix of accounted and non-accounted objects in the same cache) and perhaps
> it's possible for you to quantify the reduction of those?
Right, I will update the commit log to mention that as well. Thanks!
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> ...
>
>> @@ -321,6 +328,14 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>>   
>>   static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>>   {
>> +#ifdef CONFIG_MEMCG_KMEM
>> +	/*
>> +	 * KMALLOC_CGROUP for non-reclaimable and non-DMA object with
>> +	 * accounting enabled.
>> +	 */
>> +	if ((flags & (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)) == __GFP_ACCOUNT)
>> +		return KMALLOC_CGROUP;
>> +#endif
> This function was designed so that KMALLOC_NORMAL would be the first tested and
> returned possibility, as it's expected to be the most common. What about the
> following on top?
>
> ----8<----
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index fca03c22ea7c..418c5df0305b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -328,30 +328,40 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>   
>   static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>   {
> -#ifdef CONFIG_MEMCG_KMEM
>   	/*
> -	 * KMALLOC_CGROUP for non-reclaimable and non-DMA object with
> -	 * accounting enabled.
> +	 * The most common case is KMALLOC_NORMAL, so test for it
> +	 * with a single branch for all flags that might affect it
>   	 */
> -	if ((flags & (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)) == __GFP_ACCOUNT)
> -		return KMALLOC_CGROUP;
> +	if (likely((flags & (__GFP_RECLAIMABLE
> +#ifdef CONFIG_MEMCG_KMEM
> +			     | __GFP_ACCOUNT
>   #endif
>   #ifdef CONFIG_ZONE_DMA
> -	/*
> -	 * The most common case is KMALLOC_NORMAL, so test for it
> -	 * with a single branch for both flags.
> -	 */
> -	if (likely((flags & (__GFP_DMA | __GFP_RECLAIMABLE)) == 0))
> +			     | __GFP_DMA
> +#endif
> +			    )) == 0))
>   		return KMALLOC_NORMAL;
>   
> +#ifdef CONFIG_MEMCG_KMEM
>   	/*
> -	 * At least one of the flags has to be set. If both are, __GFP_DMA
> -	 * is more important.
> +	 * KMALLOC_CGROUP for non-reclaimable and non-DMA object with
> +	 * accounting enabled.
>   	 */
> -	return flags & __GFP_DMA ? KMALLOC_DMA : KMALLOC_RECLAIM;
> -#else
> -	return flags & __GFP_RECLAIMABLE ? KMALLOC_RECLAIM : KMALLOC_NORMAL;
> +	if ((flags & (__GFP_ACCOUNT | __GFP_RECLAIMABLE
> +#ifdef CONFIG_ZONE_DMApropose this to the customer as proposing this will create a lot of confusion
> +		      | __GFP_DMA
> +#endif
> +		     )) == __GFP_ACCOUNT)
> +		return KMALLOC_CGROUP;
>   #endif
> +
> +#ifdef CONFIG_ZONE_DMA
> +	if (flags & __GFP_DMA)
> +		return KMALLOC_DMA;
> +#endif
> +
> +	/* if we got here, it has to be __GFP_RECLAIMABLE */
> +	return KMALLOC_RECLAIM;
>   }
>   
>   /*
>
OK, I will make KMALLOC_NORMAL the first in the test. However the 
proposed change is a bit hard to read, so I will probably change it a bit.

Thanks,
Longman

