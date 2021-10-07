Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51971426D02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbhJHOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242793AbhJHOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633704563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WAIC07FBJ3G5gmDeuVW8LjJvYypfQQyJNo9w7YddLVE=;
        b=jHk5lnMOFrA0WKQIQdDwEHM4p/xZn7jJD9MsI54LBFhSobpVVis8IT5XsTEZ2YcoUz0OIC
        BuHL6VQYJZVQdQe/Ajo4Y+EctLpFwuKZM7b3IV7wgbqYl1Pb58J6nw/uE7ChUo36/VZUrf
        +S7TfMOfTiY5J+5tGj3nkfsGLNufjKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-27d7MqU_Oa6KMCum8_bFMA-1; Fri, 08 Oct 2021 10:49:21 -0400
X-MC-Unique: 27d7MqU_Oa6KMCum8_bFMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC86018D6A32;
        Fri,  8 Oct 2021 14:49:20 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E7906091B;
        Fri,  8 Oct 2021 14:49:04 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E6E6241A801E; Fri,  8 Oct 2021 11:48:13 -0300 (-03)
Message-ID: <20211007193526.169401398@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 16:23:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: [patch v4 4/8] procfs: add per-pid task isolation state
References: <20211007192346.731667417@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /proc/pid/task_isolation file, to query the state of
task isolation configuration.

---
 fs/proc/base.c                 |    4 ++
 include/linux/task_isolation.h |    2 +
 kernel/task_isolation.c        |   60 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

Index: linux-2.6/fs/proc/base.c
===================================================================
--- linux-2.6.orig/fs/proc/base.c
+++ linux-2.6/fs/proc/base.c
@@ -96,6 +96,8 @@
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
+#include <linux/prctl.h>
+#include <linux/task_isolation.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -662,6 +664,69 @@ static int proc_pid_syscall(struct seq_f
 }
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
+#ifdef CONFIG_CPU_ISOLATION
+
+struct qoptions {
+	unsigned long mask;
+	char *name;
+};
+
+static struct qoptions iopts[] = {
+	{ISOL_F_QUIESCE, "quiesce"},
+};
+#define ILEN (sizeof(iopts) / sizeof(struct qoptions))
+
+static struct qoptions qopts[] = {
+	{ISOL_F_QUIESCE_VMSTATS, "vmstat_sync"},
+};
+#define QLEN (sizeof(qopts) / sizeof(struct qoptions))
+
+static void show_isolation_state(struct seq_file *m,
+				 struct qoptions *iopt,
+				 int mask,
+				 const char *hdr)
+{
+	int i;
+
+	seq_printf(m, hdr);
+	for (i = 0; i < ILEN; i++) {
+		if (mask & iopt->mask)
+			seq_printf(m, "%s ", iopt->name);
+		iopt++;
+	}
+	if (mask == 0)
+		seq_printf(m, "none ");
+	seq_printf(m, "\n");
+}
+
+int proc_pid_task_isolation(struct seq_file *m, struct pid_namespace *ns,
+			    struct pid *pid, struct task_struct *t)
+{
+	int active_mask, quiesce_mask, conf_mask;
+	struct isol_info *isol_info;
+	struct inode *inode = m->private;
+	struct task_struct *task = get_proc_task(inode);
+
+	isol_info = t->isol_info;
+	if (!isol_info)
+		active_mask = quiesce_mask = conf_mask = 0;
+	else {
+		active_mask = isol_info->active_mask;
+		quiesce_mask = isol_info->quiesce_mask;
+		conf_mask = isol_info->conf_mask;
+	}
+
+	show_isolation_state(m, iopts, conf_mask, "Configured state: ");
+	show_isolation_state(m, iopts, active_mask, "Active state: ");
+	show_isolation_state(m, qopts, quiesce_mask, "Quiescing: ");
+
+	put_task_struct(task);
+
+	return 0;
+}
+
+#endif /* CONFIG_CPU_ISOLATION */
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -3281,6 +3346,9 @@ static const struct pid_entry tgid_base_
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+#ifdef CONFIG_CPU_ISOLATION
+	ONE("task_isolation", S_IRUSR, proc_pid_task_isolation),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)


