Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0F740895C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhIMKuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:50:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19033 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbhIMKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:50:36 -0400
Received: from dggeml763-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7NRF0wh4zbmSm;
        Mon, 13 Sep 2021 18:45:13 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggeml763-chm.china.huawei.com (10.1.199.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 18:49:17 +0800
From:   Peng Liu <liupeng256@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <liupeng256@huawei.com>
Subject: [PATCH] mm/mmap.c: fix a data race of mm->total_vm
Date:   Mon, 13 Sep 2021 10:55:50 +0000
Message-ID: <20210913105550.1569419-1-liupeng256@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeml763-chm.china.huawei.com (10.1.199.173)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable mm->total_vm could be accessed concurrently during mmaping
and system accounting as noticed by KCSAN,

BUG: KCSAN: data-race in __acct_update_integrals / mmap_region

read-write to 0xffffa40267bd14c8 of 8 bytes by task 15609 on cpu 3:
 mmap_region+0x6dc/0x1400
 do_mmap+0x794/0xca0
 vm_mmap_pgoff+0xdf/0x150
 ksys_mmap_pgoff+0xe1/0x380
 do_syscall_64+0x37/0x50
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffa40267bd14c8 of 8 bytes by interrupt on cpu 2:
 __acct_update_integrals+0x187/0x1d0
 acct_account_cputime+0x3c/0x40
 update_process_times+0x5c/0x150
 tick_sched_timer+0x184/0x210
 __run_hrtimer+0x119/0x3b0
 hrtimer_interrupt+0x350/0xaa0
 __sysvec_apic_timer_interrupt+0x7b/0x220
 asm_call_irq_on_stack+0x12/0x20
 sysvec_apic_timer_interrupt+0x4d/0x80
 asm_sysvec_apic_timer_interrupt+0x12/0x20
 smp_call_function_single+0x192/0x2b0
 perf_install_in_context+0x29b/0x4a0
 __se_sys_perf_event_open+0x1a98/0x2550
 __x64_sys_perf_event_open+0x63/0x70
 do_syscall_64+0x37/0x50
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 2 PID: 15610 Comm: syz-executor.3 Not tainted 5.10.0+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014

In vm_stat_account which called by mmap_region, increase total_vm,
and __acct_update_integrals may read total_vm at the same time.
This will cause a data race which lead to undefined behaviour. To
avoid potential bad read/write, volatile property and barrier are
both used to avoid undefined behaviour.

Signed-off-by: Peng Liu <liupeng256@huawei.com>
---
 kernel/tsacct.c | 2 +-
 mm/mmap.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 257ffb993ea2..f00de83d0246 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -137,7 +137,7 @@ static void __acct_update_integrals(struct task_struct *tsk,
 	 * the rest of the math is done in xacct_add_tsk.
 	 */
 	tsk->acct_rss_mem1 += delta * get_mm_rss(tsk->mm) >> 10;
-	tsk->acct_vm_mem1 += delta * tsk->mm->total_vm >> 10;
+	tsk->acct_vm_mem1 += delta * READ_ONCE(tsk->mm->total_vm) >> 10;
 }
 
 /**
diff --git a/mm/mmap.c b/mm/mmap.c
index 181a113b545d..5f9bcfa29835 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3356,7 +3356,7 @@ bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags, unsigned long npages)
 
 void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 {
-	mm->total_vm += npages;
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);
 
 	if (is_exec_mapping(flags))
 		mm->exec_vm += npages;
-- 
2.18.0.huawei.25

