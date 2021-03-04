Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8381B32CE30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhCDIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:14:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236288AbhCDIOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614845564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXmhmZ+FoUv+fepUyqVykFc4BakPLGiKzA7K40lwdt0=;
        b=YsnSyDnPfXVsuEJsQVQcNbQqZouxXT47k6XzysiutiexdRKUum7QLlDq/XGx8SJEshpXl4
        6dYB4iBMICcwB3qgtbfSGbg4MVP1qJVBNDDwxgSkJ1gIOYtob9+u80H8phSaRjOJBNrx8Q
        i61Po6F4CQQEJ1CkqVh0S5Qn6cAB73U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-VkxYFbjIPtSjoldO4VQadA-1; Thu, 04 Mar 2021 03:12:40 -0500
X-MC-Unique: VkxYFbjIPtSjoldO4VQadA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2B8D804330;
        Thu,  4 Mar 2021 08:12:37 +0000 (UTC)
Received: from [10.36.113.171] (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 818242C6F9;
        Thu,  4 Mar 2021 08:12:32 +0000 (UTC)
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
 <20210205185552.GA23216@willie-the-truck>
 <20210211115354.GB29894@willie-the-truck>
 <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
 <a54d7dcc-8603-6d3d-143f-b09c431b8e32@redhat.com>
 <20210303190428.GB24035@arm.com> <20210303212406.GB20055@willie-the-truck>
 <b8dfa24d-e287-0039-ea6d-f644f52f4dbf@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9872a864-15b1-12a7-6aac-0e68554bc744@redhat.com>
Date:   Thu, 4 Mar 2021 09:12:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b8dfa24d-e287-0039-ea6d-f644f52f4dbf@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 04:31, Anshuman Khandual wrote:
> 
> 
> On 3/4/21 2:54 AM, Will Deacon wrote:
>> On Wed, Mar 03, 2021 at 07:04:33PM +0000, Catalin Marinas wrote:
>>> On Thu, Feb 11, 2021 at 01:35:56PM +0100, David Hildenbrand wrote:
>>>> On 11.02.21 13:10, Anshuman Khandual wrote:
>>>>> On 2/11/21 5:23 PM, Will Deacon wrote:
>>>>>> ... and dropped. These patches appear to be responsible for a boot
>>>>>> regression reported by CKI:
>>>>>
>>>>> Ahh, boot regression ? These patches only change the behaviour
>>>>> for non boot memory only.
>>>>>
>>>>>> https://lore.kernel.org/r/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com
>>>>>
>>>>> Will look into the logs and see if there is something pointing to
>>>>> the problem.
>>>>
>>>> It's strange. One thing I can imagine is a mis-detection of early sections.
>>>> However, I don't see that happening:
>>>>
>>>> In sparse_init_nid(), we:
>>>> 1. Initialize the memmap
>>>> 2. Set SECTION_IS_EARLY | SECTION_HAS_MEM_MAP via
>>>>     sparse_init_one_section()
>>>>
>>>> Only hotplugged sections (DIMMs, dax/kmem) set SECTION_HAS_MEM_MAP without
>>>> SECTION_IS_EARLY - which is correct, because these are not early.
>>>>
>>>> So once we know that we have valid_section() -- SECTION_HAS_MEM_MAP is set
>>>> -- early_section() should be correct.
>>>>
>>>> Even if someone would be doing a pfn_valid() after
>>>> memblocks_present()->memory_present() but before
>>>> sparse_init_nid(), we should be fine (!valid_section() -> return 0).
>>>
>>> I couldn't figure out how this could fail with Anshuman's patches.
>>> Will's suspicion is that some invalid/null pointer gets dereferenced
>>> before being initialised but the only case I see is somewhere in
>>> pfn_section_valid() (ms->usage) if valid_section() && !early_section().
>>>
>>> Assuming that we do get a valid_section(ms) && !early_section(ms), is
>>> there a case where ms->usage is not initialised? I guess races with
>>> section_deactivate() are not possible this early.
>>>
>>> Another situation could be that pfn_valid() returns true when no memory
>>> is mapped for that pfn.
>>
>> The case I wondered about was __pfn_to_section() with a bogus pfn, since
>> with patch 2/2 we call that *before* checking that pfn_to_section_nr() is
>> sane.
> 
> Right, that is problematic. __pfn_to_section() should not be called without
> first validating pfn_to_section_nr(), as it could cause out-of-bound access
> on mem_section buffer. Will fix that order but as there is no test scenario
> which is definitive for this reported regression, how should we ensure that
> it fixes the problem ?

Oh, right, I missed that in patch #2. (and when comparing to generic 
pfn_valid()).

I thought bisecting pointed at patch #1, that's why I didn't even have 
another look at patch #2. Makes sense.

-- 
Thanks,

David / dhildenb

