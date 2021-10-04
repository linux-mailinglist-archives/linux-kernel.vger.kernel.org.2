Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE7420B34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhJDMxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:53:33 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39638
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231765AbhJDMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:53:32 -0400
Received: from wittgenstein.fritz.box (ip5f5bd0d9.dynamic.kabel-deutschland.de [95.91.208.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 47D9441A72;
        Mon,  4 Oct 2021 12:51:42 +0000 (UTC)
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/2] pid: add pidfd_get_task() helper
Date:   Mon,  4 Oct 2021 14:50:49 +0200
Message-Id: <20211004125050.1153693-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
References: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of system calls making use of pidfds is constantly
increasing. Some of those new system calls duplicate the code to turn a
pidfd into task_struct it refers to. Give them a simple helper for this.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Bobrowski <repnop@google.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/pid.h |  1 +
 kernel/pid.c        | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index af308e15f174..343abf22092e 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,6 +78,7 @@ struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
+struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_create(struct pid *pid, unsigned int flags);
 
 static inline struct pid *get_pid(struct pid *pid)
diff --git a/kernel/pid.c b/kernel/pid.c
index efe87db44683..2ffbb87b2ce8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -539,6 +539,40 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 	return pid;
 }
 
+/**
+ * pidfd_get_task() - Get the task associated with a pidfd
+ *
+ * @pidfd: pidfd for which to get the task
+ * @flags: flags associated with this pidfd
+ *
+ * Return the task associated with the given pidfd.
+ * Currently, the process identified by @pidfd is always a thread-group leader.
+ * This restriction currently exists for all aspects of pidfds including pidfd
+ * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd polling
+ * (only supports thread group leaders).
+ *
+ * Return: On success, the task_struct associated with the pidfd.
+ *	   On error, a negative errno number will be returned.
+ */
+struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
+{
+	unsigned int f_flags;
+	struct pid *pid;
+	struct task_struct *task;
+
+	pid = pidfd_get_pid(pidfd, &f_flags);
+	if (IS_ERR(pid))
+		return ERR_CAST(pid);
+
+	task = get_pid_task(pid, PIDTYPE_TGID);
+	put_pid(pid);
+	if (!task)
+		return ERR_PTR(-ESRCH);
+
+	*flags = f_flags;
+	return task;
+}
+
 /**
  * pidfd_create() - Create a new pid file descriptor.
  *
-- 
2.30.2

