Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C13E326E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhHGA6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:58:51 -0400
Received: from foss.arm.com ([217.140.110.172]:42750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhHGA6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:58:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D471063;
        Fri,  6 Aug 2021 17:58:32 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C79B3F66F;
        Fri,  6 Aug 2021 17:58:30 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/4] rcutorture: Don't disable softirqs with preemption disabled when PREEMPT_RT
Date:   Sat,  7 Aug 2021 01:58:04 +0100
Message-Id: <20210807005807.1083943-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807005807.1083943-1-valentin.schneider@arm.com>
References: <20210807005807.1083943-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running RCU torture with CONFIG_PREEMPT_RT under v5.14-rc4-rt6 triggers:

[    8.755472] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
[    8.755482] WARNING: CPU: 1 PID: 137 at kernel/softirq.c:172 __local_bh_disable_ip (kernel/softirq.c:172 (discriminator 31))
[    8.755500] Modules linked in:
[    8.755506] CPU: 1 PID: 137 Comm: rcu_torture_rea Not tainted 5.14.0-rc4-rt6 #171
[    8.755514] Hardware name: ARM Juno development board (r0) (DT)
[    8.755518] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[    8.755622] Call trace:
[    8.755624] __local_bh_disable_ip (kernel/softirq.c:172 (discriminator 31))
[    8.755633] rcutorture_one_extend (kernel/rcu/rcutorture.c:1453)
[    8.755640] rcu_torture_one_read (kernel/rcu/rcutorture.c:1601 kernel/rcu/rcutorture.c:1645)
[    8.755645] rcu_torture_reader (kernel/rcu/rcutorture.c:1737)
[    8.755650] kthread (kernel/kthread.c:327)
[    8.755656] ret_from_fork (arch/arm64/kernel/entry.S:783)
[    8.755663] irq event stamp: 11959
[    8.755666] hardirqs last enabled at (11959): __rcu_read_unlock (kernel/rcu/tree_plugin.h:695 kernel/rcu/tree_plugin.h:451)
[    8.755675] hardirqs last disabled at (11958): __rcu_read_unlock (kernel/rcu/tree_plugin.h:661 kernel/rcu/tree_plugin.h:451)
[    8.755683] softirqs last enabled at (11950): __local_bh_enable_ip (./arch/arm64/include/asm/irqflags.h:85 kernel/softirq.c:261)
[    8.755692] softirqs last disabled at (11942): rcutorture_one_extend (./include/linux/bottom_half.h:19 kernel/rcu/rcutorture.c:1441)

Per this warning, softirqs cannot be disabled in a non-preemptible region
under CONFIG_PREEMPT_RT. Adjust RCU torture accordingly.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index eecd1caef71d..4f3db1d3170d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1548,6 +1548,8 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	 * them on non-RT.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/* Can't disable bh in atomic context under PREEMPT_RT */
+		mask &= ~(RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH);
 		/*
 		 * Can't release the outermost rcu lock in an irq disabled
 		 * section without preemption also being disabled, if irqs
-- 
2.25.1

