Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE336BB57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhDZVsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhDZVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:48:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56968C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:48:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b21so1192037plz.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=1YY3mr8Ojw8hYyrN1Xsnw5rr0sqfsQaqzoEu5nzulUY=;
        b=mFD8sOSgwHGSZa/aoNOneN49ZOuL+luraJNpTmGoQBs3ZK8leO2uNsQjiCpgHNLhWu
         xYYlNs8t7UJ80iYZdgG0Xg6uAr/jUBtpm11pKhCiJGVZWwCF0Dejnp0StOfeHgmiM7X3
         pv1DtoYxW1GkeCPewwV3fkpCrnbDA8nhRa38Uekk+FppGHZLp2KB5XbOTqRNebhSNq80
         /tllyDS5wnyQDCA4DQjgB3dQsw+2XFE0MebOl9Zcyu2Jx+MTYfU7IoAxHo3FlekDObPI
         iJx1UYJjYL747agvtvFP7/LkhcexCG6pFMvoUcOXIUX2WjEHdtWqRZwUvhy4KXL7rHxX
         cRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=1YY3mr8Ojw8hYyrN1Xsnw5rr0sqfsQaqzoEu5nzulUY=;
        b=uVeQ61Nk3FXKXeeQMIBlRUwM5WcJF6NU+v16HP0iTjX01Dk++OjkT4dN+QPL1ol24Z
         bSmviubUg2qJzKvuU44uMyoZInYNWexr61KxHixLbOxDHd8xT8OFNT8P8EJEwBKAHFTC
         JvDW6VZlT+VeRuFFEA02YCyhtqX/yZD6dd9tG24wxJ95syhhrYcc2JEG91+O25LAQmjq
         NxXzgjJgWiL+kyRzQc78VvTtHGTzAUqi/Wt3efryoYHaxSxGQjrYtI6F5Z6LtQrLq25Q
         6rtFaj2N+YEK+hoL/KsBSN9ADmosNuSLn+GHdG6cn6ttvz1V4pW+EI8h23iU5miOxUKh
         oCeA==
X-Gm-Message-State: AOAM533EAa2hIfYPKpKvHjA/439T5E6dzs//oKCU1mRD+ohGYjnax9Ac
        3RgN1eks+vAgzpORlxPSHC2PfSjAqFY=
X-Google-Smtp-Source: ABdhPJwuWlBQPIIjNaR48nYkad5zWbSFjQnWivZG/NjubVIBB6PX3iYpGBwkYb0tIlN2l833El7WuA==
X-Received: by 2002:a17:90b:1190:: with SMTP id gk16mr1229546pjb.57.1619473683170;
        Mon, 26 Apr 2021 14:48:03 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c193sm573056pfc.11.2021.04.26.14.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 14:48:02 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by
 default""
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com>
 <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
Date:   Mon, 26 Apr 2021 14:47:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------295375603EEC5FD178306FC5"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------295375603EEC5FD178306FC5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 4/26/21 2:33 PM, Saravana Kannan wrote:
> On Mon, Apr 26, 2021 at 1:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Hi Saravana,
>>
>> Adding Sudeep and Christian, Al and Jim.
>>
>> On 3/2/21 1:11 PM, Saravana Kannan wrote:
>>> This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
>>>
>>> Since all reported issues due to fw_devlink=on should be addressed by
>>> this series, revert the revert. fw_devlink=on Take II.
>>>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>
>> This change breaks booting on SCMI-based platforms such as ARCH_BRCMSTB.
>> If I revert this change or boot with fw_devlink=permissive, then our
>> systems boot again. From a quick look, the SCMI clock provider was never
>> probed which means that our UART driver never got a chance to get its
>> clock and we have no console -> timeout.
> 
> We explicitly landed changes to handle this condition. So we'll see if
> this is what is happening.
> 
>> Al, AFAICT you had started to analyze this before in the context of
>> SCMI, do you mind sharing what you had found?
>>
>> Saravana, is there any debugging output that we can help provide?
> 
> Thanks for the report. Couple of things that can help:
> 1. Example DTS file (the final board file so that I can get the full DT view).

Attached BCX972160DV.dts which is one such system.

> 2. Point out the UART device node and the SCMI device node that you
> suspect is causing the issue.

The SCMI provider node is brcm_scmi@0 and its sub-node protocol@14 is
the clock provider. The UART node is /rdb/serial@840c000.

> 3. Boot logs with dev_dbg changed to dev_info in device_link_add() and
> device_links_check_suppliers()

OK, I did not want to modify the kernel so I just enabled dynamic debug
prints from the command line, if this is too verbose let me know.

Thank you for your prompt response.
-- 
Florian

--------------295375603EEC5FD178306FC5
Content-Type: text/x-log; charset=UTF-8;
 name="fw_devlink_on.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="fw_devlink_on.log"

