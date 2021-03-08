Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2174331560
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCHR7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhCHR7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:59:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C92C3652AB;
        Mon,  8 Mar 2021 17:59:32 +0000 (UTC)
Date:   Mon, 8 Mar 2021 17:59:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: Re: [PATCH V3 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210308175928.GG15644@arm.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
 <1614921898-4099-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614921898-4099-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 10:54:57AM +0530, Anshuman Khandual wrote:
> pfn_valid() validates a pfn but basically it checks for a valid struct page
> backing for that pfn. It should always return positive for memory ranges
> backed with struct page mapping. But currently pfn_valid() fails for all
> ZONE_DEVICE based memory types even though they have struct page mapping.
> 
> pfn_valid() asserts that there is a memblock entry for a given pfn without
> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
> that they do not have memblock entries. Hence memblock_is_map_memory() will
> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
> into the system via memremap_pages() called from a driver, their respective
> memory sections will not have SECTION_IS_EARLY set.
> 
> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
> for firmware reserved memory regions. memblock_is_map_memory() can just be
> skipped as its always going to be positive and that will be an optimization
> for the normal hotplug memory. Like ZONE_DEVICE based memory, all normal
> hotplugged memory too will not have SECTION_IS_EARLY set for their sections
> 
> Skipping memblock_is_map_memory() for all non early memory sections would
> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
> performance for normal hotplug memory as well.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: David Hildenbrand <david@redhat.com>
> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/init.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 0ace5e68efba..5920c527845a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -230,6 +230,18 @@ int pfn_valid(unsigned long pfn)
>  
>  	if (!valid_section(__pfn_to_section(pfn)))
>  		return 0;
> +
> +	/*
> +	 * ZONE_DEVICE memory does not have the memblock entries.
> +	 * memblock_is_map_memory() check for ZONE_DEVICE based
> +	 * addresses will always fail. Even the normal hotplugged
> +	 * memory will never have MEMBLOCK_NOMAP flag set in their
> +	 * memblock entries. Skip memblock search for all non early
> +	 * memory sections covering all of hotplug memory including
> +	 * both normal and ZONE_DEVICE based.
> +	 */
> +	if (!early_section(__pfn_to_section(pfn)))
> +		return pfn_section_valid(__pfn_to_section(pfn), pfn);
>  #endif
>  	return memblock_is_map_memory(addr);
>  }

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
