Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DED334BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhCJWxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhCJWwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:52:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:52:54 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b23so4506328pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQSP0RRyiScKpdlCb/43wtX66hVHg/oaQG+SQB5/BO4=;
        b=ECbXggWV3tnlNgfRe1ZDrU5+85SwkLAi7Ru1Ns2QdZwxsRJDysDIZZCyb6ETKFJBZ/
         TQNwv/V/DLDnYXMcOiyOkk3v/nQePne7CeKkXN0SCxSJyCgaYIjJf+NfWu/Do9GQL9nA
         wrnnvDQbA7H6KSYqN7nJqV3177LAWxYfMevgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQSP0RRyiScKpdlCb/43wtX66hVHg/oaQG+SQB5/BO4=;
        b=O+Z/njUza8izA/8vBcpV3J7WDZ24p7jAY9wRtAGte27oM5J2PCidJGNFQhErnwnnAv
         JeBSPlFpW0qqKfYBSjZQVO8xsudtqdAHrc0Z9PSkkt2+AGHFqD+JNNeGuMuSIejnL3C1
         yuaP6rJjzOnXdzW5TMzSYZOOtqqWh+Pktqehc7d08xTQfrLXE9cT4PzlK1qOX4vk1MV6
         brN+j90ZtpefjIqbArGBEriMhsCywXMM472sD1/BZ4ut+2u1q/SZenu71+viKHNNUDZn
         sEPyI+MkU3ZkNq6MC0xh0bCGRH7z9S9MBI0tm5Ht7+7PfDdGKgA1cLjtTOd+P2F5bAV+
         nMMQ==
X-Gm-Message-State: AOAM532i2iSsPeXfg2Jcl1k2Ie2wYuXMrIcSAD0cM2b8HVm/mj+2PRk/
        oAtoeQqnkfpaatrXFx1jwHpZ1g==
X-Google-Smtp-Source: ABdhPJzCUUOp0osZJ+U+1U/mhFBx4jaF2SZCgjDrht5VOzvygBl4oSw8HhHSds1r1ujqHn2XzJdGcA==
X-Received: by 2002:a62:1997:0:b029:1ed:5de5:5f1c with SMTP id 145-20020a6219970000b02901ed5de55f1cmr4779924pfz.14.1615416774383;
        Wed, 10 Mar 2021 14:52:54 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t22sm353384pjo.45.2021.03.10.14.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:52:54 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v1 1/3] binder: BINDER_FREEZE ioctl
Date:   Wed, 10 Mar 2021 14:52:49 -0800
Message-Id: <20210310225251.2577580-2-dualli@chromium.org>
X-Mailer: git-send-email 2.31.0.rc1.246.gcd05c9c855-goog
In-Reply-To: <20210310225251.2577580-1-dualli@chromium.org>
References: <20210310225251.2577580-1-dualli@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Ballesio <balejs@google.com>

Frozen tasks can't process binder transactions, so a way is required to
inform transmitting ends of communication failures due to the frozen
state of their receiving counterparts. Additionally, races are possible
between transitions to frozen state and binder transactions enqueued to
a specific process.

Implement BINDER_FREEZE ioctl for user space to inform the binder driver
about the intention to freeze or unfreeze a process. When the ioctl is
called, block the caller until any pending binder transactions toward
the target process are flushed. Return an error to transactions to
processes marked as frozen.

