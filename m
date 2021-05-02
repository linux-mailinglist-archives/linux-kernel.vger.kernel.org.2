Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCEC370964
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 02:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhEBAUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 20:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhEBAUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 20:20:04 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECAFC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 17:19:12 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o5so1931238qkb.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RenBvbpfFr/kRPp45Jw3e1BFxN3W9C6W8BvA+1szCJ4=;
        b=k0JngHraxHhpy9SHVmY5NgjGWMTt6GpcaYj8LhoXOJGOvx0vkvgaaK5/rBxYEQHRv9
         iWtmpQW5AXXzqZmPsMQdHGK2ZWHJsY7xVwNLUjDiqBGiMrgVfhehNbbglMGIuUpOcecO
         XjFhn+pl4E46hXlryTFwSuU3Zqi3/pXf9f4ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RenBvbpfFr/kRPp45Jw3e1BFxN3W9C6W8BvA+1szCJ4=;
        b=Ok7jUJwtW+J2PwFGInCrfAsTWMgkgbNLRkorI7FQIP+K8AEonhneb10RBp37i5h5oX
         qkOfDQQRAMzecz27LuMoJ7sZwB9D16wq1hwL9R/VRizTbABiKTjp/ZPbOYPTaJpmV5Rk
         99Zdtsc+mp1/3OqKh3WxcFsyu8HFLgFhpBYkNVhzCall+XZvRB+xYzc6sBCc690n8HsW
         3qHMasb0g/cSS9x/d6amd0yhbEfajWTCXzoZEmPId5Ohv6WP4AGLG+vG3sey1NJVy6EG
         xnEcy/SF0f6Ghiy7K2VX4coFb9iVwDU2qaaiCYkNMofAbtYUBjJt7hDTd5gHExuwwjqJ
         PaWA==
X-Gm-Message-State: AOAM531B58/E6C6COiOU8Tc+WQhWDmBAltPNXt2K7GLyyKnBwiXBdP/P
        qXJME8tO1hUxFU7W6/IJgKPYvQ==
X-Google-Smtp-Source: ABdhPJwQ0+S8q+qdRC3etHaemPYe4pog1qTFjsPkf2vMtfU20qOnSfC1JkFksanuj8fmcrJxaZeYWA==
X-Received: by 2002:a37:de16:: with SMTP id h22mr12497135qkj.351.1619914751704;
        Sat, 01 May 2021 17:19:11 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id p5sm5146067qkh.135.2021.05.01.17.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 17:19:10 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH 4/4] selftests/seccomp: Add test for atomic addfd+send
Date:   Sat,  1 May 2021 17:18:51 -0700
Message-Id: <20210502001851.3346-5-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502001851.3346-1-sargun@sargun.me>
References: <20210502001851.3346-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodrigo Campos <rodrigo@kinvolk.io>

This just adds a test to verify that when using the new introduced flag
to ADDFD, a valid fd is added and returned as the syscall result.

Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 98c3b647f54d..e2ba7adc2694 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -235,6 +235,10 @@ struct seccomp_notif_addfd {
 };
 #endif
 
+#ifndef SECCOMP_ADDFD_FLAG_SEND
+#define SECCOMP_ADDFD_FLAG_SEND	(1UL << 1) /* Addfd and return it, atomically */
+#endif
+
 struct seccomp_notif_addfd_small {
 	__u64 id;
 	char weird[4];
@@ -3976,8 +3980,14 @@ TEST(user_notification_addfd)
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
+		/* fds will be added and this value is expected */
 		if (syscall(__NR_getppid) != USER_NOTIF_MAGIC)
 			exit(1);
+
+		/* Atomic addfd+send is received here. Check it is a valid fd */
+		if (fcntl(syscall(__NR_getppid), F_GETFD) == -1)
+			exit(1);
+
 		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 	}
 
@@ -4056,6 +4066,30 @@ TEST(user_notification_addfd)
 	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	ASSERT_EQ(addfd.id, req.id);
 
+	/* Verify we can do an atomic addfd and send */
+	addfd.newfd = 0;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
+	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+
+	/* Child has fds 0-6 and 42 used, we expect the lower fd available: 7 */
+	EXPECT_EQ(fd, 7);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
+
+	/*
+	 * This sets the ID of the ADD FD to the last request plus 1. The
+	 * notification ID increments 1 per notification.
+	 */
+	addfd.id = req.id + 1;
+
+	/* This spins until the underlying notification is generated */
+	while (ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd) != -1 &&
+	       errno != -EINPROGRESS)
+		nanosleep(&delay, NULL);
+
+	memset(&req, 0, sizeof(req));
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	ASSERT_EQ(addfd.id, req.id);
+
 	resp.id = req.id;
 	resp.error = 0;
 	resp.val = USER_NOTIF_MAGIC;
@@ -4116,6 +4150,10 @@ TEST(user_notification_addfd_rlimit)
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
 	EXPECT_EQ(errno, EMFILE);
 
+	addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EMFILE);
+
 	addfd.newfd = 100;
 	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
-- 
2.25.1

