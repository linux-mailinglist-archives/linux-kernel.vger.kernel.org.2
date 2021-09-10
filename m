Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE3C406746
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhIJGlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:41:25 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16249 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:41:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H5R7G6DbGz8t2K;
        Fri, 10 Sep 2021 14:39:38 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 14:40:10 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 14:40:09 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <rppt@kernel.org>, <akpm@linux-foundation.org>,
        <anshuman.khandual@arm.com>, <nsaenz@kernel.org>,
        <geert+renesas@glider.be>, <kirill.shtuemov@linux.intel.com>,
        <mick@ics.forth.gr>, <rmk+kernel@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2] arm64: kdump: Skip kmemleak scan reserved memory for kdump
Date:   Fri, 10 Sep 2021 14:48:44 +0800
Message-ID: <20210910064844.3827813-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to boot with kdump + kmemleak, command will result in a crash:
"echo scan > /sys/kernel/debug/kmemleak"

crashkernel reserved: 0x0000000007c00000 - 0x0000000027c00000 (512 MB)
Kernel command line: BOOT_IMAGE=(hd1,gpt2)/vmlinuz-5.14.0-rc5-next-20210809+ root=/dev/mapper/ao-root ro rd.lvm.lv=ao/root rd.lvm.lv=ao/swap crashkernel=512M
Unable to handle kernel paging request at virtual address ffff000007c00000
Mem abort info:
  ESR = 0x96000007
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000007
  CM = 0, WnR = 0
swapper pgtable: 64k pages, 48-bit VAs, pgdp=00002024f0d80000
[ffff000007c00000] pgd=1800205ffffd0003, p4d=1800205ffffd0003, pud=1800205ffffd0003, pmd=1800205ffffc0003, pte=0068000007c00f06
Internal error: Oops: 96000007 [#1] SMP
pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : scan_block+0x98/0x230
lr : scan_block+0x94/0x230
sp : ffff80008d6cfb70
x29: ffff80008d6cfb70 x28: 0000000000000000 x27: 0000000000000000
x26: 00000000000000c0 x25: 0000000000000001 x24: 0000000000000000
x23: ffffa88a6b18b398 x22: ffff000007c00ff9 x21: ffffa88a6ac7fc40
x20: ffffa88a6af6a830 x19: ffff000007c00000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffffffffffffffff
x14: ffffffff00000000 x13: ffffffffffffffff x12: 0000000000000020
x11: 0000000000000000 x10: 0000000001080000 x9 : ffffa88a6951c77c
x8 : ffffa88a6a893988 x7 : ffff203ff6cfb3c0 x6 : ffffa88a6a52b3c0
x5 : ffff203ff6cfb3c0 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff20226cb56a40 x0 : 0000000000000000
Call trace:
 scan_block+0x98/0x230
 scan_gray_list+0x120/0x270
 kmemleak_scan+0x3a0/0x648
 kmemleak_write+0x3ac/0x4c8
 full_proxy_write+0x6c/0xa0
 vfs_write+0xc8/0x2b8
 ksys_write+0x70/0xf8
 __arm64_sys_write+0x24/0x30
 invoke_syscall+0x4c/0x110
 el0_svc_common+0x9c/0x190
 do_el0_svc+0x30/0x98
 el0_svc+0x28/0xd8
 el0t_64_sync_handler+0x90/0xb8
 el0t_64_sync+0x180/0x184

The reserved memory for kdump will be looked up by kmemleak, this area
will be set invalid when kdump service is bring up. That will result in
crash when kmemleak scan this area.

Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b16be52233c6..82fa0a2b544e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -30,6 +30,7 @@
 #include <linux/crash_dump.h>
 #include <linux/hugetlb.h>
 #include <linux/acpi_iort.h>
+#include <linux/kmemleak.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -101,6 +102,11 @@ static void __init reserve_crashkernel(void)
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
 
+	/*
+	 * The crashkernel memory will be removed from the kernel linear
+	 * map. Inform kmemleak so that it won't try to access it.
+	 */
+	kmemleak_ignore_phys(crash_base);
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-- 
2.18.0.huawei.25

