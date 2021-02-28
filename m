Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5487B3273C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 19:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhB1SUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 13:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhB1SUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 13:20:44 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40961C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 10:20:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h4so9996135pgf.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vz7i8h5QpaVwXL4z5bIWRRAY7xVYsdFU4lsd2qBOII4=;
        b=cptrJuqYenbcIOsAUtc14kCXbiV/w7WAonx6pD/ojsKaNI9O7OePO3lmOemQNmpeUF
         iSrdsWaI/vfd8lODG/JilP6/3ddCGap5ypehjk+PzkS8IVrbWQ6Mo+GszMTW3taio7Yg
         ww5fl4ACbTLkE/UL1+RevRrk7EutY2oMpxKYTO/BYHqT+1XsZa0bqUIqCUFYEtOzsFOI
         FeoKGPSK5pUl5HEW9k9roRzymBPU/BAwDebeF9mMTyel7JD4nhzgMsmdIRVvK2f/a95U
         w17Z1rkfFYKOtQ0HAKTw8xR2JeYA5PJ9don9BXDO/wvUrFaTvhWmbrWyxgCpAmX8SzXq
         x1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vz7i8h5QpaVwXL4z5bIWRRAY7xVYsdFU4lsd2qBOII4=;
        b=P1odOP7bSm7mj/P1bHACohVkw3Sslql5QQTZAkR86zi7wwDxk+npgQRvPnuWYOKHTH
         N2NVUKrvIvP7JDfnEVJ6nmUWpCZRUsm9MMgnbUySBgmQkbgMHhWnNBawwQt0MIlT5OYY
         kblJ61n5cBpgJDbTE/um25JOod0LjKFgM2pxEeZx57m1ML9psY83CEwxRTkop61+RPIt
         2kNr5WRMXiCKX/wrUrjrjjn2dWVOgwhc2eyahVvDT3r1G8Yi5T6LwvWfl7j8BVNr3pDV
         18UjtVf+YXVWM0oR47FN6INMYjZn0+tLs3t3uh0TXuqhLgA9Lhls7bvVQhiAWTpiFJMb
         kA3A==
X-Gm-Message-State: AOAM5334uB/1fF/ts9A3zFXHyq1UzNGxyDfgSY53TwYOXHNXylapma3Q
        uSLlgOqDUxldRD2A+jpLEO6XTMQj4+w=
X-Google-Smtp-Source: ABdhPJw2FUwvyughV/5+tz6RZ3npKPb4+dVlIuHjysq6qzALxHLYuu/JVW4x1lk4Sac6esUYLgPC3g==
X-Received: by 2002:a63:1f46:: with SMTP id q6mr10601411pgm.411.1614536403191;
        Sun, 28 Feb 2021 10:20:03 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c4sm8107994pfo.2.2021.02.28.10.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 10:20:02 -0800 (PST)
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations with
 kernel_end
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Kamal Dasu <kdasu.kdev@gmail.com>, linux-mips@linux-mips.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, iamjoonsoo.kim@lge.com,
        riel@surriel.com, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20201217201214.3414100-1-guro@fb.com>
 <20201217201214.3414100-2-guro@fb.com>
 <23fc1ef9-7342-8bc2-d184-d898107c52b2@gmail.com>
 <20210228090041.GO1447004@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8cbafe95-0f8c-a9b7-2dc9-cded846622fd@gmail.com>
