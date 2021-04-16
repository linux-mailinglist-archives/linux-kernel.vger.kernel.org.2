Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7979361B90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhDPI14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:27:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17367 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhDPI1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:27:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FM8RM2QhBzlYDD;
        Fri, 16 Apr 2021 16:25:35 +0800 (CST)
Received: from huawei.com (10.67.174.53) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 16 Apr 2021
 16:27:21 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <Jisheng.Zhang@synaptics.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <guoren@linux.alibaba.com>, <mhiramat@kernel.org>,
        <penberg@kernel.org>, <mingo@kernel.org>, <lkp@intel.com>,
        <me@packi.ch>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liaochang1@huawei.com>
Subject: [PATCH v2] riscv/kprobe: Restore local irqflag if kprobe is cancelled
Date:   Fri, 16 Apr 2021 16:27:31 +0800
Message-ID: <20210416082731.121494-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The execution of sys_read end up hitting a BUG_ON() in __find_get_block after
installing probe at sys_read via kprobe, the BUG message like the following:

[   65.708663] ------------[ cut here ]------------
[   65.709987] kernel BUG at fs/buffer.c:1251!
[   65.711283] Kernel BUG [#1]
[   65.712032] Modules linked in:
[   65.712925] CPU: 0 PID: 51 Comm: sh Not tainted 5.12.0-rc4 #1
[   65.714407] Hardware name: riscv-virtio,qemu (DT)
[   65.715696] epc : __find_get_block+0x218/0x2c8
[   65.716835]  ra : __getblk_gfp+0x1c/0x4a
[   65.717831] epc : ffffffe00019f11e ra : ffffffe00019f56a sp : ffffffe002437930
[   65.719553]  gp : ffffffe000f06030 tp : ffffffe0015abc00 t0 : ffffffe00191e038
[   65.721290]  t1 : ffffffe00191e038 t2 : 000000000000000a s0 : ffffffe002437960
[   65.723051]  s1 : ffffffe00160ad00 a0 : ffffffe00160ad00 a1 : 000000000000012a
[   65.724772]  a2 : 0000000000000400 a3 : 0000000000000008 a4 : 0000000000000040
[   65.726545]  a5 : 0000000000000000 a6 : ffffffe00191e000 a7 : 0000000000000000
[   65.728308]  s2 : 000000000000012a s3 : 0000000000000400 s4 : 0000000000000008
[   65.730049]  s5 : 000000000000006c s6 : ffffffe00240f800 s7 : ffffffe000f080a8
[   65.731802]  s8 : 0000000000000001 s9 : 000000000000012a s10: 0000000000000008
[   65.733516]  s11: 0000000000000008 t3 : 00000000000003ff t4 : 000000000000000f
[   65.734434]  t5 : 00000000000003ff t6 : 0000000000040000
[   65.734613] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
[   65.734901] Call Trace:
[   65.735076] [<ffffffe00019f11e>] __find_get_block+0x218/0x2c8
[   65.735417] [<ffffffe00020017a>] __ext4_get_inode_loc+0xb2/0x2f6
[   65.735618] [<ffffffe000201b6c>] ext4_get_inode_loc+0x3a/0x8a
[   65.735802] [<ffffffe000203380>] ext4_reserve_inode_write+0x2e/0x8c
[   65.735999] [<ffffffe00020357a>] __ext4_mark_inode_dirty+0x4c/0x18e
[   65.736208] [<ffffffe000206bb0>] ext4_dirty_inode+0x46/0x66
[   65.736387] [<ffffffe000192914>] __mark_inode_dirty+0x12c/0x3da
[   65.736576] [<ffffffe000180dd2>] touch_atime+0x146/0x150
[   65.736748] [<ffffffe00010d762>] filemap_read+0x234/0x246
[   65.736920] [<ffffffe00010d834>] generic_file_read_iter+0xc0/0x114
[   65.737114] [<ffffffe0001f5d7a>] ext4_file_read_iter+0x42/0xea
[   65.737310] [<ffffffe000163f2c>] new_sync_read+0xe2/0x15a
[   65.737483] [<ffffffe000165814>] vfs_read+0xca/0xf2
[   65.737641] [<ffffffe000165bae>] ksys_read+0x5e/0xc8
[   65.737816] [<ffffffe000165c26>] sys_read+0xe/0x16
[   65.737973] [<ffffffe000003972>] ret_from_syscall+0x0/0x2
[   65.738858] ---[ end trace fe93f985456c935d ]---

A simple reproducer looks like:
	echo 'p:myprobe sys_read fd=%a0 buf=%a1 count=%a2' > /sys/kernel/debug/tracing/kprobe_events
	echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
	cat trace

Here's what happens to hit that BUG_ON():

If instruction being single stepped caused page fault, the
kprobe is cancelled to let the page fault handler continues
as normal page fault. But the local irqflags are disabled,
so CPU will restore 'sstatus' with 'SIE' masked. After page
fault is serviced, the kprobe is triggered again, we overwrite
the saved irqflag by calling kprobe_save_local_irqflag(). Note,
'SIE' is masked in this new saved irqflag. After kprobe is
serviced, the CPU 'sstatus' is restored with 'SIE' masked.
This overwritten 'sstatus' cause BUG_ON() in __find_get_block.

This bug is already fixed on arm64 by Jisheng Zhang.

Fixes: c22b0bcb1dd02 ("riscv: Add kprobes supported")
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---

Changes in v2:
- Reorganize commit message.

 arch/riscv/kernel/probes/kprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 7e2c78e2ca6b..d71f7c49a721 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -260,8 +260,10 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
 
 		if (kcb->kprobe_status == KPROBE_REENTER)
 			restore_previous_kprobe(kcb);
-		else
+		else {
+			kprobes_restore_local_irqflag(kcb, regs);
 			reset_current_kprobe();
+		}
 
 		break;
 	case KPROBE_HIT_ACTIVE:
-- 
2.17.1

