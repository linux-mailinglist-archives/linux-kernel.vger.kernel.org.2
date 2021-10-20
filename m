Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ECD434348
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 04:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJTCKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 22:10:07 -0400
Received: from foss.arm.com ([217.140.110.172]:55502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhJTCKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 22:10:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC42B1FB;
        Tue, 19 Oct 2021 19:07:48 -0700 (PDT)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E6023F70D;
        Tue, 19 Oct 2021 19:07:45 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     akpm@linux-foundation.org, mhiramat@kernel.org,
        peterz@infradead.org
Cc:     rostedt@goodmis.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        david@redhat.com, anshuman.khandual@arm.com, justin.he@arm.com,
        jianyong.wu@arm.com, nd@arm.com
Subject: [PATCH v1] init: avoid race condition of update page table in kernel init
Date:   Wed, 20 Oct 2021 10:07:12 +0800
Message-Id: <20211020020712.90240-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Race condition of page table update can happen in kernel_init as
both of memory hotplug module init and the following mark_rodata_ro can
update page table. The function excute flow chart is:

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
[A] can contains memory hotplug init therefore both [A] and [B] can
update page table at the same time that may lead to race. Here we
introduce memory hotplug lock to guard mark_rodata_ro to avoid the race
condition.

I catch the related error when test virtio-mem (a new memory hotplug
driver) on arm64 and may be a potential bug for other arches.

How to reproduce on arm64:
(1) prepare a kernel with virtio-mem enabled on arm64
(2) start a VM using Cloud Hypervisor[1] using the kernel above
(3) hotplug memory, 20G in my case, with virtio-mem
(4) reboot or load new kernel using kexec

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

[1] https://github.com/cloud-hypervisor/cloud-hypervisor

Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 init/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/main.c b/init/main.c
index 81a79a77db46..290c9882ba9e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1471,7 +1471,9 @@ static void mark_readonly(void)
 		 * insecure pages which are W+X.
 		 */
 		rcu_barrier();
+		get_online_mems();
 		mark_rodata_ro();
+		put_online_mems();
 		rodata_test();
 	} else
 		pr_info("Kernel memory protection disabled.\n");
-- 
2.17.1

