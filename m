Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054C437026F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhD3Uux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhD3Uui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:50:38 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53336C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:49 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j3so35107995qvs.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6hiECWGoT1hxWQM2wlygrLr/LE0MxB0mzr7hlbBbFU=;
        b=PQG24a2KhhYzIPqfLxueo+WQUJoCcfVq8tX75f6OIFsAbeI/ttxz7Gjx6gUlcPCO3H
         n8nREyH7O6gRcuUN7dOD8pD2eOshOiq2vHkSAo+r9qVaZZWkVXInFTDE0ICi0hI7b4eO
         f1tmVUzK9YnxI5HpA6adXPmP0b1kQOQJjOI4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6hiECWGoT1hxWQM2wlygrLr/LE0MxB0mzr7hlbBbFU=;
        b=sbfT5OZsKZInBfQDVZyasTmWut0WZoOjFc1aw/VBkbtAEVpny+7AT70o8gSNBLDPqJ
         bNkpSwOk+geao3SqcMEbUQFOLgKWk5E0svLFtXYyvGq3Kfvvk2mF5j7MFqAe0muXYvzb
         OxNCEXq7nifR3qdcPEIYLhKQ7XmOd6bShbgEkCoLFnpMZftS6yiukEMSEKjPZDMCwFgn
         TJ9PFVv7yRUHPdg10IwzDi6+PEnQYCgXC5Q2KNos4qNvTuAYzMX59V/Q8LcvdB2F4RX2
         vQ5rQMTs7feIHd9/O9a7l3HvWVFQ4YBslKuwMgLKW0dX+rHGMXl0b72lAxuz4cP9m+NJ
         Txzg==
X-Gm-Message-State: AOAM531bUS9vUC7IZo2oIlkHX/xoUX6eWvr2fJrTbuAzV0WR4GNhtSLZ
        uiM2p3BPDi2xiAwkG2lEdXJf/g==
X-Google-Smtp-Source: ABdhPJxar8jIOfuX8TkN2pgDfEPH5cW+9ONSiPXGrD24b6+sfEcFosfKRvdHzXdeovEYPwbhkIOIRQ==
X-Received: by 2002:a0c:a98d:: with SMTP id a13mr7591877qvb.39.1619815788383;
        Fri, 30 Apr 2021 13:49:48 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id z17sm3161960qtf.10.2021.04.30.13.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:49:47 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/5] seccomp: Add wait_killable semantic to seccomp user notifier
