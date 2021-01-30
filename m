Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95C309318
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhA3JPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:15:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11952 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhA3JNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:13:50 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSQFc52g4zjFJ4;
        Sat, 30 Jan 2021 15:05:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 15:06:00 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <bhe@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <bhsharma@redhat.com>,
        <prabhakar.pkin@gmail.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <chenzhou10@huawei.com>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: [PATCH v14 00/11] support reserving crashkernel above 4G on arm64 kdump 
Date:   Sat, 30 Jan 2021 15:10:14 +0800
Message-ID: <20210130071025.65258-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which
will fail when there is no enough low memory.
2. If reserving crashkernel above 4G, in this case, crash dump
kernel will boot failure because there is no low memory available
for allocation.

To solve these issues, change the behavior of crashkernel=X.
crashkernel=X tries low allocation in DMA zone and fall back to high
allocation if it fails.

We can also use "crashkernel=X,high" to select a high region above
DMA zone, which also tries to allocate at least 256M low memory in
DMA zone automatically and "crashkernel=Y,low" can be used to allocate
specified size low memory.

When reserving crashkernel in high memory, some low memory is reserved
for crash dump kernel devices. So there may be two regions reserved for
crash dump kernel.
In order to distinct from the high region and make no effect to the use
of existing kexec-tools, rename the low region as "Crash kernel (low)",
and pass the low region by reusing DT property
"linux,usable-memory-range". We made the low memory region as the last
range of "linux,usable-memory-range" to keep compatibility with existing
user-space and older kdump kernels.

Besides, we need to modify kexec-tools:
arm64: support more than one crash kernel regions(see [1])

Another update is document about DT property 'linux,usable-memory-range':
schemas: update 'linux,usable-memory-range' node schema(see [2])

This patchset contains the following eleven patches:
0001-x86-kdump-replace-the-hard-coded-alignment-with-macr.patch
0002-x86-kdump-make-the-lower-bound-of-crash-kernel-reser.patch
0003-x86-kdump-use-macro-CRASH_ADDR_LOW_MAX-in-functions-.patch
0004-x86-kdump-move-xen_pv_domain-check-and-insert_resour.patch
0005-x86-kdump-move-reserve_crashkernel-_low-into-crash_c.patch
0006-x86-elf-Move-vmcore_elf_check_arch_cross-to-arch-x86.patch
0007-arm64-kdump-introduce-some-macroes-for-crash-kernel-.patch
0008-arm64-kdump-reimplement-crashkernel-X.patch
0009-x86-arm64-Add-ARCH_WANT_RESERVE_CRASH_KERNEL-config.patch
0010-arm64-kdump-add-memory-for-devices-by-DT-property-li.patch
0011-kdump-update-Documentation-about-crashkernel.patch

0001-0004 are some x86 cleanups which prepares for making
functionsreserve_crashkernel[_low]() generic.
0005 makes functions reserve_crashkernel[_low]() generic.
0006 fix compiling warning.
0007-0009 reimplements arm64 crashkernel=X.
0010 adds memory for devices by DT property linux,usable-memory-range.
0011 updates the doc.

Changes since [v13]
- Rebased on top of 5.11-rc5.
- Introduce config CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL.
Since reserve_crashkernel[_low]() implementations are quite similar on
other architectures, so have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in
arch/Kconfig and select this by X86 and ARM64.
- Some minor cleanup.

Changes since [v12]
- Rebased on top of 5.10-rc1.
- Keep CRASH_ALIGN as 16M suggested by Dave.
- Drop patch "kdump: add threshold for the required memory".
- Add Tested-by from John.

Changes since [v11]
- Rebased on top of 5.9-rc4.
- Make the function reserve_crashkernel() of x86 generic.
Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
and arm64 use the generic version to reimplement crashkernel=X.

Changes since [v10]
- Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.

Changes since [v9]
- Patch 1 add Acked-by from Dave.
- Update patch 5 according to Dave's comments.
- Update chosen schema.

