Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5B387929
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbhERMvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:51:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3020 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244718AbhERMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:51:05 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fkwkm6HTnzlg1x;
        Tue, 18 May 2021 20:47:28 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 20:49:44 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 20:49:43 +0800
Subject: Re: [PATCH 3/3] arm: extend pfn_valid to take into accound freed
 memory map alignment
To:     Mike Rapoport <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210518090613.21519-1-rppt@kernel.org>
 <20210518090613.21519-4-rppt@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <2d34f990-c609-88aa-1dc0-f8e9e9623fc3@huawei.com>
Date:   Tue, 18 May 2021 20:49:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210518090613.21519-4-rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/18 17:06, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> When unused memory map is freed the preserved part of the memory map is
> extended to match pageblock boundaries because lots of core mm
> functionality relies on homogeneity of the memory map within pageblock
> boundaries.
> 
> Since pfn_valid() is used to check whether there is a valid memory map
> entry for a PFN, make it return true also for PFNs that have memory map
> entries even if there is no actual memory populated there.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/arm/mm/init.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 9d4744a632c6..bb678c0ba143 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -125,11 +125,24 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
>   int pfn_valid(unsigned long pfn)
>   {
>   	phys_addr_t addr = __pfn_to_phys(pfn);
> +	unsigned long pageblock_size = PAGE_SIZE * pageblock_nr_pages;
>   
>   	if (__phys_to_pfn(addr) != pfn)
>   		return 0;
>   
> -	return memblock_is_map_memory(addr);
> +	if (memblock_is_map_memory(addr))
> +		return 1;
> +
> +	/*
> +	 * If address less than pageblock_size bytes away from a present
> +	 * memory chunk there still will be a memory map entry for it
> +	 * because we round freed memory map to the pageblock boundaries
> +	 */
> +	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
> +	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
> +		return 1;

Hi Mike, with patch3, the system won't boot.

...
Initmem setup node 0 [mem 0x0000000080a00000-0x00000000ffffefff]
   Normal zone: 18176 pages in unavailable ranges
8<--- cut here ---
Unable to handle kernel paging request at virtual address 0197c000
pgd = (ptrval)
[0197c000] *pgd=00000000
Internal error: Oops: 805 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #132
Hardware name: Hisilicon A9
PC is at mmioset+0x4c/0xa8
LR is at 0x0
pc : [<c033930c>]    lr : [<00000000>]    psr: 00000293
sp : c0801d88  ip : 0197c000  fp : 000001ff
r10: 00000000  r9 : 00000001  r8 : 00000000
r7 : 00000032  r6 : 00000032  r5 : 01000000  r4 : 0197c000
r3 : 00000000  r2 : ffffffe0  r1 : 00000000  r0 : 0197c000
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 1ac5387d  Table: 80a0404a  DAC: 55555555
Process swapper (pid: 0, stack limit = 0x(ptrval))
Stack: (0xc0801d88 to 0xc0802000)
1d80:                   000cc000 c04b5764 000cbe00 0197c000 c0885040 
c04b580c
1da0: 00000000 00000000 00000001 000fffff 00000000 00000000 00000000 
000b0200
1dc0: 00000001 00000000 c0880f38 c04b5d4c 000fffff 00000000 00000000 
00000001
1de0: 000cc000 000dca00 00000005 c0813d28 000259ff 000259ff 00000001 
c072e4c4
1e00: 0004fdff 000b0200 c050903c 00000004 c0863280 c0712ea4 00000000 
ffffefff
1e20: 00000000 c0862fa0 0007f5ff 00080a00 00000000 00080a00 000fffff 
c0813d28
1e40: 00000000 00000001 c05b046b 00000000 fffff000 c0842780 c0801e90 
00000000
1e60: fffff000 c071336c c0801e90 ffffefff 00000000 00000001 000fda00 
000fffff
1e80: ffffffff 000fda00 000fffff ffffffff 00000000 c0813d28 00000000 
c0881bb8
1ea0: c0881bac c0817900 c05df034 c0842780 c0818614 c086e3fc ffe00000 
c0705d50
1ec0: 000b0200 000fffff 00000000 c0813d28 c0817900 00000000 ef7fa000 
c07076ac
1ee0: 00000000 c0801f00 c0801f04 00000000 b0200000 00080b00 00081200 
c072b000
1f00: cc000000 b0200000 00000000 00000006 fda00000 ffff1000 000afe01 
00001000
1f20: 00000007 c0813d28 c0598da7 c0727be8 c08178e4 c086e1c0 c08e8058 
c0008000
1f40: c0801fcc 1ac5387d c05df0f8 c07044e8 00000000 00117680 c0813d20 
12c0387d
1f60: 40000193 80a01000 413fc090 1ac5387d 00000000 c0166978 c0801fac 
c0801fac
1f80: 00000000 c04b07e0 c0801fac c0813d28 00000080 00117680 c0813d20 
12c0387d
1fa0: 40000193 80a01000 413fc090 1ac5387d 00000000 c0700940 00000000 
00000000
1fc0: 00000000 00000000 00000000 c072aa64 00000000 c0813d28 00000000 
00117680
1fe0: 55555555 12c0387d 40000193 80a01000 413fc090 00000000 00000000 
00000000
[<c033930c>] (mmioset) from [<c04b5764>] (__init_single_page+0x50/0x7c)
[<c04b5764>] (__init_single_page) from [<c04b580c>] 
(init_unavailable_range+0x7c/0xec)
[<c04b580c>] (init_unavailable_range) from [<c04b5d4c>] 
(memmap_init+0x144/0x188)
[<c04b5d4c>] (memmap_init) from [<c0712ea4>] 
(free_area_init_node+0x3b8/0x54c)
[<c0712ea4>] (free_area_init_node) from [<c071336c>] 
(free_area_init+0x214/0x5a4)
[<c071336c>] (free_area_init) from [<c0705d50>] (bootmem_init+0x78/0xac)
[<c0705d50>] (bootmem_init) from [<c07076ac>] (paging_init+0x410/0x6bc)
[<c07076ac>] (paging_init) from [<c07044e8>] (setup_arch+0x10c/0x5c4)
[<c07044e8>] (setup_arch) from [<c0700940>] (start_kernel+0x60/0x5c0)
[<c0700940>] (start_kernel) from [<00000000>] (0x0)
Code: 0a41aca8 f9ffffca 0081bd08 200012e3 (0a41ac18)

