Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D80F32C26D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376812AbhCCTna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:43:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240287AbhCCT1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614799494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZak1YCTeDCL5z28NbOLP4nsAVAJ3AftCQx5HMPyNmg=;
        b=IHXoo81MZawOAha165i2gryWMZgBb5yiprXT6mOjPaBjbC02MZj3eezQDvwkyVho87NfYc
        xGdFqmMVNAyWLLwIMUozSjcYITh1/xxPCVJCtg0LL21yZJ3MsMXxP/TKoKJ0U0kQJI5NA0
        DFJafWEHxVpFU0ame6JffjoUm9FS1Ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-qjA2q2YWP12qsw9B3FMcqA-1; Wed, 03 Mar 2021 14:24:50 -0500
X-MC-Unique: qjA2q2YWP12qsw9B3FMcqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1EAC73A0;
        Wed,  3 Mar 2021 19:24:49 +0000 (UTC)
Received: from [10.36.112.28] (ovpn-112-28.ams2.redhat.com [10.36.112.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C14E60BFA;
        Wed,  3 Mar 2021 19:24:45 +0000 (UTC)
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210202123215.GA16868@willie-the-truck>
 <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
 <20210205185552.GA23216@willie-the-truck>
 <20210211115354.GB29894@willie-the-truck>
 <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
 <a54d7dcc-8603-6d3d-143f-b09c431b8e32@redhat.com>
 <20210303190428.GB24035@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5c5eb731-a5b3-757b-fcf5-283eb268625b@redhat.com>
Date:   Wed, 3 Mar 2021 20:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303190428.GB24035@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.21 20:04, Catalin Marinas wrote:
> On Thu, Feb 11, 2021 at 01:35:56PM +0100, David Hildenbrand wrote:
>> On 11.02.21 13:10, Anshuman Khandual wrote:
>>> On 2/11/21 5:23 PM, Will Deacon wrote:
>>>> ... and dropped. These patches appear to be responsible for a boot
>>>> regression reported by CKI:
>>>
>>> Ahh, boot regression ? These patches only change the behaviour
>>> for non boot memory only.
>>>
>>>> https://lore.kernel.org/r/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com
>>>
>>> Will look into the logs and see if there is something pointing to
>>> the problem.
>>
>> It's strange. One thing I can imagine is a mis-detection of early sections.
>> However, I don't see that happening:
>>
>> In sparse_init_nid(), we:
>> 1. Initialize the memmap
>> 2. Set SECTION_IS_EARLY | SECTION_HAS_MEM_MAP via
>>     sparse_init_one_section()
>>
>> Only hotplugged sections (DIMMs, dax/kmem) set SECTION_HAS_MEM_MAP without
>> SECTION_IS_EARLY - which is correct, because these are not early.
>>
>> So once we know that we have valid_section() -- SECTION_HAS_MEM_MAP is set
>> -- early_section() should be correct.
>>
>> Even if someone would be doing a pfn_valid() after
>> memblocks_present()->memory_present() but before
>> sparse_init_nid(), we should be fine (!valid_section() -> return 0).
> 
> I couldn't figure out how this could fail with Anshuman's patches.
> Will's suspicion is that some invalid/null pointer gets dereferenced
> before being initialised but the only case I see is somewhere in
> pfn_section_valid() (ms->usage) if valid_section() && !early_section().

Indeed, it looks like a latent bug.

> 
> Assuming that we do get a valid_section(ms) && !early_section(ms), is
> there a case where ms->usage is not initialised? I guess races with
> section_deactivate() are not possible this early.
> 

Do you have access to that machine? We could identify which path is 
taken quite easily.

> Another situation could be that pfn_valid() returns true when no memory
> is mapped for that pfn.
> 
>> As it happens early during boot, I doubt that some NVDIMMs that get detected
>> and added early during boot as system RAM (via dax/kmem) are the problem.
> 
> It is indeed very early, we can't even get the early console output.

So even before any hotplug really happens. All sections should be early 
at that point I guess.

> Debugging this is even harder as it's only misbehaving on a board we
> don't have access to.
> 
> On the logic in this patch, is the hot-added memory always covering a
> full subsection? The arm64 pfn_valid() currently relies on
> memblock_is_map_memory() but the patch changes it to
> pfn_section_valid(). So if hot-added memory doesn't cover the full
> subsection, it may return true even if the pfn is not mapped.

Hotplugged System RAM always covers full sections. Hotplugged 
ZONE_DEVICE always covers full subsections. pfn_section_valid() properly 
handles both cases. (see generic pfn_valid())

-- 
Thanks,

David / dhildenb

