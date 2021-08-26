Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387343F83B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhHZIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:23:34 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15254 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbhHZIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:23:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GwG6q3b4wz89bY;
        Thu, 26 Aug 2021 16:22:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 16:22:43 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 16:22:41 +0800
Subject: [BUG] amba: Remove deferred device addition
To:     Saravana Kannan <saravanak@google.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
 <20210816074619.177383-4-wangkefeng.wang@huawei.com>
 <CAL_JsqLBddXVeP-t++wqPNp=xYF7tvEcnCbjFnK9CUBLK2+9JA@mail.gmail.com>
 <CAGETcx8SY14rcd7g=Gdwmw7sUMb=jdEV+ffuNpg6btDoL1jmWw@mail.gmail.com>
 <ee649111-dc07-d6db-8872-dcb692802236@huawei.com>
 <CAGETcx9drOdE_vfn-nhDZM9MbgxGxYJN6ydiAVxo_Ltqve9eTg@mail.gmail.com>
 <b5eb935f-26e1-6475-63af-e7f6101eb017@huawei.com>
 <CAGETcx9yaWZOzt=gcyNAshoHdPoYizhmrKS-kU9c2QM2+HqeEw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <df8e7756-8b0d-d7de-a9ff-3f6eb0ffa8a5@huawei.com>
Date:   Thu, 26 Aug 2021 16:22:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx9yaWZOzt=gcyNAshoHdPoYizhmrKS-kU9c2QM2+HqeEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Btw, I've been working on [1] cleaning up the one-off deferred probe
>>> solution that we have for amba devices. That causes a bunch of other
>>> headaches. Your patch 3/3 takes us further in the wrong direction by
>>> adding more reasons for delaying the addition of the device.

Hi Saravana, I try the link[1], but with it, there is a crash when boot 
(qemu-system-arm -M vexpress-a15),

without it, boot successfully.

