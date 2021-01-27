Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ADA305704
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhA0Jd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235309AbhA0JbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611739786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ItSoLVGYUiCKrPAbo40LokW1ZKTdfq0+45C+lOgmDE=;
        b=Ah3OMtDDA1j6z7MfpKCoZiS0XWHl8L4fXgAltk6M7aVDnXVYT5YikPNm9IycpG67aYC6ka
        N8fgEzGQYnESfHTydnHa3Ne78godQeDt3CACV+GsM7ZnEuG6YQMighs4nEy6CRoa9Xl1fc
        1D8TOine0a1i9hSgz9E4WqlD2zEPm/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-ptvbeAz4MFSs7M6zZKZacw-1; Wed, 27 Jan 2021 04:29:42 -0500
X-MC-Unique: ptvbeAz4MFSs7M6zZKZacw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 608A3801817;
        Wed, 27 Jan 2021 09:29:40 +0000 (UTC)
Received: from [10.36.114.237] (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A87C85D9C6;
        Wed, 27 Jan 2021 09:29:37 +0000 (UTC)
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <bb5b9c39-d25b-6170-68ea-5b2bf297c1fd@arm.com>
 <d527c0b8-415b-2425-9f4a-9edec43d8ae5@redhat.com>
 <4c7a92f3-4c5a-c3c6-7fed-befed2f3d3cb@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Message-ID: <8ad7d1d2-6d0a-1c3c-5c18-3d5b8ca5feb8@redhat.com>
Date:   Wed, 27 Jan 2021 10:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <4c7a92f3-4c5a-c3c6-7fed-befed2f3d3cb@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.21 05:06, Anshuman Khandual wrote:
> 
> 
> On 1/25/21 2:43 PM, David Hildenbrand wrote:
>> On 25.01.21 07:22, Anshuman Khandual wrote:
>>>
>>> On 12/22/20 12:42 PM, Anshuman Khandual wrote:
>>>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>>>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>>>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>>>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>>>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>>>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>>>> into the system via memremap_pages() called from a driver, their respective
>>>> memory sections will not have SECTION_IS_EARLY set.
>>>>
>>>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>>>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>>>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>>>> skipped as its always going to be positive and that will be an optimization
>>>> for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged
>>>> normal memory too will not have SECTION_IS_EARLY set for their sections.
>>>>
>>>> Skipping memblock_is_map_memory() for all non early memory sections would
>>>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>>>> performance for normal hotplug memory as well.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>
>>> Hello David/Mike,
>>>
>>> Given that we would need to rework early sections, memblock semantics via a
>>> new config i.e EARLY_SECTION_MEMMAP_HOLES and also some possible changes to
>>> ARCH_KEEP_MEMBLOCK and HAVE_ARCH_PFN_VALID, wondering if these patches here
>>> which fixes a problem (and improves performance) can be merged first. After
>>> that, I could start working on the proposed rework. Could you please let me
>>> know your thoughts on this. Thank you.
>>
>> As I said, we might have to throw in an pfn_section_valid() check, to
>> catch not-section-aligned ZONE_DEVICE ranges (I assume this is possible
>> on arm64 as well, no?).
> 
> pfn_section_valid() should be called only for !early_section() i.e normal
> hotplug and ZONE_DEVICE memory ? Because early boot memory should always
> be section aligned.

Well, at least not on x86-64 you can have early sections intersect with 
ZONE_DEVICE memory.

E.g., have 64MB boot memory in a section. Later, we add ZONE_DEVICE 
memory which might cover the remaining 64MB. For pfn_valid() on x86-64, 
we always return "true" for such sections, because we always have the 
memmap for the whole early section allocated during boot. So, there it's 
"simple".

Now, arm64 seems to discard some parts of the vmemmap, so the remaining 
64MB in such an early section might not have a memmap anymore? TBH, I 
don't know.

Most probably only performing the check for
!early_section() is sufficient on arm64, but I really can't tell as I 
don't know what we're actually discarding and if something as described 
for x86-64 is even possible on arm64.

We should really try to take the magic out of arm64 vmemmap handling.

> 
>>
>> Apart from that, I'm fine with a simple fix upfront, that can be more
>> easily backported if needed. (Q: do we? is this stable material?)
>>
> 
> Right, an upfront fix here would help in backporting. AFAICS it should be
> backported to the stable as pte_devmap and ZONE_DEVICE have been around
> for some time now. Do you have a particular stable version which needs to
> be tagged in the patch ?

I haven't looked yet TBH. I guess it is broken since ZONE_DEVICE was 
enabled on arm64?

-- 
Thanks,

David / dhildenb

