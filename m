Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5334BA2E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 00:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhC0X1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 19:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230176AbhC0X02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 19:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616887587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SPvhqRA1ZSbbdYKxJCCjJnl5CcyH6k2uItd87TwJ+ag=;
        b=JZIwkK30Z3HL86nOpY0WVCTc3klp7fuHkLxWAuU3geITgJUyRbzGXCdiIfaX1j5gyH1IuN
        /lG5F4xgwPqOOAjIr8oDMbVveMnC6aysJSFytX/MZslclYBGJeDM0tNlRNJRz33/6v2MhM
        9gHKQmduhcV/DlMzQdpfnxbtH/Gba38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-QZkg3OJkM8iTTHXP7tMpdw-1; Sat, 27 Mar 2021 19:26:23 -0400
X-MC-Unique: QZkg3OJkM8iTTHXP7tMpdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61EDA814337;
        Sat, 27 Mar 2021 23:26:21 +0000 (UTC)
Received: from llong.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 341D95C22A;
        Sat, 27 Mar 2021 23:26:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] sched/debug: Don't disable IRQ when acquiring sched_debug_lock
Date:   Sat, 27 Mar 2021 19:25:28 -0400
Message-Id: <20210327232529.2349-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_debug_lock was used only in print_cpu().  The
print_cpu() function has two callers - sched_debug_show() and
sysrq_sched_debug_show(). Both of them are invoked by user action
(sched_debug file and sysrq-t). As print_cpu() won't be called from
interrupt context at all, there is no point in disabling IRQ when
acquiring sched_debug_lock.

Besides, if the system has many cpus and the sched_debug_lock is somehow
busy (e.g. parallel sysrq-t), the system may hit a hard lockup panic, like

[ 7809.796262] Kernel panic - not syncing: Hard LOCKUP
[ 7809.796264] CPU: 13 PID: 79867 Comm: reproducer.sh Kdump: loaded Tainted: G          I      --------- -  - 4.18.0-301.el8.x86_64 #1
[ 7809.796264] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.4.9 06/29/2018
[ 7809.796265] Call Trace:
[ 7809.796265]  <NMI>
[ 7809.796266]  dump_stack+0x5c/0x80
[ 7809.796266]  panic+0xe7/0x2a9
[ 7809.796267]  nmi_panic.cold.9+0xc/0xc
[ 7809.796267]  watchdog_overflow_callback.cold.7+0x5c/0x70
[ 7809.796268]  __perf_event_overflow+0x52/0xf0
[ 7809.796268]  handle_pmi_common+0x204/0x2a0
[ 7809.796269]  ? __set_pte_vaddr+0x32/0x50
[ 7809.796269]  ? __native_set_fixmap+0x24/0x30
[ 7809.796270]  ? ghes_copy_tofrom_phys+0xd3/0x1c0
[ 7809.796271]  intel_pmu_handle_irq+0xbf/0x160
[ 7809.796271]  perf_event_nmi_handler+0x2d/0x50
[ 7809.796272]  nmi_handle+0x63/0x110
[ 7809.796272]  default_do_nmi+0x49/0x100
[ 7809.796273]  do_nmi+0x17e/0x1e0
[ 7809.796273]  end_repeat_nmi+0x16/0x6f
[ 7809.796274] RIP: 0010:native_queued_spin_lock_slowpath+0x5b/0x1d0
[ 7809.796275] Code: 6d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 47 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 8b 37 81 fe 00 01 00
[ 7809.796276] RSP: 0018:ffffaa54cd887df8 EFLAGS: 00000002
[ 7809.796277] RAX: 0000000000000101 RBX: 0000000000000246 RCX: 0000000000000000
[ 7809.796278] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff936b66d0
[ 7809.796278] RBP: ffffffff9301fb40 R08: 0000000000000004 R09: 000000000000004f
[ 7809.796279] R10: 0000000000000000 R11: ffffaa54cd887cc0 R12: ffff907fd0a29ec0
[ 7809.796280] R13: 0000000000000000 R14: ffffffff926ab7c0 R15: 0000000000000000
[ 7809.796280]  ? native_queued_spin_lock_slowpath+0x5b/0x1d0
[ 7809.796281]  ? native_queued_spin_lock_slowpath+0x5b/0x1d0
[ 7809.796281]  </NMI>
[ 7809.796282]  _raw_spin_lock_irqsave+0x32/0x40
[ 7809.796283]  print_cpu+0x261/0x7c0
[ 7809.796283]  sysrq_sched_debug_show+0x34/0x50
[ 7809.796284]  sysrq_handle_showstate+0xc/0x20
[ 7809.796284]  __handle_sysrq.cold.11+0x48/0xfb
[ 7809.796285]  write_sysrq_trigger+0x2b/0x30
[ 7809.796285]  proc_reg_write+0x39/0x60
[ 7809.796286]  vfs_write+0xa5/0x1a0
[ 7809.796286]  ksys_write+0x4f/0xb0
[ 7809.796287]  do_syscall_64+0x5b/0x1a0
[ 7809.796287]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 7809.796288] RIP: 0033:0x7fabe4ceb648

It is not to disable IRQ for so long that a hard lockup panic is
triggered. Fix that by not disabling IRQ when taking sched_debug_lock.

Fixes: efe25c2c7b3a ("sched: Reinstate group names in /proc/sched_debug")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/debug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 486f403a778b..c4ae8a0853a1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -666,7 +666,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long flags;
 
 #ifdef CONFIG_X86
 	{
@@ -717,13 +716,13 @@ do {									\
 	}
 #undef P
 
-	spin_lock_irqsave(&sched_debug_lock, flags);
+	spin_lock(&sched_debug_lock);
 	print_cfs_stats(m, cpu);
 	print_rt_stats(m, cpu);
 	print_dl_stats(m, cpu);
 
 	print_rq(m, rq, cpu);
-	spin_unlock_irqrestore(&sched_debug_lock, flags);
+	spin_unlock(&sched_debug_lock);
 	SEQ_printf(m, "\n");
 }
 
-- 
2.18.1

