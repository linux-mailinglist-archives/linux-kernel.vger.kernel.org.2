Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B17E40C253
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhIOJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236974AbhIOJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631696557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mY4h2aG9XtMeGPKwGwD1cy8ROHMlsAc1FuQDh1xnvRM=;
        b=H9U3LXENs3ZniPSpfV2a/pYOj36JeaaK2dwM4YKonwDFv8d9/uwdOeBbAFF2vRjyOqjUXH
        Q9xqn00OhXYc7QEifN9hD1oaYHDnaxVKE0zfrg22vKm9QK08lqVSp2Ul/qlrG9jKAi+wyI
        vn0pml0qOwcv6LCeLSVLDMB9F3Yh2j4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-HJxDO9g8OISpjufEFyavig-1; Wed, 15 Sep 2021 05:02:36 -0400
X-MC-Unique: HJxDO9g8OISpjufEFyavig-1
Received: by mail-wr1-f69.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so748869wrq.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mY4h2aG9XtMeGPKwGwD1cy8ROHMlsAc1FuQDh1xnvRM=;
        b=sgwTFwhWfUtNL2ysDQXDQWG5bjTyimtDKk1GFudKAsGZLUZT6eLaJkYmUSdZI2VoN9
         S6t4nGcw6347M14LJ52/lx4x2kO3Sk0FuisIKtirASiqGTqyM4jWPmBFEity6T2Sl6Zh
         PARK14S0i7aIwWyZ0MkNkCzRopHvGm7aeWT6kv517QMubc7s8qcHMCfVAoAFwIQRA4YO
         Qi7M53JUhnKX3RHEF77jQgY1jH6Vxmnz6yWohquIUf+KZkAmcWlAwOSax8d5yJWhSVqG
         5tQuPtBlZ/LS5qOrE9/m7VLOfljhlwOxQdaFQQ1z8Kn1ck10s6FSLPsw1PSmLKTIgS49
         rzcA==
X-Gm-Message-State: AOAM532jNULdlmFcR8SAJ749tLtkqf0VQiXaCJ353cgkoZx6GoorW5sa
        GwH02+uRh9h6bV2EIZIWbyG/V1WY6fWFYxEVB1usuHFFwIYcxzHlGB5U6Eyqh+0+26ZDKoIxSlS
        GhVRG224FKI3dDRYdV2Im0zYd
X-Received: by 2002:adf:f805:: with SMTP id s5mr3592037wrp.259.1631696554996;
        Wed, 15 Sep 2021 02:02:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYdOiJ6qcR8qALeWqyxvS4VTF90fFVR10jgDaUPVNm62GAiD3X2n58EK2ieHPNA4onD3hyLA==
X-Received: by 2002:adf:f805:: with SMTP id s5mr3591988wrp.259.1631696554620;
        Wed, 15 Sep 2021 02:02:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6426.dip0.t-ipconnect.de. [91.12.100.38])
        by smtp.gmail.com with ESMTPSA id n26sm3385297wmi.43.2021.09.15.02.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 02:02:34 -0700 (PDT)
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
Message-ID: <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
Date:   Wed, 15 Sep 2021 11:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.21 21:15, Uladzislau Rezki wrote:
>> Let me have a look at it.
>>
>> Vlad Rezki
>>
>> On Wed, Sep 8, 2021 at 3:27 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> find_vmap_lowest_match() is imprecise such that it won't always
>>> find "the first free block ... that will accomplish the request" if
>>> an alignment > 1 was specified: especially also when the alignment is
>>> PAGE_SIZE. Unfortuantely, the way the vmalloc data structures were
>>> designed, propagating the max size without alignment information through
>>> the tree, it's hard to make it precise again when an alignment > 1 is
>>> specified.
>>>
>>> The issue is that in order to be able to eventually align later,
>>> find_vmap_lowest_match() has to search for a slightly bigger area and
>>> might skip some applicable subtrees just by lookign at the result of
>>> get_subtree_max_size(). While this usually doesn't matter, it matters for
>>> exact allocations as performed by KASAN when onlining a memory block,
>>> when the free block exactly matches the request.
>>> (mm/kasn/shadow.c:kasan_mem_notifier()).
>>>
>>> In case we online memory blocks out of order (not lowest to highest
>>> address), find_vmap_lowest_match() with PAGE_SIZE alignment will reject
>>> an exact allocation if it corresponds exactly to a free block. (there are
>>> some corner cases where it would still work, if we're lucky and hit the
>>> first is_within_this_va() inside the while loop)
>>>
>>> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory82/state
>>> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory83/state
>>> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory85/state
>>> [root@vm-0 fedora]# echo online > /sys/devices/system/memory/memory84/state
>>> [  223.858115] vmap allocation for size 16777216 failed: use vmalloc=<size> to increase size
>>> [  223.859415] bash: vmalloc: allocation failure: 16777216 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
>>> [  223.860992] CPU: 4 PID: 1644 Comm: bash Kdump: loaded Not tainted 4.18.0-339.el8.x86_64+debug #1
>>> [  223.862149] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>> [  223.863580] Call Trace:
>>> [  223.863946]  dump_stack+0x8e/0xd0
>>> [  223.864420]  warn_alloc.cold.90+0x8a/0x1b2
>>> [  223.864990]  ? zone_watermark_ok_safe+0x300/0x300
>>> [  223.865626]  ? slab_free_freelist_hook+0x85/0x1a0
>>> [  223.866264]  ? __get_vm_area_node+0x240/0x2c0
>>> [  223.866858]  ? kfree+0xdd/0x570
>>> [  223.867309]  ? kmem_cache_alloc_node_trace+0x157/0x230
>>> [  223.868028]  ? notifier_call_chain+0x90/0x160
>>> [  223.868625]  __vmalloc_node_range+0x465/0x840
>>> [  223.869230]  ? mark_held_locks+0xb7/0x120
>>>
>>> While we could fix this in kasan_mem_notifier() by passing an alignment
>>> of "1", this is actually an implementation detail of vmalloc and to be
>>> handled internally.
>>>
>>> So use an alignment of 1 when calling find_vmap_lowest_match() for exact
>>> allocations that are expected to succeed -- if the given range can
>>> satisfy the alignment requirements.
>>>
>>> Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
>>> Reported-by: Ping Fang <pifang@redhat.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>> Cc: Roman Gushchin <guro@fb.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: linux-mm@kvack.org
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   mm/vmalloc.c | 13 +++++++++++--
>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index d5cd52805149..c6071f5f8de3 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -1153,7 +1153,8 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
>>>   /*
>>>    * Find the first free block(lowest start address) in the tree,
>>>    * that will accomplish the request corresponding to passing
>>> - * parameters.
>>> + * parameters. Note that with an alignment > 1, this function
>>> + * can be imprecise and skip applicable free blocks.
>>>    */
>>>   static __always_inline struct vmap_area *
>>>   find_vmap_lowest_match(unsigned long size,
>>> @@ -1396,7 +1397,15 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>>>          enum fit_type type;
>>>          int ret;
>>>
>>> -       va = find_vmap_lowest_match(size, align, vstart);
>>> +       /*
>>> +        * For exact allocations, ignore the alignment, such that
>>> +        * find_vmap_lowest_match() won't search for a bigger free area just
>>> +        * able to align later and consequently fail the search.
>>> +        */
>>> +       if (vend - vstart == size && IS_ALIGNED(vstart, align))
>>> +               va = find_vmap_lowest_match(size, 1, vstart);
>>> +       else
>>> +               va = find_vmap_lowest_match(size, align, vstart);
>>>          if (unlikely(!va))
>>>                  return vend;
>>>
>>>
>>> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
>>> --
>>> 2.31.1
>>>
> This patch looks like a KASAN specific to me. So i would like to avoid
> such changes to
> the vmalloc internals in order to simplify further maintenance and
> keeping it generic
> instead.

There is nothing KASAN specific in there :) It's specific to exact 
applications -- and KASAN may be one of the only users for now.

