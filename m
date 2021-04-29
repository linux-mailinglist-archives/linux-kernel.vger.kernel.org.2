Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A228336E533
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhD2G5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:57:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17406 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2G5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:57:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FW5pb0WXbzjcCj;
        Thu, 29 Apr 2021 14:54:47 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 29 Apr 2021 14:56:38 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Chen Huang" <chenhuang5@huawei.com>
Subject: [RFC PATCH] riscv: stacktrace: fix the riscv stacktrace when CONFIG_FRAME_POINTER enabled
Date:   Thu, 29 Apr 2021 07:03:48 +0000
Message-ID: <20210429070348.2167483-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As [1] and [2] said, the arch_stack_walk should not to trace itself, or it will
leave the trace unexpectedly when called. The example is when we do "cat
/sys/kernel/debug/page_owner", all pages' stack is the same.

arch_stack_walk+0x18/0x20
stack_trace_save+0x40/0x60
register_dummy_stack+0x24/0x5e
init_page_owner+0x2e

So we use __builtin_frame_address(1) as the first frame to be walked. And mark
the arch_stack_walk() noinline.

We found that pr_cont will affact pages' stack whose task state is RUNNING when
testing "echo t > /proc/sysrq-trigger". So move the place of pr_cont and mark
the function dump_backtrace() noinline.

Also we move the case when task == NULL into else branch, and test for it in
"echo c > /proc/sysrq-trigger".

[1] https://lore.kernel.org/lkml/20210319184106.5688-1-mark.rutland@arm.com/
[2] https://lore.kernel.org/lkml/20210317142050.57712-1-chenjun102@huawei.com/

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
In this way, some crash will loss the print info "Call trace:", likes that:
# echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
[   61.774690] lkdtm: Performing direct entry BUG
[   61.775350] ------------[ cut here ]------------
[   61.775611] kernel BUG at drivers/misc/lkdtm/bugs.c:76!
[   61.776073] Kernel BUG [#1]
[   61.776319] Modules linked in:
[   61.776696] CPU: 3 PID: 1 Comm: sh Not tainted 5.11.0-rc6-next-20210208-00013-gb16da2c3b9aa #132
[   61.777185] Hardware name: riscv-virtio,qemu (DT)
[   61.777594] epc : lkdtm_BUG+0x6/0x8
[   61.777916]  ra : lkdtm_do_action+0x14/0x1c
[   61.778212] epc : ffffffe00048a7e8 ra : ffffffe0006d71a8 sp : ffffffe07fedbd90
[   61.778646]  gp : ffffffe0012e4208 tp : ffffffe07fed0000 t0 : ffffffe0012f2097
[   61.779115]  t1 : ffffffe0012f2088 t2 : 0000000000000000 s0 : ffffffe07fedbda0
[   61.779588]  s1 : 0000000000000010 a0 : ffffffe000c7fbb8 a1 : ffffffe001284d28
[   61.780017]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : c10724222fbe9200
[   61.780473]  a5 : ffffffe00048a7e2 a6 : c0000000ffffefff a7 : 0000000000000064
[   61.780932]  s2 : ffffffe000c7fbc8 s3 : ffffffe000d9e3f8 s4 : ffffffe081969000
[   61.781405]  s5 : 000000000000004b s6 : 0000000000000004 s7 : ffffffe07fedbe80
[   61.781872]  s8 : 0000003ffff987e4 s9 : 0000002ab0b7ac50 s10: 0000002ab0bacb90
[   61.782336]  s11: 0000000000000000 t3 : 000000000000006c t4 : ffffffffffffffff
[   61.782794]  t5 : 0000000000000037 t6 : ffffffe07fedbae8
[   61.783158] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
[   61.783680] [<ffffffe00048a7e8>] lkdtm_BUG+0x6/0x8
[   61.784149] [<ffffffe0006d71a8>] lkdtm_do_action+0x14/0x1c
[   61.784516] [<ffffffe00048a5ee>] direct_entry+0xc0/0x10a
[   61.784849] [<ffffffe0002498ce>] full_proxy_write+0x42/0x6a
[   61.785209] [<ffffffe000114b7c>] vfs_write+0x7e/0x218
[   61.785562] [<ffffffe000114e84>] ksys_write+0x98/0xc0
[   61.785904] [<ffffffe000114eba>] sys_write+0xe/0x16
[   61.786275] [<ffffffe000003466>] ret_from_syscall+0x0/0x2
[   61.787175] ---[ end trace 6919e7283b64f492 ]---
[   61.787707] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   61.788270] SMP: stopping secondary CPUs
[   61.788934] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

 arch/riscv/kernel/stacktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 2b3e0cb90d78..bde85fc53357 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -27,10 +27,10 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		fp = frame_pointer(regs);
 		sp = user_stack_pointer(regs);
 		pc = instruction_pointer(regs);
-	} else if (task == NULL || task == current) {
-		fp = (unsigned long)__builtin_frame_address(0);
-		sp = sp_in_global;
-		pc = (unsigned long)walk_stackframe;
+	} else if (task == current) {
+		fp = (unsigned long)__builtin_frame_address(1);
+		sp = (unsigned long)__builtin_frame_address(0);
+		pc = (unsigned long)__builtin_return_address(0);
 	} else {
 		/* task blocked in __switch_to */
 		fp = task->thread.s[0];
@@ -106,15 +106,15 @@ static bool print_trace_address(void *arg, unsigned long pc)
 	return true;
 }
 
-void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
+noinline void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 		    const char *loglvl)
 {
-	pr_cont("%sCall Trace:\n", loglvl);
 	walk_stackframe(task, regs, print_trace_address, (void *)loglvl);
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
+	pr_cont("%sCall Trace:\n", loglvl);
 	dump_backtrace(NULL, task, loglvl);
 }
 
@@ -139,7 +139,7 @@ unsigned long get_wchan(struct task_struct *task)
 
 #ifdef CONFIG_STACKTRACE
 
-void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
 	walk_stackframe(task, regs, consume_entry, cookie);
-- 
2.17.1

