Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2E428E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhJKNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237017AbhJKNfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:35:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FF7460F38;
        Mon, 11 Oct 2021 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633959202;
        bh=DXIzCSpi0RMG4dxsT+13/zfQG6b0wwvFu8K9jUKsz4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boN89nL87b+2RXpe4mOrWkPGADimTy3zB2vYJVOVXzZe9mJTtGw1E5nYKI3FU8g77
         lWdg437+a7T1oKsakmN7/slXtLUMHypqF3acPLY9bXdB1ULVngI66/kHaGzrXMBOC+
         xcnHkg1DnHJs8g49J9jGjt9Fr9cE/8Lh7cRWZ15UXEzGPWb0gtHZ0XUQ4O1JdqlpIP
         tCCSw3ga+K5OzvQB8jUGZkIdjBMdUUIscvGxe3U4pPvfLvKPO0Dy0Y8P7ErQNJNwn8
         ttOK4+d9xZ/+HRSf0IpdxKW9AEIfbe9E8ogHcZ16Lh6puUH0q7ZaVJscFAMVBOwFLm
         qksEaMJ0KeyPw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 2/2] mm: use pidfd_get_task()
Date:   Mon, 11 Oct 2021 15:32:45 +0200
Message-Id: <20211011133245.1703103-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011133245.1703103-1-brauner@kernel.org>
References: <20211011133245.1703103-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; h=from:subject; bh=hPRC+QAhxeSGyr5q6D0CanWJl4f/7BbqBOnGLZetuAE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSm2PxMcnkzIST7bdw6hkkrbZqTuN5e7t6/sOWp07cFZnGX bXTVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyajkjw4KFN67P+/nA+6990t3uc0 lfd5/65RHpzheW8SP+jUWb6iqG/6Xp8+cuaYv/Yd+yxWPCBMWrZQIZH5a9/tys1G4smTV/DwMA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Instead of duplicating the same code in two places use the newly added
pidfd_get_task() helper. This fixes an (unimportant for now) bug where
PIDTYPE_PID is used whereas PIDTYPE_TGID should have been used.

Link: https://lore.kernel.org/r/20211004125050.1153693-3-christian.brauner@ubuntu.com
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
unchanged
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

