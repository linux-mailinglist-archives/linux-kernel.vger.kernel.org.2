Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86536806B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhDVM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236331AbhDVM2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:28:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F32736145F;
        Thu, 22 Apr 2021 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619094467;
        bh=IwrgQ2DHY7E3HxCwrImEUmzADSB3e4IKq5hYInbBla8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cY6gKLmcxSZBjqz+naYfBuZ2cJwCkkBqsl/4yCwjsZhWTLGGML5Mi/nPAsEp4azbZ
         qtLbipqnHTC2Bz6XK330yu9Y+UjmoCMqmtegEu3ljLlBMCiOZSuyHCiiWFhNdT/Up2
         PGFRCeEgvSuqVxrnNLsNslogQ1tERUt+g5GU26kx4QjeIlKSU1chGey1vXFsv5en85
         +3FGB6zRBhI4HxzLC9YmMACMsXTHR/ORdyy7JAOA0mrwbPXCh9x/lu5TsAAhhozgVP
         Vz7aGuk/hwSsx2G9cDirBKyxUczdMxaNZrRUPzZ+4vAuY1Et9WJWknXawD1KWz/UPY
         O1a6uf4o+B0wA==
From:   legion@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of ucounts
Date:   Thu, 22 Apr 2021 14:27:12 +0200
Message-Id: <2531f42f7884bbfee56a978040b3e0d25cdf6cde.1619094428.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1619094428.git.legion@kernel.org>
References: <cover.1619094428.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Gladkov <legion@kernel.org>