[    2.246057] aaci-pl041 1c040000.aaci: ARM AC'97 Interface PL041 rev0 
at 0x1c040000, irq 36
[    2.246357] aaci-pl041 1c040000.aaci: FIFO 512 entries
[    2.248617] NET: Registered PF_PACKET protocol family
[    2.250481] 9pnet: Installing 9P2000 support
[    2.251474] Registering SWP/SWPB emulation handler
[    2.284374] 1c090000.serial: ttyAMA0 at MMIO 0x1c090000 (irq = 41, 
base_baud = 0) is a PL011 rev1
[    2.287797] printk: console [ttyAMA0] enabled
[    2.287797] printk: console [ttyAMA0] enabled
[    2.288262] input: AT Raw Set 2 keyboard as 
/devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:motherboard-bus:iofpga-bus@300000000/1c060000.kmi/serio0/input/input0
[    2.288262] input: AT Raw Set 2 keyboard as 
/devices/platform/bus@8000000/bus@8000000:motherboard-bus/bus@8000000:motherboard-bus:iofpga-bus@300000000/1c060000.kmi/serio0/input/input0
[    2.288755] printk: bootconsole [earlycon0] disabled
[    2.288755] printk: bootconsole [earlycon0] disabled
[    2.294507] 1c0a0000.serial: ttyAMA1 at MMIO 0x1c0a0000 (irq = 42, 
base_baud = 0) is a PL011 rev1
[    2.296950] 1c0b0000.serial: ttyAMA2 at MMIO 0x1c0b0000 (irq = 43, 
base_baud = 0) is a PL011 rev1
[    2.298636] 1c0c0000.serial: ttyAMA3 at MMIO 0x1c0c0000 (irq = 44, 
base_baud = 0) is a PL011 rev1
[    2.300496] 8<--- cut here ---
[    2.300775] ------------[ cut here ]------------
[    2.301260] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[    2.300928] WARNING: CPU: 1 PID: 27 at 
/home/wkf/work/hulk/lib/refcount.c:25 refcount_warn_saturate+0x108/0x174
[    2.301700] pgd = (ptrval)
[    2.302002] refcount_t: addition on 0; use-after-free.
[    2.302184] [00000000] *pgd=00000000
[    2.302363] Modules linked in:
[    2.302384]
[    2.302753]
[    2.303501] CPU: 1 PID: 27 Comm: kworker/u4:1 Not tainted 5.14.0-rc7+ 
#193
[    2.303990] Hardware name: ARM-Versatile Express
[    2.304198] Internal error: Oops: 5 [#1] SMP ARM
[    2.304537] Workqueue: events_unbound deferred_probe_work_func
[    2.304829] Modules linked in:
[    2.304865]
[    2.305133]
[    2.305401] Backtrace:
[    2.305562] CPU: 0 PID: 41 Comm: kworker/0:2 Not tainted 5.14.0-rc7+ #193
[    2.305614] Hardware name: ARM-Versatile Express
[    2.305576]
[    2.305781] [<c010c780>] (dump_backtrace) from [<c010cacc>] 
(show_stack+0x20/0x24)
[    2.306266] Workqueue: events_long serio_handle_event
[    2.306732]  r7:00000009 r6:00000000 r5:c0b1efb8 r4:600b0093
[    2.306889] PC is at strcmp+0x18/0x44
[    2.307115] [<c010caac>] (show_stack) from [<c091eba4>] 
(dump_stack_lvl+0x48/0x54)
[    2.307263] LR is at platform_match+0xb8/0xcc
[    2.307498] [<c091eb5c>] (dump_stack_lvl) from [<c091ebc8>] 
(dump_stack+0x18/0x1c)
[    2.307739] pc : [<c0560aec>]    lr : [<c064626c>]    psr: 60000013
[    2.307988]  r5:c0b4ef98 r4:c165ddc4
[    2.308317] sp : c1675d70  ip : c1675d80  fp : c1675d7c
[    2.308433] [<c091ebb0>] (dump_stack) from [<c01289c4>] 
(__warn+0x110/0x114)
[    2.308743] r10: 00000000  r9 : 00000000  r8 : 00000001
[    2.308961] [<c01288b4>] (__warn) from [<c0128a4c>] 
(warn_slowpath_fmt+0x84/0xc0)
[    2.309252] r7 : c0d04d08  r6 : c13aed18  r5 : c1090fc0  r4 : c13aed18
[    2.309547]  r9:00000009 r8:c0504f10 r7:00000019 r6:c0b4ef98 
r5:c0b4efbc r4:c0d04d08
[    2.309975] [<c01289cc>] (warn_slowpath_fmt) from [<c0504f10>] 
(refcount_warn_saturate+0x108/0x174)
[    2.310531] r3 : c0a5e1c0  r2 : 00000002  r1 : c0b82860  r0 : 00000000
[    2.311263] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment none
[    2.311298]  r9:600b0013 r8:00000000 r7:00000000 r6:c1787eb8 
r5:c165de3c r4:c1702b38
[    2.311899] Control: 10c5387d  Table: 8000406a  DAC: 00000051
[    2.312117] [<c0504e08>] (refcount_warn_saturate) from [<c055657c>] 
(klist_next+0x134/0x138)
[    2.312755] Register r0 information:
[    2.312964] [<c0556448>] (klist_next) from [<c06411dc>] 
(bus_for_each_drv+0x74/0xc8)
[    2.313345]  NULL pointer
[    2.313690] Register r1 information:
[    2.313736]  r9:00000000 r8:00000001 r7:c0d04d08 r6:c064373c 
r5:c165de6c r4:00000000
[    2.313933]  non-slab/vmalloc memory
[    2.314172] [<c0641168>] (bus_for_each_drv) from [<c0642f38>] 
(__device_attach+0xf0/0x15c)
[    2.315042]  r7:c10846b8 r6:c13ae444 r5:c13ae400 r4:c0d04d08
[    2.315060] Register r2 information:
[    2.315243] [<c0642e48>] (__device_attach) from [<c064390c>] 
(device_initial_probe+0x1c/0x20)
[    2.315276]  non-paged memory
[    2.315569]  r8:00000000 r7:c10846b8 r6:c13ae400 r5:c107d690 r4:c13ae400
[    2.315593] [<c06438f0>] (device_initial_probe) from [<c0642080>] 
(bus_probe_device+0x94/0x9c)
[    2.316192] [<c0641fec>] (bus_probe_device) from [<c064259c>] 
(deferred_probe_work_func+0x8c/0xb8)
[    2.316939]  r7:c10846b8 r6:c10846a4 r5:c10846a4 r4:c13ae400
[    2.317573] [<c0642510>] (deferred_probe_work_func) from [<c01475a4>] 
(process_one_work+0x238/0x594)
[    2.318513]  r9:00000000 r8:00000000 r7:c1225b00 r6:c1206200 
r5:c16b6f80 r4:c10846d4
[    2.318931] Register r3 information: non-slab/vmalloc memory
[    2.319218] [<c014736c>] (process_one_work) from [<c0147bc4>] 
(worker_thread+0x2c4/0x5f4)
[    2.320001]  r10:c0d03d00 r9:00000088 r8:ffffe000 r7:c1206218 
r6:c16b6f94 r5:c1206200
[    2.320280] Register r4 information:
[    2.320614]  r4:c16b6f80
[    2.320942] [<c0147900>] (worker_thread) from [<c014feb4>] 
(kthread+0x178/0x194)
[    2.321111]  slab kmalloc-1k
[    2.321403]  r10:c165c000 r9:c1313e74 r8:00000000 r7:c16b6f80 
r6:c0147900 r5:c16b5580
[    2.321391]  start c13aec00 pointer offset 280
[    2.321993]  r4:c13d4980
[    2.322006]  size 1024
[    2.322176] [<c014fd3c>] (kthread) from [<c0100150>] 
(ret_from_fork+0x14/0x24)
[    2.323165] Exception stack(0xc165dfb0 to 0xc165dff8)
[    2.323187]
[    2.323371] Register r5 information: non-slab/vmalloc memory
[    2.323535] Register r6 information: slab kmalloc-1k start c13aec00 
pointer offset 280 size 1024
[    2.324594] Register r7 information:
[    2.324597] dfa0:                                     00000000 
00000000 00000000 00000000
[    2.325507]  non-slab/vmalloc memory
[    2.325830] Register r8 information: non-paged memory
[    2.326267] Register r9 information:
[    2.326274] dfc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.326453]  NULL pointer
[    2.326942] Register r10 information: NULL pointer
[    2.327159] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.327258] Register r11 information: non-slab/vmalloc memory
[    2.327904] Register r12 information:
[    2.327928]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c014fd3c
[    2.327937]  non-slab/vmalloc memory
[    2.328057] Process kworker/0:2 (pid: 41, stack limit = 0x(ptrval))
[    2.328204] Stack: (0xc1675d70 to 0xc1676000)
[    2.328479]  r4:c16b5580
[    2.329851] ---[ end trace f293b13f591ee203 ]---
[    2.330027] 5d60:                                     c1675d9c 
c1675d80 c064626c c0560ae0
[    2.331070] 5d80: c1090fc0 c1675df4 c13aed18 c0d04d08 c1675dbc 
c1675da0 c0643778 c06461c0
[    2.331120] 8<--- cut here ---
[    2.331739] Unhandled fault: page domain fault (0x01b) at 0x00000010
[    2.331915] 5da0: 00000000 c1675df4 c064373c c0d04d08 c1675dec 
c1675dc0 c06411d0 c0643748
[    2.332379] pgd = (ptrval)
[    2.332408] 5dc0: c1675dec c16bf06c c1787eb8 76076098 c0d04d08 
c13aed18 c13aed5c c13aa800
[    2.332889] [00000010] *pgd=00000000
[    2.332951] 5de0: c1675e24 c1675df0 c0642f38 c0641174 c1675e44 
c13aed18 00000001 76076098
[    2.333535] 5e00: 00000000 c13aed18 c108ea84 c13aed18 c13aa800 
c10843a0 c1675e34 c1675e28
[    2.334201] 5e20: c064390c c0642e54 c1675e54 c1675e38 c0642080 
c06438fc c13aed18 00000000
[    2.334845] 5e40: c0d04d08 c13aa800 c1675eb4 c1675e58 c063fa1c 
c0641ff8 c13a5180 c1706380
[    2.335464] 5e60: eee2e0c0 c1201180 c071c008 c11ea558 c0b7f260 
c0b7f28c c1675eb4 c1675e88
[    2.336088] 5e80: c02e6368 76076098 00000001 c1706f4c c13aec00 
c108ea54 c1706f40 c11ea558
[    2.336758] 5ea0: c0b7f260 c0b7f28c c1675ef4 c1675eb8 c071c0e4 
c063f620 c0923300 c0158300
[    2.337399] 5ec0: 00000000 c13aed18 c1675ef4 c108ea70 c1702e80 
effc4400 effc7700 00000000
[    2.338025] 5ee0: 00000000 c10b2580 c1675f34 c1675ef8 c01475a4 
c071bf38 c13a5100 ffffe000
[    2.338663] 5f00: c1675f1c c1675f10 c0149250 c1702e80 effc4400 
c1702e94 effc4418 ffffe000
[    2.339296] 5f20: 00000008 c0d03d00 c1675f74 c1675f38 c014795c 
c0147378 c130fe74 c0b0c2c4
[    2.340102] 5f40: c10b1d2a effc4400 c1675f74 c1706000 c1706880 
c0147900 c1702e80 00000000
[    2.340736] 5f60: c130fe74 c1674000 c1675fac c1675f78 c014feb4 
c014790c c1706024 c1706024
[    2.341315] 5f80: c1675fac c1706880 c014fd3c 00000000 00000000 
00000000 00000000 00000000
[    2.341852] 5fa0: 00000000 c1675fb0 c0100150 c014fd48 00000000 
00000000 00000000 00000000
[    2.342407] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.342957] 5fe0: 00000000 00000000 00000000 00000000 00000013 
00000000 00000000 00000000
[    2.343361] Backtrace:
[    2.343573] [<c0560ad4>] (strcmp) from [<c064626c>] 
(platform_match+0xb8/0xcc)
[    2.343954] [<c06461b4>] (platform_match) from [<c0643778>] 
(__device_attach_driver+0x3c/0xc4)
[    2.344369]  r7:c0d04d08 r6:c13aed18 r5:c1675df4 r4:c1090fc0
[    2.344615] [<c064373c>] (__device_attach_driver) from [<c06411d0>] 
(bus_for_each_drv+0x68/0xc8)
[    2.345015]  r7:c0d04d08 r6:c064373c r5:c1675df4 r4:00000000
[    2.345283] [<c0641168>] (bus_for_each_drv) from [<c0642f38>] 
(__device_attach+0xf0/0x15c)
[    2.345654]  r7:c13aa800 r6:c13aed5c r5:c13aed18 r4:c0d04d08
[    2.345903] [<c0642e48>] (__device_attach) from [<c064390c>] 
(device_initial_probe+0x1c/0x20)
[    2.346325]  r8:c10843a0 r7:c13aa800 r6:c13aed18 r5:c108ea84 r4:c13aed18
[    2.346635] [<c06438f0>] (device_initial_probe) from [<c0642080>] 
(bus_probe_device+0x94/0x9c)
[    2.347038] [<c0641fec>] (bus_probe_device) from [<c063fa1c>] 
(device_add+0x408/0x8b8)
[    2.347419]  r7:c13aa800 r6:c0d04d08 r5:00000000 r4:c13aed18
[    2.347695] [<c063f614>] (device_add) from [<c071c0e4>] 
(serio_handle_event+0x1b8/0x234)
[    2.348094]  r10:c0b7f28c r9:c0b7f260 r8:c11ea558 r7:c1706f40 
r6:c108ea54 r5:c13aec00
[    2.348453]  r4:c1706f4c
[    2.348604] [<c071bf2c>] (serio_handle_event) from [<c01475a4>] 
(process_one_work+0x238/0x594)
[    2.348968]  r10:c10b2580 r9:00000000 r8:00000000 r7:effc7700 
r6:effc4400 r5:c1702e80
[    2.349315]  r4:c108ea70
[    2.349468] [<c014736c>] (process_one_work) from [<c014795c>] 
(worker_thread+0x5c/0x5f4)
[    2.349875]  r10:c0d03d00 r9:00000008 r8:ffffe000 r7:effc4418 
r6:c1702e94 r5:effc4400
[    2.350169]  r4:c1702e80
[    2.350315] [<c0147900>] (worker_thread) from [<c014feb4>] 
(kthread+0x178/0x194)
[    2.350687]  r10:c1674000 r9:c130fe74 r8:00000000 r7:c1702e80 
r6:c0147900 r5:c1706880
[    2.351038]  r4:c1706000
[    2.351182] [<c014fd3c>] (kthread) from [<c0100150>] 
(ret_from_fork+0x14/0x24)
[    2.351500] Exception stack(0xc1675fb0 to 0xc1675ff8)
[    2.351855] 5fa0:                                     00000000 
00000000 00000000 00000000
[    2.352415] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.352923] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.353283]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c014fd3c
[    2.353618]  r4:c1706880
[    2.354146] Code: e24cb004 ea000001 e3530000 0a000006 (e4d03001)
[    2.354860] Internal error: : 1b [#2] SMP ARM
[    2.355172] Modules linked in:
[    2.355254] ---[ end trace f293b13f591ee204 ]---
[    2.355650] CPU: 1 PID: 27 Comm: kworker/u4:1 Tainted: G      D 
W         5.14.0-rc7+ #193
[    2.355888] Kernel panic - not syncing: Fatal exception
[    2.355990] Hardware name: ARM-Versatile Express
[    2.356735] Workqueue: events_unbound deferred_probe_work_func
[    2.357217] PC is at klist_put+0x20/0xa4
[    2.357537] LR is at klist_iter_exit+0x24/0x30
[    2.357872] pc : [<c0556280>]    lr : [<c0556340>]    psr: a00b0013
[    2.358299] sp : c165de00  ip : c165de20  fp : c165de1c
[    2.358655] r10: c10b2580  r9 : 00000000  r8 : 00000001
[    2.359009] r7 : c1702b38  r6 : 00000000  r5 : c165de6c  r4 : 00000000
[    2.359440] r3 : 00000000  r2 : 76076098  r1 : 00000000  r0 : 00000000
[    2.359893] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment none
[    2.360368] Control: 10c5387d  Table: 8177806a  DAC: 00000051
[    2.360759] Register r0 information: NULL pointer
[    2.361126] Register r1 information: NULL pointer
[    2.361477] Register r2 information: non-paged memory
[    2.361835] Register r3 information: NULL pointer
[    2.362162] Register r4 information: NULL pointer
[    2.362486] Register r5 information: non-slab/vmalloc memory
[    2.362887] Register r6 information: NULL pointer
[    2.363226] Register r7 information: slab kmalloc-128 start c1702b00 
pointer offset 56 size 128
[    2.363919] Register r8 information: non-paged memory
[    2.364299] Register r9 information: NULL pointer
[    2.364668] Register r10 information: non-slab/vmalloc memory
[    2.365089] Register r11 information: non-slab/vmalloc memory
[    2.365466] Register r12 information: non-slab/vmalloc memory
[    2.365872] Process kworker/u4:1 (pid: 27, stack limit = 0x(ptrval))
[    2.366297] Stack: (0xc165de00 to 0xc165e000)
[    2.366769] de00: c165de3c c165de6c c064373c c0d04d08 c165de34 
c165de20 c0556340 c055626c
[    2.367478] de20: 00000000 c165de6c c165de64 c165de38 c0641208 
c0556328 c165de64 c136996c
[    2.368192] de40: c1702b38 76076098 c0d04d08 c13ae400 c13ae444 
c10846b8 c165de9c c165de68
[    2.368934] de60: c0642f38 c0641174 c063c4c4 c13ae400 00000001 
76076098 00000000 c13ae400
[    2.369654] de80: c107d690 c13ae400 c10846b8 00000000 c165deac 
c165dea0 c064390c c0642e54
[    2.370367] dea0: c165decc c165deb0 c0642080 c06438fc c13ae400 
c10846a4 c10846a4 c10846b8
[    2.371046] dec0: c165def4 c165ded0 c064259c c0641ff8 c10846d4 
c16b6f80 c1206200 c1225b00
[    2.371774] dee0: 00000000 00000000 c165df34 c165def8 c01475a4 
c064251c c13906c0 ffffe000
[    2.372470] df00: c165df1c c165df10 c0149250 c16b6f80 c1206200 
c16b6f94 c1206218 ffffe000
[    2.373189] df20: 00000088 c0d03d00 c165df74 c165df38 c0147bc4 
c0147378 c1313e74 c0b0c2c4
[    2.373925] df40: c10b1d2a c1206200 c165df74 c13d4980 c16b5580 
c0147900 c16b6f80 00000000
[    2.374628] df60: c1313e74 c165c000 c165dfac c165df78 c014feb4 
c014790c c13d49a4 c13d49a4
[    2.375345] df80: c165dfac c16b5580 c014fd3c 00000000 00000000 
00000000 00000000 00000000
[    2.376080] dfa0: 00000000 c165dfb0 c0100150 c014fd48 00000000 
00000000 00000000 00000000
[    2.376807] dfc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.377534] dfe0: 00000000 00000000 00000000 00000000 00000013 
00000000 00000000 00000000
[    2.378080] Backtrace:
[    2.378297] [<c0556260>] (klist_put) from [<c0556340>] 
(klist_iter_exit+0x24/0x30)
[    2.378819]  r7:c0d04d08 r6:c064373c r5:c165de6c r4:c165de3c
[    2.379199] [<c055631c>] (klist_iter_exit) from [<c0641208>] 
(bus_for_each_drv+0xa0/0xc8)
[    2.379701]  r5:c165de6c r4:00000000
[    2.379932] [<c0641168>] (bus_for_each_drv) from [<c0642f38>] 
(__device_attach+0xf0/0x15c)
[    2.380482]  r7:c10846b8 r6:c13ae444 r5:c13ae400 r4:c0d04d08
[    2.380871] [<c0642e48>] (__device_attach) from [<c064390c>] 
(device_initial_probe+0x1c/0x20)
[    2.381453]  r8:00000000 r7:c10846b8 r6:c13ae400 r5:c107d690 r4:c13ae400
[    2.381851] [<c06438f0>] (device_initial_probe) from [<c0642080>] 
(bus_probe_device+0x94/0x9c)
[    2.382364] [<c0641fec>] (bus_probe_device) from [<c064259c>] 
(deferred_probe_work_func+0x8c/0xb8)
[    2.382936]  r7:c10846b8 r6:c10846a4 r5:c10846a4 r4:c13ae400
[    2.383266] [<c0642510>] (deferred_probe_work_func) from [<c01475a4>] 
(process_one_work+0x238/0x594)
[    2.383885]  r9:00000000 r8:00000000 r7:c1225b00 r6:c1206200 
r5:c16b6f80 r4:c10846d4
[    2.384344] [<c014736c>] (process_one_work) from [<c0147bc4>] 
(worker_thread+0x2c4/0x5f4)
[    2.384893]  r10:c0d03d00 r9:00000088 r8:ffffe000 r7:c1206218 
r6:c16b6f94 r5:c1206200
[    2.385341]  r4:c16b6f80
[    2.385536] [<c0147900>] (worker_thread) from [<c014feb4>] 
(kthread+0x178/0x194)
[    2.386030]  r10:c165c000 r9:c1313e74 r8:00000000 r7:c16b6f80 
r6:c0147900 r5:c16b5580
[    2.386540]  r4:c13d4980
[    2.386742] [<c014fd3c>] (kthread) from [<c0100150>] 
(ret_from_fork+0x14/0x24)
[    2.387211] Exception stack(0xc165dfb0 to 0xc165dff8)
[    2.387653] dfa0:                                     00000000 
00000000 00000000 00000000
[    2.388374] dfc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    2.389071] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.389546]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c014fd3c
[    2.390037]  r4:c16b5580
[    2.390376] Code: e1a07000 e1a06001 e3c44001 e1a00004 (e5945010)
[    2.390836] ---[ end trace f293b13f591ee205 ]---
[    2.391580] ---[ end Kernel panic - not syncing: Fatal exception ]---


>>> -Saravana
>>>
>>> [1] - https://lore.kernel.org/lkml/CAGETcx8b228nDUho3cX9AAQ-pXOfZTMv8cj2vhdx9yc_pk8q+A@mail.gmail.com/
>>> .
>>>
> .
>