> 
> Currently the find_vmap_lowest_match() adjusts the search size
> criteria for any alignment
> values even for PAGE_SIZE alignment. That is not optimal. Because a
> PAGE_SIZE or one
> page is a minimum granularity we operate on vmalloc allocations thus
> all free blocks are
> page aligned.
> 
> All that means that we should adjust the search length only if an
> alignment request is bigger than
> one page, in case of one page, that corresponds to PAGE_SIZE value,
> there is no reason in such
> extra adjustment because all free->va_start have a page boundary anyway.
> 
> Could you please test below patch that is a generic improvement?

I played with the exact approach below (almost exactly the same code in 
find_vmap_lowest_match()), and it might make sense as a general 
improvement -- if we can guarantee that start+end of ranges are always 
PAGE-aligned; I was not able to come to that conclusion, and your change 
to vmap_init_free_space() shows me that our existing alignment 
code/checks might be quite fragile.

But I mainly decided to go with my patch instead because it will also 
work for exact allocations with align > PAGE_SIZE: most notably, when we 
try population of hugepages instead of base pages in 
__vmalloc_node_range(), by increasing the alignment. If the exact range 
allows for using huge pages, placing huge pages will work just fine with 
my modifications, while it won't with your approach.

Long story short: my approach handles exact allocations also for bigger 
alignment, Your optimization makes sense as a general improvement for 
any vmalloc allocations.

Thanks for having a look!

> 
> <snip>
> urezki@pc638:~/data/raid0/coding/linux-next.git$ git diff
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 24a3955d5a36..9d219ab5ae57 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1153,7 +1153,9 @@ is_within_this_va(struct vmap_area *va, unsigned
> long size,
>   /*
>    * Find the first free block(lowest start address) in the tree,
>    * that will accomplish the request corresponding to passing
> - * parameters.
> + * parameters. Note that with an alignment > PAGE_SIZE, this
> + * function can skip applicable free blocks with lower start
> + * addresses which may fit for an alignment request.
>    */
>   static __always_inline struct vmap_area *
>   find_vmap_lowest_match(unsigned long size,
> @@ -1167,7 +1169,7 @@ find_vmap_lowest_match(unsigned long size,
>          node = free_vmap_area_root.rb_node;
> 
>          /* Adjust the search size for alignment overhead. */
> -       length = size + align - 1;
> +       length = (align > PAGE_SIZE) ? size + align:size;
> 
>          while (node) {
>                  va = rb_entry(node, struct vmap_area, rb_node);
> @@ -2251,7 +2253,7 @@ void __init vm_area_register_early(struct
> vm_struct *vm, size_t align)
> 
>   static void vmap_init_free_space(void)
>   {
> -       unsigned long vmap_start = 1;
> +       unsigned long vmap_start = PAGE_ALIGN(1);
>          const unsigned long vmap_end = ULONG_MAX;
>          struct vmap_area *busy, *free;
> 
> urezki@pc638:~/data/raid0/coding/linux-next.git$
> <snip>
> 
> Thanks!
> 
> --
> Vlad Rezki
> 


-- 
Thanks,

David / dhildenb

