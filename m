Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4113D9033
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhG1OQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236619AbhG1OQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627481795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBTvI7AyrQyvAwreHvMDRlU4GfJOEkkwow/YW2lcebI=;
        b=KLFsm4Y81yleog3pFwDZbJ3TtHYTzx2Omc0Pjv5+EOMfvt4uLtG/kQem3uZrO1EZoIuOYz
        VIm7tEs30vkmCquzkZb6S5007B4KvHXbFyRov2HSz8Y+A7aHugPnWw6rsvrNGcX+zq41gP
        e0Tw4DHiloMKrXX+bcPTksUpepJdVCI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-rTuQ2EIHMUWytMitSoWJaQ-1; Wed, 28 Jul 2021 10:16:34 -0400
X-MC-Unique: rTuQ2EIHMUWytMitSoWJaQ-1
Received: by mail-wm1-f69.google.com with SMTP id a1-20020a7bc1c10000b0290225338d8f53so985775wmj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SBTvI7AyrQyvAwreHvMDRlU4GfJOEkkwow/YW2lcebI=;
        b=k2h9LiBgrqMBLXu8Hsv8uKNGRcdtNquN33cRTVr4SYbvPJM+Rv3XHrl3D5+0kAh7aM
         vLDCTxGWe3WAbGsgnNGC3jbhG10x2N2Vx8qLFn/8w7HcrA3Cwoks/lA7GLDs1iSBhRpA
         0iVvBGlWNJGBqlTkLVuJrCarJ6TT/U6yYqgHY7+t02lziLNMkVg+1nUmSeddJ/v/Qo7z
         pf57iPDskfDCdWfkoHMzwWeInsaeQh0qkzlb3hlPcnYhDiUwwopu2Wka00YZs3d8sz+H
         LBARHwANiwNkJP1VF/7vLf5ccQl1mG9GX1TxiQ0ZtAiCkaYgwfVvsg6DgdVxttaI4hkD
         jS5A==
X-Gm-Message-State: AOAM5338TUZkVr0cxEFhWDsKk5HtxH2xJ5g6x+7Xy4dVMhOZbu2f+XAe
        wuUEcidG/RHZq5lCvl1Jcppz4+d2kUvluWlu2LnBkHvK9O6SfkdfWu3/rWKByKpo24dyTncw1iZ
        hCEaHyN9t4ddBmHDAkYAD8Gix
X-Received: by 2002:a5d:4751:: with SMTP id o17mr23882201wrs.252.1627481792292;
        Wed, 28 Jul 2021 07:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp/VmSZ6MuqzGZoTa2wRKFNJXZiRxCOsLy7Zc304MtYust9qBmcciWmXmZwOF3zqp8wUvvWw==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr23882179wrs.252.1627481792086;
        Wed, 28 Jul 2021 07:16:32 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id f194sm6232701wmf.23.2021.07.28.07.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 07:16:31 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org
References: <20210723125210.29987-1-david@redhat.com>
 <20210723125210.29987-4-david@redhat.com> <YQFeJ1P9wQvlqAz7@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/9] drivers/base/memory: introduce "memory groups" to
 logically group memory blocks
Message-ID: <2eaa8ac5-9eaf-bd2a-ace6-3f1ac38c85ff@redhat.com>
Date:   Wed, 28 Jul 2021 16:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQFeJ1P9wQvlqAz7@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