The rlimit counter is tied to uid in the user_namespace. This allows
rlimit values to be specified in userns even if they are already
globally exceeded by the user. However, the value of the previous
user_namespaces cannot be exceeded.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/sched/user.h     |  4 ----
 include/linux/user_namespace.h |  1 +
 ipc/mqueue.c                   | 40 ++++++++++++++++++----------------
 kernel/fork.c                  |  1 +
 kernel/ucount.c                |  1 +
 kernel/user_namespace.c        |  1 +
 6 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index d33d867ad6c1..8a34446681aa 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -18,10 +18,6 @@ struct user_struct {
 #endif
 #ifdef CONFIG_EPOLL
 	atomic_long_t epoll_watches; /* The number of file descriptors currently watched */
-#endif
-#ifdef CONFIG_POSIX_MQUEUE
-	/* protected by mq_lock	*/
-	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
 #endif
 	unsigned long locked_shm; /* How many pages of mlocked shm ? */
 	unsigned long unix_inflight;	/* How many files in flight in unix sockets */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index d5bb4abb8f3e..21ad1ad1b990 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -51,6 +51,7 @@ enum ucount_type {
 	UCOUNT_INOTIFY_WATCHES,
 #endif
 	UCOUNT_RLIMIT_NPROC,
+	UCOUNT_RLIMIT_MSGQUEUE,
 	UCOUNT_COUNTS,
 };
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 8031464ed4ae..461fcf8c873d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -144,7 +144,7 @@ struct mqueue_inode_info {
 	struct pid *notify_owner;
 	u32 notify_self_exec_id;
 	struct user_namespace *notify_user_ns;
-	struct user_struct *user;	/* user who created, for accounting */
+	struct ucounts *ucounts;	/* user who created, for accounting */
 	struct sock *notify_sock;
 	struct sk_buff *notify_cookie;
 
@@ -292,7 +292,6 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 		struct ipc_namespace *ipc_ns, umode_t mode,
 		struct mq_attr *attr)
 {
-	struct user_struct *u = current_user();
 	struct inode *inode;
 	int ret = -ENOMEM;
 
@@ -321,7 +320,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 		info->notify_owner = NULL;
 		info->notify_user_ns = NULL;
 		info->qsize = 0;
-		info->user = NULL;	/* set when all is ok */
+		info->ucounts = NULL;	/* set when all is ok */
 		info->msg_tree = RB_ROOT;
 		info->msg_tree_rightmost = NULL;
 		info->node_cache = NULL;
@@ -371,19 +370,23 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 		if (mq_bytes + mq_treesize < mq_bytes)
 			goto out_inode;
 		mq_bytes += mq_treesize;
-		spin_lock(&mq_lock);
-		if (u->mq_bytes + mq_bytes < u->mq_bytes ||
-		    u->mq_bytes + mq_bytes > rlimit(RLIMIT_MSGQUEUE)) {
+		info->ucounts = get_ucounts(current_ucounts());
+		if (info->ucounts) {
+			long msgqueue;
+
+			spin_lock(&mq_lock);
+			msgqueue = inc_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
+			if (msgqueue == LONG_MAX || msgqueue > rlimit(RLIMIT_MSGQUEUE)) {
+				dec_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
+				spin_unlock(&mq_lock);
+				put_ucounts(info->ucounts);
+				info->ucounts = NULL;
+				/* mqueue_evict_inode() releases info->messages */
+				ret = -EMFILE;
+				goto out_inode;
+			}
 			spin_unlock(&mq_lock);
-			/* mqueue_evict_inode() releases info->messages */
-			ret = -EMFILE;
-			goto out_inode;
 		}
-		u->mq_bytes += mq_bytes;
-		spin_unlock(&mq_lock);
-
-		/* all is ok */
-		info->user = get_uid(u);
 	} else if (S_ISDIR(mode)) {
 		inc_nlink(inode);
 		/* Some things misbehave if size == 0 on a directory */
@@ -497,7 +500,6 @@ static void mqueue_free_inode(struct inode *inode)
 static void mqueue_evict_inode(struct inode *inode)
 {
 	struct mqueue_inode_info *info;
-	struct user_struct *user;
 	struct ipc_namespace *ipc_ns;
 	struct msg_msg *msg, *nmsg;
 	LIST_HEAD(tmp_msg);
@@ -520,8 +522,7 @@ static void mqueue_evict_inode(struct inode *inode)
 		free_msg(msg);
 	}
 
-	user = info->user;
-	if (user) {
+	if (info->ucounts) {
 		unsigned long mq_bytes, mq_treesize;
 
 		/* Total amount of bytes accounted for the mqueue */
@@ -533,7 +534,7 @@ static void mqueue_evict_inode(struct inode *inode)
 					  info->attr.mq_msgsize);
 
 		spin_lock(&mq_lock);
-		user->mq_bytes -= mq_bytes;
+		dec_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
 		/*
 		 * get_ns_from_inode() ensures that the
 		 * (ipc_ns = sb->s_fs_info) is either a valid ipc_ns
@@ -543,7 +544,8 @@ static void mqueue_evict_inode(struct inode *inode)
 		if (ipc_ns)
 			ipc_ns->mq_queues_count--;
 		spin_unlock(&mq_lock);
-		free_uid(user);
+		put_ucounts(info->ucounts);
+		info->ucounts = NULL;
 	}
 	if (ipc_ns)
 		put_ipc_ns(ipc_ns);
diff --git a/kernel/fork.c b/kernel/fork.c
index d8a4956463ae..85c6094f5a48 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -823,6 +823,7 @@ void __init fork_init(void)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
 	init_user_ns.ucount_max[UCOUNT_RLIMIT_NPROC] = task_rlimit(&init_task, RLIMIT_NPROC);
+	init_user_ns.ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = task_rlimit(&init_task, RLIMIT_MSGQUEUE);
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 6caa56f7dec8..6e6f936a5963 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -80,6 +80,7 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
 #endif
+	{ },
 	{ },
 	{ }
 };
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 2434b13b02e5..cc90d5203acf 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -122,6 +122,7 @@ int create_user_ns(struct cred *new)
 		ns->ucount_max[i] = INT_MAX;
 	}
 	ns->ucount_max[UCOUNT_RLIMIT_NPROC] = rlimit(RLIMIT_NPROC);
+	ns->ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = rlimit(RLIMIT_MSGQUEUE);
 	ns->ucounts = ucounts;
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
-- 
2.29.3

