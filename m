Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7238C32F271
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhCESYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhCESYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614968678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNT9fJ85J6oSGdxkAJMQPYTV29ndRMM0I5qlalEdePA=;
        b=XnVi1x3RvpNA6p41b49VfdAFlggSHp5B/IKk5JOip460pYL9qmBrCxgObKooVaGCxfeMRo
        Y2aMK1whpfOASUz6AqN5PXoSFCiUys6Hz1nURWCradzYtNBAuu0C3+XzZWLIK0U28pJ+Qk
        Mjy8HNecWf/SaBi9Hm0FqGZlsuA+8ng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-2JW58ZZ-Nb21e_7MNxD95g-1; Fri, 05 Mar 2021 13:24:34 -0500
X-MC-Unique: 2JW58ZZ-Nb21e_7MNxD95g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9377D760C1;
        Fri,  5 Mar 2021 18:24:31 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9B551F456;
        Fri,  5 Mar 2021 18:24:21 +0000 (UTC)
Subject: Re: [PATCH V3 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Veronika Kabatova <vkabatov@redhat.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
 <1614921898-4099-2-git-send-email-anshuman.khandual@arm.com>
 <20210305181322.GI23855@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e446810c-2020-9f21-79ba-6ede473447da@redhat.com>
Date:   Fri, 5 Mar 2021 19:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305181322.GI23855@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.03.21 19:13, Catalin Marinas wrote:
> On Fri, Mar 05, 2021 at 10:54:57AM +0530, Anshuman Khandual wrote:
>> pfn_valid() validates a pfn but basically it checks for a valid struct page
>> backing for that pfn. It should always return positive for memory ranges
>> backed with struct page mapping. But currently pfn_valid() fails for all
>> ZONE_DEVICE based memory types even though they have struct page mapping.
>>
>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>> into the system via memremap_pages() called from a driver, their respective
>> memory sections will not have SECTION_IS_EARLY set.
>>
>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>> skipped as its always going to be positive and that will be an optimization
>> for the normal hotplug memory. Like ZONE_DEVICE based memory, all normal
>> hotplugged memory too will not have SECTION_IS_EARLY set for their sections
>>
>> Skipping memblock_is_map_memory() for all non early memory sections would
>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>> performance for normal hotplug memory as well.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/mm/init.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 0ace5e68efba..5920c527845a 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -230,6 +230,18 @@ int pfn_valid(unsigned long pfn)
>>   
>>   	if (!valid_section(__pfn_to_section(pfn)))
>>   		return 0;
>> +
>> +	/*
>> +	 * ZONE_DEVICE memory does not have the memblock entries.
>> +	 * memblock_is_map_memory() check for ZONE_DEVICE based
>> +	 * addresses will always fail. Even the normal hotplugged
>> +	 * memory will never have MEMBLOCK_NOMAP flag set in their
>> +	 * memblock entries. Skip memblock search for all non early
>> +	 * memory sections covering all of hotplug memory including
>> +	 * both normal and ZONE_DEVICE based.
>> +	 */
>> +	if (!early_section(__pfn_to_section(pfn)))
>> +		return pfn_section_valid(__pfn_to_section(pfn), pfn);
> 
> Would something like this work instead:
> 
> 	if (online_device_section(ms))
> 		return 1;
> 
> to avoid the assumptions around early_section()?
> 

Please keep online section logic out of pfn valid logic. Tow different 
things. (and rather not diverge too much from generic pfn_valid() - we 
want to achieve the opposite in the long term, merging both implementations)

-- 
Thanks,

David / dhildenb

