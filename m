Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A464375872
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhEFQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235167AbhEFQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620318520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6Yy2DeoFV2q1M9s+whrk/gaR4i+2vEmv7two1Af1Zg=;
        b=iT5Pd+tgdWskAEUlxF36yarOw4aAFWyBppAIZ7cmaFYYk4sCj0bzz2tyky34+YcQUPccQt
        +KMMNl/dO798eAzl+mHFFirB768jU9wFY42dEE/vdBIxoS8OyrJjnpNVlx0DlCWJq5B3bU
        MYF4yC30UIhOprn5mHeRvJytORj0hFA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-MquNzSHINO6qpsiU9bKZag-1; Thu, 06 May 2021 12:28:39 -0400
X-MC-Unique: MquNzSHINO6qpsiU9bKZag-1
Received: by mail-ed1-f69.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so2946124edu.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u6Yy2DeoFV2q1M9s+whrk/gaR4i+2vEmv7two1Af1Zg=;
        b=VUVtNQxqlhVWSt4/mWCrFW4mHZy1KkCarMrQgqf+wzhyIImURRjQuk+WtNfVAouPjP
         kRz43yzu3pjr+DPJ85aFW7Iy5cbc97dDRpMhsuZ8W2ELDXGHcEDmH4lQmPL5FNVzLRHd
         uvZIh15i2c4Kz5SSdLDfDiDEIz0I3Nu+k7bu5OkOqjQEihqIVuQle3cTtQ3MhS/UCRzE
         +p/4pWsS+RQjEF8vca03B1bfadmoCKv+CxxqU5jqZGeBhMXUET4hdT7tVHtBhMz2cm0Z
         BmvSkpaBRKJ4BSySOdvYadjAgTLB8XxVYiYVpVs/Db7saFbofPTWI3r5aamlaQHJFPN7
         VOfQ==
X-Gm-Message-State: AOAM532qyM8ycHd+Bl7380WIzBm0uRvgzDvOV4QE97izgKzB1dfoYsKV
        plqK43DJO3xFlfAhU17hI6xHsL/fgbbdGiRhxnon9ZpNz7QApP3Qxg7VrtGhyovU3ezPa4Ra7a4
        qZ7+tvGZoq1cv1YPzTGJto58+
X-Received: by 2002:a17:906:c40f:: with SMTP id u15mr5291063ejz.11.1620318517805;
        Thu, 06 May 2021 09:28:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIBstwIoHL3+1II6XHx8KFDHdJwSWiiY8FJejBQ6M4H/9tCY0WFC2mPVvB4tI88ziJezvAaw==
X-Received: by 2002:a17:906:c40f:: with SMTP id u15mr5291031ejz.11.1620318517505;
        Thu, 06 May 2021 09:28:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id 9sm1668199ejv.73.2021.05.06.09.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 09:28:37 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
Message-ID: <f3a2152c-685b-2141-3e33-b2bcab8b6010@redhat.com>
Date:   Thu, 6 May 2021 18:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <16962E62-7D1E-4E06-B832-EC91F54CC359@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 17:50, Zi Yan wrote:
> On 6 May 2021, at 11:40, David Hildenbrand wrote:
> 
>>>>> The last patch increases SECTION_SIZE_BITS to demonstrate the use of memory
>>>>> hotplug/hotremove subsection, but is not intended to be merged as is. It is
>>>>> there in case one wants to try this out and will be removed during the final
>>>>> submission.
>>>>>
>>>>> Feel free to give suggestions and comments. I am looking forward to your
>>>>> feedback.
>>>>
>>>> Please not like this.
>>>
>>> Do you mind sharing more useful feedback instead of just saying a lot of No?
>>
>> I remember reasoning about this already in another thread, no? Either you're ignoring my previous feedback or my mind is messing with me.
> 
> I definitely remember all your suggestions:
> 
> 1. do not use CMA allocation for 1GB THP.
> 2. section size defines the minimum size in which we can add_memory(), so we cannot increase it.
> 
> I am trying an alternative here. I am not using CMA allocation and not increasing the minimum size of add_memory() by decoupling the memory block size from section size, so that add_memory() can add a memory block smaller (as small as 2MB, the subsection size) than section size. In this way, section size can be increased freely. I do not see the strong tie between add_memory() and section size, especially we have subsection bitmap support.

Okay, let me express my thoughts, I could have sworn I explained back 
then why I am not a friend of messing with the existing pageblock size:

1. Pageblock size

There are a couple of features that rely on the pageblock size to be 
reasonably small to work as expected. One example is virtio-balloon free 
page reporting, then there is virtio-mem (still also glued MAX_ORDER) 
and we have CMA (still also glued to MAX_ORDER). Most probably there are 
more. We track movability/ page isolation per pageblock; it's the 
smallest granularity you can effectively isolate pages or mark them as 
CMA (MIGRATE_ISOLATE, MIGRATE_CMA). Well, and there are "ordinary" THP / 
huge pages most of our applications use and will use, especially on 
smallish systems.

Assume you bump up the pageblock order to 1G. Small VMs won't be able to 
report any free pages to the hypervisor. You'll take the "fine-grained" 
out of virtio-mem. Each CMA area will have to be at least 1G big, which 
turns CMA essentially useless on smallish systems (like we have on arm64 
with 64k base pages -- pageblock_size is 512MB and I hate it).

Then, imagine systems that have like 4G of main memory. By stopping 
grouping at 2M and instead grouping at 1G you can very easily find 
yourself in the system where all your 4 pageblocks are unmovable and you 
essentially don't optimize for huge pages in that environment any more.

Long story short: we need a different mechanism on top and shall leave 
the pageblock size untouched, it's too tightly integrated with page 
isolation, ordinary THP, and CMA.

2. Section size

I assume the only reason you want to touch that is because 
pageblock_size <= section_size, and I guess that's one of the reasons I 
dislike it so much. Messing with the section size really only makes 
sense when we want to manage metadata for larger granularity within a 
section.

We allocate metadata per section. We mark whole sections 
early/online/present/.... Yes, in case of vmemmap, we manage the memmap 
in smaller granularity using the sub-section map, some kind of hack to 
support some ZONE_DEVICE cases better.

Let's assume we introduce something new "gigapage_order", corresponding 
to 1G. We could either decide to squeeze the metadata into sections, 
having to increase the section size, or manage that metadata differently.

Managing it differently certainly makes the necessary changes easier. 
Instead of adding more hacks into sections, rather manage that metadata 
at differently place / in a different way.

See [1] for an alternative. Not necessarily what I would dream off, but 
just to showcase that there might be alternative to group pages.

3. Grouping pages > pageblock_order

There are other approaches that would benefit from grouping at > 
pageblock_order and having bigger MAX_ORDER. And that doesn't 
necessarily mean to form gigantic pages only, we might want to group in 
multiple granularity on a single system. Memory hot(un)plug is one 
example, but also optimizing memory consumption by powering down DIMM 
banks. Also, some architectures support differing huge page sizes 
(aarch64) that could be improved without CMA. Why not have more than 2 
THP sizes on these systems?

Ideally, we'd have a mechanism that tries grouping on different 
granularity, like for every order in pageblock_order ... 
max_pageblock_order (e.g., 1 GiB), and not only add one new level of 
grouping (or increase the single grouping size).

[1] https://lkml.kernel.org/r/20210414023803.937-1-lipeifeng@oppo.com

-- 
Thanks,

David / dhildenb

