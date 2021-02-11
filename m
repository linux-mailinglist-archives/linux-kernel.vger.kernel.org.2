Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA3318B64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBKNB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhBKMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613046964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fiUqvzBbyW3Or5eLqyBvuv+nCbH+AW4zspow+cko5uE=;
        b=cAX0c+C5sAxTylREguUlsO1JTsaw4ZH4DDBPic8j/Rf7li5KfAIzjtiW99uk0+RD0z8itj
        LqgBgWVeZj5MmDS43j0JfDdX1QSxNZEkab+rQ2bDzokjHHpwoAx8O2Hk+yNuUWmfcXQIHc
        Bqmq2KQ5bratmcbRbXmhdkf3tONh99U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-YUnEXGODOreni50aXvTbqQ-1; Thu, 11 Feb 2021 07:36:02 -0500
X-MC-Unique: YUnEXGODOreni50aXvTbqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F41B0801965;
        Thu, 11 Feb 2021 12:35:59 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3616360BF1;
        Thu, 11 Feb 2021 12:35:57 +0000 (UTC)
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
 <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
 <20210202123215.GA16868@willie-the-truck>
 <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
 <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
 <0e649f28-4d54-319d-f876-8a93870cda7f@arm.com>
 <20210205185552.GA23216@willie-the-truck>
 <20210211115354.GB29894@willie-the-truck>
 <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <a54d7dcc-8603-6d3d-143f-b09c431b8e32@redhat.com>
Date:   Thu, 11 Feb 2021 13:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <23e5eb93-a39c-c68e-eac1-c5ccf9036079@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.21 13:10, Anshuman Khandual wrote:
> 
> 
> On 2/11/21 5:23 PM, Will Deacon wrote:
>> On Fri, Feb 05, 2021 at 06:55:53PM +0000, Will Deacon wrote:
>>> On Wed, Feb 03, 2021 at 09:20:39AM +0530, Anshuman Khandual wrote:
>>>> On 2/2/21 6:26 PM, David Hildenbrand wrote:
>>>>> On 02.02.21 13:51, Will Deacon wrote:
>>>>>> On Tue, Feb 02, 2021 at 01:39:29PM +0100, David Hildenbrand wrote:
>>>>>>> As I expressed already, long term we should really get rid of the arm64
>>>>>>> variant and rather special-case the generic one. Then we won't go out of
>>>>>>> sync - just as it happened with ZONE_DEVICE handling here.
>>>>>>
>>>>>> Why does this have to be long term? This ZONE_DEVICE stuff could be the
>>>>>> carrot on the stick :)
>>>>>
>>>>> Yes, I suggested to do it now, but Anshuman convinced me that doing a
>>>>> simple fix upfront might be cleaner --- for example when it comes to
>>>>> backporting :)
>>>>
>>>> Right. The current pfn_valid() breaks for ZONE_DEVICE memory and this fixes
>>>> the problem in the present context which can be easily backported if required.
>>>>
>>>> Changing or rather overhauling the generic code with new configs as proposed
>>>> earlier (which I am planning to work on subsequently) would definitely be an
>>>> improvement for the current pfn_valid() situation in terms of maintainability
>>>> but then it should not stop us from fixing the problem now.
>>>
>>> Alright, I've mulled this over a bit. I don't agree that this patch helps
>>> with maintainability (quite the opposite, in fact), but perfection is the
>>> enemy of the good so I'll queue the series for 5.12. However, I'll revert
>>> the changes at the first sign of a problem, so please do work towards a
>>> generic solution which can replace this in the medium term.
>>
>> ... and dropped. These patches appear to be responsible for a boot
>> regression reported by CKI:
> 
> Ahh, boot regression ? These patches only change the behaviour
> for non boot memory only.
> 
>>
>> https://lore.kernel.org/r/cki.8D1CB60FEC.K6NJMEFQPV@redhat.com
> 
> Will look into the logs and see if there is something pointing to
> the problem.
> 

It's strange. One thing I can imagine is a mis-detection of early 
sections. However, I don't see that happening:

In sparse_init_nid(), we:
1. Initialize the memmap
2. Set SECTION_IS_EARLY | SECTION_HAS_MEM_MAP via
    sparse_init_one_section()

Only hotplugged sections (DIMMs, dax/kmem) set SECTION_HAS_MEM_MAP 
without SECTION_IS_EARLY - which is correct, because these are not early.

So once we know that we have valid_section() -- SECTION_HAS_MEM_MAP is 
set -- early_section() should be correct.

Even if someone would be doing a pfn_valid() after 
memblocks_present()->memory_present() but before
sparse_init_nid(), we should be fine (!valid_section() -> return 0).


As it happens early during boot, I doubt that some NVDIMMs that get 
detected and added early during boot as system RAM (via dax/kmem). Are 
the problem.

-- 
Thanks,

David / dhildenb

