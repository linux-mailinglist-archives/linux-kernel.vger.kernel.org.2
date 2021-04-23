Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE0368E99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbhDWIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:12:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17395 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbhDWIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:11:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FRRlQ6dgTzlZ9n;
        Fri, 23 Apr 2021 16:09:22 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 23 Apr 2021 16:11:17 +0800
Subject: Re: [PATCH v2 0/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
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
Message-ID: <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
Date:   Fri, 23 Apr 2021 16:11:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/22 23:28, Kefeng Wang wrote:
>
> On 2021/4/22 15:29, Mike Rapoport wrote:
>> On Thu, Apr 22, 2021 at 03:00:20PM +0800, Kefeng Wang wrote:
>>> On 2021/4/21 14:51, Mike Rapoport wrote:
>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>
>>>> Hi,
>>>>
>>>> These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially 
>>>> hardwire
>>>> pfn_valid_within() to 1.
>>>>
>>>> The idea is to mark NOMAP pages as reserved in the memory map and 
>>>> restore
>>>> the intended semantics of pfn_valid() to designate availability of 
>>>> struct
>>>> page for a pfn.
>>>>
>>>> With this the core mm will be able to cope with the fact that it 
>>>> cannot use
>>>> NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER 
>>>> blocks
>>>> will be treated correctly even without the need for pfn_valid_within.
>>>>
>>>> The patches are only boot tested on qemu-system-aarch64 so I'd really
>>>> appreciate memory stress tests on real hardware.
>>>>
>>>> If this actually works we'll be one step closer to drop custom 
>>>> pfn_valid()
>>>> on arm64 altogether.
...
>
> Ok, thanks, we met a same panic like the link on arm32(without 
> HOLES_IN_ZONE),
>
> the scheme for arm64 could be suit for arm32, right?  I will try the 
> patchset with
>
> some changes on arm32 and give some feedback.

I tested this patchset(plus arm32 change, like arm64 does) based on lts 
5.10，add

some debug log, the useful info shows below, if we enable HOLES_IN_ZONE, 
no panic,

any idea, thanks.

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

----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86a00, 86a00000
----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e300, 8e300000
----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de700, de700000
----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
=== >move_freepages: start_pfn/end_pfn [de600, de7ff], [de600000, 
de7ff000] :  pfn =de600 pfn2phy = de600000 , page = ef3cc000, page-flags 
= ffffffff
8<--- cut here ---
Unable to handle kernel paging request at virtual address fffffffe
pgd = 5dd50df5
[fffffffe] *pgd=affff861, *pte=00000000, *ppte=00000000
Internal error: Oops: 37 [#1] SMP ARM
Modules linked in: gmac(O)
CPU: 2 PID: 635 Comm: test-oom Tainted: G           O      5.10.0+ #31
Hardware name: Hisilicon A9
PC is at move_freepages_block+0x150/0x278
LR is at move_freepages_block+0x150/0x278
pc : [<c02383a4>]    lr : [<c02383a4>]    psr: 200e0393
sp : c4179cf8  ip : 00000000  fp : 00000001
r10: c4179d58  r9 : 000de7ff  r8 : 00000000
r7 : c0863280  r6 : 000de600  r5 : 000de600  r4 : ef3cc000
r3 : ffffffff  r2 : 00000000  r1 : ef5d069c  r0 : fffffffe
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 1ac5387d  Table: 83b0c04a  DAC: 55555555
Process test-oom (pid: 635, stack limit = 0x25d667df)

