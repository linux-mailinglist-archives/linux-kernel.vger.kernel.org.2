Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293BF388A62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbhESJVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:21:22 -0400
Received: from foss.arm.com ([217.140.110.172]:55830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344849AbhESJVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97957101E;
        Wed, 19 May 2021 02:19:59 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C3D83F73D;
        Wed, 19 May 2021 02:19:58 -0700 (PDT)
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
To:     Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        heiko.stuebner@theobroma-systems.com, leobras.c@gmail.com,
        Rob Herring <robh@kernel.org>
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
 <09cbf655-0f13-5df6-b6a9-4a6a784e211d@suse.com>
 <94fbb521-d045-3c2e-eeb8-4029e1f92015@suse.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <d754c000-7eb1-a8ed-33a6-238171a68c87@arm.com>
Date:   Wed, 19 May 2021 10:20:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <94fbb521-d045-3c2e-eeb8-4029e1f92015@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/19/21 8:05 AM, Qu Wenruo wrote:
>
>
> On 2021/5/19 下午2:28, Qu Wenruo wrote:
>>
>>
>> On 2021/5/18 下午5:09, Alexandru Elisei wrote:
>>> After doing a git bisect I was able to trace the following error when booting my
>>> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
>>
>> I'm also hitting the same problem, with a RockPi 4B board.
>>
>> [...]
>>> [    0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
>>> [    0.393311] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>>> [    0.393333] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
>>> [    0.393356] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
>>> [    0.393375] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000
>>> 64bit]
>>
>> The same error here.
>>
>>> [    0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
>>> [    0.393839] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
>>> [    0.394165] pcieport 0000:00:00.0: AER: enabled with IRQ 78
>>> [..]
>>>
>>> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for
>>> 64-bit memory addresses"). For reference, here is the dmesg output when BAR
>>> reassignment works:
>>
>> Great thanks for the pinning down the bug, at least I can try to boot my board
>> again with the patch reverted.
>
> Although after reverting, the kernel just BUG_ON() when alternatives try to
> patch the kernel:
>
> [    0.175009] alternatives: patching kernel code
> [    0.175640] ------------[ cut here ]------------
> [    0.176260] kernel BUG at arch/arm64/kernel/alternative.c:157!
> [    0.177080] Internal error: Oops - BUG: 0 [#1] SMP
> [    0.177579] Modules linked in:
> [    0.177910] CPU: 0 PID: 12 Comm: migration/0 Not tainted 5.13.0-rc2-custom+ #11
> [    0.178665] Hardware name: Radxa ROCK Pi 4B (DT)
> [    0.179137] Stopper: multi_cpu_stop+0x0/0x1bc <- stop_cpus.constprop.0+0x98/0xf0
> [    0.179927] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
> [    0.180546] pc : __apply_alternatives+0x21c/0x254
> [    0.181047] lr : __apply_alternatives+0x100/0x254
> [    0.181538] sp : ffff800012b0fca0
> [    0.181883] x29: ffff800012b0fca0 x28: ffff800010011128 x27: ffff80001001112c
> [    0.182633] x26: ffff8000114dfec4 x25: 00000000001b0020 x24: ffff800011212368
> [    0.183377] x23: 0000000000000000 x22: ffff800011b041e6 x21: ffff800012b0fd20
> [    0.184125] x20: ffff800012b0fd30 x19: ffff8000114dfec8 x18: 0000000000000030
> [    0.184872] x17: 0000000025e8361a x16: 000000004a78ba60 x15: ffff0000020e1cd0
> [    0.185623] x14: ffff8000118dc548 x13: 0000000000000000 x12: 000000000000016b
> [    0.186370] x11: 0000000000000079 x10: ffff80001198c548 x9 : 00000000ffffe000
> [    0.187115] x8 : 80000000ffffe000 x7 : ffff8000118dc548 x6 : 0000000000005ffd
> [    0.187861] x5 : 0000000000000000 x4 : ffff8000100242b0 x3 : ffffffffffffffc0
> [    0.188606] x2 : ffff8000114fbb54 x1 : 0000000000000004 x0 : 0000000000000000
> [    0.189353] Call trace:
> [    0.189612]  __apply_alternatives+0x21c/0x254
> [    0.190073]  __apply_alternatives_multi_stop+0xc4/0xdc
> [    0.190610]  multi_cpu_stop+0xa8/0x1bc
> [    0.191007]  cpu_stopper_thread+0xb0/0x144
> [    0.191439]  smpboot_thread_fn+0x130/0x240
> [    0.191884]  kthread+0x13c/0x140
> [    0.192226]  ret_from_fork+0x10/0x30
> [    0.192616] Code: aa1c03e1 aa1a03e0 97ffff27 17ffffb8 (d4210000)
> [    0.193268] ---[ end trace d8c66e3e26751651 ]---
> [    0.193746] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [    0.194395] SMP: stopping secondary CPUs
> [    1.361467] SMP: failed to stop secondary CPUs 0-5
> [    1.361980] Rebooting in 5 seconds..
> [    6.362979] SMP: stopping secondary CPUs
> [    7.530049] SMP: failed to stop secondary CPUs 0-5
>
> Is there anything special needed to boot the kernel with that offending commit
> reverted?

I believe this is a separate bug which is being investigated [1].

Things that I tried:

1. Reverted the offending commit from v5.13-rc2, kernel booted.

2. Checkout out tag v5.13-rc1, reverted the offending commit from v5.13-rc1,
kernel hangs during boot. Didn't clean before building.

3. Did a clean and rebuild, kernel boots correctly. This seems to point at the
regression [1], since cleaning was one of the workarounds reported.

Another bug that I noticed is a kernel panic on shutdown, but that's unrelated to
the offending commit (I'll try to bisect it when I have the time).

[1] https://lkml.org/lkml/2021/5/17/2284

Thanks,

Alex

>
> Thanks,
> Qu
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> [..]
>>> [    0.307381] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
>>> [    0.307445] rockchip-pcie f8000000.pcie:      MEM
>>> 0x00fa000000..0x00fbdfffff ->
>>> 0x00fa000000
>>> [    0.307481] rockchip-pcie f8000000.pcie:       IO
>>> 0x00fbe00000..0x00fbefffff ->
>>> 0x00fbe00000
>>> [    0.308406] rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using
>>> dummy
>>> regulator
>>> [    0.308534] rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using
>>> dummy
>>> regulator
>>> [    0.374676] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
>>> [    0.374701] pci_bus 0000:00: root bus resource [bus 00-1f]
>>> [    0.374723] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
>>> [    0.374746] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
>>> address [0xfbe00000-0xfbefffff])
>>> [    0.374808] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
>>> [    0.374943] pci 0000:00:00.0: supports D1
>>> [    0.374961] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
>>> [    0.379473] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [    0.379712] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
>>> [    0.379815] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>>> [    0.379997] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
>>> [    0.380607] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
>>> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
>>> x4 link)
>>> [    0.394239] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
>>> [    0.394285] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
>>> [    0.394312] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff
>>> 64bit]
>>> [    0.394374] pci 0000:00:00.0: PCI bridge to [bus 01]
>>> [    0.394395] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
>>> [    0.394569] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>>> [    0.394845] pcieport 0000:00:00.0: PME: Signaling with IRQ 78
>>> [    0.395153] pcieport 0000:00:00.0: AER: enabled with IRQ 78
>>> [..]
>>>
>>> And here is the output of lspci when BAR reassignment works:
>>>
>>> # lspci -v
>>> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI Express Root
>>> Port (prog-if 00 [Normal decode])
>>>      Flags: bus master, fast devsel, latency 0, IRQ 78
>>>      Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>>      I/O behind bridge: 00000000-00000fff [size=4K]
>>>      Memory behind bridge: fa000000-fa0fffff [size=1M]
>>>      Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>>>      Capabilities: [80] Power Management version 3
>>>      Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>>>      Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
>>>      Capabilities: [c0] Express Root Port (Slot+), MSI 00
>>>      Capabilities: [100] Advanced Error Reporting
>>>      Capabilities: [274] Transaction Processing Hints
>>>      Kernel driver in use: pcieport
>>> lspci: Unable to load libkmod resources: error -2
>>>
>>> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD
>>> Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
>>>      Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
>>>      Flags: bus master, fast devsel, latency 0, IRQ 77, NUMA node 0
>>>      Memory at fa000000 (64-bit, non-prefetchable) [size=16K]
>>>      Capabilities: [40] Power Management version 3
>>>      Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>>      Capabilities: [70] Express Endpoint, MSI 00
>>>      Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
>>>      Capabilities: [100] Advanced Error Reporting
>>>      Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
>>>      Capabilities: [158] Power Budgeting <?>
>>>      Capabilities: [168] Secondary PCI Express
>>>      Capabilities: [188] Latency Tolerance Reporting
>>>      Capabilities: [190] L1 PM Substates
>>>      Kernel driver in use: nvme
>>>
>>> I can provide more information if needed (the board is sitting on my desk) and I
>>> can help with testing the fix.
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
