Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394F3417211
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbhIXMoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245067AbhIXMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632487346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2lCHhfcJVfe6eV8QOwHmpXfQvY8dI6NRVeDXuXkPZg=;
        b=eJt1D/XF6/6cI1NFnWEVsnllDQFS22QRWf/GRV9xq/pCf10Td+X55F0lkWqrqVM7RXAs3B
        nAYEejpSni5dgO0Q5Fqz2ZQxbFvm2TKzhOCgJOFFwq9AkqQcxno4geyCPmokgfvDlYTaqb
        MPUTMvM5Q+MF2mVuikUkLVaM/+T9VsA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-3XxGjtOVMbuD61TACrsDzw-1; Fri, 24 Sep 2021 08:42:25 -0400
X-MC-Unique: 3XxGjtOVMbuD61TACrsDzw-1
Received: by mail-wr1-f70.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so7974583wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o2lCHhfcJVfe6eV8QOwHmpXfQvY8dI6NRVeDXuXkPZg=;
        b=vFQEeVZ66GVTtaDh05EFvdTrLsVBdDyBgJ2XgF6jicxJRNOJts+4gf+Z1gIKEi0jGB
         BXOGnEeOHN0pR2MoD1ul/RD319hBfS4U4yNG4BOW5m6gQ9qkUDKwp9T9MLCDg7lIBtiG
         Q+ekOst40jma6VEJuKznM8j7JChnX+aKKWuZmMR+HiVLYJb0hY+FgxHE5Q2YmVUiVILg
         ROxxz8wQWUt57lxzxfEy7X0gsrDUIAHxITKujcjbW21DtWOE6ly2kjPF5oeJCZ5Dg2IN
         RSh2kDFBgi6n+lYh+BkDceyJByuFhbm8adb4UE3RDzA1lpQk8HZ1QosfSi9+e8J7VdP3
         XyeQ==
X-Gm-Message-State: AOAM531X5cRPwRq8FRShClFKpbelGcPPHqhjOU6R4tBnRp5GUK9cJpB4
        rfalC9MBnQ7XekzvnZPMeoVoSm+oO3rS9DTDyHHrNPbo/hdiieeGjgApRf9atVcsORhEZ2K3uo+
        NDwORmfjQQAkkpYd4Hx3nLcRx
X-Received: by 2002:a05:600c:26d4:: with SMTP id 20mr1916457wmv.40.1632487344180;
        Fri, 24 Sep 2021 05:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYrM6rSDNaQGfhmHips5iDe7ueG2IAsI6Ku8POFvMdDJJxUwlQ7psFPTLRQb68JYJocqVVWg==
X-Received: by 2002:a05:600c:26d4:: with SMTP id 20mr1916433wmv.40.1632487343967;
        Fri, 24 Sep 2021 05:42:23 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id q126sm11921468wma.10.2021.09.24.05.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 05:42:23 -0700 (PDT)
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
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
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
 <20210921221337.GA60191@pc638.lan>
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com>
 <20210922104141.GA27011@pc638.lan>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com>