Changes since [v8]
- Reuse DT property "linux,usable-memory-range".
Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
memory region.
- Fix kdump broken with ZONE_DMA reintroduced.
- Update chosen schema.

Changes since [v7]
- Move x86 CRASH_ALIGN to 2M
Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
- Update Documentation/devicetree/bindings/chosen.txt.
Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
suggested by Arnd.
- Add Tested-by from Jhon and pk.

Changes since [v6]
- Fix build errors reported by kbuild test robot.

Changes since [v5]
- Move reserve_crashkernel_low() into kernel/crash_core.c.
- Delete crashkernel=X,high.
- Modify crashkernel=X,low.
If crashkernel=X,low is specified simultaneously, reserve spcified size low
memory for crash kdump kernel devices firstly and then reserve memory above 4G.
In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
pass to crash dump kernel by DT property "linux,low-memory-range".
- Update Documentation/admin-guide/kdump/kdump.rst.

Changes since [v4]
- Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.

Changes since [v3]
- Add memblock_cap_memory_ranges back for multiple ranges.
- Fix some compiling warnings.

Changes since [v2]
- Split patch "arm64: kdump: support reserving crashkernel above 4G" as
two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
patch.

Changes since [v1]:
- Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
- Remove memblock_cap_memory_ranges() i added in v1 and implement that
in fdt_enforce_memory_region().
There are at most two crash kernel regions, for two crash kernel regions
case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
and then remove the memory range in the middle.

[1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
[2]: https://github.com/robherring/dt-schema/pull/19 
[v1]: https://lkml.org/lkml/2019/4/2/1174
[v2]: https://lkml.org/lkml/2019/4/9/86
[v3]: https://lkml.org/lkml/2019/4/9/306
[v4]: https://lkml.org/lkml/2019/4/15/273
[v5]: https://lkml.org/lkml/2019/5/6/1360
[v6]: https://lkml.org/lkml/2019/8/30/142
[v7]: https://lkml.org/lkml/2019/12/23/411
[v8]: https://lkml.org/lkml/2020/5/21/213
[v9]: https://lkml.org/lkml/2020/6/28/73
[v10]: https://lkml.org/lkml/2020/7/2/1443
[v11]: https://lkml.org/lkml/2020/8/1/150
[v12]: https://lkml.org/lkml/2020/9/7/1037
[v13]: https://lkml.org/lkml/2020/10/31/34

Chen Zhou (11):
  x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
  x86: kdump: make the lower bound of crash kernel reservation
    consistent
  x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
    reserve_crashkernel()
  x86: kdump: move xen_pv_domain() check and insert_resource() to
    setup_arch()
  x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
  x86/elf: Move vmcore_elf_check_arch_cross to
    arch/x86/include/asm/elf.h
  arm64: kdump: introduce some macroes for crash kernel reservation
  arm64: kdump: reimplement crashkernel=X
  x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL config
  arm64: kdump: add memory for devices by DT property
    linux,usable-memory-range
  kdump: update Documentation about crashkernel

 Documentation/admin-guide/kdump/kdump.rst     |  22 ++-
 .../admin-guide/kernel-parameters.txt         |  11 +-
 arch/Kconfig                                  |   3 +
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/kexec.h                |  10 ++
 arch/arm64/kernel/setup.c                     |  13 +-
 arch/arm64/mm/init.c                          | 111 +++++-------
 arch/x86/Kconfig                              |   2 +
 arch/x86/include/asm/elf.h                    |   3 +
 arch/x86/include/asm/kexec.h                  |  31 +++-
 arch/x86/kernel/setup.c                       | 163 ++----------------
 include/linux/crash_core.h                    |   3 +
 include/linux/kexec.h                         |   2 -
 kernel/crash_core.c                           | 156 +++++++++++++++++
 kernel/kexec_core.c                           |  17 --
 15 files changed, 303 insertions(+), 245 deletions(-)

-- 
2.20.1

