Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC41375B78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhEFTMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234467AbhEFTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620328257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLQS/VWO7OtVVjsKjxu+D/KAUrGLMXv+CIgGZgOS2ZA=;
        b=VkisTBs6/M5LYJWUBxrWQuqKQAj6BE9S/OMsQ4XK4h5aFKoHVkgzKTt6ucsQR/c+dBVThF
        dTEfGlN2tZngN8cEODxpp2ipk1mB+RY+qyLzEnrTvXf0lg8K9Drss1cxAqwQDPmhomGUm4
        ytUuSf7nyFNC4H4sei8QJgvGhr/S3KI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-2Chua7RgMRWi6xhoD-V6vg-1; Thu, 06 May 2021 15:10:55 -0400
X-MC-Unique: 2Chua7RgMRWi6xhoD-V6vg-1
Received: by mail-ed1-f72.google.com with SMTP id q18-20020a0564025192b02903888712212fso3129803edd.19
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BLQS/VWO7OtVVjsKjxu+D/KAUrGLMXv+CIgGZgOS2ZA=;
        b=kYpGez3WvkafLPfCu8VtLVDtsQAG0tsG8uIVfuxs2+30HtQKOybLMLo4Paa9QmnKAq
         ISwb/U1XD9ZXqZu0HE72AZhelph98wHXAtc8DtMGs++y6c76MH9CNXZ9We/NAXL3i7vb
         2Qdh3lpvKNr/TddVfKSzITs6dYKWXZ4VukZtR4s/MsAjIFpcoHgjsAQbgMcsdwSw2XPu
         VrrIu55V3zwowmq11N1kXZSYued4aAWy/k7EoKuaOEfLScJjDv+B5byQJKrtq0mxQsdN
         xx+Iq3gDayAI36ZMX6Mhtk4Ql8gHjWZr23yEQeS06VD8s5YpnA/+oKRFw5TxVCd4FaCu
         VIyA==
X-Gm-Message-State: AOAM531NjE3NFA/npKv4CB9TlQ+v54epa55Tq5UBq2GlCQCMzUzbUjNs
        dRyEoc3DqF39NEjq1h86UfSoMfBovK51+3kyRVOy9TqkfEOF8h0+qh+Cron1s4TTh3XOG7NBceQ
        /4FtjcVfP2liUuoCjLo0BMB0d
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr7015497edb.329.1620328254088;
        Thu, 06 May 2021 12:10:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZkjeBTygPaDXDtboP122O0OliN5NROL2yY9g10gw8dg8OmnhZOJqX4e3LHC7dUY0iB6oRYw==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr7015441edb.329.1620328253607;
        Thu, 06 May 2021 12:10:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id rs8sm1920481ejb.17.2021.05.06.12.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 12:10:53 -0700 (PDT)
To:     Zi Yan <ziy@nvidia.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20210506152623.178731-1-zi.yan@sent.com>
 <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
 <9D7FD316-988E-4B11-AC1C-64FF790BA79E@nvidia.com>
 <3a51f564-f3d1-c21f-93b5-1b91639523ec@redhat.com>
 <16962E62-7D1E-4E06-B832-EC91F54CC359@nvidia.com>
 <f3a2152c-685b-2141-3e33-b2bcab8b6010@redhat.com>
 <3A6D54CF-76F4-4401-A434-84BEB813A65A@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
Message-ID: <0e850dcb-c69a-188b-7ab9-09e6644af3ab@redhat.com>
Date:   Thu, 6 May 2021 21:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3A6D54CF-76F4-4401-A434-84BEB813A65A@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> 1. Pageblock size
>>
>> There are a couple of features that rely on the pageblock size to be reasonably small to work as expected. One example is virtio-balloon free page reporting, then there is virtio-mem (still also glued MAX_ORDER) and we have CMA (still also glued to MAX_ORDER). Most probably there are more. We track movability/ page isolation per pageblock; it's the smallest granularity you can effectively isolate pages or mark them as CMA (MIGRATE_ISOLATE, MIGRATE_CMA). Well, and there are "ordinary" THP / huge pages most of our applications use and will use, especially on smallish systems.
>>
>> Assume you bump up the pageblock order to 1G. Small VMs won't be able to report any free pages to the hypervisor. You'll take the "fine-grained" out of virtio-mem. Each CMA area will have to be at least 1G big, which turns CMA essentially useless on smallish systems (like we have on arm64 with 64k base pages -- pageblock_size is 512MB and I hate it).
> 
> I understand the issue of having large pageblock in small systems. My plan for this issue is to make MAX_ORDER a variable (pageblock size would be set according to MAX_ORDER) that can be adjusted based on total memory and via boot time parameter. My apology since I did not state this clearly in my cover letter and it confused you. When we have a boot time adjustable MAX_ORDER, large pageblock like 1GB would only appear for systems with large memory. For small VMs, pageblock size would stay at 2MB, so all your concerns on smallish systems should go away.

I have to admit that I am not really a friend of that. I still think our 
target goal should be to have gigantic THP *in addition to* ordinary 
THP. Use gigantic THP where enabled and possible, and just use ordinary 
THP everywhere else. Having one pageblock granularity is a real 
limitation IMHO and requires us to hack the system to support it to some 
degree.

