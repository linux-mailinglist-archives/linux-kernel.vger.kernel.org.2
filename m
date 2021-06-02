Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF32398178
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFBGzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:55:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3335 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhFBGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:55:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw04b1B33z19S77;
        Wed,  2 Jun 2021 14:49:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:46 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:53:46 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/7] ARM: mm: cleanup page fault and fix pxn process issue
Date:   Wed, 2 Jun 2021 15:02:39 +0800
Message-ID: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset cleanup ARM page fault handle to improve readability,
fix the page table entries printing and fix infinite loop in the
page fault handler when user code execution with privilege mode if
ARM_LPAE enabled.

echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT

Before:
-------
 lkdtm: Performing direct entry EXEC_USERSPACE
 lkdtm: attempting ok execution at c0717674
 lkdtm: attempting bad execution at b6fd6000
 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:	1-....: (2100 ticks this GP) idle=7e2/1/0x40000002 softirq=136/136 fqs=1050 
	(t=2101 jiffies g=-1027 q=16)
 NMI backtrace for cpu 1
 CPU: 1 PID: 57 Comm: sh Not tainted 5.13.0-rc4 #126
 ...
  r9:c1f04000 r8:c0e04cc8 r7:c1f05cbc r6:ffffffff r5:60000113 r4:c03724f8
 [<c03722e0>] (handle_mm_fault) from [<c02152f4>] (do_page_fault+0x1a0/0x3d8)
  r10:c180ec48 r9:c11b1aa0 r8:c11b1ac0 r7:8000020f r6:b6fd6000 r5:c180ec00
  r4:c1f05df8
 [<c0215154>] (do_page_fault) from [<c02157cc>] (do_PrefetchAbort+0x40/0x94)
  r10:0000000f r9:c1f04000 r8:c1f05df8 r7:b6fd6000 r6:c0215154 r5:0000020f
  r4:c0e09b18
 [<c021578c>] (do_PrefetchAbort) from [<c0200c50>] (__pabt_svc+0x50/0x80)
 Exception stack(0xc1f05df8 to 0xc1f05e40)
 5de0: 0000002b 2e34f000
 5e00: 3ee77213 3ee77213 b6fd6000 c0b51020 c140d000 c0a4b5dc 0000000f c1f05f58
 5e20: 0000000f c1f05e64 c1f05d88 c1f05e48 c0717a6c b6fd6000 60000013 ffffffff
  r8:0000000f r7:c1f05e2c r6:ffffffff r5:60000013 r4:b6fd6000
 [<c07179a8>] (lkdtm_EXEC_USERSPACE) from [<c09a51b8>] (lkdtm_do_action+0x48/0x4c)
  r4:00000027
 ...


After:
-------
 lkdtm: Performing direct entry EXEC_USERSPACE
 lkdtm: attempting ok execution at c07176d4
 lkdtm: attempting bad execution at b6f57000
 8<--- cut here ---
 Unable to handle kernel execution of user memory at virtual address b6f57000
 pgd = 81e20f00
 [b6f57000] *pgd=81e23003, *pmd=13ee9c003
 Internal error: Oops: 8000020f [#1] SMP ARM
 Modules linked in:
 CPU: 0 PID: 57 Comm: sh Not tainted 5.13.0-rc4+ #127
 Hardware name: ARM-Versatile Express
 PC is at 0xb6f57000
 LR is at lkdtm_EXEC_USERSPACE+0xc4/0xd4
 pc : [<b6f57000>]    lr : [<c0717acc>]    psr: 60000013
 sp : c1f3de48  ip : c1f3dd88  fp : c1f3de64
 r10: 0000000f  r9 : c1f3df58  r8 : 0000000f
 r7 : c0a4b5dc  r6 : c1f1d000  r5 : c0b51070  r4 :b6f57000
 r3 : 7e62f7da  r2 : 7e62f7da  r1 : 2e330000  r0 :0000002b
 Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
 ...

v2:
- split patch into smaller changes suggested by Russell
- fix page table printing in show_pte()
- add new die_kernel_fault() helper 
- report "execution of user memory" when user code execution with
  privilege mode


Kefeng Wang (7):
  ARM: mm: Rafactor the __do_page_fault()
  ARM: mm: Kill task_struct argument for __do_page_fault()
  ARM: mm: Cleanup access_error()
  ARM: mm: print out correct page table entries
  ARM: mm: Print physical address of page table base in show_pte()
  ARM: mm: Provide die_kernel_fault() helper
  ARM: mm: Fix PXN process with LPAE feature

 arch/arm/include/asm/bug.h |   2 +-
 arch/arm/kernel/traps.c    |   2 +-
 arch/arm/mm/fault.c        | 145 ++++++++++++++++++-------------------
 3 files changed, 74 insertions(+), 75 deletions(-)

-- 
2.26.2

