Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F331C41648E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhIWRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233669AbhIWRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632418980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwZcD7Df0pRLm8jOd8+VyFKWNF1q3vmrtbOqAZa6G5w=;
        b=dTfjPi1BLzKvYUdXdtpJtx0mCkwNIEbkdycETBAtmQ50449zQDd83JzlJcOn9RkOxUU4o8
        7iDx7KcqrMn7pUus0QByqNArT0gyB8IXYjPmQucgIf/khdNoTC3WJsEyEPVmPYJ2LzFxxv
        GcWG9EsMGMUMwkOEkJwUT8muYdPjAUM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-v-sbZJ_9NM-s8H382nzpGw-1; Thu, 23 Sep 2021 13:42:58 -0400
X-MC-Unique: v-sbZJ_9NM-s8H382nzpGw-1
Received: by mail-wr1-f72.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso5747996wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hwZcD7Df0pRLm8jOd8+VyFKWNF1q3vmrtbOqAZa6G5w=;
        b=mst+9LpVzulLErWXiVcVnXZnZX5U0s0/ED9uy/C6UgtVMe6n2dr23AjKgtoV6rWD9t
         2zHnFjMY95jRs+1vgM08jr7dseDsybcKCqZfimiWUr8kuEEFyZb9M+ujvd7rn/gPZA9T
         pwtAwsKI1DXbyM3UH/RxnXPnml8wk20UjqUd5NZAX6aBVLhRZadaHacUQSSRxbDSeNXQ
         ox1XbkkdNltHQGhEC5WkIjWpTf5DQWMDGdZ4AH/SFyt4nT6vGs2F/67o7LTH9kOZI3Cc
         Jr1fDc5jVuzMJe6C1AU20AjShLO5umy9LPSR2LPMiCfdr2C45OGcOC3FfRekGkHuW6oX
         FUPQ==
X-Gm-Message-State: AOAM53192jRKqa5j3nVb804iEZ72IcE9EVmnWRlU7Cky++Vu+Yi3K7Ee
        tMopcAXidZOunUfJ59EgWk4ealNgjXhUH2x3TiI4XuswbKS+dtjMVtlCY9SaDVKi3xyd4KvkSPL
        XUpLuLFeIhPVkQlA6ZQUQQLZq
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr6548463wrw.224.1632418977430;
        Thu, 23 Sep 2021 10:42:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ8XNU7CQAU94aqaI5iNMpmSR7QTAETGZ40odb+UndLxI4xL2DiYDMDSoSRBYOx5wdmRT/FQ==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr6548440wrw.224.1632418977122;
        Thu, 23 Sep 2021 10:42:57 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e5d.dip0.t-ipconnect.de. [79.242.62.93])
        by smtp.gmail.com with ESMTPSA id o12sm5246234wms.15.2021.09.23.10.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:42:56 -0700 (PDT)
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
Message-ID: <437ff5c9-1b36-8ef7-1ce6-b3125e42de93@redhat.com>
Date:   Thu, 23 Sep 2021 19:42:55 +0200
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
>   					break;
>   				}
>   			}
> <snip>
> 
> so it handles any alignment and is accurate when it comes to searching the most
> lowest free block when user wants to allocate with a special alignment value.
> 
> Could you please help and test the KASAN use case?


Sure, I'll give it a spin tomorrow! Thanks!


-- 
Thanks,

David / dhildenb