Signed-off-by: Marco Ballesio <balejs@google.com>
Co-developed-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c            | 137 ++++++++++++++++++++++++++--
 drivers/android/binder_internal.h   |  12 +++
 include/uapi/linux/android/binder.h |  13 +++
 3 files changed, 152 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c119736ca56a..9ec3ba038652 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1506,6 +1506,10 @@ static void binder_free_transaction(struct binder_transaction *t)
 
 	if (target_proc) {
 		binder_inner_proc_lock(target_proc);
+		target_proc->outstanding_txns--;
+		WARN_ON(target_proc->outstanding_txns < 0);
+		if (!target_proc->outstanding_txns && target_proc->is_frozen)
+			wake_up_interruptible_all(&target_proc->freeze_wait);
 		if (t->buffer)
 			t->buffer->transaction = NULL;
 		binder_inner_proc_unlock(target_proc);
@@ -2331,10 +2335,11 @@ static int binder_fixup_parent(struct binder_transaction *t,
  * If the @thread parameter is not NULL, the transaction is always queued
  * to the waitlist of that specific thread.
  *
- * Return:	true if the transactions was successfully queued
- *		false if the target process or thread is dead
+ * Return:	0 if the transaction was successfully queued
+ *		BR_DEAD_REPLY if the target process or thread is dead
+ *		BR_FROZEN_REPLY if the target process or thread is frozen
  */
-static bool binder_proc_transaction(struct binder_transaction *t,
+static int binder_proc_transaction(struct binder_transaction *t,
 				    struct binder_proc *proc,
 				    struct binder_thread *thread)
 {
@@ -2354,10 +2359,13 @@ static bool binder_proc_transaction(struct binder_transaction *t,
 
 	binder_inner_proc_lock(proc);
 
-	if (proc->is_dead || (thread && thread->is_dead)) {
+	if ((proc->is_frozen && !oneway) || proc->is_dead ||
+			(thread && thread->is_dead)) {
+		bool proc_is_dead = proc->is_dead
+			|| (thread && thread->is_dead);
 		binder_inner_proc_unlock(proc);
 		binder_node_unlock(node);
-		return false;
+		return proc_is_dead ? BR_DEAD_REPLY : BR_FROZEN_REPLY;
 	}
 
 	if (!thread && !pending_async)
@@ -2373,10 +2381,11 @@ static bool binder_proc_transaction(struct binder_transaction *t,
 	if (!pending_async)
 		binder_wakeup_thread_ilocked(proc, thread, !oneway /* sync */);
 
+	proc->outstanding_txns++;
 	binder_inner_proc_unlock(proc);
 	binder_node_unlock(node);
 
-	return true;
+	return 0;
 }
 
 /**
@@ -3013,13 +3022,16 @@ static void binder_transaction(struct binder_proc *proc,
 	if (reply) {
 		binder_enqueue_thread_work(thread, tcomplete);
 		binder_inner_proc_lock(target_proc);
-		if (target_thread->is_dead) {
+		if (target_thread->is_dead || target_proc->is_frozen) {
+			return_error = target_thread->is_dead ?
+				BR_DEAD_REPLY : BR_FROZEN_REPLY;
 			binder_inner_proc_unlock(target_proc);
 			goto err_dead_proc_or_thread;
 		}
 		BUG_ON(t->buffer->async_transaction != 0);
 		binder_pop_transaction_ilocked(target_thread, in_reply_to);
 		binder_enqueue_thread_work_ilocked(target_thread, &t->work);
+		target_proc->outstanding_txns++;
 		binder_inner_proc_unlock(target_proc);
 		wake_up_interruptible_sync(&target_thread->wait);
 		binder_free_transaction(in_reply_to);
@@ -3038,7 +3050,9 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from_parent = thread->transaction_stack;
 		thread->transaction_stack = t;
 		binder_inner_proc_unlock(proc);
-		if (!binder_proc_transaction(t, target_proc, target_thread)) {
+		return_error = binder_proc_transaction(t,
+				target_proc, target_thread);
+		if (return_error) {
 			binder_inner_proc_lock(proc);
 			binder_pop_transaction_ilocked(thread, t);
 			binder_inner_proc_unlock(proc);
@@ -3048,7 +3062,8 @@ static void binder_transaction(struct binder_proc *proc,
 		BUG_ON(target_node == NULL);
 		BUG_ON(t->buffer->async_transaction != 1);
 		binder_enqueue_thread_work(thread, tcomplete);
-		if (!binder_proc_transaction(t, target_proc, NULL))
+		return_error = binder_proc_transaction(t, target_proc, NULL);
+		if (return_error)
 			goto err_dead_proc_or_thread;
 	}
 	if (target_thread)
@@ -3065,7 +3080,6 @@ static void binder_transaction(struct binder_proc *proc,
 	return;
 
 err_dead_proc_or_thread:
-	return_error = BR_DEAD_REPLY;
 	return_error_line = __LINE__;
 	binder_dequeue_work(proc, tcomplete);
 err_translate_failed:
@@ -4298,6 +4312,7 @@ static void binder_free_proc(struct binder_proc *proc)
 
 	BUG_ON(!list_empty(&proc->todo));
 	BUG_ON(!list_empty(&proc->delivered_death));
+	WARN_ON(proc->outstanding_txns);
 	device = container_of(proc->context, struct binder_device, context);
 	if (refcount_dec_and_test(&device->ref)) {
 		kfree(proc->context->name);
@@ -4359,6 +4374,7 @@ static int binder_thread_release(struct binder_proc *proc,
 			     (t->to_thread == thread) ? "in" : "out");
 
 		if (t->to_thread == thread) {
+			thread->proc->outstanding_txns--;
 			t->to_proc = NULL;
 			t->to_thread = NULL;
 			if (t->buffer) {
@@ -4609,6 +4625,45 @@ static int binder_ioctl_get_node_debug_info(struct binder_proc *proc,
 	return 0;
 }
 
+static int binder_ioctl_freeze(struct binder_freeze_info *info,
+			       struct binder_proc *target_proc)
+{
+	int ret = 0;
+
+	if (!info->enable) {
+		binder_inner_proc_lock(target_proc);
+		target_proc->is_frozen = false;
+		binder_inner_proc_unlock(target_proc);
+		return 0;
+	}
+
+	/*
+	 * Freezing the target. Prevent new transactions by
+	 * setting frozen state. If timeout specified, wait
+	 * for transactions to drain.
+	 */
+	binder_inner_proc_lock(target_proc);
+	target_proc->is_frozen = true;
+	binder_inner_proc_unlock(target_proc);
+
+	if (info->timeout_ms > 0)
+		ret = wait_event_interruptible_timeout(
+			target_proc->freeze_wait,
+			(!target_proc->outstanding_txns),
+			msecs_to_jiffies(info->timeout_ms));
+
+	if (!ret && target_proc->outstanding_txns)
+		ret = -EAGAIN;
+
+	if (ret < 0) {
+		binder_inner_proc_lock(target_proc);
+		target_proc->is_frozen = false;
+		binder_inner_proc_unlock(target_proc);
+	}
+
+	return ret;
+}
+
 static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int ret;
@@ -4727,6 +4782,66 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	}
+	case BINDER_FREEZE: {
+		struct binder_freeze_info info;
+		struct binder_proc **target_procs = NULL, *target_proc;
+		int target_procs_count = 0, i = 0;
+
+		ret = 0;
+
+		if (copy_from_user(&info, ubuf, sizeof(info))) {
+			ret = -EFAULT;
+			goto err;
+		}
+
+		mutex_lock(&binder_procs_lock);
+		hlist_for_each_entry(target_proc, &binder_procs, proc_node) {
+			if (target_proc->pid == info.pid)
+				target_procs_count++;
+		}
+
+		if (target_procs_count == 0) {
+			mutex_unlock(&binder_procs_lock);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		target_procs = kcalloc(target_procs_count,
+				       sizeof(struct binder_proc *),
+				       GFP_KERNEL);
+
+		if (!target_procs) {
+			mutex_unlock(&binder_procs_lock);
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		hlist_for_each_entry(target_proc, &binder_procs, proc_node) {
+			if (target_proc->pid != info.pid)
+				continue;
+
+			binder_inner_proc_lock(target_proc);
+			target_proc->tmp_ref++;
+			binder_inner_proc_unlock(target_proc);
+
+			target_procs[i++] = target_proc;
+		}
+		mutex_unlock(&binder_procs_lock);
+
+		for (i = 0; i < target_procs_count; i++) {
+			if (ret >= 0)
+				ret = binder_ioctl_freeze(&info,
+							  target_procs[i]);
+
+			binder_proc_dec_tmpref(target_procs[i]);
+		}
+
+		kfree(target_procs);
+
+		if (ret < 0)
+			goto err;
+		break;
+	}
 	default:
 		ret = -EINVAL;
 		goto err;
@@ -4823,6 +4938,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
 	INIT_LIST_HEAD(&proc->todo);
+	init_waitqueue_head(&proc->freeze_wait);
 	proc->default_priority = task_nice(current);
 	/* binderfs stashes devices in i_private */
 	if (is_binderfs_device(nodp)) {
@@ -5035,6 +5151,7 @@ static void binder_deferred_release(struct binder_proc *proc)
 	proc->tmp_ref++;
 
 	proc->is_dead = true;
+	proc->is_frozen = false;
 	threads = 0;
 	active_transactions = 0;
 	while ((n = rb_first(&proc->threads))) {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 6cd79011e35d..e6a53e98c6da 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -367,9 +367,18 @@ struct binder_ref {
  *                        (protected by binder_deferred_lock)
  * @deferred_work:        bitmap of deferred work to perform
  *                        (protected by binder_deferred_lock)
+ * @outstanding_txns:     number of transactions to be transmitted before
+ *                        processes in freeze_wait are woken up
+ *                        (protected by @inner_lock)
  * @is_dead:              process is dead and awaiting free
  *                        when outstanding transactions are cleaned up
  *                        (protected by @inner_lock)
+ * @is_frozen:            process is frozen and unable to service
+ *                        binder transactions
+ *                        (protected by @inner_lock)
+ * @freeze_wait:          waitqueue of processes waiting for all outstanding
+ *                        transactions to be processed
+ *                        (protected by @inner_lock)
  * @todo:                 list of work for this process
  *                        (protected by @inner_lock)
  * @stats:                per-process binder statistics
@@ -410,7 +419,10 @@ struct binder_proc {
 	struct task_struct *tsk;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
+	int outstanding_txns;
 	bool is_dead;
+	bool is_frozen;
+	wait_queue_head_t freeze_wait;
 
 	struct list_head todo;
 	struct binder_stats stats;
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index ec84ad106568..7eb5b818b3c1 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -217,6 +217,12 @@ struct binder_node_info_for_ref {
 	__u32            reserved3;
 };
 
+struct binder_freeze_info {
+	__u32            pid;
+	__u32            enable;
+	__u32            timeout_ms;
+};
+
 #define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
 #define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
 #define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
@@ -227,6 +233,7 @@ struct binder_node_info_for_ref {
 #define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
 #define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
 #define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
+#define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
 
 /*
  * NOTE: Two special error codes you should check for when calling
@@ -408,6 +415,12 @@ enum binder_driver_return_protocol {
 	 * The last transaction (either a bcTRANSACTION or
 	 * a bcATTEMPT_ACQUIRE) failed (e.g. out of memory).  No parameters.
 	 */
+
+	BR_FROZEN_REPLY = _IO('r', 18),
+	/*
+	 * The target of the last transaction (either a bcTRANSACTION or
+	 * a bcATTEMPT_ACQUIRE) is frozen.  No parameters.
+	 */
 };
 
 enum binder_driver_command_protocol {
-- 
2.31.0.rc1.246.gcd05c9c855-goog

