Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3A383D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhEQTkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhEQTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:40:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B629C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso189708pjp.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZhBrgiD77I2gySMECgw5WjYrS6GZ+VglntF4MRTPMs=;
        b=0lX7xhipManMVKa737KyIKYZlD/a4lJIY8E31giaC0YtebGd64jXd1ZQmE9Hm7fSHL
         rOgMd5UAQclfoaPy7Sb3MQkGegV/07GBS/6noM+lUbPkOEf79M9a+RxKSZklrS+RG+gL
         KCqxb2y8IkTUf8XTS7W9nk3lajwbWXVvcF/Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZhBrgiD77I2gySMECgw5WjYrS6GZ+VglntF4MRTPMs=;
        b=CQKQwdZ2xcHNOxAXbL6bI6kgg2A0TC26I/BGAbrYr0f/FEtbaIWKXDjVRTCfia1xxg
         5N1h+3TFUrF+ZNB4EwWY2cH4K+zgkZQgndScVvkYpaMGAzfA2Uhyxk7z4fq6JvIt8VP+
         KcYndD33rHniGdjm+XYIcUkRdU2xtH8LZBslzmvDKhzCeWlALMb/Cbd7FNJlOVL4I/zp
         mddTuXEHgOilZ0cWbq2n+kbh481iq18QvA1v/aCbZozrRG0oDHcHfAVqnEX2vqqbp1z1
         1JusDA61Jonf4VNPyPqlx1yGs79lPQXrw0ZOaQNb7EJZ87gOJqWkRktl4Iqgv0H3VteJ
         a6Ew==
X-Gm-Message-State: AOAM533pjaEswAgcOU82uZxIj8wO73ZaTEZsnzZpsNq1oUFrbKmXx/HG
        Z88SPMmiLWJm3oaBrymngBjI4Q==
X-Google-Smtp-Source: ABdhPJzqn6zr3zfTZ51H4fkSfbxcHm6Ply/3qEKMQ0dXHQdRF562wuSto9Nv1/Ky/JmfvGMmAK54Lg==
X-Received: by 2002:a17:902:8d83:b029:ef:9dd8:4d9 with SMTP id v3-20020a1709028d83b02900ef9dd804d9mr107926plo.40.1621280366819;
        Mon, 17 May 2021 12:39:26 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id r11sm11132110pgl.34.2021.05.17.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:39:25 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH v2 3/4] seccomp: Support atomic "addfd + send reply"
Date:   Mon, 17 May 2021 12:39:07 -0700
Message-Id: <20210517193908.3113-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517193908.3113-1-sargun@sargun.me>
References: <20210517193908.3113-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodrigo Campos <rodrigo@kinvolk.io>

Alban Crequy reported a race condition userspace faces when we want to
add some fds and make the syscall return them[1] using seccomp notify.

The problem is that currently two different ioctl() calls are needed by
the process handling the syscalls (agent) for another userspace process
(target): SECCOMP_IOCTL_NOTIF_ADDFD to allocate the fd and
SECCOMP_IOCTL_NOTIF_SEND to return that value. Therefore, it is possible
for the agent to do the first ioctl to add a file descriptor but the
target is interrupted (EINTR) before the agent does the second ioctl()
call.

This patch adds a flag to the ADDFD ioctl() so it adds the fd and
returns that value atomically to the target program, as suggested by
Kees Cook[2]. This is done by simply allowing
seccomp_do_user_notification() to add the fd and return it in this case.
Therefore, in this case the target wakes up from the wait in
seccomp_do_user_notification() either to interrupt the syscall or to add
the fd and return it.

This "allocate an fd and return" functionality is useful for syscalls
that return a file descriptor only, like connect(2). Other syscalls that
return a file descriptor but not as return value (or return more than
one fd), like socketpair(), pipe(), recvmsg with SCM_RIGHTs, will not
work with this flag.

This effectively combines SECCOMP_IOCTL_NOTIF_ADDFD and
SECCOMP_IOCTL_NOTIF_SEND into an atomic opteration. The notification's
return value, nor error can be set by the user. Upon successful invocation
of the SECCOMP_IOCTL_NOTIF_ADDFD ioctl with the SECCOMP_ADDFD_FLAG_SEND
flag, the notifying process's errno will be 0, and the return value will
be the file descriptor number that was installed.

[1]: https://lore.kernel.org/lkml/CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/202012011322.26DCBC64F2@keescook/

Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Acked-by: Tycho Andersen <tycho@tycho.pizza>
---
 .../userspace-api/seccomp_filter.rst          | 12 +++++
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 49 +++++++++++++++++--
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index 6efb41cc8072..d61219889e49 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -259,6 +259,18 @@ and ``ioctl(SECCOMP_IOCTL_NOTIF_SEND)`` a response, indicating what should be
 returned to userspace. The ``id`` member of ``struct seccomp_notif_resp`` should
 be the same ``id`` as in ``struct seccomp_notif``.
 
