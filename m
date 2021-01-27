Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D43052C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhA0GD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:03:28 -0500
Received: from foss.arm.com ([217.140.110.172]:46828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237105AbhA0DrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:47:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32EF0139F;
        Tue, 26 Jan 2021 19:46:26 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3105B3F66B;
        Tue, 26 Jan 2021 19:46:21 -0800 (PST)
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <bb5b9c39-d25b-6170-68ea-5b2bf297c1fd@arm.com>
 <20210125073102.GF7648@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <42e9d8cc-ea8a-7a95-c3d4-232cd362547b@arm.com>
Date:   Wed, 27 Jan 2021 09:16:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125073102.GF7648@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/21 1:01 PM, Mike Rapoport wrote:
> On Mon, Jan 25, 2021 at 11:52:32AM +0530, Anshuman Khandual wrote:
>>
>> On 12/22/20 12:42 PM, Anshuman Khandual wrote:
>>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>>> into the system via memremap_pages() called from a driver, their respective
>>> memory sections will not have SECTION_IS_EARLY set.
>>>
>>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>>> skipped as its always going to be positive and that will be an optimization
>>> for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged
>>> normal memory too will not have SECTION_IS_EARLY set for their sections.
>>>
>>> Skipping memblock_is_map_memory() for all non early memory sections would
>>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>>> performance for normal hotplug memory as well.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> Hello David/Mike,
>>
>> Given that we would need to rework early sections, memblock semantics via a
>> new config i.e EARLY_SECTION_MEMMAP_HOLES and also some possible changes to
>> ARCH_KEEP_MEMBLOCK and HAVE_ARCH_PFN_VALID, wondering if these patches here
>> which fixes a problem (and improves performance) can be merged first. After
>> that, I could start working on the proposed rework. Could you please let me
>> know your thoughts on this. Thank you.
> 
> I didn't object to these patches, I think they are fine.
> I agree that we can look into update of arm64's pfn_valid(), maybe right
> after decrease of section size lands in.

Sure, will drop the RFC tag and prepare these patches.
