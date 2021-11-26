Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A52D45E9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhKZJJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347745AbhKZJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637917446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBeC7fNu77y+gSatqqLKddyjvmoD+l8MjcB3oFZhODk=;
        b=BxQnGaClTNRk0mvxxf48RT3eshQCKQN4nVcnStBbzY7pSDkg61HsmB5/4MGaxgylXHfZRE
        RuYMStIQwicBlLw+w6HxyTMK7ME6Yk/yrZSUQMxmda8DWjyc19XA8E7akTMpBtnJUtCY74
        Zbf/poyYxh1myoPsrklnP0j4UDmRJY0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338--A8elAhcMNWskA2B4Raa5A-1; Fri, 26 Nov 2021 04:04:05 -0500
X-MC-Unique: -A8elAhcMNWskA2B4Raa5A-1
Received: by mail-wm1-f69.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so5001827wms.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pBeC7fNu77y+gSatqqLKddyjvmoD+l8MjcB3oFZhODk=;
        b=YN77VnCRKHInNDkBNfXxMxfPDBkXMrICJP3nY4k7fd0OLHRAavcx+cstFBtG0u3Xy9
         t2vcCzZVJynG2/P2Q5uZFMCVvpzXzcteBZF51s2jKAs6L3h1Py3rGbRJ0tuvIpplgd0P
         BIkAIgUqDwblKx7xxsFjJbJi+gWB75aN/7Nr6bvtKyfLKJQy0+bazixkmSZk3mrKhbPL
         35zNmNGOF3yqN5hctrs1iMuF/rwBwZ9C0fvOHhE12CSesyjoLRL/+IuC44JQl/uRFUpi
         SJhcGAILotTJU4koillXkm6fwzEf8j6T1q4gZ8CHD20wsLIJxI/ARmCvyxPPD1fyNuZ8
         Q9Qw==
X-Gm-Message-State: AOAM533OPBQQiiif5w7mS4EWsj8EhIKkWt1sZfaVcCzYU1j7RYlecUM/
        7m7oCJZ6lHzHEsyHMSSAFX7WoEpeGZmnw95jZ21akmFoqWUiE303SlsaHMbPIZSHLv+sOaFdX6B
        l9poFpYYJXO0MluBtx3V9qmSp
X-Received: by 2002:adf:9e46:: with SMTP id v6mr12815245wre.579.1637917443866;
        Fri, 26 Nov 2021 01:04:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1dlanYH8GDldEysHXV09dUKcN/c6nLT9uALeauQ+jH6UiOSUrI6mi92jp+Lstidv4gX4iwQ==
X-Received: by 2002:adf:9e46:: with SMTP id v6mr12815225wre.579.1637917443652;
        Fri, 26 Nov 2021 01:04:03 -0800 (PST)
Received: from [192.168.3.132] (p5b0c69e1.dip0.t-ipconnect.de. [91.12.105.225])
        by smtp.gmail.com with ESMTPSA id b13sm1306456wrh.32.2021.11.26.01.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 01:04:03 -0800 (PST)
Message-ID: <d068c48d-897d-238b-010c-056951c9e3f1@redhat.com>
Date:   Fri, 26 Nov 2021 10:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "George G. Davis" <davis.george@siemens.com>
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local>
 <57d649c8-fe13-17cd-8819-2cd93500a79c@redhat.com>
 <YaBL1Ti+XnzG+fdK@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
In-Reply-To: <YaBL1Ti+XnzG+fdK@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.21 03:52, Peter Xu wrote:
> On Thu, Nov 25, 2021 at 11:32:08AM +0100, David Hildenbrand wrote:
>> On 25.11.21 11:24, Peter Xu wrote:
>>> On Mon, Nov 22, 2021 at 10:40:54AM -0800, Shakeel Butt wrote:
>>>>> Do we have a performance evaluation how much overhead is added e.g., for
>>>>> a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
>>>>> covers the whole THP?
>>>>
>>>> I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
>>>> x86 for both settings you suggested. I don't see any statistically
>>>> significant difference with and without the patch. Let me know if you
>>>> want me to try something else.
>>>
>>> I'm a bit surprised that sync split thp didn't bring any extra overhead.
>>>
>>> "unmap whole thp" is understandable from that pov, because afaict that won't
>>> even trigger any thp split anyway even delayed, if this is the simplest case
>>> that only this process mapped this thp, and it mapped once.
>>>
>>> For "unmap 4k upon thp" IIUC that's the worst case and zapping 4k should be
>>> fast; while what I don't understand since thp split requires all hand-made work
>>> for copying thp flags into small pages and so on, so I thought there should at
>>> least be some overhead measured.  Shakeel, could there be something overlooked
>>> in the test, or maybe it's me that overlooked?
>>>
>>> I had the same concern as what Kirill/Matthew raised in the other thread - I'm
>>> worried proactively splitting simply because any 4k page is zapped might
>>> quickly free up 2m thps in the system and I'm not sure whether it'll exaggerate
>>> the defragmentation of the system memory in general.  I'm also not sure whether
>>> that's ideal for some very common workload that frequently uses DONTNEED to
>>> proactively drop some pages.
>>
>> The pageblock corresponding to the THP is movable. So (unless we start
>> spilling unmovable allocations into movable pageblocks) we'd only place
>> movable allocations in there. Compaction will be able to migrate to
>> re-create a free THP.
>>
>> In contrast I think, compaction will happily skip over the THP and
>> ignore it, because it has no clue that the THP could be repurposed by
>> split+migrate (at least I am not aware of code that does it).
>>
>> Unless I am missing something, with the above in mind it could make
>> sense to split as soon as possible, even before we're under memory
>> pressure -- for example, for proactive compaction.
>>
>> [proactive compaction could try splitting first as well I think]
> 
> But we can't rely on proactive compaction for rapid operations, because it's
> still adding overhead to the overall system by split+merge, right?

Yes, but there is also direct compaction that can be triggered without
the shrinker getting involved. I think we can summarize as "there might
not be a right or wrong when to split". An application that
MADV_DONTNEEDs/munmap sub-THP memory told us that it doesn't want to
consume memory, yet it looks like it's still consuming that memory.

I do wonder how THP on the deferred split queue behave in respect to
page migration -- memory offlining, alloc_contig_range(). I saw reports
that there are some cases where THP can be problematic when
stress-testing THP:
https://lkml.kernel.org/r/20210903162102.GA10039@mam-gdavis-dt

But not sure if that's related to deferred splitting. Most probably not.

> 
> +compaction_proactiveness
> +========================
> + ...
> +Note that compaction has a non-trivial system-wide impact as pages
> +belonging to different processes are moved around, which could also lead
> +to latency spikes in unsuspecting applications. The kernel employs
> +various heuristics to avoid wasting CPU cycles if it detects that
> +proactive compaction is not being effective.
> 
> Delaying split makes sense to me because after all the kernel is not aware of
> the userspace's preference, so the best thing is to do nothing until necessary.
> 
> Proactively split thps in dontneed/unmap added an assumption that the userspace
> wants to break the pages by default.  It's 100% true for Shakeel's use case,
> but I'm not sure whether it may always be true.  That's why I thought maybe a
> new interface is more proper, so we at least won't break anyone by accident.

Well, we already broke the PMD into PTEs. So the performance gain at
least for that user is really gone until we "fix that" again via
khugepaged -- which might just be configured to not "fix" if there are
empty PTEs.

It for sure is interesting if you have a COW huge page and only one
party zaps/unmaps some part.


-- 
Thanks,

David / dhildenb

