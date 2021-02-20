Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F289D320493
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBTJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBTJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:05:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039EDC06178A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:09 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a4so6888329pgc.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHoTVMZ1UCBwdJSMckbP0vCuuAUYGs3AMqboTTCk/6s=;
        b=M8jyYb1AfjIub5FpjkEgb8pECdA0sptmR8F+v8kGpyHkMkWx5xgrkrprMX0eQ6f6Kx
         zRWbb/N7GU9/p/7ZNcIWz4/OVtwc90PAhG2/IDuD5mBYpCeJ1f3YRr0JMA4OY3o9mkkD
         hjdn+8Q7mGF769MtadV1iLSubqEk6Umr2T82M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHoTVMZ1UCBwdJSMckbP0vCuuAUYGs3AMqboTTCk/6s=;
        b=VP4KEDU0299PszlfvBRwL8C9xKZq3/qORen+0YgYaRZfnugeTk1f3Av43osXKqAPn9
         vGd5VE2OenFrg0LmRqYnugUt3b7k1twxQWlh/QsvpUeW4YzYF4SAr5k3Qo4qKIZ+YTzx
         gDgh9ikNMekPTmUdymzfpOPhUlc5didwA7bJdXOuquzcS8mOzWTNes+UqDhp+uNbAx87
         JPBpeGi5xfrur+CsurmQfSMJORJGOrd/3MvjPNhEKBbWTc6WeM5ookTW2eV6BkWL8cRV
         Vqs1jvkPDGym7zIXhWXGyt3q00p7N2tJMi0UOWzyc1jkBoEpKDy+OMDQRZGMsidfyuVI
         hvvw==
X-Gm-Message-State: AOAM530NzB9n7cZp59adlyAK4HAJYJDcZXH4+ls+g+BaVW0rNgF1Cc1q
        xI3ow7hgDcpx7yI86ihY8XKMjg==
X-Google-Smtp-Source: ABdhPJzApZ6k0Y19OSx4K6RvG/WNKN9UmXIyC/kvlTGF5fypxNXvc2BsMrmCOODYnzulrL3w8peAhA==
X-Received: by 2002:a62:6346:0:b029:1db:a562:be79 with SMTP id x67-20020a6263460000b02901dba562be79mr5734559pfb.81.1613811908173;
        Sat, 20 Feb 2021 01:05:08 -0800 (PST)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id g62sm12226727pgc.32.2021.02.20.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 01:05:07 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [RFC PATCH 2/3] seccomp: Add wait_killable semantic to seccomp user notifier
Date:   Sat, 20 Feb 2021 01:05:01 -0800
Message-Id: <20210220090502.7202-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220090502.7202-1-sargun@sargun.me>
References: <20210220090502.7202-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user notifier feature allows for filtering of seccomp notifications in
userspace. While the user notifier is handling the syscall, the notifying
process can be preempted, thus ending the notification. This has become a
growing problem, as Golang has adopted signal based async preemption[1]. In
this, it will preempt every 10ms, thus leaving the supervisor less than
10ms to respond to a given notification. If the syscall require I/O (mount,
connect) on behalf of the process, it can easily take 10ms.

This allows the supervisor to set a flag that moves the process into a
state where it is only killable by terminating signals as opposed to all
signals.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>

[1]: https://github.com/golang/go/issues/24543
---
 include/uapi/linux/seccomp.h | 10 ++++++++++
 kernel/seccomp.c             | 35 +++++++++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 6ba18b82a02e..f9acdb58138b 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -70,6 +70,16 @@ struct seccomp_notif_sizes {
 	__u16 seccomp_data;
 };
 
+/*
+ * Valid flags for struct seccomp_notif
+ *
+ * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE
+ *
+ * Prevent the notifying process from being interrupted by non-fatal, unmasked
+ * signals.
+ */
+#define SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE (1UL << 0)
+
 struct seccomp_notif {
 	__u64 id;
 	__u32 pid;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b48fb0a29455..f8c6c47df5d8 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -97,6 +97,8 @@ struct seccomp_knotif {
 
 	/* outstanding addfd requests */
 	struct list_head addfd;
+
+	bool wait_killable;
 };
 
 /**
@@ -1082,6 +1084,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	long ret = 0;
 	struct seccomp_knotif n = {};
 	struct seccomp_kaddfd *addfd, *tmp;
+	bool wait_killable = false;
 
 	mutex_lock(&match->notify_lock);
 	err = -ENOSYS;
@@ -1103,8 +1106,14 @@ static int seccomp_do_user_notification(int this_syscall,
 	 * This is where we wait for a reply from userspace.
 	 */
 	do {
+		wait_killable = n.state == SECCOMP_NOTIFY_SENT &&
+				n.wait_killable;
+
 		mutex_unlock(&match->notify_lock);
-		err = wait_for_completion_interruptible(&n.ready);
+		if (wait_killable)
+			err = wait_for_completion_killable(&n.ready);
+		else
+			err = wait_for_completion_interruptible(&n.ready);
 		mutex_lock(&match->notify_lock);
 		if (err != 0)
 			goto interrupted;
@@ -1420,14 +1429,16 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
+	ret = copy_from_user(&unotif, buf, sizeof(unotif));
+	if (ret)
+		return -EFAULT;
+
 	/* Verify that we're not given garbage to keep struct extensible. */
-	ret = check_zeroed_user(buf, sizeof(unotif));
-	if (ret < 0)
-		return ret;
-	if (!ret)
+	if (unotif.flags & ~(SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE))
 		return -EINVAL;
 
-	memset(&unotif, 0, sizeof(unotif));
+	if (unotif.id || unotif.pid)
+		return -EINVAL;
 
 	ret = down_interruptible(&filter->notif->request);
 	if (ret < 0)
@@ -1455,6 +1466,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	unotif.pid = task_pid_vnr(knotif->task);
 	unotif.data = *(knotif->data);
 
+	if (unotif.flags & SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE) {
+		knotif->wait_killable = true;
+		complete(&knotif->ready);
+	}
+
+
 	knotif->state = SECCOMP_NOTIFY_SENT;
 	wake_up_poll(&filter->wqh, EPOLLOUT | EPOLLWRNORM);
 	ret = 0;
@@ -1473,6 +1490,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		mutex_lock(&filter->notify_lock);
 		knotif = find_notification(filter, unotif.id);
 		if (knotif) {
+			/* Reset the waiting state */
+			if (knotif->wait_killable) {
+				knotif->wait_killable = false;
+				complete(&knotif->ready);
+			}
+
 			knotif->state = SECCOMP_NOTIFY_INIT;
 			up(&filter->notif->request);
 		}
-- 
2.25.1

