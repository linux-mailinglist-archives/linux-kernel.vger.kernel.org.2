Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FFE36666B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhDUHuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhDUHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618991368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAnhPgTmK2rneM8QtGU7sZ7Ohw+rHF0KbVh21PjcnDI=;
        b=GmVgWJtZMvqMiG4n5uyIkPZmX9Cp/55FY2coFigOzvGSz9p3bz1rOl74+G6E885+CdpBR6
        THqm9c/Hm5JkHaZ5s+ULeDnDci8yD3WCbQ6A8q/YGzJL99nI3gRMYGD7GjEwFseynHN3Ya
        Hcs6MrmTFYtGns48inUL+Cru7Ybrdgk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-GaK-baPnNUm05XkVUR4oew-1; Wed, 21 Apr 2021 03:49:26 -0400
X-MC-Unique: GaK-baPnNUm05XkVUR4oew-1
Received: by mail-ej1-f70.google.com with SMTP id p25-20020a1709061419b0290378364a6464so5585725ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JAnhPgTmK2rneM8QtGU7sZ7Ohw+rHF0KbVh21PjcnDI=;
        b=nemN6jKD/5lmaWqv0oZB8YToK+19nS0RYGKl4lePtYkwqL2uaTlAtjkeBecn610VCL
         s+NafgelHM1Eh/qhbR1CkY+ikDrEmgRAlRfhQybHzEIPYjByyVIWEo9hEV+bUEc/wMlo
         mI/w2/NcyIVMqkZxlHbdsP5DmGXI6/sMgsvxxgE9f1TbHEpl3w+9MLoxD17suRIzcxjq
         nwkj7u9PS6ndgog64EtLd2VH0cQ3jnrXTh2FoRNpPZwCCooezXCTpwxM7mjjrboMQzfm
         dB+L0ucFqqgN6qM5GWjQOAObb+q2slNFJWRCEgtRnp6zxqwHJ+uM2Jwuwz+/2cYjf8NU
         2loQ==
X-Gm-Message-State: AOAM531m6k5AEW8rGehLy6eWdKcTS4q8pL6mSdO2yk3m3lrAWCdHKn7k
        2rtnimIg+KX0RMQZChfFrRx/cwpuRKywxBJnWFA9WRrvnhBiOfzE82NyvTa1J//MRuhHnq14uzD
        mfatzQBt3STmKWiXDN+mXu2y4
X-Received: by 2002:a05:6402:78d:: with SMTP id d13mr36472252edy.277.1618991365303;
        Wed, 21 Apr 2021 00:49:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPQEw8LMNntsFe7QRyIPhtcWOmJcDhJxCGo22DUKTe+vv1GhR0JyZ5rACKKiobJsNfEOkgTA==
X-Received: by 2002:a05:6402:78d:: with SMTP id d13mr36472231edy.277.1618991365082;
        Wed, 21 Apr 2021 00:49:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64b8.dip0.t-ipconnect.de. [91.12.100.184])
        by smtp.gmail.com with ESMTPSA id t1sm1510968eju.88.2021.04.21.00.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:49:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] memblock: update initialization of reserved pages
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210421065108.1987-1-rppt@kernel.org>
 <20210421065108.1987-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <752fd822-6479-53f1-81fb-24b55500e963@redhat.com>
Date:   Wed, 21 Apr 2021 09:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421065108.1987-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 08:51, Mike Rapoport wrote:
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
>   include/linux/memblock.h |  4 +++-
>   mm/memblock.c            | 28 ++++++++++++++++++++++++++--
>   2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 5984fff3f175..634c1a578db8 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -30,7 +30,9 @@ extern unsigned long long max_possible_pfn;
>    * @MEMBLOCK_NONE: no special request
>    * @MEMBLOCK_HOTPLUG: hotpluggable region
>    * @MEMBLOCK_MIRROR: mirrored region
> - * @MEMBLOCK_NOMAP: don't add to kernel direct mapping
> + * @MEMBLOCK_NOMAP: don't add to kernel direct mapping and treat as
> + * reserved in the memory map; refer to memblock_mark_nomap() description
> + * for futher details
>    */
>   enum memblock_flags {
>   	MEMBLOCK_NONE		= 0x0,	/* No special request */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index afaefa8fc6ab..3abf2c3fea7f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -906,6 +906,11 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>    * @base: the base phys addr of the region
>    * @size: the size of the region
>    *
> + * The memory regions marked with %MEMBLOCK_NOMAP will not be added to the
> + * direct mapping of the physical memory. These regions will still be
> + * covered by the memory map. The struct page representing NOMAP memory
> + * frames in the memory map will be PageReserved()
> + *
>    * Return: 0 on success, -errno on failure.
>    */
>   int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
> @@ -2002,6 +2007,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
>   	return end_pfn - start_pfn;
>   }
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
> +}
> +
>   static unsigned long __init free_low_memory_core_early(void)
>   {
>   	unsigned long count = 0;
> @@ -2010,8 +2035,7 @@ static unsigned long __init free_low_memory_core_early(void)
>   
>   	memblock_clear_hotplug(0, -1);
>   
> -	for_each_reserved_mem_range(i, &start, &end)
> -		reserve_bootmem_region(start, end);
> +	memmap_init_reserved_pages();
>   
>   	/*
>   	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