[    0.000000] Linux version 5.12.0-gef1244124349 (fainelli@fainelli-desktop) (arm-linux-gcc (GCC) 8.3.0, GNU ld (GNU Binutils) 2.32) #32 S
MP Mon Apr 26 14:29:52 PDT 2021
[    0.000000] CPU: ARMv7 Processor [420f1000] revision 0 (ARMv7), cr=30c5383d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: BCX972160DV
[    0.000000] earlycon: ns16550a0 at MMIO32 0x000000000840c000 (options '115200')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] printk: debug: skip boot console de-registration.
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 16 MiB at 0x000000006f000000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x000000006fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000070000000-0x000000013fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000fdffefff]
[    0.000000]   node   0: [mem 0x00000000fdfff000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
[    0.000000] On node 0 totalpages: 1048576
[    0.000000]   DMA zone: 1920 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:63
[    0.000000]   HighMem zone: 851968 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS resident on physical CPU 0x0
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 20 pages/cpu s49804 r8192 d23924 u81920
[    0.000000] pcpu-alloc: s49804 r8192 d23924 u81920 alloc=20*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1046656
[    0.000000] Kernel command line: fw_devlink=on dyndbg="file drivers/base/core.c +p" debug earlycon keep_bootcon
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x0000000068400000-0x000000006c400000] (64MB)
[    0.000000] Memory: 3986968K/4194304K available (12288K kernel code, 1210K rwdata, 2648K rodata, 14336K init, 246K bss, 190952K reserved
, 16384K cma-reserved, 3358716K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 37847 entries in 74 pages
[    0.000000] ftrace: allocated 74 pages with 3 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@8400000, parent irq: 24)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@84a1000, parent irq: 25)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@84a1800, parent irq: 26)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@8410640, parent irq: 27)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@841a880, parent irq: 28)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@840a400, parent irq: 29)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@841a380, parent irq: 30)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@840a440, parent irq: 31)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@841a3c0, parent irq: 32)
[    0.000000] irq_brcmstb_l2: registered L2 intc (/rdb/interrupt-controller@8419000, parent irq: 33)
[    0.000000] random: get_random_bytes called from start_kernel+0x42c/0x60c with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 27.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x63a1e71a3, max_idle_ns: 440795203123 ns
[    0.000001] sched_clock: 56 bits at 27MHz, resolution 37ns, wraps every 4398046511093ns
[    0.008134] Switching to timer-based delay loop, resolution 37ns
[    0.014453] Console: colour dummy device 80x30
[    0.018988] printk: console [tty0] enabled
[    0.023186] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.00 BogoMIPS (lpj=27000)
[    0.033654] pid_max: default: 32768 minimum: 301
[    0.038432] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.045855] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.054210] CPU: Testing write buffer coherency: ok
[    0.059444] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.065526] Setting up static identity map for 0x40200000 - 0x40200060
[    0.072250] rcu: Hierarchical SRCU implementation.
[    0.078389] brcmstb: biuctrl: MCP: Enabling write pairing
[    0.084034] smp: Bringing up secondary CPUs ...
[    0.089532] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.090446] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.091316] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.091378] smp: Brought up 1 node, 4 CPUs
[    0.112826] SMP: Total of 4 processors activated (216.00 BogoMIPS).
[    0.119209] CPU: All CPU(s) started in HYP mode.
[    0.123902] CPU: Virtualization extensions available.
[    0.130052] devtmpfs: initialized
[    0.135401] device: 'platform': device_add
[    0.139664] device: 'cpu': device_add
[    0.143419] device: 'container': device_add
[    0.148274] VFP support v0.3: implementor 42 architecture 3 part 10 variant 0 rev 0
[    0.156107] device: 'workqueue': device_add
[    0.160469] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.170396] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.178019] pinctrl core: initialized pinctrl subsystem
[    0.183502] device: 'reg-dummy': device_add
[    0.187874] device: 'regulator.0': device_add
[    0.192941] NET: Registered protocol family 16
[    0.198853] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.206556] device: 'vtcon0': device_add
[    0.210923] thermal_sys: Registered thermal governor 'step_wise'
[    0.210942] thermal_sys: Registered thermal governor 'user_space'
[    0.217182] device: 'thermal_zone0': device_add
[    0.228089] device: 'thermal_zone1': device_add
[    0.232819] cpuidle: using governor menu
[    0.236916] No ATAGs?
[    0.239331] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.247505] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.253693] /rdb/syscon@84a2400: Broadcom Brahma-B15 readahead cache
[    0.260356] device: 'soc0': device_add
[    0.264207] Serial: AMBA PL011 UART driver
[    0.268567] device: 'psci': device_add
[    0.272585] device: 'timer': device_add
[    0.276708] device: 'brcm_scmi_mailbox@0': device_add
[    0.281972] device: 'brcm_scmi@0': device_add
[    0.286506] device: 'platform:brcm_scmi_mailbox@0--platform:brcm_scmi@0': device_add
[    0.294403] devices_kset: Moving brcm_scmi@0 to end of list
[    0.300086] platform brcm_scmi@0: Linked as a consumer to brcm_scmi_mailbox@0
[    0.307400] device: 'rdb': device_add
[    0.311163] OF: /rdb/brcmstb-clks/cpu_mdiv_ch0@8161010: could not get #clock-cells for /rdb/brcmstb-clks/cpu_ndiv_int@8161018
[    0.324194] device: 'platform:brcm_scmi@0--platform:rdb': device_add
[    0.330675] platform rdb: Linked as a sync state only consumer to brcm_scmi@0
[    0.338229] device: '840c000.serial': device_add
[    0.342957] device: 'platform:brcm_scmi@0--platform:840c000.serial': device_add
[    0.350440] devices_kset: Moving 840c000.serial to end of list
[    0.356358] platform 840c000.serial: Linked as a consumer to brcm_scmi@0
[    0.363315] device: '840d000.serial': device_add
[    0.368047] device: 'platform:brcm_scmi@0--platform:840d000.serial': device_add
[    0.375512] devices_kset: Moving 840d000.serial to end of list
[    0.381446] platform 840d000.serial: Linked as a consumer to brcm_scmi@0
[    0.388373] device: '840e000.serial': device_add
[    0.393116] device: 'platform:brcm_scmi@0--platform:840e000.serial': device_add
[    0.400573] devices_kset: Moving 840e000.serial to end of list
[    0.406506] platform 840e000.serial: Linked as a consumer to brcm_scmi@0
[    0.413451] device: '8b2c800.rescal': device_add
[    0.418349] device: '8d0f200.usb-phy': device_add
[    0.423175] device: 'platform:brcm_scmi@0--platform:8d0f200.usb-phy': device_add
[    0.430729] devices_kset: Moving 8d0f200.usb-phy to end of list
[    0.436794] platform 8d0f200.usb-phy: Linked as a consumer to brcm_scmi@0
[    0.443804] device: '8d00000.xhci_v2': device_add
[    0.448650] device: 'platform:brcm_scmi@0--platform:8d00000.xhci_v2': device_add
[    0.456190] devices_kset: Moving 8d00000.xhci_v2 to end of list
[    0.462212] platform 8d00000.xhci_v2: Linked as a consumer to brcm_scmi@0
[    0.469118] device: 'platform:8d0f200.usb-phy--platform:8d00000.xhci_v2': device_add
[    0.477025] devices_kset: Moving 8d00000.xhci_v2 to end of list
[    0.483053] platform 8d00000.xhci_v2: Linked as a consumer to 8d0f200.usb-phy
[    0.490510] device: '8f00000.ethernet': device_add
[    0.495435] device: 'platform:brcm_scmi@0--platform:8f00000.ethernet': device_add
[    0.503067] devices_kset: Moving 8f00000.ethernet to end of list
[    0.509174] platform 8f00000.ethernet: Linked as a consumer to brcm_scmi@0
[    0.516310] device: '840a500.gpio': device_add
[    0.520962] device: '841a400.gpio': device_add
[    0.525641] device: '8b0a000.sata': device_add
[    0.530223] device: 'platform:brcm_scmi@0--platform:8b0a000.sata': device_add
[    0.537529] devices_kset: Moving 8b0a000.sata to end of list
[    0.543275] platform 8b0a000.sata: Linked as a consumer to brcm_scmi@0
[    0.549992] device: '8b08100.sata_phy': device_add
[    0.554899] device: 'platform:8b08100.sata_phy--platform:8b0a000.sata': device_add
[    0.562609] platform 8b0a000.sata: Linked as a sync state only consumer to 8b08100.sata_phy
[    0.571259] device: '84b0000.sdhci': device_add
[    0.575894] device: 'platform:brcm_scmi@0--platform:84b0000.sdhci': device_add
[    0.583294] devices_kset: Moving 84b0000.sdhci to end of list
[    0.589133] platform 84b0000.sdhci: Linked as a consumer to brcm_scmi@0
[    0.596079] device: '83fc000.gisb-arb': device_add
[    0.601132] device: '841a840.waketimer': device_add
[    0.606194] device: 'a581500.thermal': device_add
[    0.611102] device: '8410000.aon-ctrl': device_add
[    0.616025] device: 'rdb:memory_controllers': device_add
[    0.621502] device: 'rdb:memory_controllers:memc@0': device_add
[    0.627652] device: '9900000.memc-gen': device_add
[    0.632658] device: '9903000.memc-arb': device_add
[    0.637649] device: '9920000.ddr-phy': device_add
[    0.642559] device: '9908000.shimphy': device_add
[    0.647470] device: '9902000.memc-ddr': device_add
[    0.652578] device: '84b3400.spi': device_add
[    0.657422] device: '84b2120.qspi': device_add
[    0.662032] device: 'platform:brcm_scmi@0--platform:84b2120.qspi': device_add
[    0.669346] devices_kset: Moving 84b2120.qspi to end of list
[    0.675099] platform 84b2120.qspi: Linked as a consumer to brcm_scmi@0
[    0.681851] device: '8404000.syscon': device_add
[    0.686640] device: '8404534.syscon': device_add
[    0.691437] device: '8404100.syscon': device_add
[    0.696226] device: '8404124.syscon': device_add
[    0.700992] device: '8410700.syscon': device_add
[    0.705773] device: '841070c.syscon': device_add
[    0.710565] device: '9903004.syscon': device_add
[    0.715348] device: '8404084.syscon': device_add
[    0.720141] device: '84040a4.syscon': device_add
[    0.724924] device: '84b0344.syscon': device_add
[    0.729715] device: '84b1344.syscon': device_add
[    0.734500] device: '84b1500.syscon': device_add
[    0.739283] device: '84b037c.syscon': device_add
[    0.744090] device: '84b137c.syscon': device_add
[    0.748875] device: '84040ac.syscon': device_add
[    0.753711] device: '840a628.watchdog': device_add
[    0.758676] device: '83b0000.bsp': device_add
[    0.763261] device: '8418000.mspi': device_add
[    0.767901] device: '8408000.pwm': device_add
[    0.772519] device: '9700000.gpu': device_add
[    0.777022] device: 'rdb:gpu-mmu@9705000': device_add
[    0.782254] device: '9910000.syscon': device_add
[    0.787033] device: '9909000.syscon': device_add
[    0.791869] device: '9932000.dpfe-cpu': device_add
[    0.796819] device: '8402000.rng': device_add
[    0.801358] device: '8404318.reset-controller': device_add
[    0.807013] device: '84a2400.syscon': device_add
[    0.811815] device: '8452000.syscon': device_add
[    0.816581] device: 'reboot': device_add
[    0.820800] device: 'pmu': device_add
[    0.824740] device: '8b20000.pcie': device_add
[    0.829402] device: 'platform:brcm_scmi@0--platform:8b20000.pcie': device_add
[    0.836711] devices_kset: Moving 8b20000.pcie to end of list
[    0.842472] platform 8b20000.pcie: Linked as a consumer to brcm_scmi@0
[    0.849151] device: 'smpboot': device_add
[    0.853324] device: '100000.sram': device_add
[    0.857885] device: 'cpu0': device_add
[    0.861770] device: 'cpu1': device_add
[    0.865667] device: 'cpu2': device_add
[    0.869530] device: 'cpu3': device_add
[    0.883847] device: 'writeback': device_add
[    0.889865] SCSI subsystem initialized
[    0.893864] libata version 3.00 loaded.
[    0.897999] usbcore: registered new interface driver usbfs
[    0.903747] usbcore: registered new interface driver hub
[    0.909224] usbcore: registered new device driver usb
[    0.914426] mc: Linux media interface: v0.10
[    0.918809] videodev: Linux video capture interface: v2.00
[    0.924438] pps_core: LinuxPPS API ver. 1 registered
[    0.929498] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.938794] PTP clock support registered
[    0.942998] platform brcm_scmi@0: probe deferral - supplier brcm_scmi_mailbox@0 not ready
[    0.951637] Advanced Linux Sound Architecture Driver Initialized.
[    0.957934] device: 'lo': device_add
[    0.961904] device: 'rfkill': device_add
[    0.966762] clocksource: Switched to clocksource arch_sys_counter
[    1.003627] device: 'mem': device_add
[    1.007505] device: 'null': device_add
[    1.011388] device: 'port': device_add
[    1.015245] device: 'zero': device_add
[    1.019096] device: 'full': device_add
[    1.022942] device: 'random': device_add
[    1.026950] device: 'urandom': device_add
[    1.031079] device: 'kmsg': device_add
[    1.035020] device: 'tty': device_add
[    1.038831] device: 'console': device_add
[    1.042974] device: 'tty0': device_add
[    1.046862] device: 'vcs': device_add
[    1.050700] device: 'vcsu': device_add
[    1.054551] device: 'vcsa': device_add
[    1.058402] device: 'vcs1': device_add
[    1.062280] device: 'vcsu1': device_add
[    1.066224] device: 'vcsa1': device_add
[    1.070199] device: 'tty1': device_add
[    1.074081] device: 'tty2': device_add
[    1.077945] device: 'tty3': device_add
[    1.081798] device: 'tty4': device_add
[    1.085686] device: 'tty5': device_add
[    1.089517] device: 'tty6': device_add
[    1.093411] device: 'tty7': device_add
[    1.097295] device: 'tty8': device_add
[    1.101167] device: 'tty9': device_add
[    1.105025] device: 'tty10': device_add
[    1.109001] device: 'tty11': device_add
[    1.112966] device: 'tty12': device_add
[    1.116899] device: 'tty13': device_add
[    1.120850] device: 'tty14': device_add
[    1.124795] device: 'tty15': device_add
[    1.128739] device: 'tty16': device_add
[    1.132684] device: 'tty17': device_add
[    1.136623] device: 'tty18': device_add
[    1.140617] device: 'tty19': device_add
[    1.144553] device: 'tty20': device_add
[    1.148485] device: 'tty21': device_add
[    1.152405] device: 'tty22': device_add
[    1.156351] device: 'tty23': device_add
[    1.160287] device: 'tty24': device_add
[    1.164224] device: 'tty25': device_add
[    1.168171] device: 'tty26': device_add
[    1.172123] device: 'tty27': device_add
[    1.176078] device: 'tty28': device_add
[    1.180033] device: 'tty29': device_add
[    1.183996] device: 'tty30': device_add
[    1.187955] device: 'tty31': device_add
[    1.191913] device: 'tty32': device_add
[    1.195867] device: 'tty33': device_add
[    1.199802] device: 'tty34': device_add
[    1.203742] device: 'tty35': device_add
[    1.207702] device: 'tty36': device_add
[    1.211651] device: 'tty37': device_add
[    1.215628] device: 'tty38': device_add
[    1.219599] device: 'tty39': device_add
[    1.223560] device: 'tty40': device_add
[    1.227530] device: 'tty41': device_add
[    1.231491] device: 'tty42': device_add
[    1.235429] device: 'tty43': device_add
[    1.239398] device: 'tty44': device_add
[    1.243334] device: 'tty45': device_add
[    1.247261] device: 'tty46': device_add
[    1.251269] device: 'tty47': device_add
[    1.255217] device: 'tty48': device_add
[    1.259169] device: 'tty49': device_add
[    1.263136] device: 'tty50': device_add
[    1.267075] device: 'tty51': device_add
[    1.271072] device: 'tty52': device_add
[    1.275026] device: 'tty53': device_add
[    1.278965] device: 'tty54': device_add
[    1.282958] device: 'tty55': device_add
[    1.286905] device: 'tty56': device_add
[    1.290840] device: 'tty57': device_add
[    1.294797] device: 'tty58': device_add
[    1.298736] device: 'tty59': device_add
[    1.302709] device: 'tty60': device_add
[    1.306673] device: 'tty61': device_add
[    1.310628] device: 'tty62': device_add
[    1.314609] device: 'tty63': device_add
[    1.318700] NET: Registered protocol family 2
[    1.323375] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    1.331890] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    1.339829] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    1.347106] TCP: Hash tables configured (established 8192 bind 8192)
[    1.353670] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    1.360436] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    1.367702] NET: Registered protocol family 1
[    1.375093] RPC: Registered named UNIX socket transport module.
[    1.381137] RPC: Registered udp transport module.
[    1.385948] RPC: Registered tcp transport module.
[    1.390729] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.397603] device: 'regulatory.0': device_add
[    1.402302] PCI: CLS 0 bytes, default 64
[    3.410785] device: 'clocksource': device_add
[    3.415283] device: 'clocksource0': device_add
[    3.420011] device: 'clockevents': device_add
[    3.424466] device: 'clockevent0': device_add
[    3.428918] device: 'clockevent1': device_add
[    3.433358] device: 'clockevent2': device_add
[    3.437820] device: 'clockevent3': device_add
[    3.442277] device: 'broadcast': device_add
[    3.446657] device: 'software': device_add
[    3.450861] device: 'tracepoint': device_add
[    3.455213] device: 'uprobe': device_add
[    3.459228] device: 'breakpoint': device_add
[    3.463589] Initialise system trusted keyrings
[    3.468304] workingset: timestamp_bits=30 max_order=20 bucket_order=0
[    3.477332] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.483696] NFS: Registering the id_resolver key type
[    3.488880] Key type id_resolver registered
[    3.493160] Key type id_legacy registered
[    3.497284] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    3.504137] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    3.511656] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    3.518014] fuse: init (API version 7.33)
[    3.522124] device: 'fuse': device_add
[    3.526097] device: 'cuse': device_add
[    3.530132] Key type asymmetric registered
[    3.534299] Asymmetric key parser 'x509' registered
[    3.539303] bounce: pool size: 64 pages
[    3.543245] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    3.550780] io scheduler mq-deadline registered
[    3.555372] io scheduler kyber registered
[    3.559815] brcm-gisb-arb 83fc000.gisb-arb: registered irqs: 53, 54
[    3.566619] device: 'phy-8b08100.sata_phy.0': device_add
[    3.572114] brcm-sata-phy 8b08100.sata_phy: registered 1 port(s)
[    3.578762] device: 'gpiochip0': device_add
[    3.583122] device: 'gpiochip0': device_add
[    3.587461] device: 'gpiochip1': device_add
[    3.591811] device: 'gpiochip32': device_add
[    3.596239] device: 'wakeup0': device_add
[    3.600547] device: 'gpiochip2': device_add
[    3.604914] device: 'gpiochip64': device_add
[    3.609343] device: 'gpiochip3': device_add
[    3.613662] device: 'gpiochip96': device_add
[    3.618077] device: 'wakeup1': device_add
[    3.622741] platform 8b20000.pcie: probe deferral - supplier brcm_scmi@0 not ready
[    3.631146] brcmstb-pm: error mapping DDR PHY
[    3.635609] brcmstb-pm: probe of 8410000.aon-ctrl failed with error -22
[    3.642854] device: 'ptyp0': device_add
[    3.646907] device: 'ptyp1': device_add
[    3.650874] device: 'ptyp2': device_add
[    3.654826] device: 'ptyp3': device_add
[    3.658785] device: 'ptyp4': device_add
[    3.662719] device: 'ptyp5': device_add
[    3.666673] device: 'ptyp6': device_add
[    3.670626] device: 'ptyp7': device_add
[    3.674571] device: 'ptyp8': device_add
[    3.678508] device: 'ptyp9': device_add
[    3.682469] device: 'ptypa': device_add
[    3.686417] device: 'ptypb': device_add
[    3.690368] device: 'ptypc': device_add
[    3.694310] device: 'ptypd': device_add
[    3.698243] device: 'ptype': device_add
[    3.702181] device: 'ptypf': device_add
[    3.706121] device: 'ptyq0': device_add
[    3.710059] device: 'ptyq1': device_add
[    3.714037] device: 'ptyq2': device_add
[    3.717993] device: 'ptyq3': device_add
[    3.721935] device: 'ptyq4': device_add
[    3.725896] device: 'ptyq5': device_add
[    3.729849] device: 'ptyq6': device_add
[    3.733799] device: 'ptyq7': device_add
[    3.737773] device: 'ptyq8': device_add
[    3.741709] device: 'ptyq9': device_add
[    3.745700] device: 'ptyqa': device_add
[    3.749652] device: 'ptyqb': device_add
[    3.753596] device: 'ptyqc': device_add
[    3.757547] device: 'ptyqd': device_add
[    3.761493] device: 'ptyqe': device_add
[    3.765428] device: 'ptyqf': device_add
[    3.769388] device: 'ptyr0': device_add
[    3.773339] device: 'ptyr1': device_add
[    3.777295] device: 'ptyr2': device_add
[    3.781233] device: 'ptyr3': device_add
[    3.785182] device: 'ptyr4': device_add
[    3.789136] device: 'ptyr5': device_add
[    3.793066] device: 'ptyr6': device_add
[    3.796995] device: 'ptyr7': device_add
[    3.800928] device: 'ptyr8': device_add
[    3.804864] device: 'ptyr9': device_add
[    3.808812] device: 'ptyra': device_add
[    3.812777] device: 'ptyrb': device_add
[    3.816722] device: 'ptyrc': device_add
[    3.820706] device: 'ptyrd': device_add
[    3.824652] device: 'ptyre': device_add
[    3.828611] device: 'ptyrf': device_add
[    3.832535] device: 'ptys0': device_add
[    3.836481] device: 'ptys1': device_add
[    3.840415] device: 'ptys2': device_add
[    3.844333] device: 'ptys3': device_add
[    3.848259] device: 'ptys4': device_add
[    3.852204] device: 'ptys5': device_add
[    3.856163] device: 'ptys6': device_add
[    3.860135] device: 'ptys7': device_add
[    3.864072] device: 'ptys8': device_add
[    3.868010] device: 'ptys9': device_add
[    3.871952] device: 'ptysa': device_add
[    3.875902] device: 'ptysb': device_add
[    3.879847] device: 'ptysc': device_add
[    3.883786] device: 'ptysd': device_add
[    3.887694] device: 'ptyse': device_add
[    3.891662] device: 'ptysf': device_add
[    3.895597] device: 'ptyt0': device_add
[    3.899535] device: 'ptyt1': device_add
[    3.903460] device: 'ptyt2': device_add
[    3.907400] device: 'ptyt3': device_add
[    3.911346] device: 'ptyt4': device_add
[    3.915279] device: 'ptyt5': device_add
[    3.919234] device: 'ptyt6': device_add
[    3.923180] device: 'ptyt7': device_add
[    3.927147] device: 'ptyt8': device_add
[    3.931082] device: 'ptyt9': device_add
[    3.935026] device: 'ptyta': device_add
[    3.938995] device: 'ptytb': device_add
[    3.942943] device: 'ptytc': device_add
[    3.946901] device: 'ptytd': device_add
[    3.950845] device: 'ptyte': device_add
[    3.954804] device: 'ptytf': device_add
[    3.958735] device: 'ptyu0': device_add
[    3.962688] device: 'ptyu1': device_add
[    3.966649] device: 'ptyu2': device_add
[    3.970599] device: 'ptyu3': device_add
[    3.974555] device: 'ptyu4': device_add
[    3.978499] device: 'ptyu5': device_add
[    3.982443] device: 'ptyu6': device_add
[    3.986400] device: 'ptyu7': device_add
[    3.990349] device: 'ptyu8': device_add
[    3.994303] device: 'ptyu9': device_add
[    3.998233] device: 'ptyua': device_add
[    4.002192] device: 'ptyub': device_add
[    4.006142] device: 'ptyuc': device_add
[    4.010090] device: 'ptyud': device_add
[    4.014015] device: 'ptyue': device_add
[    4.017962] device: 'ptyuf': device_add
[    4.021906] device: 'ptyv0': device_add
[    4.025858] device: 'ptyv1': device_add
[    4.029803] device: 'ptyv2': device_add
[    4.033787] device: 'ptyv3': device_add
[    4.037727] device: 'ptyv4': device_add
[    4.041662] device: 'ptyv5': device_add
[    4.045613] device: 'ptyv6': device_add
[    4.049571] device: 'ptyv7': device_add
[    4.053526] device: 'ptyv8': device_add
[    4.057476] device: 'ptyv9': device_add
[    4.061442] device: 'ptyva': device_add
[    4.065389] device: 'ptyvb': device_add
[    4.069355] device: 'ptyvc': device_add
[    4.073298] device: 'ptyvd': device_add
[    4.077242] device: 'ptyve': device_add
[    4.081191] device: 'ptyvf': device_add
[    4.085119] device: 'ptyw0': device_add
[    4.089070] device: 'ptyw1': device_add
[    4.092998] device: 'ptyw2': device_add
[    4.096949] device: 'ptyw3': device_add
[    4.100895] device: 'ptyw4': device_add
[    4.104839] device: 'ptyw5': device_add
[    4.108796] device: 'ptyw6': device_add
[    4.112733] device: 'ptyw7': device_add
[    4.116668] device: 'ptyw8': device_add
[    4.120628] device: 'ptyw9': device_add
[    4.124595] device: 'ptywa': device_add
[    4.128545] device: 'ptywb': device_add
[    4.132509] device: 'ptywc': device_add
[    4.136443] device: 'ptywd': device_add
[    4.140389] device: 'ptywe': device_add
[    4.144339] device: 'ptywf': device_add
[    4.148275] device: 'ptyx0': device_add
[    4.152190] device: 'ptyx1': device_add
[    4.156137] device: 'ptyx2': device_add
[    4.160067] device: 'ptyx3': device_add
[    4.164021] device: 'ptyx4': device_add
[    4.167974] device: 'ptyx5': device_add
[    4.171922] device: 'ptyx6': device_add
[    4.175872] device: 'ptyx7': device_add
[    4.179799] device: 'ptyx8': device_add
[    4.183734] device: 'ptyx9': device_add
[    4.187689] device: 'ptyxa': device_add
[    4.191647] device: 'ptyxb': device_add
[    4.195571] device: 'ptyxc': device_add
[    4.199544] device: 'ptyxd': device_add
[    4.203478] device: 'ptyxe': device_add
[    4.207429] device: 'ptyxf': device_add
[    4.211355] device: 'ptyy0': device_add
[    4.215318] device: 'ptyy1': device_add
[    4.219271] device: 'ptyy2': device_add
[    4.223214] device: 'ptyy3': device_add
[    4.227177] device: 'ptyy4': device_add
[    4.231143] device: 'ptyy5': device_add
[    4.235095] device: 'ptyy6': device_add
[    4.239049] device: 'ptyy7': device_add
[    4.243018] device: 'ptyy8': device_add
[    4.246968] device: 'ptyy9': device_add
[    4.250913] device: 'ptyya': device_add
[    4.254854] device: 'ptyyb': device_add
[    4.258815] device: 'ptyyc': device_add
[    4.262759] device: 'ptyyd': device_add
[    4.266696] device: 'ptyye': device_add
[    4.270640] device: 'ptyyf': device_add
[    4.274590] device: 'ptyz0': device_add
[    4.278527] device: 'ptyz1': device_add
[    4.282472] device: 'ptyz2': device_add
[    4.286447] device: 'ptyz3': device_add
[    4.290379] device: 'ptyz4': device_add
[    4.294315] device: 'ptyz5': device_add
[    4.298265] device: 'ptyz6': device_add
[    4.302194] device: 'ptyz7': device_add
[    4.306141] device: 'ptyz8': device_add
[    4.310113] device: 'ptyz9': device_add
[    4.314041] device: 'ptyza': device_add
[    4.317993] device: 'ptyzb': device_add
[    4.321939] device: 'ptyzc': device_add
[    4.325898] device: 'ptyzd': device_add
[    4.329876] device: 'ptyze': device_add
[    4.333819] device: 'ptyzf': device_add
[    4.337762] device: 'ptya0': device_add
[    4.341721] device: 'ptya1': device_add
[    4.345655] device: 'ptya2': device_add
[    4.349605] device: 'ptya3': device_add
[    4.353555] device: 'ptya4': device_add
[    4.357509] device: 'ptya5': device_add
[    4.361472] device: 'ptya6': device_add
[    4.365404] device: 'ptya7': device_add
[    4.369337] device: 'ptya8': device_add
[    4.373275] device: 'ptya9': device_add
[    4.377237] device: 'ptyaa': device_add
[    4.381172] device: 'ptyab': device_add
[    4.385136] device: 'ptyac': device_add
[    4.389063] device: 'ptyad': device_add
[    4.392997] device: 'ptyae': device_add
[    4.396939] device: 'ptyaf': device_add
[    4.400900] device: 'ptyb0': device_add
[    4.404833] device: 'ptyb1': device_add
[    4.408792] device: 'ptyb2': device_add
[    4.412751] device: 'ptyb3': device_add
[    4.416712] device: 'ptyb4': device_add
[    4.420639] device: 'ptyb5': device_add
[    4.424581] device: 'ptyb6': device_add
[    4.428561] device: 'ptyb7': device_add
[    4.432524] device: 'ptyb8': device_add
[    4.436465] device: 'ptyb9': device_add
[    4.440417] device: 'ptyba': device_add
[    4.444356] device: 'ptybb': device_add
[    4.448308] device: 'ptybc': device_add
[    4.452234] device: 'ptybd': device_add
[    4.456159] device: 'ptybe': device_add
[    4.460108] device: 'ptybf': device_add
[    4.464038] device: 'ptyc0': device_add
[    4.467973] device: 'ptyc1': device_add
[    4.471930] device: 'ptyc2': device_add
[    4.475885] device: 'ptyc3': device_add
[    4.479820] device: 'ptyc4': device_add
[    4.483784] device: 'ptyc5': device_add
[    4.487731] device: 'ptyc6': device_add
[    4.491673] device: 'ptyc7': device_add
[    4.495627] device: 'ptyc8': device_add
[    4.499583] device: 'ptyc9': device_add
[    4.503533] device: 'ptyca': device_add
[    4.507485] device: 'ptycb': device_add
[    4.511412] device: 'ptycc': device_add
[    4.515382] device: 'ptycd': device_add
[    4.519324] device: 'ptyce': device_add
[    4.523252] device: 'ptycf': device_add
[    4.527191] device: 'ptyd0': device_add
[    4.531126] device: 'ptyd1': device_add
[    4.535065] device: 'ptyd2': device_add
[    4.539031] device: 'ptyd3': device_add
[    4.542987] device: 'ptyd4': device_add
[    4.546944] device: 'ptyd5': device_add
[    4.550892] device: 'ptyd6': device_add
[    4.554849] device: 'ptyd7': device_add
[    4.558809] device: 'ptyd8': device_add
[    4.562757] device: 'ptyd9': device_add
[    4.566709] device: 'ptyda': device_add
[    4.570643] device: 'ptydb': device_add
[    4.574568] device: 'ptydc': device_add
[    4.578508] device: 'ptydd': device_add
[    4.582458] device: 'ptyde': device_add
[    4.586394] device: 'ptydf': device_add
[    4.590345] device: 'ptye0': device_add
[    4.594279] device: 'ptye1': device_add
[    4.598208] device: 'ptye2': device_add
[    4.602142] device: 'ptye3': device_add
[    4.606085] device: 'ptye4': device_add
[    4.610027] device: 'ptye5': device_add
[    4.613964] device: 'ptye6': device_add
[    4.617920] device: 'ptye7': device_add
[    4.621871] device: 'ptye8': device_add
[    4.625811] device: 'ptye9': device_add
[    4.629767] device: 'ptyea': device_add
[    4.633728] device: 'ptyeb': device_add
[    4.637667] device: 'ptyec': device_add
[    4.641619] device: 'ptyed': device_add
[    4.645572] device: 'ptyee': device_add
[    4.649509] device: 'ptyef': device_add
[    4.653449] device: 'ttyp0': device_add
[    4.657388] device: 'ttyp1': device_add
[    4.661322] device: 'ttyp2': device_add
[    4.665253] device: 'ttyp3': device_add
[    4.669218] device: 'ttyp4': device_add
[    4.673170] device: 'ttyp5': device_add
[    4.677115] device: 'ttyp6': device_add
[    4.681082] device: 'ttyp7': device_add
[    4.685022] device: 'ttyp8': device_add
[    4.688976] device: 'ttyp9': device_add
[    4.692915] device: 'ttypa': device_add
[    4.696850] device: 'ttypb': device_add
[    4.700809] device: 'ttypc': device_add
[    4.704771] device: 'ttypd': device_add
[    4.708714] device: 'ttype': device_add
[    4.712662] device: 'ttypf': device_add
[    4.716633] device: 'ttyq0': device_add
[    4.720567] device: 'ttyq1': device_add
[    4.724504] device: 'ttyq2': device_add
[    4.728451] device: 'ttyq3': device_add
[    4.732403] device: 'ttyq4': device_add
[    4.736348] device: 'ttyq5': device_add
[    4.740291] device: 'ttyq6': device_add
[    4.744259] device: 'ttyq7': device_add
[    4.748204] device: 'ttyq8': device_add
[    4.752141] device: 'ttyq9': device_add
[    4.756094] device: 'ttyqa': device_add
[    4.760045] device: 'ttyqb': device_add
[    4.763989] device: 'ttyqc': device_add
[    4.767932] device: 'ttyqd': device_add
[    4.771874] device: 'ttyqe': device_add
[    4.775824] device: 'ttyqf': device_add
[    4.779770] device: 'ttyr0': device_add
[    4.783722] device: 'ttyr1': device_add
[    4.787674] device: 'ttyr2': device_add
[    4.791651] device: 'ttyr3': device_add
[    4.795606] device: 'ttyr4': device_add
[    4.799552] device: 'ttyr5': device_add
[    4.803504] device: 'ttyr6': device_add
[    4.807457] device: 'ttyr7': device_add
[    4.811412] device: 'ttyr8': device_add
[    4.815360] device: 'ttyr9': device_add
[    4.819290] device: 'ttyra': device_add
[    4.823231] device: 'ttyrb': device_add
[    4.827173] device: 'ttyrc': device_add
[    4.831106] device: 'ttyrd': device_add
[    4.835046] device: 'ttyre': device_add
[    4.838974] device: 'ttyrf': device_add
[    4.842916] device: 'ttys0': device_add
[    4.846852] device: 'ttys1': device_add
[    4.850792] device: 'ttys2': device_add
[    4.854756] device: 'ttys3': device_add
[    4.858717] device: 'ttys4': device_add
[    4.862670] device: 'ttys5': device_add
[    4.866612] device: 'ttys6': device_add
[    4.870587] device: 'ttys7': device_add
[    4.874522] device: 'ttys8': device_add
[    4.878458] device: 'ttys9': device_add
[    4.882426] device: 'ttysa': device_add
[    4.886369] device: 'ttysb': device_add
[    4.890338] device: 'ttysc': device_add
[    4.894289] device: 'ttysd': device_add
[    4.898238] device: 'ttyse': device_add
[    4.902193] device: 'ttysf': device_add
[    4.906135] device: 'ttyt0': device_add
[    4.910072] device: 'ttyt1': device_add
[    4.914011] device: 'ttyt2': device_add
[    4.917947] device: 'ttyt3': device_add
[    4.921891] device: 'ttyt4': device_add
[    4.925857] device: 'ttyt5': device_add
[    4.929803] device: 'ttyt6': device_add
[    4.933781] device: 'ttyt7': device_add
[    4.937720] device: 'ttyt8': device_add
[    4.941664] device: 'ttyt9': device_add
[    4.945633] device: 'ttyta': device_add
[    4.949584] device: 'ttytb': device_add
[    4.953542] device: 'ttytc': device_add
[    4.957491] device: 'ttytd': device_add
[    4.961416] device: 'ttyte': device_add
[    4.965351] device: 'ttytf': device_add
[    4.969278] device: 'ttyu0': device_add
[    4.973211] device: 'ttyu1': device_add
[    4.977183] device: 'ttyu2': device_add
[    4.981147] device: 'ttyu3': device_add
[    4.985083] device: 'ttyu4': device_add
[    4.989069] device: 'ttyu5': device_add
[    4.993004] device: 'ttyu6': device_add
[    4.996947] device: 'ttyu7': device_add
[    5.000915] device: 'ttyu8': device_add
[    5.004864] device: 'ttyu9': device_add
[    5.008809] device: 'ttyua': device_add
[    5.012787] device: 'ttyub': device_add
[    5.016741] device: 'ttyuc': device_add
[    5.020678] device: 'ttyud': device_add
[    5.024620] device: 'ttyue': device_add
[    5.028582] device: 'ttyuf': device_add
[    5.032538] device: 'ttyv0': device_add
[    5.036484] device: 'ttyv1': device_add
[    5.040424] device: 'ttyv2': device_add
[    5.044378] device: 'ttyv3': device_add
[    5.048338] device: 'ttyv4': device_add
[    5.052285] device: 'ttyv5': device_add
[    5.056236] device: 'ttyv6': device_add
[    5.060177] device: 'ttyv7': device_add
[    5.064125] device: 'ttyv8': device_add
[    5.068097] device: 'ttyv9': device_add
[    5.072028] device: 'ttyva': device_add
[    5.075978] device: 'ttyvb': device_add
[    5.079944] device: 'ttyvc': device_add
[    5.083881] device: 'ttyvd': device_add
[    5.087833] device: 'ttyve': device_add
[    5.091776] device: 'ttyvf': device_add
[    5.095722] device: 'ttyw0': device_add
[    5.099672] device: 'ttyw1': device_add
[    5.103618] device: 'ttyw2': device_add
[    5.107568] device: 'ttyw3': device_add
[    5.111495] device: 'ttyw4': device_add
[    5.115441] device: 'ttyw5': device_add
[    5.119380] device: 'ttyw6': device_add
[    5.123368] device: 'ttyw7': device_add
[    5.127314] device: 'ttyw8': device_add
[    5.131258] device: 'ttyw9': device_add
[    5.135208] device: 'ttywa': device_add
[    5.139177] device: 'ttywb': device_add
[    5.143159] device: 'ttywc': device_add
[    5.147113] device: 'ttywd': device_add
[    5.151059] device: 'ttywe': device_add
[    5.155032] device: 'ttywf': device_add
[    5.158957] device: 'ttyx0': device_add
[    5.162901] device: 'ttyx1': device_add
[    5.166870] device: 'ttyx2': device_add
[    5.170811] device: 'ttyx3': device_add
[    5.174752] device: 'ttyx4': device_add
[    5.178712] device: 'ttyx5': device_add
[    5.182646] device: 'ttyx6': device_add
[    5.186615] device: 'ttyx7': device_add
[    5.190556] device: 'ttyx8': device_add
[    5.194491] device: 'ttyx9': device_add
[    5.198418] device: 'ttyxa': device_add
[    5.202377] device: 'ttyxb': device_add
[    5.206303] device: 'ttyxc': device_add
[    5.210258] device: 'ttyxd': device_add
[    5.214210] device: 'ttyxe': device_add
[    5.218154] device: 'ttyxf': device_add
[    5.222094] device: 'ttyy0': device_add
[    5.226041] device: 'ttyy1': device_add
[    5.229985] device: 'ttyy2': device_add
[    5.233920] device: 'ttyy3': device_add
[    5.237883] device: 'ttyy4': device_add
[    5.241820] device: 'ttyy5': device_add
[    5.245767] device: 'ttyy6': device_add
[    5.249703] device: 'ttyy7': device_add
[    5.253672] device: 'ttyy8': device_add
[    5.257606] device: 'ttyy9': device_add
[    5.261556] device: 'ttyya': device_add
[    5.265496] device: 'ttyyb': device_add
[    5.269421] device: 'ttyyc': device_add
[    5.273357] device: 'ttyyd': device_add
[    5.277313] device: 'ttyye': device_add
[    5.281273] device: 'ttyyf': device_add
[    5.285209] device: 'ttyz0': device_add
[    5.289177] device: 'ttyz1': device_add
[    5.293118] device: 'ttyz2': device_add
[    5.297071] device: 'ttyz3': device_add
[    5.301035] device: 'ttyz4': device_add
[    5.304968] device: 'ttyz5': device_add
[    5.308938] device: 'ttyz6': device_add
[    5.312877] device: 'ttyz7': device_add
[    5.316807] device: 'ttyz8': device_add
[    5.320767] device: 'ttyz9': device_add
[    5.324715] device: 'ttyza': device_add
[    5.328648] device: 'ttyzb': device_add
[    5.332593] device: 'ttyzc': device_add
[    5.336559] device: 'ttyzd': device_add
[    5.340508] device: 'ttyze': device_add
[    5.344460] device: 'ttyzf': device_add
[    5.348397] device: 'ttya0': device_add
[    5.352361] device: 'ttya1': device_add
[    5.356289] device: 'ttya2': device_add
[    5.360226] device: 'ttya3': device_add
[    5.364181] device: 'ttya4': device_add
[    5.368122] device: 'ttya5': device_add
[    5.372055] device: 'ttya6': device_add
[    5.375994] device: 'ttya7': device_add
[    5.379934] device: 'ttya8': device_add
[    5.383862] device: 'ttya9': device_add
[    5.387825] device: 'ttyaa': device_add
[    5.391770] device: 'ttyab': device_add
[    5.395691] device: 'ttyac': device_add
[    5.399624] device: 'ttyad': device_add
[    5.403557] device: 'ttyae': device_add
[    5.407528] device: 'ttyaf': device_add
[    5.411479] device: 'ttyb0': device_add
[    5.415433] device: 'ttyb1': device_add
[    5.419376] device: 'ttyb2': device_add
[    5.423338] device: 'ttyb3': device_add
[    5.427272] device: 'ttyb4': device_add
[    5.431235] device: 'ttyb5': device_add
[    5.435164] device: 'ttyb6': device_add
[    5.439112] device: 'ttyb7': device_add
[    5.443070] device: 'ttyb8': device_add
[    5.447003] device: 'ttyb9': device_add
[    5.450958] device: 'ttyba': device_add
[    5.454917] device: 'ttybb': device_add
[    5.458849] device: 'ttybc': device_add
[    5.462812] device: 'ttybd': device_add
[    5.466797] device: 'ttybe': device_add
[    5.470772] device: 'ttybf': device_add
[    5.474736] device: 'ttyc0': device_add
[    5.478669] device: 'ttyc1': device_add
[    5.482610] device: 'ttyc2': device_add
[    5.486582] device: 'ttyc3': device_add
[    5.490544] device: 'ttyc4': device_add
[    5.494531] device: 'ttyc5': device_add
[    5.498478] device: 'ttyc6': device_add
[    5.502414] device: 'ttyc7': device_add
[    5.506395] device: 'ttyc8': device_add
[    5.510353] device: 'ttyc9': device_add
[    5.514276] device: 'ttyca': device_add
[    5.518243] device: 'ttycb': device_add
[    5.522186] device: 'ttycc': device_add
[    5.526144] device: 'ttycd': device_add
[    5.530090] device: 'ttyce': device_add
[    5.534039] device: 'ttycf': device_add
[    5.537997] device: 'ttyd0': device_add
[    5.541938] device: 'ttyd1': device_add
[    5.545884] device: 'ttyd2': device_add
[    5.549840] device: 'ttyd3': device_add
[    5.553800] device: 'ttyd4': device_add
[    5.557743] device: 'ttyd5': device_add
[    5.561712] device: 'ttyd6': device_add
[    5.565660] device: 'ttyd7': device_add
[    5.569604] device: 'ttyd8': device_add
[    5.573600] device: 'ttyd9': device_add
[    5.577562] device: 'ttyda': device_add
[    5.581547] device: 'ttydb': device_add
[    5.585505] device: 'ttydc': device_add
[    5.589465] device: 'ttydd': device_add
[    5.593419] device: 'ttyde': device_add
[    5.597372] device: 'ttydf': device_add
[    5.601311] device: 'ttye0': device_add
[    5.605279] device: 'ttye1': device_add
[    5.609259] device: 'ttye2': device_add
[    5.613199] device: 'ttye3': device_add
[    5.617211] device: 'ttye4': device_add
[    5.621153] device: 'ttye5': device_add
[    5.625099] device: 'ttye6': device_add
[    5.629045] device: 'ttye7': device_add
[    5.632989] device: 'ttye8': device_add
[    5.636939] device: 'ttye9': device_add
[    5.640894] device: 'ttyea': device_add
[    5.644851] device: 'ttyeb': device_add
[    5.648779] device: 'ttyec': device_add
[    5.652724] device: 'ttyed': device_add
[    5.656657] device: 'ttyee': device_add
[    5.660609] device: 'ttyef': device_add
[    5.664553] device: 'ptmx': device_add
[    5.668457] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    5.674981] device: 'serial8250': device_add
[    5.679377] device: 'ttyS0': device_add
[    5.683422] device: 'ttyS1': device_add
[    5.687396] device: 'ttyS2': device_add
[    5.691400] device: 'ttyS3': device_add
[    5.695929] platform 840c000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    5.703851] platform 840d000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    5.711737] platform 840e000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    5.719789] platform 840c000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    5.727676] platform 840d000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    5.735536] platform 840e000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    5.743685] device: 'hw_random': device_add
[    5.748211] iproc-rng200 8402000.rng: hwrng registered
[    5.753969] device: '1:0': device_add
[    5.757799] device: 'ram0': device_add
[    5.761939] device: '1:1': device_add
[    5.765724] device: 'ram1': device_add
[    5.769767] device: '1:2': device_add
[    5.773566] device: 'ram2': device_add
[    5.777569] device: '1:3': device_add
[    5.781334] device: 'ram3': device_add
[    5.785340] device: '1:4': device_add
[    5.789099] device: 'ram4': device_add
[    5.793117] device: '1:5': device_add
[    5.796893] device: 'ram5': device_add
[    5.800888] device: '1:6': device_add
[    5.804674] device: 'ram6': device_add
[    5.808693] device: '1:7': device_add
[    5.812474] device: 'ram7': device_add
[    5.816504] device: '1:8': device_add
[    5.820256] device: 'ram8': device_add
[    5.824259] device: '1:9': device_add
[    5.828039] device: 'ram9': device_add
[    5.832072] device: '1:10': device_add
[    5.835929] device: 'ram10': device_add
[    5.840031] device: '1:11': device_add
[    5.843929] device: 'ram11': device_add
[    5.848033] device: '1:12': device_add
[    5.851908] device: 'ram12': device_add
[    5.856015] device: '1:13': device_add
[    5.859889] device: 'ram13': device_add
[    5.863998] device: '1:14': device_add
[    5.867855] device: 'ram14': device_add
[    5.871974] device: '1:15': device_add
[    5.875841] device: 'ram15': device_add
[    5.879976] brd: module loaded
[    5.883101] device: 'loop-control': device_add
[    5.887960] device: '7:0': device_add
[    5.891760] device: 'loop0': device_add
[    5.896215] device: '7:1': device_add
[    5.900005] device: 'loop1': device_add
[    5.904458] device: '7:2': device_add
[    5.908227] device: 'loop2': device_add
[    5.912686] device: '7:3': device_add
[    5.916467] device: 'loop3': device_add
[    5.920970] device: '7:4': device_add
[    5.924767] device: 'loop4': device_add
[    5.929216] device: '7:5': device_add
[    5.933017] device: 'loop5': device_add
[    5.937483] device: '7:6': device_add
[    5.941271] device: 'loop6': device_add
[    5.945724] device: '7:7': device_add
[    5.949513] device: 'loop7': device_add
[    5.953718] loop: module loaded
[    5.957414] platform 8b0a000.sata: probe deferral - supplier brcm_scmi@0 not ready
[    5.965310] device: 'mtd-0': device_add
[    5.970044] platform 84b2120.qspi: probe deferral - supplier brcm_scmi@0 not ready
[    5.977854] brcmstb_qspi 8418000.mspi: using mspi mode
[    5.983168] device: 'spi0': device_add
[    5.988043] device: 'Fixed MDIO bus.0': device_add
[    5.993124] device: 'fixed-0': device_add
[    5.997362] libphy: Fixed MDIO Bus: probed
[    6.002042] platform 8f00000.ethernet: probe deferral - supplier brcm_scmi@0 not ready
[    6.010377] e1000e: Intel(R) PRO/1000 Network Driver
[    6.015435] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    6.021476] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    6.029039] usbcore: registered new interface driver pegasus
[    6.034804] usbcore: registered new interface driver r8152
[    6.040405] usbcore: registered new interface driver asix
[    6.045918] usbcore: registered new interface driver ax88179_178a
[    6.052155] usbcore: registered new interface driver cdc_ether
[    6.058146] usbcore: registered new interface driver cdc_ncm
[    6.063989] device: 'usbmon0': device_add
[    6.068148] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.074791] ehci-pci: EHCI PCI platform driver
[    6.079354] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.085630] ohci-pci: OHCI PCI platform driver
[    6.090220] usbcore: registered new interface driver cdc_acm
[    6.095991] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    6.104131] usbcore: registered new interface driver usb-storage
[    6.110544] device: 'uinput': device_add
[    6.114617] i2c /dev entries driver
[    6.118853] brcmstb_thermal a581500.thermal: registered AVS TMON of-sensor driver
[    6.126867] device: 'watchdog': device_add
[    6.131143] device: 'watchdog0': device_add
[    6.135483] bcm7038-wdt 840a628.watchdog: Registered BCM7038 Watchdog
[    6.142519] sdhci: Secure Digital Host Controller Interface driver
[    6.148844] sdhci: Copyright(c) Pierre Ossman
[    6.153291] sdhci-pltfm: SDHCI platform and OF driver helper
[    6.159169] platform 84b0000.sdhci: probe deferral - supplier brcm_scmi@0 not ready
[    6.159415] hid: raw HID events driver (C) Jiri Kosina
[    6.172246] device: 'uhid': device_add
[    6.176268] usbcore: registered new interface driver usbhid
[    6.181993] usbhid: USB HID core driver
[    6.599764] brcmstb-dpfe 9932000.dpfe-cpu: registered with API v3.
[    6.606251] device: 'timer': device_add
[    6.610336] device: 'snd-soc-dummy': device_add
[    6.615681] NET: Registered protocol family 10
[    6.620674] Segment Routing with IPv6
[    6.624441] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    6.630479] device: 'sit0': device_add
[    6.634623] NET: Registered protocol family 17
[    6.639197] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you ne
ed this.
[    6.652522] 8021q: 802.1Q VLAN Support v1.8
[    6.656809] Key type dns_resolver registered
[    6.661246] Registering SWP/SWPB emulation handler
[    6.666163] device: 'cpu_dma_latency': device_add
[    6.671063] Loading compiled-in X.509 certificates
[    6.678526] devices_kset: Moving brcm_scmi@0 to end of list
[    6.684262] devices_kset: Moving 840c000.serial to end of list
[    6.690186] devices_kset: Moving 840d000.serial to end of list
[    6.696153] devices_kset: Moving 840e000.serial to end of list
[    6.702102] devices_kset: Moving 8d0f200.usb-phy to end of list
[    6.708111] devices_kset: Moving 8d00000.xhci_v2 to end of list
[    6.714129] devices_kset: Moving 8d00000.xhci_v2 to end of list
[    6.720155] devices_kset: Moving 8f00000.ethernet to end of list
[    6.726252] devices_kset: Moving 8b0a000.sata to end of list
[    6.732018] devices_kset: Moving 84b0000.sdhci to end of list
[    6.737888] devices_kset: Moving 84b2120.qspi to end of list
[    6.743637] devices_kset: Moving 8b20000.pcie to end of list
[    6.749451] platform brcm_scmi@0: probe deferral - supplier brcm_scmi_mailbox@0 not ready
[    6.757750] devices_kset: Moving 8b20000.pcie to end of list
[    6.763541] platform 8b20000.pcie: probe deferral - supplier brcm_scmi@0 not ready
[    6.771258] devices_kset: Moving 840c000.serial to end of list
[    6.777231] platform 840c000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    6.785157] devices_kset: Moving 840d000.serial to end of list
[    6.791114] platform 840d000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    6.799016] devices_kset: Moving 840e000.serial to end of list
[    6.804973] platform 840e000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    6.812846] devices_kset: Moving 8b0a000.sata to end of list
[    6.818674] platform 8b0a000.sata: probe deferral - supplier brcm_scmi@0 not ready
[    6.826399] devices_kset: Moving 84b2120.qspi to end of list
[    6.832209] platform 84b2120.qspi: probe deferral - supplier brcm_scmi@0 not ready
[    6.839891] devices_kset: Moving 8f00000.ethernet to end of list
[    6.846066] platform 8f00000.ethernet: probe deferral - supplier brcm_scmi@0 not ready
[    6.854131] devices_kset: Moving 84b0000.sdhci to end of list
[    6.860167] platform 84b0000.sdhci: probe deferral - supplier brcm_scmi@0 not ready
[    6.860776] devices_kset: Moving brcm_scmi@0 to end of list
[    6.873679] devices_kset: Moving 840c000.serial to end of list
[    6.879584] devices_kset: Moving 840d000.serial to end of list
[    6.885551] devices_kset: Moving 840e000.serial to end of list
[    6.891491] devices_kset: Moving 8d0f200.usb-phy to end of list
[    6.897526] devices_kset: Moving 8d00000.xhci_v2 to end of list
[    6.903579] devices_kset: Moving 8d00000.xhci_v2 to end of list
[    6.909657] devices_kset: Moving 8f00000.ethernet to end of list
[    6.915797] devices_kset: Moving 8b0a000.sata to end of list
[    6.921580] devices_kset: Moving 84b0000.sdhci to end of list
[    6.927461] devices_kset: Moving 84b2120.qspi to end of list
[    6.933236] devices_kset: Moving 8b20000.pcie to end of list
[    6.939028] platform brcm_scmi@0: probe deferral - supplier brcm_scmi_mailbox@0 not ready
[    6.947346] devices_kset: Moving 8b20000.pcie to end of list
[    6.953117] platform 8b20000.pcie: probe deferral - supplier brcm_scmi@0 not ready
[    6.960869] devices_kset: Moving 840c000.serial to end of list
[    6.966877] platform 840c000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    6.974751] devices_kset: Moving 840d000.serial to end of list
[    6.980754] platform 840d000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    6.988645] devices_kset: Moving 840e000.serial to end of list
[    6.994627] platform 840e000.serial: probe deferral - supplier brcm_scmi@0 not ready
[    7.002535] devices_kset: Moving 8b0a000.sata to end of list
[    7.008306] platform 8b0a000.sata: probe deferral - supplier brcm_scmi@0 not ready
[    7.016040] devices_kset: Moving 84b2120.qspi to end of list
[    7.021854] platform 84b2120.qspi: probe deferral - supplier brcm_scmi@0 not ready
[    7.029536] devices_kset: Moving 8f00000.ethernet to end of list
[    7.035698] platform 8f00000.ethernet: probe deferral - supplier brcm_scmi@0 not ready
[    7.043728] devices_kset: Moving 84b0000.sdhci to end of list
[    7.049741] device: 'ubi_ctrl': device_add
[    7.049773] platform 84b0000.sdhci: probe deferral - supplier brcm_scmi@0 not ready
[    7.054352] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    7.076406] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    7.083122] ALSA device list:
[    7.086142]   No soundcards found.
[    7.089708] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    7.098506] cfg80211: failed to load regulatory.db
[    7.115369] Freeing unused kernel memory: 14336K
[    7.129918] Run /init as init process
[    7.133673]   with arguments:
[    7.136688]     /init
[    7.139004]   with environment:
[    7.142204]     HOME=/
[    7.144622]     TERM=linux
[    7.147370]     dyndbg=file drivers/base/core.c +p
[    7.256086] random: crng init done














