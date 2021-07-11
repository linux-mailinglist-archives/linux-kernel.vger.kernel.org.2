Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76963C3D45
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhGKORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:17:40 -0400
Received: from pv50p00im-zteg10011401.me.com ([17.58.6.41]:37042 "EHLO
        pv50p00im-zteg10011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232544AbhGKORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1626012892; bh=jKojMT9XDUA5lsIWOMFWgUSOgnxSlrEbOhcPo7fJdlY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=wQD+JaPLbdtMvctFUsGFMMP5kf3pyZOL0ICgsUVyIHRRLmjfhlq3gdKIx2h01Vazn
         OD2WxSICDjUon2Ho++fCYkFL+jSQ1CDvjW5u9xhZtfCpiCabT9D3khO8AGLZQVCBb6
         +BIWZCRYHHlrkU5ve4f1Jq4bhuD62SLqTCBf572UXgPxwHGdfLDGp2N7KOhtKCfQIG
         CO2un6R6Rwv9iK+zOJ5pyij3R7M+W95gB1S0gRSMIRs17D14EKgQrhxM/BU5W4rzS5
         cB6fkDGggtR0bN/uTaq2dXRCHiWVAY4e5ND4oEt6x7yXahRjaUNuEa+M0WjC1l4IPb
         KZ/4UCfd5OP6A==
Received: from xiongwei.. (unknown [120.245.2.75])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 68D83900269;
        Sun, 11 Jul 2021 14:14:49 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [RFC PATCH v1 1/3] locking/lockdep: Fix false warning of check_wait_context()
Date:   Sun, 11 Jul 2021 22:14:28 +0800
Message-Id: <20210711141430.896595-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-11_09:2021-07-09,2021-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2107110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

We now always get a "Invalid wait context" warning with
CONFIG_PROVE_RAW_LOCK_NESTING=y, see the full warning below:

	[    0.705900] =============================
	[    0.706002] [ BUG: Invalid wait context ]
	[    0.706180] 5.13.0+ #4 Not tainted
	[    0.706349] -----------------------------
	[    0.706486] swapper/1/0 is trying to lock:
	[    0.706658] ffff898c01045998 (&n->list_lock){..-.}-{3:3}, at: deactivate_slab+0x2f4/0x570
	[    0.706759] other info that might help us debug this:
	[    0.706759] context-{2:2}
	[    0.706759] no locks held by swapper/1/0.
	[    0.706759] stack backtrace:
	[    0.706759] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.13.0+ #4
	[    0.706759] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[    0.706759] Call Trace:
	[    0.706759]  <IRQ>
	[    0.706759]  dump_stack_lvl+0x45/0x59
	[    0.706759]  __lock_acquire.cold+0x2bc/0x2ed
	[    0.706759]  ? __lock_acquire+0x3a5/0x2330
	[    0.706759]  lock_acquire+0xbb/0x2b0
	[    0.706759]  ? deactivate_slab+0x2f4/0x570
	[    0.706759]  _raw_spin_lock_irqsave+0x36/0x50
	[    0.706759]  ? deactivate_slab+0x2f4/0x570
	[    0.706759]  deactivate_slab+0x2f4/0x570
	[    0.706759]  ? find_held_lock+0x2b/0x80
	[    0.706759]  ? lock_release+0xbd/0x2b0
	[    0.706759]  ? tick_irq_enter+0x28/0xe0
	[    0.706759]  flush_cpu_slab+0x2f/0x50
	[    0.706759]  flush_smp_call_function_queue+0x133/0x1d0
	[    0.706759]  __sysvec_call_function_single+0x3e/0x190
	[    0.706759]  sysvec_call_function_single+0x65/0x90
	[    0.706759]  </IRQ>
	[    0.706759]  asm_sysvec_call_function_single+0x12/0x20
	[    0.706759] RIP: 0010:default_idle+0xb/0x10
	[    0.706759] Code: 8b 04 25 40 6f 01 00 f0 80 60 02 df c3 0f ae f0 0f ae 38 0f ae f0 eb b9 0f 1f 80 00 00 00 00 eb 07 0f 00 2d ef f4 50 00 fb f4 <c3> c
	[    0.706759] RSP: 0018:ffff96c8c006bef8 EFLAGS: 00000202
	[    0.706759] RAX: ffffffff9c2f66d0 RBX: 0000000000000001 RCX: 0000000000000001
	[    0.706759] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9c2f697f
	[    0.706759] RBP: ffff898c01201700 R08: 0000000000000001 R09: 0000000000000001
	[    0.706759] R10: 0000000000000039 R11: 0000000000000000 R12: 0000000000000000
	[    0.706759] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
	[    0.706759]  ? mwait_idle+0x70/0x70
	[    0.706759]  ? default_idle_call+0x3f/0x1e0
	[    0.706759]  default_idle_call+0x66/0x1e0
	[    0.706759]  do_idle+0x1fb/0x270
	[    0.706759]  ? _raw_spin_unlock_irqrestore+0x28/0x40
	[    0.706759]  cpu_startup_entry+0x14/0x20
	[    0.706759]  secondary_startup_64_no_verify+0xc2/0xcb

In this case the wait type of spin_lock is 3 and the wait type of
raw_spin_lock is 2, meanwhile deactivate_slab call is in hardirq context,
, which is waiting for wait type <= 2, so check_wait_context() will print
this warning. However, spin_lock and raw_spin_lock should be same wait
type in !PREEMPT_RT environment.

Wait type details, with CONFIG_PROVE_RAW_LOCK_NESTING=y:
	LD_WAIT_SPIN   = 2,
	LD_WAIT_CONFIG = 3,
, with !CONFIG_PROVE_RAW_LOCK_NESTING:
	LD_WAIT_CONFIG = LD_WAIT_SPIN = 2,
.

As we know, the semantics of spin_lock will be only changed in PREEMPT_RT
environment, hence the wait type of spin_lock can be bigger than
raw_spin_lock's.

The fix makes CONFIG_PROVE_RAW_LOCK_NESTING under CONFIG_PREEMPT_RT=y and
the warning will be fixed.

Furthermore, this warning doesn't exsit in PREEMPT_RT environment. Because
the RT kernel has already replaced all the spin_lock_*() with
raw_spin_lock_*() for the list_lock of node. It means the current wait
type that is in hardirq context is equal to the wait type of raw_spin_lock
in this case.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8acc01d7d816..083608106436 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1271,7 +1271,7 @@ config PROVE_LOCKING
 
 config PROVE_RAW_LOCK_NESTING
 	bool "Enable raw_spinlock - spinlock nesting checks"
-	depends on PROVE_LOCKING
+	depends on PROVE_LOCKING && PREEMPT_RT
 	default n
 	help
 	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
-- 
2.30.2

