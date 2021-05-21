Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEF38C7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhEUN0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhEUN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:26:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:25:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v13so10962473ple.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NBjjL7pnFZ06uvK9gyMkAYmiPuyoooQWMZwL3pXGC0g=;
        b=SrL6ofn37xVOYsiLd2KFdzUVQU4o14JTvBDzooFiJFG0h7JoQ8QxYhEjLywac2yNLo
         DUXqLCxW1tfht9SLjgv7kL8dgHj9Pm9qViIVfhc/wkpEOORLQ9+1O7E9KsmuFxoKk9mE
         p3eOU1V8Zc+Kww9zbSN27mdAc+eYE8NSvDQINEk4QMTN6JMFKH3PwSVH2J0NaeuDrFNP
         bQcKDHs8jJDi1ep4QDpmvtLjOdBRhQV+ia5dK5ft7E4DLE/Pb/fk0CX/RQhAaZJ2QnDS
         5MGgHcFqMLOXvsfDY7c0KK6l4rOOAszYI5Nmc9oGLWj0Y4JFwvi2D/tN5W0my/BCbBZe
         PpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NBjjL7pnFZ06uvK9gyMkAYmiPuyoooQWMZwL3pXGC0g=;
        b=XuYj04xEQbsnFny7DPRDhqML6J1LPSnt6u9AYrsWt/EURKPWJO5fLQjqEELapughUm
         CbfOTEl+qgLf6cv5UrzdmVxkVhNa6rSuZFmGRW63c6ZRcjda+K+jnU0tIQl/GChSlqvF
         SS8ncYVaadxf2S9SFmUgUghPZ3B/GTtHKCqus7aoU2Zy4e69sOj6iiYdX8gy2eTTjP71
         XDBpoheda6W1TwZCDZTaC0oNMMgPTqP9v1WpJPk/Ts1NXI23LD2qGMZgJnYML2GqCdnV
         I2OCOogZtAMa46K+wWrl7nFNZ2oJ9J/7nIMyVNgQ8KL9TdZOgSRMoemdH2xP40NoANoH
         iCMg==
X-Gm-Message-State: AOAM5316siMw+7asjAk+PX0BHKvKW7T5xGanlAwxXDGxV7LLeD8Dn8nt
        V+tjdDMxgmIrm+FIrDOO93SBse8/P5EULuQJ
X-Google-Smtp-Source: ABdhPJxR2eyaWpxWvuD3fYxnlkYzLPv/dN2+/yqLf+Q9xoiy9+or0+E2kh39zU+TqXUPqC1duD3VKg==
X-Received: by 2002:a17:902:778d:b029:ee:f821:f56d with SMTP id o13-20020a170902778db02900eef821f56dmr12150333pll.79.1621603515855;
        Fri, 21 May 2021 06:25:15 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c130sm4413613pfc.51.2021.05.21.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:25:15 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: [PATCH] hungtask: add filter kthread/check comm
Date:   Fri, 21 May 2021 21:25:03 +0800
Message-Id: <20210521132503.19740-1-chenguanyou@xiaomi.com>
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
 kernel/sysctl.c              | 16 ++++++++++++++++
 lib/Kconfig.debug            | 24 ++++++++++++++++++++++++
 4 files changed, 61 insertions(+)

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
index 2c7f46b366f1..6eab8cf0c37f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1101,6 +1101,30 @@ config DEFAULT_HUNG_TASK_TIMEOUT
 	  A timeout of 0 disables the check.  The default is two minutes.
 	  Keeping the default should be fine in most cases.
 
+config DEFAULT_HUNG_TASK_FILTER_KTHREAD
+	int "Default filter kthread for hung task"
+	depends on DETECT_HUNG_TASK
+	range 0 1
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

