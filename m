Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C27420B35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhJDMxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:53:35 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39658
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233208AbhJDMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:53:33 -0400
Received: from wittgenstein.fritz.box (ip5f5bd0d9.dynamic.kabel-deutschland.de [95.91.208.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D6AFE41A73;
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
Subject: [PATCH 2/2] mm: use pidfd_get_task()
Date:   Mon,  4 Oct 2021 14:50:50 +0200
Message-Id: <20211004125050.1153693-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
References: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of duplicating the same code in two places use the newly added
pidfd_get_task() helper. This fixes an (unimportant for now) bug where
PIDTYPE_PID is used whereas PIDTYPE_TGID should have been used.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Bobrowski <repnop@google.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 mm/madvise.c  | 15 +++------------
 mm/oom_kill.c | 15 +++------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..8c927202bbe6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1235,7 +1235,6 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct iovec iovstack[UIO_FASTIOV], iovec;
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	struct pid *pid;
 	struct task_struct *task;
 	struct mm_struct *mm;
 	size_t total_len;
@@ -1250,18 +1249,12 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	if (ret < 0)
 		goto out;
 
-	pid = pidfd_get_pid(pidfd, &f_flags);
-	if (IS_ERR(pid)) {
-		ret = PTR_ERR(pid);
+	task = pidfd_get_task(pidfd, &f_flags);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
 		goto free_iov;
 	}
 
-	task = get_pid_task(pid, PIDTYPE_PID);
-	if (!task) {
-		ret = -ESRCH;
-		goto put_pid;
-	}
-
 	if (!process_madvise_behavior_valid(behavior)) {
 		ret = -EINVAL;
 		goto release_task;
@@ -1301,8 +1294,6 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	mmput(mm);
 release_task:
 	put_task_struct(task);
-put_pid:
-	put_pid(pid);
 free_iov:
 	kfree(iov);
 out:
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..70d399d5817e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1151,21 +1151,14 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	struct task_struct *p;
 	unsigned int f_flags;
 	bool reap = true;
-	struct pid *pid;
 	long ret = 0;
 
 	if (flags)
 		return -EINVAL;
 
-	pid = pidfd_get_pid(pidfd, &f_flags);
-	if (IS_ERR(pid))
-		return PTR_ERR(pid);
-
-	task = get_pid_task(pid, PIDTYPE_TGID);
-	if (!task) {
-		ret = -ESRCH;
-		goto put_pid;
-	}
+	task = pidfd_get_task(pidfd, &f_flags);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
 
 	/*
 	 * Make sure to choose a thread which still has a reference to mm
@@ -1204,8 +1197,6 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	mmdrop(mm);
 put_task:
 	put_task_struct(task);
-put_pid:
-	put_pid(pid);
 	return ret;
 #else
 	return -ENOSYS;
-- 
2.30.2

