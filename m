Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76E44E696
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhKLMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234976AbhKLMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636721058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xOmeUfOPYAne3s/pym/qAjegVbtgQy5mXY0/V+XfMHw=;
        b=LqYWYmM21F+VAejI4EbGjXJlRJ6ac/g3no/ImmNGUb9G/EbLpmKRBe++aXLj/AkVWMJv+g
        UzJnDo0Ob/EDRu5GQkt+GvfJzcYuNI+K9/Qcflla7uElxAVyAWKW0ynbz1F1lJ9UJ9iIDs
        EpBIDAd6I8Y6jNPspcNMnYgpoO/Rt0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-in7Ov2UyNYGhtuj6gZ5itw-1; Fri, 12 Nov 2021 07:44:15 -0500
X-MC-Unique: in7Ov2UyNYGhtuj6gZ5itw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C0648799FC;
        Fri, 12 Nov 2021 12:44:14 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD08357CD2;
        Fri, 12 Nov 2021 12:44:06 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3E73E40C5C1D; Fri, 12 Nov 2021 09:42:32 -0300 (-03)
Message-ID: <20211112123750.752309933@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 12 Nov 2021 09:35:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [patch v7 04/10] procfs: add per-pid task isolation state
References: <20211112123531.497831890@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /proc/pid/task_isolation file, to query the state of
task isolation configuration.

---
 fs/proc/base.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

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


