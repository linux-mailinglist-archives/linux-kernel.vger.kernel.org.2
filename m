Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC23C36E8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbhD2KXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:23:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5141 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhD2KXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:23:44 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FWBN64d9gzYc5p;
        Thu, 29 Apr 2021 18:20:38 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 29 Apr 2021 18:22:56 +0800
Received: from [10.174.177.244] (10.174.177.244) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 18:22:55 +0800
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Will Deacon" <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
 <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
 <YIpY8TXCSc7Lfa2Z@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
Date:   Thu, 29 Apr 2021 18:22:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YIpY8TXCSc7Lfa2Z@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/29 14:57, Mike Rapoport wrote:

>>> Do you use SPARSMEM? If yes, what is your section size?
>>> What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?
>> Yes,
>>
>> CONFIG_SPARSEMEM=y
>>
>> CONFIG_SPARSEMEM_STATIC=y
>>
>> CONFIG_FORCE_MAX_ZONEORDER = 11
>>
>> CONFIG_PAGE_OFFSET=0xC0000000
>> CONFIG_HAVE_ARCH_PFN_VALID=y
>> CONFIG_HIGHMEM=y
>> #define SECTION_SIZE_BITS    26
>> #define MAX_PHYSADDR_BITS    32
>> #define MAX_PHYSMEM_BITS     32


With the patch,  the addr is aligned, but the panic still occurred,

new free memory log is below,

memblock_free: [0xaf430000-0xaf44ffff] mem_init+0x158/0x23c

memblock_free: [0xaf510000-0xaf53ffff] mem_init+0x158/0x23c
memblock_free: [0xaf560000-0xaf57ffff] mem_init+0x158/0x23c
memblock_free: [0xafd98000-0xafdc7fff] mem_init+0x158/0x23c
memblock_free: [0xafdd8000-0xafdfffff] mem_init+0x158/0x23c
memblock_free: [0xafe18000-0xafe7ffff] mem_init+0x158/0x23c
memblock_free: [0xafee0000-0xafefffff] mem_init+0x158/0x23c
__free_memory_core, range: 0x80a03000 - 0x80a04000, pfn: 80a03 - 80a04
__free_memory_core, range: 0x80a08000 - 0x80b00000, pfn: 80a08 - 80b00
__free_memory_core, range: 0x812e8058 - 0x83000000, pfn: 812e9 - 83000
__free_memory_core, range: 0x85000000 - 0x85600000, pfn: 85000 - 85600
__free_memory_core, range: 0x86a00000 - 0x87e00000, pfn: 86a00 - 87e00
__free_memory_core, range: 0x8bd00000 - 0x8c500000, pfn: 8bd00 - 8c500
__free_memory_core, range: 0x8e300000 - 0x8ed00000, pfn: 8e300 - 8ed00
__free_memory_core, range: 0x90d00000 - 0xaf2c0000, pfn: 90d00 - af2c0
__free_memory_core, range: 0xaf430000 - 0xaf450000, pfn: af430 - af450
__free_memory_core, range: 0xaf510000 - 0xaf540000, pfn: af510 - af540
__free_memory_core, range: 0xaf560000 - 0xaf580000, pfn: af560 - af580
__free_memory_core, range: 0xafd98000 - 0xafdc8000, pfn: afd98 - afdc8
__free_memory_core, range: 0xafdd8000 - 0xafe00000, pfn: afdd8 - afe00
__free_memory_core, range: 0xafe18000 - 0xafe80000, pfn: afe18 - afe80
__free_memory_core, range: 0xafee0000 - 0xaff00000, pfn: afee0 - aff00
__free_memory_core, range: 0xaff80000 - 0xaff8d000, pfn: aff80 - aff8d
__free_memory_core, range: 0xafff2000 - 0xafff4580, pfn: afff2 - afff4
__free_memory_core, range: 0xafffe000 - 0xafffe0e0, pfn: afffe - afffe
__free_memory_core, range: 0xafffe4fc - 0xafffe500, pfn: affff - afffe
__free_memory_core, range: 0xafffe6e4 - 0xafffe700, pfn: affff - afffe
__free_memory_core, range: 0xafffe8dc - 0xafffe8e0, pfn: affff - afffe
__free_memory_core, range: 0xafffe970 - 0xafffe980, pfn: affff - afffe
__free_memory_core, range: 0xafffe990 - 0xafffe9a0, pfn: affff - afffe
__free_memory_core, range: 0xafffe9a4 - 0xafffe9c0, pfn: affff - afffe
__free_memory_core, range: 0xafffeb54 - 0xafffeb60, pfn: affff - afffe
__free_memory_core, range: 0xafffecf4 - 0xafffed00, pfn: affff - afffe
__free_memory_core, range: 0xafffefc4 - 0xafffefd8, pfn: affff - afffe
__free_memory_core, range: 0xb0200000 - 0xc0000000, pfn: b0200 - b0200
__free_memory_core, range: 0xcc000000 - 0xdca00000, pfn: cc000 - b0200
__free_memory_core, range: 0xde700000 - 0xdea00000, pfn: de700 - b0200
__free_memory_core, range: 0xe0800000 - 0xe0c00000, pfn: e0800 - b0200
__free_memory_core, range: 0xf4b00000 - 0xf7000000, pfn: f4b00 - b0200
__free_memory_core, range: 0xfda00000 - 0xffffffff, pfn: fda00 - b0200
> It seems that with SPARSEMEM we don't align the freed parts on pageblock
> boundaries.
>
> Can you try the patch below:
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index afaefa8fc6ab..1926369b52ec 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1941,14 +1941,13 @@ static void __init free_unused_memmap(void)
>   		 * due to SPARSEMEM sections which aren't present.
>   		 */
>   		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
> -#else
> +#endif
>   		/*
>   		 * Align down here since the VM subsystem insists that the
>   		 * memmap entries are valid from the bank start aligned to
>   		 * MAX_ORDER_NR_PAGES.
>   		 */
>   		start = round_down(start, MAX_ORDER_NR_PAGES);
> -#endif
>   
>   		/*
>   		 * If we had a previous bank, and there is a space
>   
>
