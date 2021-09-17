Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985640F467
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245501AbhIQItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235322AbhIQItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631868478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcuAPbm9xw3yksCit77EG+81MmjR4Nbi9Tedl5nxVZs=;
        b=FntBswwKecE7nH4oiznjG3rwD6OkLYAGZftya4VOolW52lePqlsvnXvj69iSumKFJ2E9HG
        kyn307JUVXvaDs11ltFiglUU1uTEjX3Kh3KifLP6Q+uNX9x5zENTsYtjpD5EQF5QnZ8khZ
        N6nTHj/4GgHitCujgJB6BzxZv3XpE7U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-WPixiiMlNN--xDfw-dpQgw-1; Fri, 17 Sep 2021 04:47:56 -0400
X-MC-Unique: WPixiiMlNN--xDfw-dpQgw-1
Received: by mail-wm1-f72.google.com with SMTP id n30-20020a05600c3b9e00b002fbbaada5d7so3462779wms.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wcuAPbm9xw3yksCit77EG+81MmjR4Nbi9Tedl5nxVZs=;
        b=07PjUYGC5oKMhNvcYg28SBw+nowVJHSK/zO6BaxxHgaYLdD4nNSwr33pp9WAsiZl0F
         78LpnxORkMhtX7+lLzVL1k+H9ZhI38yF9EO+i/rTuxBv8Wg99M7OdndyiPr8Y/cs5aLX
         8P/gqzFUR1RLA+QLj+41PL+JXzqxFUbzO0Yrj02NxF3JOibMcSMcloes/GLnjl3CnT4B
         JLR5eoqJGU8EjWK5ez7yQ7/oClsCqfO0ksaoIaH2rRpayPGXnPpVhHghhMD1A656LEmy
         5cDUUW81k9w88sQlIoeWc2YA+Lgu6uqw5Cggo/PtAfg3ZgSWzPLblAj2IhMl3+RmiUVb
         k3Hw==
X-Gm-Message-State: AOAM53043rkM4+Qp/sA/3PGMalZbK+OJ1VW0NpVEKvq+knGuRjpaLvwF
        Hpc20C2gZrNyPZG7yyo5OVjIxgSgKWR2qMSxfO53oKum1uxNJnHnQru6f/1NjbWALzGGay/tndY
        0HqGT72Pu2tH4I6AzDML0P3iG
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr10694161wrs.26.1631868475621;
        Fri, 17 Sep 2021 01:47:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybao8lYYRsgqWQpVjn5+Se3mBigm2FdtvAQE8Fl/F+9zEOtBbl/e5Gt5erJhx/kHtztbs+yA==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr10694132wrs.26.1631868475343;
        Fri, 17 Sep 2021 01:47:55 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c655a.dip0.t-ipconnect.de. [91.12.101.90])
        by smtp.gmail.com with ESMTPSA id g1sm6061083wrr.2.2021.09.17.01.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 01:47:54 -0700 (PDT)
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
 <20210916193403.GA1940@pc638.lan>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
Message-ID: <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
Date:   Fri, 17 Sep 2021 10:47:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916193403.GA1940@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This patch looks like a KASAN specific to me. So i would like to avoid
>>> such changes to
>>> the vmalloc internals in order to simplify further maintenance and
>>> keeping it generic
>>> instead.
>>
>> There is nothing KASAN specific in there :) It's specific to exact
>> applications -- and KASAN may be one of the only users for now.
>>
> Well, you can name it either way :) So it should not be specific by the
> design, otherwise as i mentioned the allocator would be like a peace of
> code that handles corner cases what is actually not acceptable.