Date:   Sun, 28 Feb 2021 10:19:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210228090041.GO1447004@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2/28/2021 1:00 AM, Mike Rapoport wrote:
> Hi Florian,
> 
> On Sat, Feb 27, 2021 at 08:18:47PM -0800, Florian Fainelli wrote:
>>
>> On 12/17/2020 12:12 PM, Roman Gushchin wrote:
>>> With kaslr the kernel image is placed at a random place, so starting
>>> the bottom-up allocation with the kernel_end can result in an
>>> allocation failure and a warning like this one:
>>>
>>> [    0.002920] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
>>> [    0.002921] ------------[ cut here ]------------
>>> [    0.002922] memblock: bottom-up allocation failed, memory hotremove may be affected
>>> [    0.002937] WARNING: CPU: 0 PID: 0 at mm/memblock.c:332 memblock_find_in_range_node+0x178/0x25a
>>> [    0.002937] Modules linked in:
>>> [    0.002939] CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.0+ #1169
>>> [    0.002940] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
>>> [    0.002942] RIP: 0010:memblock_find_in_range_node+0x178/0x25a
>>> [    0.002944] Code: e9 6d ff ff ff 48 85 c0 0f 85 da 00 00 00 80 3d 9b 35 df 00 00 75 15 48 c7 c7 c0 75 59 88 c6 05 8b 35 df 00 01 e8 25 8a fa ff <0f> 0b 48 c7 44 24 20 ff ff ff ff 44 89 e6 44 89 ea 48 c7 c1 70 5c
>>> [    0.002945] RSP: 0000:ffffffff88803d18 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
>>> [    0.002947] RAX: 0000000000000000 RBX: 0000000240000000 RCX: 00000000ffffdfff
>>> [    0.002948] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 0000000000000046
>>> [    0.002948] RBP: 0000000100000000 R08: ffffffff88922788 R09: 0000000000009ffb
>>> [    0.002949] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000000000
>>> [    0.002950] R13: 0000000000000000 R14: 0000000080000000 R15: 00000001fb42c000
>>> [    0.002952] FS:  0000000000000000(0000) GS:ffffffff88f71000(0000) knlGS:0000000000000000
>>> [    0.002953] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.002954] CR2: ffffa080fb401000 CR3: 00000001fa80a000 CR4: 00000000000406b0
>>> [    0.002956] Call Trace:
>>> [    0.002961]  ? memblock_alloc_range_nid+0x8d/0x11e
>>> [    0.002963]  ? cma_declare_contiguous_nid+0x2c4/0x38c
>>> [    0.002964]  ? hugetlb_cma_reserve+0xdc/0x128
>>> [    0.002968]  ? flush_tlb_one_kernel+0xc/0x20
>>> [    0.002969]  ? native_set_fixmap+0x82/0xd0
>>> [    0.002971]  ? flat_get_apic_id+0x5/0x10
>>> [    0.002973]  ? register_lapic_address+0x8e/0x97
>>> [    0.002975]  ? setup_arch+0x8a5/0xc3f
>>> [    0.002978]  ? start_kernel+0x66/0x547
>>> [    0.002980]  ? load_ucode_bsp+0x4c/0xcd
>>> [    0.002982]  ? secondary_startup_64_no_verify+0xb0/0xbb
>>> [    0.002986] random: get_random_bytes called from __warn+0xab/0x110 with crng_init=0
>>> [    0.002988] ---[ end trace f151227d0b39be70 ]---
>>>
>>> At the same time, the kernel image is protected with memblock_reserve(),
>>> so we can just start searching at PAGE_SIZE. In this case the
>>> bottom-up allocation has the same chances to success as a top-down
>>> allocation, so there is no reason to fallback in the case of a
>>> failure. All together it simplifies the logic.
>>>
>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>
>> Hi Roman, Thomas and other linux-mips folks,
>>
>> Kamal and myself have been unable to boot v5.11 on MIPS since this
>> commit, reverting it makes our MIPS platforms boot successfully. We do
>> not see a warning like this one in the commit message, instead what
>> happens appear to be a corrupted Device Tree which prevents the parsing
>> of the "rdb" node and leading to the interrupt controllers not being
>> registered, and the system eventually not booting.
>>
>> The Device Tree is built-into the kernel image and resides at
>> arch/mips/boot/dts/brcm/bcm97435svmb.dts.
>>
>> Do you have any idea what could be wrong with MIPS specifically here?
> 
> Apparently there is a memblock allocation in one of the functions called
> from arch_mem_init() between plat_mem_setup() and
> early_init_fdt_reserve_self().
> 
> If you have serial available that early we can try to track it down with
> forcing memblock_debug in mm/memblock.c to 1:
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index afaefa8fc6ab..83034245f8d5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -151,7 +151,7 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
>                         pr_info(fmt, ##__VA_ARGS__);                    \
>         } while (0)
>  
> -static int memblock_debug __initdata_memblock;
> +static int memblock_debug __initdata_memblock = 1;
>  static bool system_has_some_mirror __initdata_memblock = false;
>  static int memblock_can_resize __initdata_memblock;
>  static int memblock_memory_in_slab __initdata_memblock = 0;
> 
> 
> Regardless, I think that moving DT self reservation just after
> plat_mem_setup() is safe and it'll make things more robust.
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 279be0153f8b..f476b99a7bcd 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -623,6 +623,8 @@ static void __init arch_mem_init(char **cmdline_p)
>  {
>  	/* call board setup routine */
>  	plat_mem_setup();
> +	early_init_fdt_reserve_self();
> +	early_init_fdt_scan_reserved_mem();
>  	memblock_set_bottom_up(true);
>  
>  	bootcmdline_init();
> @@ -636,9 +638,6 @@ static void __init arch_mem_init(char **cmdline_p)
>  
>  	check_kernel_sections_mem();
>  
> -	early_init_fdt_reserve_self();
> -	early_init_fdt_scan_reserved_mem();
> -
>  #ifndef CONFIG_NUMA
>  	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
>  #endif

Thanks a lot for taking a look! The current/broken memblock=debug output
looks like this:

[    0.000000] Linux version 5.11.0-g5695e5161974 (florian@localhost)
(mipsel-linux-gcc (GCC) 8.3.0, GNU ld (GNU Binutils) 2.32) #84 SMP Sun
Feb 28 10:01:50 PST 2021
[    0.000000] CPU0 revision is: 00025b00 (Broadcom BMIPS5200)
[    0.000000] FPU revision is: 00130001
[    0.000000] memblock_add: [0x00000000-0x0fffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] memblock_add: [0x20000000-0x4fffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] memblock_add: [0x90000000-0xcfffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] MIPS: machine is Broadcom BCM97435SVMB
[    0.000000] earlycon: ns16550a0 at MMIO32 0x10406b00 (options '')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] memblock_reserve: [0x00aa7600-0x00aaa0a0]
setup_arch+0x128/0x69c
[    0.000000] memblock_reserve: [0x00010000-0x018313cf]
setup_arch+0x1f8/0x69c
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] memblock_alloc_try_nid: 10913 bytes align=0x40 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x00001000-0x00003aa0]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32680 bytes align=0x4 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x00003aa4-0x0000ba4b]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 25 bytes align=0x4 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x0000ba4c-0x0000ba64]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_reserve: [0x0096a000-0x00969fff]
setup_arch+0x3fc/0x69c
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e0/0x69c
[    0.000000] memblock_reserve: [0x0000ba80-0x0000ba9f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e0/0x69c
[    0.000000] memblock_reserve: [0x0000bb00-0x0000bb1f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e0/0x69c
[    0.000000] memblock_reserve: [0x0000bb80-0x0000bb9f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 64
bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, no aliases,
linesize 32 bytes
[    0.000000] MIPS secondary cache 512kB, 8-way, linesize 128 bytes.
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0000c000-0x0000cfff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0000d000-0x0000dfff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0000e000-0x0000efff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   HighMem  [mem 0x0000000010000000-0x00000000cfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000004fffffff]
[    0.000000]   node   0: [mem 0x0000000090000000-0x00000000cfffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x00000000cfffffff]
[    0.000000] memblock_alloc_try_nid: 27262976 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000
alloc_node_mem_map.constprop.135+0x6c/0xc8
[    0.000000] memblock_reserve: [0x01831400-0x032313ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000 setup_usemap+0x64/0x98
[    0.000000] memblock_reserve: [0x0000bc00-0x0000bc1f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 384 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000 setup_usemap+0x64/0x98
[    0.000000] memblock_reserve: [0x0000bc80-0x0000bdff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x80000000 reserved size = 0x0322f032
[    0.000000]  memory.cnt  = 0x3
[    0.000000]  memory[0x0]     [0x00000000-0x0fffffff], 0x10000000
bytes flags: 0x0
[    0.000000]  memory[0x1]     [0x20000000-0x4fffffff], 0x30000000
bytes flags: 0x0
[    0.000000]  memory[0x2]     [0x90000000-0xcfffffff], 0x40000000
bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0xa
[    0.000000]  reserved[0x0]   [0x00001000-0x00003aa0], 0x00002aa1
bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x00003aa4-0x0000ba64], 0x00007fc1
bytes flags: 0x0
[    0.000000]  reserved[0x2]   [0x0000ba80-0x0000ba9f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x3]   [0x0000bb00-0x0000bb1f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x4]   [0x0000bb80-0x0000bb9f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x5]   [0x0000bc00-0x0000bc1f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x6]   [0x0000bc80-0x0000bdff], 0x00000180
bytes flags: 0x0
[    0.000000]  reserved[0x7]   [0x0000c000-0x0000efff], 0x00003000
bytes flags: 0x0
[    0.000000]  reserved[0x8]   [0x00010000-0x018313cf], 0x018213d0
bytes flags: 0x0
[    0.000000]  reserved[0x9]   [0x01831400-0x032313ff], 0x01a00000
bytes flags: 0x0
[    0.000000] memblock_alloc_try_nid: 30 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 start_kernel+0x12c/0x654
[    0.000000] memblock_reserve: [0x0000be00-0x0000be1d]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 30 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 start_kernel+0x150/0x654
[    0.000000] memblock_reserve: [0x0000be80-0x0000be9d]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_embed_first_chunk+0x3b0/0x884
[    0.000000] memblock_reserve: [0x0000f000-0x0000ffff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_embed_first_chunk+0x5a4/0x884
[    0.000000] memblock_reserve: [0x03231400-0x032323ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 294912 bytes align=0x1000 nid=-1
from=0x01000000 max_addr=0x00000000 pcpu_dfl_fc_alloc+0x24/0x30
[    0.000000] memblock_reserve: [0x03233000-0x0327afff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_free: [0x03245000-0x03244fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x03257000-0x03256fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x03269000-0x03268fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x0327b000-0x0327afff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] percpu: Embedded 18 pages/cpu s50704 r0 d23024 u73728
[    0.000000] memblock_alloc_try_nid: 4 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x178/0x6ec
[    0.000000] memblock_reserve: [0x0000bf00-0x0000bf03]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x1a8/0x6ec
[    0.000000] memblock_reserve: [0x0000bf80-0x0000bf83]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 16 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x1dc/0x6ec
[    0.000000] memblock_reserve: [0x03232400-0x0323240f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 16 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x20c/0x6ec
[    0.000000] memblock_reserve: [0x03232480-0x0323248f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 128 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x558/0x6ec
[    0.000000] memblock_reserve: [0x03232500-0x0323257f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 92 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x8c/0x294
[    0.000000] memblock_reserve: [0x03232580-0x032325db]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 768 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0xe0/0x294
[    0.000000] memblock_reserve: [0x03232600-0x032328ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 772 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x124/0x294
[    0.000000] memblock_reserve: [0x03232900-0x03232c03]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 192 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x158/0x294
[    0.000000] memblock_reserve: [0x03232c80-0x03232d3f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_free: [0x0000f000-0x0000ffff]
pcpu_embed_first_chunk+0x838/0x884
[    0.000000] memblock_free: [0x03231400-0x032323ff]
pcpu_embed_first_chunk+0x850/0x884
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 523776
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] memblock_alloc_try_nid: 131072 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 alloc_large_system_hash+0x1f8/0x33c
[    0.000000] memblock_reserve: [0x0327b000-0x0329afff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes, linear)
[    0.000000] memblock_alloc_try_nid: 65536 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 alloc_large_system_hash+0x1f8/0x33c
[    0.000000] memblock_reserve: [0x0329b000-0x032aafff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes, linear)
[    0.000000] memblock_reserve: [0x00000000-0x000003ff]
trap_init+0x70/0x4e8
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 2045268K/2097152K available (8226K kernel code,
1070K rwdata, 1336K rodata, 13808K init, 260K bss, 51884K reserved, 0K
cma-reserved, 1835008K highmem)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] NR_IRQS: 256
[    0.000000] OF: Bad cell count for /rdb
[    0.000000] irq_bcm7038_l1: failed to remap intc L1 registers
[    0.000000] OF: of_irq_init: children remain, but no parents
[    0.000000] random: get_random_bytes called from
start_kernel+0x444/0x654 with crng_init=0
[    0.000000] sched_clock: 32 bits at 250 Hz, resolution 4000000ns,
wraps every 8589934590000000ns

and with your patch applied which unfortunately did not work we have the
following:

[    0.000000] Linux version 5.11.0-g5695e5161974 (florian@localhost)
(mipsel-linux-gcc (GCC) 8.3.0, GNU ld (GNU Binutils) 2.32) #86 SMP Sun
Feb 28 10:04:54 PST 2021
[    0.000000] CPU0 revision is: 00025b00 (Broadcom BMIPS5200)
[    0.000000] FPU revision is: 00130001
[    0.000000] memblock_add: [0x00000000-0x0fffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] memblock_add: [0x20000000-0x4fffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] memblock_add: [0x90000000-0xcfffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] MIPS: machine is Broadcom BCM97435SVMB
[    0.000000] memblock_reserve: [0x00aa7600-0x00aaa0a0]
setup_arch+0x60/0x6a4
[    0.000000] earlycon: ns16550a0 at MMIO32 0x10406b00 (options '')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] memblock_reserve: [0x00010000-0x018313cf]
setup_arch+0x200/0x6a4
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] memblock_alloc_try_nid: 10913 bytes align=0x40 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x00001000-0x00003aa0]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32680 bytes align=0x4 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x00003aa4-0x0000ba4b]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 25 bytes align=0x4 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x0000ba4c-0x0000ba64]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_reserve: [0x0096a000-0x00969fff]
setup_arch+0x404/0x6a4
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e8/0x6a4
[    0.000000] memblock_reserve: [0x0000ba80-0x0000ba9f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e8/0x6a4
[    0.000000] memblock_reserve: [0x0000bb00-0x0000bb1f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e8/0x6a4
[    0.000000] memblock_reserve: [0x0000bb80-0x0000bb9f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 64
bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, no aliases,
linesize 32 bytes
[    0.000000] MIPS secondary cache 512kB, 8-way, linesize 128 bytes.
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0000c000-0x0000cfff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0000d000-0x0000dfff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0000e000-0x0000efff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   HighMem  [mem 0x0000000010000000-0x00000000cfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000004fffffff]
[    0.000000]   node   0: [mem 0x0000000090000000-0x00000000cfffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x00000000cfffffff]
[    0.000000] memblock_alloc_try_nid: 27262976 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000
alloc_node_mem_map.constprop.135+0x6c/0xc8
[    0.000000] memblock_reserve: [0x01831400-0x032313ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000 setup_usemap+0x64/0x98
[    0.000000] memblock_reserve: [0x0000bc00-0x0000bc1f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 384 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000 setup_usemap+0x64/0x98
[    0.000000] memblock_reserve: [0x0000bc80-0x0000bdff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x80000000 reserved size = 0x0322f032
[    0.000000]  memory.cnt  = 0x3
[    0.000000]  memory[0x0]     [0x00000000-0x0fffffff], 0x10000000
bytes flags: 0x0
[    0.000000]  memory[0x1]     [0x20000000-0x4fffffff], 0x30000000
bytes flags: 0x0
[    0.000000]  memory[0x2]     [0x90000000-0xcfffffff], 0x40000000
bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0xa
[    0.000000]  reserved[0x0]   [0x00001000-0x00003aa0], 0x00002aa1
bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x00003aa4-0x0000ba64], 0x00007fc1
bytes flags: 0x0
[    0.000000]  reserved[0x2]   [0x0000ba80-0x0000ba9f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x3]   [0x0000bb00-0x0000bb1f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x4]   [0x0000bb80-0x0000bb9f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x5]   [0x0000bc00-0x0000bc1f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x6]   [0x0000bc80-0x0000bdff], 0x00000180
bytes flags: 0x0
[    0.000000]  reserved[0x7]   [0x0000c000-0x0000efff], 0x00003000
bytes flags: 0x0
[    0.000000]  reserved[0x8]   [0x00010000-0x018313cf], 0x018213d0
bytes flags: 0x0
[    0.000000]  reserved[0x9]   [0x01831400-0x032313ff], 0x01a00000
bytes flags: 0x0
[    0.000000] memblock_alloc_try_nid: 30 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 start_kernel+0x12c/0x654
[    0.000000] memblock_reserve: [0x0000be00-0x0000be1d]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 30 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 start_kernel+0x150/0x654
[    0.000000] memblock_reserve: [0x0000be80-0x0000be9d]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_embed_first_chunk+0x3b0/0x884
[    0.000000] memblock_reserve: [0x0000f000-0x0000ffff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_embed_first_chunk+0x5a4/0x884
[    0.000000] memblock_reserve: [0x03231400-0x032323ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 294912 bytes align=0x1000 nid=-1
from=0x01000000 max_addr=0x00000000 pcpu_dfl_fc_alloc+0x24/0x30
[    0.000000] memblock_reserve: [0x03233000-0x0327afff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_free: [0x03245000-0x03244fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x03257000-0x03256fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x03269000-0x03268fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x0327b000-0x0327afff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] percpu: Embedded 18 pages/cpu s50704 r0 d23024 u73728
[    0.000000] memblock_alloc_try_nid: 4 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x178/0x6ec
[    0.000000] memblock_reserve: [0x0000bf00-0x0000bf03]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x1a8/0x6ec
[    0.000000] memblock_reserve: [0x0000bf80-0x0000bf83]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 16 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x1dc/0x6ec
[    0.000000] memblock_reserve: [0x03232400-0x0323240f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 16 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x20c/0x6ec
[    0.000000] memblock_reserve: [0x03232480-0x0323248f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 128 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x558/0x6ec
[    0.000000] memblock_reserve: [0x03232500-0x0323257f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 92 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x8c/0x294
[    0.000000] memblock_reserve: [0x03232580-0x032325db]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 768 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0xe0/0x294
[    0.000000] memblock_reserve: [0x03232600-0x032328ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 772 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x124/0x294
[    0.000000] memblock_reserve: [0x03232900-0x03232c03]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 192 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x158/0x294
[    0.000000] memblock_reserve: [0x03232c80-0x03232d3f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_free: [0x0000f000-0x0000ffff]
pcpu_embed_first_chunk+0x838/0x884
[    0.000000] memblock_free: [0x03231400-0x032323ff]
pcpu_embed_first_chunk+0x850/0x884
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 523776
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] memblock_alloc_try_nid: 131072 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 alloc_large_system_hash+0x1f8/0x33c
[    0.000000] memblock_reserve: [0x0327b000-0x0329afff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes, linear)
[    0.000000] memblock_alloc_try_nid: 65536 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 alloc_large_system_hash+0x1f8/0x33c
[    0.000000] memblock_reserve: [0x0329b000-0x032aafff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes, linear)
[    0.000000] memblock_reserve: [0x00000000-0x000003ff]
trap_init+0x70/0x4e8
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 2045268K/2097152K available (8226K kernel code,
1070K rwdata, 1336K rodata, 13808K init, 260K bss, 51884K reserved, 0K
cma-reserved, 1835008K highmem)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] NR_IRQS: 256
[    0.000000] OF: Bad cell count for /rdb
[    0.000000] irq_bcm7038_l1: failed to remap intc L1 registers
[    0.000000] OF: of_irq_init: children remain, but no parents
[    0.000000] random: get_random_bytes called from
start_kernel+0x444/0x654 with crng_init=0
[    0.000000] sched_clock: 32 bits at 250 Hz, resolution 4000000ns,
wraps every 8589934590000000ns

With only the revert of f787b0b4502cde50c3583432d6cb9bd8306fc242
("memblock: do not start bottom-up allocations with kernel_end") and an
unmodified arch/mips/kernel/setup.c, this boots successfully:

[    0.000000] Linux version 5.11.0-gf787b0b4502c (florian@locahost)
(mipsel-linux-gcc (GCC) 8.3.0, GNU ld (GNU Binutils) 2.32) #88 SMP Sun
Feb 28 10:13:21 PST 2021
[    0.000000] CPU0 revision is: 00025b00 (Broadcom BMIPS5200)
[    0.000000] FPU revision is: 00130001
[    0.000000] memblock_add: [0x00000000-0x0fffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] memblock_add: [0x20000000-0x4fffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] memblock_add: [0x90000000-0xcfffffff]
early_init_dt_scan_memory+0x160/0x1e0
[    0.000000] MIPS: machine is Broadcom BCM97435SVMB
[    0.000000] earlycon: ns16550a0 at MMIO32 0x10406b00 (options '')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] memblock_reserve: [0x00aa9600-0x00aac0a0]
setup_arch+0x128/0x69c
[    0.000000] memblock_reserve: [0x00010000-0x018313cf]
setup_arch+0x1f8/0x69c
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] memblock_alloc_try_nid: 10913 bytes align=0x40 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x01831400-0x01833ea0]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32680 bytes align=0x4 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x01833ea4-0x0183be4b]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 25 bytes align=0x4 nid=-1
from=0x00000000 max_addr=0x00000000
early_init_dt_alloc_memory_arch+0x40/0x84
[    0.000000] memblock_reserve: [0x018313d0-0x018313e8]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_reserve: [0x0096c000-0x0096bfff]
setup_arch+0x3fc/0x69c
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e0/0x69c
[    0.000000] memblock_reserve: [0x0183be80-0x0183be9f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e0/0x69c
[    0.000000] memblock_reserve: [0x0183bf00-0x0183bf1f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 setup_arch+0x4e0/0x69c
[    0.000000] memblock_reserve: [0x0183bf80-0x0183bf9f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 64
bytes.
[    0.000000] Primary data cache 32kB, 4-way, VIPT, no aliases,
linesize 32 bytes
[    0.000000] MIPS secondary cache 512kB, 8-way, linesize 128 bytes.
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0183c000-0x0183cfff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0183d000-0x0183dfff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0xffffffff fixrange_init+0x90/0xf4
[    0.000000] memblock_reserve: [0x0183e000-0x0183efff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   HighMem  [mem 0x0000000010000000-0x00000000cfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000004fffffff]
[    0.000000]   node   0: [mem 0x0000000090000000-0x00000000cfffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x00000000cfffffff]
[    0.000000] memblock_alloc_try_nid: 27262976 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000
alloc_node_mem_map.constprop.135+0x6c/0xc8
[    0.000000] memblock_reserve: [0x0183f000-0x0323efff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 32 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000 setup_usemap+0x64/0x98
[    0.000000] memblock_reserve: [0x0323f000-0x0323f01f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 384 bytes align=0x80 nid=0
from=0x00000000 max_addr=0x00000000 setup_usemap+0x64/0x98
[    0.000000] memblock_reserve: [0x0323f080-0x0323f1ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x80000000 reserved size = 0x0322f032
[    0.000000]  memory.cnt  = 0x3
[    0.000000]  memory[0x0]     [0x00000000-0x0fffffff], 0x10000000
bytes flags: 0x0
[    0.000000]  memory[0x1]     [0x20000000-0x4fffffff], 0x30000000
bytes flags: 0x0
[    0.000000]  memory[0x2]     [0x90000000-0xcfffffff], 0x40000000
bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x8
[    0.000000]  reserved[0x0]   [0x00010000-0x018313e8], 0x018213e9
bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x01831400-0x01833ea0], 0x00002aa1
bytes flags: 0x0
[    0.000000]  reserved[0x2]   [0x01833ea4-0x0183be4b], 0x00007fa8
bytes flags: 0x0
[    0.000000]  reserved[0x3]   [0x0183be80-0x0183be9f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x4]   [0x0183bf00-0x0183bf1f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x5]   [0x0183bf80-0x0183bf9f], 0x00000020
bytes flags: 0x0
[    0.000000]  reserved[0x6]   [0x0183c000-0x0323f01f], 0x01a03020
bytes flags: 0x0
[    0.000000]  reserved[0x7]   [0x0323f080-0x0323f1ff], 0x00000180
bytes flags: 0x0
[    0.000000] memblock_alloc_try_nid: 30 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 start_kernel+0x12c/0x654
[    0.000000] memblock_reserve: [0x0323f200-0x0323f21d]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 30 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 start_kernel+0x150/0x654
[    0.000000] memblock_reserve: [0x0323f280-0x0323f29d]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_embed_first_chunk+0x3b0/0x884
[    0.000000] memblock_reserve: [0x03240000-0x03240fff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4096 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_embed_first_chunk+0x5a4/0x884
[    0.000000] memblock_reserve: [0x03241000-0x03241fff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 294912 bytes align=0x1000 nid=-1
from=0x01000000 max_addr=0x00000000 pcpu_dfl_fc_alloc+0x24/0x30
[    0.000000] memblock_reserve: [0x03242000-0x03289fff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_free: [0x03254000-0x03253fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x03266000-0x03265fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x03278000-0x03277fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] memblock_free: [0x0328a000-0x03289fff]
pcpu_embed_first_chunk+0x7a0/0x884
[    0.000000] percpu: Embedded 18 pages/cpu s50704 r0 d23024 u73728
[    0.000000] memblock_alloc_try_nid: 4 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x178/0x6ec
[    0.000000] memblock_reserve: [0x0323f300-0x0323f303]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 4 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x1a8/0x6ec
[    0.000000] memblock_reserve: [0x0323f380-0x0323f383]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 16 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x1dc/0x6ec
[    0.000000] memblock_reserve: [0x0323f400-0x0323f40f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 16 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x20c/0x6ec
[    0.000000] memblock_reserve: [0x0323f480-0x0323f48f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 128 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_setup_first_chunk+0x558/0x6ec
[    0.000000] memblock_reserve: [0x0323f500-0x0323f57f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 92 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x8c/0x294
[    0.000000] memblock_reserve: [0x0323f580-0x0323f5db]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 768 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0xe0/0x294
[    0.000000] memblock_reserve: [0x0323f600-0x0323f8ff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 772 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x124/0x294
[    0.000000] memblock_reserve: [0x0323f900-0x0323fc03]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_alloc_try_nid: 192 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 pcpu_alloc_first_chunk+0x158/0x294
[    0.000000] memblock_reserve: [0x0323fc80-0x0323fd3f]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] memblock_free: [0x03240000-0x03240fff]
pcpu_embed_first_chunk+0x838/0x884
[    0.000000] memblock_free: [0x03241000-0x03241fff]
pcpu_embed_first_chunk+0x850/0x884
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 523776
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] memblock_alloc_try_nid: 131072 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 alloc_large_system_hash+0x1f8/0x33c
[    0.000000] memblock_reserve: [0x0328a000-0x032a9fff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes, linear)
[    0.000000] memblock_alloc_try_nid: 65536 bytes align=0x80 nid=-1
from=0x00000000 max_addr=0x00000000 alloc_large_system_hash+0x1f8/0x33c
[    0.000000] memblock_reserve: [0x032aa000-0x032b9fff]
memblock_alloc_range_nid+0xf8/0x198
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes, linear)
[    0.000000] memblock_reserve: [0x00000000-0x000003ff]
trap_init+0x70/0x4e8
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 2045272K/2097152K available (8226K kernel code,
1078K rwdata, 1336K rodata, 13800K init, 260K bss, 51880K reserved, 0K
cma-reserved, 1835008K highmem)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] NR_IRQS: 256
[    0.000000] irq_bcm7038_l1: registered BCM7038 L1 intc
(/rdb/interrupt-controller@41b500, IRQs: 128)
[    0.000000] irq_brcmstb_l2: registered L2 intc
(/rdb/interrupt-controller@403000, parent irq: 52)
[    0.000000] irq_bcm7120_l2: registered BCM7120 L2 intc
(/rdb/interrupt-controller@406780, parent IRQ(s): 2)
[    0.000000] irq_bcm7120_l2: registered BCM7120 L2 intc
(/rdb/interrupt-controller@409480, parent IRQ(s): 3)
[    0.000000] irq_brcmstb_l2: registered L2 intc
(/rdb/interrupt-controller@408440, parent irq: 54)
[    0.000000] irq_brcmstb_l2: registered L2 intc
(/rdb/interrupt-controller@41b000, parent irq: 24)
[    0.000000] irq_brcmstb_l2: registered L2 intc
(/rdb/interrupt-controller@41bd00, parent irq: 25)
[    0.000000] random: get_random_bytes called from
start_kernel+0x444/0x654 with crng_init=0
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 10882621761 ns
[    0.000000] sched_clock: 32 bits at 250 Hz, resolution 4000000ns,
wraps every 8589934590000000ns

The DTB is located at this offset within vmlinux:

37084: 80aac0a1      0 OBJECT  GLOBAL DEFAULT       10
__dtb_bcm97435svmb_end
48909: 80aa9600      0 OBJECT  GLOBAL DEFAULT       10
__dtb_bcm97435svmb_begin

0x8000_0000 maps to physical address 0x0 on these MIPS platforms.
-- 
Florian
