Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9539D7DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFGIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhFGIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623055745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nx1hUYYHMW5mVqvLvMchsGATtVkY4GJZG/k/SnbIt4M=;
        b=I+bSR8u3LOjT9crRaIeczl0KlFyDs0QVGwLh3R81IiEiKaPDQRzLpJNYQOZ9QyCQLaJt8J
        NjgqbIRZzA8aVJPJK/Mq8/dmZ+X+n80lsmVuJ/Sc6MLCxDsD824ZwxcbHQ77kPgyFLg/1f
        lkm1JBs5NhemSYb3zYTedijAdPTYrYc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-JeQ9pT0BN_eQWqjtJ7bv9g-1; Mon, 07 Jun 2021 04:49:03 -0400
X-MC-Unique: JeQ9pT0BN_eQWqjtJ7bv9g-1
Received: by mail-wr1-f72.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so7479786wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nx1hUYYHMW5mVqvLvMchsGATtVkY4GJZG/k/SnbIt4M=;
        b=OEA6kVzwv+cz/Xg1pz5p/q3PIBLc2r8uGI00GlKlQcbInxgO2vgHdNVL2TKh99rHnk
         AyHTN6T2ve5wAN6s6PbhOnpcu0yXKoko9Ne9X0tI2aTEtzTzrzCzq9Ll7/Wz3A/DGezU
         fW5FRZPazrcpmZhna07cfwZybEM/5DxKmgWca34j7lQqDD9AiKenWfQVJBeJ4OpaHtgy
         /rbmG13R2/jC9oaN2pWEhvFraDF8bU4oHD2AEgTXJeDvO4Qf0JM5k2BxgWX/jJhqQE1t
         jJqLct7ksVWBLuaV22gwbVnBqjbuSKvuQEW3fnTAOVaE8MOry6nKZ/x8mhlR7AfDUGVs
         RAdg==
X-Gm-Message-State: AOAM531ld43iu9YmW+++HzagO/Bk6VizcR83GCEDNL1hgOydc7cBSS6X
        B4lRY4DvI1LZ2GL+EwfCEsmSQxg5hD5ij7zxnfvhtPs9mVZ310JA2D2D6S8ek9gnTb51yf0Svir
        oJr8Xe5kG2R1cP6Mqv22LRgV8iNEqzfpQi44sTGdcAQZQpEsHdPLlmQBo8AOPZrbwS3EsplUe
X-Received: by 2002:a05:600c:2e43:: with SMTP id q3mr15540795wmf.11.1623055742162;
        Mon, 07 Jun 2021 01:49:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycIys+K+NqaWblC8ffIhXoXJK4nnHDTg1/8VoHCspmMrc4ul0z/0IKf84x1B6XBJwe1Mbt0w==
X-Received: by 2002:a05:600c:2e43:: with SMTP id q3mr15540758wmf.11.1623055741887;
        Mon, 07 Jun 2021 01:49:01 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6188.dip0.t-ipconnect.de. [91.12.97.136])
        by smtp.gmail.com with ESMTPSA id u6sm16338315wre.76.2021.06.07.01.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 01:49:01 -0700 (PDT)
To:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain> <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
 <20210604074140.GA25063@linux> <20210607075147.GA10554@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
Message-ID: <85984701-55ae-dfa5-2a8d-f637051b612d@redhat.com>
Date:   Mon, 7 Jun 2021 10:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607075147.GA10554@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.21 09:52, Oscar Salvador wrote:
> On Fri, Jun 04, 2021 at 09:41:45AM +0200, Oscar Salvador wrote:
>> On Thu, Jun 03, 2021 at 02:45:13PM +0200, Michal Hocko wrote:
>>> I believe we need to define the purpose of the locking first. The
>>
>> If you ask me, this locking would be meant to make sure zone's zone_start_pfn
>> or spanned_pages do not change under us, in case we __need__ the value to be
>> stable.
>>
>>> existing locking doesn't serve much purpose, does it? The state might
>>
>> Well, half-way. Currently, the locking is taken in write mode whenever
>> the zone is expanded or shrinked, and in read mode when called from
>> bad_range()->page_outside_zone_boundaries() (only on VM_DEBUG).
>>
>> But as you pointed out, such state might change right after the locking is
>> released and all the work would be for nothing.
>> So indeed, the __whole__ operation should be envolved by the lock in the caller
>> The way that stands right now is not optimal.
>>
>>> change right after the lock is released and the caller cannot really
>>> rely on the result. So aside of the current implementation, I would
>>> argue that any locking has to be be done on the caller layer.
>>>
>>> But the primary question is whether anybody actually cares about
>>> potential races in the first place.
>>
>> I have been checking move_freepages_block() and alloc_contig_pages(), which
>> are two of the functions that call zone_spans_pfn().
>>
>> move_freepages_block() uses it in a way to align the given pfn to pageblock
>> top and bottom, and then check that aligned pfns are still within the same zone.
>>  From a memory-hotplug perspective that's ok as we know that we are offlining
>> PAGES_PER_SECTION (which implies whole pageblocks).
>>
>> alloc_contig_pages() (used by the hugetlb gigantic allocator) runs through a
>> node's zonelist and checks whether zone->zone_start_pfn + nr_pages stays within
>> the same zone.
>> IMHO, the race with zone_spans_last_pfn() vs mem-hotplug would not be that bad,
>> as it will be caught afters by e.g: __alloc_contig_pages when pages cannot be
>> isolated because they are offline etc.
>>
>> So, I would say we do not really need the lock, but I might be missing something.
>> But if we chose to care about this, then the locking should be done right, not
>> half-way as it is right now.
> 
> 
> Any thoughts on this? :-)

I'd like to point out that I think the seqlock is not in place to 
synchronize with actual growing/shrinking but to get consistent zone 
ranges -- like using atomics, but we have two inter-dependent values here.

If you obtain the zone ranges that way and properly use 
pfn_to_online_page(), there is hardly something that can go wrong in 
practice. If the zone grew in the meantime, most probably you can just 
live with not processing that part for now. If the zone shrunk in the 
meantime, pfn_to_online_page() will make you skip that part (it was 
offlined either way, so you most probably don't really care about that 
part).

[pfn_to_online_page() is racy as well, but the race window is very small 
and we never saw a problem in practice really]

Without the seqlock, you might just get a garbage zone range and have 
either false/positive negatives when just testing for a simple range not 
in an hot(un)plugged range [which is the usual case when talking about 
compaction etc.].

-- 
Thanks,

David / dhildenb

