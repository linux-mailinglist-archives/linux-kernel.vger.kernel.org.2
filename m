Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30F38C7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhEUN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhEUN1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:27:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC88C06138A
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:26:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m190so14222472pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9hkkuD5NA2Pyjb3c9ZtYwB66/Op7JmiLBr1ePBjM8p0=;
        b=jpUhxGSLzSeYgGgVG5I5sbBbpgVxnuAU4fW2Sa4+q1FzNp9tiq+R7jUom4OLlVdIxf
         0/TkTYiiC661H9VEuC1EKEM/qVbNrNHmgDrl1Ep2pznlrAkyIOp7V7TvWlCZerTyxLfq
         hf9zEwiNfrNxviAwtEbUMLtk8r7DCKkTi8mWWQnivAvejkzrSvv0nkxh7uX4zgif5PEq
         U9ELLCG+UrHiM5lsvbrsIu2FakpQaPJg0ijDuyGpRln3T3gokK/tSbcUlCUSFCy5j5ZF
         yjzedH5UOBVdl7T50OClZKGbmw4PPKrfbtVhVeg0aUAWUsp7HMIAWsqbPcDRO5RtaqhW
         3BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9hkkuD5NA2Pyjb3c9ZtYwB66/Op7JmiLBr1ePBjM8p0=;
        b=LqxOYTegVxME8YmaqJ354l9b30EziEuGTKdWiRMIjZINVd5Rj58mK5T9Z2tBKqpGyt
         SADJlP7dogZx+AuHnXgXvpttnnn2YwbTQx9NtCP34zZjD+r4EMK7x7jOxI1e0+1dUR2J
         ofBq5F5w+Rr8/JXPwn07y8hF7XcIugSyOn4eNOsHxQhlDrlGqWkPlZTh3dRMm1bCKD/0
         jC0/mSmvpccJWHz9gXd/zWArRf6n4Mgbp1zx7vElScypE+RJ0k8l1TfdnXbGsImMly/u
         LUe5VYDHT/TWprFfGaKR7h4op70f3APGVwgDVLPuWFTdxOf48/iTW2U+qR8Bd08+jjEI
         DPxw==
X-Gm-Message-State: AOAM530dLevCTvdf+smMoC1On1hQolsfkd0WNoCYQN9Wv/2JL34z9blZ
        X6VQDVaDmpsVVAtvjMGjgMNV6ZHatRIcGkwn
X-Google-Smtp-Source: ABdhPJwb+xSDHgFcLWWj7Z9LjoNzfJbDbGseNLTkOJOJgYXUr0OjCqBs2raV+DVpRvXy7nRzVo5BWg==
X-Received: by 2002:a63:5218:: with SMTP id g24mr9758243pgb.309.1621603561303;
        Fri, 21 May 2021 06:26:01 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p6sm4303283pfh.166.2021.05.21.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:26:01 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: [PATCH] hungtask: add filter kthread/check comm
Date:   Fri, 21 May 2021 21:25:44 +0800
Message-Id: <20210521132544.19816-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel threads are always in D state, when we enable hung_task,
it will misjudge, we should skip these to narrow the scope.

exp mtk mobilephone:
root            435   435      2       0      0 mtk_lpm_monitor_thread 0 D LPM-0
root            436   436      2       0      0 mtk_lpm_monitor_thread 0 D LPM-1
root            437   437      2       0      0 mtk_lpm_monitor_thread 0 D LPM-2
root            438   438      2       0      0 mtk_lpm_monitor_thread 0 D LPM-3
root            439   439      2       0      0 mtk_lpm_monitor_thread 0 D LPM-4
root            440   440      2       0      0 mtk_lpm_monitor_thread 0 D LPM-5
root            441   441      2       0      0 mtk_lpm_monitor_thread 0 D LPM-6
root            442   442      2       0      0 mtk_lpm_monitor_thread 0 D LPM-7

Signed-off-by: chenguanyou <chenguanyou@xiaomi.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 16 ++++++++++++
 include/linux/sched/sysctl.h                |  4 +++
 kernel/hung_task.c                          | 17 +++++++++++++
 kernel/sysctl.c                             | 16 ++++++++++++
 lib/Kconfig.debug                           | 27 +++++++++++++++++++++
 5 files changed, 80 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b73a4e..081ca22db4d5 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -405,6 +405,22 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
 -1: report an infinite number of warnings.
 
