Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE46C36B8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhDZSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhDZSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:07:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h11so8495546pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXQkmwVqiUnp8MC4j5tfz7p3R+FU1tfYlagzLohTjuY=;
        b=Ue62utb9hb9BnTvytxWMX8lje0lKk7p1TTytW0T12TqBqrwFG8zocex6avaTqULQhN
         dRBE+bIq2oiR7daEFN0peQZHkqRRcF4ea73LBgG97h7QERiAsenBdfzdd67KpOppAikV
         E3d8kOO6OCrLi/T+S4iSFntZ8c2sP5lLbT4J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXQkmwVqiUnp8MC4j5tfz7p3R+FU1tfYlagzLohTjuY=;
        b=MW/2MpzZCLR7vXPGCCbmnbq87gSYwcdK01SEUnEClcCwdroIhCRxtDQJlHTOcp4/NZ
         5kUary79kIyI06ZX383IznlRRk/HuZfseJwjHJWKBbi+C3PqU0V6EM/OpXUoykyU3j64
         SHMMWSBl2sfkldYuGFbP7JNNchwjYjfh3G4ltgTgZXgNE8Y7Rn37KBJFWxONgKIhDG2s
         eoPN5eOXNyyPzQz4wvKsyR1JMVRSfbaH+nVF3kh8OZiwA/2XBBuR1E0E3rngY4WUAxyM
         LenY2ADoBu4SVmQLlMW4dm3K/xKTonPljDNwZ5xsRCxnGRrnkFXYnJdPrepVgD0ORoYh
         7hkQ==
X-Gm-Message-State: AOAM5312T3SD03bFx4JXzpP62Ru+PYHNCkDOHk75bD7LvEffLr1wAC/I
        Wth3yD6rDyiqs7CnSLI6lsJZBg==
X-Google-Smtp-Source: ABdhPJymD5a11tGNjf4vsTjPAKG0wTfnUekHyqOYyWxnLoBkDMvLCx+BiIbY062vK7qTHrFTBtGSJQ==
X-Received: by 2002:a63:4c63:: with SMTP id m35mr17616844pgl.105.1619460385529;
        Mon, 26 Apr 2021 11:06:25 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j7sm326835pfd.129.2021.04.26.11.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:06:24 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Alban Crequy <alban@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH RESEND 5/5] selftests/seccomp: Add test for atomic addfd+send
Date:   Mon, 26 Apr 2021 11:06:10 -0700
Message-Id: <20210426180610.2363-6-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426180610.2363-1-sargun@sargun.me>
References: <20210426180610.2363-1-sargun@sargun.me>
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
index 34140ce2ab21..b3bfe76c6e90 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -239,6 +239,10 @@ struct seccomp_notif_addfd {
 #define SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE	(1UL << 0) /* Prevent task from being interrupted */
 #endif
 
+#ifndef SECCOMP_ADDFD_FLAG_SEND
+#define SECCOMP_ADDFD_FLAG_SEND	(1UL << 1) /* Addfd and return it, atomically */
+#endif
+
 struct seccomp_notif_addfd_small {
 	__u64 id;
 	char weird[4];
@@ -3980,8 +3984,14 @@ TEST(user_notification_addfd)
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
 
@@ -4060,6 +4070,30 @@ TEST(user_notification_addfd)
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
@@ -4120,6 +4154,10 @@ TEST(user_notification_addfd_rlimit)
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

