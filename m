Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC636B5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhDZP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:27:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17063 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhDZP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:27:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FTTFr0xjkz19M2v;
        Mon, 26 Apr 2021 23:24:16 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 26 Apr 2021 23:26:39 +0800
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
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
Date:   Mon, 26 Apr 2021 23:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YIZNq5HMfJ1rWytv@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/26 13:20, Mike Rapoport wrote:
> On Sun, Apr 25, 2021 at 03:51:56PM +0800, Kefeng Wang wrote:
>> On 2021/4/25 15:19, Mike Rapoport wrote:
>>
>>      On Fri, Apr 23, 2021 at 04:11:16PM +0800, Kefeng Wang wrote:
>>
>>          I tested this patchset(plus arm32 change, like arm64 does) based on lts
>>          5.10，add
>>
>>          some debug log, the useful info shows below, if we enable HOLES_IN_ZONE, no
>>          panic,
>>
>>          any idea, thanks.
>>
>>
>>      Are there any changes on top of 5.10 except for pfn_valid() patch?
>>      Do you see this panic on 5.10 without the changes?
>>
>> Yes, there are some BSP support for arm board based on 5.10, with or without
>>
>> your patch will get same panic, the panic pfn=de600 in the range of
>> [dcc00,de00]
>>
>> which is freed by free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de700,
>> de700000
>>
>> we see the PC is at PageLRU, same reason like arm64 panic log,
>>
>>     "PageBuddy in move_freepages returns false
>>      Then we call PageLRU, the macro calls PF_HEAD which is compound_page()
>>      compound_page reads page->compound_head, it is 0xffffffffffffffff, so it
>>      resturns 0xfffffffffffffffe - and accessing this address causes crash"
>>
>>      Can you see stack backtrace beyond move_freepages_block?
>>
>> I do some oom test, so the log is about memory allocate,
>>
>> [<c02383c8>] (move_freepages_block) from [<c0238668>]
>> (steal_suitable_fallback+0x174/0x1f4)
>>
>> [<c0238668>] (steal_suitable_fallback) from [<c023999c>] (get_page_from_freelist+0x490/0x9a4)
> Hmm, this is called with a page from free list, having a page from a freed
> part of the memory map passed to steal_suitable_fallback() means that there
> is an issue with creation of the free list.
>
> Can you please add "memblock=debug" to the kernel command line and post the
> log?

Here is the log,

CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=1ac5387d

CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: HISI-CA9
memblock_add: [0x80a00000-0x855fffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0x86a00000-0x87dfffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0x8bd00000-0x8c4fffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0x8e300000-0x8ecfffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0x90d00000-0xbfffffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xcc000000-0xdc9fffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xe0800000-0xe0bfffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xf5300000-0xf5bfffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xf5c00000-0xf6ffffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xfe100000-0xfebfffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xfec00000-0xffffffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xde700000-0xde9fffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xf4b00000-0xf52fffff] early_init_dt_scan_memory+0x11c/0x188
memblock_add: [0xfda00000-0xfe0fffff] early_init_dt_scan_memory+0x11c/0x188
memblock_reserve: [0x80a01000-0x80a02d2e] setup_arch+0x68/0x5c4
Malformed early option 'vecpage_wrprotect'
Memory policy: Data cache writealloc
memblock_reserve: [0x80b00000-0x812e8057] arm_memblock_init+0x34/0x14c
memblock_reserve: [0x83000000-0x84ffffff] arm_memblock_init+0x100/0x14c
memblock_reserve: [0x80a04000-0x80a07fff] arm_memblock_init+0xa0/0x14c
memblock_reserve: [0x80a00000-0x80a02fff] hisi_mem_reserve+0x14/0x30
MEMBLOCK configuration:
  memory size = 0x4c0fffff reserved size = 0x027ef058
  memory.cnt  = 0xa
  memory[0x0]    [0x80a00000-0x855fffff], 0x04c00000 bytes flags: 0x0
  memory[0x1]    [0x86a00000-0x87dfffff], 0x01400000 bytes flags: 0x0
  memory[0x2]    [0x8bd00000-0x8c4fffff], 0x00800000 bytes flags: 0x0
  memory[0x3]    [0x8e300000-0x8ecfffff], 0x00a00000 bytes flags: 0x0
  memory[0x4]    [0x90d00000-0xbfffffff], 0x2f300000 bytes flags: 0x0
  memory[0x5]    [0xcc000000-0xdc9fffff], 0x10a00000 bytes flags: 0x0
  memory[0x6]    [0xde700000-0xde9fffff], 0x00300000 bytes flags: 0x0
  memory[0x7]    [0xe0800000-0xe0bfffff], 0x00400000 bytes flags: 0x0
  memory[0x8]    [0xf4b00000-0xf6ffffff], 0x02500000 bytes flags: 0x0
  memory[0x9]    [0xfda00000-0xfffffffe], 0x025fffff bytes flags: 0x0
  reserved.cnt  = 0x4
  reserved[0x0]    [0x80a00000-0x80a02fff], 0x00003000 bytes flags: 0x0
  reserved[0x1]    [0x80a04000-0x80a07fff], 0x00004000 bytes flags: 0x0
  reserved[0x2]    [0x80b00000-0x812e8057], 0x007e8058 bytes flags: 0x0
  reserved[0x3]    [0x83000000-0x84ffffff], 0x02000000 bytes flags: 0x0