+hung_task_filter_kthread
+========================
+
+We should skip kthread when a hung task is detected.
+This file shows up if ``CONFIG_DEFAULT_HUNG_TASK_FILTER_KTHREAD`` is enabled.
+
+= =========================================================
+0 Not skip detect kthread.
+1 Skip detect kthread.
+= =========================================================
+
+hung_task_check_comm
+====================
+
+We should skip non ``hung_task_check_comm`` when a hung task is detected.
+This file shows up if ``CONFIG_DEFAULT_HUNG_TASK_CHECK_COMM`` is enabled.
 
 hyperv_record_panic_msg
 =======================
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3c31ba88aca5..e8a9a28215bf 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -14,11 +14,15 @@ extern unsigned int sysctl_hung_task_all_cpu_backtrace;
 #define sysctl_hung_task_all_cpu_backtrace 0
 #endif /* CONFIG_SMP */
 
+#define TASK_COMM_LEN 16
+
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
 extern unsigned long sysctl_hung_task_timeout_secs;
 extern unsigned long sysctl_hung_task_check_interval_secs;
 extern int sysctl_hung_task_warnings;
+extern unsigned int sysctl_hung_task_filter_kthread;
+extern char sysctl_hung_task_check_comm[TASK_COMM_LEN];
 int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 #else
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebaebea3f..baee8466b902 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -23,6 +23,7 @@
 #include <linux/sched/sysctl.h>
 
 #include <trace/events/sched.h>
+#include <linux/string.h>
 
 /*
  * The number of tasks checked:
@@ -48,6 +49,16 @@ unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_
  */
 unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
 
+/*
+ * Non-zero means no checking kthread
+ */
+unsigned int __read_mostly sysctl_hung_task_filter_kthread = CONFIG_DEFAULT_HUNG_TASK_FILTER_KTHREAD;
+
+/*
+ * Only one
+ */
+char __read_mostly sysctl_hung_task_check_comm[TASK_COMM_LEN] = CONFIG_DEFAULT_HUNG_TASK_CHECK_COMM;
+
 int __read_mostly sysctl_hung_task_warnings = 10;
 
 static int __read_mostly did_panic;
@@ -88,6 +99,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
 
+	if (unlikely(strlen(sysctl_hung_task_check_comm) && !strstr(t->comm, sysctl_hung_task_check_comm)))
+		return;
+
+	if (unlikely(sysctl_hung_task_filter_kthread && t->flags & PF_KTHREAD))
+		return;
+
 	/*
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09b5dc1..1daede87c88d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2519,6 +2519,22 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &neg_one,
 	},
+	{
+		.procname	= "hung_task_filter_kthread",
+		.data		= &sysctl_hung_task_filter_kthread,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "hung_task_check_comm",
+		.data		= &sysctl_hung_task_check_comm,
+		.maxlen		= TASK_COMM_LEN,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
 #endif
 #ifdef CONFIG_RT_MUTEXES
 	{
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2c7f46b366f1..63570b1fec35 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1101,6 +1101,33 @@ config DEFAULT_HUNG_TASK_TIMEOUT
 	  A timeout of 0 disables the check.  The default is two minutes.
 	  Keeping the default should be fine in most cases.
 
+config DEFAULT_HUNG_TASK_FILTER_KTHREAD
+	int "Default filter kthread for hung task"
+	depends on DETECT_HUNG_TASK
+	range 0 1
+	default 0
+	help
+	  This option controls filter kthread uses to determine when
+	  a kernel task has become "state=TASK_UNINTERRUPTIBLE" and should be skipped.
+
+	  It can be adjusted at runtime via the kernel.hung_task_filter_kthread
+	  sysctl or by writing a value to
+	  /proc/sys/kernel/hung_task_filter_kthread.
+
+	  A filter of 1 disables the check.
+
+config DEFAULT_HUNG_TASK_CHECK_COMM
+	string "Default check only one comm"
+	depends on DETECT_HUNG_TASK
+	default ""
+	help
+	  This option controls only detect "task.comm = kernel.hung_task_check_comm" when
+	  it become "state=TASK_UNINTERRUPTIBLE", skip other threads.
+
+	  It can be adjusted at runtime via the kernel.hung_task_check_comm
+	  sysctl or by writing a value to
+	  /proc/sys/kernel/hung_task_check_comm.
+
 config BOOTPARAM_HUNG_TASK_PANIC
 	bool "Panic (Reboot) On Hung Tasks"
 	depends on DETECT_HUNG_TASK
-- 
2.17.1

