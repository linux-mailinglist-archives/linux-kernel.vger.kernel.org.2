Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BEF36B8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhDZSHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbhDZSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:07:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v20so2104051plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrSljs9p2akWCSedVPpNDBp3AdI7AQvDDvYRJ1g+BNw=;
        b=hX1O4cmxzHz/96wKySXNVSy1o/tuOKNg/8w3w5HOz3YzxjR6S9pGew+OWoSnJQlFgQ
         gnR+juglV+HGK3xVfQdnNeSyRhxGBEo3bgXf53IqqBNBiA7Fy1BJvRt3dU0/vz2fjWuS
         45OHIPX6jweV+kHhQCnBZN+APHzihpt0M34v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrSljs9p2akWCSedVPpNDBp3AdI7AQvDDvYRJ1g+BNw=;
        b=M5KCrzJrZl72YXVPybiM5nHYnJTOc/6Av0fUMs74E30TgKFlVvhhh/X9YC2V4UiY4F
         gE65/D7FeTB2Uv+mIu7Nw3N8hYasuLcS6E5BH6QJmTfp7D2AJWTkDpxSfICHwClmpXbv
         ZGsSoXU4QRbA2W1aIbAgB3SlIUzStWGXv8MBm8Im1HtQhrasn+cGp50jxnoajvgbSHzT
         EfJLHVR8wK6A0D4NwzCuvBE5LsuZ2raLT60HOAkJAjHbt1Lf4m7U2gYgWtO3TnM/Ap0s
         e50YS8TQjKvCFn1tJbRtw3UujoQ5hYwoSytrhM0HOJ12YD9tHiI8kRzRW76zh1419VMQ
         rLtQ==
X-Gm-Message-State: AOAM5307d5fXa1kNqzmBofQkPlC7Oxul2ovUfBXCJ3l1ccywok2p6UPv
        dfAtBm7ukudHzkO8t7cNMW+pzw==
X-Google-Smtp-Source: ABdhPJz/Jxxy2ss20n/gYw5KrTowBECBp8mQNBFk6Vd+p+7JDws2uMYJI83Ssqwz3dgPHNb0PmJE8w==
X-Received: by 2002:a17:90a:ea11:: with SMTP id w17mr365736pjy.6.1619460377881;
        Mon, 26 Apr 2021 11:06:17 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j7sm326835pfd.129.2021.04.26.11.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:06:17 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: [PATCH RESEND 2/5] seccomp: Add wait_killable semantic to seccomp user notifier
Date:   Mon, 26 Apr 2021 11:06:07 -0700
Message-Id: <20210426180610.2363-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426180610.2363-1-sargun@sargun.me>
References: <20210426180610.2363-1-sargun@sargun.me>
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
signals. The process can still be terminated before the supervisor receives
the notification.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>

[1]: https://github.com/golang/go/issues/24543
---
 .../userspace-api/seccomp_filter.rst          | 15 +++---
 include/uapi/linux/seccomp.h                  |  3 ++
 kernel/seccomp.c                              | 54 ++++++++++++++++---
 3 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index bd9165241b6c..75de9400d56a 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -251,13 +251,14 @@ seccomp notification fd to receive a ``struct seccomp_notif``, which contains
 five members: the input length of the structure, a unique-per-filter ``id``,
 the ``pid`` of the task which triggered this request (which may be 0 if the
 task is in a pid ns not visible from the listener's pid namespace), a ``flags``
-member which for now only has ``SECCOMP_NOTIF_FLAG_SIGNALED``, representing
-whether or not the notification is a result of a non-fatal signal, and the
-``data`` passed to seccomp. Userspace can then make a decision based on this
-information about what to do, and ``ioctl(SECCOMP_IOCTL_NOTIF_SEND)`` a
-response, indicating what should be returned to userspace. The ``id`` member of
-``struct seccomp_notif_resp`` should be the same ``id`` as in ``struct
-seccomp_notif``.
+member and the ``data`` passed to seccomp. Upon receiving the notification,
+the ``SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE`` flag may be set, which will
+try to put the task into a state where it will only respond to fatal signals.
+
+Userspace can then make a decision based on this information about what to do,
+and ``ioctl(SECCOMP_IOCTL_NOTIF_SEND)`` a response, indicating what should be
+returned to userspace. The ``id`` member of ``struct seccomp_notif_resp`` should
+be the same ``id`` as in ``struct seccomp_notif``.
 
 It is worth noting that ``struct seccomp_data`` contains the values of register
 arguments to the syscall, but does not contain pointers to memory. The task's
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 6ba18b82a02e..bc7fc8b04749 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -70,6 +70,9 @@ struct seccomp_notif_sizes {
 	__u16 seccomp_data;
 };
 
+/* Valid flags for struct seccomp_notif */
+#define SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE	(1UL << 0) /* Prevent task from being interrupted */
+
 struct seccomp_notif {
 	__u64 id;
 	__u32 pid;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 93684cc63285..b852e8617004 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -97,6 +97,8 @@ struct seccomp_knotif {
 
 	/* outstanding addfd requests */
 	struct list_head addfd;
+
+	bool wait_killable;
 };
 
 /**
@@ -1073,6 +1075,11 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
 	complete(&addfd->completion);
 }
 
+static bool notification_interruptible(struct seccomp_knotif *n)
+{
+	return !(n->state == SECCOMP_NOTIFY_SENT && n->wait_killable);
+}
+
 static int seccomp_do_user_notification(int this_syscall,
 					struct seccomp_filter *match,
 					const struct seccomp_data *sd)
@@ -1082,6 +1089,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	long ret = 0;
 	struct seccomp_knotif n = {};
 	struct seccomp_kaddfd *addfd, *tmp;
+	bool interruptible = true;
 
 	mutex_lock(&match->notify_lock);
 	err = -ENOSYS;
@@ -1103,11 +1111,31 @@ static int seccomp_do_user_notification(int this_syscall,
 	 * This is where we wait for a reply from userspace.
 	 */
 	do {
+		interruptible = notification_interruptible(&n);
+
 		mutex_unlock(&match->notify_lock);
-		err = wait_for_completion_interruptible(&n.ready);
+		if (interruptible)
+			err = wait_for_completion_interruptible(&n.ready);
+		else
+			err = wait_for_completion_killable(&n.ready);
 		mutex_lock(&match->notify_lock);
-		if (err != 0)
+
+		if (err != 0) {
+			/*
+			 * There is a race condition here where if the
+			 * notification was received with the
+			 * SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE flag, but a
+			 * non-fatal signal was received before we could
+			 * transition we could erroneously end our wait early.
+			 *
+			 * The next wait for completion will ensure the signal
+			 * was not fatal.
+			 */
+			if (interruptible && !notification_interruptible(&n))
+				continue;
+
 			goto interrupted;
+		}
 
 		addfd = list_first_entry_or_null(&n.addfd,
 						 struct seccomp_kaddfd, list);
@@ -1422,14 +1450,16 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
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
@@ -1457,6 +1487,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
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
@@ -1477,6 +1513,10 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		if (knotif) {
 			knotif->state = SECCOMP_NOTIFY_INIT;
 			up(&filter->notif->request);
+
+			/* Wake the task to reset its state */
+			if (knotif->wait_killable)
+				complete(&knotif->ready);
 		}
 		mutex_unlock(&filter->notify_lock);
 	}
-- 
2.25.1

