Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4BE3271AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 10:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhB1JBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 04:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhB1JBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 04:01:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9121464E38;
        Sun, 28 Feb 2021 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614502850;
        bh=8mA43d4QxG1l5TgOlrLJX5S5pb5qni0CUaJ+AOPZGK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF71Mq5Ww46r6dBcQL4HzYIaQ5z0eqD6pT/ugfzkxRKfJwgGkGn5YV6774jEEP0DE
         t/LGLiaVLPpDH3R8xqfaoiIEzhxBrAvVukTRF1WDLa0vjwm97AVKHP9+0dssP7iyn6
         ATvPJf+p6he86e9U/IN2/hCvp0v6VDnj6V5I786zPla0cf9SvuoyJrUBUSV4DCuVbM
         WwlgXD89SO4N4It4pmgYNJfZB7fCrLdpINehc6xFptsp1P/NVPf2AzaVWADRjpB31n
         BjJqIV1lUVH1Q8IYrQ78kUizbqVWN+w54n3va2X9v03NY43vmSlRk6apjPvo9UegXK
         kdxTTC5q37a2g==
Date:   Sun, 28 Feb 2021 11:00:41 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Kamal Dasu <kdasu.kdev@gmail.com>, linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, iamjoonsoo.kim@lge.com,
        riel@surriel.com, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations with
 kernel_end
Message-ID: <20210228090041.GO1447004@kernel.org>
References: <20201217201214.3414100-1-guro@fb.com>
 <20201217201214.3414100-2-guro@fb.com>
 <23fc1ef9-7342-8bc2-d184-d898107c52b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fc1ef9-7342-8bc2-d184-d898107c52b2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Sat, Feb 27, 2021 at 08:18:47PM -0800, Florian Fainelli wrote:
> 
> On 12/17/2020 12:12 PM, Roman Gushchin wrote:
> > With kaslr the kernel image is placed at a random place, so starting
> > the bottom-up allocation with the kernel_end can result in an
> > allocation failure and a warning like this one:
> > 
> > [    0.002920] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> > [    0.002921] ------------[ cut here ]------------
> > [    0.002922] memblock: bottom-up allocation failed, memory hotremove may be affected
> > [    0.002937] WARNING: CPU: 0 PID: 0 at mm/memblock.c:332 memblock_find_in_range_node+0x178/0x25a
> > [    0.002937] Modules linked in:
> > [    0.002939] CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #1169
> > [    0.002940] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
> > [    0.002942] RIP: 0010:memblock_find_in_range_node+0x178/0x25a
> > [    0.002944] Code: e9 6d ff ff ff 48 85 c0 0f 85 da 00 00 00 80 3d 9b 35 df 00 00 75 15 48 c7 c7 c0 75 59 88 c6 05 8b 35 df 00 01 e8 25 8a fa ff <0f> 0b 48 c7 44 24 20 ff ff ff ff 44 89 e6 44 89 ea 48 c7 c1 70 5c
> > [    0.002945] RSP: 0000:ffffffff88803d18 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
> > [    0.002947] RAX: 0000000000000000 RBX: 0000000240000000 RCX: 00000000ffffdfff
> > [    0.002948] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 0000000000000046
> > [    0.002948] RBP: 0000000100000000 R08: ffffffff88922788 R09: 0000000000009ffb
> > [    0.002949] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000000000
> > [    0.002950] R13: 0000000000000000 R14: 0000000080000000 R15: 00000001fb42c000
> > [    0.002952] FS:  0000000000000000(0000) GS:ffffffff88f71000(0000) knlGS:0000000000000000
> > [    0.002953] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.002954] CR2: ffffa080fb401000 CR3: 00000001fa80a000 CR4: 00000000000406b0
> > [    0.002956] Call Trace:
> > [    0.002961]  ? memblock_alloc_range_nid+0x8d/0x11e
> > [    0.002963]  ? cma_declare_contiguous_nid+0x2c4/0x38c
> > [    0.002964]  ? hugetlb_cma_reserve+0xdc/0x128
> > [    0.002968]  ? flush_tlb_one_kernel+0xc/0x20
> > [    0.002969]  ? native_set_fixmap+0x82/0xd0
> > [    0.002971]  ? flat_get_apic_id+0x5/0x10
> > [    0.002973]  ? register_lapic_address+0x8e/0x97
> > [    0.002975]  ? setup_arch+0x8a5/0xc3f
> > [    0.002978]  ? start_kernel+0x66/0x547
> > [    0.002980]  ? load_ucode_bsp+0x4c/0xcd
> > [    0.002982]  ? secondary_startup_64_no_verify+0xb0/0xbb
> > [    0.002986] random: get_random_bytes called from __warn+0xab/0x110 with crng_init=0
> > [    0.002988] ---[ end trace f151227d0b39be70 ]---
> > 
> > At the same time, the kernel image is protected with memblock_reserve(),
> > so we can just start searching at PAGE_SIZE. In this case the
> > bottom-up allocation has the same chances to success as a top-down
> > allocation, so there is no reason to fallback in the case of a
> > failure. All together it simplifies the logic.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Hi Roman, Thomas and other linux-mips folks,
> 
> Kamal and myself have been unable to boot v5.11 on MIPS since this
> commit, reverting it makes our MIPS platforms boot successfully. We do
> not see a warning like this one in the commit message, instead what
> happens appear to be a corrupted Device Tree which prevents the parsing
> of the "rdb" node and leading to the interrupt controllers not being
> registered, and the system eventually not booting.
> 
> The Device Tree is built-into the kernel image and resides at
> arch/mips/boot/dts/brcm/bcm97435svmb.dts.
> 
> Do you have any idea what could be wrong with MIPS specifically here?

Apparently there is a memblock allocation in one of the functions called
from arch_mem_init() between plat_mem_setup() and
early_init_fdt_reserve_self().

If you have serial available that early we can try to track it down with
forcing memblock_debug in mm/memblock.c to 1:

diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..83034245f8d5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -151,7 +151,7 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
                        pr_info(fmt, ##__VA_ARGS__);                    \
        } while (0)
 
-static int memblock_debug __initdata_memblock;
+static int memblock_debug __initdata_memblock = 1;
 static bool system_has_some_mirror __initdata_memblock = false;
 static int memblock_can_resize __initdata_memblock;
 static int memblock_memory_in_slab __initdata_memblock = 0;


Regardless, I think that moving DT self reservation just after
plat_mem_setup() is safe and it'll make things more robust.

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 279be0153f8b..f476b99a7bcd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -623,6 +623,8 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	/* call board setup routine */
 	plat_mem_setup();
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
 	memblock_set_bottom_up(true);
 
 	bootcmdline_init();
@@ -636,9 +638,6 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	check_kernel_sections_mem();
 
-	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
-
 #ifndef CONFIG_NUMA
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
 #endif
 
-- 
Sincerely yours,
Mike.
