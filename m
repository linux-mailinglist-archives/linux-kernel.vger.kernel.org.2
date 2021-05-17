Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C89383D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhEQTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbhEQTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:40:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EF2C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n3so3755660plf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iU7bYSoJHKb73gorZxEZEgv0GcS4wxZ3B8NrxMg/0i8=;
        b=nFEpsWlL6Hf+Tf2nZcDGFmfWZDgWVkYhEziwk5zASJwoXlAXWO7T652X8607ntcVZt
         0L6bmfwuAh0DJcYiHboGk8DvaWodFsbq25RVa2Sm7H3nXqlfiuLRQHTaLXMMgjiDTfJE
         o0TY60LQFITU+8Q6iP/GdFfDRW2bAGmNA0p4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iU7bYSoJHKb73gorZxEZEgv0GcS4wxZ3B8NrxMg/0i8=;
        b=DP7MEV1bKAmWc66+YpRvBJrBjCsf2typ292DkL605e5lTagszgYvw4oEXnY/9nBi4e
         Rx9f3uj/fVHEXEFuULyLOsJoOkYQr1HLeYvCbKWJ6ooHcZ9LSZ/JiHbxYX0F4J/oolkl
         ylfBUjfo/39wrZQPB8Cx25Ib62k6Dbc+ad1N1f+v6B/Vyx7hEvK8bjnA5Q8f3nJ12W8U
         dl01FXzKxOZaJaQaZSxnNLHVt8SLuGC2vtZplra1Y7vlUu42RzfzWZHw/Iz1NX+oZnCT
         HCnOQbWGxDt8cgkGTFJbGF8xlQYidH66R1lOoWdKfFW4TTbYEazUOlYMKtEDfefsVucT
         2xrg==
X-Gm-Message-State: AOAM530JJm8jJCNUQYu59CipNXkGRANoENnnNQwaw3612DoMW426cWjC
        7rXFGTuHpusbAYYWeKbnShC5QA==
X-Google-Smtp-Source: ABdhPJxHmwwHsxW9q2h7tWAckMcmRBRdL5UHD/Y6VbqGo5im1AbWpTzUpT2dnhe8AR9cGj5VVxd2bw==
X-Received: by 2002:a17:90a:6402:: with SMTP id g2mr1106623pjj.82.1621280368575;
        Mon, 17 May 2021 12:39:28 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id r11sm11132110pgl.34.2021.05.17.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:39:27 -0700 (PDT)
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
Subject: [PATCH v2 4/4] selftests/seccomp: Add test for atomic addfd+send
Date:   Mon, 17 May 2021 12:39:08 -0700
Message-Id: <20210517193908.3113-5-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517193908.3113-1-sargun@sargun.me>
References: <20210517193908.3113-1-sargun@sargun.me>
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
Acked-by: Tycho Andersen <tycho@tycho.pizza>
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

