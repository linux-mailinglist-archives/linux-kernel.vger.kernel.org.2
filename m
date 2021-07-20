Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09133CF43D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhGTFbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 01:31:04 -0400
Received: from mx425.baidu.com ([119.249.100.233]:52617 "EHLO mx423.baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230414AbhGTFa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:30:27 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2021 01:30:27 EDT
Received: from unknown.domain.tld (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx423.baidu.com (Postfix) with ESMTP id 5B2C716E01287;
        Tue, 20 Jul 2021 14:04:41 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.co, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: [PATCH][RFC] sched/cpuacct: Fix cpuacct charge
Date:   Tue, 20 Jul 2021 14:04:41 +0800
Message-Id: <20210720060441.22550-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_irq_regs only work for current running cpu, but the task, whose
cpuacct will be charged, maybe run different cpu, like Cpu 2 wake
up a kernel thread to CPU 3, cause CPU 3 task are charged with the
following stack

  cpuacct_charge+0xd8/0x100
  update_curr+0xe1/0x1e0
  enqueue_entity+0x144/0x6e0
  enqueue_task_fair+0x93/0x900
  ttwu_do_activate+0x4b/0x90
  try_to_wake_up+0x20b/0x530
  ? update_dl_rq_load_avg+0x10f/0x210
  swake_up_locked.part.1+0x13/0x40
  swake_up_one+0x27/0x40
  rcu_process_callbacks+0x484/0x4f0
  ? run_rebalance_domains_bt+0x5a/0x180
  __do_softirq+0xe3/0x308
  irq_exit+0xf0/0x100
  smp_apic_timer_interrupt+0x74/0x160
  apic_timer_interrupt+0xf/0x20
  </IRQ>
 RIP: 0033:0x456947

so define a get_irq_regs_cpu which returns the required cpu irq registers

BUT it should be not safe, and do not know what it should be like in MIPS?

Fixes: dbe9337109c2 "(sched/cpuacct: Fix charge cpuacct.usage_sys)"
Co-developed-by: Zhao Jie <zhaojie17@baidu.com>
Signed-off-by: Zhao Jie <zhaojie17@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/asm-generic/irq_regs.h | 5 +++++
 kernel/sched/cpuacct.c         | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/irq_regs.h b/include/asm-generic/irq_regs.h
index 2e7c6e8..93e2579 100644
--- a/include/asm-generic/irq_regs.h
+++ b/include/asm-generic/irq_regs.h
@@ -21,6 +21,11 @@ static inline struct pt_regs *get_irq_regs(void)
 	return __this_cpu_read(__irq_regs);
 }
 
+static inline struct pt_regs *get_irq_regs_cpu(int cpu)
+{
+	return per_cpu(__irq_regs, cpu);
+}
+
 static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
 {
 	struct pt_regs *old_regs;
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 893eece..8b96058 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -340,7 +340,8 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 {
 	struct cpuacct *ca;
 	int index = CPUACCT_STAT_SYSTEM;
-	struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
+	int cpu = task_cpu(tsk);
+	struct pt_regs *regs = get_irq_regs_cpu(cpu) ? : task_pt_regs(tsk);
 
 	if (regs && user_mode(regs))
 		index = CPUACCT_STAT_USER;
-- 
2.9.4

