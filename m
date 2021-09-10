Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D0A406FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhIJQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhIJQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:43:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C10AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:42:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1898982pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5wOmmxvEtnTHLM9D1J1H3m26b1fVlAkaw2R8MzvMJE=;
        b=LwN+LeajNrJVYqWx4HzdEiyfGcUBWaE8eJDO0158AKYaRjVQL6xLvCj4NzQh8Wgk9Z
         upL2LbrF1JEwe9BD8EXdZJtLv6dRh6QGEcvWS7SazYa9rig5ru/sqDjLznhMFPJiU9K3
         n37jCmlkjv/Rz01xByo+8AdfY4tUju6JmTBs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5wOmmxvEtnTHLM9D1J1H3m26b1fVlAkaw2R8MzvMJE=;
        b=oM0s5RnDpnCrmGIO+2Nzwfdnd08TZCjjxiCkd+pcTiK/7nNPe5I/Nsa3mAHNvLCU81
         D1KfH2+g2xjc4I1XYjCLBlInov2rACKFf2wVWtaeq5o9RURgDauIJWBntvNSQfsZT2aM
         4ZU80zrdzyZvIWXdYsDdnr9E17IcdSn/YfN1ggFFasdWY3+hCrXVC0Xt0iHmycPWcOCI
         DU88S4m7bODjXxRIbCsAmNrA6nKXAGM516E/oGQd7Nvl2cYKy9wtLCZT8OK1uCoJ7AVg
         60a/OfAGpWlcYcu51tfqMHLiI0WcuHZy6RfyuvtlcOOVt0E/ai75z8aITFymYllFZtAc
         utSQ==
X-Gm-Message-State: AOAM530qU15fb/xNDsM+gTta+LNXkLYp3/klOejFJ/ZLKxtwphh4DpMq
        H5iHDhdu07QIcpmPlq3pwiaiZg==
X-Google-Smtp-Source: ABdhPJwnsNVdIo1ZWDoaakvFe4lZSV//xkhZFGe12j5igJZdOToeOgyKDIcESUHIt0r/JmiBdI9oiA==
X-Received: by 2002:a17:902:e743:b0:13a:eb0:d124 with SMTP id p3-20020a170902e74300b0013a0eb0d124mr8325551plf.38.1631292134015;
        Fri, 10 Sep 2021 09:42:14 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c133sm5546948pfb.39.2021.09.10.09.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:42:13 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 1/1] binder: fix freeze race
Date:   Fri, 10 Sep 2021 09:42:10 -0700
Message-Id: <20210910164210.2282716-2-dualli@chromium.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210910164210.2282716-1-dualli@chromium.org>
References: <20210910164210.2282716-1-dualli@chromium.org>
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

NOTE: This patch reuses the existing definition of struct
binder_frozen_status_info but expands the bit assignments of __u32
member sync_recv.

To ensure backward compatibility, bit 0 of sync_recv still indicates
there's an outstanding sync binder transaction. This patch adds new
information to bit 1 of sync_recv, indicating the binder transaction
happens exactly when there's a race.

If an existing userspace app runs on a new kernel, a sync binder call
will set bit 0 of sync_recv so ioctl(BINDER_GET_FROZEN_INFO) still
return the expected value (true). The app just doesn't check bit 1
intentionally so it doesn't have the ability to tell if there's a race.
This behavior is aligned with what happens on an old kernel which
doesn't set bit 1 at all.

A new userspace app can 1) check bit 0 to know if there's a sync binder
transaction happened when being frozen - same as before; and 2) check
bit 1 to know if that sync binder transaction happened exactly when
there's a race - a new information for rollback decision.

Fixes: 432ff1e91694 ("binder: BINDER_FREEZE ioctl")
Test: stress test with apps being frozen and initiating binder calls at
the same time, confirmed the pending transactions succeeded.
Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c            | 35 ++++++++++++++++++++++++-----
 drivers/android/binder_internal.h   |  2 ++
 include/uapi/linux/android/binder.h |  7 ++++++
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d9030cb6b1e4..1a68c2f590cf 100644
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
 
+static bool binder_txns_pending_ilocked(struct binder_proc *proc)
+{
+	struct rb_node *n;
+	struct binder_thread *thread;
+
+	if (proc->outstanding_txns > 0)
+		return true;
+
+	for (n = rb_first(&proc->threads); n; n = rb_next(n)) {
+		thread = rb_entry(n, struct binder_thread, rb_node);
+		if (thread->transaction_stack)
+			return true;
+	}
+	return false;
+}
+
 static int binder_ioctl_freeze(struct binder_freeze_info *info,
 			       struct binder_proc *target_proc)
 {
@@ -4679,8 +4694,13 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
 			(!target_proc->outstanding_txns),
 			msecs_to_jiffies(info->timeout_ms));
 
-	if (!ret && target_proc->outstanding_txns)
-		ret = -EAGAIN;
+	/* Check pending transactions that wait for reply */
+	if (ret >= 0) {
+		binder_inner_proc_lock(target_proc);
+		if (binder_txns_pending_ilocked(target_proc))
+			ret = -EAGAIN;
+		binder_inner_proc_unlock(target_proc);
+	}
 
 	if (ret < 0) {
 		binder_inner_proc_lock(target_proc);
@@ -4696,6 +4716,7 @@ static int binder_ioctl_get_freezer_info(
 {
 	struct binder_proc *target_proc;
 	bool found = false;
+	__u32 txns_pending;
 
 	info->sync_recv = 0;
 	info->async_recv = 0;
@@ -4705,7 +4726,9 @@ static int binder_ioctl_get_freezer_info(
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

