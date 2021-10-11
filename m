Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7B428E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhJKNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236996AbhJKNfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:35:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAE1060EB4;
        Mon, 11 Oct 2021 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633959197;
        bh=WASKuunDznop2Gt/EdpxjsrUicUNeg8J9P/l7yA5PxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRkszoWCS9yTpum+x1Z2Fc1fWXKXROiuAMG7a9hHu06wsH1GoSnSvmQ0FR//QeVL5
         kCIXLEolyLGI1MNF/DTC80qJZZNdvJVo53gY5J6GqX3LfMFfOQXiYc5dUiMnyf4fgA
         no4OadSF7RKNPQU9C0vX9FalLyzUNxHO2hRY38DAqrYg3wOEg0jZd86QADUvQchhVZ
         o4PnTEhYIYeKmDl7tAjC/173wloUYME7gHicAyPvJa2vfZlMCZWZfWfMi55og+wXKJ
         FfQPfpk+5ThhrNA6msBH9mbrp2HxvbzIaZeFiR5HktDFAsipzcLl+1ucK+G5A/8iYo
         WgHbui53XDxBQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 1/2] pid: add pidfd_get_task() helper
Date:   Mon, 11 Oct 2021 15:32:44 +0200
Message-Id: <20211011133245.1703103-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011133245.1703103-1-brauner@kernel.org>
References: <20211011133245.1703103-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2954; h=from:subject; bh=kXvY2YwbxVX1cpVZZpdvJqM2O3omsoRZqEBDc+r93v8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSm2PzMjw7YsKabR231Ot1T29evm6u34VRRfOTl/Z8MmB9z Bwre7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIhZWMDCvtLOuXRmfm5l8I7sjd/p tZYIVy5PMZ6/x2r47im5wt5sHIcHn2U10Tu02KU1htz3fvux1bs56lxGk+v+Fj1RrdXX2H2QE=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The number of system calls making use of pidfds is constantly
increasing. Some of those new system calls duplicate the code to turn a
pidfd into task_struct it refers to. Give them a simple helper for this.

Link: https://lore.kernel.org/r/20211004125050.1153693-2-christian.brauner@ubuntu.com
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Bobrowski <repnop@google.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Reviewed-by: Matthew Bobrowski <repnop@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- David Hildenbrand <david@redhat.com>:
  - Also document that the caller is expected to decrease the reference
    count on the returned task.
---
 include/linux/pid.h |  1 +
 kernel/pid.c        | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index efe87db44683..2fc0a16ec77b 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -539,6 +539,42 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
 	return pid;
 }
 
+/**
+ * pidfd_get_task() - Get the task associated with a pidfd
+ *
+ * @pidfd: pidfd for which to get the task
+ * @flags: flags associated with this pidfd
+ *
+ * Return the task associated with @pidfd. The function takes a reference on
+ * the returned task. The caller is responsible for releasing that reference.
+ *
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

