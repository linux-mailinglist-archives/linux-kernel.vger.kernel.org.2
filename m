Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6FD387742
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbhERLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbhERLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:17:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD527C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:16:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k19so7147368pfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PT1ViMRA8GOBG5oCmyeoONxSbXXiNjRACO4QiTXbGtE=;
        b=JpZNDZvA5AUVL/N+EdaH+RbnWc5OBjSDSGkoaeg3j893RYM8Co8BcFqwKUsAFYv9EG
         dsNcGQxtrNpe64ckDuLV4NC06hbIEla/kU1MU/SgphpTlERKJCgKEPZHP9ubVfJi687d
         ql4v+6KFIZ7mq+xq/tqIUQR+8JPP6kZ8eW5agla+7luK0YAehflravnQ28Ac3Muw3evV
         qgMzaP+fQBDJF8L+nMlAyL5HX+Mv9ASiazhgOIaArzoJYGKKPHf6lo87yRuAVHB1ykBP
         OGlz/BeB+NvWgXHZ1/xMXYh0J2/U4dDRfmQxVdLcum5pqDXJaNlH3WtswFnp8dPUgASz
         /h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PT1ViMRA8GOBG5oCmyeoONxSbXXiNjRACO4QiTXbGtE=;
        b=kH9wQmf5bxZfAznZzT6OMF1+7IMKPvPbMKaJ4sc7VBHlBdZ+8lJpCpnYDAWkeWdiVG
         Shrab+xb4dQ2NmxCsqx/Dw1jUDQaAuiMWA016Q7Pt48kb97ca0bmdAQv3zjTQ08awTk4
         rbZUKMoOL6JFoLX+zKIrsHWctTsLNeiQazGEkL8pAoF6Z/YhsTGbzqoBxsx30Ptalpt8
         GUnGSfs5fujchMMQIFUTFZAAT++gfdlCQIOi/FxHd7mAFXYk2dTr4OuXo1JxOHtLU36S
         DG+lVMemVjs89tAldrIKbkMcHsZDWGqP1zsUYzn1iQMxO5doeBcATY5wUCHFnY8Gqj/v
         Czmw==
X-Gm-Message-State: AOAM5324Rf36tD8h7r2mc7kTRnKwByg/Jhyd4/xdHYmYfWwWJjVee2iV
        /5rbtU+UKoOoroW9PFMmOeYomBN+rUkKP73Z
X-Google-Smtp-Source: ABdhPJx1miN8WRa6xboN9pbBnvVhN9EhDXH7B2KPIxVJ1+LzqQma8rX4jl2ZEg8NYdqkgstoWBdEww==
X-Received: by 2002:a62:31c4:0:b029:28d:1ad0:340c with SMTP id x187-20020a6231c40000b029028d1ad0340cmr4440383pfx.35.1621336596129;
        Tue, 18 May 2021 04:16:36 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s48sm3540840pfw.205.2021.05.18.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:16:35 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: [PATCH] hungtask: add filter kthread/check comm
Date:   Tue, 18 May 2021 19:16:16 +0800
Message-Id: <20210518111616.26695-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

