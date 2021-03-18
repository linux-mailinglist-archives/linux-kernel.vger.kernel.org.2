Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DB33FEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhCRFSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhCRFRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:17:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c6so3238258qtc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhNHZWi1gcEbD0E+dTnwZ0TOde7BQFM72L1zaItSgn8=;
        b=hqCN5cxET3p553/Y+fmLdnV1UsGSxJvywk3jklVOnkGnZvpUA6hKun8CrufYlDh2r+
         j3Fy1yCJs8Rm2G1uopi+FoDU9hAsxAw3W4jD80uVOnWNqu/cS4Hknb0EualTFkB+KEIU
         igzla459v2KOnJNQBLMv9f/5oX/EZ7gSXSOCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhNHZWi1gcEbD0E+dTnwZ0TOde7BQFM72L1zaItSgn8=;
        b=J4mdqXUZgNFJLU+FYnYayBtOqdHRl+vPeUMUdtZ272tdSJ5BiRInbofsx8JU04MHHy
         +ngykh3jS6CzORK8SThlzArLO/f5K0Mwd5faUjhvWl52BrbT5qihI7xptcQpySZIh2eS
         3SDLNNKfbKlNVL+v3i07ufR7wbzmeTg3az/n6sen1W6OzeWVu36vrsgq9GsGIp0PUdNc
         ayfwOREuBQK8avQRjZ8LW7YgbRYTbl4+dwYaFh88fEWvcD91IhLQTD6b1D2MST+UJDQY
         acwnX4YMh9av3MYcbFrXzbGlsge39gDgi2KGkr36lkAchW8Az8zPvoC6dJ9BEbA9PT71
         aM6Q==
X-Gm-Message-State: AOAM533rKDIqAPCeNZ+KLEAt0y8TtsvGX/wKqWhei0ttchDYHrY/dGXe
        sv5PDgOSFCbUcSSlua+eGlHrOQ==
X-Google-Smtp-Source: ABdhPJxflenaXrKFxtr6lzNVCqoJMlQIj8VIU/q/fbWdD6xWKfaHSXJkkkIB2ZEjNblgQm5d4O2dQQ==
X-Received: by 2002:a05:622a:454:: with SMTP id o20mr2210299qtx.292.1616044662349;
        Wed, 17 Mar 2021 22:17:42 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m16sm937852qkm.100.2021.03.17.22.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:17:41 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/5] seccomp: Add wait_killable semantic to seccomp user notifier
Date:   Wed, 17 Mar 2021 22:17:30 -0700
Message-Id: <20210318051733.2544-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318051733.2544-1-sargun@sargun.me>
References: <20210318051733.2544-1-sargun@sargun.me>
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
index b48fb0a29455..1a38fb1de053 100644
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
@@ -1420,14 +1448,16 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
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
@@ -1455,6 +1485,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
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
@@ -1475,6 +1511,10 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
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