Date:   Fri, 30 Apr 2021 13:49:36 -0700
Message-Id: <20210430204939.5152-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430204939.5152-1-sargun@sargun.me>
References: <20210430204939.5152-1-sargun@sargun.me>
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
 .../userspace-api/seccomp_filter.rst          | 22 +++---
 include/uapi/linux/seccomp.h                  |  2 +
 kernel/seccomp.c                              | 71 ++++++++++++++++++-
 3 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index bd9165241b6c..6ba4d39baf2a 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -250,14 +250,20 @@ Users can read via ``ioctl(SECCOMP_IOCTL_NOTIF_RECV)``  (or ``poll()``) on a
 seccomp notification fd to receive a ``struct seccomp_notif``, which contains
 five members: the input length of the structure, a unique-per-filter ``id``,
 the ``pid`` of the task which triggered this request (which may be 0 if the
-task is in a pid ns not visible from the listener's pid namespace), a ``flags``
-member which for now only has ``SECCOMP_NOTIF_FLAG_SIGNALED``, representing
-whether or not the notification is a result of a non-fatal signal, and the
-``data`` passed to seccomp. Userspace can then make a decision based on this
-information about what to do, and ``ioctl(SECCOMP_IOCTL_NOTIF_SEND)`` a
-response, indicating what should be returned to userspace. The ``id`` member of
-``struct seccomp_notif_resp`` should be the same ``id`` as in ``struct
-seccomp_notif``.
+task is in a pid ns not visible from the listener's pid namespace). The
+notification also contains the ``data`` passed to seccomp, and a currently
+unused filters flag.
+
+Upon receiving the notification ``ioctl(SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE)``
+can be used to make the notifying task only respond to fatal signals. Once the
+notification has been set as wait_killable, it cannot be unset. If the
+notification is already in the wait_killable state, EALREADY will be returned by
+the ioctl.
+
+Userspace can then make a decision based on this information about what to do,
+and ``ioctl(SECCOMP_IOCTL_NOTIF_SEND)`` a response, indicating what should be
+returned to userspace. The ``id`` member of ``struct seccomp_notif_resp`` should
+be the same ``id`` as in ``struct seccomp_notif``.
 
 It is worth noting that ``struct seccomp_data`` contains the values of register
 arguments to the syscall, but does not contain pointers to memory. The task's
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 6ba18b82a02e..71dbc1f7889f 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -146,5 +146,7 @@ struct seccomp_notif_addfd {
 /* On success, the return value is the remote process's added fd number */
 #define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3, \
 						struct seccomp_notif_addfd)
+/* Set flag to prevent non-fatal signal preemption */
+#define SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE	SECCOMP_IOW(4, __u64)
 
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 93684cc63285..7ac1cea6e7f0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -97,6 +97,8 @@ struct seccomp_knotif {
 
 	/* outstanding addfd requests */
 	struct list_head addfd;
+
+	bool wait_killable;
 };
 
 /**
@@ -1073,6 +1075,12 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
 	complete(&addfd->completion);
 }
 
+/* Must be called with notify_lock held */
+static inline bool notification_wait_killable(struct seccomp_knotif *n)
+{
+	return n->state == SECCOMP_NOTIFY_SENT && n->wait_killable;
+}
+
 static int seccomp_do_user_notification(int this_syscall,
 					struct seccomp_filter *match,
 					const struct seccomp_data *sd)
@@ -1103,11 +1111,33 @@ static int seccomp_do_user_notification(int this_syscall,
 	 * This is where we wait for a reply from userspace.
 	 */
 	do {
+		int wait_killable = notification_wait_killable(&n);
+
 		mutex_unlock(&match->notify_lock);
-		err = wait_for_completion_interruptible(&n.ready);
+		if (wait_killable)
+			err = wait_for_completion_killable(&n.ready);
+		else
+			err = wait_for_completion_interruptible(&n.ready);
 		mutex_lock(&match->notify_lock);
-		if (err != 0)
+		if (err != 0) {
+			/*
+			 * If the SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE was
+			 * used to change the state of the handler to
+			 * wait_killable, but a non-fatal signal arrived
+			 * before we could complete the transition, we could
+			 * erroneously finish waiting early.
+			 *
+			 * If we were previously in not in the wait_killable
+			 * state and we've transitioned to the wait_killable
+			 * state, retry waiting. wait_for_completion_killable
+			 * will check again if there is a fatal signal waiting,
+			 * or another completion (addfd).
+			 */
+			if (!wait_killable && notification_wait_killable(&n))
+				continue;
+
 			goto interrupted;
+		}
 
 		addfd = list_first_entry_or_null(&n.addfd,
 						 struct seccomp_kaddfd, list);
@@ -1477,6 +1507,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		if (knotif) {
 			knotif->state = SECCOMP_NOTIFY_INIT;
 			up(&filter->notif->request);
+
+			/* Wake the task to reset its state */
+			if (knotif->wait_killable) {
+				knotif->wait_killable = false;
+				complete(&knotif->ready);
+			}
 		}
 		mutex_unlock(&filter->notify_lock);
 	}
@@ -1648,6 +1684,35 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	return ret;
 }
 
+static long seccomp_notify_set_wait_killable(struct seccomp_filter *filter,
+					     void __user *buf)
+{
+	struct seccomp_knotif *knotif;
+	u64 id;
+	long ret;
+
+	if (copy_from_user(&id, buf, sizeof(id)))
+		return -EFAULT;
+
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret < 0)
+		return ret;
+
+	knotif = find_notification(filter, id);
+	if (!knotif || knotif->state != SECCOMP_NOTIFY_SENT) {
+		ret = -ENOENT;
+	} else if (knotif->wait_killable) {
+		ret = -EALREADY;
+	} else {
+		ret = 0;
+		knotif->wait_killable = true;
+		complete(&knotif->ready);
+	}
+
+	mutex_unlock(&filter->notify_lock);
+	return ret;
+}
+
 static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -1663,6 +1728,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE:
+		return seccomp_notify_set_wait_killable(filter, buf);
 	}
 
 	/* Extensible Argument ioctls */
-- 
2.25.1

