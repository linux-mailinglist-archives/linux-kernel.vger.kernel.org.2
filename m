Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC036308C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhDQONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 10:13:49 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:17260 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDQONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 10:13:45 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id 2F07080139;
        Sat, 17 Apr 2021 22:13:15 +0800 (CST)
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
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        zhouchuangao <zhouchuangao@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/hung_task: Add a whitelist and blacklist mechanism.
Date:   Sat, 17 Apr 2021 07:13:01 -0700
Message-Id: <1618668783-39601-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR5LSVZDQhpCHU5ITk0eSUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NEk6Qhw5PD8OSxcRHRg*Pxop
        MExPCzJVSlVKTUpDTU1DTEJOQkpCVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUxNTkg3Bg++
X-HM-Tid: 0a78e02db6aeb037kuuu2f07080139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this patch is to add a whitelist and blacklist
mechanism to the hung task thread.

1. Add a /sys/module/hung_task/parameters/hung_seconds interface,
so you can write a specific time to 'hung_seconds' to hang a shell
process for a while. This interface is convenient for us to debug
the function of hung task thread.
eg:
echo 100 > /sys/module/hung_task/parameters/hung_seconds
This will put the current shell process into D state for 100s.

2. Add whitelist and blacklist. If a D state process is on the
whitelist, it will skip checking for that process. In contrast, if
the process is on a blacklist, panic is triggered.
Different use scenarios can make different whitelist and blacklist.

eg:
In Android system, we usually and some processes to the whitelist.
static task_t task_whitelist[] = {
	{"mdrt_thread", HUNG_TASK_WHITELIST},
	{"chre_kthread", HUNG_TASK_WHITELIST},
	{"scp_power_reset", HUNG_TASK_WHITELIST},
	{"ccci_fsm1", HUNG_TASK_WHITELIST},
	{"qos_ipi_recv", HUNG_TASK_WHITELIST},
	{NULL, 0},
};

3. Add a new member hung_state to task_struct to identify the type
of the D state process being detected.
A value of 0x1(HUNG_TASK_WHITELIST) indicates that the process is
on the whitelist.
A value of 0x2(HUNG_TASK_BLACKLIST) indicates that the process is
on the blacklist.
The remaining bits are reserved, and there may be other scenarios
entering the D state that need to be added to hung_state.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 include/linux/sched.h |  1 +
 kernel/hung_task.c    | 88 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d5264b..8ffbdf6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -973,6 +973,7 @@ struct task_struct {
 	unsigned long			last_switch_count;
 	unsigned long			last_switch_time;
 	unsigned long			killed_time;
+	unsigned long			hung_state;
 #endif
 	/* Filesystem information: */
 	struct fs_struct		*fs;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index bb2e3e1..952a44c 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -72,6 +72,57 @@ unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
 unsigned int __read_mostly sysctl_hung_task_panic =
 				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
 
+#define HUNG_TASK_WHITELIST		0x1
+#define HUNG_TASK_BLACKLIST		0x2
+
+typedef struct {
+	char *task_comm;
+	unsigned long flag;
+} task_t;
+
+static task_t task_whitelist[] = {
+	{NULL, 0},
+};
+
+static task_t task_blacklist[] = {
+	{"init", HUNG_TASK_BLACKLIST},
+	{NULL, 0},
+};
+
+static bool task_in_blacklist(struct task_struct *tsk)
+{
+	task_t *info = NULL;
+
+	if (tsk->hung_state & HUNG_TASK_BLACKLIST)
+		return true;
+
+	for (info = task_blacklist; info->task_comm; info++) {
+		if (!strcmp(tsk->comm, info->task_comm)) {
+			tsk->hung_state |= HUNG_TASK_BLACKLIST;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool task_in_whitelist(struct task_struct *tsk)
+{
+	task_t *info = NULL;
+
+	if (tsk->hung_state & HUNG_TASK_WHITELIST)
+		return true;
+
+	for (info = task_whitelist; info->task_comm; info++) {
+		if (!strcmp(tsk->comm, info->task_comm)) {
+			tsk->hung_state |= HUNG_TASK_WHITELIST;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
 {
@@ -111,6 +162,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
 		return;
 
+	/* Check if process 't' is in the whitelist. */
+	if (task_in_whitelist(t)) {
+		pr_info("skip hung task: %s\n", t->comm);
+		return;
+	}
+
 	trace_sched_process_hang(t);
 
 	if (sysctl_hung_task_panic) {
@@ -118,7 +175,6 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		hung_task_show_lock = true;
 		hung_task_call_panic = true;
 	}
-
 	/*
 	 * Ok, the task did not get scheduled for more than 2 minutes,
 	 * complain:
@@ -141,6 +197,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 			hung_task_show_all_bt = true;
 	}
 
+	/* Check if process 't' is in the blacklist. */
+	if (task_in_blacklist(t)) {
+		pr_err("critical task blocked: (%d)%s\n", t->pid, t->comm);
+		hung_task_call_panic = true;
+	}
+
 	touch_nmi_watchdog();
 }
 
@@ -253,8 +315,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		trigger_all_cpu_backtrace();
 	}
 
-	if (hung_task_call_panic)
+	if (hung_task_call_panic) {
+		show_state_filter(TASK_UNINTERRUPTIBLE);
 		panic("hung_task: blocked tasks");
+	}
 }
 
 static long hung_timeout_jiffies(unsigned long last_checked,
@@ -322,6 +386,7 @@ static int watchdog(void *dummy)
 	unsigned long hung_last_checked = jiffies;
 
 	set_user_nice(current, 0);
+	pr_info("khungtaskd started...\n");
 
 	for ( ; ; ) {
 		unsigned long timeout = sysctl_hung_task_timeout_secs;
@@ -357,3 +422,22 @@ static int __init hung_task_init(void)
 	return 0;
 }
 subsys_initcall(hung_task_init);
+
+static int hung_task_test(const char *val, const struct kernel_param *kp)
+{
+	unsigned long sec = 0;
+	if (kstrtoul(val, 10, &sec))
+		return -EINVAL;
+
+	pr_info("Hung task Dsleep %ld s, start!\n", sec);
+	msleep(sec * 1000);
+	pr_info("Hung task Dsleep %ld s, end!\n", sec);
+
+	return 0;
+}
+
+static const struct kernel_param_ops hung_task_test_ops = {
+	.set = hung_task_test,
+};
+
+module_param_cb(hung_seconds, &hung_task_test_ops, NULL, 0600);
-- 
2.7.4

