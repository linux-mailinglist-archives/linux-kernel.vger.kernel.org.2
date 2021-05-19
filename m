Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377DE388DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353409AbhESMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353400AbhESMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:14:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CD1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:13:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k19so9754931pfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O/9q39k7rrXMli4TaFIIEmk8ITDHDiphSH3DMEqJGCo=;
        b=HaxiJlYKTvgDmRZBbVv2l2QBfuizNL81J3NtGQfcLRjsqPcCMVLAxVIZfqTNmGoZAu
         Rix4sUsz5YFaFsASvvl1XhUFLDRwHVwDmZFu63N8hBRAIxF7BuF8OaqGG8prxn5jJY+o
         0Yjy+qHVhS8z6f6mKBJzSdoDb2gZzHDoWq4e18pqVx2gXk6PdABXqhULj5iuwhWzyJir
         fvqXbFcDtndGHoBRK73SXWic3djZICAtBwyFVOqqoDCu30deRPwPbXyvBHSFlAWIvRkp
         6VQN1N6TQctz///Pq66ChA1oPhA4swTiMVOIDL+qQirb3Nz79RXB81x3ml1BB3+N3nnV
         vlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O/9q39k7rrXMli4TaFIIEmk8ITDHDiphSH3DMEqJGCo=;
        b=HRAYdOtEht39NFSwSoG4YSj3/aWXKdTVZhduamz4bBOu7pR2urv0Bb9tJABZH8igDm
         TDTT16Ra85+3yPlwGj0huTJ+fPB1r/EiGAgUUVA32lGH2zJMQuwpmpnWKYUGA1zmq4dJ
         C8CpcjWgRC1KOvy13VODKbz8ATEZjQFVmQIp+6AOgyVC36uC7MxrgKCKus0PtUtveSJi
         8vtJ5JgVjdqU5IFTVu7qPmOstHRjFe6ye730rf8lM8iY/pdRZt7kw2nXApE1yew0ZF1i
         mJ3YCzEkOH4EagnHVY8DMNQyAyUImmTVTbUN1dD2b/9nYa+CYQGJnKo6X7lKUE9umQSm
         mFRA==
X-Gm-Message-State: AOAM533GRtPI4UCUjJEhLKK95PfzOfASqm1hg6WzUSWtwUoEWZCjleMk
        8Jzcdhv+ulqixn+WsjXGrgl9hHBCFYtqNESI
X-Google-Smtp-Source: ABdhPJySESpCrQ5eCg0kOU5AT26GaTmqmYnoNugA9kucM0CeA7UQtCxPvSgYxth+m3GW3xgcqdzXoA==
X-Received: by 2002:a05:6a00:14d0:b029:2cf:ee47:dfd9 with SMTP id w16-20020a056a0014d0b02902cfee47dfd9mr10487950pfu.31.1621426418688;
        Wed, 19 May 2021 05:13:38 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id iq16sm5989049pjb.31.2021.05.19.05.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:13:38 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: [PATCH] hungtask: add filter kthread/check comm
Date:   Wed, 19 May 2021 20:13:25 +0800
Message-Id: <20210519121325.22083-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel threads are always in D state, when we enable hung_task,
it will misjudge, we should skip these to narrow the scope.

exp mtk mobilephone:
root            420   420      2       0      0 kwdt_thread         0 D wdtk-0
root            421   421      2       0      0 kwdt_thread         0 D wdtk-1
root            422   422      2       0      0 kwdt_thread         0 D wdtk-2
root            423   423      2       0      0 kwdt_thread         0 D wdtk-3
root            424   424      2       0      0 kwdt_thread         0 D wdtk-4
root            425   425      2       0      0 kwdt_thread         0 D wdtk-5
root            426   426      2       0      0 kwdt_thread         0 D wdtk-6
root            427   427      2       0      0 kwdt_thread         0 D wdtk-7
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
 include/linux/sched/sysctl.h |  4 ++++
 kernel/hung_task.c           | 17 +++++++++++++++++
 kernel/sysctl.c              | 15 +++++++++++++++
 lib/Kconfig.debug            | 23 +++++++++++++++++++++++
 4 files changed, 59 insertions(+)

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
index 396ebaebea3f..e018563d4882 100644
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
+ * Non zero means no checking kthread
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
index 62fbd09b5dc1..157c47a8430a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2519,6 +2519,21 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &neg_one,
 	},
+	{
+		.procname	= "hung_task_filter_kthread",
+		.data		= &sysctl_hung_task_filter_kthread,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
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
index 2c7f46b366f1..59cfa9e230ee 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1101,6 +1101,29 @@ config DEFAULT_HUNG_TASK_TIMEOUT
 	  A timeout of 0 disables the check.  The default is two minutes.
 	  Keeping the default should be fine in most cases.
 
+config DEFAULT_HUNG_TASK_FILTER_KTHREAD
+	bool "Default filter kthread for hung task"
+	depends on DETECT_HUNG_TASK
+	default 0
+	help
+	  This option controls filter kthread used to determine when
+	  a kernel task has become "state=TASK_UNINTERRUPTIBLE" and should be skip.
+
+	  It can be adjusted at runtime via the kernel.hung_task_filter_kthread
+	  sysctl or by writing a value to
+	  /proc/sys/kernel/hung_task_filter_kthread.
+
+	  A filter of 1 disables the check
+
+config DEFAULT_HUNG_TASK_CHECK_COMM
+	string "Default check only one comm"
+	depends on DETECT_HUNG_TASK
+	default ""
+	help
+	  It can be adjusted at runtime via the kernel.hung_task_check_comm
+	  sysctl or by writing a value to
+	  /proc/sys/kernel/hung_task_check_comm.
+
 config BOOTPARAM_HUNG_TASK_PANIC
 	bool "Panic (Reboot) On Hung Tasks"
 	depends on DETECT_HUNG_TASK
-- 
2.17.1

