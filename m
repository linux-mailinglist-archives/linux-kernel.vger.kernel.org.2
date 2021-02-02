Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386BC30BEE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhBBM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231433AbhBBM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612270583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d68rpmNK8P9THEE+WZsflh6uEq5A5m7Cya/2Fvyn7KU=;
        b=ZVvgga3u1N+YAijOqIOBJDQzKTiObzuFayrWXgNkdR+q23Cyfx8iDRKxQrCl260HVTWm7i
        AaAZziUp+kqFqj4bYgwuKc0LZ3+YWGKhyyCFYGCiavJ4tL1ypcY7lYceky/ws0iAGH5N97
        sKrtzwewT9DH8Na2sCXZRe4tVj0nt2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-TbIzxk4-OKmY48wWmNZHAQ-1; Tue, 02 Feb 2021 07:56:19 -0500
X-MC-Unique: TbIzxk4-OKmY48wWmNZHAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7805C801B13;
        Tue,  2 Feb 2021 12:56:17 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA6405D9DC;
        Tue,  2 Feb 2021 12:56:11 +0000 (UTC)
Subject: Re: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
To:     Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
 <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
 <20210202123215.GA16868@willie-the-truck>
 <20210202123524.GB16868@willie-the-truck>
 <f32e7caa-3414-9dd7-eb8c-220da1d925a1@redhat.com>
 <20210202125152.GC16868@willie-the-truck>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4d8f5156-8628-5531-1485-322ad92aa15c@redhat.com>
Date:   Tue, 2 Feb 2021 13:56:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210202125152.GC16868@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.21 13:51, Will Deacon wrote:
> On Tue, Feb 02, 2021 at 01:39:29PM +0100, David Hildenbrand wrote:
>> On 02.02.21 13:35, Will Deacon wrote:
>>> On Tue, Feb 02, 2021 at 12:32:15PM +0000, Will Deacon wrote:
>>>> On Tue, Feb 02, 2021 at 09:41:53AM +0530, Anshuman Khandual wrote:
>>>>> pfn_valid() validates a pfn but basically it checks for a valid struct page
>>>>> backing for that pfn. It should always return positive for memory ranges
>>>>> backed with struct page mapping. But currently pfn_valid() fails for all
>>>>> ZONE_DEVICE based memory types even though they have struct page mapping.
>>>>>
>>>>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>>>>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>>>>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>>>>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>>>>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>>>>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>>>>> into the system via memremap_pages() called from a driver, their respective
>>>>> memory sections will not have SECTION_IS_EARLY set.
>>>>>
>>>>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>>>>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>>>>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>>>>> skipped as its always going to be positive and that will be an optimization
>>>>> for the normal hotplug memory. Like ZONE_DEVICE based memory, all normal
>>>>> hotplugged memory too will not have SECTION_IS_EARLY set for their sections
>>>>>
>>>>> Skipping memblock_is_map_memory() for all non early memory sections would
>>>>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>>>>> performance for normal hotplug memory as well.
>>>>
>>>> Hmm. Although I follow your logic, this does seem to rely on an awful lot of
>>>> assumptions to continue to hold true as the kernel evolves. In particular,
>>>> how do we ensure that early sections are always fully backed with
>>>
>>> Sorry, typo here:       ^^^ should be *non-early* sections.
>>
>> It might be a good idea to have a look at generic
>> include/linux/mmzone.h:pfn_valid()
> 
> The generic implementation already makes assumptions that aren't true on
> arm64, so that's why we've ended up with our own implementation. But the
> patches here put us in a position where I worry that pfn_valid() may return
> 'true' in future for cases where the underlying struct page is either
> non-existent or bogus, and debugging those failures really sucks. We had a
> raft of those back when NOMAP was introduced and I don't want to re-live
> that experience.

Yeah, and I agree when it comes to boot mem. However, the way generic 
memory hotplug/memremap infrastructure (->!early sections) works does 
not allow for such special cases you mention and would break quite some 
other code if messed up. So I wouldn't worry about that part too much 
for now.

> 
>> As I expressed already, long term we should really get rid of the arm64
>> variant and rather special-case the generic one. Then we won't go out of
>> sync - just as it happened with ZONE_DEVICE handling here.
> 
> Why does this have to be long term? This ZONE_DEVICE stuff could be the
> carrot on the stick :)

Yes, I suggested to do it now, but Anshuman convinced me that doing a 
simple fix upfront might be cleaner --- for example when it comes to 
backporting :)

-- 
Thanks,

David / dhildenb

