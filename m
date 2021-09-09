Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF6C405FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349159AbhIIXW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhIIXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:22:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D53C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 16:21:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g14so184017pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=optmWzoqIVOjhQXUMw5iUjXNrn25GovU7GMv1VfeFYo=;
        b=UnhmMEFEEedb/nYIRVefvpU1lJ5cyoiHEBsKXFQv4U2C39h5LMx+zhiUUfrRCdqDck
         CDuAV3R0eOIIW9YThxsoW0VrcSSHEv0NedNPVIXZkP5b/n77Yrz+McGeOwdHvTBXQSFJ
         KG5czbdgXWuO2m/iQgzN4G0/ESmE5UrjS1B0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=optmWzoqIVOjhQXUMw5iUjXNrn25GovU7GMv1VfeFYo=;
        b=wHHHuQ7WNxdiH1ho9I2ixd2mYyELRgRiCZxivgx+anPvBWVpg5O8uIogvg1Lp7D3O4
         wIrqyvDPt+riwvQlZd9ilwzyQPp9YYt4y9qQQYT53euk2MbbgDkCAvOenlJex0FP/wqE
         0sL48vsGqUTT6AIwyTefcbSmgICxE5uBtqXTeTjRDhR2VmEgrmspWgf1wzewRnvLdvqM
         SG1HgYTOxteeStp1a42qSpEMcJmh4kLo/1OnDYisnlHBcu9afMq+J2YmnwtbnOIeVpQ1
         4b3LWkKCIIBMbqT0JpcdN+G6wFWrCOvy7wzkNcf1TLFJUzd+GmSIPYmy4gsxA9vdQ0nI
         ZpcA==
X-Gm-Message-State: AOAM533xFUeiPzRaAYXDH3Bq2z9J+EouaDgqtioXRDob49d7EAK8s+ez
        JaROUgm4RLoj+qLkDmzrKwLfMg==
X-Google-Smtp-Source: ABdhPJw9Rgvnj20pjw8zoOIoGNR6si9d5MfAS7qI0rSDmxdPGsldEe5p12DT7v+1IPeWBYgqIe3nMA==
X-Received: by 2002:a62:403:0:b0:433:9582:d449 with SMTP id 3-20020a620403000000b004339582d449mr1083524pfe.15.1631229706076;
        Thu, 09 Sep 2021 16:21:46 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id f16sm3178210pja.38.2021.09.09.16.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:21:45 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v1 1/1] binder: fix freeze race
Date:   Thu,  9 Sep 2021 16:21:41 -0700
Message-Id: <20210909232141.2489691-2-dualli@chromium.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210909232141.2489691-1-dualli@chromium.org>
References: <20210909232141.2489691-1-dualli@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

Currently cgroup freezer is used to freeze the application threads, and
BINDER_FREEZE is used to freeze binder interface. There's already a
mechanism for BINDER_FREEZE to wait for any existing transactions to
drain out before actually freezing the binder interface.

But freezing an app requires 2 steps, freezing the binder interface with
BINDER_FREEZEwhich and then freezing the application main threads with
cgroupfs. This is not an atomic operation. The following race issue
might happen.

1) Binder interface is frozen by ioctl(BINDER_FREEZE);
2) Main thread initiates a new sync binder transaction;
3) Main thread is frozen by "echo 1 > cgroup.freeze";
4) The response reaches the frozen thread, which will unexpectedly fail.

This patch provides a mechanism for user space freezer manager to check
if there's any new pending transaction happening between BINDER_FREEZE
and freezing main thread. If there's any, the main thread freezing
operation can be rolled back.

Furthermore, the response might reach the binder driver before the
rollback actually happens. That will also cause failed transaction.

As the other process doesn't wait for another response of the response,
the failed response transaction can be fixed by treating the response
transaction like an oneway/async one, allowing it to reach the frozen
thread. And it will be consumed when the thread gets unfrozen later.

Bug: 198493121
Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c          | 32 +++++++++++++++++++++++++++----
 drivers/android/binder_internal.h |  2 ++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d9030cb6b1e4..f9713a97578c 100644
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
 
+static int binder_txns_pending(struct binder_proc *proc)
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
+		if (binder_txns_pending(target_proc))
+			ret = -EAGAIN;
+		binder_inner_proc_unlock(target_proc);
+	}
+
 	if (ret < 0) {
 		binder_inner_proc_lock(target_proc);
 		target_proc->is_frozen = false;
@@ -4705,7 +4728,8 @@ static int binder_ioctl_get_freezer_info(
 		if (target_proc->pid == info->pid) {
 			found = true;
 			binder_inner_proc_lock(target_proc);
-			info->sync_recv |= target_proc->sync_recv;
+			info->sync_recv |= target_proc->sync_recv |
+					(binder_txns_pending(target_proc) << 1);
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
-- 
2.33.0.309.g3052b89438-goog