memblock_alloc_try_nid: 2097152 bytes align=0x200000 nid=-1 
from=0x00000000 max_addr=0x00000000 early_alloc+0x20/0x4c
memblock_reserve: [0xb0000000-0xb01fffff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x00000000 
max_addr=0x00000000 early_alloc+0x20/0x4c
memblock_reserve: [0xaffff000-0xafffffff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 40 bytes align=0x4 nid=-1 from=0x00000000 
max_addr=0x00000000 iotable_init+0x34/0xf0
memblock_reserve: [0xafffefd8-0xafffefff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x00000000 
max_addr=0x00000000 early_alloc+0x20/0x4c
memblock_reserve: [0xafffd000-0xafffdfff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x00000000 
max_addr=0x00000000 early_alloc+0x20/0x4c
memblock_reserve: [0xafffc000-0xafffcfff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x00000000 
max_addr=0x00000000 early_alloc+0x20/0x4c
memblock_reserve: [0xafffb000-0xafffbfff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x00000000 
max_addr=0x00000000 early_alloc+0x20/0x4c
memblock_reserve: [0xafffa000-0xafffafff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 384 bytes align=0x20 nid=0 from=0x00000000 
max_addr=0x00000000 sparse_init_nid+0x34/0x1d8
memblock_reserve: [0xafffee40-0xafffefbf] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_exact_nid_raw: 12582912 bytes align=0x80000 nid=0 
from=0xc09fffff max_addr=0x00000000 sparse_init_nid+0xec/0x1d8
memblock_reserve: [0xaf380000-0xaff7ffff] 
memblock_alloc_range_nid+0x104/0x13c
Zone ranges:
   Normal   [mem 0x0000000080a00000-0x00000000b01fffff]
   HighMem  [mem 0x00000000b0200000-0x00000000ffffefff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000080a00000-0x00000000855fffff]
   node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
   node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
   node   0: [mem 0x000000008e300000-0x000000008ecfffff]
   node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
   node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
   node   0: [mem 0x00000000de700000-0x00000000de9fffff]
   node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
   node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
   node   0: [mem 0x00000000fda00000-0x00000000ffffefff]
Zeroed struct page in unavailable ranges: 513 pages
Initmem setup node 0 [mem 0x0000000080a00000-0x00000000ffffefff]
On node 0 totalpages: 311551
   Normal zone: 1230 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 157440 pages, LIFO batch:31
   HighMem zone: 154111 pages, LIFO batch:31
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffee20-0xafffee3f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffee00-0xafffee1f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffede0-0xafffedff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffedc0-0xafffeddf] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffeda0-0xafffedbf] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffed80-0xafffed9f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffed60-0xafffed7f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffed40-0xafffed5f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffed20-0xafffed3f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 32 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_arch+0x440/0x5c4
memblock_reserve: [0xafffed00-0xafffed1f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 22396 bytes align=0x4 nid=-1 from=0x00000000 
max_addr=0x00000000 early_init_dt_alloc_memory_arch+0x30/0x64
memblock_reserve: [0xafff4884-0xafff9fff] 
memblock_alloc_range_nid+0x104/0x13c
[dts]:cpu type is 1380
memblock_alloc_try_nid: 404 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc.constprop.8+0x1c/0x24
memblock_reserve: [0xafffeb60-0xafffecf3] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 404 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc.constprop.8+0x1c/0x24
memblock_reserve: [0xafffe9c0-0xafffeb53] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafff3000-0xafff3fff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4096 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafff2000-0xafff2fff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 278528 bytes align=0x1000 nid=-1 from=0xc09fffff 
max_addr=0x00000000 pcpu_dfl_fc_alloc+0x28/0x34
memblock_reserve: [0xaffae000-0xafff1fff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_free: [0xaffbf000-0xaffbefff] pcpu_embed_first_chunk+0x5ec/0x6a8
memblock_free: [0xaffd0000-0xaffcffff] pcpu_embed_first_chunk+0x5ec/0x6a8
memblock_free: [0xaffe1000-0xaffe0fff] pcpu_embed_first_chunk+0x5ec/0x6a8
memblock_free: [0xafff2000-0xafff1fff] pcpu_embed_first_chunk+0x5ec/0x6a8
percpu: Embedded 17 pages/cpu s37044 r8192 d24396 u69632
memblock_alloc_try_nid: 4 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffefc0-0xafffefc3] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 4 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe9a0-0xafffe9a3] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 16 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe980-0xafffe98f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 16 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe960-0xafffe96f] 
memblock_alloc_range_nid+0x104/0x13c
pcpu-alloc: s37044 r8192 d24396 u69632 alloc=17*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
memblock_alloc_try_nid: 128 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe8e0-0xafffe95f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 92 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe880-0xafffe8db] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 384 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe700-0xafffe87f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 388 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe560-0xafffe6e3] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 96 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe500-0xafffe55f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 92 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe4a0-0xafffe4fb] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 768 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe1a0-0xafffe49f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 772 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafff4580-0xafff4883] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 192 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 memblock_alloc+0x18/0x20
memblock_reserve: [0xafffe0e0-0xafffe19f] 
memblock_alloc_range_nid+0x104/0x13c
memblock_free: [0xafff3000-0xafff3fff] pcpu_embed_first_chunk+0x570/0x6a8
memblock_free: [0xafff2000-0xafff2fff] pcpu_embed_first_chunk+0x58c/0x6a8
Built 1 zonelists, mobility grouping on.  Total pages: 310321
Kernel command line: console=ttyAMA0,9600n8N lpj=8000000 
initrd=0x83000000,0x2000000 maxcpus=4 master_cpu=1 quiet highres=off  
oops=panic vecpage_wrprotect ksm=1 ramdisk_size=30720 kmemleak=off 
min_loop=128 lockd.nlm_tcpport=13001 lockd.nlm_udpport=13001 
rdinit=/sbin/init root=/dev/ram0 vmalloc=256M
printk: log_buf_len individual max cpu contribution: 4096 bytes
printk: log_buf_len total cpu_extra contributions: 12288 bytes
printk: log_buf_len min size: 16384 bytes
memblock_alloc_try_nid: 32768 bytes align=0x4 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_log_buf+0xe4/0x404
memblock_reserve: [0xaffa6000-0xaffadfff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 12288 bytes align=0x4 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_log_buf+0x130/0x404
memblock_reserve: [0xaffa3000-0xaffa5fff] 
memblock_alloc_range_nid+0x104/0x13c
memblock_alloc_try_nid: 90112 bytes align=0x4 nid=-1 from=0x00000000 
max_addr=0x00000000 setup_log_buf+0x180/0x404
memblock_reserve: [0xaff8d000-0xaffa2fff] 
memblock_alloc_range_nid+0x104/0x13c
printk: log_buf_len: 32768 bytes
printk: early log buf free: 2492(15%)
memblock_alloc_try_nid: 524288 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 alloc_large_system_hash+0x1b0/0x2e8
memblock_reserve: [0xaf300000-0xaf37ffff] 
memblock_alloc_range_nid+0x104/0x13c
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
memblock_alloc_try_nid: 262144 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 alloc_large_system_hash+0x1b0/0x2e8
memblock_reserve: [0xaf2c0000-0xaf2fffff] 
memblock_alloc_range_nid+0x104/0x13c
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
memblock_free: [0xaf430000-0xaf453fff] mem_init+0x154/0x238
memblock_free: [0xaf510000-0xaf545fff] mem_init+0x154/0x238
memblock_free: [0xaf560000-0xaf57ffff] mem_init+0x154/0x238
memblock_free: [0xafd98000-0xafdcdfff] mem_init+0x154/0x238
memblock_free: [0xafdd8000-0xafdfffff] mem_init+0x154/0x238
memblock_free: [0xafe18000-0xafe7ffff] mem_init+0x154/0x238
memblock_free: [0xafee0000-0xafefffff] mem_init+0x154/0x238
Memory: 1191160K/1246204K available (4096K kernel code, 436K rwdata, 
1120K rodata, 1024K init, 491K bss, 55044K reserved, 0K cma-reserved, 
616444K highmem)

>> [<c023999c>] (get_page_from_freelist) from [<c023a4dc>] (__alloc_pages_nodemask+0x188/0xc08)
>> [<c023a4dc>] (__alloc_pages_nodemask) from [<c0223078>] (alloc_zeroed_user_highpage_movable+0x14/0x3c)
>> [<c0223078>] (alloc_zeroed_user_highpage_movable) from [<c0226768>] (handle_mm_fault+0x254/0xac8)
>> [<c0226768>] (handle_mm_fault) from [<c04ba09c>] (do_page_fault+0x228/0x2f4)
>> [<c04ba09c>] (do_page_fault) from [<c0111d80>] (do_DataAbort+0x48/0xd0)
>> [<c0111d80>] (do_DataAbort) from [<c0100e00>] (__dabt_usr+0x40/0x60)
>>
>>
>>
>>          Zone ranges:
>>            Normal   [mem 0x0000000080a00000-0x00000000b01fffff]
>>            HighMem  [mem 0x00000000b0200000-0x00000000ffffefff]
>>          Movable zone start for each node
>>          Early memory node ranges
>>            node   0: [mem 0x0000000080a00000-0x00000000855fffff]
>>            node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
>>            node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
>>            node   0: [mem 0x000000008e300000-0x000000008ecfffff]
>>            node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
>>            node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
>>            node   0: [mem 0x00000000de700000-0x00000000de9fffff]
>>            node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
>>            node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
>>            node   0: [mem 0x00000000fda00000-0x00000000ffffefff]
>>
>>          ----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86a00, 86a00000
>>          ----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e300, 8e300000
>>          ----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
>>          ----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de700, de700000
>>          ----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
>>          ----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
>>          ----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
>>          === >move_freepages: start_pfn/end_pfn [de601, de7ff], [de600000, de7ff000]
>>          :  pfn =de600 pfn2phy = de600000 , page = ef3cc000, page-flags = ffffffff
>>          8<--- cut here ---
>>          Unable to handle kernel paging request at virtual address fffffffe
>>          pgd = 5dd50df5
>>          [fffffffe] *pgd=affff861, *pte=00000000, *ppte=00000000
>>          Internal error: Oops: 37 [#1] SMP ARM
>>          Modules linked in: gmac(O)
>>          CPU: 2 PID: 635 Comm: test-oom Tainted: G           O      5.10.0+ #31
>>          Hardware name: Hisilicon A9
>>          PC is at move_freepages_block+0x150/0x278
>>          LR is at move_freepages_block+0x150/0x278
>>          pc : [<c02383a4>]    lr : [<c02383a4>]    psr: 200e0393
>>          sp : c4179cf8  ip : 00000000  fp : 00000001
>>          r10: c4179d58  r9 : 000de7ff  r8 : 00000000
>>          r7 : c0863280  r6 : 000de600  r5 : 000de600  r4 : ef3cc000
>>          r3 : ffffffff  r2 : 00000000  r1 : ef5d069c  r0 : fffffffe
>>          Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>          Control: 1ac5387d  Table: 83b0c04a  DAC: 55555555
>>          Process test-oom (pid: 635, stack limit = 0x25d667df)
>>
>>
