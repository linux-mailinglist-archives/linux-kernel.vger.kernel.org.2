Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51CC3809F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhENM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:58:20 -0400
Received: from mail-m17670.qiye.163.com ([59.111.176.70]:17792 "EHLO
        mail-m17670.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhENM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:58:19 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17670.qiye.163.com (Hmail) with ESMTPA id 5FEFE3C015F;
        Fri, 14 May 2021 20:57:02 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        zhouchuangao <zhouchuangao@vivo.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/hung_task: Report top CPU consumers
Date:   Fri, 14 May 2021 05:56:49 -0700
Message-Id: <1620997011-106951-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkMYSFZJSENJSUIeGU9MQxhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6HBw4Kj8NIzdIIzdLLk8*
        EhNPChBVSlVKTUlLQkJMS0lISUpDVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUNIQ0M3Bg++
X-HM-Tid: 0a796af3a476da5akuws5fefe3c015f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. If the task did not get scheduled for more than 2 minutes,
report top 3(By default) CPU consumers.

2. By default, the CPU utilization of each process in one minute
is calculated.

3. Add a new member last_cpu_time to task_struct to record the CPU
usage of the process at the beginning of the computation.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 include/linux/sched.h |   1 +
 kernel/hung_task.c    | 161 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d5264b..103f98f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -973,6 +973,7 @@ struct task_struct {
 	unsigned long			last_switch_count;
 	unsigned long			last_switch_time;
 	unsigned long			killed_time;
+	u64				last_cpu_time;
 #endif
 	/* Filesystem information: */
 	struct fs_struct		*fs;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index bb2e3e1..fb5f944 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -10,6 +10,7 @@
 #include <linux/cpu.h>
 #include <linux/nmi.h>
 #include <linux/init.h>
+#include <linux/tick.h>
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
@@ -21,7 +22,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
-
+#include <linux/sched/cputime.h>
 #include <trace/events/sched.h>
 
 /*
@@ -55,6 +56,16 @@ static bool hung_task_show_lock;
 static bool hung_task_call_panic;
 static bool hung_task_show_all_bt;
 
+static u64	last_cpu_usage;
+static u64	interval_cpu_usage;
+
+#define NUM_CONSUMERS   3
+struct cpu_consumer {
+	char	comm[TASK_COMM_LEN];
+	pid_t	pid;
+	u64	cpu_used;
+};
+
 static struct task_struct *watchdog_task;
 
 #ifdef CONFIG_SMP
@@ -72,6 +83,145 @@ unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
 unsigned int __read_mostly sysctl_hung_task_panic =
 				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
 
+#ifdef arch_idle_time
+static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+{
+	u64 idle;
+
+	idle = kcs->cpustat[CPUTIME_IDLE];
+	if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
+		idle += arch_idle_time(cpu);
+	return idle;
+}
+
+static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
+{
+	u64 iowait;
+
+	iowait = kcs->cpustat[CPUTIME_IOWAIT];
+	if (cpu_online(cpu) && nr_iowait_cpu(cpu))
+		iowait += arch_idle_time(cpu);
+	return iowait;
+}
+#else
+static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+{
+	u64 idle, idle_usecs = -1ULL;
+
+	if (cpu_online(cpu))
+		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
+
+	if (idle_usecs == -1ULL)
+		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
+		idle = kcs->cpustat[CPUTIME_IDLE];
+	else
+		idle = idle_usecs * NSEC_PER_USEC;
+
+	return idle;
+}
+
+static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
+{
+	u64 iowait, iowait_usecs = -1ULL;
+
+	if (cpu_online(cpu))
+		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
+
+	if (iowait_usecs == -1ULL)
+		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
+		iowait = kcs->cpustat[CPUTIME_IOWAIT];
+	else
+		iowait = iowait_usecs * NSEC_PER_USEC;
+
+	return iowait;
+}
+#endif
+
+static void show_top_cpu_consumers(bool compute)
+{
+	int i, j;
+	struct task_struct *g, *t;
+	struct signal_struct *sig;
+	u64 cutime, cstime, utime, stime;
+	u64 task_cpu_time, interval_time;
+	struct cpu_consumer tcc[NUM_CONSUMERS];
+
+	memset(tcc, 0, sizeof(struct cpu_consumer) * NUM_CONSUMERS);
+
+	for_each_process_thread(g, t) {
+		sig = t->signal;
+		cutime = sig->cutime;
+		cstime = sig->cstime;
+		task_cputime_adjusted(t, &utime, &stime);
+		task_cpu_time = cutime + cstime + utime + stime;
+
+		if (compute) {
+			interval_time = task_cpu_time - t->last_cpu_time;
+			for (i = 0; i < NUM_CONSUMERS; i++) {
+				if (interval_time > tcc[i].cpu_used) {
+					for (j = NUM_CONSUMERS - 1; j > i; j--) {
+						strcpy(tcc[j].comm, tcc[j-1].comm);
+						tcc[j].pid = tcc[j-1].pid;
+						tcc[j].cpu_used = tcc[j-1].cpu_used;
+					}
+					strcpy(tcc[i].comm, t->comm);
+					tcc[i].pid = t->pid;
+					tcc[i].cpu_used = interval_time;
+					break;
+				}
+			}
+		} else
+			t->last_cpu_time = task_cpu_time;
+	}
+
+	if (compute) {
+		pr_info("hung task report top %d CPU consumers:\n", NUM_CONSUMERS);
+		pr_info("TOP    COMM    PID    [TASK_CPU_TIME/ALL_CPU_TIME]\n");
+		for (i = 0; i < NUM_CONSUMERS; i++)
+			pr_info("Top%d   %s    %d    [%lld/%lld]\n", i,
+				tcc[i].comm,
+				tcc[i].pid,
+				nsec_to_clock_t(tcc[i].cpu_used),
+				nsec_to_clock_t(interval_cpu_usage));
+	}
+}
+
+static void all_cpu_usage(bool compute)
+{
+	int i;
+	u64 user, nice, system, idle, iowait, irq, softirq, steal;
+	u64 guest, guest_nice;
+	u64 current_cpu_usage = 0;
+
+	user = nice = system = idle = iowait = irq = 0;
+	softirq = steal = guest = guest_nice = 0;
+
+	for_each_possible_cpu(i) {
+		struct kernel_cpustat kcpustat;
+		u64 *cpustat = kcpustat.cpustat;
+
+		kcpustat_cpu_fetch(&kcpustat, i);
+
+		user += cpustat[CPUTIME_USER];
+		nice += cpustat[CPUTIME_NICE];
+		system += cpustat[CPUTIME_SYSTEM];
+		idle += get_idle_time(&kcpustat, i);
+		iowait += get_iowait_time(&kcpustat, i);
+		irq += cpustat[CPUTIME_IRQ];
+		softirq += cpustat[CPUTIME_SOFTIRQ];
+		steal += cpustat[CPUTIME_STEAL];
+		guest += cpustat[CPUTIME_GUEST];
+		guest_nice += kcpustat_cpu(i).cpustat[CPUTIME_GUEST_NICE];
+	}
+	current_cpu_usage = user + nice + system + idle + iowait +
+				irq + softirq + steal + guest + guest_nice;
+
+	if (compute)
+		interval_cpu_usage = current_cpu_usage - last_cpu_usage;
+	else
+		last_cpu_usage = current_cpu_usage;
+}
+
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
 {
@@ -253,8 +403,15 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		trigger_all_cpu_backtrace();
 	}
 
-	if (hung_task_call_panic)
+	if (hung_task_call_panic) {
+		all_cpu_usage(false);
+		show_top_cpu_consumers(false);
+		msleep(1000);
+		all_cpu_usage(true);
+		show_top_cpu_consumers(true);
+
 		panic("hung_task: blocked tasks");
+	}
 }
 
 static long hung_timeout_jiffies(unsigned long last_checked,
-- 
2.7.4

