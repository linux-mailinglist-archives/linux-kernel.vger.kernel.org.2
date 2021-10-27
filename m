Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E752143C6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbhJ0JvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:51:05 -0400
Received: from foss.arm.com ([217.140.110.172]:41400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232462AbhJ0JvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:51:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6461FB;
        Wed, 27 Oct 2021 02:48:39 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 968C43F70D;
        Wed, 27 Oct 2021 02:48:35 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, anshuman.khandual@arm.com, ardb@kernel.org,
        david@redhat.com, gshan@redhat.com, justin.he@arm.com,
        jianyong.wu@arm.com, nd@arm.com
Subject: [PATCH v1] arm64/mm: avoid race condition of update page table when kernel init
Date:   Wed, 27 Oct 2021 17:48:28 +0800
Message-Id: <20211027094828.7629-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Race condition of page table update can happen in kernel boot period as
both of memory hotplug action when kernel init and the mark_rodata_ro can
update page table. For virtio-mem, the function excute flow chart is:

-------------------------
kernel_init
  kernel_init_freeable
    ...
      do_initcall
        ...
          module_init [A]

  ...
  mark_readonly
    mark_rodata_ro [B]
-------------------------
virtio-mem can be initialized at [A] and spwan a workqueue to add
memory, therefore the race of update page table can happen inside [B].

What's more, the race condition can happen even for ACPI based memory
hotplug, as it can burst into kernel boot period while page table is
updating inside mark_rodata_ro.

That's why memory hotplug lock is needed to guard mark_rodata_ro to avoid
the race condition.

It may only happen in arm64. As fixmap, which is the global resource, is
used in page table creating. So, the change is only for arm64.

The error often occurs inside alloc_init_pud() in arch/arm64/mm/mmu.c

the race condition flow is:

*************** begin ************

kerenl_init                                 virtio-mem workqueue
=========                                   ========
alloc_init_pud(...)
  pudp = pud_set_fixmap_offset(..)          alloc_init_pud(...)
...                                         ...
    READ_ONCE(*pudp) //OK!                    pudp = pud_set_fixmap_offset(
...                                         ...
  pud_clear_fixmap() //fixmap break
                                              READ_ONCE(*pudp) //CRASH!

**************** end *************

I catch the related error when test virtio-mem (a new memory hotplug
driver) on arm64.

How to reproduce:
(1) prepare a kernel with virtio-mem enabled on arm64
(2) start a VM using Cloud Hypervisor using the kernel above
(3) hotplug memory, 20G in my case, with virtio-mem
(4) reboot or start a new kernel using kexec

Test for server times, you may find the error below:

[    1.131039] Unable to handle kernel paging request at virtual address fffffbfffda3b140
[    1.134504] Mem abort info:
[    1.135722]   ESR = 0x96000007
[    1.136991]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.139189]   SET = 0, FnV = 0
[    1.140467]   EA = 0, S1PTW = 0
[    1.141755]   FSC = 0x07: level 3 translation fault
[    1.143787] Data abort info:
[    1.144976]   ISV = 0, ISS = 0x00000007
[    1.146554]   CM = 0, WnR = 0
[    1.147817] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000426f2000
[    1.150551] [fffffbfffda3b140] pgd=0000000042ffd003, p4d=0000000042ffd003, pud=0000000042ffe003, pmd=0000000042fff003, pte=0000000000000000
[    1.155728] Internal error: Oops: 96000007 [#1] SMP
[    1.157724] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G         C        5.15.0-rc3+ #100
[    1.161002] Hardware name: linux,dummy-virt (DT)
[    1.162939] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.165825] pc : alloc_init_pud+0x38c/0x550
[    1.167610] lr : alloc_init_pud+0x394/0x550
[    1.169358] sp : ffff80001001bd10
......
[    1.200527] Call trace:
[    1.201583]  alloc_init_pud+0x38c/0x550
[    1.203218]  __create_pgd_mapping+0x94/0xe0
[    1.204983]  update_mapping_prot+0x50/0xd8
[    1.206730]  mark_rodata_ro+0x50/0x58
[    1.208281]  kernel_init+0x3c/0x120
[    1.209760]  ret_from_fork+0x10/0x20
[    1.211298] Code: eb15003f 54000061 d5033a9f d5033fdf (f94000a1)
[    1.213856] ---[ end trace 59473413ffe3f52d ]---
[    1.215850] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

We can see that the error derived from the l3 translation as the pte
value is *0*. That is because the fixmap has been clear when access.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 arch/arm64/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb347c3..567dfba8f08a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -564,8 +564,10 @@ void mark_rodata_ro(void)
 	 * to cover NOTES and EXCEPTION_TABLE.
 	 */
 	section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
+	get_online_mems();
 	update_mapping_prot(__pa_symbol(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
+	put_online_mems();
 
 	debug_checkwx();
 }
-- 
2.17.1