Let's not overstress the situation of adding essentially 3 LOC in order 
to fix a sane use case of the vmalloc allocator that was not considered 
properly by internal changes due to 68ad4a330433 ("mm/vmalloc.c: keep 
track of free blocks for vmap allocation").

> 
>>>
>>> Currently the find_vmap_lowest_match() adjusts the search size
>>> criteria for any alignment
>>> values even for PAGE_SIZE alignment. That is not optimal. Because a
>>> PAGE_SIZE or one
>>> page is a minimum granularity we operate on vmalloc allocations thus
>>> all free blocks are
>>> page aligned.
>>>
>>> All that means that we should adjust the search length only if an
>>> alignment request is bigger than
>>> one page, in case of one page, that corresponds to PAGE_SIZE value,
>>> there is no reason in such
>>> extra adjustment because all free->va_start have a page boundary anyway.
>>>
>>> Could you please test below patch that is a generic improvement?
>>
>> I played with the exact approach below (almost exactly the same code in
>> find_vmap_lowest_match()), and it might make sense as a general improvement
>> -- if we can guarantee that start+end of ranges are always PAGE-aligned; I
>> was not able to come to that conclusion...
> All free blocks are PAGE aligned that is how it has to be. A vstart also
> should be aligned otherwise the __vunmap() will complain about freeing
> a bad address:
> 
> <snip>
>      if (WARN(!PAGE_ALIGNED(addr), "Trying to vfree() bad address (%p)\n",
>              addr))
>          return;
> <snip>
> 
> BTW, we should add an extra check to the alloc_vmap_area(), something like
> below:
> 
> <snip>
>      if (!PAGE_ALIGNED(ALIGN(vstart, align))) {
>          WARN_ONCE(1, "vmalloc: vstart or align are not page aligned (0x%lx, 0x%lx)\n",
>              vstart, align);
>          return ERR_PTR(-EBUSY);
> 	}
> <snip>
> 
> to check that passed pair of vstart and align are correct.
> 

Yes we better should.

>>
>> vmap_init_free_space() shows me that our existing alignment code/checks
>> might be quite fragile.
>>
> It is not important to page align a first address. As i mentioned before
> vstart and align have to be correct and we should add such check.
> 
>>
>> But I mainly decided to go with my patch instead because it will also work
>> for exact allocations with align > PAGE_SIZE: most notably, when we try
>> population of hugepages instead of base pages in __vmalloc_node_range(), by
>> increasing the alignment. If the exact range allows for using huge pages,
>> placing huge pages will work just fine with my modifications, while it won't
>> with your approach.
>>
>> Long story short: my approach handles exact allocations also for bigger
>> alignment, Your optimization makes sense as a general improvement for any
>> vmalloc allocations.
>>
>> Thanks for having a look!
>>
> The problem is that there are no users(seems only KASAN) who set the range
> that corresponds to exact size. If you add an aligment overhead on top of

So there is one user and it was broken by 68ad4a330433 ("mm/vmalloc.c: 
keep track of free blocks for vmap allocation").

> it means that search size should include it because we may end up with exact
> free block and after applying aligment it will not fit. This is how allocators
> handle aligment.

This is an implementation detail of the vmalloc allocator ever since 
68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap 
allocation").

If callers pass an exact range, and the alignment they specify applies, 
why should we reject such an allocation? It's leaking an implementation 
detail fixed easily internally into callers.

> 
> Another approach is(you mentioned it in your commit message):
> 
> urezki@pc638:~/data/raid0/coding/linux-next.git$ git diff mm/kasan/shadow.c
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 082ee5b6d9a1..01d3bd76c851 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -200,7 +200,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>                  if (shadow_mapped(shadow_start))
>                          return NOTIFY_OK;
>   
> -               ret = __vmalloc_node_range(shadow_size, PAGE_SIZE, shadow_start,
> +               ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
>                                          shadow_end, GFP_KERNEL,
>                                          PAGE_KERNEL, VM_NO_GUARD,
>                                          pfn_to_nid(mem_data->start_pfn),
> urezki@pc638:~/data/raid0/coding/linux-next.git$
> 
> why not? Also you can increase the range in KASAN code.

No, that's leaking implementation details to the caller. And no, 
increasing the range and eventually allocating something bigger (e.g., 
placing a huge page where it might not have been possible) is not 
acceptable for KASAN.

If you're terribly unhappy with this patch, please suggest something 
reasonable to fix exact allocations:
a) Fixes the KASAN use case.
b) Allows for automatic placement of huge pages for exact allocations.
c) Doesn't leak implementation details into the caller.

Thanks

-- 
Thanks,

David / dhildenb