> 
>>
>> Then, imagine systems that have like 4G of main memory. By stopping grouping at 2M and instead grouping at 1G you can very easily find yourself in the system where all your 4 pageblocks are unmovable and you essentially don't optimize for huge pages in that environment any more.
>>
>> Long story short: we need a different mechanism on top and shall leave the pageblock size untouched, it's too tightly integrated with page isolation, ordinary THP, and CMA.
> 
> I think it is better to make pageblock size adjustable based on total memory of a system. It is not reasonable to have the same pageblock size across systems with memory sizes from <1GB to several TBs. Do you agree?
> 

I suggest an additional mechanism on top. Please bear in mind that 
ordinary THP will most probably be still the default for 99.9% of all 
application/library cases, even when you have gigantic THP around.

>>
>> 2. Section size
>>
>> I assume the only reason you want to touch that is because pageblock_size <= section_size, and I guess that's one of the reasons I dislike it so much. Messing with the section size really only makes sense when we want to manage metadata for larger granularity within a section.
> 
> Perhaps it is worth checking if it is feasible to make pageblock_size > section_size, so we can still have small sections when pageblock_size are large. One potential issue for that is when PFN discontinues at section boundary, we might have partial pageblock when pageblock_size is big. I guess supporting partial pageblock (or different pageblock sizes like you mentioned below ) would be the right solution.
> 
>>
>> We allocate metadata per section. We mark whole sections early/online/present/.... Yes, in case of vmemmap, we manage the memmap in smaller granularity using the sub-section map, some kind of hack to support some ZONE_DEVICE cases better.
>>
>> Let's assume we introduce something new "gigapage_order", corresponding to 1G. We could either decide to squeeze the metadata into sections, having to increase the section size, or manage that metadata differently.
>>
>> Managing it differently certainly makes the necessary changes easier. Instead of adding more hacks into sections, rather manage that metadata at differently place / in a different way.
> 
> Can you elaborate on managing it differently?

Let's keep it simple. Assume you track on a 1G gigpageblock MOVABLE vs. 
!movable in addition to existing pageblocks. A 64 TB system would have 
64*1024 gigpageblocks. One bit per gigapageblock would require 8k a.k.a. 
2 pages. If you need more states, it would maybe double. No need to 
manage that using sparse memory sections IMHO. Just allocate 2/4 pages 
during boot for the bitmap.

> 
>>
>> See [1] for an alternative. Not necessarily what I would dream off, but just to showcase that there might be alternative to group pages.
> 
> I saw this patch too. It is an interesting idea to separate different allocation orders into different regions, but it would not work for gigantic page allocations unless we have large pageblock size to utilize existing anti-fragmentation mechanisms.

Right, any anti-fragmentation mechanism on top.

>> 3. Grouping pages > pageblock_order
>>
>> There are other approaches that would benefit from grouping at > pageblock_order and having bigger MAX_ORDER. And that doesn't necessarily mean to form gigantic pages only, we might want to group in multiple granularity on a single system. Memory hot(un)plug is one example, but also optimizing memory consumption by powering down DIMM banks. Also, some architectures support differing huge page sizes (aarch64) that could be improved without CMA. Why not have more than 2 THP sizes on these systems?
>>
>> Ideally, we'd have a mechanism that tries grouping on different granularity, like for every order in pageblock_order ... max_pageblock_order (e.g., 1 GiB), and not only add one new level of grouping (or increase the single grouping size).
> 
> I agree. In some sense, supporting partial pageblock and increasing pageblock size (e.g., to 1GB) is, at the high level, quite similar to having multiple pageblock sizes. But I am not sure if we really want to support multiple pageblock sizes, since it creates pageblock fragmentation when we want to change migratetype for part of a pageblock. This means we would break a large pageblock into small ones if we just want to steal a subset of pages from MOVEABLE for UNMOVABLE allocations. Then pageblock loses its most useful anti-fragmentation feature. Also it seems to be a replication of buddy allocator functionalities when it comes to pageblock split and merge.

Let's assume for simplicity that you have a 4G machine, maximum 4 
gigantic pages. The first gigantic page will be impossible either way 
due to the kernel, boot time allocations etc. So you're left with 3 
gigantic pages you could use at best.

Obviously, you want to make sure that the remaining parts of the first 
gigantic page are used as best as possible for ordinary huge pages, so 
you would actually want to group them in 2 MiB chunks and avoid 
fragmentation there.

Obviously, supporting two pageblock types would require core 
modifications to support it natively. (not pushing for the idea of two 
pageblock orders, just motivating why we actually want to keep grouping 
for ordinary THP).

> 
> 
> The above is really a nice discussion with you on pageblock, section, memory hotplug/hotremove, which also helps me understand more on the issues with increasing MAX_ORDER to enable 1GB page allocation.
> 
> In sum, if I get it correctly, the issues I need to address are:
> 
> 1. large pageblock size (which is needed when we bump MAX_ORDER for gigantic page allocation from buddy allocator) is not good for machines with small memory.
> 
> 2. pageblock size is currently tied with section size (which made me want to bump section size).
> 
> 
> For 1, I think making MAX_ORDER a variable that can be set based on total memory size and adjustable via boot time parameter should solve the problem. For small machines, we will keep MAX_ORDER as small as we have now like 4MB, whereas for large machines, we can increase MAX_ORDER to utilize gigantic pages.
> 
> For 2, supporting partial pageblock and allow a pageblock to cross multiple sections would break the tie between pageblock size and section to solve the issue.
> 
> I am going to look into them. What do you think?

I am not sure that's really the right direction as stated above.

-- 
Thanks,

David / dhildenb

