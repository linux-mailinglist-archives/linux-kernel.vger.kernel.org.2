Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35997433E81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhJSSfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234526AbhJSSfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCE7560FC2;
        Tue, 19 Oct 2021 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634668398;
        bh=tddQ5j01VhjnhIGP8U5orxlEDk+1e+p9qoKkKIqsjkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONdpB1h4RUwdchQNPYQ9aObUZscH3vfl44Dc/Ug9+BRpHd24+jNt8NVw34b0HOkNc
         UEIlwsyNbkKDoRZmKIZcKJH9SBHKThIWTbhrDQV+KiDdgldsYLN52PhaKje/qvNfP4
         ABn7ILKNomjcAzZimzNg9M7PNYj/oHtY2VnqY5VtsTOfaWulgzzyXHkVhdF+H7/3+3
         p+OJgXvR0Sw4Er29MUM8kHvJZdg3YjG1SqMgqGYiEnTCYvUdi4hgkMGZLxXHCGI+69
         qKWHJMHhp0jJvMxNtdgGbawgSGidKQ7Dvh4Zw/L3OTyJyOwfpqCyxKvXI0fPyDDZpu
         9NmH6F1EcWswg==
Date:   Tue, 19 Oct 2021 21:33:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YW8PZ0Q5UeRH4W4R@kernel.org>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
 <YW5bjV128Qk1foIv@kernel.org>
 <YW6t5tBe/IjSYWn3@arm.com>
 <089478ad-3755-b085-d9aa-c68e9792895c@quicinc.com>
 <YW7p3ARYbpxmeLCF@arm.com>
 <8da41896-dc11-8246-54cf-1174f617ac39@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da41896-dc11-8246-54cf-1174f617ac39@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 01:59:22PM -0400, Qian Cai wrote:
> 
> 
> On 10/19/2021 11:53 AM, Catalin Marinas wrote:
> > Thanks. I guess the log here is with the Mike's patch reverted.
> 
> Yes.
> 
> > Try "earlycon=pl011,mmio32,0x12600000" on the kernel command line
> > and hopefully we get some early log.
> 
> Thanks for the suggestion, Catalin. I did not realize that a
> manually-provided "earlycon" started earlier than just "earlycon"
> and not defer to ACPI to populate parameters. Anyway,
> 
> [	0.000000][	T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
> [	0.000000][	T0] Linux version 5.15.0-rc6-next-20211019+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #104 SMP Tue Oct 19 17:36:17 UTC 2021
> [	0.000000][	T0] earlycon: pl11 at MMIO32 0x0000000012600000 (options '')
> [	0.000000][	T0] printk: bootconsole [pl11] enabled
> [	0.000000][	T0] efi: Getting UEFI parameters from /chosen in DT:
> [	0.000000][	T0] efi:   System Table     	: 0x0000009ff7de0018
> [	0.000000][	T0] efi:   MemMap Address   	: 0x0000009fe6dae018
> [	0.000000][	T0] efi:   MemMap Size      	: 0x0000000000000600
> [	0.000000][	T0] efi:   MemMap Desc. Size	: 0x0000000000000030
> [	0.000000][	T0] efi:   MemMap Desc. Version : 0x0000000000000001
> [	0.000000][	T0] efi: EFI v2.70 by American Megatrends
> [	0.000000][	T0] efi: ACPI 2.0=0x9ff5b40000 SMBIOS 3.0=0x9ff686fd98 ESRT=0x9ff1d18298 MEMRESERVE=0x9fe6dacd98  
> [	0.000000][	T0] efi: Processing EFI memory map:
> [	0.000000][	T0] efi:   0x000090000000-0x000091ffffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000][	T0] efi:   0x000092000000-0x0000928fffff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000][	T0] ------------[ cut here ]------------
> [	0.000000][	T0] kernel BUG at mm/kmemleak.c:1140!
> [	0.000000][	T0] Internal error: Oops - BUG: 0 [#1] SMP
> [	0.000000][	T0] Modules linked in:
> [	0.000000][	T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc6-next-20211019+ #104
> [	0.000000][	T0] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [	0.000000][	T0] pc : kmemleak_free_part_phys+0x64/0x8c
> [	0.000000][	T0] lr : kmemleak_free_part_phys+0x38/0x8c
> [	0.000000][	T0] sp : ffff800011eafbc0
> [	0.000000][	T0] x29: ffff800011eafbc0 x28: 1fffff7fffb41c0d x27: fffffbfffda0e068
> [	0.000000][	T0] x26: 0000000092000000 x25: 1ffff000023d5f94 x24: ffff800011ed84d0
> [	0.000000][	T0] x23: ffff800011ed84c0 x22: ffff800011ed83d8 x21: 0000000000900000
> [	0.000000][	T0] x20: ffff800011782000 x19: 0000000092000000 x18: ffff800011ee0730
> [	0.000000][	T0] x17: 0000000000000000 x16: 0000000000000000 x15: 1ffff0000233252c
> [	0.000000][	T0] x14: ffff800019a905a0 x13: 0000000000000001 x12: ffff7000023d5ed7
> [	0.000000][	T0] x11: 1ffff000023d5ed6 x10: ffff7000023d5ed6 x9 : dfff800000000000
> [	0.000000][	T0] x8 : ffff800011eaf6b7 x7 : 0000000000000001 x6 : ffff800011eaf6b0
> [	0.000000][	T0] x5 : 00008ffffdc2a12a x4 : ffff7000023d5ed7 x3 : 1ffff000023dbf99
> [	0.000000][	T0] x2 : 1ffff000022f0463 x1 : 0000000000000000 x0 : ffffffffffffffff
> [	0.000000][	T0] Call trace:
> [	0.000000][	T0]  kmemleak_free_part_phys+0x64/0x8c
> [	0.000000][	T0]  memblock_mark_nomap+0x5c/0x78
> [	0.000000][	T0]  reserve_regions+0x294/0x33c
> [	0.000000][	T0]  efi_init+0x2d0/0x490
> [	0.000000][	T0]  setup_arch+0x80/0x138
> [	0.000000][	T0]  start_kernel+0xa0/0x3ec
> [	0.000000][	T0]  __primary_switched+0xc0/0xc8
> [	0.000000][	T0] Code: 34000041 97d526e7 f9418e80 36000040 (d4210000)  
> [	0.000000][	T0] random: get_random_bytes called from print_oops_end_marker+0x34/0x80 with crng_init=0
> [	0.000000][	T0] ---[ end trace 0000000000000000 ]---
> [	0.000000][	T0] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [	0.000000][	T0] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> 
> I did not quite figure out where this BUG() was triggered and I did not

This is from here:
arch/arm64/include/asm/memory.h:

#define PHYS_OFFSET         ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })

kmemleak_free_part_phys() does __va() which uses PHYS_OFFSET and all this
happens before memstart_addr is set.

I'll try to see how this can be untangled...

> see anything obviously after checking DEBUG_VIRTUAL code, but it did
> finger to the kmemleak_free_part() line. I verified that phys == 0x92000000d,
> 
> void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
> {
> 	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
> 		kmemleak_free_part(__va(phys), size);
> }
> 
> As you can see the above efi=debug information was truncated. Usually
> on a working boot the whole thing is:
> 
> [	0.000000] efi: Processing EFI memory map:
> [	0.000000] efi:   0x000010540000-0x00001054ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |  ]
> [	0.000000] efi:   0x000090000000-0x00009007ffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x000090080000-0x000091ebffff [Loader Data    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x000091ec0000-0x000091ffffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x000092000000-0x0000928fffff [Runtime Data   	|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x000092900000-0x0000fffb7fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x0000fffb8000-0x0000fffbffff [Boot Data      	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x0000fffc0000-0x0000ffffffff [Runtime Data   	|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x000880000000-0x00088ae4afff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x00088ae4b000-0x00088fffffff [Loader Data    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x000890000000-0x000fffffffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x008800000000-0x009f81089fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009f8108a000-0x009f82dabfff [Loader Data    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009f82dac000-0x009fe6dabfff [Loader Code    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fe6dac000-0x009fe6dacfff [Loader Data    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fe6dad000-0x009fe6dadfff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fe6dae000-0x009fe6db2fff [Loader Data    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fe6db3000-0x009fe6f7bfff [Loader Code    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fe6f7c000-0x009ff287cfff [Boot Data      	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff287d000-0x009ff3293fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff3294000-0x009ff5af0fff [Boot Code      	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff5af1000-0x009ff5b2ffff [Reserved       	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff5b30000-0x009ff5b4ffff [ACPI Reclaim Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff5b50000-0x009ff5baffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff5bb0000-0x009ff5bbffff [ACPI Memory NVS	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff5bc0000-0x009ff7deffff [Runtime Data   	|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff7df0000-0x009ff7e5ffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff7e60000-0x009ff7ffffff [Runtime Code   	|RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff8000000-0x009ff801efff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff801f000-0x009ff801ffff [Boot Data      	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009ff8020000-0x009fff9fffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fffa00000-0x009fffbfffff [Loader Data    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fffc00000-0x009fffdbffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fffdc0000-0x009fffdcffff [Loader Data    	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fffdd0000-0x009fffdd4fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
> [	0.000000] efi:   0x009fffdd5000-0x009fffffffff [Boot Data      	|   |  |  |  |  |  |  |   |WB|WT|WC|UC]

-- 
Sincerely yours,
Mike.
