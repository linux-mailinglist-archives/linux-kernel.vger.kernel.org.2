Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A7340663B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhIJDyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 23:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhIJDy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:54:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC012C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 20:53:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so534170pjx.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 20:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOFwZQKZc5N8/5J8GkchZhDo+txPCEoFeo7OzZYVs3s=;
        b=NsOc8j8dGGqr5JN8KSDpGHn25JLQGfGiDuloUpU0LQ1V47xTW3stjNie0r6Dq0GW/d
         GVmujrTt1b9T+VpRCBnb35Y/try+qugY0wab3mO183FFE6L+cjzUm+1OABLKD1EZiH82
         OKJy0332qIcHXoRpxvWj+MVoATf0H/RgKaEmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOFwZQKZc5N8/5J8GkchZhDo+txPCEoFeo7OzZYVs3s=;
        b=UCHAc3KVNWXJWv4g6r8SgonNXotGkgivi58Gm6n+HfNnKpkpNndXGMPKCtcdWqy0Xd
         CjuXXAQgNGjW1h+MVZ46HRut0LkN6P94sjSw8MZUOCefa5wvi5RXYoZRhSpJ84onGGcU
         W+NKJXDtPUJx67tjcnzSGvg0exS8Be9N5bED/Z8/YaK2kOJYc0/RmvUc6pHKU5ujpwBe
         VQ5JmFqNbHzSeZsEyR0yEza4ph7xMp9MmoylVLu34luTkB8xITQfiriMxS2s+WcETU8k
         EupPo9Uq/Of0e3nmgBu298Je8seAVmf82b/SCQBXcfsJqqyJW3ysTxQMURm8eNnvy2zd
         oE5w==
X-Gm-Message-State: AOAM532b9E7pqZ/+2MSg0RtajAIe5wxC7O9wtuyl8VLRjQNafVY6uhed
        acINDamSKJZe5cyn5JSD2vr4jQ==
X-Google-Smtp-Source: ABdhPJzmQLvmcPFkP5omIdzRrufR1QCcKOwYHi+G+qFV1+APsMctFIHxa5XVv7fPIfrfFuSli5Xvnw==
X-Received: by 2002:a17:902:e153:b0:13b:63ba:7288 with SMTP id d19-20020a170902e15300b0013b63ba7288mr1033577pla.33.1631245999249;
        Thu, 09 Sep 2021 20:53:19 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id u8sm3374344pfk.212.2021.09.09.20.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 20:53:18 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 1/1] binder: fix freeze race
Date:   Thu,  9 Sep 2021 20:53:16 -0700
Message-Id: <20210910035316.2873554-2-dualli@chromium.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210910035316.2873554-1-dualli@chromium.org>
References: <20210910035316.2873554-1-dualli@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

Currently cgroup freezer is used to freeze the application threads, and
BINDER_FREEZE is used to freeze the corresponding binder interface.
There's already a mechanism in ioctl(BINDER_FREEZE) to wait for any
existing transactions to drain out before actually freezing the binder
interface.

But freezing an app requires 2 steps, freezing the binder interface with
ioctl(BINDER_FREEZE) and then freezing the application main threads with
cgroupfs. This is not an atomic operation. The following race issue
might happen.

1) Binder interface is frozen by ioctl(BINDER_FREEZE);
2) Main thread A initiates a new sync binder transaction to process B;
3) Main thread A is frozen by "echo 1 > cgroup.freeze";
4) The response from process B reaches the frozen thread, which will
unexpectedly fail.

This patch provides a mechanism to check if there's any new pending
transaction happening between ioctl(BINDER_FREEZE) and freezing the
main thread. If there's any, the main thread freezing operation can
be rolled back to finish the pending transaction.

Furthermore, the response might reach the binder driver before the
rollback actually happens. That will still cause failed transaction.

As the other process doesn't wait for another response of the response,
the response transaction failure can be fixed by treating the response
transaction like an oneway/async one, allowing it to reach the frozen
thread. And it will be consumed when the thread gets unfrozen later.

