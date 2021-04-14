Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F061935F752
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348723AbhDNPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229661AbhDNPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618413136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvGZLtj/JZR18KhKppCpw2o1u6Vet6Jv6a+C3P66ArY=;
        b=Z35UkNKBkIK0hGHpQD8SHKm76+gdePDQ0HKztJG4P5Eq50Ylen3jHjl9dcIn05dnSjnstK
        ptk6XpYM1j94A1mdeYcSXuFmmdKrQ5N4uAfXbPPeD25l1LWIn8epjeuBOIjVf6ZYFrvp5U
        m5Gx0uMbVhM2n7oonL0zWifv4P8t0ws=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-jZ1pD_1oP0uJpXOi25PFxg-1; Wed, 14 Apr 2021 11:12:14 -0400
X-MC-Unique: jZ1pD_1oP0uJpXOi25PFxg-1
Received: by mail-wr1-f71.google.com with SMTP id j4-20020adfe5040000b0290102bb319b87so1209995wrm.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OvGZLtj/JZR18KhKppCpw2o1u6Vet6Jv6a+C3P66ArY=;
        b=YLG6V6TYkaPb4NpjKpd0/fKm2MKp/GP+21CcoBypNfNlyHxYdB57fi8AcWyL9fY1mJ
         Mo+xpNkyhkWu8z4A8RNeXJxRqbU28CZVN+QD82RIZCwSmzpX0P2TXiM3/1oiHaKrGwzQ
         VxHDtOrLL3uijJDFm5YpH/jUJeb2Z+o3fsIt7yh2gBWDT/l1GBWsr5jekte7dxppxWaP
         z4DC7q1f6no1Y6HCeS4oX/oczPuPrHeOnMf6LLK2W4Saam178hvOCBL+TVOsfHnZTH5E
         WQcQ+c8SyR15Lv3VAhr1eMj9Qq43oMkrMUwbITsDRvFMxVfK2pmWktrWVkPMPf+Cm3im
         ckhw==
X-Gm-Message-State: AOAM533MhBW84g2Ahrt5kouPI2Ae38Nnz1Fjy+mZht+M3BOIQCaQ9doN
        q40Tz6TxkRlIE3xK9ALpHddPuoJH6ZBb/NISKYxSzm5sxjlmRrRK5AE7HpesKaoPRLTmuJ6RNpe
        ZCaVvbn+6dgnDc/UA4KTgLGxA
X-Received: by 2002:a1c:f614:: with SMTP id w20mr3490000wmc.70.1618413132949;
        Wed, 14 Apr 2021 08:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwpIn8nv9v5Y/Dtcv6mOc3r8te/FMqBM0g0pALidkDsp7h2aVJV3ZZM5WuTLB2ksnnlanbKw==
X-Received: by 2002:a1c:f614:: with SMTP id w20mr3489987wmc.70.1618413132740;
        Wed, 14 Apr 2021 08:12:12 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id z14sm334347wrt.54.2021.04.14.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:12:12 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
Date:   Wed, 14 Apr 2021 17:12:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407172607.8812-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.21 19:26, Mike Rapoport wrote:
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

I assume these pages are never given to the buddy, because we don't have 
a direct mapping. So to the kernel, it's essentially just like a memory 
hole with benefits.

I can spot that we want to export such memory like any special memory 
thingy/hole in /proc/iomem -- "reserved", which makes sense.

I would assume that MEMBLOCK_NOMAP is a special type of *reserved* 
memory. IOW, that for_each_reserved_mem_range() should already succeed 
on these as well -- we should mark anything that is MEMBLOCK_NOMAP 
implicitly as reserved. Or are there valid reasons not to do so? What 
can anyone do with that memory?

I assume they are pretty much useless for the kernel, right? Like other 
reserved memory ranges.


> 
> Split out initialization of the reserved pages to a function with a
> meaningful name and treat the MEMBLOCK_NOMAP regions the same way as the
> reserved regions and mark struct pages for the NOMAP regions as
> PageReserved.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/memblock.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index afaefa8fc6ab..6b7ea9d86310 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2002,6 +2002,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
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
> @@ -2010,8 +2030,7 @@ static unsigned long __init free_low_memory_core_early(void)
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


-- 
Thanks,

David / dhildenb