Date:   Fri, 24 Sep 2021 14:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922104141.GA27011@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.21 12:41, Uladzislau Rezki wrote:
> On Wed, Sep 22, 2021 at 10:34:55AM +0200, David Hildenbrand wrote:
>>>> No, that's leaking implementation details to the caller. And no, increasing
>>>> the range and eventually allocating something bigger (e.g., placing a huge
>>>> page where it might not have been possible) is not acceptable for KASAN.
>>>>
>>>> If you're terribly unhappy with this patch,
>>> Sorry to say but it simple does not make sense.
>>>
>>
>> Let's agree to disagree.
>>
>> find_vmap_lowest_match() is imprecise now and that's an issue for exact
>> allocations. We can either make it fully precise again (eventually degrading
>> allocation performance) or just special-case exact allocations to fix the
>> regression.
>>
>> I decided to go the easy path and do the latter; I do agree that making
>> find_vmap_lowest_match() fully precise again might be preferred -- we could
>> have other allocations failing right now although there are still suitable
>> holes.
>>
>> I briefly thought about performing the search in find_vmap_lowest_match()
>> twice. First, start the search without an extended range, and fallback to
>> the extended range if that search fails. Unfortunately, I think that still
>> won't make the function completely precise due to the way we might miss
>> searching some suitable subtrees.
>>
>>>>
>>>> please suggest something reasonable to fix exact allocations:
>>>> a) Fixes the KASAN use case.
>>>> b) Allows for automatic placement of huge pages for exact allocations.
>>>> c) Doesn't leak implementation details into the caller.
>>>>
>>> I am looking at it.
>>
> I am testing this:
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dcf23d16a308..cdf3bda6313d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1161,18 +1161,14 @@ find_vmap_lowest_match(unsigned long size,
>   {
>   	struct vmap_area *va;
>   	struct rb_node *node;
> -	unsigned long length;
>   
>   	/* Start from the root. */
>   	node = free_vmap_area_root.rb_node;
>   
> -	/* Adjust the search size for alignment overhead. */
> -	length = size + align - 1;
> -
>   	while (node) {
>   		va = rb_entry(node, struct vmap_area, rb_node);
>   
> -		if (get_subtree_max_size(node->rb_left) >= length &&
> +		if (get_subtree_max_size(node->rb_left) >= size &&
>   				vstart < va->va_start) {
>   			node = node->rb_left;
>   		} else {
> @@ -1182,9 +1178,9 @@ find_vmap_lowest_match(unsigned long size,
>   			/*
>   			 * Does not make sense to go deeper towards the right
>   			 * sub-tree if it does not have a free block that is
> -			 * equal or bigger to the requested search length.
> +			 * equal or bigger to the requested search size.
>   			 */
> -			if (get_subtree_max_size(node->rb_right) >= length) {
> +			if (get_subtree_max_size(node->rb_right) >= size) {
>   				node = node->rb_right;
>   				continue;
>   			}
> @@ -1192,16 +1188,30 @@ find_vmap_lowest_match(unsigned long size,
>   			/*
>   			 * OK. We roll back and find the first right sub-tree,
>   			 * that will satisfy the search criteria. It can happen
> -			 * only once due to "vstart" restriction.
> +			 * due to "vstart" restriction or an alignment overhead.
>   			 */
>   			while ((node = rb_parent(node))) {
>   				va = rb_entry(node, struct vmap_area, rb_node);
>   				if (is_within_this_va(va, size, align, vstart))
>   					return va;
>   
> -				if (get_subtree_max_size(node->rb_right) >= length &&
> +				if (get_subtree_max_size(node->rb_right) >= size &&
>   						vstart <= va->va_start) {
> +					/*
> +					 * Shift the vstart forward, so we do not loop over same
> +					 * sub-tree force and back. The aim is to continue tree
> +					 * scanning toward higher addresses cutting off previous
> +					 * ones.
> +					 *
> +					 * Please note we update vstart with parent's start address
> +					 * adding "1" because we do not want to enter same sub-tree
> +					 * one more time after it has already been inspected and no
> +					 * suitable free block found there.
> +					 */
> +					vstart = va->va_start + 1;
>   					node = node->rb_right;
> +
> +					/* Scan a sub-tree rooted at "node". */

So the idea is that once we run into a dead end because we took a left 
subtree, we rollback to the next possible rigth subtree and try again. 
If we run into another dead end, we repeat ... thus, this can now happen 
more than once.

I assume the only implication is that this can now be slower in some 
corner cases with larger alignment, because it might take longer to find 
something suitable. Fair enough.

>   					break;
>   				}
>   			}
> <snip>
> 
> so it handles any alignment and is accurate when it comes to searching the most
> lowest free block when user wants to allocate with a special alignment value.
> 
> Could you please help and test the KASAN use case?

Just tried it, works just fine with KASAN and makes sense in general, 
thanks!

-- 
Thanks,

David / dhildenb