Fixes: 432ff1e91694 ("binder: BINDER_FREEZE ioctl")
Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c            | 34 +++++++++++++++++++++++++----
 drivers/android/binder_internal.h   |  2 ++
 include/uapi/linux/android/binder.h |  7 ++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d9030cb6b1e4..eaffdf5f692c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3038,9 +3038,8 @@ static void binder_transaction(struct binder_proc *proc,
 	if (reply) {
 		binder_enqueue_thread_work(thread, tcomplete);
 		binder_inner_proc_lock(target_proc);
-		if (target_thread->is_dead || target_proc->is_frozen) {
-			return_error = target_thread->is_dead ?
-				BR_DEAD_REPLY : BR_FROZEN_REPLY;
+		if (target_thread->is_dead) {
+			return_error = BR_DEAD_REPLY;
 			binder_inner_proc_unlock(target_proc);
 			goto err_dead_proc_or_thread;
 		}
@@ -4648,6 +4647,22 @@ static int binder_ioctl_get_node_debug_info(struct binder_proc *proc,
 	return 0;
 }
 
+static int binder_txns_pending_ilocked(struct binder_proc *proc)
+{
+	struct rb_node *n;
+	struct binder_thread *thread;
+
+	if (proc->outstanding_txns > 0)
+		return 1;
+
+	for (n = rb_first(&proc->threads); n; n = rb_next(n)) {
+		thread = rb_entry(n, struct binder_thread, rb_node);
+		if (thread->transaction_stack)
+			return 1;
+	}
+	return 0;
+}
+
 static int binder_ioctl_freeze(struct binder_freeze_info *info,
 			       struct binder_proc *target_proc)
 {
@@ -4682,6 +4697,14 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
 	if (!ret && target_proc->outstanding_txns)
 		ret = -EAGAIN;
 
+	/* Also check pending transactions that wait for reply */
+	if (ret >= 0) {
+		binder_inner_proc_lock(target_proc);
+		if (binder_txns_pending_ilocked(target_proc))
+			ret = -EAGAIN;
+		binder_inner_proc_unlock(target_proc);
+	}
+
 	if (ret < 0) {
 		binder_inner_proc_lock(target_proc);
 		target_proc->is_frozen = false;
@@ -4696,6 +4719,7 @@ static int binder_ioctl_get_freezer_info(
 {
 	struct binder_proc *target_proc;
 	bool found = false;
+	int txns_pending;
 
 	info->sync_recv = 0;
 	info->async_recv = 0;
@@ -4705,7 +4729,9 @@ static int binder_ioctl_get_freezer_info(
 		if (target_proc->pid == info->pid) {
 			found = true;
 			binder_inner_proc_lock(target_proc);
-			info->sync_recv |= target_proc->sync_recv;
+			txns_pending = binder_txns_pending_ilocked(target_proc);
+			info->sync_recv |= target_proc->sync_recv |
+					(txns_pending << 1);
 			info->async_recv |= target_proc->async_recv;
 			binder_inner_proc_unlock(target_proc);
 		}
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 810c0b84d3f8..402c4d4362a8 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -378,6 +378,8 @@ struct binder_ref {
  *                        binder transactions
  *                        (protected by @inner_lock)
  * @sync_recv:            process received sync transactions since last frozen
+ *                        bit 0: received sync transaction after being frozen
+ *                        bit 1: new pending sync transaction during freezing
  *                        (protected by @inner_lock)
  * @async_recv:           process received async transactions since last frozen
  *                        (protected by @inner_lock)
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 20e435fe657a..3246f2c74696 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -225,7 +225,14 @@ struct binder_freeze_info {
 
 struct binder_frozen_status_info {
 	__u32            pid;
+
+	/* process received sync transactions since last frozen
+	 * bit 0: received sync transaction after being frozen
+	 * bit 1: new pending sync transaction during freezing
+	 */
 	__u32            sync_recv;
+
+	/* process received async transactions since last frozen */
 	__u32            async_recv;
 };
 
-- 
2.33.0.309.g3052b89438-goog