--------------295375603EEC5FD178306FC5
Content-Type: audio/vnd.dts;
 name="BCX972160DV.dts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="BCX972160DV.dts"

L2R0cy12MS87CgovIHsKCXNlcmlhbC1udW1iZXIgPSAiRU0wMDA2NjY5IjsKCW1vZGVsID0g
IkJDWDk3MjE2MERWIjsKCWNvbXBhdGlibGUgPSAiQkNYOTcyMTYwRFZcMGJyY20sYmNtNzIx
NmIwXDBicmNtLGJyY21zdGIiOwoJI2FkZHJlc3MtY2VsbHMgPSA8MHgwMj47Cgkjc2l6ZS1j
ZWxscyA9IDwweDAyPjsKCWludGVycnVwdC1wYXJlbnQgPSA8MHgwMT47CgoJbWVtb3J5IHsK
CQkjYWRkcmVzcy1jZWxscyA9IDwweDAxPjsKCQkjc2l6ZS1jZWxscyA9IDwweDAxPjsKCQlk
ZXZpY2VfdHlwZSA9ICJtZW1vcnkiOwoJCXJlZyA9IDwweDAwIDB4NDAwMDAwMDAgMHgwMSAw
eDAwPjsKCX07CgoJY3B1cyB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8MHgwMT47CgkJI3NpemUt
Y2VsbHMgPSA8MHgwMD47CgoJCWNwdUAwIHsKCQkJb3BlcmF0aW5nLXBvaW50cyA9IDwweDI3
ZjY3OCAweDAwIDB4MWFhNDUwIDB4MDAgMHgxM2ZiM2MgMHgwMD47CgkJCWNsb2NrLWZyZXF1
ZW5jeSA9IDwweDljMWFjNGMwPjsKCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKCQkJZW5hYmxl
LW1ldGhvZCA9ICJwc2NpIjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyYWhtYS1iNTNcMGFy
bSxjb3J0ZXgtYTUzIjsKCQkJcmVnID0gPDB4MDA+OwoJCQluZXh0LWxldmVsLWNhY2hlID0g
PDB4MDI+OwoJCQljbG9ja3MgPSA8MHgwMyAweDAwPjsKCQkJY2xvY2stbmFtZXMgPSAiY3B1
IjsKCQl9OwoKCQljcHVAMSB7CgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwweDljMWFjNGMwPjsK
CQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsKCQkJ
Y29tcGF0aWJsZSA9ICJicmNtLGJyYWhtYS1iNTNcMGFybSxjb3J0ZXgtYTUzIjsKCQkJcmVn
ID0gPDB4MDE+OwoJCQluZXh0LWxldmVsLWNhY2hlID0gPDB4MDI+OwoJCQljbG9ja3MgPSA8
MHgwMyAweDAwPjsKCQkJY2xvY2stbmFtZXMgPSAiY3B1IjsKCQl9OwoKCQljcHVAMiB7CgkJ
CWNsb2NrLWZyZXF1ZW5jeSA9IDwweDljMWFjNGMwPjsKCQkJZGV2aWNlX3R5cGUgPSAiY3B1
IjsKCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJy
YWhtYS1iNTNcMGFybSxjb3J0ZXgtYTUzIjsKCQkJcmVnID0gPDB4MDI+OwoJCQluZXh0LWxl
dmVsLWNhY2hlID0gPDB4MDI+OwoJCQljbG9ja3MgPSA8MHgwMyAweDAwPjsKCQkJY2xvY2st
bmFtZXMgPSAiY3B1IjsKCQl9OwoKCQljcHVAMyB7CgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDww
eDljMWFjNGMwPjsKCQkJZGV2aWNlX3R5cGUgPSAiY3B1IjsKCQkJZW5hYmxlLW1ldGhvZCA9
ICJwc2NpIjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyYWhtYS1iNTNcMGFybSxjb3J0ZXgt
YTUzIjsKCQkJcmVnID0gPDB4MDM+OwoJCQluZXh0LWxldmVsLWNhY2hlID0gPDB4MDI+OwoJ
CQljbG9ja3MgPSA8MHgwMyAweDAwPjsKCQkJY2xvY2stbmFtZXMgPSAiY3B1IjsKCQl9OwoK
CQljYWNoZSB7CgkJCWNvbXBhdGlibGUgPSAiY2FjaGUiOwoJCQlsaW51eCxwaGFuZGxlID0g
PDB4MDI+OwoJCQlwaGFuZGxlID0gPDB4MDI+OwoJCX07Cgl9OwoKCXBzY2kgewoJCWNvbXBh
dGlibGUgPSAiYXJtLHBzY2ktMC4yXDBhcm0scHNjaSI7CgkJbWV0aG9kID0gInNtYyI7CgkJ
Y3B1X3N1c3BlbmQgPSA8MHhjNDAwMDAwMT47CgkJY3B1X29mZiA9IDwweDg0MDAwMDAyPjsK
CQljcHVfb24gPSA8MHhjNDAwMDAwMz47Cgl9OwoKCXRpbWVyIHsKCQljb21wYXRpYmxlID0g
ImFybSxhcm12OC10aW1lciI7CgkJaW50ZXJydXB0cyA9IDwweDAxIDB4MGQgMHhmZjA4IDB4
MDEgMHgwZSAweGZmMDggMHgwMSAweDBiIDB4ZmYwOCAweDAxIDB4MGEgMHhmZjA4PjsKCQlj
bG9jay1mcmVxdWVuY3kgPSA8MHgxOWJmY2MwPjsKCQlhbHdheXMtb247Cgl9OwoKCWJyY21f
Ym9ndXNfY2xrIHsKCQkjY2xvY2stY2VsbHMgPSA8MHgwMT47CgkJY29tcGF0aWJsZSA9ICJm
aXhlZC1jbG9jayI7CgkJY2xvY2stZnJlcXVlbmN5ID0gPDB4YmM2MTRlPjsKCQlsaW51eCxw
aGFuZGxlID0gPDB4MDM+OwoJCXBoYW5kbGUgPSA8MHgwMz47Cgl9OwoKCXJlc2VydmVkLW1l
bW9yeSB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8MHgwMj47CgkJI3NpemUtY2VsbHMgPSA8MHgw
Mj47CgkJcmFuZ2VzOwoKCQlTU0JNQDQ3MDQwMDAwIHsKCQkJcmVzZXJ2ZWQtbmFtZXMgPSAi
U1NCTSI7CgkJCXJlZyA9IDwweDAwIDB4NDcwNDAwMDAgMHgwMCAweDEwMDAwPjsKCQl9OwoK
CQlCRldANDcwMDAwMDAgewoJCQlyZXNlcnZlZC1uYW1lcyA9ICJCRlciOwoJCQlyZWcgPSA8
MHgwMCAweDQ3MDAwMDAwIDB4MDAgMHg0MDAwMD47CgkJfTsKCgkJU1JSQGZlMDAwMDAwIHsK
CQkJcmVzZXJ2ZWQtbmFtZXMgPSAiU1JSIjsKCQkJbm8tbWFwOwoJCQlyZWcgPSA8MHgwMCAw
eGZlMDAwMDAwIDB4MDAgMHgyMDAwMDAwPjsKCQl9OwoKCQlOV01CT1ggewoJCQlsaW51eCxw
aGFuZGxlID0gPDB4MDU+OwoJCQlwaGFuZGxlID0gPDB4MDU+OwoJCX07Cgl9OwoKCWJyY21f
c2NtaV9tYWlsYm94QDAgewoJCSNtYm94LWNlbGxzID0gPDB4MDE+OwoJCWNvbXBhdGlibGUg
PSAiYnJjbSxicmNtc3RiLW1ib3giOwoJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CgkJbGludXgs
cGhhbmRsZSA9IDwweDA0PjsKCQlwaGFuZGxlID0gPDB4MDQ+OwoJfTsKCglicmNtX3NjbWlA
MCB7CgkJY29tcGF0aWJsZSA9ICJhcm0sc2NtaS1zbWNcMGFybSxzY21pIjsKCQltYm94ZXMg
PSA8MHgwNCAweDAwIDB4MDQgMHgwMT47CgkJbWJveC1uYW1lcyA9ICJ0eFwwcngiOwoJCXNo
bWVtID0gPDB4MDU+OwoJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CgkJYXJtLHNtYy1pZCA9IDww
eDgzMDAwNDAwPjsKCQlpbnRlcnJ1cHQtbmFtZXMgPSAiYTJwIjsKCQkjYWRkcmVzcy1jZWxs
cyA9IDwweDAxPjsKCQkjc2l6ZS1jZWxscyA9IDwweDAwPjsKCgkJcHJvdG9jb2xAMTMgewoJ
CQlyZWcgPSA8MHgxMz47CgkJfTsKCgkJcHJvdG9jb2xAMTQgewoJCQlyZWcgPSA8MHgxND47
CgkJCSNjbG9jay1jZWxscyA9IDwweDAxPjsKCQkJbGludXgscGhhbmRsZSA9IDwweDA5PjsK
CQkJcGhhbmRsZSA9IDwweDA5PjsKCQl9OwoKCQlwcm90b2NvbEAxNSB7CgkJCXJlZyA9IDww
eDE1PjsKCQkJI3NlbnNvci1jZWxscyA9IDwweDAxPjsKCQkJI3RoZXJtYWwtc2Vuc29yLWNl
bGxzID0gPDB4MDE+OwoJCQlsaW51eCxwaGFuZGxlID0gPDB4MDY+OwoJCQlwaGFuZGxlID0g
PDB4MDY+OwoJCX07CgoJCXByb3RvY29sQDgwIHsKCQkJcmVnID0gPDB4ODA+OwoJCX07Cgl9
OwoKCWFsaWFzZXMgewoJCXNjbWlfY2xrID0gIi9icmNtX3NjbWlAMC9wcm90b2NvbEAxNCI7
CgkJcGNpZTAgPSAiL3BjaWVAOGIxMDAwMCI7CgkJcGNpZTEgPSAiL3BjaWVAOGIyMDAwMCI7
CgkJc2VyaWFsMCA9ICIvcmRiL3NlcmlhbEA4NDBjMDAwIjsKCQlzZXJpYWwxID0gIi9yZGIv
c2VyaWFsQDg0MGQwMDAiOwoJCXNlcmlhbDIgPSAiL3JkYi9zZXJpYWxAODQwZTAwMCI7CgkJ
dXNicGh5MCA9ICIvcmRiL3VzYi1waHlAOGQwZjIwMCI7CgkJeGhjaTBfMCA9ICIvcmRiL3ho
Y2lfdjJAOGQwMDAwMCI7CgkJYmRjMF8wID0gIi9yZGIvYmRjX3YyQDhkMGUwMDAiOwoJCWV0
aDAgPSAiL3JkYi9ldGhlcm5ldEA4ZjAwMDAwIjsKCQlldGgxID0gIi9yZGIvZXRoZXJuZXRA
OGYyMDAwMCI7CgkJdXBnX2dpbyA9ICIvcmRiL2dwaW9AODQwYTUwMCI7CgkJdXBnX2dpb19h
b24gPSAiL3JkYi9ncGlvQDg0MWE0MDAiOwoJCXNhdGFfcGh5MCA9ICIvcmRiL3NhdGFfcGh5
QDhiMDgxMDAiOwoJCXNhdGEwID0gIi9yZGIvc2F0YUA4YjBhMDAwIjsKCQltbWMwID0gIi9y
ZGIvc2RoY2lAODRiMDAwMCI7CgkJbW1jMSA9ICIvcmRiL3NkaGNpQDg0YjEwMDAiOwoJCXdh
dGNoZG9nMCA9ICIvcmRiL3dhdGNoZG9nQDg0MGE2MjgiOwoJCWJzcCA9ICIvcmRiL2JzcEA4
M2IwMDAwIjsKCQlncHUwID0gIi9yZGIvZ3B1QDk3MDAwMDAiOwoJCWdwdV9tbXUwID0gIi9y
ZGIvZ3B1LW1tdUA5NzA1MDAwIjsKCX07CgoJdGhlcm1hbC16b25lcyB7CgoJCXNjbWktdGhl
cm1hbCB7CgkJCXBvbGxpbmctZGVsYXkgPSA8MHgzZTg+OwoJCQlwb2xsaW5nLWRlbGF5LXBh
c3NpdmUgPSA8MHgzZTg+OwoJCQl0aGVybWFsLXNlbnNvcnMgPSA8MHgwNiAweDAwPjsKCQl9
OwoKCQljcHUtdGhlcm1hbCB7CgkJCXBvbGxpbmctZGVsYXkgPSA8MHgwMD47CgkJCXBvbGxp
bmctZGVsYXktcGFzc2l2ZSA9IDwweDAwPjsKCQkJdGhlcm1hbC1zZW5zb3JzID0gPDB4MDc+
OwoKCQkJdHJpcHMgewoKCQkJCWNwdS1hbGVydDAgewoJCQkJCXRlbXBlcmF0dXJlID0gPDB4
MTczMTg+OwoJCQkJCWh5c3RlcmVzaXMgPSA8MHgyNzEwPjsKCQkJCQl0eXBlID0gInBhc3Np
dmUiOwoJCQkJfTsKCgkJCQljcHUtYWxlcnQxIHsKCQkJCQl0ZW1wZXJhdHVyZSA9IDwweDFh
ZGIwPjsKCQkJCQloeXN0ZXJlc2lzID0gPDB4MjcxMD47CgkJCQkJdHlwZSA9ICJwYXNzaXZl
IjsKCQkJCX07CgoJCQkJY3B1LWFsZXJ0MiB7CgkJCQkJdGVtcGVyYXR1cmUgPSA8MHgxZTg0
OD47CgkJCQkJaHlzdGVyZXNpcyA9IDwweDI3MTA+OwoJCQkJCXR5cGUgPSAicGFzc2l2ZSI7
CgkJCQl9OwoJCQl9OwoJCX07Cgl9OwoKCWNob3NlbiB7CgkJc3Rkb3V0LXBhdGggPSAiL3Jk
Yi9zZXJpYWxAODQwYzAwMDoxMTUyMDAiOwoJfTsKCglyZGIgewoJCSNhZGRyZXNzLWNlbGxz
ID0gPDB4MDE+OwoJCSNzaXplLWNlbGxzID0gPDB4MDE+OwoJCWNvbXBhdGlibGUgPSAic2lt
cGxlLWJ1cyI7CgkJcmFuZ2VzID0gPDB4MDAgMHgwMCAweDAwIDB4ZmZmZmZmZmY+OwoKCQli
cmNtc3RiLWNsa3MgewoJCQkjYWRkcmVzcy1jZWxscyA9IDwweDAxPjsKCQkJI3NpemUtY2Vs
bHMgPSA8MHgwMT47CgkJCXJlZyA9IDwweDI2MjAwMDAgMHgyYTAgMHgyNTgxODAwIDB4Zjgg
MHg0MTAwMDAgMHg2MDA+OwoJCQlyYW5nZXM7CgoJCQlzd19zY2IgewoJCQl9OwoKCQkJY3B1
X25kaXZfaW50QDgxNjEwMTggewoJCQkJbGludXgscGhhbmRsZSA9IDwweDA4PjsKCQkJCXBo
YW5kbGUgPSA8MHgwOD47CgkJCX07CgoJCQljcHVfbWRpdl9jaDBAODE2MTAxMCB7CgkJCQlj
bG9ja3MgPSA8MHgwOD47CgkJCQljbG9jay1uYW1lcyA9ICJjcHVfbmRpdl9pbnQiOwoJCQl9
OwoKCQkJdXBnX2ZpeGVkIHsKCQkJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOwoJCQkJ
I2Nsb2NrLWNlbGxzID0gPDB4MDA+OwoJCQkJY2xvY2stZnJlcXVlbmN5ID0gPDB4MTliZmNj
MD47CgkJCQlsaW51eCxwaGFuZGxlID0gPDB4MTI+OwoJCQkJcGhhbmRsZSA9IDwweDEyPjsK
CQkJfTsKCQl9OwoKCQlzZXJpYWxAODQwYzAwMCB7CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxi
Y203MjE2LXVhcnRcMGJyY20sYmNtNzI3MS11YXJ0XDBuczE2NTUwYSI7CgkJCXJlZy1pby13
aWR0aCA9IDwweDA0PjsKCQkJcmVnLXNoaWZ0ID0gPDB4MDI+OwoJCQlyZWcgPSA8MHg4NDBj
MDAwIDB4MjA+OwoJCQlyZWctbmFtZXMgPSAidWFydCI7CgkJCWludGVycnVwdHMgPSA8MHgw
MCAweDYwIDB4MDQ+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAidWFydCI7CgkJCWZpZm8tc2l6
ZSA9IDwweDIwPjsKCQkJYXV0by1mbG93LWNvbnRyb2w7CgkJCWN1cnJlbnQtc3BlZWQgPSA8
MHgxYzIwMD47CgkJCWNsb2NrcyA9IDwweDA5IDB4Zjg+OwoJCQljbG9jay1uYW1lcyA9ICJz
d19iYXVkIjsKCQl9OwoKCQlzZXJpYWxAODQwZDAwMCB7CgkJCWNvbXBhdGlibGUgPSAiYnJj
bSxiY203MjE2LXVhcnRcMGJyY20sYmNtNzI3MS11YXJ0XDBuczE2NTUwYSI7CgkJCXJlZy1p
by13aWR0aCA9IDwweDA0PjsKCQkJcmVnLXNoaWZ0ID0gPDB4MDI+OwoJCQlyZWcgPSA8MHg4
NDBkMDAwIDB4MjA+OwoJCQlyZWctbmFtZXMgPSAidWFydCI7CgkJCWludGVycnVwdHMgPSA8
MHgwMCAweDYxIDB4MDQ+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAidWFydCI7CgkJCWZpZm8t
c2l6ZSA9IDwweDIwPjsKCQkJYXV0by1mbG93LWNvbnRyb2w7CgkJCWNsb2NrcyA9IDwweDA5
IDB4Zjk+OwoJCQljbG9jay1uYW1lcyA9ICJzd19iYXVkIjsKCQl9OwoKCQlzZXJpYWxAODQw
ZTAwMCB7CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxiY203MjE2LXVhcnRcMGJyY20sYmNtNzI3
MS11YXJ0XDBuczE2NTUwYSI7CgkJCXJlZy1pby13aWR0aCA9IDwweDA0PjsKCQkJcmVnLXNo
aWZ0ID0gPDB4MDI+OwoJCQlyZWcgPSA8MHg4NDBlMDAwIDB4MjA+OwoJCQlyZWctbmFtZXMg
PSAidWFydCI7CgkJCWludGVycnVwdHMgPSA8MHgwMCAweDYyIDB4MDQ+OwoJCQlpbnRlcnJ1
cHQtbmFtZXMgPSAidWFydCI7CgkJCWZpZm8tc2l6ZSA9IDwweDIwPjsKCQkJYXV0by1mbG93
LWNvbnRyb2w7CgkJCWNsb2NrcyA9IDwweDA5IDB4ZmE+OwoJCQljbG9jay1uYW1lcyA9ICJz
d19iYXVkIjsKCQl9OwoKCQlyZXNjYWxAMCB7CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxiY203
MjE2LXBjaWUtc2F0YS1yZXNjYWwiOwoJCQlyZWcgPSA8MHg4YjJjODAwIDB4MTA+OwoJCQkj
cmVzZXQtY2VsbHMgPSA8MHgwMD47CgkJCWxpbnV4LHBoYW5kbGUgPSA8MHgwZT47CgkJCXBo
YW5kbGUgPSA8MHgwZT47CgkJfTsKCgkJdXNiLXBoeUA4ZDBmMjAwIHsKCQkJcmVnID0gPDB4
OGQwZjIwMCAweDIwMCAweDhkMDA4ODAgMHgzMCAweDhkMGMxMDAgMHg1MzQgMHg4ZDBlYzAw
IDB4M2M0PjsKCQkJcmVnLW5hbWVzID0gImN0cmxcMHhoY2lfZWNcMHhoY2lfZ2JsXDBiZGNf
ZWMiOwoJCQkjYWRkcmVzcy1jZWxscyA9IDwweDAxPjsKCQkJI3NpemUtY2VsbHMgPSA8MHgw
MT47CgkJCWJyY20saW9jID0gPDB4MDE+OwoJCQlicmNtLGlwcCA9IDwweDAxPjsKCQkJY29t
cGF0aWJsZSA9ICJicmNtLGJjbTcyMTYtdXNiLXBoeVwwYnJjbSxicmNtc3RiLXVzYi1waHlc
MGJyY20sdXNiLXBoeSI7CgkJCWlvYyA9IDwweDAxPjsKCQkJaXBwID0gPDB4MDE+OwoJCQlp
bnRlcnJ1cHRzID0gPDB4MGE+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPDB4MGE+OwoJCQlp
bnRlcnJ1cHQtbmFtZXMgPSAid2FrZSI7CgkJCSNwaHktY2VsbHMgPSA8MHgwMT47CgkJCXJh
bmdlczsKCQkJaGFzX3hoY2lfb25seTsKCQkJYnJjbSxoYXMteGhjaTsKCQkJY2xvY2tzID0g
PDB4MDkgMHhmYj47CgkJCWNsb2NrLW5hbWVzID0gInN3X3VzYiI7CgkJCWxpbnV4LHBoYW5k
bGUgPSA8MHgwYj47CgkJCXBoYW5kbGUgPSA8MHgwYj47CgkJfTsKCgkJeGhjaV92MkA4ZDAw
MDAwIHsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcyMTYteGhjaVwwYnJjbSxiY203NDQ1
LXhoY2lcMGJyY20seGhjaS1icmNtLXYyXDBnZW5lcmljLXhoY2kiOwoJCQlyZWcgPSA8MHg4
ZDAwMDAwIDB4NTAwPjsKCQkJaW50ZXJydXB0cyA9IDwweDAwIDB4NzEgMHgwND47CgkJCWlu
dGVycnVwdC1uYW1lcyA9ICJ1c2IwX3hoY2lfMCI7CgkJCXBoeXMgPSA8MHgwYiAweDAxPjsK
CQkJcGh5LW5hbWVzID0gInVzYnBoeSI7CgkJCWNsb2NrcyA9IDwweDA5IDB4ZmM+OwoJCQlj
bG9jay1uYW1lcyA9ICJzd191c2IiOwoJCX07CgoJCWJkY192MkA4ZDBlMDAwIHsKCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJkYy11ZGMtdjMuMVww
YnJjbSxiZGMtdWRjLXYyIjsKCQkJcmVnID0gPDB4OGQwZTAwMCAweDQwMD47CgkJCWludGVy
cnVwdHMgPSA8MHgwMCAweDcyIDB4MDQ+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAidXNiMF91
c2JkIjsKCQkJcGh5cyA9IDwweDBiIDB4MDE+OwoJCQlwaHktbmFtZXMgPSAidXNicGh5IjsK
CQkJY2xvY2tzID0gPDB4MDkgMHhmZD47CgkJCWNsb2NrLW5hbWVzID0gInN3X3VzYmQiOwoJ
CX07CgoJCWV0aGVybmV0QDhmMDAwMDAgewoJCQlwaHktbW9kZSA9ICJyZ21paSI7CgkJCXBo
eS1oYW5kbGUgPSA8MHgyYT47CgkJCXBoeS1zcGVlZCA9IDwweDNlOD47CgkJCXBoeS1pZCA9
IDwweDAxPjsKCQkJcGh5LXR5cGUgPSA8MHgwNj47CgkJCWxvY2FsLW1hYy1hZGRyZXNzID0g
WzAwIDEwIDE4IGFjIDBiIDlkXTsKCQkJbGludXgscGhhbmRsZSA9IDwweDI5PjsKCQkJcGhh
bmRsZSA9IDwweDI5PjsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MHgwMT47CgkJCSNzaXplLWNl
bGxzID0gPDB4MDE+OwoJCQljb21wYXRpYmxlID0gImJyY20sZ2VuZXQtdjUiOwoJCQlkZXZp
Y2VfdHlwZSA9ICJuZXR3b3JrIjsKCQkJcmVnID0gPDB4OGYwMDAwMCAweDEwMDEwPjsKCQkJ
aW50ZXJydXB0cyA9IDwweDAwIDB4M2EgMHgwNCAweDAwIDB4M2IgMHgwND47CgkJCWludGVy
cnVwdC1wYXJlbnQgPSA8MHgwMT47CgkJCWludGVycnVwdHMtZXh0ZW5kZWQgPSA8MHgwMSAw
eDAwIDB4M2EgMHgwNCAweDAxIDB4MDAgMHgzYiAweDA0IDB4MGEgMHgwZD47CgkJCWludGVy
cnVwdC1uYW1lcyA9ICJnZW5ldF8wX2FcMGdlbmV0XzBfYlwwd29sX2dlbmV0IjsKCQkJY2xv
Y2tzID0gPDB4MDkgMHhlNCAweDA5IDB4ZTYgMHgwOSAweGVhIDB4MDkgMHhlNCAweDA5IDB4
ZTYgMHgwOSAweGVhPjsKCQkJY2xvY2stbmFtZXMgPSAic3dfZ2VuZXRcMHN3X2dlbmV0ZWVl
XDBzd19nZW5ldHdvbFwwZW5ldFwwZW5ldC1lZWVcMGVuZXQtd29sIjsKCgkJCW1kaW9AZTE0
IHsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDB4MDE+OwoJCQkJI3NpemUtY2VsbHMgPSA8MHgw
MD47CgkJCQljb21wYXRpYmxlID0gImJyY20sZ2VuZXQtbWRpby12NSI7CgkJCQlyZWcgPSA8
MHhlMTQgMHgwOD47CgoJCQkJZXRoZXJuZXQtcGh5QDEwMSB7CgkJCQkJbGludXgscGhhbmRs
ZSA9IDwweDJhPjsKCQkJCQlwaGFuZGxlID0gPDB4MmE+OwoJCQkJCWRldmljZV90eXBlID0g
ImV0aGVybmV0LXBoeSI7CgkJCQkJbWF4LXNwZWVkID0gPDB4M2U4PjsKCQkJCQljb21wYXRp
YmxlID0gImV0aGVybmV0LXBoeS1pZWVlODAyLjMtYzIyIjsKCQkJCX07CgkJCX07CgkJfTsK
CgkJZXRoZXJuZXRAOGYyMDAwMCB7CgkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7CgkJCWxpbnV4
LHBoYW5kbGUgPSA8MHgyYj47CgkJCXBoYW5kbGUgPSA8MHgyYj47CgkJCSNhZGRyZXNzLWNl
bGxzID0gPDB4MDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwweDAxPjsKCQkJY29tcGF0aWJsZSA9
ICJicmNtLGdlbmV0LXY1IjsKCQkJZGV2aWNlX3R5cGUgPSAibmV0d29yayI7CgkJCXJlZyA9
IDwweDhmMjAwMDAgMHgxMDAxMD47CgkJCWludGVycnVwdHMgPSA8MHgwMCAweDNjIDB4MDQg
MHgwMCAweDNkIDB4MDQ+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPDB4MDE+OwoJCQlpbnRl
cnJ1cHRzLWV4dGVuZGVkID0gPDB4MDEgMHgwMCAweDNjIDB4MDQgMHgwMSAweDAwIDB4M2Qg
MHgwNCAweDBhIDB4MGU+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAiZ2VuZXRfMV9hXDBnZW5l
dF8xX2JcMHdvbF9nZW5ldCI7CgkJCWNsb2NrcyA9IDwweDA5IDB4ZTUgMHgwOSAweGU3IDB4
MDkgMHhlYiAweDA5IDB4ZTUgMHgwOSAweGU3IDB4MDkgMHhlYj47CgkJCWNsb2NrLW5hbWVz
ID0gInN3X2dlbmV0XDBzd19nZW5ldGVlZVwwc3dfZ2VuZXR3b2xcMGVuZXRcMGVuZXQtZWVl
XDBlbmV0LXdvbCI7CgoJCQltZGlvQGUxNCB7CgkJCQkjYWRkcmVzcy1jZWxscyA9IDwweDAx
PjsKCQkJCSNzaXplLWNlbGxzID0gPDB4MDA+OwoJCQkJY29tcGF0aWJsZSA9ICJicmNtLGdl
bmV0LW1kaW8tdjUiOwoJCQkJcmVnID0gPDB4ZTE0IDB4MDg+OwoJCQl9OwoJCX07CgoJCWdw
aW9AODQwYTUwMCB7CgkJCSNncGlvLWNlbGxzID0gPDB4MDI+OwoJCQkjaW50ZXJydXB0LWNl
bGxzID0gPDB4MDI+OwoJCQljb21wYXRpYmxlID0gImJyY20sYmNtNzIxNi1ncGlvXDBicmNt
LGJyY21zdGItZ3BpbyI7CgkJCWdwaW8tY29udHJvbGxlcjsKCQkJaW50ZXJydXB0LWNvbnRy
b2xsZXI7CgkJCXJlZyA9IDwweDg0MGE1MDAgMHg0MD47CgkJCWludGVycnVwdHMgPSA8MHgw
MD47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8MHgwYz47CgkJCWludGVycnVwdHMtZXh0ZW5k
ZWQgPSA8MHgwYyAweDAwIDB4MGEgMHgwNT47CgkJCWludGVycnVwdC1uYW1lcyA9ICJ1cGdf
Z2lvXDB1cGdfZ2lvX2Fvbl93YWtldXAiOwoJCQl3YWtldXAtc291cmNlOwoJCQlicmNtLGdw
aW8tYmFuay13aWR0aHMgPSA8MHgyMCAweDFmPjsKCQl9OwoKCQlncGlvQDg0MWE0MDAgewoJ
CQkjZ3Bpby1jZWxscyA9IDwweDAyPjsKCQkJI2ludGVycnVwdC1jZWxscyA9IDwweDAyPjsK
CQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcyMTYtZ3Bpb1wwYnJjbSxicmNtc3RiLWdwaW8i
OwoJCQlncGlvLWNvbnRyb2xsZXI7CgkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQlyZWcg
PSA8MHg4NDFhNDAwIDB4NDA+OwoJCQlpbnRlcnJ1cHRzID0gPDB4MDA+OwoJCQlpbnRlcnJ1
cHQtcGFyZW50ID0gPDB4MGQ+OwoJCQlpbnRlcnJ1cHRzLWV4dGVuZGVkID0gPDB4MGQgMHgw
MCAweDBhIDB4MDU+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAidXBnX2dpb19hb25cMHVwZ19n
aW9fYW9uX3dha2V1cCI7CgkJCWFsd2F5cy1vbjsKCQkJd2FrZXVwLXNvdXJjZTsKCQkJYnJj
bSxncGlvLWJhbmstd2lkdGhzID0gPDB4MGIgMHgwNj47CgkJfTsKCgkJc2F0YUA4YjBhMDAw
IHsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MHgwMT47CgkJCSNzaXplLWNlbGxzID0gPDB4MDA+
OwoJCQljb21wYXRpYmxlID0gImJyY20sYmNtNzIxNi1haGNpXDBicmNtLGJjbTc0NDUtYWhj
aVwwYnJjbSxzYXRhMy1haGNpIjsKCQkJcGh5LWVuYWJsZS1zc2MtbWFzayA9IDwweDAzPjsK
CQkJcGh5LWdlbmVyYXRpb24gPSA8MHgyODAwPjsKCQkJcmVnLW5hbWVzID0gImFoY2lcMHRv
cC1jdHJsIjsKCQkJcmVnID0gPDB4OGIwYTAwMCAweDIwMTAgMHg4YjA4MDAwIDB4MjQ+OwoJ
CQlpbnRlcnJ1cHRzID0gPDB4MDAgMHgzZSAweDA0PjsKCQkJaW50ZXJydXB0LW5hbWVzID0g
InNhdGFfYWhjaSI7CgkJCXBoeS1iYXNlLWFkZHIgPSA8MHg4YjA4MTAwPjsKCQkJdG9wLWN0
cmwtYmFzZS1hZGRyID0gPDB4OGIwODAwMD47CgkJCXJlc2V0cyA9IDwweDBlPjsKCQkJcmVz
ZXQtbmFtZXMgPSAicmVzY2FsIjsKCQkJY2xvY2tzID0gPDB4MDkgMHhmND47CgkJCWNsb2Nr
LW5hbWVzID0gInN3X3NhdGEzIjsKCgkJCXNhdGEtcG9ydEAwIHsKCQkJCXJlZyA9IDwweDAw
PjsKCQkJCXBoeXMgPSA8MHgwZj47CgkJCX07CgkJfTsKCgkJc2F0YV9waHlAOGIwODEwMCB7
CgkJCSNhZGRyZXNzLWNlbGxzID0gPDB4MDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwweDAwPjsK
CQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcyMTYtc2F0YS1waHlcMGJyY20sYmNtNzQ0NS1z
YXRhLXBoeVwwYnJjbSxwaHktc2F0YTMiOwoJCQlyZWcgPSA8MHg4YjA4MTAwIDB4ZWZjPjsK
CQkJcmVnLW5hbWVzID0gInBoeSI7CgoJCQlzYXRhLXBoeUAwIHsKCQkJCXJlZyA9IDwweDAw
PjsKCQkJCSNwaHktY2VsbHMgPSA8MHgwMD47CgkJCQlicmNtLGVuYWJsZS1zc2M7CgkJCQli
cmNtLHR4LWFtcGxpdHVkZS1taWxsaXZvbHQgPSA8MHgwMD47CgkJCQlsaW51eCxwaGFuZGxl
ID0gPDB4MGY+OwoJCQkJcGhhbmRsZSA9IDwweDBmPjsKCQkJfTsKCQl9OwoKCQlzZGhjaUA4
NGIwMDAwIHsKCQkJbm8tMS04LXY7CgkJCXNkaGNpLGF1dG8tY21kMTI7CgkJCW5vLW1tYzsK
CQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcyMTYtc2RoY2lcMGJyY20sYmNtNzQ0NS1zZGhj
aVwwYnJjbSxzZGhjaS1icmNtc3RiIjsKCQkJcmVnID0gPDB4ODRiMDAwMCAweDI2MCAweDg0
YjAzMDAgMHgyMDA+OwoJCQlyZWctbmFtZXMgPSAiaG9zdFwwY2ZnIjsKCQkJaW50ZXJydXB0
cyA9IDwweDAwIDB4MjYgMHgwND47CgkJCWludGVycnVwdC1uYW1lcyA9ICJzZGlvMF8wIjsK
CQkJY2xvY2tzID0gPDB4MDkgMHhmNT47CgkJCWNsb2NrLW5hbWVzID0gInN3X3NkaW8iOwoJ
CX07CgoJCXNkaGNpQDg0YjEwMDAgewoJCQltbWMtZGRyLTFfOHY7CgkJCW1tYy1oczIwMC0x
Xzh2OwoJCQluby1zZDsKCQkJbm8tc2RpbzsKCQkJbm9uLXJlbW92YWJsZTsKCQkJYnVzLXdp
ZHRoID0gPDB4MDg+OwoJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwoJCQljb21wYXRpYmxlID0g
ImJyY20sYmNtNzIxNi1zZGhjaVwwYnJjbSxiY203NDQ1LXNkaGNpXDBicmNtLHNkaGNpLWJy
Y21zdGIiOwoJCQlyZWcgPSA8MHg4NGIxMDAwIDB4MjYwIDB4ODRiMTMwMCAweDIwMD47CgkJ
CXJlZy1uYW1lcyA9ICJob3N0XDBjZmciOwoJCQlpbnRlcnJ1cHRzID0gPDB4MDAgMHgyNyAw
eDA0PjsKCQkJaW50ZXJydXB0LW5hbWVzID0gInNkaW8xXzAiOwoJCQlzeXNjb24tZW1tYyA9
IDwweDEwPjsKCQkJY2xvY2tzID0gPDB4MDkgMHhmNT47CgkJCWNsb2NrLW5hbWVzID0gInN3
X3NkaW8iOwoJCX07CgoJCWludGVycnVwdC1jb250cm9sbGVyQDg0MDAwMDAgewoJCQkjaW50
ZXJydXB0LWNlbGxzID0gPDB4MDE+OwoJCQljb21wYXRpYmxlID0gImJyY20sbDItaW50YyI7
CgkJCWludGVycnVwdC1wYXJlbnQgPSA8MHgwMT47CgkJCXJlZyA9IDwweDg0MDAwMDAgMHg0
OD47CgkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQlpbnRlcnJ1cHRzID0gPDB4MDAgMHg1
MyAweDA0PjsKCQkJaW50ZXJydXB0LW5hbWVzID0gInN5cyI7CgkJCWJyY20saXJxLWNhbi13
YWtlOwoJCQlsaW51eCxwaGFuZGxlID0gPDB4MTE+OwoJCQlwaGFuZGxlID0gPDB4MTE+OwoJ
CX07CgoJCWludGVycnVwdC1jb250cm9sbGVyQDg0YTEwMDAgewoJCQkjaW50ZXJydXB0LWNl
bGxzID0gPDB4MDE+OwoJCQljb21wYXRpYmxlID0gImJyY20sbDItaW50YyI7CgkJCWludGVy
cnVwdC1wYXJlbnQgPSA8MHgwMT47CgkJCXJlZyA9IDwweDg0YTEwMDAgMHgzMD47CgkJCWlu
dGVycnVwdC1jb250cm9sbGVyOwoJCQlpbnRlcnJ1cHRzID0gPDB4MDAgMHgyMiAweDA0PjsK
CQkJaW50ZXJydXB0LW5hbWVzID0gImhpZiI7CgkJfTsKCgkJaW50ZXJydXB0LWNvbnRyb2xs
ZXJAODRhMTgwMCB7CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgwMT47CgkJCWNvbXBhdGli
bGUgPSAiYnJjbSxoaWYtc3BpLWwyLWludGMiOwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPDB4
MDE+OwoJCQlyZWcgPSA8MHg4NGExODAwIDB4MzA+OwoJCQlpbnRlcnJ1cHQtY29udHJvbGxl
cjsKCQkJaW50ZXJydXB0cyA9IDwweDAwIDB4MjMgMHgwND47CgkJCWludGVycnVwdC1uYW1l
cyA9ICJoaWZfc3BpIjsKCQkJbGludXgscGhhbmRsZSA9IDwweDE0PjsKCQkJcGhhbmRsZSA9
IDwweDE0PjsKCQl9OwoKCQlpbnRlcnJ1cHQtY29udHJvbGxlckA4NDEwNjQwIHsKCQkJI2lu
dGVycnVwdC1jZWxscyA9IDwweDAxPjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGwyLWludGMi
OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPDB4MDE+OwoJCQlyZWcgPSA8MHg4NDEwNjQwIDB4
MzA+OwoJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsKCQkJaW50ZXJydXB0cyA9IDwweDAwIDB4
NTUgMHgwND47CgkJCWludGVycnVwdC1uYW1lcyA9ICJzeXNfcG0iOwoJCQlicmNtLGlycS1j
YW4td2FrZTsKCQkJbGludXgscGhhbmRsZSA9IDwweDBhPjsKCQkJcGhhbmRsZSA9IDwweDBh
PjsKCQl9OwoKCQlnaXNiLWFyYkA4M2ZjMDAwIHsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJj
bTcyNzgtZ2lzYi1hcmIiOwoJCQlyZWcgPSA8MHg4M2ZjMDAwIDB4ODAwPjsKCQkJaW50ZXJy
dXB0cyA9IDwweDAwIDB4MTcgMHgwMSAweDE4PjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDww
eDExPjsKCQkJaW50ZXJydXB0LW5hbWVzID0gImdpc2JfdGltZW91dFwwZ2lzYl90ZWFcMGdp
c2JfYnJlYWtwb2ludF9lcnJvclwwZ2lzYl9idXNfd2FybmluZyI7CgkJCWJyY20sZ2lzYi1h
cmItbWFzdGVyLW1hc2sgPSA8MHg2MTlhOGY0Mj47CgkJCWJyY20sZ2lzYi1hcmItbWFzdGVy
LW5hbWVzID0gInNjcHVfMFwwY3B1XzBcMGp0YWdfMFwwc3NwXzBcMHJkY18wXDBodmRfMFww
dmljZV8wXDByYWFnYV8wXDBwY2llXzBcMHBjaWVfMVwwYmJzaV9zcGlcMGF2c18wXDBic3Bf
MFwwY3B1X3NfMCI7CgkJfTsKCgkJaW50ZXJydXB0LWNvbnRyb2xsZXJAODQxYTg4MCB7CgkJ
CSNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgwMT47CgkJCWNvbXBhdGlibGUgPSAiYnJjbSx1cGct
YXV4LWFvbi1sMi1pbnRjIjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwweDAxPjsKCQkJcmVn
ID0gPDB4ODQxYTg4MCAweDMwPjsKCQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7CgkJCWludGVy
cnVwdHMgPSA8MHgwMCAweDU3IDB4MDQ+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAidXBnX2F1
eF9hb24iOwoJCQlicmNtLGlycS1jYW4td2FrZTsKCQkJbGludXgscGhhbmRsZSA9IDwweDEz
PjsKCQkJcGhhbmRsZSA9IDwweDEzPjsKCQl9OwoKCQl3YWtldGltZXJAODQxYTg0MCB7CgkJ
CWNsb2NrcyA9IDwweDEyPjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyY21zdGItd2FrZXRp
bWVyIjsKCQkJcmVnID0gPDB4ODQxYTg0MCAweDE0PjsKCQkJaW50ZXJydXB0cyA9IDwweDAz
PjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwweDBhPjsKCQkJaW50ZXJydXB0cy1leHRlbmRl
ZCA9IDwweDBhIDB4MDMgMHgxMyAweDA4PjsKCQkJaW50ZXJydXB0LW5hbWVzID0gInRpbWVy
XDB3a3Rtcl9hbGFybSI7CgkJfTsKCgkJdGhlcm1hbEBhNTgxNTAwIHsKCQkJI3RoZXJtYWwt
c2Vuc29yLWNlbGxzID0gPDB4MDA+OwoJCQljb21wYXRpYmxlID0gImJyY20sYXZzLXRtb24t
YmNtNzIxNlwwYnJjbSxhdnMtdG1vbi1iY203NDQ1XDBicmNtLGF2cy10bW9uIjsKCQkJcmVn
ID0gPDB4YTU4MTUwMCAweDI4PjsKCQkJbGludXgscGhhbmRsZSA9IDwweDA3PjsKCQkJcGhh
bmRsZSA9IDwweDA3PjsKCQl9OwoKCQlhb24tY3RybEA4NDEwMDAwIHsKCQkJY29tcGF0aWJs
ZSA9ICJicmNtLGJyY21zdGItYW9uLWN0cmwiOwoJCQlyZWcgPSA8MHg4NDEwMDAwIDB4MjAw
IDB4ODQxMDIwMCAweDQwMD47CgkJCXJlZy1uYW1lcyA9ICJhb24tY3RybFwwYW9uLXNyYW0i
OwoJCX07CgoJCW1lbW9yeV9jb250cm9sbGVycyB7CgkJCXJhbmdlczsKCQkJY29tcGF0aWJs
ZSA9ICJzaW1wbGUtYnVzIjsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MHgwMT47CgkJCSNzaXpl
LWNlbGxzID0gPDB4MDE+OwoKCQkJbWVtY0AwIHsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDB4
MDE+OwoJCQkJI3NpemUtY2VsbHMgPSA8MHgwMT47CgkJCQljb21wYXRpYmxlID0gImJyY20s
YnJjbXN0Yi1tZW1jXDBzaW1wbGUtYnVzIjsKCQkJCXJhbmdlczsKCQkJCWJyY20sbWFwLXRv
LWNwdSA9IDwweDAwIDB4MDAgMHgwMCAweDQwMDAwMDAwIDB4MDMgMHgwMD47CgoJCQkJbWVt
Yy1nZW5AOTkwMDAwMCB7CgkJCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyY21zdGItbWVtYy1n
ZW4tcmV2LWMuMS4xXDBicmNtLGJyY21zdGItbWVtYy1nZW4iOwoJCQkJCXJlZyA9IDwweDk5
MDAwMDAgMHg4MDA+OwoJCQkJfTsKCgkJCQltZW1jLWFyYkA5OTAzMDAwIHsKCQkJCQljb21w
YXRpYmxlID0gImJyY20sYnJjbXN0Yi1tZW1jLWFyYiI7CgkJCQkJcmVnID0gPDB4OTkwMzAw
MCAweDRmMD47CgkJCQkJYnJjbSxtZW1jLWNsaWVudC1tYXNrcyA9IDwweGUwZmYzMDdmIDB4
ZmZmZmZmZmYgMHhmZmZmZmZmZiAweDNmPjsKCQkJCQlicmNtLG1lbWMtY2xpZW50LW5hbWVz
ID0gImRyYW1faW5pdF96cWNzXDByZWZyZXNoXDB6cWNzX2VuZ2luZVwwZHR1X3NjcnViYmVy
XDB0cmFjZWxvZ1wwbXNhXDBkaXMwXDBodmQwX3BmcmlcMHZpY2VfcGZyaVwwaG9zdF9jcHVf
bWNwX3JfaGlcMGhvc3RfY3B1X21jcF9yX2xvXDBob3N0X2NwdV9tY3Bfd19oaVwwaG9zdF9j
cHVfbWNwX3dfbG9cMHYzZF9tY3Bfcl9oaVwwdjNkX21jcF9yX2xvXDB2M2RfbWNwX3dfaGlc
MHYzZF9tY3Bfd19sb1wwYnNwX2RtYVwwc2FnZV9kbWFcMHNjcHVcMHVhcnRfZG1hX3JkXDB1
YXJ0X2RtYV93clwweHB0X3dyX3R1bmVyX3JzXDB4cHRfd3JfY2FyZF9yc1wweHB0X3dyX2Nk
YlwweHB0X3dyX2l0Yl9tc2dcMHhwdF9yZF9yc1wweHB0X3JkX2NhcmRfcnNcMHhwdF9yZF9w
YlwweHB0X3dyX21lbWRtYVwwZ2VuZXQwX3dyXDBnZW5ldDBfcmRcMGdlbmV0MV93clwwZ2Vu
ZXQxX3JkXDBwY2llXzBcMHBjaWVfMVwwc2Rpb19lbW1jXDBzZGlvX2NhcmRcMHNhdGFcMHVz
Yl94XzBcMHVzYl9iZGNfMFwwbTJtY18wXDBtMm1jXzFcMG0ybWNfMlwwbTJtYzFfMFwwbTJt
YzFfMVwwbTJtYzFfMlwwbW1fbTJtY18wXDBtbV9tMm1jXzFcMG1tX20ybWNfMlwwcmFhZ2Fc
MGF1ZF9haW9cMGh2ZDBfZGJsa1wwaHZkMF92Z1wwaHZkMF9pbGNwdVwwaHZkMF9vbGNwdVww
aHZkMF9jYWJcMGh2ZDBfaWxzaVwwYnZuX3JkY1wwYnZuX21mZDBcMGJ2bl9tZmQwXzFcMGJ2
bl9tYWRfcGl4X2ZkXDBidm5fbWFkX3F1YW50XDBidm5fbWFkX3BpeF9jYXBcMGJ2bl9jYXAw
XDBidm5fdmZkMFwwYnZuX2dmZDBcMGJ2bl9jbXAwXDB2ZWNfdmJpX2VuYzBcMHZlY19sdXRf
bGRcMGJ2bl9tZmQxXDBidm5fbWZkMV8xXDBidm5fbWFkMV9waXhfZmRcMGJ2bl9tYWQxX3F1
YW50XDBidm5fbWFkMV9waXhfY2FwXDBidm5fY2FwMVwwYnZuX3ZmZDFcMGJ2bl9nZmQxXDBi
dm5fdHN4MFwwYnZuX3RzeDBfMVwwdmljZV9jbWUwXDB2aWNlX2NtZTFcMHZpY2VfZm1lXDB2
aWNlX2ltZDBcMHZpY2VfaW1kMVwwdmljZV9kYmxrXDB2aWNlX2NhYmFjMFwwdmljZV9jYWJh
YzFcMHZpY2VfcHNzMFwwdmljZV92aXAwX2luc3QwIjsKCQkJCQlicmNtLG1lbWMtbWF4LWNs
aWVudHMgPSA8MHg2Nj47CgkJCQl9OwoKCQkJCWRkci1waHlAOTkyMDAwMCB7CgkJCQkJY29t
cGF0aWJsZSA9ICJicmNtLGJyY21zdGItZGRyLXBoeS12NzYuMSI7CgkJCQkJcmVnID0gPDB4
OTkyMDAwMCAweGI0PjsKCQkJCX07CgoJCQkJc2hpbXBoeUA5OTA4MDAwIHsKCQkJCQljb21w
YXRpYmxlID0gImJyY20sYnJjbXN0Yi1kZHItc2hpbXBoeS12MS4wIjsKCQkJCQlyZWcgPSA8
MHg5OTA4MDAwIDB4Yzg+OwoJCQkJfTsKCgkJCQltZW1jLWRkckA5OTAyMDAwIHsKCQkJCQlj
bG9jay1mcmVxdWVuY3kgPSA8MHg3ZjIyZmY0MD47CgkJCQkJY29tcGF0aWJsZSA9ICJicmNt
LGJyY21zdGItbWVtYy1kZHItcmV2LWMuMS4xXDBicmNtLGJyY21zdGItbWVtYy1kZHIiOwoJ
CQkJCXJlZyA9IDwweDk5MDIwMDAgMHg2MDA+OwoJCQkJfTsKCQkJfTsKCQl9OwoKCQlzcGlA
ODRiMzQwMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDB4MDE+OwoJCQkjc2l6ZS1jZWxscyA9
IDwweDAwPjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLHNwaS1icmNtc3RiXDBicmNtLHNwaS1i
Y20tcXNwaSI7CgkJCXJlZyA9IDwweDg0YjM0MDAgMHgxODggMHg4NGIzMjAwIDB4NTAgMHg4
NGIzMzAwIDB4MmMgMHg4NGExODAwIDB4MzAgMHg4NGIyMTIwIDB4MDQ+OwoJCQlyZWctbmFt
ZXMgPSAiaGlmX21zcGlcMGJzcGlcMGJzcGlfcmFmXDBoaWZfc3BpX2ludHIyXDBjc19yZWci
OwoJCQlpbnRlcnJ1cHRzID0gPDB4MDAgMHgyMyAweDA0PjsKCQkJaW50ZXJydXB0LW5hbWVz
ID0gImhpZl9zcGkiOwoKCQkJbTI1cDgwQDAgewoJCQkJI3NpemUtY2VsbHMgPSA8MHgwMj47
CgkJCQkjYWRkcmVzcy1jZWxscyA9IDwweDAyPjsKCQkJCWNvbXBhdGlibGUgPSAibTI1cDgw
IjsKCQkJCXJlZyA9IDwweDAwPjsKCQkJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDB4MjYyNWEw
MD47CgkJCQlzcGktY3BvbDsKCQkJCXNwaS1jcGhhOwoJCQkJdXNlLWJzcGk7CgkJCQltMjVw
LGZhc3QtcmVhZDsKCgkJCQlmbGFzaDAuYm9sdEAwIHsKCQkJCQlyZWcgPSA8MHgwMCAweDAw
IDB4MDAgMHgyODAwMDA+OwoJCQkJfTsKCgkJCQlmbGFzaDAubWFjYWRyQDI4MDAwMCB7CgkJ
CQkJcmVnID0gPDB4MDAgMHgyODAwMDAgMHgwMCAweDEwMDAwPjsKCQkJCX07CgoJCQkJZmxh
c2gwLm52cmFtQDI5MDAwMCB7CgkJCQkJcmVnID0gPDB4MDAgMHgyOTAwMDAgMHgwMCAweDEw
MDAwPjsKCQkJCX07CgoJCQkJZmxhc2gwLndsYW5AMmEwMDAwIHsKCQkJCQlyZWcgPSA8MHgw
MCAweDJhMDAwMCAweDAwIDB4MTAwMDA+OwoJCQkJfTsKCgkJCQlmbGFzaDAua2VybmVsQDJi
MDAwMCB7CgkJCQkJcmVnID0gPDB4MDAgMHgyYjAwMDAgMHgwMCAweDg1MDAwMD47CgkJCQl9
OwoKCQkJCWZsYXNoMC5icDMwQGIwMDAwMCB7CgkJCQkJcmVnID0gPDB4MDAgMHhiMDAwMDAg
MHgwMCAweDEwMDAwPjsKCQkJCX07CgoJCQkJZmxhc2gwLmJwMzFAYjEwMDAwIHsKCQkJCQly
ZWcgPSA8MHgwMCAweGIxMDAwMCAweDAwIDB4MTAwMDA+OwoJCQkJfTsKCgkJCQlmbGFzaDAu
ZGV2dHJlZUBiMjAwMDAgewoJCQkJCXJlZyA9IDwweDAwIDB4YjIwMDAwIDB4MDAgMHgxMDAw
MD47CgkJCQl9OwoKCQkJCWZsYXNoMC5zcGxhc2hAYjMwMDAwIHsKCQkJCQlyZWcgPSA8MHgw
MCAweGIzMDAwMCAweDAwIDB4ODAwMDA+OwoJCQkJfTsKCgkJCQlmbGFzaDAucm9vdGZzQGJi
MDAwMCB7CgkJCQkJcmVnID0gPDB4MDAgMHhiYjAwMDAgMHgwMCAweDM0NTAwMDA+OwoJCQkJ
fTsKCgkJCQlmbGFzaDBAMCB7CgkJCQkJcmVnID0gPDB4MDAgMHgwMCAweDAwIDB4NDAwMDAw
MD47CgkJCQl9OwoJCQl9OwoJCX07CgoJCXFzcGlAODRiMzQwMCB7CgkJCSNhZGRyZXNzLWNl
bGxzID0gPDB4MDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwweDAwPjsKCQkJY29tcGF0aWJsZSA9
ICJicmNtLHNwaS1iY203MjE2LXFzcGlcMGJyY20sc3BpLWJjbTc0NDUtcXNwaVwwYnJjbSxz
cGktYmNtLXFzcGlcMGJyY20sc3BpLWJyY21zdGItcXNwaSI7CgkJCXJlZyA9IDwweDg0YjIx
MjAgMHgwNCAweDg0YjM0MDAgMHgxODggMHg4NGIzMjAwIDB4NTA+OwoJCQlyZWctbmFtZXMg
PSAiY3NfcmVnXDBoaWZfbXNwaVwwYnNwaSI7CgkJCWludGVycnVwdHMgPSA8MHgwNiAweDA1
IDB4MDQgMHgwMyAweDAyIDB4MDEgMHgwMD47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8MHgx
ND47CgkJCWludGVycnVwdC1uYW1lcyA9ICJtc3BpX2hhbHRlZFwwbXNwaV9kb25lXDBzcGlf
bHJfb3ZlcnJlYWRcMHNwaV9scl9zZXNzaW9uX2RvbmVcMHNwaV9scl9pbXBhdGllbnRcMHNw
aV9scl9zZXNzaW9uX2Fib3J0ZWRcMHNwaV9scl9mdWxsbmVzc19yZWFjaGVkIjsKCQkJY2xv
Y2tzID0gPDB4MDkgMHhmNz47CgkJCWNsb2NrLW5hbWVzID0gInN3X3NwaW5vciI7CgoJCQlt
MjVwODBAMCB7CgkJCQkjc2l6ZS1jZWxscyA9IDwweDAyPjsKCQkJCSNhZGRyZXNzLWNlbGxz
ID0gPDB4MDI+OwoJCQkJY29tcGF0aWJsZSA9ICJtMjVwODAiOwoJCQkJcmVnID0gPDB4MDA+
OwoJCQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MHgyNjI1YTAwPjsKCQkJCXNwaS1jcG9sOwoJ
CQkJc3BpLWNwaGE7CgkJCQl1c2UtYnNwaTsKCQkJCW0yNXAsZmFzdC1yZWFkOwoKCQkJCWZs
YXNoMC5ib2x0QDAgewoJCQkJCXJlZyA9IDwweDAwIDB4MDAgMHgwMCAweDI4MDAwMD47CgkJ
CQl9OwoKCQkJCWZsYXNoMC5tYWNhZHJAMjgwMDAwIHsKCQkJCQlyZWcgPSA8MHgwMCAweDI4
MDAwMCAweDAwIDB4MTAwMDA+OwoJCQkJfTsKCgkJCQlmbGFzaDAubnZyYW1AMjkwMDAwIHsK
CQkJCQlyZWcgPSA8MHgwMCAweDI5MDAwMCAweDAwIDB4MTAwMDA+OwoJCQkJfTsKCgkJCQlm
bGFzaDAud2xhbkAyYTAwMDAgewoJCQkJCXJlZyA9IDwweDAwIDB4MmEwMDAwIDB4MDAgMHgx
MDAwMD47CgkJCQl9OwoKCQkJCWZsYXNoMC5rZXJuZWxAMmIwMDAwIHsKCQkJCQlyZWcgPSA8
MHgwMCAweDJiMDAwMCAweDAwIDB4ODUwMDAwPjsKCQkJCX07CgoJCQkJZmxhc2gwLmJwMzBA
YjAwMDAwIHsKCQkJCQlyZWcgPSA8MHgwMCAweGIwMDAwMCAweDAwIDB4MTAwMDA+OwoJCQkJ
fTsKCgkJCQlmbGFzaDAuYnAzMUBiMTAwMDAgewoJCQkJCXJlZyA9IDwweDAwIDB4YjEwMDAw
IDB4MDAgMHgxMDAwMD47CgkJCQl9OwoKCQkJCWZsYXNoMC5kZXZ0cmVlQGIyMDAwMCB7CgkJ
CQkJcmVnID0gPDB4MDAgMHhiMjAwMDAgMHgwMCAweDEwMDAwPjsKCQkJCX07CgoJCQkJZmxh
c2gwLnNwbGFzaEBiMzAwMDAgewoJCQkJCXJlZyA9IDwweDAwIDB4YjMwMDAwIDB4MDAgMHg4
MDAwMD47CgkJCQl9OwoKCQkJCWZsYXNoMC5yb290ZnNAYmIwMDAwIHsKCQkJCQlyZWcgPSA8
MHgwMCAweGJiMDAwMCAweDAwIDB4MzQ1MDAwMD47CgkJCQl9OwoKCQkJCWZsYXNoMEAwIHsK
CQkJCQlyZWcgPSA8MHgwMCAweDAwIDB4MDAgMHg0MDAwMDAwPjsKCQkJCX07CgkJCX07CgkJ
fTsKCgkJc3lzY29uQDg0MDQwMDAgewoJCQljb21wYXRpYmxlID0gImJyY20sYnJjbXN0Yi1z
dW4tdG9wLWN0cmxcMHN5c2NvbiI7CgkJCXJlZyA9IDwweDg0MDQwMDAgMHg3MDg+OwoJCQls
aW51eCxwaGFuZGxlID0gPDB4MTY+OwoJCQlwaGFuZGxlID0gPDB4MTY+OwoJCX07CgoJCXN5
c2NvbkA4NDA0NTM0IHsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyY21zdGItc3VuLXRvcC1j
dHJsLXNhdGEtcGNpZTAtc2VsZWN0XDBzeXNjb24iOwoJCQlyZWcgPSA8MHg4NDA0NTM0IDB4
MDQ+OwoJCQlsaW51eCxwaGFuZGxlID0gPDB4MWQ+OwoJCQlwaGFuZGxlID0gPDB4MWQ+OwoJ
CX07CgoJCXN5c2NvbkA4NDA0MTAwIHsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyY21zdGIt
c3VuLXRvcC1jdHJsLXBpbi1tdXgtY3RybFwwc3lzY29uIjsKCQkJcmVnID0gPDB4ODQwNDEw
MCAweDI0PjsKCQkJbGludXgscGhhbmRsZSA9IDwweDFlPjsKCQkJcGhhbmRsZSA9IDwweDFl
PjsKCQl9OwoKCQlzeXNjb25AODQwNDEyNCB7CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxicmNt
c3RiLXN1bi10b3AtY3RybC1waW4tbXV4LXBhZC1jdHJsXDBzeXNjb24iOwoJCQlyZWcgPSA8
MHg4NDA0MTI0IDB4MTg+OwoJCQlsaW51eCxwaGFuZGxlID0gPDB4MWY+OwoJCQlwaGFuZGxl
ID0gPDB4MWY+OwoJCX07CgoJCXN5c2NvbkA4NDEwNzAwIHsKCQkJY29tcGF0aWJsZSA9ICJi
cmNtLGJyY21zdGItYW9uLXBpbi1jdHJsLXBpbi1tdXgtY3RybFwwc3lzY29uIjsKCQkJcmVn
ID0gPDB4ODQxMDcwMCAweDBjPjsKCQkJbGludXgscGhhbmRsZSA9IDwweDIwPjsKCQkJcGhh
bmRsZSA9IDwweDIwPjsKCQl9OwoKCQlzeXNjb25AODQxMDcwYyB7CgkJCWNvbXBhdGlibGUg
PSAiYnJjbSxicmNtc3RiLWFvbi1waW4tY3RybC1wYWQtbXV4LWN0cmxcMHN5c2NvbiI7CgkJ
CXJlZyA9IDwweDg0MTA3MGMgMHgwOD47CgkJCWxpbnV4LHBoYW5kbGUgPSA8MHgyMT47CgkJ
CXBoYW5kbGUgPSA8MHgyMT47CgkJfTsKCgkJc3lzY29uQDk5MDMwMDQgewoJCQljb21wYXRp
YmxlID0gImJyY20sYnJjbXN0Yi1tZW1jLWFyYi0wLWNsaWVudC1pbmZvXDBzeXNjb24iOwoJ
CQlyZWcgPSA8MHg5OTAzMDA0IDB4MjAwPjsKCQl9OwoKCQlzeXNjb25AODQwNDA4NCB7CgkJ
CWNvbXBhdGlibGUgPSAiYnJjbSxicmNtc3RiLXN1bi10b3AtY3RybC1nZW5lcmFsLWN0cmwt
MVwwc3lzY29uIjsKCQkJcmVnID0gPDB4ODQwNDA4NCAweDA0PjsKCQkJbGludXgscGhhbmRs
ZSA9IDwweDIyPjsKCQkJcGhhbmRsZSA9IDwweDIyPjsKCQl9OwoKCQlzeXNjb25AODQwNDBh
NCB7CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxicmNtc3RiLXN1bi10b3AtY3RybC1nZW5lcmFs
LWN0cmwtbm8tc2Nhbi0wXDBzeXNjb24iOwoJCQlyZWcgPSA8MHg4NDA0MGE0IDB4MDQ+OwoJ
CQlsaW51eCxwaGFuZGxlID0gPDB4MjM+OwoJCQlwaGFuZGxlID0gPDB4MjM+OwoJCX07CgoJ
CXN5c2NvbkA4NGIwMzQ0IHsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyY21zdGItc2Rpby0w
LWNmZy1zZC1waW4tc2VsXDBzeXNjb24iOwoJCQlyZWcgPSA8MHg4NGIwMzQ0IDB4MDQ+OwoJ
CQlsaW51eCxwaGFuZGxlID0gPDB4MjQ+OwoJCQlwaGFuZGxlID0gPDB4MjQ+OwoJCX07CgoJ
CXN5c2NvbkA4NGIxMzQ0IHsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyY21zdGItc2Rpby0x
LWNmZy1zZC1waW4tc2VsXDBzeXNjb24iOwoJCQlyZWcgPSA8MHg4NGIxMzQ0IDB4MDQ+OwoJ
CQlsaW51eCxwaGFuZGxlID0gPDB4MjU+OwoJCQlwaGFuZGxlID0gPDB4MjU+OwoJCX07CgoJ
CXN5c2NvbkA4NGIxNTAwIHsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJyY21zdGItc2Rpby0x
LWJvb3QtbWFpbi1jdGxcMHN5c2NvbiI7CgkJCXJlZyA9IDwweDg0YjE1MDAgMHgwND47CgkJ
CWxpbnV4LHBoYW5kbGUgPSA8MHgyNj47CgkJCXBoYW5kbGUgPSA8MHgyNj47CgkJfTsKCgkJ
c3lzY29uQDg0YjAzN2MgewoJCQljb21wYXRpYmxlID0gImJyY20sYnJjbXN0Yi1zZGlvLTAt
Y2ZnLXBoeS1zdy1tb2RlLTAtcngtY3RybFwwc3lzY29uIjsKCQkJcmVnID0gPDB4ODRiMDM3
YyAweDA0PjsKCQkJbGludXgscGhhbmRsZSA9IDwweDI3PjsKCQkJcGhhbmRsZSA9IDwweDI3
PjsKCQl9OwoKCQlzeXNjb25AODRiMTM3YyB7CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxicmNt
c3RiLXNkaW8tMS1jZmctcGh5LXN3LW1vZGUtMC1yeC1jdHJsXDBzeXNjb24iOwoJCQlyZWcg
PSA8MHg4NGIxMzdjIDB4MDQ+OwoJCQlsaW51eCxwaGFuZGxlID0gPDB4Mjg+OwoJCQlwaGFu
ZGxlID0gPDB4Mjg+OwoJCX07CgoJCXN5c2NvbkA4NDA0MGFjIHsKCQkJY29tcGF0aWJsZSA9
ICJicmNtLGJyY21zdGItc3VuLXRvcC1jdHJsLWdlbmVyYWwtY3RybC1uby1zY2FuLTJcMHN5
c2NvbiI7CgkJCXJlZyA9IDwweDg0MDQwYWMgMHgwND47CgkJCWxpbnV4LHBoYW5kbGUgPSA8
MHgxMD47CgkJCXBoYW5kbGUgPSA8MHgxMD47CgkJfTsKCgkJaW50ZXJydXB0LWNvbnRyb2xs
ZXJAODQwYTQwMCB7CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgwMT47CgkJCWNvbXBhdGli
bGUgPSAiYnJjbSxiY203MjcxLWwyLWludGMiOwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPDB4
MDE+OwoJCQlyZWcgPSA8MHg4NDBhNDAwIDB4MjA+OwoJCQlpbnRlcnJ1cHQtY29udHJvbGxl
cjsKCQkJaW50ZXJydXB0cyA9IDwweDAwIDB4NWEgMHgwND47CgkJCWludGVycnVwdC1uYW1l
cyA9ICJ1cGdfbWFpbiI7CgkJCWJyY20saXJxLWNhbi13YWtlOwoJCQlsaW51eCxwaGFuZGxl
ID0gPDB4MGM+OwoJCQlwaGFuZGxlID0gPDB4MGM+OwoJCX07CgoJCWludGVycnVwdC1jb250
cm9sbGVyQDg0MWEzODAgewoJCQkjaW50ZXJydXB0LWNlbGxzID0gPDB4MDE+OwoJCQljb21w
YXRpYmxlID0gImJyY20sYmNtNzI3MS1sMi1pbnRjIjsKCQkJaW50ZXJydXB0LXBhcmVudCA9
IDwweDAxPjsKCQkJcmVnID0gPDB4ODQxYTM4MCAweDIwPjsKCQkJaW50ZXJydXB0LWNvbnRy
b2xsZXI7CgkJCWludGVycnVwdHMgPSA8MHgwMCAweDViIDB4MDQ+OwoJCQlpbnRlcnJ1cHQt
bmFtZXMgPSAidXBnX21haW5fYW9uIjsKCQkJYnJjbSxpcnEtY2FuLXdha2U7CgkJCWxpbnV4
LHBoYW5kbGUgPSA8MHgwZD47CgkJCXBoYW5kbGUgPSA8MHgwZD47CgkJfTsKCgkJaW50ZXJy
dXB0LWNvbnRyb2xsZXJAODQwYTQ0MCB7CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgwMT47
CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxiY203MjcxLWwyLWludGMiOwoJCQlpbnRlcnJ1cHQt
cGFyZW50ID0gPDB4MDE+OwoJCQlyZWcgPSA8MHg4NDBhNDQwIDB4MjA+OwoJCQlpbnRlcnJ1
cHQtY29udHJvbGxlcjsKCQkJaW50ZXJydXB0cyA9IDwweDAwIDB4NTggMHgwND47CgkJCWlu
dGVycnVwdC1uYW1lcyA9ICJ1cGdfYnNjIjsKCQkJbGludXgscGhhbmRsZSA9IDwweDE3PjsK
CQkJcGhhbmRsZSA9IDwweDE3PjsKCQl9OwoKCQlpbnRlcnJ1cHQtY29udHJvbGxlckA4NDFh
M2MwIHsKCQkJI2ludGVycnVwdC1jZWxscyA9IDwweDAxPjsKCQkJY29tcGF0aWJsZSA9ICJi
cmNtLGJjbTcyNzEtbDItaW50YyI7CgkJCWludGVycnVwdC1wYXJlbnQgPSA8MHgwMT47CgkJ
CXJlZyA9IDwweDg0MWEzYzAgMHgyMD47CgkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQlp
bnRlcnJ1cHRzID0gPDB4MDAgMHg1OSAweDA0PjsKCQkJaW50ZXJydXB0LW5hbWVzID0gInVw
Z19ic2NfYW9uIjsKCQkJYnJjbSxpcnEtY2FuLXdha2U7CgkJCWxpbnV4LHBoYW5kbGUgPSA8
MHgxOD47CgkJCXBoYW5kbGUgPSA8MHgxOD47CgkJfTsKCgkJaW50ZXJydXB0LWNvbnRyb2xs
ZXJAODQxOTAwMCB7CgkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgwMT47CgkJCWNvbXBhdGli
bGUgPSAiYnJjbSxiY203MjcxLWwyLWludGMiOwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPDB4
MDE+OwoJCQlyZWcgPSA8MHg4NDE5MDAwIDB4MjA+OwoJCQlpbnRlcnJ1cHQtY29udHJvbGxl
cjsKCQkJaW50ZXJydXB0cyA9IDwweDAwIDB4NWUgMHgwND47CgkJCWludGVycnVwdC1uYW1l
cyA9ICJ1cGdfc3BpIjsKCQkJYnJjbSxpcnEtY2FuLXdha2U7CgkJCWxpbnV4LHBoYW5kbGUg
PSA8MHgxNT47CgkJCXBoYW5kbGUgPSA8MHgxNT47CgkJfTsKCgkJd2F0Y2hkb2dAODQwYTYy
OCB7CgkJCWNsb2NrcyA9IDwweDEyPjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcwMzgt
d2R0IjsKCQkJcmVnID0gPDB4ODQwYTYyOCAweDE0PjsKCQl9OwoKCQlic3BAODNiMDAwMCB7
CgkJCSNhZGRyZXNzLWNlbGxzID0gPDB4MDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwweDAxPjsK
CQkJY29tcGF0aWJsZSA9ICJicmNtLGJzcC12Mi41LjFcMGJyY20sYnNwIjsKCQkJcmVnID0g
PDB4ODNiMDAwMCAweDQwMDA+OwoJCQlyYW5nZXM7CgkJfTsKCgkJbXNwaUA4NDE4MDAwIHsK
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MHgwMT47CgkJCSNzaXplLWNlbGxzID0gPDB4MDA+OwoJ
CQljbG9ja3MgPSA8MHgxMj47CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxzcGktYmNtNzIxNi1x
c3BpXDBicmNtLHNwaS1iY203NDQ1LXFzcGlcMGJyY20sc3BpLWJjbS1xc3BpXDBicmNtLHNw
aS1icmNtc3RiLW1zcGkiOwoJCQlyZWcgPSA8MHg4NDE4MDAwIDB4MTgwPjsKCQkJcmVnLW5h
bWVzID0gIm1zcGkiOwoJCQlpbnRlcnJ1cHRzID0gPDB4MDA+OwoJCQlpbnRlcnJ1cHQtcGFy
ZW50ID0gPDB4MTU+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAibXNwaV9kb25lIjsKCQl9OwoK
CQlwd21AODQwODAwMCB7CgkJCSNwd20tY2VsbHMgPSA8MHgwMj47CgkJCWNsb2NrcyA9IDww
eDEyPjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcwMzgtcHdtXDBicmNtLGJyY21zdGIt
cHdtIjsKCQkJcmVnID0gPDB4ODQwODAwMCAweDI4PjsKCQl9OwoKCQlncHVAOTcwMDAwMCB7
CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxiY203MjE2LWdwdVwwYnJjbSxncHUtdjQuMy4xOC4w
IjsKCQkJcmVnID0gPDB4OTcwMDAwMCAweDIwMDEwIDB4OTczMDAyMCAweDE4PjsKCQkJcmVn
LW5hbWVzID0gInYzZFwwYnBjbSI7CgkJCWludGVycnVwdHMgPSA8MHgwMCAweDYzIDB4MDQg
MHgwMCAweDY0IDB4MDQ+OwoJCQlpbnRlcnJ1cHQtbmFtZXMgPSAidjNkXDB2M2RfaHViIjsK
CQl9OwoKCQlncHUtbW11QDk3MDUwMDAgewoJCQljb21wYXRpYmxlID0gImJyY20sYmNtNzIx
Ni12M2RcMGJyY20sdjNkLXY0LjMuMTguMCI7CgkJfTsKCgkJc3lzY29uQDk5MTAwMDAgewoJ
CQljb21wYXRpYmxlID0gImJyY20sYmNtNzIxNi1tZW1jLWR0dS1tYXBcMGJyY20sbWVtYy1k
dHUtbWFwLXYxLjEuMC4wXDBicmNtLGJyY21zdGItbWVtYy1kdHUtbWFwXDBzeXNjb24iOwoJ
CQlyZWcgPSA8MHg5OTEwMDAwIDB4MTAwMDA+OwoJCX07CgoJCXN5c2NvbkA5OTA5MDAwIHsK
CQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcyMTYtbWVtYy1kdHUtY29uZmlnXDBicmNtLG1l
bWMtZHR1LWNvbmZpZy12MS4xLjAuMFwwYnJjbSxicmNtc3RiLW1lbWMtZHR1LWNvbmZpZ1ww
c3lzY29uIjsKCQkJcmVnID0gPDB4OTkwOTAwMCAweDYwMD47CgkJfTsKCgkJZHBmZS1jcHVA
OTkzMjAwMCB7CgkJCWNvbXBhdGlibGUgPSAiYnJjbSxiY203MjE2LWRwZmUtY3B1XDBicmNt
LGRwZmUtY3B1IjsKCQkJcmVnID0gPDB4OTkzMjAwMCAweDFhMCAweDk5MzQwMDAgMHgxMDAw
IDB4OTkzODAwMCAweDQwMDA+OwoJCQlyZWctbmFtZXMgPSAiZHBmZS1jcHVcMGRwZmUtZG1l
bVwwZHBmZS1pbWVtIjsKCQl9OwoKCQlybmdAODQwMjAwMCB7CgkJCWNvbXBhdGlibGUgPSAi
YnJjbSxiY203MjE2LXJuZzIwMFwwYnJjbSxpcHJvYy1ybmcyMDAiOwoJCQlyZWcgPSA8MHg4
NDAyMDAwIDB4Mjg+OwoJCX07CgoJCXJlc2V0LWNvbnRyb2xsZXJAODQwNDMxOCB7CgkJCSNy
ZXNldC1jZWxscyA9IDwweDAxPjsKCQkJY29tcGF0aWJsZSA9ICJicmNtLGJjbTcyMTYtcmVz
ZXRcMGJyY20sYnJjbXN0Yi1yZXNldCI7CgkJCXJlZyA9IDwweDg0MDQzMTggMHgzMD47CgkJ
fTsKCgkJc3lzY29uQDg0YTI0MDAgewoJCQljb21wYXRpYmxlID0gImJyY20sYmNtNzIxNi1j
cHUtYml1LWN0cmxcMGJyY20sYnJjbXN0Yi1jcHUtYml1LWN0cmxcMHN5c2NvbiI7CgkJCXJl
ZyA9IDwweDg0YTI0MDAgMHg0MDA+OwoJCQlicmNtLHdyaXRlLXBhaXJpbmc7CgkJCWxpbnV4
LHBoYW5kbGUgPSA8MHgxYj47CgkJCXBoYW5kbGUgPSA8MHgxYj47CgkJfTsKCgkJc3lzY29u
QDg0NTIwMDAgewoJCQljb21wYXRpYmxlID0gImJyY20sYnJjbXN0Yi1oaWYtY29udGludWF0
aW9uXDBzeXNjb24iOwoJCQlyZWcgPSA8MHg4NDUyMDAwIDB4MWM+OwoJCQlsaW51eCxwaGFu
ZGxlID0gPDB4MWM+OwoJCQlwaGFuZGxlID0gPDB4MWM+OwoJCX07CgoJCXZyZWctd2lmaS1w
d3IgewoJCX07CgoJCXZyZWctd2xhbi1wd3IgewoJCX07Cgl9OwoKCXJlYm9vdCB7CgkJY29t
cGF0aWJsZSA9ICJicmNtLGJyY21zdGItcmVib290IjsKCQlzeXNjb24gPSA8MHgxNiAweDMw
NCAweDMwOD47Cgl9OwoKCXBtdSB7CgkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWE1My1w
bXVcMGFybSxhcm12OC1wbXV2MyI7CgkJaW50ZXJydXB0cyA9IDwweDAwIDB4MDQgMHhmMDQg
MHgwMCAweDA1IDB4ZjA0IDB4MDAgMHgwNiAweGYwNCAweDAwIDB4MDcgMHhmMDQ+OwoJCWlu
dGVycnVwdC1uYW1lcyA9ICJjcHVfcG11aXJxXzBcMGNwdV9wbXVpcnFfMVwwY3B1X3BtdWly
cV8yXDBjcHVfcG11aXJxXzMiOwoJfTsKCgluZXh1cy13YWtldXBzIHsKCQlpbnRlcnJ1cHRz
ID0gPDB4MDAgMHgwMSAweDAyIDB4MDUgMHgwOD47CgkJaW50ZXJydXB0LXBhcmVudCA9IDww
eDBhPjsKCQlpbnRlcnJ1cHQtbmFtZXMgPSAiY2VjXDBpcnJcMGtwZFwwZ3Bpb1wweHB0X3Bt
dSI7Cgl9OwoKCW5leHVzLXVwZ19tYWluX2lycSB7CgkJaW50ZXJydXB0cyA9IDwweDAwIDB4
MDEgMHgwMj47CgkJaW50ZXJydXB0LXBhcmVudCA9IDwweDBjPjsKCQlpbnRlcnJ1cHQtbmFt
ZXMgPSAiZ2lvXDBpcmJcMHNwYXJlXzAwIjsKCX07CgoJbmV4dXMtdXBnX21haW5fYW9uX2ly
cSB7CgkJaW50ZXJydXB0cyA9IDwweDAwIDB4MDQgMHgwMSAweDAyIDB4MDMgMHgwNT47CgkJ
aW50ZXJydXB0LXBhcmVudCA9IDwweDBkPjsKCQlpbnRlcnJ1cHQtbmFtZXMgPSAiZ2lvXDBp
Y2FwXDBrYmQxXDBrYmQyXDBrYmQzXDBzcGFyZV8wMCI7Cgl9OwoKCW5leHVzLXVwZ19ic2Nf
aXJxIHsKCQlpbnRlcnJ1cHRzID0gPDB4MDAgMHgwMT47CgkJaW50ZXJydXB0LXBhcmVudCA9
IDwweDE3PjsKCQlpbnRlcnJ1cHQtbmFtZXMgPSAiaWljYVwwc3BhcmVfMDAiOwoJfTsKCglu
ZXh1cy11cGdfYnNjX2Fvbl9pcnEgewoJCWludGVycnVwdHMgPSA8MHgwMCAweDAxIDB4MDI+
OwoJCWludGVycnVwdC1wYXJlbnQgPSA8MHgxOD47CgkJaW50ZXJydXB0LW5hbWVzID0gImlp
Y2JcMGlpY2NcMHNwYXJlXzAwIjsKCX07CgoJbmV4dXMtdXBnX3NwaV9hb25faXJxIHsKCQlp
bnRlcnJ1cHRzID0gPDB4MDEgMHgwMD47CgkJaW50ZXJydXB0LXBhcmVudCA9IDwweDE1PjsK
CQlpbnRlcnJ1cHQtbmFtZXMgPSAic3BhcmVfMDBcMHNwaSI7Cgl9OwoKCXBjaWVAOGIyMDAw
MCB7CgkJYnJjbSxzY2Itc2l6ZXMgPSA8MHgwMSAweDAwPjsKCQlkbWEtcmFuZ2VzID0gPDB4
NDMwMDAwMDAgMHgwMSAweDAwIDB4MDAgMHg0MDAwMDAwMCAweDAxIDB4MDA+OwoJCXJhbmdl
cyA9IDwweDIwMDAwMDAgMHgwMCAweGY4MDAwMDAwIDB4MDAgMHgzODAwMDAwMCAweDAwIDB4
NDAwMDAwMCAweDQyMDAwMDAwIDB4MDAgMHhmYzAwMDAwMCAweDAwIDB4M2MwMDAwMDAgMHgw
MCAweDNmMDAwMDA+OwoJCXJlc2V0cyA9IDwweDBlPjsKCQlyZXNldC1uYW1lcyA9ICJyZXNj
YWwiOwoJCXJlZyA9IDwweDAwIDB4OGIyMDAwMCAweDAwIDB4YzcwND47CgkJaW50ZXJydXB0
cyA9IDwweDAwIDB4NGUgMHgwNCAweDAwIDB4NGYgMHgwND47CgkJaW50ZXJydXB0LW5hbWVz
ID0gInBjaWVcMG1zaSI7CgkJYXNwbS1uby1sMHM7CgkJZGV2aWNlX3R5cGUgPSAicGNpIjsK
CQltc2ktY29udHJvbGxlcjsKCQltc2ktcGFyZW50ID0gPDB4MWE+OwoJCSNhZGRyZXNzLWNl
bGxzID0gPDB4MDM+OwoJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgwMT47CgkJI3NpemUtY2Vs
bHMgPSA8MHgwMj47CgkJYnVzLXJhbmdlID0gPDB4MDAgMHhmZj47CgkJY29tcGF0aWJsZSA9
ICJicmNtLGJjbTcyMTYtcGNpZVwwYnJjbSxiY203NDQ1LXBjaWVcMGJyY20scGNpLXBsYXQt
ZGV2IjsKCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHgwMCAweDAwIDB4MDAgMHgwNz47CgkJ
dG90LW51bS1wY2llID0gPDB4MDI+OwoJCWxpbnV4LHBjaS1kb21haW4gPSA8MHgwMT47CgkJ
aW50ZXJydXB0LW1hcCA9IDwweDAwIDB4MDAgMHgwMCAweDAxIDB4MDEgMHgwMCAweDRhIDB4
MDQgMHgwMCAweDAwIDB4MDAgMHgwMiAweDAxIDB4MDAgMHg0YiAweDA0IDB4MDAgMHgwMCAw
eDAwIDB4MDMgMHgwMSAweDAwIDB4NGMgMHgwNCAweDAwIDB4MDAgMHgwMCAweDA0IDB4MDEg
MHgwMCAweDRkIDB4MDQ+OwoJCWNsb2NrcyA9IDwweDA5IDB4ZjE+OwoJCWNsb2NrLW5hbWVz
ID0gInN3X3BjaWUiOwoJCWxpbnV4LHBoYW5kbGUgPSA8MHgxYT47CgkJcGhhbmRsZSA9IDww
eDFhPjsKCgkJcGNpQDEsMCB7CgkJCWxvY2FsLW1hYy1hZGRyZXNzID0gWzAwIDEwIDE4IGFj
IDBiIDlmXTsKCQkJcmVnID0gPDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMD47CgkJCSNhZGRy
ZXNzLWNlbGxzID0gPDB4MDM+OwoJCQkjc2l6ZS1jZWxscyA9IDwweDAyPjsKCgkJCXBjaUAx
LDAsMCB7CgkJCQlyZWcgPSA8MHgwMCAweDAwIDB4MDAgMHgwMCAweDAwPjsKCQkJfTsKCQl9
OwoJfTsKCgluZXh1cy11cGdfYXV4X2Fvbl9pbnRyMiB7CgkJaW50ZXJydXB0cyA9IDwweDA0
IDB4MDUgMHgwNiAweDAwIDB4MDEgMHgwMiAweDAzIDB4MDg+OwoJCWludGVycnVwdC1wYXJl
bnQgPSA8MHgxMz47CgkJaW50ZXJydXB0LW5hbWVzID0gImJpY2FwX2ZpZm9faW5hY3RfaW50
clwwYmljYXBfZmlmb19sdmxfaW50clwwYmljYXBfZmlmb19vZl9pbnRyXDBiaWNhcF90aW1l
b3V0MF9pbnRyXDBiaWNhcF90aW1lb3V0MV9pbnRyXDBiaWNhcF90aW1lb3V0Ml9pbnRyXDBi
aWNhcF90aW1lb3V0M19pbnRyXDB3a3Rtcl9hbGFybV9pbnRyIjsKCX07CgoJYm9sdCB7CgkJ
cG1hcCA9IDwweDAyPjsKCQl2ZXJzaW9uID0gPDB4MTAwNDc+OwoJCWRhdGUgPSAiMjAyMS0w
NC0xNiAxMzowMDoxMiI7CgkJdXNlciA9ICJmZjk0NDg0NEBzdGJpcnYtbG54LTMiOwoJCXRh
ZyA9ICJ2MS43MS1wcmUxLTE2LWc1MTM3Yjc0YjE5MmMiOwoJCWJvYXJkID0gIkJDWDk3MjE2
MERWIjsKCQlmYW1pbHktaWQgPSA8MHg3MjE2MDAxMD47CgkJcHJvZHVjdC1pZCA9IDwweDcy
MTYwMTA+OwoJCWJvYXJkLWlkID0gPDB4MTk+OwoJCWJveCA9IFszMSAwMF07CgkJcnRzID0g
ImRlcHJlY2F0ZWRfZm9ybWF0X2JveDEiOwoJCWJvb3RkZXYgPSAic3BpIjsKCQlkdC1jb21w
YXQgPSA8MHgwMT47CgkJcG1pYzAtcmVzZXQtbGlzdCA9ICJXRFRFWFBfU0hEV04iOwoJCXJl
c2V0LWxpc3QgPSAic29mdHdhcmVfbWFzdGVyIjsKCQlyZXNldC1oaXN0b3J5ID0gPDB4MjAw
PjsKCQl0aW1lci13ZG9nID0gPDB4ODQwYTYwMD47Cgl9OwoKCWludGVycnVwdC1jb250cm9s
bGVyQDIwMDAwMCB7CgkJY29tcGF0aWJsZSA9ICJhcm0sY29ydGV4LWExNS1naWMiOwoJCWlu
dGVycnVwdC1jb250cm9sbGVyOwoJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgwMz47CgkJcmVn
ID0gPDB4MDAgMHgyMDEwMDAgMHgwMCAweDEwMDAgMHgwMCAweDIwMjAwMCAweDAwIDB4MjAw
MD47CgkJcmVnLW5hbWVzID0gImRpc3RcMGNwdSI7CgkJbGludXgscGhhbmRsZSA9IDwweDAx
PjsKCQlwaGFuZGxlID0gPDB4MDE+OwoJfTsKCglzbXBib290IHsKCQljb21wYXRpYmxlID0g
ImJyY20sYnJjbXN0Yi1zbXBib290IjsKCQlzeXNjb24tY3B1ID0gPDB4MWIgMHhjNCAweDhj
PjsKCQlzeXNjb24tY29udCA9IDwweDFjPjsKCX07CgoJc3JhbUAxMDAwMDAgewoJCWNvbXBh
dGlibGUgPSAiYnJjbSxib290LXNyYW1cMG1taW8tc3JhbSI7CgkJcmVnID0gPDB4MDAgMHgx
MDAwMDAgMHgwMCAweDE4MDAwPjsKCX07CgoJczMgewoJCXN5c2Nvbi1yZWZzID0gPDB4MWQg
MHgxZSAweDFmIDB4MjAgMHgyMSAweDIyIDB4MjMgMHgyNCAweDI1IDB4MjYgMHgyNyAweDI4
IDB4MTA+OwoJfTsKfTsK
--------------295375603EEC5FD178306FC5--
