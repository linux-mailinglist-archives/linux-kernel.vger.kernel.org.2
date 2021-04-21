Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1F366976
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhDUKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:51:43 -0400
Received: from foss.arm.com ([217.140.110.172]:59154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhDUKvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:51:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A75F8113E;
        Wed, 21 Apr 2021 03:51:07 -0700 (PDT)
Received: from [10.163.74.228] (unknown [10.163.74.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE0013F73B;
        Wed, 21 Apr 2021 03:51:03 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 2/4] memblock: update initialization of reserved pages
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210421065108.1987-1-rppt@kernel.org>
 <20210421065108.1987-3-rppt@kernel.org>
Message-ID: <4d3844f1-3cb2-32cb-5222-ed023843970e@arm.com>
Date:   Wed, 21 Apr 2021 16:21:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421065108.1987-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/21 12:21 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The struct pages representing a reserved memory region are initialized
> using reserve_bootmem_range() function. This function is called for each
> reserved region just before the memory is freed from memblock to the buddy
> page allocator.
> 
> The struct pages for MEMBLOCK_NOMAP regions are kept with the default
> values set by the memory map initialization which makes it necessary to
> have a special treatment for such pages in pfn_valid() and
> pfn_valid_within().
> 
> Split out initialization of the reserved pages to a function with a
> meaningful name and treat the MEMBLOCK_NOMAP regions the same way as the
> reserved regions and mark struct pages for the NOMAP regions as
> PageReserved.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  include/linux/memblock.h |  4 +++-
>  mm/memblock.c            | 28 ++++++++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 5984fff3f175..634c1a578db8 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -30,7 +30,9 @@ extern unsigned long long max_possible_pfn;
>   * @MEMBLOCK_NONE: no special request
>   * @MEMBLOCK_HOTPLUG: hotpluggable region
>   * @MEMBLOCK_MIRROR: mirrored region
> - * @MEMBLOCK_NOMAP: don't add to kernel direct mapping
> + * @MEMBLOCK_NOMAP: don't add to kernel direct mapping and treat as
> + * reserved in the memory map; refer to memblock_mark_nomap() description
> + * for futher details

Small nit - s/futher/further

>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index afaefa8fc6ab..3abf2c3fea7f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -906,6 +906,11 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>   * @base: the base phys addr of the region
>   * @size: the size of the region
>   *
> + * The memory regions marked with %MEMBLOCK_NOMAP will not be added to the
> + * direct mapping of the physical memory. These regions will still be
> + * covered by the memory map. The struct page representing NOMAP memory
> + * frames in the memory map will be PageReserved()
> + *
>   * Return: 0 on success, -errno on failure.
>   */
>  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
> @@ -2002,6 +2007,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
>  	return end_pfn - start_pfn;
>  }
>  
> +static void __init memmap_init_reserved_pages(void)
> +{
> +	struct memblock_region *region;
> +	phys_addr_t start, end;
> +	u64 i;
> +
> +	/* initialize struct pages for the reserved regions */
> +	for_each_reserved_mem_range(i, &start, &end)
> +		reserve_bootmem_region(start, end);
> +
> +	/* and also treat struct pages for the NOMAP regions as PageReserved */
> +	for_each_mem_region(region) {
> +		if (memblock_is_nomap(region)) {
> +			start = region->base;
> +			end = start + region->size;
> +			reserve_bootmem_region(start, end);
> +		}
> +	}

I guess there is no possible method to unify both these loops.

> +}
> +
>  static unsigned long __init free_low_memory_core_early(void)
>  {
>  	unsigned long count = 0;
> @@ -2010,8 +2035,7 @@ static unsigned long __init free_low_memory_core_early(void)
>  
>  	memblock_clear_hotplug(0, -1);
>  
> -	for_each_reserved_mem_range(i, &start, &end)
> -		reserve_bootmem_region(start, end);
> +	memmap_init_reserved_pages();
>  
>  	/*
>  	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
> 


Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
