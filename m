Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE78637026B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhD3Uu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbhD3Uum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:50:42 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k127so16535432qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVd2WMDZlRcVHbWT2xgesmGD/N8sDYwKT+s1aPdX054=;
        b=ttm6ofaY0pxaGM3kpeUodAQJyrehN+55UB9ega22plk3/VUxcl1IDMhqdYnML2Rrk7
         5TBcy0RzwB9UfGXP8jzfdt17zH5YxEDmKaFcWDlBsuFVSAhEALdemlEjoRlEhKzXUUqK
         JAopPYaoqW8yg8vT59s19lnnTAufHseAvGpec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVd2WMDZlRcVHbWT2xgesmGD/N8sDYwKT+s1aPdX054=;
        b=mDx9h+I8BSSo65yEnoGgSbhhSlmI+bidNnORhx9qlQvP297J3NykHQ+lsxvYzRTAZC
         t7l45EqnIMFOaAABxEKekvhDJLigUrxETUOwarVJRmTXEKkY3h39nkRjCUePEG/XSwib
         3FL1se0CKtJI6OkRXA3kK0sB8b6c1/S33393rpD9l6dEiREv/aYDubHMmFI0d878XlOQ
         gcmQ/cb5Hc7SILw68En8XVM9t3nGujqfPuFIQ058735IUzS8rXilO7kTZyWSaCCBiYWQ
         DXr2OdCDts/0joOkhVCh/SswQ0549xWFLhZaF56R3Fqa4585+VJncHKU7LeMkr/osORb
         MJwg==
X-Gm-Message-State: AOAM532UL0Jlpp72XytWXMgcbVHxXvk87OBfThwRUGN02PI0TiHXKiax
        DSgdy1TyqgG6Q2p4y3VdWNYvXw==
X-Google-Smtp-Source: ABdhPJwuHHpvNmBnXGdJEx1RSG/4GMDue3kTjBZI0J4nYHYurPYyimJaPf4Z+J6AHpPy5VlBkqvA6A==
X-Received: by 2002:a37:7b41:: with SMTP id w62mr7434442qkc.256.1619815792499;
        Fri, 30 Apr 2021 13:49:52 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id z17sm3161960qtf.10.2021.04.30.13.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:49:51 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH v2 4/5] seccomp: Support atomic "addfd + send reply"
Date:   Fri, 30 Apr 2021 13:49:38 -0700
Message-Id: <20210430204939.5152-5-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430204939.5152-1-sargun@sargun.me>
References: <20210430204939.5152-1-sargun@sargun.me>
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

Other patches in this series add a way to block signals when a syscall
is put to wait by seccomp. However, that might be a big hammer for some
cases, as the golang runtime uses SIGURG to interrupt threads for GC
collection.  Sometimes we just don't want to interfere with the GC, for
example, and just either add the fd and return it or fail the syscall.
With no leaking fds added inadvertly to the target process.

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
work with this flag. The way to go to emulate those in cases where a
signal might interrupt is to use the functionality to block signals.

The struct seccomp_notif_resp, used when doing SECCOMP_IOCTL_NOTIF_SEND
ioctl() to send a response to the target, has three more fields that we
don't allow to set when doing the addfd ioctl() to also return. The
reasons to disallow each field are:
 * val: This will be set to the new allocated fd. No point taking it
   from userspace in this case.
 * error: If this is non-zero, the value is ignored. Therefore,
   it is pointless in this case as we want to return the value.
 * flags: The only flag is to let userspace continue to execute the
   syscall. This seems pointless, as we want the syscall to return the
   allocated fd.

This is why those fields are not possible to set when using this new
flag.

[1]: https://lore.kernel.org/lkml/CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/202012011322.26DCBC64F2@keescook/

Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/uapi/linux/seccomp.h |  1 +
 kernel/seccomp.c             | 49 +++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 71dbc1f7889f..6a14c39a6e05 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -115,6 +115,7 @@ struct seccomp_notif_resp {
 
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
+#define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
 
 /**
  * struct seccomp_notif_addfd
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 7ac1cea6e7f0..eed3294f3df8 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -109,6 +109,7 @@ struct seccomp_knotif {
  *      installing process should allocate the fd as normal.
  * @flags: The flags for the new file descriptor. At the moment, only O_CLOEXEC
  *         is allowed.
+ * @ioctl_flags: The flags used for the seccomp_addfd ioctl.
  * @ret: The return value of the installing process. It is set to the fd num
  *       upon success (>= 0).
  * @completion: Indicates that the installing process has completed fd
@@ -120,6 +121,7 @@ struct seccomp_kaddfd {
 	struct file *file;
 	int fd;
 	unsigned int flags;
+	__u32 ioctl_flags;
 
 	/* To only be set on reply */
 	int ret;
@@ -1064,14 +1066,35 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
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
 
@@ -1143,7 +1166,7 @@ static int seccomp_do_user_notification(int this_syscall,
 						 struct seccomp_kaddfd, list);
 		/* Check if we were woken up by a addfd message */
 		if (addfd)
-			seccomp_handle_addfd(addfd);
+			seccomp_handle_addfd(addfd, &n);
 
 	}  while (n.state != SECCOMP_NOTIFY_REPLIED);
 
@@ -1610,7 +1633,7 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	if (addfd.newfd_flags & ~O_CLOEXEC)
 		return -EINVAL;
 
-	if (addfd.flags & ~SECCOMP_ADDFD_FLAG_SETFD)
+	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND))
 		return -EINVAL;
 
 	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
@@ -1620,6 +1643,7 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	if (!kaddfd.file)
 		return -EBADF;
 
+	kaddfd.ioctl_flags = addfd.flags;
 	kaddfd.flags = addfd.newfd_flags;
 	kaddfd.fd = (addfd.flags & SECCOMP_ADDFD_FLAG_SETFD) ?
 		    addfd.newfd : -1;
@@ -1645,6 +1669,23 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
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