>>   
>>   static void unregister_memory(struct memory_block *memory)
>> @@ -681,6 +692,11 @@ static void unregister_memory(struct memory_block *memory)
>>   
>>   	WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
>>   
>> +	if (memory->group) {
>> +		refcount_dec(&memory->group->refcount);
>> +		memory->group = NULL;
> 
> Who freed the memory for the group?

try_remove_memory() will end up calling 
remove_memory_block_devices()->unregister_memory().

try_remove_memory() will get called by drivers that added memory 
previously and registered the memory groups.

>> +static int register_memory_group(struct memory_group group)
>> +{
>> +	struct memory_group *new_group;
>> +	uint32_t mgid;
>> +	int ret;
>> +
>> +	if (!node_possible(group.nid))
>> +		return -EINVAL;
>> +
>> +	new_group = kzalloc(sizeof(group), GFP_KERNEL);
>> +	if (!new_group)
>> +		return -ENOMEM;
>> +	*new_group = group;
> 
> You burried a memcpy here, why?  Please be explicit as this is now a
> dynamic structure.

To make the two callers directly below nicer. This is a pure helper for 
initialization. Suggestions welcome.

> 
>> +	refcount_set(&new_group->refcount, 1);
> 
> Why not just use a kref?  You seem to be treating it as a kref would
> work, right?

I shall have a look, thanks!

> 
>> +
>> +	ret = xa_alloc(&memory_groups, &mgid, new_group, xa_limit_31b,
>> +		       GFP_KERNEL);
>> +	if (ret)
>> +		kfree(new_group);
>> +	return ret ? ret : mgid;
> 
> I hate ?: please spell this out:
> 	if (ret)
> 		return ret;
> 	return mgid;

I can avoid it in this case, but it feels kind of wrong to stick to the 
personal preference of individuals if it's getting used all over the 
code base and there is no clear coding style recommendation.

> 
> There, more obvious and you can read it in 10 years when you have to go
> fix it up...
> 

Fair enough.

> 
> 
>> +}
>> +
>> +int register_static_memory_group(int nid, unsigned long max_pages)
>> +{
>> +	struct memory_group group = {
>> +		.nid = nid,
>> +		.s = {
>> +			.max_pages = max_pages,
>> +		},
>> +	};
>> +
>> +	if (!max_pages)
>> +		return -EINVAL;
>> +	return register_memory_group(group);
>> +}
>> +EXPORT_SYMBOL_GPL(register_static_memory_group);
> 
> Let's make our global namespace a bit nicer:
> 	memory_group_register_static()
> 	memory_group_register_dynamic()
> 
> and so on.  Use prefixes please, not suffixes.

Sure, no strong opinion, can do.

> 
> 
>> +
>> +int register_dynamic_memory_group(int nid, unsigned long unit_pages)
>> +{
>> +	struct memory_group group = {
>> +		.nid = nid,
>> +		.is_dynamic = true,
>> +		.d = {
>> +			.unit_pages = unit_pages,
>> +		},
>> +	};
>> +
>> +	if (!unit_pages || !is_power_of_2(unit_pages) ||
>> +	    unit_pages < PHYS_PFN(memory_block_size_bytes()))
>> +		return -EINVAL;
>> +	return register_memory_group(group);
>> +}
>> +EXPORT_SYMBOL_GPL(register_dynamic_memory_group);
>> +
>> +int unregister_memory_group(int mgid)
>> +{
>> +	struct memory_group *group;
>> +
>> +	if (mgid < 0)
>> +		return -EINVAL;
>> +
>> +	group = xa_load(&memory_groups, mgid);
>> +	if (!group || refcount_read(&group->refcount) > 1)
>> +		return -EINVAL;
>> +
>> +	xa_erase(&memory_groups, mgid);
>> +	kfree(group);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(unregister_memory_group);
> 
> memory_group_unregister()

Sure.

> 
> 
>> +
>> +struct memory_group *get_memory_group(int mgid)
>> +{
>> +	return xa_load(&memory_groups, mgid);
>> +}
> 
> Global function?

Called from mm/memory_hotplug.c:add_memory_resource(). Note that we do 
not want to export that function to random modules.

Any suggestion?

> 
> 
>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>> index 97e92e8b556a..6e20a6174fe5 100644
>> --- a/include/linux/memory.h
>> +++ b/include/linux/memory.h
>> @@ -23,6 +23,42 @@
>>   
>>   #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
>>   
>> +struct memory_group {
>> +	/* Nid the whole group belongs to. */
>> +	int nid;
> 
> What is a "nid"?

"Node id". Will clarify.

> 
>> +	/* References from memory blocks + 1. */
> 
> Blank line above this?

Sure.

> 
> And put the structure comments in proper kernel doc so that others can
> read them and we can verify it is correct over time.

Can do.

> 
>> +	refcount_t refcount;
>> +	/*
>> +	 * Memory group type: static vs. dynamic.
>> +	 *
>> +	 * Static: All memory in the group belongs to a single unit, such as,
>> +	 * a DIMM. All memory belonging to the group will be added in
>> +	 * one go and removed in one go -- it's static.
>> +	 *
>> +	 * Dynamic: Memory within the group is added/removed dynamically in
>> +	 * units of the specified granularity of at least one memory block.
>> +	 */
>> +	bool is_dynamic;
>> +
>> +	union {
>> +		struct {
>> +			/*
>> +			 * Maximum number of pages we'll have in this static
>> +			 * memory group.
>> +			 */
>> +			unsigned long max_pages;
>> +		} s;
>> +		struct {
>> +			/*
>> +			 * Unit in pages in which memory is added/removed in
>> +			 * this dynamic memory group. This granularity defines
>> +			 * the alignment of a unit in physical address space.
>> +			 */
>> +			unsigned long unit_pages;
>> +		} d;
> 
> so is_dynamic determines which to use here?  Please be explicit.

Sure, can make that more explicit.

Thanks for the feedback!


-- 
Thanks,

David / dhildenb

