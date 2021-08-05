Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037973E15FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhHENsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhHENsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:48:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9AC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:47:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so9546354pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zMkJpqcMehvvJmFCPhO8x6BBR7kZMtXX6euFuN8dhlE=;
        b=INwI9QUwJIh5IXdsHECbRGSH6KSD6jyd4nVROVshcdYWZR4wqHSmteMXwGYyJSEbEm
         7l/LXwsCOa+er2jgVunbgKxTETxB50Tnxeau5a/d77qNqnzj/LrXIGisgBtMI0C5hIcI
         MA8qlEDWxUzMdL96xCpJ85DZxYYXphCC7SRkMbJtHqpJKN9n8r4DbWb+dzr+rcn+RNfv
         QFS/lwIfl24fjdp3LxAeycNfOAgHUdnO3Hx4hjkR3hBenL79sGVTw6NT5tdjsvt0ndN6
         uOWnDWeh1fkjQ/lQISoYu1nhnubKT5yLjc787PiJfrm7dAGorO2gweVZ2HYZe5DF9nlh
         GLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zMkJpqcMehvvJmFCPhO8x6BBR7kZMtXX6euFuN8dhlE=;
        b=eWbZUgpeR232cSCnTJNsm7IoY5e6uoPP1FFUf1/yhHW1FQfDOzuQHnMfHYH4aFLalF
         j+JsQlPLMk7B+QRIvkLHKejgpN4U+q58zfsMNXtt2qF6RhZE7JZ7zcTbfag24/9nHJPz
         e8wGgYLufZZhdj+lqh/ikyWPKV75LMVsnzdee94QopxzZVupPb0UoCUVLscOKfaUvu+2
         MRwjAC2fqVliLsB35J67D87/H3YgzsenBtyx05Le+2RBXxrDjmBB+XcB6znQTO9SyqR7
         BWzcDOfkuTaoOOqsXmDDUgNfheGqchKtfFEHmYuqfJnOyWjocMBsVQ1VBMToW5ZMXtSV
         YFWA==
X-Gm-Message-State: AOAM530Gz1BrzK08MYnPP5f4+EjXTSarfTB2l5vZjziUBIQpWLGKtph8
        dwZZMOd7JsEuTTDrVQUrFDaIdhwmy9ZFUg==
X-Google-Smtp-Source: ABdhPJy0qNdF5LQGPDaeEJbgFQaxsFrp2l38K/Z1yHpHfzvGrHn7VZy3/HQqVGxAYwYVwgMtTpsBUA==
X-Received: by 2002:a17:902:9a92:b029:127:8aab:6a46 with SMTP id w18-20020a1709029a92b02901278aab6a46mr1803362plp.8.1628171276080;
        Thu, 05 Aug 2021 06:47:56 -0700 (PDT)
Received: from localhost.localdomain ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id lk17sm9714505pjb.37.2021.08.05.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:47:55 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: [PATCH v2] hungtask: add filter kthread
Date:   Thu,  5 Aug 2021 21:47:47 +0800
Message-Id: <20210805134747.29621-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel threads are always in D state, when we enable hung_task,
it will misjudge, we should skip these to narrow the scope.

exp mediatek:
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
 Documentation/admin-guide/sysctl/kernel.rst | 10 ++++++++++
 include/linux/sched/sysctl.h                |  1 +
 kernel/hung_task.c                          |  8 ++++++++
 kernel/sysctl.c                             |  9 +++++++++
 lib/Kconfig.debug                           | 15 +++++++++++++++
 5 files changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 68b21395a743..3c7c74b26d95 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -405,6 +405,16 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
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
 
 hyperv_record_panic_msg
 =======================
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index db2c0f34aaaf..2b8b01b57559 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -19,6 +19,7 @@ extern unsigned int  sysctl_hung_task_panic;
 extern unsigned long sysctl_hung_task_timeout_secs;
 extern unsigned long sysctl_hung_task_check_interval_secs;
 extern int sysctl_hung_task_warnings;
+extern unsigned int sysctl_hung_task_filter_kthread;
 int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 #else
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebaebea3f..74ad75c2dde8 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -48,6 +48,11 @@ unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_
  */
 unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
 
+/*
+ * Non-zero means no checking kthread
+ */
+unsigned int __read_mostly sysctl_hung_task_filter_kthread = CONFIG_DEFAULT_HUNG_TASK_FILTER_KTHREAD;
+
 int __read_mostly sysctl_hung_task_warnings = 10;
 
 static int __read_mostly did_panic;
@@ -88,6 +93,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
 
+	if (unlikely(sysctl_hung_task_filter_kthread && t->flags & PF_KTHREAD))
+		return;
+
 	/*
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d4a78e08f6d8..62067b9db486 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2513,6 +2513,15 @@ static struct ctl_table kern_table[] = {
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
 #endif
 #ifdef CONFIG_RT_MUTEXES
 	{
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..d7063f955987 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1110,6 +1110,21 @@ config DEFAULT_HUNG_TASK_TIMEOUT
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
 config BOOTPARAM_HUNG_TASK_PANIC
 	bool "Panic (Reboot) On Hung Tasks"
 	depends on DETECT_HUNG_TASK
-- 
2.17.1