+Userspace can also add file descriptors to the notifying process via
+``ioctl(SECCOMP_IOCTL_NOTIF_ADDFD)``. The ``id`` member of
+``struct seccomp_notif_addfd`` should be the same ``id`` as in
+``struct seccomp_notif``. The ``newfd_flags`` flag may be used to set flags
+like O_EXEC on the file descriptor in the notifying process. If the supervisor
+wants to inject the file descriptor with a specific number, the
+``SECCOMP_ADDFD_FLAG_SETFD`` flag can be used, and set the ``newfd`` member to
+the specific number to use. If that file descriptor is already open in the
+notifying process it will be replaced. The supervisor can also add an FD, and
+respond atomically by using the ``SECCOMP_ADDFD_FLAG_SEND`` flag and the return
+value will be the injected file descriptor number.
+
 It is worth noting that ``struct seccomp_data`` contains the values of register
 arguments to the syscall, but does not contain pointers to memory. The task's
 memory is accessible to suitably privileged traces via ``ptrace()`` or
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 6ba18b82a02e..78074254ab98 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -115,6 +115,7 @@ struct seccomp_notif_resp {
 
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
+#define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
 
 /**
  * struct seccomp_notif_addfd
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 93684cc63285..3636f9584991 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -107,6 +107,7 @@ struct seccomp_knotif {
  *      installing process should allocate the fd as normal.
  * @flags: The flags for the new file descriptor. At the moment, only O_CLOEXEC
  *         is allowed.
+ * @ioctl_flags: The flags used for the seccomp_addfd ioctl.
  * @ret: The return value of the installing process. It is set to the fd num
  *       upon success (>= 0).
  * @completion: Indicates that the installing process has completed fd
@@ -118,6 +119,7 @@ struct seccomp_kaddfd {
 	struct file *file;
 	int fd;
 	unsigned int flags;
+	__u32 ioctl_flags;
 
 	/* To only be set on reply */
 	int ret;
@@ -1062,14 +1064,35 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
 	return filter->notif->next_id++;
 }
 
-static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
+static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_knotif *n)
 {
+	int fd;
+
 	/*
 	 * Remove the notification, and reset the list pointers, indicating
 	 * that it has been handled.
 	 */
 	list_del_init(&addfd->list);
-	addfd->ret = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
+	fd = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
+
+	addfd->ret = fd;
+
+	if (addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_SEND) {
+		/* If we fail reset and return an error to the notifier */
+		if (fd < 0) {
+			n->state = SECCOMP_NOTIFY_SENT;
+		} else {
+			/* Return the FD we just added */
+			n->flags = 0;
+			n->error = 0;
+			n->val = fd;
+		}
+	}
+
+	/*
+	 * Mark the notification as completed. From this point, addfd mem
+	 * might be invalidated and we can't safely read it anymore.
+	 */
 	complete(&addfd->completion);
 }
 
@@ -1113,7 +1136,7 @@ static int seccomp_do_user_notification(int this_syscall,
 						 struct seccomp_kaddfd, list);
 		/* Check if we were woken up by a addfd message */
 		if (addfd)
-			seccomp_handle_addfd(addfd);
+			seccomp_handle_addfd(addfd, &n);
 
 	}  while (n.state != SECCOMP_NOTIFY_REPLIED);
 
@@ -1574,7 +1597,7 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	if (addfd.newfd_flags & ~O_CLOEXEC)
 		return -EINVAL;
 
-	if (addfd.flags & ~SECCOMP_ADDFD_FLAG_SETFD)
+	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND))
 		return -EINVAL;
 
 	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
@@ -1584,6 +1607,7 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	if (!kaddfd.file)
 		return -EBADF;
 
+	kaddfd.ioctl_flags = addfd.flags;
 	kaddfd.flags = addfd.newfd_flags;
 	kaddfd.fd = (addfd.flags & SECCOMP_ADDFD_FLAG_SETFD) ?
 		    addfd.newfd : -1;
@@ -1609,6 +1633,23 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 		goto out_unlock;
 	}
 
+	if (addfd.flags & SECCOMP_ADDFD_FLAG_SEND) {
+		/*
+		 * Disallow queuing an atomic addfd + send reply while there are
+		 * some addfd requests still to process.
+		 *
+		 * There is no clear reason to support it and allows us to keep
+		 * the loop on the other side straight-forward.
+		 */
+		if (!list_empty(&knotif->addfd)) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+
+		/* Allow exactly only one reply */
+		knotif->state = SECCOMP_NOTIFY_REPLIED;
+	}
+
 	list_add(&kaddfd.list, &knotif->addfd);
 	complete(&knotif->ready);
 	mutex_unlock(&filter->notify_lock);
-- 
2.25.1

