Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B180536674B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhDUIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhDUIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618995135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADh1GjnD2traYWKrmdkbx4sS/3yzMkTFPb5D6p+Cevw=;
        b=fwddir1dxXBrn7zqdMBtwmDG6yF4Z5FBQEuYcsv5Uz4soQgioSnyZPGD1K7XuQfaHYvgb4
        aoPvre/zKl+Up6/zbFMI5LSeFcJzFuhDOZeYoqVPzrChPPWN3zuXJCktJMoc08r+VF2Swe
        TRZDL/Y2loB/7m1uBq54ry2JHf8edCQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-tlzgz6MDNLy-UbOJ5CLh_g-1; Wed, 21 Apr 2021 04:52:11 -0400
X-MC-Unique: tlzgz6MDNLy-UbOJ5CLh_g-1
Received: by mail-ed1-f72.google.com with SMTP id f1-20020a0564021941b02903850806bb32so8702417edz.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ADh1GjnD2traYWKrmdkbx4sS/3yzMkTFPb5D6p+Cevw=;
        b=YXk3E2Hx/41ufOraKy8E8KjkgfhJg2oLWwIe8TrDWfTsC6Mh99u0eKThtSW1jDxmwB
         fsRzo+SzbzP+c42U3A8ranrqzCl7WYOQCkk1LQA6YdUZubE5Jwwh+nNdbqqJ4Bj/kObz
         htiyUWTy+76x48tuFd5L4K0nYDSmMPao9eMbpNAFakHzjjlr5yJ2OksU4eqBYfk+KBO6
         Su2JkOUVBMass89viYuUyG7EbEcjKRoVFEiPwmv3fkA8QrbH6AVstcxz829xZY2q+g1A
         6NXrEAVY/AAgbfZgqKxRfvPI+UGOruJdeMvOKesT4WuHelz/Ld+1Oa1Aars2WAF8lhaS
         lkuQ==
X-Gm-Message-State: AOAM533iy8D+HdHh9ksoaow6t6fztqA2KoI8XaHBtfGkKS5zezo5/uqv
        q+NEjU2uV+KDELMgGRtpY5hTY4v0UUgyoNitox7TN1ur8GzZimaSqpYc/27rXbjTXpwdfRlKb5+
        PT606QHZjaVrxa89H+1f7e5rkA7eZYIh83MMo1ym7zOFxbP1ZwuPVNwDaZy1tI6TUQytn/8Lw
X-Received: by 2002:a17:906:b2cf:: with SMTP id cf15mr31447464ejb.233.1618995129875;
        Wed, 21 Apr 2021 01:52:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPu5TB58UU6Pp+QMCJZiDVV54hEiR7K4MqSQTWUG2seDg6yT4lInHBRhqgDKp3s1svx9xIeA==
X-Received: by 2002:a17:906:b2cf:: with SMTP id cf15mr31447436ejb.233.1618995129509;
        Wed, 21 Apr 2021 01:52:09 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64b8.dip0.t-ipconnect.de. [91.12.100.184])
        by smtp.gmail.com with ESMTPSA id gt33sm1614955ejc.89.2021.04.21.01.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 01:52:09 -0700 (PDT)
Subject: Re: [PATCH v9 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-5-osalvador@suse.de> <YH6zQ1Dty9kJFkuk@dhcp22.suse.cz>
 <20210421081546.GD22456@linux> <YH/ktDG/9o2OHNGj@dhcp22.suse.cz>
 <c248d75d-fe50-7d3f-69bc-6df3241f39ac@redhat.com>
 <YH/nKqrV2orwHeya@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6044ab2c-e130-c21c-08ba-3132e9107843@redhat.com>
Date:   Wed, 21 Apr 2021 10:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH/nKqrV2orwHeya@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 10:49, Michal Hocko wrote:
> On Wed 21-04-21 10:44:38, David Hildenbrand wrote:
>> On 21.04.21 10:39, Michal Hocko wrote:
>>> On Wed 21-04-21 10:15:46, Oscar Salvador wrote:
>>>> On Tue, Apr 20, 2021 at 12:56:03PM +0200, Michal Hocko wrote:
>>> [...]
>>>>> necessary. Using two different iteration styles is also hurting the code
>>>>> readability. I would go with the following
>>>>> 	for (pfn = start_pfn; pfn < end_pfn; ) {
>>>>> 		unsigned long order = min(MAX_ORDER - 1UL, __ffs(pfn));
>>>>>
>>>>> 		while (start + (1UL << order) > end_pfn)
>>>>>                           order--;
>>>>> 		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
>>>>> 		pfn += 1 << order;
>>>>> 	}
>>>>>
>>>>> which is what __free_pages_memory does already.
>>>>
>>>> this is kinda what I used to have in the early versions, but it was agreed
>>>> with David to split it in two loops to make it explicit.
>>>> I can go back to that if it is preferred.
>>>
>>> Not that I would insist but I find it better to use common constructs
>>> when it doesn't hurt readability. The order evaluation can be even done
>>> in a trivial helper.
>>>
>>>>>> +	if (memmap_on_memory) {
>>>>>> +		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
>>>>>> +						      get_nr_vmemmap_pages_cb);
>>>>>> +		if (nr_vmemmap_pages) {
>>>>>> +			if (size != memory_block_size_bytes()) {
>>>>>> +				pr_warn("Refuse to remove %#llx - %#llx,"
>>>>>> +					"wrong granularity\n",
>>>>>> +					start, start + size);
>>>>>> +				return -EINVAL;
>>>>>> +			}
>>>>>> +
>>>>>> +			/*
>>>>>> +			 * Let remove_pmd_table->free_hugepage_table do the
>>>>>> +			 * right thing if we used vmem_altmap when hot-adding
>>>>>> +			 * the range.
>>>>>> +			 */
>>>>>> +			mhp_altmap.alloc = nr_vmemmap_pages;
>>>>>> +			altmap = &mhp_altmap;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>>    	/* remove memmap entry */
>>>>>>    	firmware_map_remove(start, start + size, "System RAM");
>>>>>
>>>>> I have to say I still dislike this and I would just wrap it inside out
>>>>> and do the operation from within walk_memory_blocks but I will not
>>>>> insist.
>>>>
>>>> I have to confess I forgot about the details of that dicussion, as we were
>>>> quite focused on decoupling vmemmap pages from {online,offline} interface.
>>>> Would you mind elaborating a bit more?
>>>
>>> As I've said I will not insist and this can be done in the follow up.
>>> You are iterating over memory blocks just to refuse to do an operation
>>> which can be split to several memory blocks. See
>>> http://lkml.kernel.org/r/YFtPxH0CT5QZsnR1@dhcp22.suse.cz and follow
>>> walk_memory_blocks(start, size, NULL, remove_memory_block_cb)
>>>
>>
>> We'll have to be careful in general when removing memory in different
>> granularity than it was added, especially calling arch_remove_memory() in
>> smaller granularity than it was added via arch_add_memory(). We might fail
>> to tear down the direct map, imagine having mapped a 1GiB page but decide to
>> remove individual 128 MiB chunks -- that won't work and the direct map would
>> currently remain.
> 
> Agreed but I am not referring to arbitrary hotremove path. All I am
> pointing at is to split up to memory blocks and do the same kind of work
> on each separately. Partial failures might turn out to be more tricky
> and as I've said I do not insist on doing that right now but it is a bit
> weird to outright fail the operation even when in fact there are more
> blocks to be hot removed in once.

Agreed. But we should also focus on what actual users need to see if 
it's worth the trouble (I know of none that will be using memmap_on_memory).


-- 
Thanks,

David / dhildenb

